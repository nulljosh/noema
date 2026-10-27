import os
import subprocess
import tempfile
import unittest

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def walk(n, m, cap):
    """Plain Python tree walk with no deciders, cut only by the cap."""
    opts, hist, stack = 2 * m * (n + 1), {}, [({}, 1)]
    while stack:
        mach, f = stack.pop()
        tape, pos, q, t = {}, 0, 0, 0
        while t < cap and (q, tape.get(pos, 0)) in mach:
            w, mv, q2 = mach[(q, tape.get(pos, 0))]
            tape[pos], pos, q, t = w, pos + mv, q2, t + 1
        if t == cap:
            continue
        s = tape.get(pos, 0)
        hist[t + 1] = hist.get(t + 1, 0) + f * 2 * m * opts ** (n * m - len(mach) - 1)
        k = 1 + max([x[2] for x in mach.values()] + [0])
        for w in range(m):
            for mv in ((1,) if not mach else (1, -1)):
                for x in range(min(k + 1, n)):
                    g = (n - k if x == k else 1) * (2 if not mach else 1)
                    stack.append(({**mach, (q, s): (w, mv, x)}, f * g))
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
