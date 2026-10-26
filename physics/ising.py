"""Exact 2D Ising model on small periodic L x L lattices. Stdlib only.

g[k] counts spin configurations with exactly k unsatisfied bonds (2N bonds, N = L*L),
so Z(K) = sum_k g[k] * exp(K * (2N - 2k)). Counted exactly by a row transfer matrix,
checked against brute force (L <= 4) and Kaufman's 1949 closed form.

    python3 ising.py        # L = 2..8, writes benchmarks/ising-latest.json
    python3 ising.py 9      # one size, not saved
    python3 ising.py tri 12 # antiferromagnet ground states on triangular tori up to 12x12
"""
import json
import math
import sys
import time
from pathlib import Path

ONSAGER_TC = 2 / math.log(1 + math.sqrt(2))  # 2.269185...


def _pop(x):
    return bin(x).count("1")


def density_of_states(L, triangular=False):
    """Exact g[k], k = 0..2N (0..3N on the triangular lattice), via a row transfer matrix.

    Each polynomial in k is packed into one big int, B bits per coefficient
    (every coefficient is below 2^N), so shifting k is a shift and summing is +.
    """
    N, S = L * L, 1 << L
    B, full = N + 1, S - 1
    rot = lambda s: ((s << 1) | (s >> (L - 1))) & full
    h = [_pop(s ^ rot(s)) for s in range(S)]  # bonds inside one row, wrap included
    # bonds between rows: straight down, plus one diagonal per site on the triangular lattice
    between = (lambda s, t: _pop(s ^ t) + _pop(s ^ rot(t))) if triangular else (lambda s, t: _pop(s ^ t))
    K = 2 * L if triangular else L
    by_dist = [[[s for s in range(S) if between(s, t) == k] for k in range(K + 1)] for t in range(S)]
    # T commutes with row rotation and global flip, so the trace term is the same on each orbit
    orbit = {}
    for s0 in range(S):
        r, rep = s0, s0
        for _ in range(L):
            r = rot(r)
            rep = min(rep, r, r ^ full)
        orbit[rep] = orbit.get(rep, 0) + 1
    total = 0
    for s0, mult in orbit.items():
        V = [0] * S
        V[s0] = 1 << (B * h[s0])
        for _ in range(L - 1):
            V = [sum((sum(V[s] for s in group) << (B * (k + h[t])) for k, group in enumerate(by_dist[t]))) for t in range(S)]
        total += mult * sum(V[s] << (B * between(s, s0)) for s in range(S))
    mask = (1 << B) - 1
    return [(total >> (B * k)) & mask for k in range((3 if triangular else 2) * N + 1)]


def brute_force(L):
    """g[k] by enumerating all 2^N states. Only for L <= 4."""
    N = L * L
    g = [0] * (2 * N + 1)
    for x in range(1 << N):
        bad = 0
        for i in range(N):
            r, c = divmod(i, L)
            me = (x >> i) & 1
            bad += me != (x >> (r * L + (c + 1) % L)) & 1
            bad += me != (x >> (((r + 1) % L) * L + c)) & 1
        g[bad] += 1
    return g


def brute_force_triangular(L):
    """Triangular-lattice g[k] by listing all 2^N states. Only for L <= 4."""
    N = L * L
    g = [0] * (3 * N + 1)
    for x in range(1 << N):
        bad = 0
        for i in range(N):
            r, c = divmod(i, L)
            me = (x >> i) & 1
            for j in (r * L + (c + 1) % L, ((r + 1) % L) * L + c, ((r + 1) % L) * L + (c + 1) % L):
                bad += me != (x >> j) & 1
        g[bad] += 1
    return g


def log_z(g, K):
    N2 = len(g) - 1
    terms = [math.log(c) + K * (N2 - 2 * k) for k, c in enumerate(g) if c]
    m = max(terms)
    return m + math.log(sum(math.exp(t - m) for t in terms))


def kaufman_log_z(L, K):
    """Kaufman (1949) exact Z for an L x L torus, as log Z. Independent of g."""
    n = m = L
    c = math.cosh(2 * K) / math.tanh(2 * K)

    def gamma(l):
        if l == 0:
            return 2 * K + math.log(math.tanh(K))  # signed: negative below Tc, arccosh would lose that
        return math.acosh(c - math.cos(math.pi * l / n))

    odd = [gamma(2 * r + 1) for r in range(n)]
    even = [gamma(2 * r) for r in range(n)]
    z1 = math.prod(2 * math.cosh(m * x / 2) for x in odd)
    z2 = math.prod(2 * math.sinh(m * x / 2) for x in odd)
    z3 = math.prod(2 * math.cosh(m * x / 2) for x in even)
    z4 = math.prod(2 * math.sinh(m * x / 2) for x in even)
    return math.log(0.5) + (m * n / 2) * math.log(2 * math.sinh(2 * K)) + math.log(z1 + z2 + z3 + z4)


