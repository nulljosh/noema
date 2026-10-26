"""Check ratio estimates against their own 95% confidence intervals and P values in trial abstracts.

    python3 ratios.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

"OR 1.5 (95% CI 1.2-1.9), P = 0.30" can be checked with no data: the estimate must sit inside its interval, and a
95% interval that excludes 1 goes with P < 0.05, one that includes 1 with P > 0.05. Two sharp flags only:
  inside   the estimate lies outside its own interval, beyond rounding;
  verdict  the interval clearly excludes 1 while P > 0.06, or clearly includes 1 while P < 0.04.
Bounds within rounding of 1 and P between 0.04 and 0.06 are skipped. Georgescu and Wren (2018) ran this kind of
check across PubMed.
"""
import glob
import json
import math
import re
import sys

import pvalues

NUM = r'(?<![\w.·])(\d*[.·]?\d+)'  # .078 is a number; the 77 in a typed 'O.77' is not
RATIO = re.compile(r'(?<![\w-])(a?ORs?|a?RRs?|a?HRs?|IRR|odds ratio|risk ratio|hazard ratio|relative risk|rate ratio)'
                   r'(?![\w-])[^\d;]{0,25}?' + NUM + r'\s*[(\[,;]?\s*95\s*%\s*(?:CI|confidence interval)[\s,:=]*'
                   + NUM + r'\s*(?:-|–|to|,)\s*' + NUM)
SKIP = re.compile(r'inferior|\bNI\b|one-sided|1-sided|equivalen|interaction|heterogeneity|breslow|difference|trend|\bP\s+P\b', re.I)  # these P values test something other than the ratio


def _num(text):
    value, decimals, _ = pvalues._value(text)
    return value, 0.5 * 10 ** -decimals


def _p_fits(op, printed, est, te, lo, tl, hi, th, slack=10, log=True, too_big=True):
    """True when the printed P fits the P that Altman and Bland (2011) recover from the interval, to within a factor.

    SE = (ln hi - ln lo) / 3.92 and z = |ln est| / SE, taken over every rounding of the three printed numbers.
    With log=False (a difference, null 0) the same runs on the raw scale. too_big=False forgives a printed P above the
    recovered one, which small-sample t and exact tests give.
    ponytail: a factor of 10 forgives exact, profile and t-based intervals; tighten it only after a hand-read.
    """
    if log and (lo - tl <= 0 or est - te <= 0):
        return True
    f = math.log if log else float
    (e1, e2), (l1, l2), (h1, h2) = [(f(x - t), f(x + t)) for x, t in ((est, te), (lo, tl), (hi, th))]
    se_max = (h2 - l1) / 3.92
    se_min = max(1e-12, (h1 - l2) / 3.92)
    far = max(abs(e1), abs(e2))
    near = 0.0 if e1 <= 0 <= e2 else min(abs(e1), abs(e2))
    p_lo, p_hi = math.erfc(far / se_min / math.sqrt(2)), math.erfc(near / se_max / math.sqrt(2))
    value, decimals, exp = pvalues._value(printed)
    if op in ('<', '≤', '<='):
        return p_lo <= value * slack
    if op in ('>', '≥', '>='):
        return not too_big or p_hi * slack >= value
    half = 0.5 * 10 ** -(decimals + exp)
    return p_lo / slack <= value + half and (not too_big or value - half <= p_hi * slack)


def flags(text):
    """(kind, ratio name, estimate, low, high, operator, printed P, sentence) for each sharp mismatch."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        matches = list(RATIO.finditer(sentence))
        for i, m in enumerate(matches):
            (est, te), (lo, tl), (hi, th) = _num(m.group(2)), _num(m.group(3)), _num(m.group(4))
            if not 0 < lo <= hi:
                continue
            row = (m.group(1), m.group(2), m.group(3), m.group(4))
            if est < lo - tl - te or est > hi + th + te:
                yield ('inside',) + row + (None, None, sentence)
                continue
            stop = matches[i + 1].start() if i + 1 < len(matches) else len(sentence)
            p = pvalues.P_VALUE.search(sentence[m.end():stop])
            if p is None or p.start() > 40:
                continue
            if i + 1 < len(matches) and stop - (m.end() + p.end()) < 15:  # "(p < 0.001; OR ..." is the next ratio's P
                continue
            op, printed = p.group(1) or '=', p.group(2)
            value = pvalues._value(printed)[0]
            excludes = lo - tl > 1 or hi + th < 1
            includes = lo + tl < 1 < hi - th
            says_big = (op == '=' and value > 0.06) or (op in ('>', '≥', '>=') and value >= 0.05)
            says_small = (op == '=' and value < 0.04) or (op in ('<', '≤', '<=') and value <= 0.04)
            if (excludes and says_big) or (includes and says_small):
                yield ('verdict',) + row + (op, printed, sentence)
            elif not _p_fits(op, printed, est, te, lo, tl, hi, th):
                yield ('pci',) + row + (op, printed, sentence)


def scan(abstracts):
    rows, ratios = [], 0
    for pmid, text in abstracts.items():
        ratios += len(RATIO.findall(text))
        for f in flags(text):
            rows.append({'pmid': pmid, 'kind': f[0], 'ratio': f[1], 'estimate': f[2], 'ci': [f[3], f[4]],
                         'printed_p': None if f[5] is None else f[5] + ' ' + f[6], 'sentence': f[7][:400]})
    return rows, ratios


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, ratios = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'ratios_with_ci': ratios, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
