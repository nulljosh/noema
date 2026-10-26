import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import trials  # noqa: E402


class IsisTwoTests(unittest.TestCase):
    def setUp(self):
        self.rows = trials.recompute()

    def test_percentages_match_abstract(self):
        printed = [(9.2, 12.0), (9.4, 11.8), (8.0, 13.2)]
        for r, (t, c) in zip(self.rows, printed):
            self.assertEqual((round(100 * r["risk_treated"], 1), round(100 * r["risk_control"], 1)), (t, c))

    def test_odds_reductions_match_paper(self):
        for r in self.rows:
            self.assertEqual(round(100 * r["odds_reduction"]), r["reported"], r["label"])
            self.assertLess(abs(r["woolf_odds_reduction"] - r["odds_reduction"]), 0.01)  # second method agrees

    def test_combination_limits_match_paper(self):
        lo, hi = self.rows[2]["ci95"]
        self.assertEqual((round(100 * lo), round(100 * hi)), (34, 50))

    def test_sd_discrepancy_stays_visible(self):
        # Single agents recompute to the printed SD 4. The combination recomputes to 4, the paper
        # prints 5, yet its own 34-50 limits imply about 4. Kept as an open note, not an error claim.
        self.assertEqual([round(100 * r["sd"]) for r in self.rows], [4, 4, 4])


if __name__ == "__main__":
    unittest.main()
