"""Sorting networks: check the best known networks for 8 and 9 inputs, and prove small optimal sizes by search.

A comparator network sorts every input if and only if it sorts every 0/1 input (the 0-1 principle), so checking
2^n bit patterns is a complete proof that a network sorts. Minimality is proved by generate and prune: grow every
network one comparator at a time, keep only the set of outputs it can still produce, and drop a candidate whose
output set is, up to a relabelling of channels, a superset of another's (it can never finish sooner).
"""
from itertools import permutations

# Batcher's odd-even merge sort for 8 inputs: 19 comparators, the proven minimum for n = 8.
N8 = [(0, 1), (2, 3), (4, 5), (6, 7), (0, 2), (1, 3), (4, 6), (5, 7), (1, 2), (5, 6), (0, 4), (1, 5), (2, 6), (3, 7),
      (2, 4), (3, 5), (1, 2), (3, 4), (5, 6)]
# A 25-comparator network for 9 inputs, the proven minimum for n = 9.
N9 = [(0, 3), (1, 7), (2, 5), (4, 8), (0, 7), (2, 4), (3, 8), (5, 6), (0, 2), (1, 3), (4, 5), (7, 8), (1, 4), (3, 6),
      (5, 7), (0, 1), (2, 4), (3, 5), (6, 8), (2, 3), (4, 5), (6, 7), (1, 2), (3, 4), (5, 6)]


def apply(net, bits):
    for i, j in net:
        a, b = bits >> i & 1, bits >> j & 1
        if a > b:  # put the 0 on channel i, the 1 on channel j
            bits ^= (1 << i) | (1 << j)
    return bits


def is_sorted(bits, n):
    ones = bin(bits).count("1")
    return bits == ((1 << n) - 1) ^ ((1 << (n - ones)) - 1)  # ones packed into the top channels


def sorts(net, n):
    """0-1 principle: True exactly when the network sorts every input of n values."""
    return all(is_sorted(apply(net, b), n) for b in range(1 << n))


def outputs(net, n):
    return frozenset(apply(net, b) for b in range(1 << n))


def _permute(bits, p):
    return sum(1 << p[i] for i in range(len(p)) if bits >> i & 1)


def _subsumes(a, b, perms):
    """a can do no better than b: some relabelling maps b's outputs into a's (|b| <= |a|)."""
    return len(b) <= len(a) and any(all(_permute(x, p) in a for x in b) for p in perms)


def optimal_size(n, limit=20):
    """Smallest comparator count that sorts n inputs, by generate and prune. Practical for n <= 5 in plain Python."""
    comps = [(i, j) for i in range(n) for j in range(i + 1, n)]
    perms = list(permutations(range(n)))
    layer = [frozenset(range(1 << n))]
    target = n + 1  # a sorted output set has exactly n + 1 patterns
    for size in range(limit + 1):
        if any(len(o) == target for o in layer):
            return size
        grown = {frozenset(apply([c], x) for x in o) for o in layer for c in comps}
        grown = sorted(grown, key=len)
        kept = []
        for o in grown:  # drop any set that subsumes a set we already kept
            if not any(_subsumes(o, k, perms) for k in kept):
                kept.append(o)
        layer = kept
    return None


if __name__ == "__main__":
    print(f"n=8: {len(N8)} comparators, sorts all 256 inputs: {sorts(N8, 8)}")
    print(f"n=9: {len(N9)} comparators, sorts all 512 inputs: {sorts(N9, 9)}")
    for n in range(2, 6):
        print(f"optimal size for n={n}: {optimal_size(n)}")
