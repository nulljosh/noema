"""Alkane structural isomers C_nH_{2n+2}, counted two ways and checked against OEIS A000602.

Method 1 (exact): rooted alkyl counts from Polya's cycle index, then the centroid formula
for unrooted trees whose maximum degree is 4. Python ints throughout.
Method 2 (brute force): grow trees one leaf at a time and keep one AHU string per class.
"""
import json
import os
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
REFERENCE = os.path.join(HERE, 'benchmarks', 'A000602-b-0-100.txt')
LATEST = os.path.join(HERE, 'benchmarks', 'alkanes-latest.json')
FORMULA_MAX_N = 100
BRUTE_MAX_N = 12
TABLE_MAX_N = 40


def _mul(p, q, deg):
    """Product of two coefficient lists, truncated to degree deg."""
    out = [0] * (deg + 1)
    for i, a in enumerate(p[:deg + 1]):
        if a:
            for j, b in enumerate(q[:deg + 1 - i]):
                out[i + j] += a * b
    return out


def _spread(p, k, deg):
    """p(x^k), truncated to degree deg."""
    out = [0] * (deg + 1)
    for i, c in enumerate(p):
        if i * k > deg:
            break
        out[i * k] = c
    return out


def _divide_exact(total, d):
    quotient, remainder = divmod(total, d)
    if remainder:
        raise ArithmeticError('cycle index sum is not divisible by %d' % d)
    return quotient


def slot_series(limit):
    """b[0..limit] with b[0] = 1 (an empty slot) and b[k] = rooted alkyl groups with k carbons
    (OEIS A000598), where every carbon in the group has at most three children.

    Pólya: the root's children form a multiset of exactly three slots, so the cycle index of
    the symmetric group S3 gives (B^3 + 3 B B(x^2) + 2 B(x^3)) / 6."""
    b = [1] + [0] * limit
    for m in range(1, limit + 1):
        d = m - 1
        cube = _mul(_mul(b, b, d), b, d)
        cross = _mul(b, _spread(b, 2, d), d)
        total = cube[d] + 3 * cross[d] + 2 * _spread(b, 3, d)[d]
        b[m] = _divide_exact(total, 6)
    return b


