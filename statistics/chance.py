"""Birthday problem and coupon collector, exact with fractions, checked by simulation.

    python3 chance.py
"""
import random
from fractions import Fraction


def birthday(n, days=365):
    """Exact chance that at least two of n people share a birthday."""
    p = Fraction(1)
    for i in range(n):
        p *= Fraction(days - i, days)
    return 1 - p


def first_over_half(days=365):
    n = 1
    while birthday(n, days) <= Fraction(1, 2):
        n += 1
    return n


def coupon_mean(n):
    """Exact expected draws to collect all n coupons: n * H_n."""
    return n * sum(Fraction(1, k) for k in range(1, n + 1))


def simulate_birthday(n, trials, rng, days=365):
    return sum(len({rng.randrange(days) for _ in range(n)}) < n for _ in range(trials)) / trials


def simulate_coupon(n, trials, rng):
    total = 0
    for _ in range(trials):
        seen, draws = set(), 0
        while len(seen) < n:
            seen.add(rng.randrange(n))
            draws += 1
        total += draws
    return total / trials


if __name__ == "__main__":
    rng = random.Random(2026)
    print(f"birthday: first n over 1/2 = {first_over_half()}, P(23) = {float(birthday(23)):.6f}, "
          f"simulated {simulate_birthday(23, 100_000, rng):.4f}")
    for n in (6, 50):
        print(f"coupons n={n}: exact {coupon_mean(n)} = {float(coupon_mean(n)):.4f}, simulated {simulate_coupon(n, 20_000, rng):.3f}")
