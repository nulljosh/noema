"""Step 4 of the TRIANGULAR.md proof, checked by brute force.

The proof says det K(s, t) is a signed, weighted sum over the perfect matchings of the honeycomb torus,
and that with s, t = +-1 the weight of a matching is s^p t^q for its crossing parity class (p, q). Four
determinants then invert to the four class counts, and a(n) = 2 N(n mod 2, n mod 2).

Nothing here uses the closed form. Matchings are enumerated one by one and classified directly, so an
error in the cycle-sign argument shows up as a disagreement.

    python3 torus_check.py [N=4]
"""
import itertools
import sys

from ising import _det, _torus_product, no_mono_triangle_count


def triangles(n):
    """The 2 n^2 triangles of the n x n triangular torus, up triangles first, as (kind, r, c)."""
    return [(k, r, c) for k in (0, 1) for r in range(n) for c in range(n)]


def bonds(n):
    """Each bond of the triangular lattice as (up triangle, down triangle, crosses_row, crosses_col).

    A bond is an edge of the dual honeycomb graph. U(r, c) meets D(r, c) by its diagonal, D(r-1, c) by
    its horizontal bond, and D(r, c-1) by its vertical bond, exactly as the proof sets it up. The two
    flags say whether the bond lies on the row-0 or column-0 cut, which is what the crossing parities count.
    """
    out = []
    for r in range(n):
        for c in range(n):
            out.append(((0, r, c), (1, r, c), 0, 0))                      # diagonal, crosses neither
            out.append(((0, r, c), (1, (r - 1) % n, c), r == 0, 0))       # horizontal, on the row cut
            out.append(((0, r, c), (1, r, (c - 1) % n), 0, c == 0))       # vertical, on the column cut
    return out


def matchings(n):
    """Every perfect matching of the dual honeycomb torus, as a list of bond indices."""
    es, ups = bonds(n), [t for t in triangles(n) if t[0] == 0]
    at = {}
    for i, (u, d, _, _) in enumerate(es):
        at.setdefault(u, []).append(i)
    out, used = [], set()

    def walk(k, picked):
        if k == len(ups):
            out.append(list(picked))
            return
        for i in at[ups[k]]:
            d = es[i][1]
            if d in used:
                continue
            used.add(d); picked.append(i)
            walk(k + 1, picked)
            picked.pop(); used.remove(d)

    walk(0, [])
    return out


def classes(n):
    """{(row parity, column parity): how many matchings}, by direct enumeration."""
    es, out = bonds(n), {}
    for m in matchings(n):
        p = sum(es[i][2] for i in m) % 2, sum(es[i][3] for i in m) % 2
        out[p] = out.get(p, 0) + 1
    return out


def from_determinants(n):
    """The same four class counts, read off the four P(s, t) the proof uses."""
    P = {(s, t): _torus_product(n, s, t) for s in (1, -1) for t in (1, -1)}
    sign = (-1) ** n  # det K(1, 1) is (-1)^n times the all-plus count, per step 4
    return {(p, q): sign * sum(P[(s, t)] * s ** p * t ** q for s in (1, -1) for t in (1, -1)) // 4
            for p in (0, 1) for q in (0, 1)}


def check(n):
    direct, det = classes(n), from_determinants(n)
    a = 2 * direct[(n % 2, n % 2)]
    return direct, det, a, no_mono_triangle_count(n)


if __name__ == '__main__':
    for n in range(2, int(sys.argv[1]) if sys.argv[1:] else 5):
        direct, det, a, counted = check(n)
        agree = all(abs(det[k]) == direct.get(k, 0) for k in direct)
        print('n=%d  classes %s' % (n, dict(sorted(direct.items()))))
        print('      determinants %s  %s' % (dict(sorted(det.items())), 'agree' if agree else 'DISAGREE'))
        print('      2 x N(%d,%d) = %d, transfer-matrix count %d  %s'
              % (n % 2, n % 2, a, counted, 'ok' if a == counted else 'MISMATCH'))
