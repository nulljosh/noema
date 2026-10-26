# Noema loop handoff (2026-10-26)

## What a loop is

A finite foreground cycle. State one exact question, compute inside a fixed bound, check a second way, keep failures and baselines visible, separate what was observed from what was proved. Stop when the cycle's work is done. No paid models, background jobs or automatic pushes. Run one lane per cycle and alternate lanes between cycles so neither goes stale.

## Where things stand

Math: SAT checked 18,069 formulas; Goldbach and Collatz stopping cover 10,000; first descent covers starts 2 through 1,000,000 with two implementations agreeing (max 287 steps at 626,331). Written algebra covers 28 of 32 classes modulo 32; Lean 4.35.0 checks the three-step 4k+1 lemma. Sixteen tests.

Biology: the pinned HBB reference, 1,332 single-base substitutions, and 256 UniProt annotations reproduced (two outside a one-base explanation, three complex ones excluded). Hb Bristol explained with sources. Eleven tests.

Both sites now deploy as one from `./deploy.sh`.

## Restart prompts

Math lane:

```text
Continue Noema's math lane. Read CLAUDE.md, math/CLAUDE.md, math/WHITEPAPER.md, math/docs/RESEARCH.md, math/proofs/README.md and roadmap.md. In math/, run the Python tests, python3 mathlab.py benchmark, python3 descent.py and lake build in proofs/. Formalize the exact eight-step first-descent lemmas for 32k+11 and 32k+23 using the ordinary Collatz map and ruling out every earlier descent. Then derive forced affine prefixes for remainders 7, 15, 27 and 31 modulo 32 when split modulo 64, before any numerical comparison. Keep the bound at one million. Preserve parity branches, failures and the frozen baseline. Report proof status and measured results separately. No paid models, background jobs or universal claims from finite checks. Stop when the cycle ends.
```

Biology lane:

```text
Continue Noema's biology lane. Read CLAUDE.md, biology/CLAUDE.md, biology/WHITEPAPER.md and biology/benchmarks/README.md. In biology/, run uv run evidna.py benchmark and inspect regressions before changing anything. Then take the next open item in roadmap.md in one small, tested change: first the held-out hypothesis-quality benchmark with predeclared scoring, then a second public gene with independently specified expected cases. Update the whitepaper and landing findings only with measured evidence. Keep evidence provenance separate from sequence correctness. No Claude calls, background jobs or instrument code. Stop when useful work is done and report results and remaining limits.
```

Cross-lab (use when both lanes are quiet):

```text
Continue Noema across both labs. Read CLAUDE.md and roadmap.md. Build the claims ledger: a claims.json in math/ and in biology/ with claim, exact domain, bound, level (observed, written, machine-checked, literature) and source, then make each landing page render its claims from it. Add the Fieldbook links. Run both test suites and ./deploy.sh's checks, but do not deploy without Joshua's yes. Stop at the end of the cycle.
```
