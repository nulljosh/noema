import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import spread


class SpreadTests(unittest.TestCase):
    def test_impossible_values_flagged(self):
        for text in ('Score was higher (10 [IQR 7-7] vs 9 [5-11]).', 'Median follow-up was 22.9 months (IQR 27.5-33.3).',
                     'The median was 8 months (range 1-6).'):
            self.assertEqual(len(list(spread.flags(text))), 1, text)

    def test_false_alarms_skipped(self):
        for text in ('Median BMI was 29.8 kg/m 2 (IQR 27.0-34.2).', 'Pain was 8/10 (interquartile range, 6, 8).',
                     'Mean age 32.15 ± 4.58 (range, 25-45) years.', 'A score of 20 out of 30 (range 13-26).',
                     'A decrease of 29.2 (interquartile range = -58.3 to -4.2).', 'Median 225 mm 2 [IQR 150 to 325].',
                     'Median 4.9 (IQR 3.1-6.0).'):
            self.assertEqual(list(spread.flags(text)), [], text)


if __name__ == '__main__':
    unittest.main()
