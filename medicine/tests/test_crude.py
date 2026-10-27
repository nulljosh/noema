import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import crude


class CrudeTests(unittest.TestCase):
    def far(self, text):
        return [f[0] for f in crude.flags(text)]

    def test_far(self):
        for text in ('Discharge was possible in 52.9% vs 71% (OR 4.75; 95% CI 2.1-10.8).',
                     'Rehospitalization was higher (76.1% vs. 48.8%, univariate OR 1.778).'):
            self.assertEqual(self.far(text), [True], text)

    def test_fits(self):
        for text in ('Mortality was 20% vs 10% (RR 0.50).', 'Cure was 85.5% vs. 73.1% (RR=1.85).',
                     'Abstinence was 31.4% vs. 25.3% (OR=1.35).', 'Failure was 27.6% vs 48.8% (relative risk, 0.57).'):
            self.assertEqual(self.far(text), [False], text)

    def test_skipped(self):
        for text in ('Death was 20% vs 10% (adjusted OR 5.0).', 'Use was 82.4% vs. 17.6% (OR 0.869).',
                     'Pain was 41% and 40% (RR at 12 months 1.0).'):
            self.assertEqual(self.far(text), [], text)


if __name__ == '__main__':
    unittest.main()
