# Noema loop handoff (2026-10-27)

## What a loop is

A finite foreground cycle. State one exact question, compute inside a fixed bound, check a second way, keep failures and baselines visible, separate what was observed from what was proved. Stop when the cycle's work is done. No paid models, background jobs or automatic pushes. Run one lane per cycle and alternate lanes between cycles so neither goes stale.

## Tick protocol (every loop tick, in order)

1. Read `roadmap.md`. Rotate lanes in ledger order (math, cs, physics, chemistry, medicine, statistics, biology, then any queued field): take the lane whose last ledger row is oldest. Starting a queued field counts as that lane's tick.
2. Run the lane's tests before touching anything. A red baseline is the tick's only job.
3. Do one bounded study: an exact question, a fixed bound, a stop condition.
4. Check it a second way: an independent implementation, a numeric check of a symbolic result, or a primary source (OEIS, the paper, UniProt, ClinVar).
5. Search the literature before thinking it is new. A match means "reproduced", which is still a win and becomes a regression test.
6. Write the ledger row in `ledger.md` (claim, level, second check, literature, status). Mark the roadmap item done and add the one to three sharper questions the result raised to Frontier or the lane roadmap.
7. Commit and push only the lab's paths. Then re-arm.

**Discovery gate.** A row may say "candidate" only if it is reproducible from a committed command, passes a second check, and has no match after a real literature search. It may say "breakthrough" only after that, plus a written or machine-checked argument for anything universal, plus a written description someone outside the lab could check. Finite checks never become universal claims.

## Where things stand

Math: SAT checked 18,069 formulas; Goldbach and Collatz stopping cover 10,000; first descent covers starts 2 through 1,000,000 with two implementations agreeing (max 287 steps at 626,331). Written algebra covers 28 of 32 classes modulo 32; Lean 4.35.0 checks three of those lemmas (4k+1, 32k+11, 32k+23). Lean comes from `brew install elan-init`; `lake build` in `math/proofs` fetches the pinned toolchain. Sixteen tests.

Biology: the pinned HBB reference, 1,332 single-base substitutions, and 256 UniProt annotations reproduced (two outside a one-base explanation, three complex ones excluded). Hb Bristol explained with sources. Eleven tests.

Computer science: every 2-, 3- and 4-state machine and every 2-state 3-symbol machine is settled in Python. BB(3) = 21 and BB(2,3) = 38 are proved in full in Lean (`FAR.bb3`, `FAR.bb23`), axioms propext and Quot.sound only. `halters.c` counts every halting machine and sums the halting times. At 5 states it gives 26,751,695,615,616 halters, exactly A004147(5), and a sum of 64,068,865,333,248, a new fifth term for A386859. The OEIS edit waits on Joshua in `docs/OEIS-A386859.md`. The runtime spectrum is 1, 6, 21, 79, 1,207 distinct runtimes for 1 to 5 states, an open question in Aaronson's Busy Beaver Frontier. It has no OEIS entry yet. The 5-state run takes about 3 hours on six cores. Rerun with `./halters 5 2 47176870 3 6 I`, and keep `halters-5.json` curated.

Medicine: landmark trials recomputed from their counts; 235,860 abstracts scanned for numbers that contradict themselves. On ClinicalTrials.gov, `registry.py` checks baseline Totals: 328 equal the plain average of unequal arms, and 407 Total SDs cannot come from any arm sizes. `analyses.py` checks outcome analyses: 61 CIs in 52 trials have a limit with the wrong sign, which the posted p-value confirms. Raw downloads live in the session scratchpad and are refetched with `fetch`.

Both sites now deploy as one from `./deploy.sh` (last deploy 2026-10-27).

## Restart prompts

Math lane:

```text
Continue Noema's math lane. Read CLAUDE.md, math/CLAUDE.md, math/WHITEPAPER.md, math/docs/RESEARCH.md, math/proofs/README.md and roadmap.md. In math/, run the Python tests, python3 mathlab.py benchmark, python3 descent.py and lake build in proofs/. Derive forced affine prefixes for remainders 7, 15, 27 and 31 modulo 32 when split modulo 64, before any numerical comparison. Keep the bound at one million. Preserve parity branches, failures and the frozen baseline. Report proof status and measured results separately. No paid models, background jobs or universal claims from finite checks. Stop when the cycle ends.
```

Biology lane:

```text
Continue Noema's biology lane. Read CLAUDE.md, biology/CLAUDE.md, biology/WHITEPAPER.md and biology/benchmarks/README.md. In biology/, run uv run evidna.py benchmark and inspect regressions before changing anything. Then take the next open item in roadmap.md in one small, tested change: first the held-out hypothesis-quality benchmark with predeclared scoring, then a second public gene with independently specified expected cases. Update the whitepaper and landing findings only with measured evidence. Keep evidence provenance separate from sequence correctness. No Claude calls, background jobs or instrument code. Stop when useful work is done and report results and remaining limits.
```

CS lane:

```text
Continue Noema's CS lane. Read CLAUDE.md, cs/CLAUDE.md, cs/README.md and ledger.md. In cs/, run python3 -m unittest discover -s tests. Next: draft an OEIS entry for the runtime spectrum (1, 6, 21, 79, 1207) for Joshua, then run halters.c on 2 states and 4 symbols with cap 3932964 and report how many nodes reach the cap before claiming anything. Every claim names its level. No universal claims from finite checks. Stop when the cycle ends.
```

Medicine lane:

```text
Continue Noema's medicine lane. Read CLAUDE.md, medicine/CLAUDE.md, medicine/README.md and ledger.md. Run python3 -m unittest discover -s tests. Next: hand-read a seeded sample of the 61 sign slips in registry-ci-sign.json and the 407 SD rows in registry-sd.json, and record what each one is. A mismatch with a paper is an open note until the full text is read. NCBI calls use tool=noema only. Stop when the cycle ends.
```

Cross-lab (use when both lanes are quiet):

```text
Continue Noema across every lane. Read CLAUDE.md and roadmap.md. Build the claims ledger: a claims.json in each lane with claim, exact domain, bound, level (observed, written, machine-checked, literature) and source, then make each landing page render its claims from it. Add the Fieldbook links. Run every lane's tests and ./deploy.sh's checks, but do not deploy without Joshua's yes. Stop at the end of the cycle.
```
