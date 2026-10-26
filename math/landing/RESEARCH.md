# Research ladder

Start with easy experiments, not promises of easy open problems. This order describes the prerequisites and cost of our next study, not a ranking of mathematical difficulty. Number theory does not form a chain of implications leading to P versus NP.

| Stage | Question | Evidence and next gate |
| --- | --- | --- |
| 0 | Do reference calculations reproduce known answers? | SAT controls, known primes, Collatz 27 and powers of two. Tests before larger runs. |
| 1 | Is unit propagation complete on the small SAT corpus? | No. Replay the saved four-clause unsatisfiable example. |
| 2 | Does strong Goldbach hold through 10,000? | Bounded reproduction completed. Prime-pair witnesses independently checked. |
| 3 | Do Collatz starts through 10,000 reach one within 1,000 steps? | Yes. Next: first descent below the starting value. |
| 4 | How do twin counts and consecutive-prime gaps grow? | Finite pair counts complete. Next: gap records on disjoint intervals. |
| 5 | How does branching behave on structured SAT families? | Next SAT experiment: tiny pigeonhole formulas and a truth-table-checked DPLL implementation. |
| 6 | What would settle P versus NP or Riemann? | Literature and exact proof obligations only. No asymptotic conclusions from timing curves. |

## Initial results

SAT: 18,069 syntactic formulas, zero incorrect decisions or invalid SAT witnesses. Propagation stalled on 9,824 satisfiable and 10 unsatisfiable cases. Labelled variables and clause sets are counted, not distinct Boolean functions or random SAT inputs.

Goldbach: all 4,999 even integers from four through 10,000 had witnesses. The largest minimum prime addend was 173, first attained at 7,426 = 173 + 7,253. This is far below published verification work.

Collatz: all 10,000 starts reached one. Start 6,171 had the longest total stopping time, 261 ordinary steps. Its trajectory peaked at 975,400; this is not a claim about the largest peak of all starts. There were 205 twin-prime pairs with both endpoints at most 10,000.

## A small proved statement

For every nonnegative integer k, the Collatz orbit of 2^k reaches one after exactly k steps. Each positive power of two is even, so halving decreases its exponent by one. The first exponent zero occurs after k steps. This elementary established argument is a proof. Testing twenty powers only checks the implementation.

The four two-variable SAT clauses rule out all assignments and have no unit clause. Allowing unused variables extends this example to any larger variable count. This proves plain unit propagation is incomplete on arbitrary CNF; it says nothing about all SAT algorithms.

## Next predeclared experiment

For Collatz starts two through 10,000, find the first ordinary step below the start, capped at 1,000 steps. Independently replay the record cases. Report cap hits as unresolved. A finite maximum is a dataset statistic, not a universal bound. Proving eventual descent for every integer greater than one would yield termination by strong induction. Our finite checks do not supply that quantifier.

## Primary sources, consulted October 14, 2026

