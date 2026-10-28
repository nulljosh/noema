"""Halting-time histogram of every n-state, m-symbol machine from blank, by a plain tree walk with no deciders.

    python3 runtimes.py 4    # 2 symbols, cap 107 (BB(4)); about a minute

Only the step cap cuts a branch, so the cap must be the proved Busy Beaver value. Same convention and weights as
halters.c (A004147, A386859): 2m(n+1) choices per entry, unreached entries counted, not built. It shares no code
with halters.c, so it is the second count behind the runtime spectrum.
"""
import sys

CAPS = {1: 1, 2: 6, 3: 21, 4: 107}  # BB(n) for 2 symbols, proved


def walk(n, m, cap):
    """{halting step: number of machines}."""
    opts, hist, stack = 2 * m * (n + 1), {}, [({}, 1)]
    while stack:
        mach, f = stack.pop()
        tape, pos, q, t = {}, 0, 0, 0
        while t < cap and (q, tape.get(pos, 0)) in mach:
            w, mv, q2 = mach[(q, tape.get(pos, 0))]
            tape[pos], pos, q, t = w, pos + mv, q2, t + 1
        if t == cap:
            continue
        s = tape.get(pos, 0)
        hist[t + 1] = hist.get(t + 1, 0) + f * 2 * m * opts ** (n * m - len(mach) - 1)
        k = 1 + max([x[2] for x in mach.values()] + [0])
        for w in range(m):
            for mv in ((1,) if not mach else (1, -1)):
                for x in range(min(k + 1, n)):
                    g = (n - k if x == k else 1) * (2 if not mach else 1)
                    stack.append(({**mach, (q, s): (w, mv, x)}, f * g))
    return hist


if __name__ == '__main__':
    n = int(sys.argv[1])
    h = walk(n, 2, CAPS[n])
    print('runtimes', len(h), 'halters', sum(h.values()), 'steps', sum(k * v for k, v in h.items()),
          'first missing', min(set(range(1, max(h) + 2)) - set(h)))
