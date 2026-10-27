"""Check the Total column of ClinicalTrials.gov baseline tables against the arms beside it.

    python3 registry.py fetch BASELINE_JSON    # every study with posted results, mean/SD measures only (~1 h)
    python3 registry.py BASELINE_JSON

A posted baseline table gives each arm's count, mean and SD, then a Total. Whatever participants are missing, the
Total mean must lie between the lowest and highest arm mean (`outside`). With the printed counts it should be the
count-weighted mean of the arms; a Total more than ten roundings off is `far`. Missing values can explain a far
Total, but not one that lands, to the last digit, on the plain average of the arm means when the arms differ in
size: that is a Total typed as AVERAGE(arms) (`unweighted`). `chance` is how many far Totals would land on the
plain average by luck if they fell anywhere between the arm means. Equal analyzed counts make the plain average
right, so `clear` keeps only arms whose sizes differ at least twofold, with no note about missing participants.
"""
import json
import sys
import time
import urllib.parse
import urllib.request

API = 'https://clinicaltrials.gov/api/v2/studies?'


def fetch(path):
    """Page through the ClinicalTrials.gov API one request at a time, a second apart."""
    query = {'aggFilters': 'results:with', 'pageSize': '1000', 'fields': 'NCTId,BaselineCharacteristicsModule'}
    keep = {}
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=120) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            module = s.get('resultsSection', {}).get('baselineCharacteristicsModule') or {}
            measures = [m for m in module.get('measures', []) if m.get('paramType') == 'MEAN'
                        and m.get('dispersionType') == 'STANDARD_DEVIATION']
            if measures:
                keep[s['protocolSection']['identificationModule']['nctId']] = {**module, 'measures': measures}
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump(keep, open(path, 'w'))


def _num(text):
    """(value, half a unit in the last printed place) or None."""
    try:
        value = float(text)
    except (TypeError, ValueError):
        return None
    places = len(text.split('.')[1]) if '.' in text else 0
    return value, 0.5 * 10 ** -places


def _counts(denoms):
    for d in denoms or []:
        if d.get('units') == 'Participants':
            return {c['groupId']: int(c['value']) for c in d.get('counts', []) if c.get('value', '').isdigit()}
    return {}


def rows(study):
    """One dict per single-row mean measure whose Total counts exactly the listed arms."""
    groups = study.get('groups', [])
    total = [g['id'] for g in groups if g.get('title', '').strip().lower() == 'total']
    if len(total) != 1 or len(groups) < 3:
        return
    total = total[0]
    ids = [g['id'] for g in groups if g['id'] != total]
    base = _counts(study.get('denoms'))
    for measure in study['measures']:
        classes = measure.get('classes', [])
        if len(classes) != 1 or len(classes[0].get('categories', [])) != 1:
            continue
        counts = _counts(measure.get('denoms')) or base
        cells = {x['groupId']: x for x in classes[0]['categories'][0].get('measurements', [])}
        means = {i: _num(cells.get(i, {}).get('value')) for i in ids + [total]}
        if any(means[i] is None or counts.get(i, 0) < 1 for i in ids + [total]):
            continue
        if sum(counts[i] for i in ids) != counts[total]:
            continue  # the Total covers different people
        n = counts[total]
        (tm, tt), arms = means[total], [(counts[i],) + means[i] for i in ids]
        weighted = sum(c * m for c, m, _ in arms) / n
        plain = sum(m for _, m, _ in arms) / len(arms)
        w_tol = sum(c * t for c, _, t in arms) / n + tt
        p_tol = sum(t for _, _, t in arms) / len(arms) + tt
        lo, hi = min(m - t for _, m, t in arms), max(m + t for _, m, t in arms)
        sds = [_num(cells[i].get('spread')) for i in ids + [total]]
        note = bool(measure.get('populationDescription') or study.get('populationDescription'))
        yield {'measure': measure.get('title', ''), 'total': tm, 'note': note,
               'unequal': 2 * min(c for c, _, _ in arms) <= max(c for c, _, _ in arms), 'weighted': round(weighted, 4),
               'plain': round(plain, 4), 'outside': tm + tt < lo or tm - tt > hi,
               'far': abs(tm - weighted) > 10 * w_tol,
               'unweighted': abs(tm - plain) <= p_tol + 1e-9 and abs(weighted - plain) > 2 * p_tol,
               'chance': min(1, 2 * p_tol / (hi - lo)) if hi > lo else 1,
               'sd_plain': None not in sds and abs(sds[-1][0] - sum(s for s, _ in sds[:-1]) / len(arms))
                           <= sum(t for _, t in sds) / len(arms) + 1e-9}


def scan(studies):
    out = {'checked': 0, 'outside': [], 'far': 0, 'chance': 0.0, 'unweighted': []}
    for nct, study in studies.items():
        for row in rows(study):
            out['checked'] += 1
            if row['outside']:
                out['outside'].append({'nct': nct, **row})
            if row['far']:
                out['far'] += 1
                out['chance'] += row['chance']
                if row['unweighted']:
                    out['unweighted'].append({'nct': nct, **row})
    out['chance'] = round(out['chance'], 1)
    return out


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        sys.exit(fetch(sys.argv[2]))
    studies = json.load(open(sys.argv[1]))
    out = scan(studies)
    out['studies'] = len(studies)
    out['trials_unweighted'] = len({r['nct'] for r in out['unweighted']})
    out['sd_plain_too'] = sum(r['sd_plain'] for r in out['unweighted'])
    clear = [r for r in out['unweighted'] if r['unequal'] and not r['note']]  # missing data cannot even the arms out
    out['clear'], out['trials_clear'] = len(clear), len({r['nct'] for r in clear})
    out['clear_rows'] = clear
    print(json.dumps(out, indent=1))
