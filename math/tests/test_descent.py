import unittest
from descent import first_descent, accelerated_check, study, residue_tree


class DescentTests(unittest.TestCase):
    def test_known_cases(self):
        self.assertEqual(first_descent(3), {'start': 3, 'steps': 6, 'first_below': 2, 'status': 'descended'})
        self.assertEqual(first_descent(27)['steps'], 96)
        self.assertEqual(first_descent(626331)['steps'], 287)
        self.assertEqual(first_descent(626331)['first_below'], 597017)
        self.assertEqual(first_descent(3, 5)['status'], 'unresolved_at_cap')
        self.assertEqual(first_descent(3, 6)['first_below'], 2)
        self.assertEqual(first_descent(2, 1)['first_below'], 1)
        for start in range(2, 1000, 2):
            self.assertEqual(first_descent(start)['steps'], 1)

    def test_acceleration_at_odd_caps(self):
        for start in (2, 3, 7, 27, 97, 6171):
            for cap in (1, 2, 5, 6, 95, 96, 1000):
                result = first_descent(start, cap)
                self.assertEqual((result['steps'], result['first_below']), accelerated_check(start, cap))

    def test_boundaries_and_coverage(self):
        for invalid in (0, 1, -1, 1.5, True, 1000001):
            with self.assertRaises(ValueError):
                first_descent(invalid)
        for invalid in (0, 1001, 1.5, True):
            with self.assertRaises(ValueError):
                first_descent(3, invalid)
        result = study(10000)
        self.assertEqual(result['starts_checked'], 9999)
        self.assertEqual(sum(result['step_histogram'].values()), 9999)
        self.assertEqual(result['unresolved'], [])
        self.assertEqual(result['independent_disagreements'], 0)
        for modulus in (8, 16):
            groups = result['residue_groups'][str(modulus)]
            self.assertEqual(sum(g['checked'] for g in groups), 9999)
            for group in groups:
                r = group['remainder']
                expected = sum(n % modulus == r for n in range(2, 10001))
                self.assertEqual(group['checked'], expected)
                self.assertEqual(group['unresolved'], 0)
                if r % 2 == 0:
                    self.assertEqual(group['minimum_steps'], 1)
                    self.assertEqual(group['maximum']['steps'], 1)
                if r % 4 == 1:
                    self.assertEqual(group['minimum_steps'], 3)
                    self.assertEqual(group['maximum']['steps'], 3)
        class_three = result['residue_groups']['16'][3]
        self.assertEqual(class_three['minimum_steps'], 6)
        self.assertEqual(class_three['maximum']['steps'], 6)

    def test_remaining_modulo_32_groups(self):
        result = study(10000)
        groups = result['residue_groups']['32']
        self.assertEqual([g['remainder'] for g in groups], [7,11,15,23,27,31])
        self.assertEqual(sum(g['checked'] for g in groups), 1875)
        for group in groups:
            r = group['remainder']
            self.assertEqual(group['checked'], sum(n % 32 == r for n in range(2,10001)))
            if r in (11,23):
                self.assertEqual(group['minimum_steps'], 8)
                self.assertEqual(group['maximum']['steps'], 8)
            else:
                self.assertGreater(group['maximum']['steps'], group['minimum_steps'])
        for k in range(100):
            for r in (11,23):
                self.assertEqual(first_descent(32*k+r)['steps'], 8)


class ResidueTreeTests(unittest.TestCase):
    # OEIS A076227 a(1)..a(20), fetched 2026-10-26 from oeis.org.
    A076227 = [1, 1, 2, 3, 4, 8, 13, 19, 38, 64, 128, 226, 367, 734, 1295, 2114, 4228, 7495, 14990, 27328]

    def test_matches_oeis(self):
        self.assertEqual([l['open'] for l in residue_tree(20)], self.A076227)

    def test_closed_classes_descend_numerically(self):
        for level in residue_tree(12):
            m = level['modulus']
            for r, steps in level['_closed'].items():
                for n in range(r if r >= 2 else r + m, 60000, m * 7):
                    self.assertLessEqual(first_descent(n)['steps'], steps, (m, r, n))
