"""Participant flow on ClinicalTrials.gov against itself.

    python3 flow.py fetch OUT_JSON    # every study with results, flags kept (~25 min)

Each period of a trial's flow says, per group, how many started, how many completed and how many did not, and lists
the reasons people left. People are conserved: completed plus not completed is the number that started, nobody
completes who did not start, and the reasons for leaving add up to the number who did not complete.
"""
import json
import sys
import time
import urllib.parse
import urllib.request

API = 'https://clinicaltrials.gov/api/v2/studies?'


def _n(text):
    try:
        return int(text)
    except (TypeError, ValueError):
        return None


def flags(flow):
    out = []
    for p in flow.get('periods', []):
        got = {}
        for m in p.get('milestones', []):
            for a in m.get('achievements', []):
                got.setdefault(a['groupId'], {})[m.get('type')] = _n(a.get('numSubjects'))
        left = {}
        for d in p.get('dropWithdraws', []):
            for r in d.get('reasons', []):
                v = _n(r.get('numSubjects'))
                if v is not None:
                    left[r['groupId']] = left.get(r['groupId'], 0) + v
        for g, m in got.items():
            s, c, nc = m.get('STARTED'), m.get('COMPLETED'), m.get('NOT COMPLETED')
            if s is not None and c is not None and c > s:
                out.append(('completed > started', p.get('title'), g, c, s))
            if None not in (s, c, nc) and c + nc != s:
                out.append(('completed + not completed != started', p.get('title'), g, c + nc, s))
            if nc is not None and g in left and left[g] != nc:
                out.append(('reasons != not completed', p.get('title'), g, left[g], nc))
    return out


def fetch(path):
    query = {'aggFilters': 'results:with', 'pageSize': '200', 'fields': 'NCTId,ParticipantFlowModule'}
    tally, rows, studies = {}, [], 0
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=300) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            flow = s.get('resultsSection', {}).get('participantFlowModule')
            if not flow:
                continue
            studies += 1
            for f in flags(flow):
                tally[f[0]] = tally.get(f[0], 0) + 1
                rows.append([s['protocolSection']['identificationModule']['nctId'], *f])
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump({'studies': studies, 'tally': tally, 'trials': {k: len({r[0] for r in rows if r[1] == k}) for k in tally},
               'rows': rows}, open(path, 'w'))


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
