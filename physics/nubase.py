"""NUBASE2020 against ENSDF ground states (IAEA LiveChart): half-lives that disagree, and ground/isomer swaps
NUBASE does not flag with '&' (its mark for "order reversed compared to ENSDF").

python3 nubase.py fetch DIR   saves nubase_4.mas20 and gs.csv into DIR
python3 nubase.py DIR         prints both checks
"""
import csv
import math
import sys
import urllib.request

UA = {'User-Agent': 'Noema/1.0 (+https://noema.jaybulb.com)'}
NUBASE = 'https://amdc.impcas.ac.cn/masstables/Ame2020/nubase_4.mas20'
LIVECHART = 'https://nds.iaea.org/relnsd/v1/data?fields=ground_states&nuclides=all'
Y = 365.2422 * 86400
UNIT = {'ys': 1e-24, 'zs': 1e-21, 'as': 1e-18, 'fs': 1e-15, 'ps': 1e-12, 'ns': 1e-9, 'us': 1e-6, 'ms': 1e-3, 's': 1,
        'm': 60, 'h': 3600, 'd': 86400, 'y': Y, 'ky': 1e3 * Y, 'My': 1e6 * Y, 'Gy': 1e9 * Y, 'Ty': 1e12 * Y,
        'Py': 1e15 * Y, 'Ey': 1e18 * Y, 'Zy': 1e21 * Y, 'Yy': 1e24 * Y}


def fetch(d):
    for url, name in ((NUBASE, 'nubase_4.mas20'), (LIVECHART, 'gs.csv')):
        with urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=120) as r:
            open(f'{d}/{name}', 'wb').write(r.read())


def num(s):
    try:
        return float(s)
    except ValueError:
        return None


def nubase(lines):
    """(Z, A, state digit) -> (half-life words, flags, J-pi). Columns per the file's own FORMAT header."""
    return {(int(l[4:7]), int(l[0:3]), l[7]): ([w for w in (l[69:78].strip(), l[78:80].strip()) if w], l[67:69],
                                               l[88:102].strip())
            for l in lines if not l.startswith('#')}


def seconds(words):
    """['24.11', 'ky'] -> seconds, or None for stable, systematics (#) or limits."""
    if len(words) != 2 or words[1] not in UNIT or num(words[0]) is None:
        return None
    return num(words[0]) * UNIT[words[1]]


def halflives(nb, rows, dex=0.3, sigma=5):
    """Ground states whose half-lives differ by more than `dex` and `sigma` (NUBASE uncertainty not read: ENSDF's only)."""
    out = []
    for r in rows:
        z, a = int(r['z']), int(r['z']) + int(r['n'])
        t, dt, g = num(r['half_life_sec']), num(r['unc_hls']), nb.get((z, a, '0'))
        T = g and seconds(g[0])
        if not T or r['operator_hl'] or not t or dt is None:
            continue
        off, z_ = abs(math.log10(t / T)), abs(t - T) / dt if dt else float('inf')
        if off > dex and z_ > sigma:
            out.append((round(off, 2), f"{a}{r['symbol']}", f"{r['half_life']} {r['unit_hl']}", ' '.join(g[0])))
    return sorted(out, reverse=True)


def duplicates(rows):
    """Rows whose decay_1..3 name one mode twice. The single-nuclide endpoint lists each mode once, so a
    consumer reading decay_2 off the bulk export can pick up a second, different branching for the same mode."""
    out = []
    for r in rows:
        modes = [(r[f'decay_{i}'].strip(), r[f'decay_{i}_%'].strip()) for i in (1, 2, 3) if r[f'decay_{i}'].strip()]
        names = [d for d, _ in modes]
        if len(set(names)) < len(names):
            out.append((f"{int(r['z']) + int(r['n'])}{r['symbol']}", modes))
    return out


def swaps(nb, rows):
    """ENSDF's ground state carries NUBASE's first-isomer half-life and spin, yet NUBASE has no '&' on it."""
    out = []
    for r in rows:
        z, a = int(r['z']), int(r['z']) + int(r['n'])
        g, m = nb.get((z, a, '0')), nb.get((z, a, '1'))
        if not g or not m or not r['half_life'] or r['operator_hl']:
            continue
        e = [r['half_life'].upper(), r['unit_hl'].upper()]
        spin = lambda j: j.strip('()#*').split(',')[0]
        if ([w.upper() for w in m[0]] == e and [w.upper() for w in g[0]] != e and '&' not in g[1]
                and spin(r['jp'].replace(' ', ',')) == spin(m[2])):
            out.append((f"{a}{r['symbol']}", g[1].strip(), r['jp'], ' '.join(m[0]), r['ENSDFpublicationcut-off']))
    return out


if __name__ == '__main__':
    if sys.argv[1] == 'fetch':
        fetch(sys.argv[2])
        sys.exit()
    nb = nubase(open(f'{sys.argv[1]}/nubase_4.mas20'))
    rows = list(csv.DictReader(open(f'{sys.argv[1]}/gs.csv')))
    for h in halflives(nb, rows):
        print('half-life', *h)
    for s in swaps(nb, rows):
        print('unflagged swap', *s)
    for d in duplicates(rows):
        print('duplicated decay mode', *d)