def specific_heat_peak(g, lo=1.5, hi=3.5, steps=2001):
    """Temperature (J = k_B = 1) where C per spin peaks, on a grid of step 0.001."""
    N2 = len(g) - 1
    E = [-(N2 - 2 * k) for k in range(len(g))]
    live = [(math.log(c), e) for c, e in zip(g, E) if c]
    best = (0.0, 0.0)
    for i in range(steps):
        T = lo + (hi - lo) * i / (steps - 1)
        K = 1 / T
        lw = [lc - K * e for lc, e in live]
        mx = max(lw)
        w = [math.exp(x - mx) for x in lw]
        Z = sum(w)
        e1 = sum(wi * e for wi, (_, e) in zip(w, live)) / Z
        e2 = sum(wi * e * e for wi, (_, e) in zip(w, live)) / Z
        C = K * K * (e2 - e1 * e1) / (N2 // 2)
        if C > best[1]:
            best = (T, C)
    return best


def study(sizes):
    rows = []
    for L in sizes:
        t = time.time()
        g = density_of_states(L)
        secs = round(time.time() - t, 2)
        assert sum(g) == 2 ** (L * L)
        Tpk, Cpk = specific_heat_peak(g)
        err = max(abs(log_z(g, K) - kaufman_log_z(L, K)) / log_z(g, K) for K in (0.3, 0.6))
        rows.append({"L": L, "states": 2 ** (L * L), "seconds": secs, "kaufman_rel_err": err,
                     "c_peak_T": round(Tpk, 3), "c_peak": round(Cpk, 4), "g_nonzero": [c for c in g if c]})
        print(f"L={L}  2^{L*L} states  C peak at T={Tpk:.3f} (Onsager {ONSAGER_TC:.3f})  Kaufman err {err:.1e}  {secs}s")
    return rows


def triangular_ground_states(L):
    """Antiferromagnet on the triangular torus: ground states are the states with the most unlike bonds."""
    g = density_of_states(L, triangular=True)
    k = max(i for i, c in enumerate(g) if c)
    return k, g[k]


def no_mono_triangle_count(L):
    """The same ground states counted a second way: every triangle has exactly one like bond
    exactly when no triangle has all three spins equal, so count 2-colourings of the triangular
    torus with no one-colour triangle. A 0/1 row transfer, much faster than the full polynomial."""
    S, full = 1 << L, (1 << L) - 1
    rot = lambda s: ((s << 1) | (s >> (L - 1))) & full

    def ok(s, t):  # triangles {s_i, t_i, t_(i-1)} and {s_i, s_(i-1), t_(i-1)}, matching density_of_states
        rt, rs = rot(t), rot(s)
        return not ((~(s ^ t) & ~(t ^ rt)) | (~(s ^ rs) & ~(rs ^ rt))) & full

    nxt = [[t for t in range(S) if ok(s, t)] for s in range(S)]
    orbit = {}
    for s0 in range(S):
        r, rep = s0, s0
        for _ in range(L):
            r = rot(r)
            rep = min(rep, r, r ^ full)
        orbit[rep] = orbit.get(rep, 0) + 1
    total = 0
    for s0, mult in orbit.items():
        V = {s0: 1}
        for _ in range(L - 1):
            W = {}
            for s, c in V.items():
                for t in nxt[s]:
                    W[t] = W.get(t, 0) + c
            V = W
        total += mult * sum(c for s, c in V.items() if ok(s, s0))
    return total


if __name__ == "__main__":
    if sys.argv[1:2] == ["tri"]:
        for L in range(2, int(sys.argv[2]) + 1 if sys.argv[2:] else 9):
            count = no_mono_triangle_count(L)
            print(f"L={L}  ground states {count}  entropy per spin {math.log(count) / (L * L):.5f} (Wannier 0.33831)", flush=True)
        raise SystemExit
    sizes = [int(a) for a in sys.argv[1:]] or list(range(2, 9))
    rows = study(sizes)
    if not sys.argv[1:]:
        out = Path(__file__).parent / "benchmarks" / "ising-latest.json"
        out.parent.mkdir(exist_ok=True)
        out.write_text(json.dumps({"onsager_tc": ONSAGER_TC, "sizes": rows}, indent=1) + "\n")
