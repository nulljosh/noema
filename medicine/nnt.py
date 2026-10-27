"""Check numbers needed to treat and relative risk reductions against the numbers printed beside them.

    python3 nnt.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

Two identities need no data:
  nnt   NNT = 1 / absolute risk difference. "ARR 5% ... NNT 50" is a slip: 1 / 0.05 is 20. The difference comes from
        an absolute risk reduction or difference, or from the last "A% vs B%" pair before the NNT in the sentence.
        A printed NNT may be rounded up, down or to the nearest, so only one outside every rounding is flagged.
  rrr   relative risk reduction = 1 - RR (or 1 - HR). "RRR 40% (RR 0.80)" is a slip: 1 - 0.80 is 20%.
Odds ratios are skipped for rrr: 1 - OR is not a risk reduction.
"""
import glob
import json
import math
import re
import sys

import pvalues
import ratios

NUM = r'(?<![\w.·])(\d*[.·]?\d+)'
NNT = re.compile(r'(?<![\w-])(?:NNTB?|NNH|number needed to (?:treat|harm))(?![\w-])\s*(?:\[NNTB?\]|\(NNTB?\))?[\s,:=]*(?:(?:of|was|is|were)\s+)?' + NUM + r'(?!\d|[.·]\d|\s*%)')
ARR = re.compile(r'(?<![\w-])(?:ARR|ARD|ARI|absolute (?:risk )?(?:reduction|difference|increase|benefit)|risk difference)'
                 r'(?![\w-])[^\d;]{0,25}?' + NUM + r'\s*(%|percentage points?)?')
ARMS = re.compile(NUM + r'\s*%[^\d;%]{0,40}?\b(?:vs\.?|versus|compared (?:with|to)|and|or)\s+' + NUM + r'\s*%')
RRR = re.compile(r'(?<![\w-])(?:RRR|relative risk reduction)(?![\w-])[^\d;]{0,20}?' + NUM + r'\s*%')
RATIO = re.compile(r'(?<![\w-])(a?RR|a?HR|IRR|risk ratio|hazard ratio|relative risk|rate ratio)(?![\w-])[^\d;]{0,20}?' + NUM)
SKIP = re.compile(r'per (?:1,?000|100|10,?000)|person-years|patient-years|per year|over \d+ years|\bnumber needed to (?:screen|vaccinate)\b'
                  r'|inferior|\bNI\b|per protocol', re.I)


def _nnt_fits(nnt, tn, diff, td):
    """True when some rounding of the printed NNT matches 1 / d for some d the printed difference rounds from."""
    if diff - td <= 0:
        return True
    lo, hi = 1 / (diff + td), 1 / (diff - td)
    return math.floor(lo) - tn <= nnt <= math.ceil(hi) + tn


def flags(text):
    """(kind, printed numbers, implied value, sentence) for each sharp mismatch."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        for m in NNT.finditer(sentence):
            nnt, tn = ratios._num(m.group(1))
            if nnt < 1:
                continue
            head = sentence[max(0, m.start() - 160):m.start()]
            a = list(ARR.finditer(head))
            if a:
                a = a[-1]
                value, tol = ratios._num(a.group(1))
                if a.group(2):
                    diff, td = value / 100, tol / 100
                elif value < 1:
                    diff, td = value, tol
                else:
                    continue  # "ARR 5" with no unit: a percent or a count per 100, so say nothing
                printed = a.group(0)
            else:
                pairs = list(ARMS.finditer(head))
                if not pairs:
                    continue
                (x, tx), (y, ty) = ratios._num(pairs[-1].group(1)), ratios._num(pairs[-1].group(2))
                diff, td = abs(x - y) / 100, (tx + ty) / 100
                printed = pairs[-1].group(0)
            if not _nnt_fits(nnt, tn, diff, td):
                yield 'nnt', printed + ' ... ' + m.group(0), round(1 / diff, 1) if diff else None, sentence
        for m in RRR.finditer(sentence):
            rrr, tr = ratios._num(m.group(1))
            window = sentence[m.end():m.end() + 80]
            r = RATIO.search(window) or RATIO.search(sentence[max(0, m.start() - 80):m.start()])
            if r is None:
                continue
            est, te = ratios._num(r.group(2))
            if not 0 < est < 1.5:
                continue
            implied = (1 - est) * 100
            if abs(rrr - implied) > 100 * te + tr + 0.5 and abs(rrr - (1 - 1 / est) * 100) > 100 * te + tr + 0.5:
                yield 'rrr', m.group(0) + ' | ' + r.group(0), round(implied, 1), sentence


def scan(abstracts):
    rows, counts = [], {'nnt': 0, 'rrr': 0}
    for pmid, text in abstracts.items():
        t = ' '.join(text.split())
        counts['nnt'] += len(NNT.findall(t))
        counts['rrr'] += len(RRR.findall(t))
        for kind, printed, implied, sentence in flags(text):
            rows.append({'pmid': pmid, 'kind': kind, 'printed': printed, 'implied': implied, 'sentence': sentence[:400]})
    return rows, counts


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, counts = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'mentions': counts, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
