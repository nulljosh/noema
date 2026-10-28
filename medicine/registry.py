"""Check the Total column of ClinicalTrials.gov baseline tables against the arms beside it.

    python3 registry.py fetch BASELINE_JSON    # every study with posted results, mean/SD and count measures (~1 h)
    python3 registry.py BASELINE_JSON

A posted baseline table gives each arm's count, mean and SD, then a Total. Whatever participants are missing, the
Total mean must lie between the lowest and highest arm mean (`outside`). With the printed counts it should be the
count-weighted mean of the arms; a Total more than ten roundings off is `far`. Missing values can explain a far
Total, but not one that lands, to the last digit, on the plain average of the arm means when the arms differ in
size: that is a Total typed as AVERAGE(arms) (`unweighted`). `chance` is how many far Totals would land on the
plain average by luck if they fell anywhere between the arm means. `decoy` counts far Totals with both the plain
average and its mirror image about the weighted mean inside the arm range, then how many land on each: missing
data would scatter Totals to both sides alike, an AVERAGE only to the plain one. Equal analyzed counts make the plain average
right, so `clear` keeps only arms whose sizes differ at least twofold, with no note about missing participants.
`sd_impossible` needs no counts: it flags Total SDs that no way of pooling the arms could give. `arms_as_sem` finds
the high ones that fit once the arm spreads are read as standard errors, with other factors as decoys.
"""
import json
import re
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
            measures = [m for m in module.get('measures', []) if m.get('paramType') == 'COUNT_OF_PARTICIPANTS'
                        or m.get('dispersionType') == 'STANDARD_DEVIATION']
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


def sd_span(arms):
    """(lo, hi) for the pooled SD over every rounding, allowing a divisor of N or N - 1; arms are (n, m, tm, s, ts)."""
    N = sum(a[0] for a in arms)
    m = sum(n * mv for n, mv, *_ in arms) / N
    t = 2 * max(a[2] for a in arms)
    within_lo = sum((n - 1) * max(0, sv - ts) ** 2 for n, _, _, sv, ts in arms)
    within_hi = sum(max(n - 1, 1) * (sv + ts) ** 2 for n, _, _, sv, ts in arms)
    between_lo = sum(n * max(0, abs(mv - m) - t) ** 2 for n, mv, *_ in arms)
    between_hi = sum(n * (abs(mv - m) + t) ** 2 for n, mv, *_ in arms)
    return (within_lo + between_lo) ** 0.5 / N ** 0.5, ((within_hi + between_hi) / max(N - 1, 1)) ** 0.5


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
        if measure.get('paramType') != 'MEAN' or len(classes) != 1 or len(classes[0].get('categories', [])) != 1:
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
        pooled = None if None in sds else sd_span([a + sd for a, sd in zip(arms, sds)])
        mirror = 2 * weighted - plain  # a decoy: as far from the weighted mean as the plain average, other side
        decoy = abs(weighted - plain) > 2 * p_tol and lo <= plain <= hi and lo <= mirror <= hi
        note = bool(measure.get('populationDescription') or study.get('populationDescription'))
        yield {'measure': measure.get('title', ''), 'total': tm, 'note': note,
               'unequal': 2 * min(c for c, _, _ in arms) <= max(c for c, _, _ in arms), 'weighted': round(weighted, 4),
               'plain': round(plain, 4), 'outside': tm + tt < lo or tm - tt > hi,
               'far': abs(tm - weighted) > 10 * w_tol,
               'unweighted': abs(tm - plain) <= p_tol + 1e-9 and abs(weighted - plain) > 2 * p_tol,
               'decoy': decoy, 'on_plain': decoy and abs(tm - plain) <= p_tol + 1e-9,
               'on_mirror': decoy and abs(tm - mirror) <= p_tol + 1e-9,
               'chance': min(1, 2 * p_tol / (hi - lo)) if hi > lo else 1,
               'sd_plain': None not in sds and abs(sds[-1][0] - sum(s for s, _ in sds[:-1]) / len(arms))
                           <= sum(t for _, t in sds) / len(arms) + 1e-9,
               'sd_outside': pooled is not None and (sds[-1][0] + sds[-1][1] < pooled[0]
                                                     or sds[-1][0] - sds[-1][1] > pooled[1])}


