# Noema loop handoff (2026-10-27, night)

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

Computer science: every 2-, 3- and 4-state machine and every 2-state 3-symbol machine is settled in Python. BB(2) = 6, BB(3) = 21 and BB(2,3) = 38 are proved in full in Lean (`FAR.bb2`, `FAR.bb3`, `FAR.bb23`), `Count2.lean` machine-checks A004147(2) and A386859(2) over all 20,736 two-state tables, and `Count3.lean` machine-checks A004147(3), A386859(3) and R(3) = 21 by a tree-counting theorem (`CountTree.lean`), in 182 pieces from `count_lean.py`. Axioms propext and Quot.sound only. `halters.c` counts every halting machine and sums the halting times. At 5 states it gives 26,751,695,615,616 halters, exactly A004147(5), and a sum of 64,068,865,333,248, a new fifth term for A386859 (OEIS edit waits on Joshua, `docs/OEIS-A386859.md`). The runtime spectrum is 1, 6, 21, 79, 1,207 for 1 to 5 states; `runtimes.py`, a plain walk sharing no code with halters.c, agrees through 4 states (draft for Joshua in `docs/OEIS-runtime-spectrum.md`). The runner-up 23,554,764 is Marxen and Buntrock's, not ours. `plainwalk.c`, a decider-free C walk, matches the 5-state count to step 2000 exactly (919 runtimes), and with A004147(5) that shows the 333 long halters are complete. `platypus.py` adds the ones each halter leaves: 74 is the smallest count no 5-state machine prints, and PP(n) (A399346, Placid Platypus) is now known for n = 1 to 130, where OEIS has 37 (edit drafted in `docs/OEIS-A399346.md`). `circular.c` extends A394183 (2-state machines on a circular tape) from 19 to 27 terms. `sortnet.py` reproduces optimal sorting networks to 7 inputs. Novelty report: `docs/reports/Noema candidates novelty check.md`.

Medicine: 235,860 abstracts scanned for numbers that contradict themselves. On ClinicalTrials.gov (details in `medicine/docs/REGISTRY.md`): 328 baseline Totals are the plain average of unequal arms; 407 Total SDs cannot come from any arm sizes, and 71 of the too-wide ones fit once the arms are read as standard errors; 61 CIs in 52 trials have a sign slip the p-value confirms; 292 outcome intervals in 90 trials are labelled SD but fit standard errors (`registry-spread.json`, with a scale rule that drops mixed units); linked papers confirm it: 15 of the 16 that print the flagged values and name the spread say SE, and the 16th shows a wrong registry interval instead. One-sided P values posted without a label explain most interval-versus-P clashes. The Salk primary source (AJPH 1955, PMID 14361811) has no open copy. Raw downloads live in the session scratchpad: `analyses.py fetch` and `fetch-arms`, `registry.py fetch`.

Physics: the triangular closed form and 2n + 1 bound are not in OEIS or the arXiv sources read on 2026-10-27; three papers that could settle novelty block scripts (see roadmap). Krawczyk citation fixed.

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
Continue Noema's CS lane. Read CLAUDE.md, cs/CLAUDE.md, cs/README.md and ledger.md. In cs/, run python3 -m unittest discover -s tests. Next: sorting networks at 8 inputs (19) with permutation symmetry, or prove the mirror and state-swap weights sound in CountTree.lean so the 4-state counts come within reach. Every claim names its level. No universal claims from finite checks. Stop when the cycle ends.
```

Medicine lane:

```text
Continue Noema's medicine lane. Read CLAUDE.md, medicine/CLAUDE.md, medicine/README.md and ledger.md. Run python3 -m unittest discover -s tests. Next: flag mixed units in the SD-label check (arms and difference on different scales), then read a seeded sample of the 61 sign slips against their papers. A mismatch with a paper is an open note until the full text is read. NCBI calls use tool=noema only. Stop when the cycle ends.
```

Cross-lab (use when both lanes are quiet):

```text
Continue Noema across every lane. Read CLAUDE.md and roadmap.md. Build the claims ledger: a claims.json in each lane with claim, exact domain, bound, level (observed, written, machine-checked, literature) and source, then make each landing page render its claims from it. Add the Fieldbook links. Run every lane's tests and ./deploy.sh's checks, but do not deploy without Joshua's yes. Stop at the end of the cycle.
```
