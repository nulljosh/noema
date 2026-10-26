"""Check printed P values against the counts printed beside them in trial abstracts.

    python3 pvalues.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR, from percents.fetch

A sentence like "24/72 (33.3%) vs 8/71 (11.3%); P = 0.002" prints a 2x2 table and its P value. The P is recomputed
with Pearson's chi-square, Yates' chi-square and Fisher's exact test, each two-sided and one-sided. A printed P is
consistent when some rounding of some test gives it. It is gross when it falls on the other side of 0.05 from every
test, the rule statcheck uses (Nuijten et al. 2016). A sentence naming an analysis that differs from a raw 2x2 test
(adjusted, stratified, non-inferiority and so on) goes to the ambiguous bucket instead.
"""
import glob
import json
import math
import re
import sys

import percents

DEN = percents.DEN + r'(?![-–])'  # 6/12-week is a time point, not a fraction
FRACTIONS = [
    (re.compile(percents.NUM + r'\s*/\s*' + DEN + r'(?:\s*' + percents.PCT + r')?'), 1, 2, 3),
    (re.compile(percents.NUM + r'\s+of\s+' + percents.DEN + r'(?:\s*' + percents.PCT + r')?'), 1, 2, 3),
    (re.compile(percents.NUM + r'\s*' + percents.PCT + r'\s*[)\]]\s+of\s+' + percents.DEN), 1, 3, 2),
]
PCT_BEFORE = re.compile(r'(?<![\d.])(\d{1,3}(?:\.\d{1,2})?)\s*%\s*[,(\[]\s*$')
JOIN = re.compile(r'\b(?:vs\.?|versus|compared (?:with|to))(?!\w)', re.I)
NUMBER = r'(\d(?:[.·]\d+)?\s*(?:[x×]\s*10\s*[-−–]\s*\d+|[eE][-−]\d+)|\d?[.·]\d+|1)'  # scientific form first
P_VALUE = re.compile(r'(?<![\w-])[Pp](?:\s*(?:-?\s*value)?\s*(=|<|>|≤|≥|<=|>=)|\s*-?\s*value\s*(?:of\s*)?)\s*' + NUMBER)
AMBIGUOUS = re.compile(r'inferior|equivalen|one-sided|adjust|stratif|log-rank|logrank|hazard|cluster|interaction|trend|'
                       r'per-protocol|per protocol|regression|multivariab|propensity|cox|mixed|gee\b|ancova|odds ratio|'
                       r'kaplan|survival|time to|mantel|estimat|respectively|score|β|beta|\bP\s+P\b', re.I)  # P P is markup debris
MODEL = re.compile(r'adjust|regression|GEE|generalized estimating|mixed|ANCOVA|multivariab|McNemar|paired|log-rank|Kaplan', re.I)
SENTENCE = re.compile(r'(?<=[.!?])\s+(?=[A-Z(])')


def fractions(sentence):
    """(x, n, printed percentage or None, start, end) for each fraction, in order, without overlaps."""
    found = []
    for pattern, gx, gn, gp in FRACTIONS:
        for m in pattern.finditer(sentence):
            x, n = int(m.group(gx)), int(m.group(gn))
            if 1 < n and x <= n:
                printed = m.group(gp)
                if printed is None:  # "39.5% (68/122)" prints the percentage first
                    before = PCT_BEFORE.search(sentence[max(0, m.start() - 20):m.start()])
                    printed = before.group(1) if before else None
                found.append((x, n, printed, m.start(), m.end()))
    found.sort(key=lambda f: (f[3], -f[4]))
    out = []
    for f in found:
        if not out or f[3] >= out[-1][4]:
            out.append(f)
    return out


def _value(text):
    """Printed number as (value, decimals, exponent)."""
    text = text.replace('·', '.').replace('−', '-').replace('–', '-')
    m = re.match(r'([\d.]+)\s*(?:[x×]\s*10\s*-\s*(\d+)|[eE]-(\d+))?$', text)
    mantissa, exp = m.group(1), int(m.group(2) or m.group(3) or 0)
    decimals = len(mantissa.split('.')[1]) if '.' in mantissa else 0
    return float(mantissa) * 10 ** -exp, decimals, exp


