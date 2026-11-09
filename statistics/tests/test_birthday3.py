import unittest
from fractions import Fraction
from birthday3 import no_triple_by_count, no_triple_series, smallest_past_half


class BirthdayTripleTests(unittest.TestCase):
    def test_two_methods_agree_exactly(self):
        series = no_triple_series(60)
        for n in range(61):
            self.assertEqual(series[n], no_triple_by_count(n), n)

    def test_published_answer_is_88(self):
        self.assertEqual(smallest_past_half(), 88)

    def test_small_case_by_hand(self):
        # Three people on a two-day year: only all-same fails, and that is 2 of 8.
        self.assertEqual(no_triple_by_count(3, days=2), Fraction(3, 4))
        self.assertEqual(no_triple_series(3, days=2)[3], Fraction(3, 4))

    def test_pigeonhole_forces_a_triple(self):
        self.assertEqual(no_triple_by_count(731), 0)


if __name__ == '__main__':
    unittest.main()
