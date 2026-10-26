import unittest
from alkanes import (REFERENCE, _divide_exact, alkane_counts, brute_force, canonical,
                     load_reference, slot_series)

# OEIS A000602, n = 1..20, copied from https://oeis.org/A000602/b000602.txt.
FIRST_20 = [1, 1, 1, 2, 3, 5, 9, 18, 35, 75, 159, 355, 802, 1858, 4347, 10359, 24894,
            60523, 148284, 366319]
# OEIS A000598 (rooted alkyl groups), n = 1..10, same source.
ALKYL_A000598 = [1, 1, 2, 4, 8, 17, 39, 89, 211, 507]


class AlkaneCountTests(unittest.TestCase):
    def test_first_twenty_match_oeis(self):
        counts = alkane_counts(20)
        self.assertEqual([counts[n] for n in range(1, 21)], FIRST_20)

    def test_rooted_alkyl_counts_match_a000598(self):
        self.assertEqual(slot_series(10)[1:], ALKYL_A000598)

    def test_brute_force_equals_formula_up_to_ten(self):
        counts = alkane_counts(10)
        for n in range(1, 11):
            self.assertEqual(brute_force(n), counts[n], n)

    def test_formula_matches_vendored_b_file_to_100(self):
        ref = load_reference(REFERENCE)
        counts = alkane_counts(100)
        for n in range(1, 101):
            self.assertEqual(counts[n], ref[n], n)

    def test_divisibility_guard_raises(self):
        with self.assertRaises(ArithmeticError):
            _divide_exact(7, 6)


class CanonicalFormTests(unittest.TestCase):
    def test_relabelled_path_has_same_form(self):
        path = [[1], [0, 2], [1, 3], [2]]
        relabelled = [[2, 3], [3], [0], [0, 1]]
        self.assertEqual(canonical(path), canonical(relabelled))

    def test_path_and_star_differ(self):
        path = [[1], [0, 2], [1, 3], [2]]
        star = [[1, 2, 3], [0], [0], [0]]
        self.assertNotEqual(canonical(path), canonical(star))


if __name__ == '__main__':
    unittest.main()
