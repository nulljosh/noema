"""Kepler's third law across the NASA Exoplanet Archive, and the planets whose posted orbit breaks it.

    python3 kepler.py fetch PS_JSON     # the composite planet table, one row per planet (a few seconds)
    python3 kepler.py PS_JSON           # the law's scatter and the outliers, as JSON
    python3 kepler.py fetch-fits F_JSON # every published solution with a/R_star, P, M_star and R_star
    python3 kepler.py papers F_JSON     # papers whose transit a/R_star runs off the law across their planets
    python3 kepler.py fetch-multi M_JSON
    python3 kepler.py densities M_JSON  # one paper, one star, circular orbits: every planet must imply the same stellar density

With the semi-major axis a in AU, the period P in years and the masses in solar masses, a^3 = (M_star + M_planet) P^2.
The archive's composite table takes each value from a named reference, so a planet whose a, P and stellar mass all
come from one paper and still miss the law by a factor of two is a contradiction inside that paper or its transcription.
"""
import json
import math
import re
import sys
import urllib.parse
import urllib.request

TAP = 'https://exoplanetarchive.ipac.caltech.edu/TAP/sync?'
COLS = ('pl_name,pl_orbper,pl_orbsmax,st_mass,pl_bmassj,'
        'pl_orbper_reflink,pl_orbsmax_reflink,st_mass_reflink')
MJUP = 9.5458e-4  # Jupiter mass in solar masses
RSUN_AU = 0.0046505


def fetch(path):
    q = {'query': 'select %s from pscomppars' % COLS, 'format': 'json'}
    with urllib.request.urlopen(TAP + urllib.parse.urlencode(q), timeout=300) as response:
        open(path, 'wb').write(response.read())


def fetch_fits(path):
    q = {'query': 'select pl_name,pl_refname,pl_ratdor,pl_orbper,st_mass,st_rad from ps where pl_ratdor is not null '
                  'and pl_orbper is not null and st_mass is not null and st_rad is not null', 'format': 'json'}
    with urllib.request.urlopen(TAP + urllib.parse.urlencode(q), timeout=300) as response:
        open(path, 'wb').write(response.read())


def fetch_multi(path):
    q = {'query': 'select hostname,pl_name,pl_refname,pl_ratdor,pl_ratdorerr1,pl_ratdorerr2,pl_orbper,pl_orbeccen '
                  'from ps where pl_ratdor is not null and pl_orbper is not null', 'format': 'json'}
    with urllib.request.urlopen(TAP + urllib.parse.urlencode(q), timeout=300) as response:
        open(path, 'wb').write(response.read())


def rho_star(ardor, period_days):
    """Stellar density in g/cm^3 from a circular orbit's a/R_star and period: 3 pi (a/R_star)^3 / (G P^2)."""
    return 3 * math.pi * ardor ** 3 / (6.674e-8 * (period_days * 86400) ** 2)


def densities(rows, spread=1.5, sigmas=3):
    """Papers that fit two or more circular planets around one star to different stellar densities (Kipping 2014's
    multibody check), skipping catalog tables, which fit each candidate alone. Widest in sigma first."""
    by = {}
    for r in rows:
        ar, p, e = r.get('pl_ratdor'), r.get('pl_orbper'), r.get('pl_orbeccen')
        ref = re.sub(r'<[^>]*>', '', r.get('pl_refname') or '').strip()
        if not (ar and p and ar > 0 and p > 0) or (e or 0) > 0.05 or re.search(r'KOI|TOI|Table|Catalog|ExoFOP', ref, re.I):
            continue
        err = max(abs(r.get('pl_ratdorerr1') or 0), abs(r.get('pl_ratdorerr2') or 0)) / ar
        by.setdefault((ref, r['hostname']), []).append((r['pl_name'], rho_star(ar, p), err))
    out = []
    for (ref, host), v in by.items():
        lo, hi = min(v, key=lambda x: x[1]), max(v, key=lambda x: x[1])
        if len(v) < 2 or not (lo[2] and hi[2]) or hi[1] / lo[1] < spread:
            continue
        sig = math.log(hi[1] / lo[1]) / (3 * math.hypot(lo[2], hi[2]))  # density error is 3x a/R_star's
        if sig > sigmas:
            out.append([ref, host, round(hi[1] / lo[1], 2), round(sig, 1), [[n, round(d, 2)] for n, d, _ in v]])
    return sorted(out, key=lambda o: -o[3])


def ardor_kepler(period_days, m_star, r_star):
    """a/R_star from the period and stellar mass by the law, for comparison with a transit fit's a/R_star."""
    return (m_star * (period_days / 365.25) ** 2) ** (1 / 3) / (r_star * RSUN_AU)


def papers(rows, least=5):
    """Per paper with at least `least` planets: the median log10 of fitted a/R_star over the law's, most off first."""
    by = {}
    for r in rows:
        ar, p, m, rs = (r.get(k) for k in ('pl_ratdor', 'pl_orbper', 'st_mass', 'st_rad'))
        if ar and p and m and rs and min(ar, p, m, rs) > 0:
            by.setdefault(re.sub(r'<[^>]*>', '', r['pl_refname']).strip(), []).append(
                math.log10(ar / ardor_kepler(p, m, rs)))
    out = [[ref, len(v), round(sorted(v)[len(v) // 2], 3)] for ref, v in by.items() if len(v) >= least]
    return sorted(out, key=lambda o: -abs(o[2]))


def ratio(period_days, a_au, m_star, m_planet_jup=0):
    """a^3 / ((M_star + M_planet) P^2): 1 when the posted orbit obeys Kepler's third law."""
    return a_au ** 3 / ((m_star + (m_planet_jup or 0) * MJUP) * (period_days / 365.25) ** 2)


def ref(link):
    m = re.search(r'refstr=(\S+)', link or '')
    return m.group(1) if m else None


def study(rows):
    out = []
    for r in rows:
        p, a, m = r.get('pl_orbper'), r.get('pl_orbsmax'), r.get('st_mass')
        if p and a and m and min(p, a, m) > 0:
            refs = [ref(r.get(k)) for k in ('pl_orbper_reflink', 'pl_orbsmax_reflink', 'st_mass_reflink')]
            out.append((math.log10(ratio(p, a, m, r.get('pl_bmassj'))), r['pl_name'], p, a, m, refs))
    out.sort()
    logs = [o[0] for o in out]
    n = len(logs)
    far = [o for o in out if abs(o[0]) > math.log10(2)]  # off by more than a factor of two
    return {'planets': n, 'median_log10_ratio': round(logs[n // 2], 5),
            'iqr_log10_ratio': round(logs[3 * n // 4] - logs[n // 4], 5),
            'exact': sum(abs(x) < 1e-4 for x in logs),  # a derived from P and M by the law itself
            'off_by_2x': len(far), 'off_by_2x_one_source': sum(len(set(o[5])) == 1 for o in far),
            'rows': [[o[1], round(10 ** o[0], 3), o[2], o[3], o[4], o[5]] for o in far]}


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
    elif sys.argv[1] == 'fetch-fits':
        fetch_fits(sys.argv[2])
    elif sys.argv[1] == 'fetch-multi':
        fetch_multi(sys.argv[2])
    elif sys.argv[1] == 'densities':
        print(json.dumps(densities(json.load(open(sys.argv[2]))), indent=0))
    elif sys.argv[1] == 'papers':
        print(json.dumps(papers(json.load(open(sys.argv[2]))), indent=0))
    else:
        print(json.dumps(study(json.load(open(sys.argv[1]))), indent=0))
