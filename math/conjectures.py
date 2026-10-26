"""Small, bounded number-theory studies. No universal-proof claims."""
from datetime import datetime, timezone
import hashlib
import json
from math import isqrt
from pathlib import Path

from mathlab import ROOT, atomic_write


def primes_up_to(limit):
    if type(limit) is not int or not 2 <= limit <= 10000:
        raise ValueError('Prime-study limit must be an integer from 2 through 10000.')
    sieve = bytearray(b'\x01') * (limit + 1)
    sieve[0:2] = b'\x00\x00'
    for p in range(2, isqrt(limit) + 1):
        if sieve[p]:
            for multiple in range(p * p, limit + 1, p):
                sieve[multiple] = 0
    return [p for p in range(2, limit + 1) if sieve[p]]


def trial_prime(n):
    return n >= 2 and all(n % d for d in range(2, isqrt(n) + 1))


def collatz(start, max_steps=1000):
    if type(start) is not int or start < 1 or type(max_steps) is not int or not 0 <= max_steps <= 1000:
        raise ValueError('Use a positive integer start and a step cap from zero through 1000.')
    n, peak, steps = start, start, 0
    while n != 1 and steps < max_steps:
        n = 3 * n + 1 if n % 2 else n // 2
        peak = max(peak, n)
        steps += 1
    return {'start': start, 'steps': steps, 'peak': peak,
            'status': 'reached_one' if n == 1 else 'unresolved_at_cap'}


def study(limit):
    primes = primes_up_to(limit)
    prime_set = set(primes)
    # Separate algorithm checks every sieve membership, not only found primes.
    if any((n in prime_set) != trial_prime(n) for n in range(limit + 1)):
        raise RuntimeError('Sieve disagrees with trial division.')
    digest = hashlib.sha256()
    failures = []
    hardest_goldbach = None
    for even in range(4, limit + 1, 2):
        p = next((p for p in primes if p <= even // 2 and even - p in prime_set), None)
        if p is None:
            failures.append(even)
        else:
            if not (trial_prime(p) and trial_prime(even - p)):
                raise RuntimeError('Goldbach witness failed independent primality check.')
            witness = {'even': even, 'p': p, 'q': even - p}
            if hardest_goldbach is None or p > hardest_goldbach['p']:
                hardest_goldbach = witness
        digest.update((json.dumps([even, p], separators=(',', ':')) + '\n').encode())
    unresolved = []
    longest = {'start': 1, 'steps': 0, 'peak': 1, 'status': 'reached_one'}
    for start in range(1, limit + 1):
        result = collatz(start)
        digest.update((json.dumps(result, sort_keys=True, separators=(',', ':')) + '\n').encode())
        if result['status'] != 'reached_one':
            unresolved.append(start)
        if result['steps'] > longest['steps']:
            longest = result
    return {'limit': limit, 'goldbach': {'even_cases': max(0, limit // 2 - 1),
            'counterexamples': failures, 'largest_minimum_addend': hardest_goldbach},
            'collatz': {'starts': limit, 'step_cap': 1000, 'unresolved': unresolved,
                        'longest_first_tie': longest},
            'twin_primes': {'pairs': sum(p + 2 in prime_set for p in primes),
                           'both_primes_at_most': limit},
            'evidence_sha256': digest.hexdigest()}


def run():
    stages = [study(limit) for limit in (100, 1000, 10000)]
    report = {'suite': 'number-theory-v1', 'status': 'complete',
              'updated_at': datetime.now(timezone.utc).isoformat(),
              'engine_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'stages': stages,
              'limits': 'Finite checks only. A Collatz step cap is unresolved, not divergence. '
                        'No finite twin-prime count proves infinitely many pairs.'}
    baseline = json.loads((ROOT / 'benchmarks/number-theory-baseline.json').read_text())
    if stages != baseline['stages'] or baseline['suite'] != report['suite']:
        raise RuntimeError('Number-theory regression: accepted findings were not replaced.')
    atomic_write(ROOT / 'landing/ladder.json', json.dumps(report, indent=2) + '\n')
    atomic_write(ROOT / 'benchmarks/number-theory-latest.json', json.dumps(report, indent=2) + '\n')
    return report


if __name__ == '__main__':
    print(json.dumps(run(), indent=2))
