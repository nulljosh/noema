import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import codes  # noqa: E402

# A(n, d) from the published tables (Brouwer), n = 3..7
KNOWN = {(3, 3): 2, (4, 3): 2, (5, 3): 4, (6, 3): 8, (7, 3): 16, (5, 4): 2, (6, 4): 4, (7, 4): 8, (7, 5): 2}


class CodesTests(unittest.TestCase):
    def test_known_values(self):
        for (n, d), want in KNOWN.items():
            size, code = codes.A(n, d)
            self.assertEqual(size, want, (n, d))
            # the second check: the code itself, distance by distance
            self.assertTrue(all(bin(a ^ b).count('1') >= d for i, a in enumerate(code) for b in code[i + 1:]))


if __name__ == '__main__':
    unittest.main()