def triples(text):
    """(a, n1, b, n2, operator, printed P, sentence, fraction pair) for each 'a/n1 vs b/n2 ... P' in the text."""
    for sentence in SENTENCE.split(' '.join(text.split())):
        fr = fractions(sentence)
        ps = [m.end() for m in P_VALUE.finditer(sentence)]
        for i in range(len(fr) - 1):
            f1, f2 = fr[i], fr[i + 1]
            between = sentence[f1[4]:f2[3]]
            if len(between) > 120 or not JOIN.search(between) or P_VALUE.search(between):
                continue
            # f1 must be the first fraction since the last P, so "A, B vs C; P" is not read as B against C.
            last = max([0] + [e for e in ps if e <= f1[3]])
            if i > 0 and fr[i - 1][3] >= last:
                continue
            stop = fr[i + 2][3] if i + 2 < len(fr) else len(sentence)
            m = P_VALUE.search(sentence[f2[4]:stop])
            if m is None or m.start() > 80 or f1[1] < 5 or f2[1] < 5:  # the P must start within 80 characters
                continue
            yield f1[0], f1[1], f2[0], f2[1], m.group(1) or '=', m.group(2), sentence, (f1, f2)


def _hyper(a, n1, n2, m1):
    """Log probability of the 2x2 table with a events in row one, given the margins."""
    lc = lambda n, k: math.lgamma(n + 1) - math.lgamma(k + 1) - math.lgamma(n - k + 1)
    return lc(n1, a) + lc(n2, m1 - a) - lc(n1 + n2, m1)


def tests(a, n1, b, n2):
    """Two-sided and one-sided P from Pearson, Yates and Fisher for a/n1 against b/n2."""
    n, m1 = n1 + n2, a + b
    m2 = n - m1
    if m1 == 0 or m2 == 0:
        return {name: 1.0 for name in ('pearson', 'yates', 'fisher', 'pearson1', 'yates1', 'fisher1')}
    cross = a * (n2 - b) - b * (n1 - a)
    denom = n1 * n2 * m1 * m2
    chi = n * cross * cross / denom
    yates = n * max(0.0, abs(cross) - n / 2) ** 2 / denom
    p = {'pearson': math.erfc(math.sqrt(chi / 2)), 'yates': math.erfc(math.sqrt(yates / 2))}
    lo, hi = max(0, m1 - n2), min(n1, m1)
    probs = {k: math.exp(_hyper(k, n1, n2, m1)) for k in range(lo, hi + 1)}
    observed = probs[a]
    p['fisher'] = min(1.0, sum(v for v in probs.values() if v <= observed * (1 + 1e-7)))
    expected = n1 * m1 / n
    side = range(a, hi + 1) if a >= expected else range(lo, a + 1)
    p['fisher1'] = min(1.0, sum(probs[k] for k in side))
    p['pearson1'], p['yates1'] = p['pearson'] / 2, p['yates'] / 2
    return p


def matches(op, printed, p):
    """True when the printed P (with its operator) is consistent with the computed p."""
    value, decimals, exp = _value(printed)
    if op in ('<', '≤', '<='):
        return p <= value * (1 + 1e-9)
    if op in ('>', '≥', '>='):
        return p >= value * (1 - 1e-9)
    scale = 10 ** (decimals + exp)
    return round(value * scale) in {math.floor(p * scale), math.ceil(p * scale)}


def significant(op, printed):
    """True, False or None (on the line) for what the printed P says at 0.05."""
    value = _value(printed)[0]
    if op in ('<', '≤', '<='):
        return True if value <= 0.05 else None
    if op in ('>', '≥', '>='):
        return False if value >= 0.05 else None
    return None if value == 0.05 else value < 0.05


def judge(a, n1, b, n2, op, printed, sentence, pair):
    p = tests(a, n1, b, n2)
    slip = any(f[2] is not None and not percents.consistent(f[0], f[1], f[2]) for f in pair)
    sig = significant(op, printed)
    gross = (sig is True and min(p.values()) >= 0.05) or (sig is False and max(p.values()) < 0.05)
    return {'a': a, 'n1': n1, 'b': b, 'n2': n2, 'printed': op + ' ' + printed,
            'p': {k: float('%.3g' % v) for k, v in p.items()},
            'consistent': any(matches(op, printed, v) for v in p.values()), 'gross': gross,
            'fraction_slip': slip, 'ambiguous': bool(AMBIGUOUS.search(sentence)), 'sentence': sentence[:400]}


def scan(abstracts):
    rows = []
    for pmid, text in abstracts.items():
        model = bool(MODEL.search(text))
        for t in triples(text):
            rows.append({'pmid': pmid, **judge(*t), 'abstract_names_a_model': model})
    return rows


def summary(rows, total):
    clean = [r for r in rows if not r['ambiguous'] and not r['fraction_slip']]
    return {'abstracts': total, 'triples': len(rows), 'unambiguous': len(clean),
            'inconsistent': sum(not r['consistent'] for r in clean), 'gross': sum(r['gross'] for r in clean),
            'fraction_slips': sum(r['fraction_slip'] for r in rows)}


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows = scan(abstracts)
    print(json.dumps({'summary': summary(rows, len(abstracts)), 'rows': rows}, indent=1, ensure_ascii=False))
