"""Alcohols C_nH_{2n+1}OH: structural (OEIS A000598) and stereo (A000625) counts, two ways each,
plus stereo alkanes (A000628) by the same rotations and a centroid formula.

An alcohol is an alkyl group rooted at the carbon holding the OH, so every carbon has three
child slots. Structural isomers ignore how the slots are arranged (the symmetric group S3).
Stereoisomers keep the handedness of each carbon, so only rotations count (the cyclic group C3).

Method 1 (exact): Polya's cycle index for S3 or C3. Python ints throughout.
Method 2 (brute force): build every tree from smaller ones and keep one canonical form per class.
"""
import json
import os
import time

from alkanes import _divide_exact, _mul, _spread, load_reference, slot_series

HERE = os.path.dirname(os.path.abspath(__file__))
STRUCTURAL_REFERENCE = os.path.join(HERE, 'benchmarks', 'A000598-b-0-100.txt')
STEREO_REFERENCE = os.path.join(HERE, 'benchmarks', 'A000625-b-0-100.txt')
STEREO_ALKANE_REFERENCE = os.path.join(HERE, 'benchmarks', 'A000628-b-0-100.txt')
LATEST = os.path.join(HERE, 'benchmarks', 'alcohols-latest.json')
FORMULA_MAX_N = 100
BRUTE_MAX_N = 12


def stereo_series(limit):
    """c[0..limit], c[0] = 1 for an empty slot. The three slots only rotate, so the cycle index
    of C3 gives (C^3 + 2 C(x^3)) / 3."""
    c = [1] + [0] * limit
    for m in range(1, limit + 1):
        d = m - 1
        cube = _mul(_mul(c, c, d), c, d)
        c[m] = _divide_exact(cube[d] + 2 * _spread(c, 3, d)[d], 3)
    return c


def stereo_alkanes(limit):
    """[n] -> alkanes C_nH_{2n+2} counting stereoisomers, n = 0..limit, with a[0] = 1 as OEIS has it.

    One centroid: four branches of at most (n-1)//2 carbons, where only the alternating group A4
    acts, so (T^4 + 3 T(x^2)^2 + 8 T T(x^3)) / 12. Two centroids: an unordered pair of halves."""
    c = stereo_series(limit)
    counts = [1] + [0] * limit
    for n in range(1, limit + 1):
        deg = n - 1
        half = (n - 1) // 2
        t = [c[k] if k <= half else 0 for k in range(deg + 1)]
        t2 = _mul(t, t, deg)
        s2 = _spread(t, 2, deg)
        s3 = _spread(t, 3, deg)
        total = _mul(t2, t2, deg)[deg] + 3 * _mul(s2, s2, deg)[deg] + 8 * _mul(t, s3, deg)[deg]
        counts[n] = _divide_exact(total, 12)
        if n % 2 == 0:
            a = c[n // 2]
            counts[n] += a * (a + 1) // 2
    return counts


def _rotation_form(a, b, c):
    return min((a, b, c), (b, c, a), (c, a, b))


def _sorted_form(a, b, c):
    return tuple(sorted((a, b, c)))


def brute_force(limit, stereo):
    """Counts for n = 0..limit from explicit trees, one canonical nested tuple per class."""
    form = _rotation_form if stereo else _sorted_form
    trees = {0: {()}}
    for n in range(1, limit + 1):
        found = set()
        for i in range(n):
            for j in range(n - i):
                k = n - 1 - i - j
                for a in trees[i]:
                    for b in trees[j]:
                        for c in trees[k]:
                            found.add(form(a, b, c))
        trees[n] = found
    return [len(trees[n]) for n in range(limit + 1)]


def main():
    started = time.time()
    structural = slot_series(FORMULA_MAX_N)
    stereo = stereo_series(FORMULA_MAX_N)
    alkanes = stereo_alkanes(FORMULA_MAX_N)
    for series, path, name in ((structural, STRUCTURAL_REFERENCE, 'A000598'), (stereo, STEREO_REFERENCE, 'A000625'), (alkanes, STEREO_ALKANE_REFERENCE, 'A000628')):
        ref = load_reference(path)
        wrong = [n for n in ref if n <= FORMULA_MAX_N and series[n] != ref[n]]
        if wrong:
            raise SystemExit('%s disagrees at n = %s' % (name, wrong[:5]))
    brute_structural = brute_force(BRUTE_MAX_N, False)
    brute_stereo = brute_force(BRUTE_MAX_N, True)
    if brute_structural != structural[:BRUTE_MAX_N + 1] or brute_stereo != stereo[:BRUTE_MAX_N + 1]:
        raise SystemExit('brute force disagrees with the formula')
    result = {
        'formula_checked_to': FORMULA_MAX_N,
        'brute_force_checked_to': BRUTE_MAX_N,
        'structural_A000598': structural[:21],
        'stereo_A000625': stereo[:21],
        'stereo_alkanes_A000628': alkanes[:21],
        'stereo_over_structural_at_100': round(stereo[100] / structural[100], 3),
    }
    with open(LATEST, 'w') as f:
        json.dump(result, f, indent=1)
        f.write('\n')
    print(json.dumps(result)[:300])
    print('agrees with every b-file (A000598 and A000625 to n = %d, A000628 to its 38 terms), brute force to n = %d, in %.1f s'
          % (FORMULA_MAX_N, BRUTE_MAX_N, time.time() - started))


if __name__ == '__main__':
    main()
