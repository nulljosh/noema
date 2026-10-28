import json
import os
import subprocess
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# A332717 rows 1..21 as OEIS had them on 2026-10-28
ROWS = [[1], [1], [1], [1, 2], [1], [1, 9], [1, 14], [1, 2, 8, 16], [1, 3, 7], [1, 5, 15, 25], [1, 7, 110],
        [1, 2, 9, 18], [1, 351], [1, 7, 12, 14, 21, 91], [1, 295], [1, 2, 8, 16, 24, 32], [1, 7, 119, 578],
        [1, 3, 7, 9, 27, 81], [1, 190, 285], [1, 2, 5, 7, 15, 25, 30, 50, 200, 240], [1, 14, 21, 189, 315, 630]]


class Rule110Tests(unittest.TestCase):
    def test_known_rows(self):
        exe = os.path.join(tempfile.mkdtemp(), 'rule110')
        subprocess.run(['cc', '-O2', '-o', exe, os.path.join(HERE, 'rule110.c')], check=True)
        for n, row in enumerate(ROWS, 1):
            out = subprocess.run([exe, str(n)], capture_output=True, text=True, check=True).stdout.split()
            self.assertEqual(list(map(int, out[3:out.index('max')])), row)

    def test_result_file(self):
        r = json.load(open(os.path.join(HERE, 'rule110.json')))
        self.assertEqual(r['rows']['21'], ROWS[20])
        self.assertEqual(len(r['A332718']), 34)


if __name__ == '__main__':
    unittest.main()
