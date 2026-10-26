"""Check that trial abstracts' printed percentages match their printed fractions.

    python3 percents.py 2023 400      # scan 400 randomized-trial abstracts from PubMed, publication year 2023

An abstract that prints "12/40 (35%)" or "12 of 40 (35%)" states both the fraction and its percentage, so the
two can be checked against each other with no other data. A pair is flagged only when no rounding of the exact
percentage to the printed number of decimals (nearest, up or down) gives the printed value. Abstracts come from
NCBI E-utilities (public, no key, kept under 3 requests a second).
"""
import json
import math
import re
import sys
import time
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET

EUTILS = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
NUM = r'(?<![\w.·/])(\d{1,6})(?![\w.·])'  # a whole number, not part of a name like HPV16 or a decimal
DEN = r'(\d{1,6})(?![\w.·])'
# A percentage followed by "CI" or a range dash is an interval, not the fraction's share.
PCT = r'[(\[]\s*(\d{1,3}(?:\.\d{1,2})?)\s*%(?!\s*(?:CI|[-–]))'
PATTERNS = [
    (re.compile(NUM + r'\s*/\s*' + DEN + r'\s*' + PCT), 1, 2, 3),         # 12/40 (30%)
    (re.compile(NUM + r'\s+of\s+' + NUM + r'\s*' + PCT), 1, 2, 3),         # 12 of 40 (30%)
    (re.compile(NUM + r'\s*' + PCT + r'\s*[)\]]\s+of\s+' + NUM), 1, 3, 2),  # 12 (30%) of 40
]


def consistent(x, n, printed):
    """True when some rounding of 100 x / n to the printed decimals (nearest, up or down) gives the printed text."""
    decimals = len(printed.split('.')[1]) if '.' in printed else 0
    scale = 10 ** decimals
    exact = 100 * x * scale / n
    value = round(float(printed) * scale)
    return value in {math.floor(exact), math.ceil(exact)}


def pairs(text):
    """Every (x, n, printed, snippet) fraction-with-percentage in the text, skipping impossible fractions."""
    for pattern, gx, gn, gp in PATTERNS:
        for m in pattern.finditer(text):
            x, n, printed = int(m.group(gx)), int(m.group(gn)), m.group(gp)
            if 1 < n and x <= n:  # n = 1 is a score band such as sPGA 0/1
                yield x, n, printed, text[max(0, m.start() - 60):m.end() + 10]


def check(text):
    return [p for p in pairs(text) if not consistent(*p[:3])]


def _get(url, body=None):
    time.sleep(0.4)
    with urllib.request.urlopen(url, body, timeout=120) as response:
        return response.read()


def fetch(dates, count):
    """PMIDs and abstract text of randomized controlled trials published in a PubMed date range, like 2023 or
    2023/01:2023/06. One search returns at most 10,000, so larger samples split the range."""
    term = 'randomized controlled trial[pt] AND hasabstract AND %s[dp]' % dates
    query = urllib.parse.urlencode({'db': 'pubmed', 'term': term, 'retmax': count, 'retmode': 'json', 'sort': 'pub_date'})
    ids = json.loads(_get(EUTILS + 'esearch.fcgi?' + query))['esearchresult']['idlist']
    out = {}
    for i in range(0, len(ids), 200):
        body = urllib.parse.urlencode({'db': 'pubmed', 'id': ','.join(ids[i:i + 200]), 'retmode': 'xml'}).encode()
        root = ET.fromstring(_get(EUTILS + 'efetch.fcgi', body))
        for art in root.iter('PubmedArticle'):
            pmid = art.findtext('.//PMID')
            out[pmid] = ' '.join(''.join(a.itertext()) for a in art.iter('AbstractText'))
    return out


def fetch_epmc(year):
    """The same trials from Europe PMC, which mirrors PubMed and pages 1,000 abstracts a request, about 5 times
    faster. Keyed by PMID, so it merges with fetch."""
    base = 'https://www.ebi.ac.uk/europepmc/webservices/rest/search?'
    query = 'PUB_TYPE:"randomized controlled trial" AND PUB_YEAR:%d AND HAS_ABSTRACT:y' % year
    out, cursor = {}, '*'
    while True:
        page = json.loads(_get(base + urllib.parse.urlencode({'query': query, 'resultType': 'core', 'pageSize': 1000,
                                                              'format': 'json', 'cursorMark': cursor})))
        for r in page['resultList']['result']:
            if r.get('pmid') and r.get('abstractText'):
                out[r['pmid']] = re.sub(r'<[^>]+>', ' ', r['abstractText'])
        if not page['resultList']['result'] or page.get('nextCursorMark') in (None, cursor):
            return out
        cursor = page['nextCursorMark']


def scan(year, count):
    abstracts = fetch(year, count)
    checked = flagged = 0
    rows = []
    for pmid, text in abstracts.items():
        found = list(pairs(text))
        checked += len(found)
        for x, n, printed, snippet in found:
            if not consistent(x, n, printed):
                flagged += 1
                rows.append({'pmid': pmid, 'x': x, 'n': n, 'printed': printed,
                             'exact': round(100 * x / n, 3), 'snippet': ' '.join(snippet.split())})
    return {'year': year, 'abstracts': len(abstracts), 'pairs': checked, 'flagged': flagged, 'rows': rows}


if __name__ == '__main__':
    year = int(sys.argv[1]) if sys.argv[1:] else 2023
    count = int(sys.argv[2]) if sys.argv[2:] else 400
    print(json.dumps(scan(year, count), indent=1))
