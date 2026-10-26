import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import ratios


class RatioTests(unittest.TestCase):
    def kinds(self, text):
        return [f[0] for f in ratios.flags(text)]

    def test_estimate_outside_interval(self):
        self.assertEqual(self.kinds('Death was higher (OR 2.0, 95% CI 0.5-1.8).'), ['inside'])

    def test_verdict_mismatch(self):
        self.assertEqual(self.kinds('Risk rose (OR 1.5; 95% CI 1.2-1.9; P = 0.30).'), ['verdict'])
        self.assertEqual(self.kinds('No change (HR 0.9, 95% CI 0.7 to 1.2, P = 0.01).'), ['verdict'])

    def test_clean_and_borderline(self):
        for text in ('Similar (HR 0.8, 95% CI 0.6-1.1, P = 0.2).', 'Lower (RR 0.7, 95% CI 0.5 to 0.9; P = 0.01).',
                     'Edge (OR 1.4, 95% CI 1.0-2.0, P = 0.08).', 'Edge (OR 1.4, 95% CI 1.1-2.0, P = 0.05).',
                     'Noninferior (HR 1.3, 95% CI 1.1-1.5, P = 0.4).', 'Lower (RR O.77, 95% CI 0.62-0.97).',
                     'Lower (HR,.078; 95% CI, 0.024-0.256).', 'Both lower (HR 0.48, 95% CI 0.37-0.61) (interaction P = .37).'):
            self.assertEqual(self.kinds(text), [], text)


if __name__ == '__main__':
    unittest.main()
