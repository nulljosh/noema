import math
import os
import random
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import quakes  # noqa: E402


class QuakeTests(unittest.TestCase):
    def test_recovers_b(self):  # magnitudes drawn from Gutenberg-Richter with b = 1, binned at 0.1
        rng = random.Random(7)
        mags = [round(5.45 + rng.expovariate(math.log(10)), 1) for _ in range(20000)]
        n, b, se = quakes.b_value(mags, 5.5)
        self.assertLess(abs(b - 1), 3 * se + 0.02)


if __name__ == '__main__':
    unittest.main()
