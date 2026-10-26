# Research queue

> Priority tier 5 (2026-10-17): exploratory, this year. Order: live blockers, ship pushes, active features, portfolio, exploratory. See ~/Documents/Code/LOOP-HANDOFF.md.

- [ ] Check tiny pigeonhole formulas and DPLL node counts.
- [ ] Measure prime gaps on disjoint intervals with checked endpoints.
- [ ] Review a specific complexity technique against its computation model and barriers.

Raise one study's scope at a time. Riemann remains literature-only until prerequisites and a rigorous verification method are specified.

## Living literature queue

Last reviewed: October 14, 2026. Update this file after each completed study or source review, not with background automation.

- [ ] Read Barina's 2025 verification methods and reproduce one tiny congruence-class example.
- [ ] Review the 2025 paradoxical-Collatz preprint, pin its map convention and select one reproducible statement.
- [ ] Read the 2025 missing-string/algebrization preprint after the basic complexity barriers.
- [ ] Recheck primary sources for later progress before promoting any literature lead.

Recent papers are leads, not assumed solutions. Keep a precise source and status with every added item.

## Next after the first-descent run

Current evidence: starts 2 through 1,000,000 all descended within 1,000 ordinary steps. The maximum was 287 steps at 626,331. No universal claim follows.

## Cycle 2 completed

Modulo 8 and 16 summaries preserve all earlier aggregate results. Elementary first-descent proofs cover even starts, 4k+1 for k >= 1, and 16k+3 for k >= 0. Remaining remainders modulo 16: 7, 11 and 15. This is known algebra reproduced in the notebook, not a new Collatz result.

Do not infer termination for an initial class merely because its first descent is proved: its smaller endpoint may belong to an uncovered class.

## Next after cycle 3

Modulo-32 splits and the first small Lean proof are complete. Written first-descent arguments cover 28 of 32 residue classes; Lean checks the 4k+1 three-step lemma and the 32k+11 and 32k+23 eight-step lemmas. Remaining classes: 7, 15, 27 and 31. Keep the bound fixed.

- [x] Formalize the two exact eight-step lemmas, 32k+11 and 32k+23, in Lean using the ordinary map and all earlier steps (2026-10-26, only propext and Quot.sound).
- [ ] Formalize the remaining written first-descent arguments (even starts, 16k+3, and the others) in Lean, one at a time.
- [ ] Derive forced prefixes for the four remaining groups modulo 64 before checking them at the existing bound. Preserve parity-dependent branches.
- [ ] Keep proof-assistant status separate from bounded software checks and written algebra in every public claim.
