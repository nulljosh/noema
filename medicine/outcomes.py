"""Outcome cells on ClinicalTrials.gov that count more participants than the outcome analysed.

    python3 outcomes.py fetch OUT_JSON    # every study with results, flags kept (~35 min)

An outcome posted as a count of participants, or as a percentage of them, is bounded by its own denominator: no
cell can count more people than the group the outcome analysed, and no percentage of participants can pass 100.
"""
import json
import sys
import time
import urllib.parse
import urllib.request

API = 'https://clinicaltrials.gov/api/v2/studies?'


def _num(text):
    try:
        return float(text)
    except (TypeError, ValueError):
        return None


def flags(m):
    """Cells of one outcome measure that exceed their bound, as (kind, group, value, bound)."""
    unit = (m.get('unitOfMeasure') or '').lower()
    param = m.get('paramType')
    counting = param == 'COUNT_OF_PARTICIPANTS' or (param == 'NUMBER' and unit in ('participants', 'participant'))
    percent = param in ('COUNT_OF_PARTICIPANTS', 'NUMBER') and unit.startswith('percentage of participants')
    if not (counting or percent):
        return []
    out = []
    n = {c['groupId']: _num(c.get('value')) for d in m.get('denoms', [])[:1] for c in d.get('counts', [])}
    for cl in m.get('classes', []):
        cn = {c['groupId']: _num(c.get('value')) for d in cl.get('denoms', [])[:1] for c in d.get('counts', [])}
        for cat in cl.get('categories', []):
            for x in cat.get('measurements', []):
                v, g = _num(x.get('value')), x['groupId']
                bound = cn.get(g, n.get(g))
                if v is None:
                    continue
                if counting and bound is not None and v > bound:
                    out.append(('count > analysed', g, v, bound))
                if percent and v > 100:
                    out.append(('percent > 100', g, v, 100))
    return out


def fetch(path):
    query = {'aggFilters': 'results:with', 'pageSize': '100', 'fields': 'NCTId,OutcomeMeasuresModule'}
    tally, rows, studies = {}, [], 0
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=300) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            nct = s['protocolSection']['identificationModule']['nctId']
            studies += 1
            for i, m in enumerate(s.get('resultsSection', {}).get('outcomeMeasuresModule', {}).get('outcomeMeasures', [])):
                for kind, g, v, bound in flags(m):
                    tally[kind] = tally.get(kind, 0) + 1
                    rows.append([nct, i + 1, (m.get('title') or '')[:80], kind, g, v, bound])
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump({'studies': studies, 'tally': tally, 'trials': {k: len({r[0] for r in rows if r[3] == k}) for k in tally},
               'rows': rows}, open(path, 'w'))


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
