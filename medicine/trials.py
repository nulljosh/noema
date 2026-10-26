"""Recompute landmark trial results from the counts the papers print.

    python3 trials.py

Counts are copied from the abstract named in each row. The Peto one-step odds ratio is
what ISIS-2 reported; the plain (Woolf) odds ratio is a second, independent check.
"""
import math

# (label, deaths on treatment, n treatment, deaths on control, n control, reported odds reduction %, reported SD %)
ISIS2 = {
    "source": "ISIS-2 Collaborative Group, Lancet 1988;2:349-60, PMID 2899772, 5-week vascular deaths",
    "rows": [
        ("streptokinase vs placebo infusion", 791, 8592, 1029, 8595, 25, 4),
        ("aspirin vs placebo tablets", 804, 8587, 1016, 8600, 23, 4),
        ("both vs neither", 343, 4292, 568, 4300, 42, 5),  # paper also gives 95% limits 34-50
    ],
}


def peto(a, n1, c, n2):
    """Peto one-step odds ratio: log OR = (O - E) / V, SD of log OR = 1 / sqrt(V)."""
    N, d = n1 + n2, a + c
    E = n1 * d / N
    V = E * (n2 / N) * (N - d) / (N - 1)
    return (a - E) / V, 1 / math.sqrt(V)


def woolf(a, n1, c, n2):
    """Plain odds ratio with the Woolf standard error."""
    b, d = n1 - a, n2 - c
    return math.log(a * d / (b * c)), math.sqrt(1 / a + 1 / b + 1 / c + 1 / d)


def recompute(rows=ISIS2["rows"]):
    out = []
    for label, a, n1, c, n2, reported, reported_sd in rows:
        lo, s = peto(a, n1, c, n2)
        wlo, _ = woolf(a, n1, c, n2)
        out.append({
            "label": label, "risk_treated": a / n1, "risk_control": c / n2,
            "odds_reduction": 1 - math.exp(lo),
            "sd": math.exp(lo) * s,  # delta method, as a percentage-point SD on the odds reduction
            "ci95": (1 - math.exp(lo + 1.96 * s), 1 - math.exp(lo - 1.96 * s)),
            "woolf_odds_reduction": 1 - math.exp(wlo),
            "reported": reported, "reported_sd": reported_sd,
        })
    return out


if __name__ == "__main__":
    print(ISIS2["source"])
    for r in recompute():
        lo, hi = r["ci95"]
        print(f"{r['label']:35} {r['risk_treated']:.1%} vs {r['risk_control']:.1%}  "
              f"odds reduction {r['odds_reduction']:.1%} SD {r['sd']:.1%} (95% {lo:.0%} to {hi:.0%})  "
              f"Woolf {r['woolf_odds_reduction']:.1%}  paper {r['reported']}% SD {r['reported_sd']}")
