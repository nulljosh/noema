"""The chance that three of n people share a birthday, exactly, by two independent methods.

Method 1 counts assignments with no triple directly: k days hold two people and n - 2k hold one.
Method 2 walks a Markov chain one person at a time over (days with one, days with two).
Both use exact fractions. The published answer is that 88 people is the smallest group past a half.
"""
import json
import math
import os
from fractions import Fraction

HERE = os.path.dirname(os.path.abspath(__file__))
LATEST = os.path.join(HERE, 'benchmarks', 'birthday3-latest.json')
DAYS = 365
SEARCH_MAX = 120


def no_triple_by_count(n, days=DAYS):
    """P(no date is shared by three or more of n people), summing over how many dates hold a pair."""
    total = 0
    for k in range(n // 2 + 1):
        singles = n - 2 * k
        if k + singles > days:
            continue
        total += math.comb(days, k) * math.comb(days - k, singles) * math.factorial(n) // 2 ** k
    return Fraction(total, days ** n)


def no_triple_series(limit, days=DAYS):
    """[P(no triple among n people)] for n = 0..limit, by adding one person at a time."""
    states = {(0, 0): Fraction(1)}
    out = [Fraction(1)]
    for _ in range(limit):
        nxt = {}
        for (one, two), p in states.items():
            empty = days - one - two
            if empty:
                key = (one + 1, two)
                nxt[key] = nxt.get(key, 0) + p * Fraction(empty, days)
            if one:
                key = (one - 1, two + 1)
                nxt[key] = nxt.get(key, 0) + p * Fraction(one, days)
        states = nxt
        out.append(sum(states.values(), Fraction(0)))
    return out


def smallest_past_half(days=DAYS, limit=SEARCH_MAX):
    series = no_triple_series(limit, days)
    return next(n for n in range(limit + 1) if 1 - series[n] > Fraction(1, 2))


def main():
    series = no_triple_series(SEARCH_MAX)
    for n in range(SEARCH_MAX + 1):
        if series[n] != no_triple_by_count(n):
            raise SystemExit('the two methods disagree at n = %d' % n)
    n = smallest_past_half()
    result = {
        'days': DAYS,
        'methods_agree_exactly_to': SEARCH_MAX,
        'smallest_group_past_half': n,
        'chance_at_87': float(1 - series[n - 1]),
        'chance_at_88': float(1 - series[n]),
    }
    with open(LATEST, 'w') as f:
        json.dump(result, f, indent=1)
        f.write('\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