[Cook's official statement](https://www.claymath.org/wp-content/uploads/2022/06/pvsnp.pdf) gives the formal framework. [Clay](https://www.claymath.org/millennium/p-vs-np/) lists P versus NP as unsolved.

[Oliveira e Silva, Herzog and Pardi](https://sweet.ua.pt/tos/bib/4.12.html) reports even-Goldbach verification through 4 x 10^18. Strong Goldbach concerns two prime summands for each even number greater than two; it differs from the proved three-prime weak theorem.

[Tao, 2019](https://arxiv.org/abs/1909.03562) proves an almost-all result for Collatz orbits, not termination for every positive integer.

[Maynard, On the Twin Prime Conjecture](https://arxiv.org/abs/1910.14674) discusses prime-gap progress. A finite pair count cannot prove infinitely many pairs.

[Clay's Riemann description](https://www.claymath.org/millennium/riemann-hypothesis/) concerns nontrivial zeta zeros. No zeta-zero experiment has been performed here.

[Aaronson and Wigderson](https://www.scottaaronson.com/papers/alg.pdf) describes relativization, due to Baker, Gill and Solovay, and develops algebrization. [Razborov and Rudich](https://www.sciencedirect.com/science/article/pii/S002200009791494X) gives a natural-proofs barrier under a hardness assumption. These barriers do not prove P != NP.

## Recent work watchlist

Reviewed October 14, 2026. [Barina's 2025 peer-reviewed verification paper](https://link.springer.com/article/10.1007/s11227-025-07337-0) and [author's project](https://pcbarina.fit.vut.cz/) report a verification milestone below 2^71. This is finite computation, not a Collatz proof; Noema is not attempting to beat it. Read its sieve and congruence-class methods before considering larger verification runs.

[Paradoxical behavior in Collatz sequences, 2025 preprint](https://arxiv.org/abs/2502.00948) concerns stopping-time behavior and trajectories exceeding their starting value. Review the paper's exact iteration convention before comparing counts: some Collatz maps combine an odd step with a halving, while Noema counts those separately. This is a literature lead, not an endorsed proof or a reproduced result.

[New Algebrization Barriers to Circuit Lower Bounds via Communication Complexity of Missing-String, 2025 preprint](https://arxiv.org/abs/2511.14038) is a later complexity-theory reading lead. Check its exact theorem statements and publication status before selecting an experiment. Noema has not verified its proofs.

At each research session, refresh sources before adding a new direction. Add the date, primary source, claim, publication status, prerequisites and smallest testable question. A new preprint does not automatically become a priority or an accepted theorem.

## First-descent calculation, October 14, 2026

The ordinary Collatz map counts an odd 3n+1 step separately from the following halving. For every start from two through the stated bound, the study finds the first value strictly below that start. One is excluded because it has no smaller positive target. Each start is cross-checked with a separate implementation that combines odd steps with their next halving, then restores the ordinary-step count.

| Upper bound | Starts checked | Unresolved at 1,000 steps | First start with longest descent | Steps | First lower value |
| --- | ---: | ---: | ---: | ---: | ---: |
| 10,000 | 9,999 | 0 | 703 | 132 | 628 |
| 100,000 | 99,999 | 0 | 35,655 | 220 | 29,405 |
| 1,000,000 | 999,999 | 0 | 626,331 | 287 | 597,017 |

No implementation disagreements occurred. The three stages overlap and must not be summed. The longest first descent is distinct from total stopping time to one. This finite reproduction does not prove every integer eventually descends. The complete report is landing/descent.json; run python3 descent.py to reproduce it. The study is software-checked, not proof-assistant-certified or a verification record.

## Cycle 2 protocol: remainder groups

Before running: preserve the existing starts 2 through 1,000,000, ordinary-step convention and 1,000-step cap. Group each start by its remainder after division by 8 and 16. Report counts, unresolved cases, minimum first-descent time and the first case attaining each group's maximum. Compare every trajectory with the existing accelerated checker, and preserve the previous stream digest and aggregate measurements as a regression baseline.

Predeclared controls: even starts descend in one step; starts 4k+1 with k >= 1 descend in exactly three. Reject the run if either control fails, group totals differ from the full corpus, or existing measurements change. Inspect any further class pattern with an algebraic proof. Agreement in a bounded group alone does not establish its infinite analogue.

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

## Cycle 3 protocol: forced prefixes modulo 32

Before numerical comparison: split only remainders 7, 11 and 15 modulo 16 into remainders 7, 11, 15, 23, 27 and 31 modulo 32. Keep starts two through one million and the ordinary 1,000-step cap. Derive each affine prefix 32k+r for k >= 0 by applying a step only while its parity is fixed for all k. Stop at a uniformly smaller term or at a term whose parity depends on k.

| Remainder | Forced steps | Affine prefix | Stop reason |
| --- | ---: | --- | --- |
| 7 | 9 | 32k+7 → 96k+22 → 48k+11 → 144k+34 → 72k+17 → 216k+52 → 108k+26 → 54k+13 → 162k+40 → 81k+20 | next parity depends on k |
| 11 | 8 | 32k+11 → 96k+34 → 48k+17 → 144k+52 → 72k+26 → 36k+13 → 108k+40 → 54k+20 → 27k+10 | strictly below the start for every k >= 0 |
| 15 | 9 | 32k+15 → 96k+46 → 48k+23 → 144k+70 → 72k+35 → 216k+106 → 108k+53 → 324k+160 → 162k+80 → 81k+40 | next parity depends on k |
| 23 | 8 | 32k+23 → 96k+70 → 48k+35 → 144k+106 → 72k+53 → 216k+160 → 108k+80 → 54k+40 → 27k+20 | strictly below the start for every k >= 0 |
| 27 | 9 | 32k+27 → 96k+82 → 48k+41 → 144k+124 → 72k+62 → 36k+31 → 108k+94 → 54k+47 → 162k+142 → 81k+71 | next parity depends on k |
| 31 | 10 | 32k+31 → 96k+94 → 48k+47 → 144k+142 → 72k+71 → 216k+214 → 108k+107 → 324k+322 → 162k+161 → 486k+484 → 243k+242 | next parity depends on k |

For remainders 11 and 23, the eighth terms are 27k+10 and 27k+20. They are below 32k+11 and 32k+23 by 5k+1 and 5k+3. Every preceding affine term has both its coefficient and constant greater than those of the start. Thus there is no earlier descent. Predeclared controls: these two groups have exact first-descent time eight; reject a numerical run if this fails, an earlier baseline changes, or the six group counts fail to partition their parent groups. No constant first-descent time is predicted for the other four groups.

Formal-check target: the exact three-step first descent of 4k+1 for positive k. Use the actual ordinary Collatz function, all earlier steps, and a universally quantified integer parameter. No finite enumeration, Collatz assumption, new axiom or unfinished proof is acceptable.

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

Lean 4.35.0 checked the universally quantified exact three-step lemma for 4k+1 with k >= 1. The definition includes the actual ordinary Collatz iteration and all earlier steps. The proof uses standard Lean logic, no new axiom, no Collatz assumption, no unfinished proof and no finite-case enumeration. Both direct checking with warnings as errors and lake build succeeded locally. Its dependency report lists only propext and Quot.sound. The written eight-step lemmas have not yet been checked in Lean.

The downloadable Noema.lean and proof-check.json identify exactly what was checked. Lean verification of one lemma is not verification of the Python corpus, the entire whitepaper, other written arguments, or a termination theorem.
