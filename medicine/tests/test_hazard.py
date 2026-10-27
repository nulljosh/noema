import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import hazard


class HazardTests(unittest.TestCase):
    def test_a_fitting_hr_passes_either_direction(self):
        text = 'Median PFS was 9.0 vs 17.6 months (hazard ratio 0.52, 95% CI 0.31-0.89, P = 0.016).'
        self.assertEqual([f[0] for f in hazard.flags(text)], [False])
        text = 'Median PFS was 9.0 vs 17.6 months (hazard ratio 1.92, 95% CI 1.12-3.2, P = 0.016).'
        self.assertEqual([f[0] for f in hazard.flags(text)], [False])

    def test_equal_medians_with_a_strong_hr_are_flagged(self):
        text = 'Median OS was 12.0 vs 12.2 months (HR 0.30, 95% CI 0.20-0.45).'
        self.assertEqual([f[0] for f in hazard.flags(text)], [True])

    def test_an_hr_outside_its_interval_is_skipped(self):
        self.assertEqual(list(hazard.flags('Median OS was 5 vs 9 months (HR 2.5, 95% CI 0.4-0.9).')), [])


if __name__ == '__main__':
    unittest.main()
