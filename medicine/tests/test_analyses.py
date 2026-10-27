import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import analyses


def row(est, lo, hi, p=None, kind='Mean Difference (Final Values)'):
    return {'paramType': kind, 'paramValue': est, 'ciLowerLimit': lo, 'ciUpperLimit': hi,
            'ciNumSides': 'TWO_SIDED', 'ciPctValue': '95', 'pValue': p}


class AnalysesTests(unittest.TestCase):
    def test_lost_minus_backed_by_p(self):  # NCT02595970: -21.6 (-23.52, 19.58), p < 0.0001
        self.assertEqual(analyses.sign_slip(row('-21.6', '-23.52', '19.58', '<0.0001')), ([-23.52, -19.58], 'backs the flip'))

    def test_stray_minus_backed_by_p(self):  # NCT00796653: -0.153 (-0.391, -0.084), p 0.2057
        self.assertEqual(analyses.sign_slip(row('-0.153', '-0.391', '-0.084', '0.2057'))[1], 'backs the flip')

    def test_p_backing_the_posted_ci(self):
        self.assertEqual(analyses.sign_slip(row('-4.4', '-9.4', '-1.0', '0.009'))[1], 'backs the posted CI')

    def test_symmetric_ratio_and_one_sided_left_alone(self):
        self.assertIsNone(analyses.sign_slip(row('-2.0', '-3.1', '-0.9', '0.001')))
        self.assertIsNone(analyses.sign_slip(row('0.58', '0.25', '1.36', '0.21')))  # a ratio under a difference label
        self.assertIsNone(analyses.sign_slip(row('-21.6', '-23.52', '19.58', '<0.0001', 'Odds Ratio (OR)')))
        self.assertIsNone(analyses.sign_slip({**row('-21.6', '-23.52', '19.58'), 'ciNumSides': 'ONE_SIDED'}))

    def test_pval(self):
        self.assertEqual(analyses.pval('<0.001'), (0.0, 0.001))
        self.assertEqual([round(x, 6) for x in analyses.pval('0.05')], [0.045, 0.055])
        self.assertIsNone(analyses.pval('NA'))


if __name__ == '__main__':
    unittest.main()
