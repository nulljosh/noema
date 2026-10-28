"""Check ClinicalTrials.gov adverse-event tables against themselves.

    python3 ae.py fetch OUT_JSON    # every study with results, flags kept, raw tables not (~30 min)

Each event group posts how many participants had any serious (or other) adverse event and how many were at risk;
each event term posts, per group, the participants affected, the events and the participants at risk. Counting
forces some orderings that hold for any data: a term's affected participants are among the group's affected ones,
the affected are among those at risk, and each affected participant had at least one event. A group's total of
participants with any serious event cannot exceed the sum over its serious terms, since each of them has a term.
"""
import json
import sys
import time
import urllib.parse
import urllib.request

API = 'https://clinicaltrials.gov/api/v2/studies?'


def flags(ae):
    """The impossible orderings in one adverse-events module, as (kind, detail) pairs."""
    out, groups = [], {g['id']: g for g in ae.get('eventGroups', [])}
    for g in groups.values():
        for k in ('serious', 'other', 'deaths'):
            a, r = g.get(k + 'NumAffected'), g.get(k + 'NumAtRisk')
            if a is not None and r is not None and a > r:
                out.append(('group affected > at risk', [g['id'], k, a, r]))
    for k in ('serious', 'other'):
        sums = {}
        for e in ae.get(k + 'Events', []):
            for s in e.get('stats', []):
                a, r, n = s.get('numAffected'), s.get('numAtRisk'), s.get('numEvents')
                if a is None:
                    continue
                sums[s['groupId']] = sums.get(s['groupId'], 0) + a
                if r is not None and a > r:
                    out.append(('term affected > at risk', [k, e.get('term'), s['groupId'], a, r]))
                if n is not None and a > n:
                    out.append(('term affected > events', [k, e.get('term'), s['groupId'], a, n]))
                total = groups.get(s['groupId'], {}).get(k + 'NumAffected')
                if total is not None and a > total:
                    out.append(('term affected > group affected', [k, e.get('term'), s['groupId'], a, total]))
        if k == 'serious':
            for gid, g in groups.items():
                total = g.get('seriousNumAffected')
                if total and gid in sums and total > sums[gid]:
                    out.append(('group serious > sum of terms', [gid, total, sums[gid]]))
    return out


def fetch(path):
    """Page through every study with results, a second apart, keeping only the flags."""
    query = {'aggFilters': 'results:with', 'pageSize': '100', 'fields': 'NCTId,AdverseEventsModule'}
    tally, rows, studies = {}, [], 0
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=300) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            ae = s.get('resultsSection', {}).get('adverseEventsModule')
            if not ae:
                continue
            studies += 1
            for kind, detail in flags(ae):
                tally[kind] = tally.get(kind, 0) + 1
                rows.append([s['protocolSection']['identificationModule']['nctId'], kind, detail])
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump({'studies': studies, 'tally': tally, 'trials': {k: len({r[0] for r in rows if r[1] == k}) for k in tally},
               'rows': rows}, open(path, 'w'))


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
