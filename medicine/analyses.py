"""Check ClinicalTrials.gov outcome analyses against themselves: sign slips in confidence limits.

    python3 analyses.py fetch ANALYSES_JSON    # every outcome analysis of every study with results (~35 min)
    python3 analyses.py ANALYSES_JSON
    python3 analyses.py fetch-arms ARMS_JSON   # the same outcomes with their arm counts, values and spreads
    python3 analyses.py spreads ARMS_JSON      # does each CI fit its arms' spreads as SDs, or as standard errors?

An analysis posts an estimate, a two-sided CI and often a p-value. For a difference (mean, LS mean, risk, slope),
most CIs are symmetric about the estimate. A CI that is not, but becomes symmetric when one limit changes sign,
looks like a lost or stray minus sign. That alone can be luck, since some intervals are honestly lopsided (medians,
rare-event risk differences), so the p-value decides: `backs the flip` when the posted CI disagrees with p about
zero and the flipped one agrees, `backs the posted CI` for the reverse, which is the rate luck alone gives.
Estimates whose CI is symmetric on the log scale are ratios under a difference label and are left out.
"""
import json
import math
import re
import sys
import time
import urllib.parse
import urllib.request

API = 'https://clinicaltrials.gov/api/v2/studies?'
KEEP = ('groupIds', 'pValue', 'statisticalMethod', 'paramType', 'paramValue', 'ciPctValue', 'ciNumSides',
        'ciLowerLimit', 'ciUpperLimit', 'dispersionType', 'dispersionValue', 'nonInferiorityType')


def fetch(path):
    """Page through the API one request at a time, a second apart; keep analyses, not group data."""
    query = {'aggFilters': 'results:with', 'pageSize': '200', 'fields': 'NCTId,OutcomeMeasuresModule'}
    out = []
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=180) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            nct = s['protocolSection']['identificationModule']['nctId']
            for i, m in enumerate(s.get('resultsSection', {}).get('outcomeMeasuresModule', {}).get('outcomeMeasures', [])):
                for a in m.get('analyses', []):
                    out.append({'nct': nct, 'outcome': i, 'title': m.get('title'), **{k: a[k] for k in KEEP if k in a}})
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump(out, open(path, 'w'))


def fetch_arms(path):
    """Like fetch, but keep each analysed outcome's arm rows too: count, value and spread per group, with the
    outcome's parameter and dispersion type. Only outcomes with one class and one category, the plain tables."""
    query = {'aggFilters': 'results:with', 'pageSize': '200', 'fields': 'NCTId,OutcomeMeasuresModule'}
    out = []
    while True:
        with urllib.request.urlopen(API + urllib.parse.urlencode(query), timeout=180) as response:
            page = json.load(response)
        for s in page.get('studies', []):
            nct = s['protocolSection']['identificationModule']['nctId']
            for i, m in enumerate(s.get('resultsSection', {}).get('outcomeMeasuresModule', {}).get('outcomeMeasures', [])):
                classes = m.get('classes', [])
                if not m.get('analyses') or len(classes) != 1 or len(classes[0].get('categories', [])) != 1:
                    continue
                n = {c['groupId']: c.get('value') for d in m.get('denoms', [])[:1] for c in d.get('counts', [])}
                cells = {x['groupId']: x for x in classes[0]['categories'][0].get('measurements', [])}
                out.append({'nct': nct, 'outcome': i, 'param': m.get('paramType'), 'dispersion': m.get('dispersionType'),
                            'arms': {g: [n.get(g), x.get('value'), x.get('spread')] for g, x in cells.items()},
                            'analyses': [{k: a[k] for k in KEEP if k in a} for a in m['analyses']]})
        if not page.get('nextPageToken'):
            break
        query['pageToken'] = page['nextPageToken']
        time.sleep(1)
    json.dump(out, open(path, 'w'))


def num(text):
    """(value, half a unit in the last printed place) or None."""
    try:
        value = float(str(text).replace(',', ''))
    except (TypeError, ValueError):
        return None
    t = str(text).strip()
    return value, 0.5 * 10 ** -(len(t.split('.')[1]) if '.' in t else 0)


def pval(text):
    """(low, high) bounds on a posted p-value, or None."""
    m = re.fullmatch(r'(<=?|≤|>=?|≥)?(\d*\.?\d+)', str(text or '').replace(' ', ''))
    if not m or float(m.group(2)) > 1:
        return None
    v, op = float(m.group(2)), m.group(1) or ''
    if op[:1] in '<≤' and op:
        return 0.0, v
    if op[:1] in '>≥' and op:
        return v, 1.0
    h = 0.5 * 10 ** -len(m.group(2).split('.')[1]) if '.' in m.group(2) else 0
    return max(0.0, v - h), min(1.0, v + h)


def additive(param_type):
    t = str(param_type)
    return bool(re.search(r'differ|slope', t, re.I)) and not re.search(r'ratio|\blog|posterior|bayes', t, re.I)


def symmetric(est, lo, hi):
    """Estimate at the CI midpoint, within rounding and 2% of the half-width."""
    return abs((lo[0] + hi[0]) / 2 - est[0]) <= est[1] + lo[1] + hi[1] + 0.01 * (hi[0] - lo[0])


def side(lo, hi, p):
    """'agree' or 'clash' when a 95% CI and a two-sided p clearly say the same or opposite things about zero."""
    excludes = lo > 0 or hi < 0
    if (excludes and p[0] > 0.10) or (not excludes and p[1] < 0.01):
        return 'clash'
    if (excludes and p[1] <= 0.05) or (not excludes and p[0] >= 0.05):
        return 'agree'
    return None


