import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, HERE)
import platypus

PP177 = '0RB0LB_1RC1RB_1LD0RF_1LB1LD_1LZ1RA_0LA1RE'  # halts with 177 ones in 17,003 steps


class NbhdTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.exe = os.path.join(tempfile.mkdtemp(), 'nbhd')
        subprocess.run(['cc', '-O2', '-o', cls.exe, os.path.join(HERE, 'nbhd.c')], check=True)

    def run_nbhd(self, lo, hi, depth):
        out = subprocess.run([self.exe, '50000', str(lo), str(hi), str(depth)],
                             input='177 %s\n' % PP177, capture_output=True, text=True, check=True).stdout
        return [l.split() for l in out.splitlines()]

    def test_depth_0_is_the_seed_alone(self):
        self.assertEqual(self.run_nbhd(170, 200, 0), [['177', PP177]])

    def test_deeper_finds_more(self):
        counts = [len(self.run_nbhd(170, 200, d)) for d in (0, 1, 2)]
        self.assertEqual(counts[0], 1)
        self.assertLess(counts[0], counts[1])
        self.assertLess(counts[1], counts[2])

    def test_every_hit_really_halts_with_the_ones_it_claims(self):
        for ones, machine in self.run_nbhd(170, 200, 1):
            states, _, got = platypus.sim(machine, 50000)
            self.assertEqual((states, got), (6, int(ones)), machine)


if __name__ == '__main__':
    unittest.main()
