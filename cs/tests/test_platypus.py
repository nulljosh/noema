import json
import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, HERE)
import platypus  # noqa: E402

# A399346 as OEIS had it on 2026-10-28, n = 1..37
OEIS = [1, 2, 2, 2, 3, 3] + [4] * 7 + [5] * 24


class PlatypusTests(unittest.TestCase):
    def test_small_spectra(self):  # every count up to Sigma(n) is printable for n = 1..4
        d = tempfile.mkdtemp(); exe = os.path.join(d, 'plainwalk')
        subprocess.run(['cc', '-O2', '-o', exe, os.path.join(HERE, 'plainwalk.c')], check=True)
        for n, sigma in ((1, 1), (2, 4), (3, 6), (4, 13)):
            self.assertEqual(sorted(platypus.spectrum(exe, n, platypus.BB[n])), list(range(sigma + 1)))

    def test_result(self):
        r = json.load(open(os.path.join(HERE, 'platypus-5.json')))
        self.assertEqual(r['pp'][:37], OEIS)
        self.assertEqual(r['first_not_printable_by_5_states'], 74)
        for n in (13, 73, 74, 117):  # each witness halts with exactly n ones, using pp(n) states
            states, _, ones = platypus.sim(r['witness'][str(n)])
            self.assertEqual((states, ones), (r['pp'][n - 1], n))
        self.assertIn(4098, r['spectrum_5'])  # Sigma(5)


if __name__ == '__main__':
    unittest.main()
