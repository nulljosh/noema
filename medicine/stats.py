"""Recompute P from the test statistic printed beside it, the way statcheck does (Nuijten et al. 2016).

    python3 stats.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

"t(146) = -2.15, P = 0.03", "χ2(2) = 9.69, P = 0.008", "F(1, 55) = 0.39, P = 0.53" and "z = -3.27, P = 0.001" each
fix their P. Every rounding of the printed statistic is tried, and a t or z may be one-sided (half the P).
With no df printed, only bounds that hold for every df are used:
  t     the normal tail is the smallest P any df gives, and df = 1 (Cauchy) the largest.
  χ2    the tail grows with df, so df = 1 gives the smallest P; there is no largest.
  F     no bound, so an F needs its df. An F(45, 1) is also read as F(1, 45).
A row is 'gross' when every P the statistic allows sits on the other side of 0.05 from the printed P.
"""
import glob
import json
import math
import re
import sys

import pvalues

STAT = re.compile(r'(?<![\w-])(t|[zZ]|F|χ\s*2|χ²|[Cc]hi[- ]?squared?|X2)'
                  r'\s*(?:\(\s*(?:df\s*=\s*)?(\d+(?:\.\d+)?)\s*(?:,\s*(\d+(?:\.\d+)?)\s*)?\))?'
                  r'\s*(?:value\s*)?=\s*([-−–]?\s?\d*[.·]?\d+)'
                  r'(?:[\s,;]*df\s*=\s*(\d+))?[\s,;:(]*')
SKIP = re.compile(r'inferior|equivalen|\bNI\b|bonferroni|corrected|permutation|bootstrap|monte carlo', re.I)


def _betacf(a, b, x):
    """Continued fraction for the incomplete beta function (modified Lentz)."""
    tiny = 1e-300
    c, d = 1.0, 1 - (a + b) * x / (a + 1)
    d = 1 / (d if abs(d) > tiny else tiny)
    h = d
    for m in range(1, 300):
        for num in (m * (b - m) * x / ((a + 2 * m - 1) * (a + 2 * m)),
                    -(a + m) * (a + b + m) * x / ((a + 2 * m) * (a + 2 * m + 1))):
            d = 1 + num * d
            d = 1 / (d if abs(d) > tiny else tiny)
            c = 1 + num / c
            c = c if abs(c) > tiny else tiny
            h *= d * c
        if abs(d * c - 1) < 1e-15:
            break
    return h


def betai(a, b, x):
    """Regularized incomplete beta I_x(a, b)."""
    if x <= 0:
        return 0.0
    if x >= 1:
        return 1.0
    front = math.exp(math.lgamma(a + b) - math.lgamma(a) - math.lgamma(b) + a * math.log(x) + b * math.log(1 - x))
    if x < (a + 1) / (a + b + 2):
        return front * _betacf(a, b, x) / a
    return 1 - front * _betacf(b, a, 1 - x) / b


def gammaq(a, x):
    """Regularized upper incomplete gamma Q(a, x)."""
    if x <= 0:
        return 1.0
    front = math.exp(-x + a * math.log(x) - math.lgamma(a))
    if x < a + 1:
        term = total = 1 / a
        for n in range(1, 500):
            term *= x / (a + n)
            total += term
            if term < total * 1e-16:
                break
        return 1 - front * total
    tiny = 1e-300
    b = x + 1 - a
    c, d = 1 / tiny, 1 / b
    h = d
    for i in range(1, 500):
        an = -i * (i - a)
        b += 2
        d = an * d + b
        d = 1 / (d if abs(d) > tiny else tiny)
        c = b + an / c
        c = c if abs(c) > tiny else tiny
        h *= d * c
        if abs(d * c - 1) < 1e-15:
            break
    return front * h


