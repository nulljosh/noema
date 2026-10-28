"""A(n, d): the most binary words of length n whose pairwise Hamming distances are all at least d.

    python3 codes.py N D     # exact A(N, D) by exhaustive maximum-clique search, with a code that attains it

The words are the vertices of a graph joined when they are at least d apart; a code is a clique. The search fixes
the all-zero word (any code can be shifted to contain it) and keeps only one word of each weight-and-pattern class
up to coordinate order for the second word, then runs a branch and bound whose bound is a greedy colouring.
"""
import sys


def clique(adj, cand, size, best, bound):
    """Largest clique extending `size` vertices inside bitset `cand`; best is a one-item list [size, members]."""
    order, colours = [], []
    rest, c = cand, 0
    while rest:  # greedy colouring: each colour class is an independent set, so a clique uses one per colour
        c += 1
        q = rest
        while q:
            v = (q & -q).bit_length() - 1
            q &= ~adj[v] & ~(1 << v)
            rest &= ~(1 << v)
            order.append(v)
            colours.append(c)
    for i in range(len(order) - 1, -1, -1):
        if size + colours[i] <= best[0]:
            return
        v = order[i]
        bound.append(v)
        new = cand & adj[v]
        if new:
            clique(adj, new, size + 1, best, bound)
        elif size + 1 > best[0]:
            best[0], best[1] = size + 1, list(bound)
        bound.pop()
        cand &= ~(1 << v)


def A(n, d):
    words = range(1 << n)
    adj = [sum(1 << u for u in words if bin(u ^ v).count('1') >= d) for v in words]
    best = [1, [0]]
    for w in range(d, n + 1):  # second word, up to coordinate order: the first w coordinates set
        v = (1 << w) - 1
        bound = [0, v]
        cand = adj[0] & adj[v]
        if cand:
            clique(adj, cand, 2, best, bound)
        elif best[0] < 2:
            best[0], best[1] = 2, [0, v]
    return best[0], sorted(best[1])


if __name__ == '__main__':
    n, d = int(sys.argv[1]), int(sys.argv[2])
    size, code = A(n, d)
    print(size, ' '.join(format(c, '0%db' % n) for c in code))
