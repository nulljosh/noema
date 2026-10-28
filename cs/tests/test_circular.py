import os
import subprocess
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OEIS = [4, 7, 11, 13, 21, 23, 36, 35, 55, 47, 78, 59, 105, 81]  # A394183(1..14) as OEIS had it on 2026-10-28


class CircularTests(unittest.TestCase):
    def test_known_terms(self):  # the memoized walk over (state, turned tape) gives the exhaustive values
        exe = os.path.join(tempfile.mkdtemp(), 'circular')
        subprocess.run(['cc', '-O2', '-o', exe, os.path.join(HERE, 'circular.c')], check=True)
        got = [int(subprocess.run([exe, str(n)], capture_output=True, text=True, check=True).stdout.split()[3])
               for n in range(1, 15)]
        self.assertEqual(got, OEIS)


if __name__ == '__main__':
    unittest.main()
