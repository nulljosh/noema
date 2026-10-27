"""Check a hazard ratio against the two median times printed just before it.

    python3 hazard.py CACHE_DIR       # every *.json of {pmid: abstract} in CACHE_DIR

"Median OS was 11.7 vs 12.1 months (HR 0.98, 95% CI 0.73-1.31)" ties the ratio to the medians when hazards are
constant: HR is then the inverse ratio of the medians. Hazards are rarely constant and the abstract seldom says
which arm is the reference, so only size is checked, never direction. A pair is far when the whole interval for
|ln HR| sits more than 3 times above, or below a third of, |ln| of the median ratio (with 0.1 of slack either way).
"""
import glob
import json
import math
import re
import sys

import pvalues
import ratios

NUM = r'(?<![\w.·\-–])(\d*[.·]?\d+)(?![\w·-])'  # not the 1 in 'S-1' or the 2 in '2-mg'
UNIT = r'\s*(?:months?|mo|weeks?|days?|years?)'
MEDIANS = re.compile(r'median[^.;]{0,80}?' + NUM + r'(?:' + UNIT + r')?[^\d;]{0,30}?\b(?:vs\.?|versus|and|'
                     r'compared with)\s+' + NUM + UNIT, re.I)
HR = re.compile(r'(?:\bHR\b|hazard ratio)[^\d]{0,30}?' + ratios.NUM + r'[^;]{0,25}?(?:CI|confidence interval)'
                r'[^\d]{0,6}(?:9[05]\s*%?)?[^\d]{0,6}' + ratios.NUM + r'\s*(?:-|–|to|,)\s*' + ratios.NUM, re.I)
SLACK = 0.1


def far(a, b, hr, lo, hi):
    """True when the CI for |ln HR| cannot fit |ln(a/b)| within a factor of 3."""
    r = abs(math.log(a / b))
    if lo > 1 or hi < 1:
        near, wide = sorted([abs(math.log(lo)), abs(math.log(hi))])
    else:
        near, wide = 0, max(abs(math.log(lo)), abs(math.log(hi)))
    return near > 3 * r + SLACK or wide < r / 3 - SLACK


def flags(text):
    """(far, medians, hr, sentence) for each HR with an interval right after a pair of medians."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        m = MEDIANS.search(sentence)
        h = m and HR.search(sentence, m.end())
        if not h or h.start() - m.end() > 80:
            continue
        a, b = ratios._num(m.group(1))[0], ratios._num(m.group(2))[0]
        hr, lo, hi = (ratios._num(x)[0] for x in h.groups())
        if a == b or min(a, b, lo) <= 0 or not lo <= hr <= hi:
            continue
        yield far(a, b, hr, lo, hi), m.group(0), h.group(0), sentence


def scan(abstracts):
    rows, checked = [], 0
    for pmid, text in abstracts.items():
        for is_far, medians, hr, sentence in flags(text):
            checked += 1
            if is_far:
                rows.append({'pmid': pmid, 'medians': medians, 'hr': hr, 'sentence': sentence[:400]})
    return rows, checked


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, checked = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'compared': checked, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
