import unittest
from alcohols import (STEREO_ALKANE_REFERENCE, STEREO_REFERENCE, STRUCTURAL_REFERENCE, brute_force,
                      load_reference, slot_series, stereo_alkanes, stereo_series)


class AlcoholCountTests(unittest.TestCase):
    def test_formulas_match_vendored_b_files_to_100(self):
        for series, path in ((slot_series(100), STRUCTURAL_REFERENCE), (stereo_series(100), STEREO_REFERENCE),
                             (stereo_alkanes(100), STEREO_ALKANE_REFERENCE)):
            ref = load_reference(path)
            self.assertGreaterEqual(len(ref), 30)
            for n, value in ref.items():
                if n <= 100:
                    self.assertEqual(series[n], value, n)

    def test_brute_force_equals_formula_up_to_ten(self):
        self.assertEqual(brute_force(10, False), slot_series(10))
        self.assertEqual(brute_force(10, True), stereo_series(10))

    def test_propanol_has_two_structures_and_butanol_gains_a_mirror_pair(self):
        self.assertEqual(slot_series(4)[3:5], [2, 4])
        self.assertEqual(stereo_series(4)[3:5], [2, 5])


if __name__ == '__main__':
    unittest.main()
