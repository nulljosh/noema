"""Check medians against their own interquartile range and means or medians against their own range.

    python3 spread.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

A median outside its IQR, or a value outside its own range, cannot happen. "10 [IQR 7-7]" or "8 months (range 1-6)"
is a slip whatever the data. So is an SD too large for its range: by the Bhatia-Davis inequality the variance of data
in [a, b] with mean m is at most (m - a)(b - m), and the sample SD is at most sqrt(2) times that root (n >= 2), so
"2.8 ± 1.78 days (range 2.29-3.31)" cannot be a range. Numbers glued to units (mm 2, × 10 3, log 10), denominators (8/10, out of 30) and SDs
(± 4.6 (range 25-45)) are skipped, and so is a decrease printed as a positive number against a negative interval.
"""
import glob
import json
import re
import sys

N = r'(-?\d+(?:[.·]\d+)?)'
END = r'\s*(?:-|–|to|,)\s*' + N + r'(?![\d,])'
TAIL = END + r'\s*[)\]]'
HEAD = r'(?<![\w.·,/-])' + N + r'(?![\d,/])\s*(?:[a-zA-Zµ%°]+\s*)?[(\[]\s*'
PATTERNS = {'iqr': re.compile(HEAD + r'(?:IQR|interquartile range)[\s,:=]*' + N + TAIL),
            'range': re.compile(HEAD + r'range[\s,:=]*' + N + TAIL)}
UNIT = r'(?:[a-zA-Zµ%°]+\s*)'
SD = [re.compile(r'(?<![\w.·,/-])' + N + r'\s*(?:±|\+/-|\+/−)\s*' + N + r'(?![\d,])\s*' + UNIT + r'{0,2}?[(\[,;]\s*range[\s,:=]*'
                 + N + END, re.I),
      re.compile(r'(?<![\w.·,/-])' + N + r'\s*' + UNIT + r'?[(\[]\s*(?:SD|s\.d\.|standard deviation)[\s,:=]*' + N + r'\s*' + UNIT
                 + r'?[;,]\s*range[\s,:=]*' + N + END, re.I)]
BEFORE = re.compile(r'(?:±|\+/-|\+|\bout of|\b(?:mm|cm|m|μm|km)|×\s*10|\bx\s*10|\blog|\bP|\d\.|week|day|month|year|grade|stage|'
                    r'type|phase|visit|time|minutes?|s\.?d\.?|SD\]?|\[)\s*$', re.I)


def _f(x):
    return float(x.replace('·', '.'))


def _tol(x):
    x = x.replace('·', '.')
    return 0.5 * 10 ** -(len(x.split('.')[1]) if '.' in x else 0)


def flags(text):
    """(kind, value, low, high, snippet) for each value that lies outside its own IQR or range."""
    t = ' '.join(text.split())
    for kind, pattern in PATTERNS.items():
        for m in pattern.finditer(t):
            x, a, b = m.group(1), m.group(2), m.group(3)
            if BEFORE.search(t[max(0, m.start() - 12):m.start()]):
                continue
            value, low, high = _f(x), _f(a), _f(b)
            if low > high or -high - _tol(b) <= value <= -low + _tol(a):
                continue
            if value < low - _tol(a) - _tol(x) or value > high + _tol(b) + _tol(x):
                yield kind, x, a, b, t[max(0, m.start() - 80):m.end() + 10]


def sd_flags(text):
    """(mean, sd, low, high, snippet) for each SD larger than any data in its own range allows."""
    t = ' '.join(text.split())
    for pattern in SD:
        for m in pattern.finditer(t):
            x, sd, a, b = m.groups()
            if BEFORE.search(t[max(0, m.start() - 12):m.start()]):
                continue
            lo, hi = _f(a) - _tol(a), _f(b) + _tol(b)
            ml, mh = _f(x) - _tol(x), _f(x) + _tol(x)
            if not lo <= hi or mh < lo or ml > hi:
                continue
            widest = max((m_ - lo) * (hi - m_) for m_ in (ml, mh, min(max((lo + hi) / 2, ml), mh)))
            if _f(sd) - _tol(sd) > (2 * max(widest, 0)) ** 0.5:
                yield x, sd, a, b, t[max(0, m.start() - 60):m.end() + 10]


def scan(abstracts):
    rows = [{'pmid': pmid, 'kind': k, 'value': x, 'interval': [a, b], 'snippet': s}
            for pmid, text in abstracts.items() for k, x, a, b, s in flags(text)]
    rows += [{'pmid': pmid, 'kind': 'sd', 'value': x, 'sd': sd, 'interval': [a, b], 'snippet': s}
             for pmid, text in abstracts.items() for x, sd, a, b, s in sd_flags(text)]
    checked = sum(len(p.findall(' '.join(t.split()))) for t in abstracts.values() for p in PATTERNS.values())
    return rows, checked


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, checked = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'checked': checked, 'flags': len(rows), 'rows': rows}, indent=1,
                     ensure_ascii=False))
