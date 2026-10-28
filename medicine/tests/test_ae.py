import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import ae  # noqa: E402


def module(total, cells):
    return {'eventGroups': [{'id': 'EG000', 'seriousNumAffected': total, 'seriousNumAtRisk': 10}],
            'seriousEvents': [{'term': t, 'stats': [{'groupId': 'EG000', 'numAffected': a, 'numEvents': n,
                                                    'numAtRisk': r}]} for t, a, n, r in cells]}


class AeTests(unittest.TestCase):
    def test_consistent(self):
        self.assertEqual(ae.flags(module(3, [('a', 2, 2, 10), ('b', 2, 5, 10)])), [])

    def test_each_ordering(self):
        kinds = [k for k, _ in ae.flags(module(3, [('a', 4, 2, 3)]))]
        self.assertEqual(sorted(kinds), ['term affected > at risk', 'term affected > events',
                                         'term affected > group affected'])
        self.assertEqual([k for k, _ in ae.flags(module(5, [('a', 1, 1, 10), ('b', 2, 2, 10)]))],
                         ['group serious > sum of terms'])
        self.assertEqual([k for k, _ in ae.flags(module(11, []))], ['group affected > at risk'])


if __name__ == '__main__':
    unittest.main()
