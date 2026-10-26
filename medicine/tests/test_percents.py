import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import percents


class PercentTests(unittest.TestCase):
    def test_rounding_rules(self):
        for x, n, printed in ((12, 40, '30'), (12, 40, '30.0'), (1, 3, '33.3'), (2, 3, '66.6'), (2, 3, '67'), (1, 8, '13')):
            self.assertTrue(percents.consistent(x, n, printed), (x, n, printed))
        for x, n, printed in ((12, 40, '35'), (6, 18, '66.6'), (8, 183, '3'), (10, 55, '18.0')):
            self.assertFalse(percents.consistent(x, n, printed), (x, n, printed))

    def test_patterns(self):
        found = [p[:3] for p in percents.pairs('in 12 (30%) of 40 and 3/9 [33.3%] and 5 of 10 (50 %)')]
        self.assertEqual(sorted(found), [(3, 9, '33.3'), (5, 10, '50'), (12, 40, '30')])

    def test_false_alarms_are_skipped(self):
        for text in ('negative HPV16/18 (8.4% vs. 14.5%)', 'sPGA 0/1 (71.8% vs 0.4%)', 'was 0% (0/52 [95% CI, 0.0-5.6])',
                     'In RCT sites (1-4), 79/365 (19%-41%) reported', 'rate 31·7% (90/298 [95% CI 26·6-37·2])'):
            self.assertEqual(percents.check(text), [], text)


if __name__ == '__main__':
    unittest.main()
