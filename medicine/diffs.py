"""Check differences against their own 95% confidence intervals and P values in trial abstracts.

    python3 diffs.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

The ratio checks in ratios.py, on the raw scale with null 0: "MD -2.3 (95% CI -4.1 to -0.5), P = 0.40" is a slip.
  inside   the estimate lies outside its own interval (a sign flipped against the whole interval is skipped);
  verdict  the interval clearly excludes 0 while P > 0.06, or clearly includes 0 while P < 0.04;
  pci      the printed P sits more than 10x below the P the interval gives (Altman and Bland 2011). Only below:
           t tests and exact tests on small trials give larger P than the normal curve, never smaller.
Medians, Hodges-Lehmann and non-inferiority sentences are skipped: their intervals need not be symmetric.
"""
import glob
import json
import re
import sys

import pvalues
import ratios

SNUM = r'(?<![\w.·])((?:[-−–]\s?)?\d*[.·]?\d+)'
DIFF = re.compile(r'(?<![\w-])((?i:mean differences?|differences?|risk difference|absolute risk difference)|MD|WMD|SMD|RD)'
                  r'(?![\w-])((?:(?!(?i:ratio|odds|hazard|between|versus|vs|errors?\b)|a?[HOR]R\b)[^\d;]){0,25}?)' + SNUM + r'\s*[^\d()\[\];]{0,20}?[(\[,;]?\s*95\s*%\s*(?:CI|confidence interval)'
                  r'[\s,:=]*' + SNUM + r'\s*%?\s*(?:-|–|−|to|,|;)\s*' + SNUM + r'(?!,\d|\s\d{3}\b|\s*×)')  # 1,725 and 11 494 are thousands
SKIP = re.compile(r'inferior|\bNI\b|one-sided|1-sided|equivalen|interaction|heterogeneity|median|hodges|bootstrap|trend|'
                  r'\bP\s+P\b', re.I)


def _num(text):
    value, tol = ratios._num(re.sub(r'^[-−–]\s?', '', text))
    return (-value if text[0] in '-−–' else value), tol


def flags(text):
    """(kind, name, estimate, low, high, operator, printed P, sentence) for each sharp mismatch."""
    for sentence in pvalues.SENTENCE.split(' '.join(text.split())):
        if SKIP.search(sentence):
            continue
        matches = list(DIFF.finditer(sentence))
        for i, m in enumerate(matches):
            if re.search(r'(?:ratio|\b[HOR]R)\W*$', sentence[max(0, m.start() - 12):m.start()]):
                continue  # "OR difference" is a ratio
            (est, te), (lo, tl), (hi, th) = _num(m.group(3)), _num(m.group(4)), _num(m.group(5))
            if lo > hi:
                continue
            row = (m.group(1), m.group(3), m.group(4), m.group(5))
            outside = lambda x: x < lo - tl - te or x > hi + th + te
            if outside(est):
                if not outside(-est) or not outside(est / 100):  # a flipped sign, or 14.1% against 0.042 to 0.235
                    continue
                yield ('inside',) + row + (None, None, sentence)
                continue
            stop = matches[i + 1].start() if i + 1 < len(matches) else len(sentence)
            p = pvalues.P_VALUE.search(sentence[m.end():stop])
            if p is None or p.start() > 40:
                continue
            if i + 1 < len(matches) and stop - (m.end() + p.end()) < 15:  # the next difference's P
                continue
            op, printed = p.group(1) or '=', p.group(2)
            value = pvalues._value(printed)[0]
            excludes = lo - tl > 0 or hi + th < 0
            includes = lo + tl < 0 < hi - th
            says_big = (op == '=' and value > 0.06) or (op in ('>', '≥', '>=') and value >= 0.05)
            says_small = (op == '=' and value < 0.04) or (op in ('<', '≤', '<=') and value <= 0.04)
            if (excludes and says_big) or (includes and says_small):
                yield ('verdict',) + row + (op, printed, sentence)
            elif not ratios._p_fits(op, printed, est, te, lo, tl, hi, th, log=False, too_big=False):
                yield ('pci',) + row + (op, printed, sentence)


def scan(abstracts):
    rows, count = [], 0
    for pmid, text in abstracts.items():
        count += len(DIFF.findall(text))
        for f in flags(text):
            rows.append({'pmid': pmid, 'kind': f[0], 'name': f[1], 'estimate': f[2], 'ci': [f[3], f[4]],
                         'printed_p': None if f[5] is None else f[5] + ' ' + f[6], 'sentence': f[7][:400]})
    return rows, count


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows, count = scan(abstracts)
    print(json.dumps({'abstracts': len(abstracts), 'differences_with_ci': count, 'flags': len(rows), 'rows': rows},
                     indent=1, ensure_ascii=False))
