"""Two small finite studies. Domain and rejection rule are stated in each function.

Pigeonhole: n + 1 pigeons do not fit in n holes. Each formula is unsatisfiable, so a solver has to
prove it, and DPLL with unit propagation shows how the search grows. Exhaustive checking of every
assignment confirms the verdict wherever that is feasible.

Prime gaps: the largest gap between consecutive primes inside disjoint windows, with both endpoints
proved prime and everything between them proved composite by trial division.
"""
import json
import math
import os
from itertools import product

HERE = os.path.dirname(os.path.abspath(__file__))
LATEST = os.path.join(HERE, 'benchmarks', 'tiny-latest.json')
MAX_HOLES = 6
EXHAUSTIVE_MAX_HOLES = 3
WINDOW = 90000
WINDOW_STARTS = (1000, 100000, 1000000, 10000000, 100000000)  # disjoint on purpose


def pigeonhole(holes):
    """(variable count, clauses). Variable (p * holes + h + 1): pigeon p sits in hole h."""
    pigeons = holes + 1
    var = lambda p, h: p * holes + h + 1
    clauses = [[var(p, h) for h in range(holes)] for p in range(pigeons)]
    for h in range(holes):
        for a in range(pigeons):
            for b in range(a + 1, pigeons):
                clauses.append([-var(a, h), -var(b, h)])
    return pigeons * holes, clauses


def dpll(clauses, pick=lambda current: current[0][0]):
    """(satisfiable, search nodes). By default branches on the first literal left after unit propagation."""
    nodes = [0]

    def solve(current):
        nodes[0] += 1
        while True:
            if any(not c for c in current):
                return False
            if not current:
                return True
            unit = next((c[0] for c in current if len(c) == 1), None)
            if unit is None:
                break
            current = [[x for x in c if x != -unit] for c in current if unit not in c]
        literal = pick(current)
        for choice in (literal, -literal):
            if solve([[x for x in c if x != -choice] for c in current if choice not in c]):
                return True
        return False

    return solve([list(c) for c in clauses]), nodes[0]


def exhaustive_sat(variables, clauses):
    return any(all(any(bits[abs(x) - 1] == (x > 0) for x in c) for c in clauses)
               for bits in product((False, True), repeat=variables))


def is_prime(n):
    return n >= 2 and all(n % d for d in range(2, math.isqrt(n) + 1))


def primes_between(lo, hi):
    """Primes in [lo, hi) by a segmented sieve."""
    base = bytearray(b'\x01') * (math.isqrt(hi) + 1)
    base[0:2] = b'\x00\x00'
    small = []
    for p in range(2, len(base)):
        if base[p]:
            small.append(p)
            base[p * p::p] = bytes(len(base[p * p::p]))
    seg = bytearray(b'\x01') * (hi - lo)
    for p in small:
        start = max(p * p, (lo + p - 1) // p * p)
        seg[start - lo::p] = bytes(len(seg[start - lo::p]))
    return [lo + i for i, alive in enumerate(seg) if alive and lo + i >= 2]


def largest_gap(lo, hi):
    """{start, end, gap} for the largest gap with both primes in [lo, hi), the earliest if tied.
    Rejected unless trial division proves both ends prime and every number between composite."""
    primes = primes_between(lo, hi)
    start, end = max(zip(primes, primes[1:]), key=lambda pair: (pair[1] - pair[0], -pair[0]))
    if not (is_prime(start) and is_prime(end)) or any(is_prime(k) for k in range(start + 1, end)):
        raise ArithmeticError('endpoint check failed at %d' % start)
    return {'start': start, 'end': end, 'gap': end - start}


def main():
    rows = []
    for holes in range(1, MAX_HOLES + 1):
        variables, clauses = pigeonhole(holes)
        sat, nodes = dpll(clauses)
        row = {'holes': holes, 'variables': variables, 'clauses': len(clauses), 'sat': sat, 'dpll_nodes': nodes}
        if holes <= EXHAUSTIVE_MAX_HOLES:
            row['exhaustive_sat'] = exhaustive_sat(variables, clauses)
        rows.append(row)
    gaps = [{'window': [lo, lo + WINDOW], **largest_gap(lo, lo + WINDOW)} for lo in WINDOW_STARTS]
    result = {'pigeonhole': rows, 'prime_gaps': gaps}
    with open(LATEST, 'w') as f:
        json.dump(result, f, indent=1)
        f.write('\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
