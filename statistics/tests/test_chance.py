import math
import random
import sys
import unittest
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import chance  # noqa: E402


class ChanceTests(unittest.TestCase):
    def test_birthday_exact(self):
        self.assertEqual(chance.first_over_half(), 23)
        self.assertAlmostEqual(float(chance.birthday(23)), 0.507297, places=6)
        self.assertEqual(chance.birthday(366), 1)  # pigeonhole

    def test_coupon_exact(self):
        self.assertEqual(chance.coupon_mean(6), Fraction(147, 10))  # a die: 14.7 rolls
        self.assertAlmostEqual(float(chance.coupon_mean(50)), 224.9603, places=4)

    def test_simulation_agrees_within_four_standard_errors(self):
        rng = random.Random(1)
        p, t = float(chance.birthday(23)), 20_000
        self.assertLess(abs(chance.simulate_birthday(23, t, rng) - p), 4 * math.sqrt(p * (1 - p) / t))
        sd = math.sqrt(sum((6 / k) * (6 / k - 1) for k in range(1, 7)))  # sum of geometric variances
        self.assertLess(abs(chance.simulate_coupon(6, t, rng) - 14.7), 4 * sd / math.sqrt(t))


if __name__ == "__main__":
    unittest.main()
