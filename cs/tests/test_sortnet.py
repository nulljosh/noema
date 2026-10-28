import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import sortnet


class SortnetTests(unittest.TestCase):
    def test_a003075(self):  # OEIS A003075: 0, 1, 3, 5, 9, 12, 16, 19, 25, ...
        self.assertEqual([sortnet.size(n)[0] for n in range(1, 7)], [0, 1, 3, 5, 9, 12])

    def test_six_channel_layers(self):
        self.assertEqual(sortnet.size(6)[1][:4], [15, 85, 320, 1021])


if __name__ == '__main__':
    unittest.main()
