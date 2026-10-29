import os
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import bench


def results(no_generation, generated, resolved):
    return {'no_generation': no_generation, 'generated': generated, 'resolved': resolved}


class BenchTest(unittest.TestCase):
    def test_clean_submission(self):
        c = bench.check(results([], ['a', 'b', 'c', 'd'], ['a']), ['a', 'b', 'c', 'd'])
        self.assertEqual((c['repeated'], c['missing'], c['unknown']), ([], [], []))
        self.assertEqual((c['entries'], c['distinct']), (4, 4))
        self.assertEqual(bench.rates(c), (25.0, 25.0))

    def test_repeat_hides_a_gap(self):
        """Two entries for one task and none for another: the count still looks full."""
        c = bench.check(results(['a'], ['b', 'b', 'c'], ['c']), ['a', 'b', 'c', 'd'])
        self.assertEqual(c['entries'], 4)
        self.assertEqual(c['distinct'], 3)
        self.assertEqual(c['repeated'], ['b'])
        self.assertEqual(c['missing'], ['d'])
        over_official, over_attempted = bench.rates(c)
        self.assertAlmostEqual(over_official, 25.0)
        self.assertAlmostEqual(over_attempted, 100 / 3)

    def test_task_outside_the_official_list(self):
        c = bench.check(results([], ['a', 'z'], []), ['a', 'b'])
        self.assertEqual(c['unknown'], ['z'])
        self.assertEqual(c['missing'], ['b'])

    def test_exception_only_files_are_not_checkable(self):
        """The newer schema lists only exceptions, so a task attempted and failed appears nowhere."""
        self.assertTrue(bench.enumerative(results([], ['a'], [])))
        self.assertFalse(bench.enumerative({'no_generation': [], 'no_logs': [], 'resolved': ['a']}))

    def test_survey_sorts_every_submission(self):
        every = {
            'good': results([], ['a', 'b'], ['a']),
            'short': results([], ['a'], []),
            'exceptions-only': {'no_generation': [], 'no_logs': [], 'resolved': ['a']},
            'missing-file': {'error': 'HTTP Error 404: Not Found'},
        }
        clean, flagged, opaque, absent = bench.survey(every, ['a', 'b'])
        self.assertEqual((clean, list(flagged), opaque, absent),
                         (['good'], ['short'], ['exceptions-only'], ['missing-file']))
        self.assertEqual(flagged['short']['missing'], ['b'])


if __name__ == '__main__':
    unittest.main()
