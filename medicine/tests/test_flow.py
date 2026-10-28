import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import flow  # noqa: E402


def period(s, c, nc, reasons):
    m = lambda t, v: {'type': t, 'achievements': [{'groupId': 'FG000', 'numSubjects': str(v)}]}  # noqa: E731
    return {'periods': [{'title': 'Overall Study', 'milestones': [m('STARTED', s), m('COMPLETED', c), m('NOT COMPLETED', nc)],
                         'dropWithdraws': [{'type': 'x', 'reasons': [{'groupId': 'FG000', 'numSubjects': str(r)}]}
                                           for r in reasons]}]}


class FlowTests(unittest.TestCase):
    def test_conserved(self):
        self.assertEqual(flow.flags(period(10, 7, 3, [2, 1])), [])

    def test_each_break(self):
        self.assertEqual([f[0] for f in flow.flags(period(10, 12, 0, []))], ['completed > started',
                                                                             'completed + not completed != started'])
        self.assertEqual([f[0] for f in flow.flags(period(10, 7, 3, [2, 2]))], ['reasons != not completed'])


if __name__ == '__main__':
    unittest.main()