def sd_impossible(study):
    """Single-row mean measures whose Total SD no arm sizes allow, with the Total mean inside the arm means.
    Pooling arms of at least 2 gives a sample variance of at least half the smallest arm variance and at most the
    largest arm variance plus half the squared range of arm means, whatever the counts, so a Total SD under half
    the smallest arm SD, or over twice the root of (largest arm variance + range^2 / 4), cannot be right.
    Yields (measure, total mean, total SD, lowest allowed, highest allowed, kind)."""
    groups = study.get('groups', [])
    total = [g['id'] for g in groups if g.get('title', '').strip().lower() == 'total']
    if len(total) != 1 or len(groups) < 3:
        return
    ids = [g['id'] for g in groups if g['id'] != total[0]]
    n = _counts(study.get('denoms')).get(total[0], 0)
    for measure in study['measures']:
        classes = measure.get('classes', [])
        if measure.get('paramType') != 'MEAN' or len(classes) != 1 or len(classes[0].get('categories', [])) != 1:
            continue
        cells = {x['groupId']: x for x in classes[0]['categories'][0].get('measurements', [])}
        means = [_num(cells.get(i, {}).get('value')) for i in ids + total]
        sds = [_num(cells.get(i, {}).get('spread')) for i in ids + total]
        if None in means or None in sds:
            continue
        (tm, tmt), (ts, tst) = means[-1], sds[-1]
        lo_m, hi_m = min(m - t for m, t in means[:-1]), max(m + t for m, t in means[:-1])
        if tm + tmt < lo_m or tm - tmt > hi_m:
            continue
        lo = min(v - t for v, t in sds[:-1])
        hi = (max(v + t for v, t in sds[:-1]) ** 2 + (hi_m - lo_m) ** 2 / 4) ** 0.5
        if ts + tst < 0.5 * lo:
            kind = 'zero' if ts == 0 else 'se' if n > 1 and abs(ts - lo * n ** -0.5) <= max(tst, 0.15 * lo * n ** -0.5) \
                else 'low'
        elif ts - tst > 2 * hi:
            kind = 'mean' if abs(ts - tm) <= tst + tmt else 'count' if ts == n else 'high'
        else:
            continue
        yield measure.get('title', ''), tm, ts, round(lo, 4), round(hi, 4), kind


def arms_as_sem(study, scale=1.0):
    """Measures flagged 'high' whose Total SD does fit once each arm's spread is read as a standard error,
    SD = SE * sqrt(n). `scale` multiplies sqrt(n), so other factors can serve as decoys."""
    high = {m for m, *_, kind in sd_impossible(study) if kind == 'high'}
    groups = study.get('groups', [])
    total = [g['id'] for g in groups if g.get('title', '').strip().lower() == 'total'][0] if high else None
    ids = [g['id'] for g in groups if g['id'] != total]
    for measure in study['measures'] if high else []:
        if measure.get('title', '') not in high:
            continue
        counts = _counts(measure.get('denoms')) or _counts(study.get('denoms'))
        if any(counts.get(i, 0) < 2 for i in ids) or sum(counts[i] for i in ids) != counts.get(total):
            continue
        cells = {x['groupId']: x for x in measure['classes'][0]['categories'][0].get('measurements', [])}
        arms = [(counts[i],) + _num(cells[i]['value']) + _num(cells[i]['spread']) for i in ids]
        lo, hi = sd_span([(n, m, mt, v * scale * n ** .5, vt * scale * n ** .5) for n, m, mt, v, vt in arms])
        ts, tt = _num(cells[total]['spread'])
        if ts + tt >= lo and ts - tt <= hi:
            yield measure['title']


EXHAUSTIVE = ('Sex: Female, Male', 'Age, Categorical', 'Ethnicity (NIH/OMB)', 'Race (NIH/OMB)')


def counts(study):
    """(arm sums that miss the Total, categories summed past their arm's count) over the standard count measures."""
    groups, base, miss, over = study.get('groups', []), _counts(study.get('denoms')), [], []
    total = [g['id'] for g in groups if g.get('title', '').strip().lower() == 'total']
    for measure in study['measures']:
        classes = measure.get('classes', [])
        if measure.get('paramType') != 'COUNT_OF_PARTICIPANTS' or len(classes) != 1:
            continue
        n = _counts(measure.get('denoms')) or base
        cells = [{x['groupId']: x.get('value', '') for x in c.get('measurements', [])}
                 for c in classes[0].get('categories', [])]
        if not cells or not all(v.isdigit() for c in cells for v in c.values()):
            continue
        cells = [{k: int(v) for k, v in c.items()} for c in cells]
        arms = [g['id'] for g in groups if g['id'] not in total]
        if len(total) == 1 and len(arms) > 1 and all(i in c for c in cells for i in arms + total):
            miss += [measure['title'] for c in cells if sum(c[i] for i in arms) != c[total[0]]]
        if measure.get('title') in EXHAUSTIVE:
            over += [(measure['title'], g['id'], sum(c[g['id']] for c in cells), n[g['id']]) for g in groups
                     if g['id'] in n and all(g['id'] in c for c in cells) and sum(c[g['id']] for c in cells) > n[g['id']]]
    return miss, over


