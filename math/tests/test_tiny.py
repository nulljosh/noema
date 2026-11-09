import unittest
from math import factorial
from tiny import dpll, exhaustive_sat, is_prime, largest_gap, pigeonhole, primes_between


class PigeonholeTests(unittest.TestCase):
    def test_every_small_instance_is_unsat_both_ways(self):
        for holes in range(1, 4):
            variables, clauses = pigeonhole(holes)
            self.assertFalse(dpll(clauses)[0])
            self.assertFalse(exhaustive_sat(variables, clauses))

    def test_dropping_one_pigeon_makes_it_satisfiable(self):
        _, clauses = pigeonhole(3)
        self.assertTrue(dpll(clauses[1:])[0])

    def test_search_nodes_are_two_factorial_minus_one(self):
        # Observed for this branching order only, up to six holes. Not a theorem here.
        for h in range(1, 7):
            self.assertEqual(dpll(pigeonhole(h)[1])[1], 2 * factorial(h) - 1, h)


class PrimeGapTests(unittest.TestCase):
    def test_segmented_sieve_matches_trial_division(self):
        for lo, hi in ((2, 500), (1000, 1500), (99900, 100100)):
            self.assertEqual(primes_between(lo, hi), [n for n in range(lo, hi) if is_prime(n)])

    def test_known_maximal_gap(self):
        # 1327 to 1361, the first gap of 34.
        self.assertEqual(largest_gap(1300, 1400), {'start': 1327, 'end': 1361, 'gap': 34})


if __name__ == '__main__':
    unittest.main()
