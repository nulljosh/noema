import os
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import count_lean  # noqa: E402


class CountLean(unittest.TestCase):
    def test_tree_counts(self):
        # the Python twin of the Lean tree gives the 3-state counts Count3.lean proves
        cnt, ssum, _ = count_lean.walk([None] * 6, 0, 0, [], 0, [])
        self.assertEqual((cnt, ssum), (7571840, 13141792))

    def test_pieces_cover_the_tree(self):
        nodes = []
        count_lean.frontier([None] * 6, 0, 0, [], 0, [], nodes)
        self.assertTrue(all(count_lean.walk(n[0], n[1], *n[2])[2] <= count_lean.T for n in nodes))
        self.assertEqual(len(nodes), 760)


if __name__ == '__main__':
    unittest.main()
