"""Check a printed Cohen's d against the two arm means and SDs printed just before it.

    python3 cohen.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

"4.1 ± 2.6 vs 5.7 ± 2.4, P = 0.006, d = 0.64" fixes d up to the choice of SD: the gap in means over the pooled SD,
over either arm's SD (Glass), or shrunk by up to a quarter for small samples (Hedges). Every rounding is tried, and
a d is flagged only when it sits more than 1.5 times outside that whole range. A ± that is really a standard error,
a d from change scores or an adjusted d can all explain a flag, so a flag is an open note until a hand read.
"""
import glob
import json
import math
import re
import sys

import pvalues
import ratios

NUM = r'([-−–]?)' + ratios.NUM
SD = NUM + r'\s*(?:±|\+/-|\+/−)\s*' + ratios.NUM
PAIR = re.compile(SD + r'[^\d;±]{0,40}?\b(?:vs\.?|versus|compared (?:with|to))\s+' + SD)
D = re.compile(r"(?<![\w-])(?:Cohen'?s\s*)?d\s*[=:]\s*" + NUM + r'(?![\d.])')
SKIP = re.compile(r'adjust|\bSEM?\b|standard error|change|differen|\bfrom\b|baseline|ANCOVA|mixed', re.I)
GAP = math.log(1.5)


def _signed(sign, text):
    value, tol = ratios._num(text)
    return (-value if sign else value), tol


def span(m1, t1, s1, u1, m2, t2, s2, u2):
    """(lowest, highest) |d| the printed means and SDs allow over each rounding and each choice of SD."""
    lo_diff, hi_diff = max(0, abs(m1 - m2) - t1 - t2), abs(m1 - m2) + t1 + t2
    small, big = min(s1 - u1, s2 - u2), max(s1 + u1, s2 + u2)
    if small <= 0:
        return None
    return 0.75 * lo_diff / big, hi_diff / small


def flags(text):
    """(far, pair, d, (lo, hi), sentence) for each d with a mean ± SD pair right before it."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        for m in D.finditer(sentence):
            head = sentence[max(0, m.start() - 120):m.start()]
            pairs = list(PAIR.finditer(head))
            if not pairs or '±' in head[pairs[-1].end():] or len(head) - pairs[-1].end() > 40:
                continue  # the pair must sit right before the d
            g = pairs[-1].groups()
            (m1, t1), (s1, u1) = _signed(g[0], g[1]), ratios._num(g[2])
            (m2, t2), (s2, u2) = _signed(g[3], g[4]), ratios._num(g[5])
            bounds = span(m1, t1, s1, u1, m2, t2, s2, u2)
            d, td = ratios._num(m.group(2))
            if not bounds or d == 0:
                continue
            lo, hi = bounds
            far = d + td < lo / 1.5 or d - td > hi * 1.5
            yield far, pairs[-1].group(0), m.group(0), (round(lo, 2), round(hi, 2)), sentence


def scan(abstracts):
    rows, checked = [], 0
    for pmid, text in abstracts.items():
        for far, pair, d, bounds, sentence in flags(text):
            checked += 1
            if far:
                rows.append({'pmid': pmid, 'pair': pair, 'd': d, 'range': bounds, 'sentence': sentence[:400]})
    return rows, checked


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, checked = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'compared': checked, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
