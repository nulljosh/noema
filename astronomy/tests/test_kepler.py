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

    def test_papers(self):  # the Sun's own a/R_star is 215; a paper fitting 10 percent long shows +0.041 dex
        self.assertAlmostEqual(kepler.ardor_kepler(365.25, 1.0, 1.0), 215.03, delta=0.05)
        rows = [{'pl_refname': '<a>P</a>', 'pl_ratdor': 215.03 * f, 'pl_orbper': 365.25, 'st_mass': 1.0, 'st_rad': 1.0}
                for f in (1.1, 1.1, 1.1, 1.0, 1.2)]
        self.assertEqual(kepler.papers(rows), [['P', 5, 0.041]])

    def test_densities(self):  # the Sun from Earth's orbit, then a paper whose second planet implies an 8x denser star
        self.assertAlmostEqual(kepler.rho_star(215.03, 365.25), 1.41, delta=0.01)
        row = lambda n, ar, p: {'hostname': 'S', 'pl_name': n, 'pl_refname': '<a>P</a>', 'pl_ratdor': ar,  # noqa: E731
                                'pl_ratdorerr1': ar / 100, 'pl_orbper': p}
        self.assertEqual(kepler.densities([row('S b', 10, 3), row('S c', 20, 3 * 2 ** 1.5)]), [])
        self.assertEqual(kepler.densities([row('S b', 10, 3), row('S c', 40, 3 * 2 ** 1.5)])[0][2], 8.0)


if __name__ == '__main__':
    unittest.main()
