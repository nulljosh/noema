import unittest
from conjectures import collatz, primes_up_to, study, run


class ConjectureTests(unittest.TestCase):
    def test_known_primes_and_boundaries(self):
        self.assertEqual(primes_up_to(20), [2, 3, 5, 7, 11, 13, 17, 19])
        for bad in (0, -1, 10001, 3.5, True):
            with self.assertRaises(ValueError):
                primes_up_to(bad)

    def test_collatz_known_cases_and_cap(self):
        self.assertEqual(collatz(1)['steps'], 0)
        self.assertEqual(collatz(3)['steps'], 7)
        self.assertEqual(collatz(27)['steps'], 111)
        self.assertEqual(collatz(27)['peak'], 9232)
        self.assertEqual(collatz(3, 2)['status'], 'unresolved_at_cap')
        self.assertEqual(collatz(2, 1)['status'], 'reached_one')
        for exponent in range(20):
            self.assertEqual(collatz(2**exponent)['steps'], exponent)
        for bad in (0, -1, 1.5, True):
            with self.assertRaises(ValueError):
                collatz(bad)

    def test_small_independent_counts(self):
        report = study(10)
        self.assertEqual(report['goldbach']['even_cases'], 4)
        self.assertEqual(report['goldbach']['counterexamples'], [])
        self.assertEqual(report['twin_primes']['pairs'], 2)
        self.assertEqual(report['collatz']['unresolved'], [])

    def test_frozen_stages(self):
        self.assertEqual([s['limit'] for s in run()['stages']], [100, 1000, 10000])
