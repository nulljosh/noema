"""Fewest comparators that sort n inputs, by breadth-first search over output sets.

    python3 sortnet.py 7

By the 0-1 principle a comparator network sorts every input if it sorts every 0-1 vector. So the state after k
comparators is the set of 0-1 vectors it can output, kept as a bitmask over the 2^n vectors. Layer k holds every
distinct set reachable with k comparators (a comparator that changes nothing is skipped); the answer is the first
layer holding a set of sorted vectors only. Checked against OEIS A003075.
"""
import sys


def size(n):
    """(minimum comparators, distinct output sets per layer)."""
    N = 1 << n
    maps = [[v ^ (1 << i | 1 << j) if v >> i & 1 and not v >> j & 1 else v for v in range(N)]
            for i in range(n) for j in range(i + 1, n)]  # min to channel i, max to channel j
    ok = sum(1 << (N - 1 ^ (1 << k) - 1) for k in range(n + 1))  # k zeros, then ones
    layer, widths = {(1 << N) - 1}, []
    while not any(s & ~ok == 0 for s in layer):
        nxt = set()
        for s in layer:
            vs = [v for v in range(N) if s >> v & 1]
            for m in maps:
                t = 0
                for v in vs:
                    t |= 1 << m[v]
                if t != s:
                    nxt.add(t)
        layer = nxt
        widths.append(len(layer))
    return len(widths), widths


if __name__ == '__main__':
    k, widths = size(int(sys.argv[1]))
    print(k, widths)