def scan(studies):
    out = {'checked': 0, 'outside': [], 'far': 0, 'chance': 0.0, 'unweighted': [], 'decoy': [0, 0, 0]}
    for nct, study in studies.items():
        for row in rows(study):
            out['checked'] += 1
            if row['outside']:
                out['outside'].append({'nct': nct, **row})
            if row['far']:
                out['far'] += 1
                out['chance'] += row['chance']
                for k, key in enumerate(('decoy', 'on_plain', 'on_mirror')):
                    out['decoy'][k] += row[key]
                if row['unweighted']:
                    out['unweighted'].append({'nct': nct, **row})
    out['chance'] = round(out['chance'], 1)
    return out


def fetch_elig(path):
    """Eligibility ages ([minimumAge, maximumAge]) for every trial with results, one request a second."""
    query = {'aggFilters': 'results:with', 'pageSize': '1000', 'fields': 'NCTId,EligibilityModule'}
    keep = {}
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=120) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            e = s['protocolSection'].get('eligibilityModule', {})
            keep[s['protocolSection']['identificationModule']['nctId']] = [e.get('minimumAge'), e.get('maximumAge')]
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump(keep, open(path, 'w'))


YEARS = {'year': 1, 'years': 1, 'month': 1 / 12, 'months': 1 / 12, 'week': 7 / 365.25, 'weeks': 7 / 365.25,
         'day': 1 / 365.25, 'days': 1 / 365.25}


def _years(text):
    m = re.match(r'([\d.]+)\s*(\w+)', text or '')
    return float(m.group(1)) * YEARS[m.group(2).lower()] if m and m.group(2).lower() in YEARS else None


def age_flags(study, lo_text, hi_text):
    """Baseline age groups that the trial's own age limits rule out: a mean outside them, or an SD above the
    Bhatia-Davis cap, the largest sample SD any ages inside the limits can have with that mean (to rounding).
    'wide' marks an SD above the whole width of the range, which no mean can rescue."""
    a, b = _years(lo_text), _years(hi_text)
    if a is None or b is None:
        return []
    b += 1  # "65 Years" admits anyone up to their 66th birthday
    n = _counts(study.get('denoms'))
    out = []
    for m in study.get('measures', []):
        if (m.get('paramType') != 'MEAN' or m.get('dispersionType') != 'STANDARD_DEVIATION'
                or not re.match(r'\s*age[\s,:(]*(continuous)?[\s)]*$', m.get('title', ''), re.I)
                or (m.get('unitOfMeasure') or '').strip().lower() != 'years'):
            continue
        cats = m.get('classes', [])
        if len(cats) != 1 or len(cats[0].get('categories', [])) != 1:
            continue
        for x in cats[0]['categories'][0].get('measurements', []):
            mv, sv, k = _num(x.get('value')), _num(x.get('spread')), n.get(x.get('groupId'))
            if not mv or not sv or not k or k < 2:
                continue
            (mean, tm), (sd, ts) = mv, sv
            if mean + tm < a or mean - tm > b:
                out.append({'group': x['groupId'], 'n': k, 'mean': mean, 'sd': sd, 'kind': 'mean outside'})
                continue
            best = max((v - a) * (b - v) for v in (mean - tm, mean + tm, min(max((a + b) / 2, mean - tm), mean + tm)))
            cap = (max(best, 0) * k / (k - 1)) ** 0.5
            if sd - ts > cap * 1.0001:
                out.append({'group': x['groupId'], 'n': k, 'mean': mean, 'sd': sd, 'cap': round(cap, 2),
                            'kind': 'wide' if sd - ts > b - a else 'over cap'})
    return out


BRACKETS = {'<=18 years': (0, 18), 'Between 18 and 65 years': (18, 65), '>=65 years': (65, 200)}


