# Noema Technical Whitepaper

**v0.1.0** | October 2026

Noema is a mathematics lab built around precise questions, bounded computations and honest records. It borrows Evidna's finite foreground evidence loop. The first studies cover SAT, Goldbach, Collatz and twin primes.

## The core mechanic

State the finite domain before running a test.
Use a direct reference calculation or independent algorithm to check results.
Retain the domain and engine fingerprints, counts and representative cases.
Compare against a fixed regression baseline before updating accepted findings.
A larger finite bound extends coverage. It does not prove an infinite conjecture.

## SAT study

Enumerate one through three labelled variables and up to four distinct clauses.
Clauses are nonempty, have distinct variables and exclude tautologies.
There are 3^n - 1 possible clauses; select subsets in canonical order.
The empty formula is included. A truth table decides each case.
Plain unit propagation either decides a formula or reports that it stalled.
Every reported SAT assignment is checked against the original formula.
The four possible two-variable clauses together rule out all four assignments.
They have no unit clause, so propagation stalls despite unsatisfiability.
This is a known limitation of a restricted solver, not a new lower bound.

## Number theory

Check bounds 100, 1,000 and 10,000 in order.
Find a prime pair for each even number from four through each bound.
Trial division independently checks sieve membership and selected witnesses.
Follow each positive Collatz start through at most 1,000 ordinary steps.
A cap hit means unresolved, never divergence.
Count twin-prime pairs with both endpoints in each interval.
Overlapping stages cannot be added as independent evidence.

## Proof obligations

