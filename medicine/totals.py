"""Check that a sex split adds up to the total it splits.

    python3 totals.py CACHE_DIR        # every *.json of {pmid: abstract} in CACHE_DIR

"55 patients (22 males and 34 females)" adds to 56, more people than there are. A split that sums past its total is
impossible. One that falls short may be missing data or a third category, so a shortfall is listed apart and only
counted when the sentence names no other group.
"""
import glob
import json
import re
import sys

WHO = r'(?:patients|participants|subjects|women|men|children|adults|individuals|volunteers|infants|people|persons|cases)'
SEX = r'(men|males?|boys|women|females?|girls)'
SPLIT = re.compile(r'(?<![\d.,])(\d{2,5})\s+' + WHO + r'[^\d.;()\[\]]{0,30}?[(\[]\s*(\d{1,5})\s*(?:\([^)]*\)\s*)?' + SEX
                   + r'\s*(?:,|and|/|;)\s*(\d{1,5})\s*(?:\([^)]*\)\s*)?' + SEX, re.I)
OTHER = re.compile(r'unspecified|not specified|missing|gender-diverse|transgender|nonbinary|non-binary|other|undeclared|'
                   r'did not report|per group|in the intervention|in each', re.I)


def _male(word):
    return word.lower().startswith(('men', 'male', 'boy'))


def splits(text):
    """(total, first, second, kind, snippet) for each split that does not add up; kind is 'over' or 'short'."""
    t = ' '.join(text.split())
    for m in SPLIT.finditer(t):
        total, a, b = int(m.group(1)), int(m.group(2)), int(m.group(4))
        if _male(m.group(3)) == _male(m.group(5)) or a + b == total:
            continue
        snippet = t[max(0, m.start() - 40):m.end() + 40]
        if a + b < total and OTHER.search(snippet):
            continue
        yield total, a, b, 'over' if a + b > total else 'short', snippet


if __name__ == '__main__':
    abstracts = {}
    for path in sorted(glob.glob(sys.argv[1].rstrip('/') + '/*.json')):
        abstracts.update(json.load(open(path)))
    rows = [{'pmid': p, 'total': n, 'split': [a, b], 'kind': k, 'snippet': s}
            for p, text in abstracts.items() for n, a, b, k, s in splits(text)]
    checked = sum(1 for text in abstracts.values() for m in SPLIT.finditer(' '.join(text.split()))
                  if _male(m.group(3)) != _male(m.group(5)))
    print(json.dumps({'abstracts': len(abstracts), 'checked': checked, 'rows': rows}, indent=1, ensure_ascii=False))
