import unittest
from heldout import run, score


class HeldOutTests(unittest.TestCase):
    def test_engine_agrees_with_clinvar_protein_changes(self):
        report = run()
        self.assertEqual(report['engine_disagreements'], [])
        self.assertEqual(report['labeled'], 93)
        self.assertEqual(report['held_out']['predictor_v0']['n'], 28)

    def test_score(self):
        self.assertEqual(score([(1, 1), (0, 0), (1, 0), (0, 0)])['balanced_accuracy'], 0.75)
