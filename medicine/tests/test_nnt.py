import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import nnt


class NntTests(unittest.TestCase):
    def kinds(self, text):
        return [f[0] for f in nnt.flags(text)]

    def test_mismatches(self):
        self.assertEqual(self.kinds('The absolute risk reduction was 5% (NNT 50).'), ['nnt'])
        self.assertEqual(self.kinds('Mortality was 12.0% vs 8.0% (NNT 10).'), ['nnt'])
        self.assertEqual(self.kinds('A relative risk reduction of 40% (RR 0.80; 95% CI 0.7-0.9).'), ['rrr'])

    def test_clean_and_skipped(self):
        for text in ('The absolute risk reduction was 5% (NNT 20).', 'Mortality was 12.0% vs 8.0% (NNT 25).',
                     'RRR 20% (HR 0.80).', 'ARR 0.031, NNT 33.', 'ARR 3.1% (NNT 33 over 5 years).',
                     'ARR 5 per 1000 (NNT 200).', 'An ARR of 4 (NNT 25).'):
            self.assertEqual(self.kinds(text), [], text)


if __name__ == '__main__':
    unittest.main()
