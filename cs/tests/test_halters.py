import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, HERE)
import runtimes  # noqa: E402


def walk(n, m, cap):
    """Plain Python tree walk with no deciders, cut only by the cap."""
    hist = runtimes.walk(n, m, cap)
    return sum(hist.values()), sum(k * v for k, v in hist.items())


class HaltersTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.dir = tempfile.mkdtemp()
        cls.bin = os.path.join(cls.dir, 'halters')
        subprocess.run(['cc', '-O2', '-o', cls.bin, os.path.join(HERE, 'halters.c')], check=True)

    def run_c(self, *args, trig=None):
        env = dict(os.environ, **({'TRIG': str(trig)} if trig else {}))
        out = subprocess.run([self.bin, *map(str, args)], capture_output=True, text=True, env=env, check=True).stdout
        vals = dict(line.split()[:2] for line in out.splitlines() if line.split()[0] in ('halters', 'stepsum'))
        return int(vals['halters']), int(vals['stepsum'])

    def test_known_terms(self):  # A004147 and A386859 for n = 1..4
        for n, cap, halt, steps in ((1, 1, 32, 32), (2, 6, 9784, 13504), (3, 21, 7571840, 13141792),
                                    (4, 107, 11140566368, 23076152576)):
            self.assertEqual(self.run_c(n, 2, cap), (halt, steps))

    def test_runtime_spectrum(self):  # 1, 6, 21 distinct halting times; the first gap is the Lazy Beaver (A337805)
        self.assertEqual([len(runtimes.walk(n, 2, c)) for n, c in ((1, 1), (2, 6), (3, 21))], [1, 6, 21])
        self.assertEqual(len(runtimes.walk(2, 3, 38)), 27)  # 2 states, 3 symbols, as halters.c finds

    def test_plainwalk_agrees(self):  # the decider-free C walk, a second program for the 5-state check below 2000
        exe = os.path.join(self.dir, 'plainwalk')
        subprocess.run(['cc', '-O2', '-o', exe, os.path.join(HERE, 'plainwalk.c')], check=True)
        for n, cap, halt, steps, rts in ((2, 6, 9784, 13504, 6), (3, 21, 7571840, 13141792, 21),
                                         (4, 107, 11140566368, 23076152576, 79)):
            out = subprocess.run([exe, str(n), str(cap)], capture_output=True, text=True, check=True).stdout.split()
            self.assertEqual((int(out[1]), int(out[3]), int(out[5])), (halt, steps, rts))

    def test_python_agrees(self):
        for n, m, cap in ((2, 2, 6), (3, 2, 21), (2, 3, 38)):
            self.assertEqual(self.run_c(n, m, cap), walk(n, m, cap))

    def test_deciders_cut_no_halter(self):  # fire every decider early, past the cap: counts must not move
        for trig in (1, 3, 8, 20):
            self.assertEqual(self.run_c(4, 2, 3000, trig=trig), (11140566368, 23076152576))
            self.assertEqual(self.run_c(2, 3, 500, trig=trig), (16525080, 24319536))  # 2-symbol cuts stay off

    def test_split_adds_up(self):
        parts = [self.run_c(4, 2, 107, 2, 3, i) for i in range(3)]
        self.assertEqual((sum(p[0] for p in parts), sum(p[1] for p in parts)), (11140566368, 23076152576))


if __name__ == '__main__':
    unittest.main()