[Cook's official statement](https://www.claymath.org/wp-content/uploads/2022/06/pvsnp.pdf) defines P, NP and NP-completeness.
A polynomial-time algorithm for all SAT inputs would establish P = NP.
A lower bound for one solver does not establish P != NP.
[Algebrization](https://www.scottaaronson.com/papers/alg.pdf) describes barriers to broad classes of techniques.
[Natural proofs](https://www.sciencedirect.com/science/article/pii/S002200009791494X) gives a conditional barrier for certain general circuit lower-bound arguments.
Future proof proposals must specify their model, quantifiers and relevant barrier assumptions.

## Limits

No open conjecture has been solved. These studies reproduce small known results.
Baselines detect changed behavior; they are not external mathematical certification.
No AI calls, daemon, autonomous publishing or formal proof assistant runs.
The viewer contains bounded interactive examples and Python-generated reports.
Sources and the next experiment are in docs/RESEARCH.md.

<!-- research-loop:start -->
## Latest measured run

Updated 2026-10-14T16:49:01.323181+00:00.
Checked 18,069 formulas. Soundness errors: 0.
Unit propagation stalled on 9,824 satisfiable and 10 unsatisfiable formulas.
This finite result measures one restricted algorithm, not P versus NP.
<!-- research-loop:end -->

MIT License · Copyright 2026 Joshua Trommel.

## Living research record

The roadmap advances from known controls to bounded number theory, structured SAT and proof obligations. New sources enter a dated literature queue before an experiment is selected. The current watchlist includes Barina's 2025 Collatz verification methods and two 2025 preprints on stopping-time behavior and algebrization. See docs/RESEARCH.md for sources, publication status and unreproduced claims.

The Noema identity uses a single-color N within a circle and an exact clrs.cc base palette. The public brand kit contains constrained SVG variants, CSS and JSON tokens, typography and accessibility rules. Browser examples remain separate from Python-generated research records.

## First-descent calculation, October 14, 2026

The ordinary Collatz map counts an odd 3n+1 step separately from the following halving. For every start from two through the stated bound, the study finds the first value strictly below that start. One is excluded because it has no smaller positive target. Each start is cross-checked with a separate implementation that combines odd steps with their next halving, then restores the ordinary-step count.

| Upper bound | Starts checked | Unresolved at 1,000 steps | First start with longest descent | Steps | First lower value |
| --- | ---: | ---: | ---: | ---: | ---: |
| 10,000 | 9,999 | 0 | 703 | 132 | 628 |
| 100,000 | 99,999 | 0 | 35,655 | 220 | 29,405 |
| 1,000,000 | 999,999 | 0 | 626,331 | 287 | 597,017 |

No implementation disagreements occurred. The three stages overlap and must not be summed. The longest first descent is distinct from total stopping time to one. This finite reproduction does not prove every integer eventually descends. The complete report is landing/descent.json; run python3 descent.py to reproduce it. The study is software-checked, not proof-assistant-certified or a verification record.

## Cycle 2: three elementary proofs

These are established elementary Collatz facts, reproduced here rather than claimed as new mathematics. Counts use the ordinary map T(n) = n/2 for even n and T(n) = 3n+1 for odd n. A first descent must be strictly below the start, and every earlier term must still be at least that start.

**Even starts.** For n >= 2 even, T(n) = n/2 < n. First descent takes exactly one step.

**Starts 4k+1, k >= 1.** Their first three steps are

`4k+1 → 12k+4 → 6k+2 → 3k+1`.

The first two terms exceed the start: their differences from it are 8k+3 and 2k+1. The third is smaller by k. Therefore first descent takes exactly three ordinary steps. The exception k=0 gives start one and is excluded.

**Starts 16k+3, k >= 0.** Their first six steps are

`16k+3 → 48k+10 → 24k+5 → 72k+16 → 36k+8 → 18k+4 → 9k+2`.

The displayed parity choices hold for every nonnegative integer k. The first five differences from the start are 32k+7, 8k+2, 56k+13, 20k+5 and 2k+1, all positive. The sixth term is smaller by 7k+1. Therefore first descent takes exactly six ordinary steps.

Together these arguments cover the eight even remainders modulo 16, the four remainders 1, 5, 9 and 13, and remainder 3. That is 13 of 16 residue classes, with start one excluded. It is not a proof that these classes are invariant under iteration; the arguments establish first descent from each start in a covered class. A descent may land in an uncovered class. They therefore do not prove Collatz even for every start in the covered classes without an additional termination argument.

## Cycle 2 measurements

The same 999,999 starts from two through one million were grouped modulo 8 and 16. All earlier trajectory digests and aggregate measurements matched the frozen first-descent-v1 baseline. The v2 report adds group summaries. All group totals matched the full corpus, every accelerated cross-check agreed, and the proved 1-, 3- and 6-step cases matched computation.

| Remainder modulo 16 | Starts checked | Observed minimum first descent | Observed maximum | First start attaining maximum |
| --- | ---: | ---: | ---: | ---: |
| 7 | 62,500 | 8 | 269 | 362,343 |
| 11 | 62,500 | 8 | 287 | 626,331 |
| 15 | 62,500 | 11 | 285 | 667,375 |

These three remaining groups account for 187,500 checked starts. Every one descended within the cap, but no infinite descent theorem is supplied for those groups. The maximum values in this table are finite observations, not universal bounds. Grouping starts does not establish an inductive invariant or rule out a cycle.

## Next predeclared question

Split only remainders 7, 11 and 15 into the corresponding classes modulo 32, keeping the bound fixed. Derive the forced initial affine paths before running the comparison. Seek an exact first-descent lemma or an explicit exception, then keep any variable-length branches visible. Do not confuse a fixed prefix or an average decrease with eventual descent for every start.

## Cycle 3 results and first formal check

The six selected modulo-32 groups partition the three prior parent groups. All earlier trajectory digests and aggregate measurements still match the frozen baseline. Each group contains 31,250 starts at the one-million bound. No case was unresolved and the independent implementations agreed.

| Remainder modulo 32 | Starts checked | Minimum first descent | Maximum in this range | First start attaining maximum |
| --- | ---: | ---: | ---: | ---: |
| 7 | 31,250 | 11 | 269 | 362,343 |
| 11 | 31,250 | 8 | 8 | 11 |
| 15 | 31,250 | 11 | 285 | 667,375 |
| 23 | 31,250 | 8 | 8 | 23 |
| 27 | 31,250 | 11 | 287 | 626,331 |
| 31 | 31,250 | 13 | 282 | 381,727 |

The algebraic eight-step predictions for remainders 11 and 23 matched every checked case. Together with the previous written arguments, first descent is established algebraically for 28 of 32 residue classes, excluding start one. Four classes remain outside those arguments: 7, 15, 27 and 31. The maximum values above are finite observations, not universal bounds. No novel mathematical result is claimed.

Lean 4.35.0 checked three universally quantified exact lemmas: the three-step lemma for 4k+1 with k >= 1, and the eight-step lemmas for 32k+11 and 32k+23 with all k >= 0. The definition includes the actual ordinary Collatz iteration and all earlier steps. The proof uses standard Lean logic, no new axiom, no Collatz assumption, no unfinished proof and no finite-case enumeration. Both direct checking with warnings as errors and lake build succeeded locally. The dependency report for each lists only propext and Quot.sound. The other written first-descent arguments have not yet been checked in Lean.

The downloadable Noema.lean and proof-check.json identify exactly what was checked. Lean verification of three lemmas is not verification of the Python corpus, the entire whitepaper, other written arguments, or a termination theorem.

## Cycle 4: the modulo-64 split and the residue tree (October 26, 2026)

Lean 4.35.0 now also checks the exact eight-step first-descent lemmas for 32k+11 and 32k+23, for every k >= 0, with the same definitions and only the axioms propext and Quot.sound.

The four remaining classes modulo 32 were split modulo 64 symbolically, before any numeric comparison. None of the eight classes (7, 39, 15, 47, 27, 59, 31, 63) resolves. Each runs 10 to 12 forced steps, then reaches coefficient 81, 243 or 729, where the next parity depends on k and the value is still above the start.

`python3 descent.py tree` repeats that split for every class up to 2^20. A class closes when its forced affine prefix falls below the start for every member, excluding starts 0 and 1. The open counts for m = 1 to 20 are 1, 1, 2, 3, 4, 8, 13, 19, 38, 64, 128, 226, 367, 734, 1,295, 2,114, 4,228, 7,495, 14,990 and 27,328. They match OEIS A076227 term for term. A second check runs ordinary first descent on sampled members of every closed class through 2^12, and none descends later than its class predicts. This reproduces a known sequence; it is a correctness check of the engine, not a new result. Open classes are not counterexamples.
