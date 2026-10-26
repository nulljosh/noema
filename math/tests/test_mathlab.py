import math
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import mathlab


class StudyTests(unittest.TestCase):
    def test_known_controls(self):
        cases = [(0, (), True, 'sat'), (0, ((),), False, 'unsat'),
                 (1, ((1,),), True, 'sat'), (1, ((1,), (-1,)), False, 'unsat'),
                 (2, ((1, 2),), True, 'stalled'),
                 (2, ((1, 2), (1, -2), (-1, 2), (-1, -2)), False, 'stalled'),
                 (3, ((1,), (-1, 2), (-2, 3), (-3,)), False, 'unsat')]
        for n, formula, sat, expected in cases:
            with self.subTest(formula=formula):
                self.assertEqual(mathlab.truth_table(n, formula)['sat'], sat)
                self.assertEqual(mathlab.unit_propagation(n, formula)[0], expected)

    def test_input_boundaries(self):
        for n, formula in [(4, ()), (-1, ()), (True, ()), (1, ((0,),)),
                           (1, ((2,),)), (1, ((True,),)), (1, ((1, 1),)),
                           (1, ((1, -1),))]:
            with self.assertRaises(ValueError):
                mathlab.unit_propagation(n, formula)
        for minutes in (0, -1, 61, math.nan, math.inf):
            with self.assertRaises(ValueError):
                mathlab.study(minutes)

    def test_full_corpus_soundness_and_regression(self):
        report = mathlab.study()
        # Independent clause count: 3**n - 1; select at most four clauses.
        for n in range(1, 4):
            k = 3**n - 1
            expected = sum(math.comb(k, i) for i in range(min(k, 4) + 1))
            self.assertEqual(report['metrics'][f'variables_{n}'], expected)
        self.assertEqual(report['metrics']['soundness_errors'], 0)
        self.assertEqual(report['metrics']['witness_errors'], 0)
        self.assertTrue(mathlab.regression(report))
        for example in report['examples'].values():
            self.assertEqual(mathlab.truth_table(example['variables'], example['clauses'])['sat'],
                             example['sat'])

    def test_timeout_and_interrupt(self):
        with patch('mathlab.time.monotonic', side_effect=[0, 61, 61]):
            self.assertEqual(mathlab.study(1)['status'], 'timed_out')
        with patch('mathlab.corpus', side_effect=KeyboardInterrupt):
            self.assertEqual(mathlab.study()['status'], 'interrupted')

    def test_incomplete_run_preserves_accepted_results(self):
        with tempfile.TemporaryDirectory() as directory, patch('mathlab.ROOT', Path(directory)):
            mathlab.publish({'status': 'timed_out'})
            self.assertEqual(len(list((Path(directory) / 'runs').glob('*.json'))), 1)
            self.assertFalse((Path(directory) / 'benchmarks/latest.json').exists())


if __name__ == '__main__':
    unittest.main()
