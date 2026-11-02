import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import sortnet  # noqa: E402


class SortnetTests(unittest.TestCase):
    def test_best_known_networks_sort_everything(self):
        self.assertEqual(len(sortnet.N8), 19)
        self.assertEqual(len(sortnet.N9), 25)
        self.assertTrue(sortnet.sorts(sortnet.N8, 8))
        self.assertTrue(sortnet.sorts(sortnet.N9, 9))

    def test_a_broken_network_is_caught(self):
        self.assertFalse(sortnet.sorts(sortnet.N8[:-1], 8))

    def test_small_optimal_sizes(self):
        self.assertEqual([sortnet.optimal_size(n) for n in range(2, 6)], [1, 3, 5, 9])


if __name__ == "__main__":
    unittest.main()
