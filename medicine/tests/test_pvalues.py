import math
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import pvalues


class PValueTests(unittest.TestCase):
    def test_fisher_exact_small_table(self):
        # 4/4 against 0/4: the observed table and its mirror are the only ones as extreme, each 1 / C(8, 4).
        p = pvalues.tests(4, 4, 0, 4)
        self.assertAlmostEqual(p['fisher'], 2 / math.comb(8, 4), places=12)
        self.assertAlmostEqual(p['fisher1'], 1 / math.comb(8, 4), places=12)

    def test_pearson_is_pooled_z_squared(self):
        a, n1, b, n2 = 24, 72, 8, 71
        pool = (a + b) / (n1 + n2)
        z = (a / n1 - b / n2) / math.sqrt(pool * (1 - pool) * (1 / n1 + 1 / n2))
        self.assertAlmostEqual(pvalues.tests(a, n1, b, n2)['pearson'], math.erfc(abs(z) / math.sqrt(2)), places=12)

    def test_extracts_and_judges_a_triple(self):
        text = 'Rates were 24/72 (33.3%) vs 8/71 (11.3%); P value 0.002. Other text 3/9 here.'
        (t,) = list(pvalues.triples(text))
        self.assertEqual(t[:6], (24, 72, 8, 71, '=', '0.002'))
        row = pvalues.judge(*t)
        self.assertTrue(row['consistent'])
        self.assertFalse(row['gross'] or row['fraction_slip'] or row['ambiguous'])

    def test_gross_and_slip_flags(self):
        (t,) = list(pvalues.triples('Death 10/100 (10%) versus 12/100 (12%), P = 0.01.'))
        self.assertTrue(pvalues.judge(*t)['gross'])
        (t,) = list(pvalues.triples('Death 10/100 (19%) versus 12/100 (12%), P = 0.01.'))
        self.assertTrue(pvalues.judge(*t)['fraction_slip'])
        (t,) = list(pvalues.triples('Cough [10% (2/10) vs 45% (9/20), P =0.031].'))
        self.assertTrue(pvalues.judge(*t)['fraction_slip'])

    def test_printed_forms(self):
        self.assertTrue(pvalues.matches('=', '.29', 0.287))
        self.assertTrue(pvalues.matches('<', '0.001', 0.0002))
        self.assertFalse(pvalues.matches('<', '0.001', 0.002))
        self.assertTrue(pvalues.matches('=', '1.2 × 10−5', 1.24e-5))
        self.assertEqual(list(pvalues.triples('a 5/10 vs 1/10, P = 1·2 × 10−5 b'))[0][5], '1·2 × 10−5')

    def test_needs_a_comparison_word_and_real_fractions(self):
        self.assertEqual(list(pvalues.triples('In 5/10 and 1/10 patients, P = 0.03.')), [])
        self.assertEqual(list(pvalues.triples('HPV16/18 (8.4%) vs 3/20 (15%), P = 0.03.')), [])
        # Three arms before one P, and a P sitting between the two fractions, are not read as a pair.
        self.assertEqual(list(pvalues.triples('A (24/68), B (22/68) compared to C (22/68), P = .02.')), [])
        self.assertEqual(list(pvalues.triples('2 of 40 in RC (vs. C, P = 0.001), and 3 of 39 in RB (vs. C, P = 0.003).')), [])


if __name__ == '__main__':
    unittest.main()
