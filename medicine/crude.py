"""Check a printed risk or odds ratio against the two arm percentages printed just before it.

    python3 crude.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

"Mortality 20% vs 10% (RR 0.50)" fixes the crude ratio: 10 / 20 or 20 / 10 for a risk ratio, the same with odds for
an odds ratio, and for a risk ratio also the complement (the 80% and 90% who did not die). Every rounding of both
percentages is tried, either arm may come first, and a ratio is flagged only when it sits more than 1.5 times away
from every crude value. Adjusted, regression, stratified, cluster and rate ratios are skipped by wording, but many
trials adjust without saying so, so a flag is an open note until a hand read finds the abstract calls it crude.
"""
import glob
import json
import math
import re
import sys

import nnt
import pvalues
import ratios

RATIO = re.compile(r'(?<![\w-])(RR|risk ratio|relative risk|OR|odds ratio)(?![\w-])[^\d;%-]{0,20}?' + nnt.NUM
                   + r'(?![\d.·]|\s*%|\s*to\b)')  # "OR [95% CI]" and "OR = 1.2 to 1.9" are not estimates
SKIP = re.compile(r'adjust|\ba(?:OR|RR)\b|multivaria|correct|stratif|weighted|cluster|propensity|logistic|regression|'
                  r'mantel|poisson|mixed|multilevel|incidence|rate ratio|hazard|person-years|per (?:1,?000|100)|'
                  r'inferior|\bNI\b', re.I)
GAP = math.log(1.5)


def crude(kind, x, tx, y, ty):
    """Every crude ratio the two printed percentages allow, over each rounding and both orders; None at 0 or 100."""
    out = []
    for a in (x - tx, x + tx):
        for b in (y - ty, y + ty):
            if not (0 < a < 100 and 0 < b < 100):
                return None
            odds = a * (100 - b) / (b * (100 - a))
            out += [odds, 1 / odds] if kind == 'OR' else [a / b, b / a, (100 - a) / (100 - b), (100 - b) / (100 - a)]
    return out


def gap(est, te, values):
    """How far (as a log ratio) the printed estimate, at any rounding, sits from the nearest crude value."""
    return min(0 if est - te <= v <= est + te else min(abs(math.log(v / (est - te))) if est > te else math.inf,
                                                      abs(math.log(v / (est + te)))) for v in values)


def flags(text):
    """(far, kind, arms, ratio, crude values, sentence) for each ratio with an arm pair right before it."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        for m in RATIO.finditer(sentence):
            head = sentence[max(0, m.start() - 100):m.start()]
            pairs = list(nnt.ARMS.finditer(head))
            if not pairs:
                continue
            pair = pairs[-1]
            between = head[pair.end():]
            if len(between) > 30 or re.search(r'\d|;|\bP\b|respectively|\band\b', between):
                continue  # the pair must sit right before the ratio, with nothing else in between
            if re.search(r'\bat\b', m.group(0)) or re.search(r'(CI|interval|[-–]|to)\s*[:,]?\s*$', head[:pair.start()]) \
                    or re.search(r'lower|higher|reduc|increas|odds|\)', pair.group(0)):
                continue  # an interval's bound or "63% lower odds" is not an arm's rate
            (x, tx), (y, ty) = ratios._num(pair.group(1)), ratios._num(pair.group(2))
            if abs(x + y - 100) <= tx + ty:
                continue  # 82.4% vs 17.6% splits one group in two
            kind = 'OR' if m.group(1) in ('OR', 'odds ratio') else 'RR'
            est, te = ratios._num(m.group(2))
            values = crude(kind, x, tx, y, ty)
            if values and est > 0:
                yield gap(est, te, values) > GAP, kind, pair.group(0), m.group(0), sorted({round(v, 2) for v in values}), sentence


def scan(abstracts):
    rows, checked = [], 0
    for pmid, text in abstracts.items():
        for far, kind, arms, ratio, values, sentence in flags(text):
            checked += 1
            if far:
                    rows.append({'pmid': pmid, 'kind': kind, 'arms': arms, 'ratio': ratio, 'crude': values,
                             'sentence': sentence[:400]})
    return rows, checked


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, checked = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'ratios': checked, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
