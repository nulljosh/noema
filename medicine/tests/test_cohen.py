import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import cohen


class CohenTests(unittest.TestCase):
    def test_a_fitting_d_passes(self):
        text = 'Scores improved (39.3 ± 15.9 vs 24.1 ± 16.4, P = 0.015, d = 0.94).'
        self.assertEqual([f[0] for f in cohen.flags(text)], [False])

    def test_a_tenfold_slip_is_flagged(self):
        text = 'Balance was higher (77.52 ± 18.27 vs 72.35 ± 16.39, Cohen\'s d = 0.030).'
        far, pair, d, (lo, hi), _ = next(cohen.flags(text))
        self.assertTrue(far)
        self.assertLess(lo, 0.3)
        self.assertGreater(hi, 0.3)

    def test_negative_means_and_skips(self):
        text = 'PPO fell more (-0.22 ± 0.22 vs -0.05 ± 0.09 W, p = 0.008, d = -2.16).'
        self.assertEqual([f[0] for f in cohen.flags(text)], [False])  # fits the smaller SD
        self.assertEqual(list(cohen.flags('Adjusted scores (5.0 ± 1.0 vs 4.0 ± 1.0, d = 9.0).')), [])


if __name__ == '__main__':
    unittest.main()
