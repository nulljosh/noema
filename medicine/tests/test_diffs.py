import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import diffs


class DiffTests(unittest.TestCase):
    def kinds(self, text):
        return [f[0] for f in diffs.flags(text)]

    def test_mismatches(self):
        self.assertEqual(self.kinds('Lower BP (MD -2.3 mmHg, 95% CI -4.1 to -0.5; P = 0.40).'), ['verdict'])
        self.assertEqual(self.kinds('Same (MD 0.4, 95% CI -1.0 to 1.8, P = 0.001).'), ['verdict'])
        self.assertEqual(self.kinds('The difference was 3.20%; 95% CI, 3.22% to 9.72%; P = 0.30.'), ['inside'])
        self.assertEqual(self.kinds('Scores fell (adjusted mean difference: -0.50, 95% CI -3.93 to -0.34, p = 0.0001).'), ['pci'])

    def test_clean_and_skipped(self):
        for text in ('Lower BP (MD -2.3, 95% CI -4.1 to -0.5; P = 0.01).',
                     'Weight (mean difference 5.2 kg; 95% CI, 1.1 to 9.3; P = .02).',
                     'Reduced by 2.3 (MD 2.3, 95% CI -4.1 to -0.5, P=0.01).',
                     'Small trial (difference -5096.0 kJ; 95% CI -7000.0, -3192.1; P = .0001).',
                     'No difference in OS (HR, 1.22; 95% CI, 0.90-1.64; P = .20).',
                     'Severity (OR difference = 1.005 [95% CI: 0.972, 1.040]; p = 0.762).',
                     'More fluid (difference=975 mL; 95% CI -450 to 1,725 mL).',
                     'Rates (RD 14.1%, 95% CI 0.042 to 0.235; P = 0.005).',
                     'Noninferior (difference 1.0, 95% CI -0.5 to 2.5, P = 0.001).'):
            self.assertEqual(self.kinds(text), [], text)


if __name__ == '__main__':
    unittest.main()