def alkane_counts(limit):
    """Dict n -> number of alkane isomers C_nH_{2n+2}, for n = 1..limit.

    Every tree has a centroid: a node whose branches each hold at most half the nodes.
    One centroid: root there, with at most four branches of at most (n-1)//2 nodes each.
    Two adjacent centroids (n even): an edge cutting the tree into two halves of n/2 nodes,
    an unordered pair of rooted alkyls, which is a(a+1)/2 with a = A000598(n/2)."""
    b = slot_series(limit)
    counts = {}
    for n in range(1, limit + 1):
        deg = n - 1
        half = (n - 1) // 2
        t = [b[k] if k <= half else 0 for k in range(deg + 1)]
        t2 = _mul(t, t, deg)
        t4 = _mul(t2, t2, deg)
        s2 = _spread(t, 2, deg)
        s3 = _spread(t, 3, deg)
        s4 = _spread(t, 4, deg)
        unicentroid = _divide_exact(
            t4[deg]
            + 6 * _mul(t2, s2, deg)[deg]
            + 3 * _mul(s2, s2, deg)[deg]
            + 8 * _mul(t, s3, deg)[deg]
            + 6 * s4[deg],
            24,
        )
        bicentroid = 0
        if n % 2 == 0:
            a = b[n // 2]
            bicentroid = a * (a + 1) // 2
        counts[n] = unicentroid + bicentroid
    return counts


def canonical(adj):
    """AHU string of an unlabeled tree, rooted at its centre (the smaller one if there are two)."""
    n = len(adj)
    deg = [len(a) for a in adj]
    removed = [False] * n
    layer = [v for v in range(n) if deg[v] <= 1]
    remaining = n
    while remaining > 2:
        remaining -= len(layer)
        nxt = []
        for v in layer:
            removed[v] = True
            for u in adj[v]:
                if not removed[u]:
                    deg[u] -= 1
                    if deg[u] == 1:
                        nxt.append(u)
        layer = nxt
    centres = [v for v in range(n) if not removed[v]]

    def encode(v, parent):
        return '(' + ''.join(sorted(encode(u, v) for u in adj[v] if u != parent)) + ')'

    return min(encode(c, -1) for c in centres)


def brute_force(n):
    """Count trees with n nodes and maximum degree 4 by adding a leaf to every node of degree
    below 4 in each tree of size n-1. Removing a leaf never raises a degree, so this reaches
    every tree; the canonical AHU string removes duplicates."""
    trees = {canonical([[]]): [[]]}
    for size in range(2, n + 1):
        grown = {}
        for adj in trees.values():
            for v in range(size - 1):
                if len(adj[v]) < 4:
                    new = [list(a) for a in adj] + [[v]]
                    new[v].append(size - 1)
                    grown.setdefault(canonical(new), new)
        trees = grown
    return len(trees)


def load_reference(path=REFERENCE):
    """OEIS b-file rows as a dict n -> a(n)."""
    ref = {}
    with open(path) as f:
        for line in f:
            parts = line.split()
            if len(parts) == 2:
                ref[int(parts[0])] = int(parts[1])
    return ref


def main():
    ref = load_reference()
    started = time.monotonic()
    counts = alkane_counts(FORMULA_MAX_N)
    formula_seconds = time.monotonic() - started

    started = time.monotonic()
    brute = {n: brute_force(n) for n in range(1, BRUTE_MAX_N + 1)}
    brute_seconds = time.monotonic() - started

    rows = []
    for n in range(1, FORMULA_MAX_N + 1):
        row = {'n': n, 'formula': str(counts[n]), 'oeis': str(ref[n]),
               'match_oeis': counts[n] == ref[n], 'brute': None, 'match_brute': None}
        if n in brute:
            row['brute'] = str(brute[n])
            row['match_brute'] = brute[n] == counts[n]
        rows.append(row)

    print('%4s %12s %12s %6s %8s' % ('n', 'formula', 'OEIS', 'match', 'brute'))
    for row in rows[:TABLE_MAX_N]:
        brute_cell = row['brute'] if row['brute'] is not None else '-'
        print('%4d %12s %12s %6s %8s' % (row['n'], row['formula'], row['oeis'],
                                         'yes' if row['match_oeis'] else 'NO', brute_cell))
    last = rows[-1]
    print('n=%d: %s (%s)' % (last['n'], last['formula'],
                             'matches OEIS' if last['match_oeis'] else 'DOES NOT match OEIS'))

    all_oeis = all(row['match_oeis'] for row in rows)
    all_brute = all(row['match_brute'] for row in rows if row['match_brute'] is not None)
    print('formula vs OEIS A000602, n = 1..%d: %s' % (FORMULA_MAX_N, 'all match' if all_oeis else 'MISMATCH'))
    print('brute force vs formula, n = 1..%d: %s' % (BRUTE_MAX_N, 'all match' if all_brute else 'MISMATCH'))
    print('seconds: formula %.2f, brute force %.2f' % (formula_seconds, brute_seconds))

    os.makedirs(os.path.dirname(LATEST), exist_ok=True)
    report = {
        'sequence': 'A000602',
        'reference': 'benchmarks/A000602-b-0-100.txt (rows 0 to 100 of https://oeis.org/A000602/b000602.txt)',
        'formula_max_n': FORMULA_MAX_N,
        'brute_max_n': BRUTE_MAX_N,
        'all_match_oeis': all_oeis,
        'all_brute_match_formula': all_brute,
        'seconds': {'formula': round(formula_seconds, 3), 'brute': round(brute_seconds, 3)},
        'rows': rows,
    }
    with open(LATEST, 'w') as f:
        json.dump(report, f, indent=1)
        f.write('\n')
    print('wrote %s' % LATEST)
    return 0 if all_oeis and all_brute else 1


if __name__ == '__main__':
    sys.exit(main())
