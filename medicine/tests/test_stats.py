import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import stats


class StatsTests(unittest.TestCase):
    def verdicts(self, text):
        return [f[0] for f in stats.flags(text)]

    def test_tails(self):
        self.assertAlmostEqual(stats.p_two_sided('t', 2.0, 10), 0.0734, places=4)
        self.assertAlmostEqual(stats.p_two_sided('chi', 9.21, 2), 0.0100, places=4)
        self.assertAlmostEqual(stats.p_two_sided('F', 4.0, 1, 30), 0.0546, places=4)

    def test_gross(self):
        for text in ('t(20) = 1.2, P < 0.05.', 'χ2 = 1.2, P = 0.001.', 't = 1.5, P = 0.02.',
                     'F(1, 38) = 15.41, p = 0.4316.'):
            self.assertEqual(self.verdicts(text), ['gross'], text)

    def test_fits(self):
        for text in ('t(146) = -2.15, P = 0.03.', 'F(1, 55) = 0.39, P = 0.53.', 'z = -3.27, p = 0.001.',
                     'F (45, 1) = 6.07, p = .018.', 't = 1.80, P = 0.04.', 'χ2(2) = 9.21, P = 0.01.'):
            self.assertEqual(self.verdicts(text), [None], text)


if __name__ == '__main__':
    unittest.main()
