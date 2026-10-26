import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import totals


class TotalsTests(unittest.TestCase):
    def test_kinds(self):
        self.assertEqual([r[3] for r in totals.splits('in 55 patients (22 males and 34 females, mean age 48)')], ['over'])
        self.assertEqual([r[3] for r in totals.splits('Of 53 patients (34 males and 9 females) who finished')], ['short'])
        self.assertEqual(list(totals.splits('Of 60 patients (30 men and 30 women)')), [])

    def test_explained_shortfall_and_same_sex_skipped(self):
        self.assertEqual(list(totals.splits('504 participants (333 women, 165 men, and 6 unspecified)')), [])
        self.assertEqual(list(totals.splits('40 patients (20 men and 15 men)')), [])

    def test_arms(self):
        self.assertEqual([r[0] for r in totals.arms('95 patients were randomized to either MA (n = 50) or KA (n = 49) groups.')], [95])
        for text in ('120 patients were randomized to A (n = 60) or B (n = 60).',
                     '1082 infants were randomly assigned to sitting (n=546) or lying (n=536), and early (n=549) or late (n=533).',
                     '15 076 participants were randomized to aspirin 81 mg (n=7540) or 325 mg (n=7536).',
                     'COVID-19 patients were randomized to verum (n = 41) and placebo (n = 37).'):
            self.assertEqual(list(totals.arms(text)), [], text)


if __name__ == '__main__':
    unittest.main()