def bracket_flags(study, lo_text, hi_text):
    """Standard age brackets with participants that the trial's own age limits rule out, in the Total column
    (or the only group). 'whole' marks a bracket that holds the entire sample."""
    a, b = _years(lo_text), _years(hi_text)
    groups = study.get('groups') or []
    total = [g['id'] for g in groups if g.get('title', '').strip().lower() == 'total'] or (
        [groups[0]['id']] if len(groups) == 1 else [])
    if not total:
        return []
    n = _counts(study.get('denoms')).get(total[0])
    out = []
    for m in study.get('measures', []):
        if m.get('paramType') != 'COUNT_OF_PARTICIPANTS' or not re.match(r'\s*age', m.get('title', ''), re.I):
            continue
        for c in m.get('classes', []):
            for k in c.get('categories', []):
                span = BRACKETS.get(k.get('title'))
                v = next((x.get('value') for x in k.get('measurements', []) if x.get('groupId') == total[0]), None)
                if not span or not v or not v.isdigit() or int(v) == 0:
                    continue
                lo, hi = span  # a bracket is ruled out when the limits cannot reach it
                if (b is not None and b + 1 <= lo) or (a is not None and a > hi):
                    out.append({'bracket': k['title'], 'count': int(v), 'n': n, 'whole': n == int(v)})
    return out


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        sys.exit(fetch(sys.argv[2]))
    if sys.argv[1] == 'fetch-elig':
        sys.exit(fetch_elig(sys.argv[2]))
    if sys.argv[1] == 'brackets':  # registry.py brackets BASELINE ELIG
        base, elig = json.load(open(sys.argv[2])), json.load(open(sys.argv[3]))
        rows = [{'nct': nct, 'limits': elig[nct][:2], **r} for nct, st in base.items() if nct in elig
                for r in bracket_flags(st, *elig[nct][:2])]
        print(json.dumps({'trials': len({r['nct'] for r in rows}), 'whole': [r for r in rows if r['whole']]}, indent=0))
        sys.exit()
    if sys.argv[1] == 'ages':  # registry.py ages BASELINE ELIG
        base, elig = json.load(open(sys.argv[2])), json.load(open(sys.argv[3]))
        flags = {nct: f for nct, st in base.items() if nct in elig for f in [age_flags(st, *elig[nct][:2])] if f}
        rows = [(nct, r) for nct, f in flags.items() for r in f]
        tally = {k: [sum(r['kind'] == k for _, r in rows), len({nct for nct, r in rows if r['kind'] == k})]
                 for k in ('mean outside', 'over cap', 'wide')}
        print(json.dumps({'tally [groups, trials]': tally, 'wide': [{'nct': nct, **r} for nct, r in rows if r['kind'] == 'wide']}, indent=0))
        sys.exit()
    studies = json.load(open(sys.argv[1]))
    out = scan(studies)
    out['studies'] = len(studies)
    out['trials_unweighted'] = len({r['nct'] for r in out['unweighted']})
    out['sd_plain_too'] = sum(r['sd_plain'] for r in out['unweighted'])
    out['sd_plain_and_wrong'] = sum(r['sd_plain'] and r['sd_outside'] for r in out['unweighted'])
    clear = [r for r in out['unweighted'] if r['unequal'] and not r['note']]  # missing data cannot even the arms out
    out['clear'], out['trials_clear'] = len(clear), len({r['nct'] for r in clear})
    out['clear_sd_plain_and_wrong'] = sum(r['sd_plain'] and r['sd_outside'] for r in clear)
    out['clear_rows'] = clear
    tallies = [counts(study) for study in studies.values()]
    out['count_totals_missed'] = sum(len(m) for m, _ in tallies)
    out['count_over'] = sum(len(o) for _, o in tallies)
    out['count_over_doubled'] = sum(got == 2 * n for _, o in tallies for _, _, got, n in o)  # crossover arms
    sd = [(nct,) + row for nct, study in studies.items() for row in sd_impossible(study)]
    out['sd_impossible'], out['trials_sd_impossible'] = len(sd), len({r[0] for r in sd})
    out['sd_kinds'] = {k: sum(r[-1] == k for r in sd) for k in ('zero', 'se', 'low', 'mean', 'count', 'high')}
    out['sd_rows'] = sd
    out['arm_sem'] = [[nct, m] for nct, study in studies.items() for m in arms_as_sem(study)]
    out['arm_sem_decoys'] = {f: sum(1 for st in studies.values() for _ in arms_as_sem(st, f)) for f in (0.5, 0.7, 1.4, 2.0)}
    print(json.dumps(out, indent=1))
