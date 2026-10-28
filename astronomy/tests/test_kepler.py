import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import kepler  # noqa: E402


class KeplerTests(unittest.TestCase):
    def test_solar_system(self):  # Earth and Jupiter, from the IAU values, obey the law within a percent
        self.assertAlmostEqual(kepler.ratio(365.256, 1.0, 1.0, 0.00315), 1, delta=0.01)
        self.assertAlmostEqual(kepler.ratio(4332.59, 5.2044, 1.0, 1.0), 1, delta=0.01)

    def test_outlier_flagged(self):
        rows = [{'pl_name': 'ok', 'pl_orbper': 365.25, 'pl_orbsmax': 1.0, 'st_mass': 1.0},
                {'pl_name': 'ok2', 'pl_orbper': 365.25, 'pl_orbsmax': 1.0, 'st_mass': 1.0},
                {'pl_name': 'bad', 'pl_orbper': 365.25, 'pl_orbsmax': 2.0, 'st_mass': 1.0,
                 'pl_orbper_reflink': 'refstr=X ', 'pl_orbsmax_reflink': 'refstr=X ', 'st_mass_reflink': 'refstr=X '}]
        r = kepler.study(rows)
        self.assertEqual((r['off_by_2x'], r['off_by_2x_one_source']), (1, 1))
        self.assertEqual(r['rows'][0][:2], ['bad', 8.0])


if __name__ == '__main__':
    unittest.main()