def sign_slip(a):
    """(flipped CI, verdict) when one limit's sign looks wrong, else None."""
    est, lo, hi = num(a.get('paramValue')), num(a.get('ciLowerLimit')), num(a.get('ciUpperLimit'))
    if not (est and lo and hi) or a.get('ciNumSides') != 'TWO_SIDED' or not additive(a.get('paramType')):
        return None
    if lo[0] >= hi[0] or symmetric(est, lo, hi):
        return None
    if est[0] > 0 and lo[0] > 0 and abs(math.log(est[0]) - math.log(lo[0] * hi[0]) / 2) <= (
            0.03 * math.log(hi[0] / lo[0]) / 2 + est[1] / est[0] + lo[1] / lo[0]):
        return None  # symmetric on the log scale: a ratio
    for flo, fhi in ((-lo[0], hi[0]), (lo[0], -hi[0])):
        if (flo, fhi) == (lo[0], hi[0]):
            continue
        a2, b2 = sorted((flo, fhi))
        if a2 < b2 and a2 <= est[0] <= b2 and symmetric(est, (a2, lo[1]), (b2, hi[1])):
            p, pct = pval(a.get('pValue')), num(a.get('ciPctValue'))
            verdict = 'no p'
            if p and pct and pct[0] == 95:
                s0, s1 = side(lo[0], hi[0], p), side(a2, b2, p)
                verdict = ('backs the flip' if (s0, s1) == ('clash', 'agree') else
                           'backs the posted CI' if (s0, s1) == ('agree', 'clash') else 'neutral')
            return [a2, b2], verdict
    return None


def spread_kind(rec, a):
    """For a two-arm mean difference with a 95% two-sided CI: 'fits SD', 'fits SE', or None when neither or unclear.
    The CI half-width should be about 1.96 * sqrt(s1^2/n1 + s2^2/n2) when the arm spreads are SDs, and
    1.96 * sqrt(s1^2 + s2^2) when they are standard errors. Arms of at least 10 keep the two far apart."""
    g = a.get('groupIds') or []
    if len(g) != 2 or a.get('ciNumSides') != 'TWO_SIDED' or not additive(a.get('paramType')):
        return None
    pct, lo, hi = num(a.get('ciPctValue')), num(a.get('ciLowerLimit')), num(a.get('ciUpperLimit'))
    arms = [rec['arms'].get(x) for x in g]
    if not (pct and pct[0] == 95 and lo and hi and hi[0] > lo[0]) or None in arms:
        return None
    try:
        (n1, _, s1), (n2, _, s2) = [(int(n), v, float(sp)) for n, v, sp in arms]
    except (TypeError, ValueError):
        return None
    if min(n1, n2) < 10 or not (s1 > 0 and s2 > 0):
        return None
    h = (hi[0] - lo[0]) / 2
    r_sd, r_se = h / (1.96 * (s1 ** 2 / n1 + s2 ** 2 / n2) ** .5), h / (1.96 * (s1 ** 2 + s2 ** 2) ** .5)
    # ponytail: a fixed window; adjusted models narrow the CI and small t widen it, both within about a quarter
    return 'fits SD' if 0.75 <= r_sd <= 1.33 else 'fits SE' if 0.75 <= r_se <= 1.33 else None


def main(path):
    rows = json.load(open(path))
    tally, hits = {}, []
    for a in rows:
        r = sign_slip(a)
        if r:
            tally[r[1]] = tally.get(r[1], 0) + 1
            if r[1] == 'backs the flip':
                hits.append({'nct': a['nct'], 'title': a.get('title'), 'type': a.get('paramType'),
                             'estimate': a.get('paramValue'), 'ci': [a.get('ciLowerLimit'), a.get('ciUpperLimit')],
                             'flipped': r[0], 'p': a.get('pValue'), 'method': a.get('statisticalMethod')})
    print(json.dumps({'analyses': len(rows), 'additive_two_sided': sum(
        1 for a in rows if a.get('ciNumSides') == 'TWO_SIDED' and additive(a.get('paramType'))
        and num(a.get('paramValue')) and num(a.get('ciLowerLimit')) and num(a.get('ciUpperLimit'))),
        'sign_slips': tally, 'trials_backed': len({h['nct'] for h in hits}), 'backed': hits}, indent=1))


def spreads(path):
    """Tally spread_kind against each outcome's own dispersion label, and list the analyses that disagree."""
    tally, off = {}, []
    for rec in json.load(open(path)):
        for a in rec['analyses']:
            k = spread_kind(rec, a)
            if k and rec.get('dispersion') in ('Standard Deviation', 'Standard Error'):
                key = '%s, %s' % (rec['dispersion'], k)
                tally[key] = tally.get(key, 0) + 1
                if k != {'Standard Deviation': 'fits SD', 'Standard Error': 'fits SE'}[rec['dispersion']]:
                    off.append([rec['nct'], rec['outcome'], rec['dispersion'], k, [rec['arms'][g] for g in a['groupIds']],
                                a.get('paramValue'), [a.get('ciLowerLimit'), a.get('ciUpperLimit')]])
    print(json.dumps({'tally': tally, 'disagree': len(off), 'trials': len({o[0] for o in off}), 'rows': off}))


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
    elif sys.argv[1] == 'fetch-arms':
        fetch_arms(sys.argv[2])
    elif sys.argv[1] == 'spreads':
        spreads(sys.argv[2])
    else:
        main(sys.argv[1])