def p_two_sided(kind, x, d1=None, d2=None):
    """P for |statistic| = x. kind is 't', 'z', 'chi' or 'F'; t and z are two-sided."""
    if kind == 'z':
        return math.erfc(x / math.sqrt(2))
    if kind == 't':
        return betai(d1 / 2, 0.5, d1 / (d1 + x * x))
    if kind == 'chi':
        return gammaq(d1 / 2, x / 2)
    return betai(d2 / 2, d1 / 2, d2 / (d2 + d1 * x))


def p_range(kind, x, tx, d1=None, d2=None):
    """(smallest, largest) P over every rounding of x, with the df bounds when no df is printed."""
    lo_x, hi_x = max(0.0, x - tx), x + tx
    if kind == 't' and d1 is None:
        return math.erfc(hi_x / math.sqrt(2)), 1 - 2 / math.pi * math.atan(lo_x)
    if kind == 'chi' and d1 is None:
        return math.erfc(math.sqrt(hi_x / 2)), 1.0
    return p_two_sided(kind, hi_x, d1, d2), p_two_sided(kind, lo_x, d1, d2)


def _kind(name):
    return 't' if name == 't' else 'z' if name in 'zZ' else 'F' if name == 'F' else 'chi'


def judge(kind, x, tx, d1, d2, op, printed):
    """None when the printed P fits, else 'gross' or 'off'."""
    lo, hi = p_range(kind, x, tx, d1, d2)
    ranges = [(lo, hi), (lo / 2, hi / 2)] if kind in 'tz' else [(lo, hi)]
    if kind == 'F' and d1 > d2:  # "F(45, 1)" is F(1, 45) with the df swapped
        ranges.append(p_range(kind, x, tx, d2, d1))
    value, decimals, exp = pvalues._value(printed)
    half = 0.5 * 10 ** -(decimals + exp) if op == '=' else 0
    want = pvalues.significant(op, printed)
    fits = False
    for a, b in ranges:
        if op in ('<', '≤', '<='):
            fits |= a <= value * (1 + 1e-9)
        elif op in ('>', '≥', '>='):
            fits |= b >= value * (1 - 1e-9)
        else:
            fits |= a <= value + half and value - half <= b
    if fits:
        return None
    if want is True and all(a > 0.05 for a, _ in ranges):
        return 'gross'
    if want is False and all(b < 0.05 for _, b in ranges):
        return 'gross'
    return 'off'


def flags(text):
    """(verdict, statistic text, P text, sentence) for each statistic whose P does not fit."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        for m in STAT.finditer(sentence):
            p = pvalues.P_VALUE.match(sentence, m.end())
            if p is None:
                continue
            kind = _kind(m.group(1))
            df1 = m.group(2) or m.group(5)
            d1 = float(df1) if df1 else None
            d2 = float(m.group(3)) if m.group(3) else None
            if kind == 'F' and d2 is None or (d1 is not None and d1 <= 0) or (kind in 'tchi' and m.group(3)):
                continue  # an F needs both df; a t or χ2 with two numbers in brackets is something else
            if kind == 'z' and d1 is not None:
                continue
            x, tx = pvalues._value(re.sub(r'[-−–]\s?', '', m.group(4)))[0], 0.5 * 10 ** -pvalues._value(
                re.sub(r'[-−–]\s?', '', m.group(4)))[1]
            op = p.group(1) or '='
            verdict = judge(kind, x, tx, d1, d2, op, p.group(2))
            yield verdict, m.group(0).strip(' ,;:('), p.group(0), sentence


def scan(abstracts):
    rows, checked = [], 0
    for pmid, text in abstracts.items():
        for verdict, stat, p, sentence in flags(text):
            checked += 1
            if verdict:
                rows.append({'pmid': pmid, 'verdict': verdict, 'stat': stat, 'p': p, 'sentence': sentence[:400]})
    return rows, checked


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, checked = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'checked': checked, 'off': sum(r['verdict'] == 'off' for r in rows),
                      'gross': sum(r['verdict'] == 'gross' for r in rows), 'rows': rows}, indent=1, ensure_ascii=False))
