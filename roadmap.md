# Noema roadmap

> Priority tier 5: exploratory. Each lane keeps its detailed queue in `math/roadmap.md` and `biology/roadmap.md`. This file is the order across both. Raise one study's scope at a time.

## Now

- [ ] **Biology:** review `benchmarks/latest.json`, then read the two annotations no one-base change explains and the original Hb Bristol paper.

## Next

- [ ] **Biology:** the held-out set has only four negatives. Declare, before fetching, a second source of benign labels (common HBB variants by population frequency, cited threshold) and score v0 on it.
- [ ] **Biology:** predictor v1 from structure facts with sources (heme pocket and alpha1-beta1/beta2 interface residues from a cited paper), scored next to v0 on the same split.
- [ ] **Biology:** add a second public gene, but only with expected cases someone else specified.
- [ ] **Both:** one claims ledger. A small `claims.json` per lab: claim, exact domain, bound, level (observed, written, machine-checked, literature), source. The landing pages render from it, so no page can state more than the ledger holds.
- [ ] **Both:** link each study to its Fieldbook entry (Collatz and number theory, genetics and molecular biology), one line each.

## Later

- [ ] **Math:** tiny pigeonhole formulas with DPLL node counts, and prime gaps on disjoint intervals with checked endpoints.
- [ ] **Math:** read Barina's 2025 verification methods and reproduce one tiny congruence-class example before trusting any literature lead.
- [ ] **Biology:** evidence-file fingerprints, so observations cannot inform a revision until the file checks out.
- [ ] **Biology:** test the workbench on Safari, Android hardware and a screen reader.
- [ ] **Biology:** a human-reviewed experiment record (controls, units, outcomes, provenance). No instrument code without a qualified lab partner, simulated commands and explicit human sign-off.

## Discovery ledger

One row per result, in [ledger.md](ledger.md).

## Fields

Every STEM field is welcome. A field gets a folder only when a tick starts its first study, and its first study must reproduce something published before it aims at anything new.

| Field | Status | First study (reproduce first) | Check against |
|---|---|---|---|
| Math | live (`math/`) | Collatz residue tree, Lean first-descent lemmas | OEIS A076227 |
| Computer science | live (`cs/`) | Busy Beaver through 4 states | Rado, Brady, bbchallenge |
| Biology | live (`biology/`) | HBB substitutions, held-out ClinVar benchmark | UniProt, ClinVar |
| Physics | live (`physics/`) | Exact 2D Ising partition function on small periodic lattices | known exact values, Onsager limit |
| Chemistry | live (`chemistry/`) | Count alkane structural isomers C1 to C20 by tree enumeration | OEIS A000602 |
| Information engineering | queued | Largest binary codes A(n, d) for small n by exhaustive search | published code tables |
| Astronomy | queued | Kepler's third law across the NASA Exoplanet Archive, with the scatter reported | the archive itself |
| Statistics | live (`statistics/`) | Reproduce the birthday-problem and coupon-collector exact values by computation | closed forms |
| Medicine | live (`medicine/`) | Recompute the headline effect and its confidence interval from the published counts of landmark trials (ISIS-2 aspirin, the 1954 Salk polio trial) | the papers' own tables |

## Frontier

Each tick adds the sharpest next question its result raised. Prune anything that stays untouched for ten ticks.

- [ ] **Math:** binary patterns in the longest-surviving residues mod 2^20.
- [ ] **Math:** Lean-check one whole level of the tree (every class mod 2^8 that closes does so in 13 steps), so the A100982 row becomes machine-checked rather than observed.
- [ ] **CS (Joshua):** sign in to OEIS and submit the A386859 edit in `docs/OEIS-A386859.md`.
- [ ] **CS (Joshua):** submit the runtime spectrum (1, 6, 21, 79, 1207) as a new sequence, drafted in `docs/OEIS-runtime-spectrum.md`.
- [x] **CS:** second study, optimal sorting-network sizes for n up to 7 by search, matching OEIS A003075 (`sortnet.py`, 2026-10-27).
- [ ] **CS:** sorting networks at n = 8 (19), then 9 (25), with permutation symmetry and subsumption pruning.
- [ ] **Biology:** after the held-out benchmark, predict the effect class of every HBB substitution and score it only against held-out ClinVar records.
- [ ] **Physics:** the 3x3 and 4x4 Ising rows are missing from OEIS. Draft an entry for Joshua to review before anything is submitted.
- [ ] **Physics:** novelty search for the triangular closed form and the 2n+1 divisibility (read the 2006 Comput. Phys. Commun. paper, dimer-on-torus divisibility papers), then an outside reader for TRIANGULAR.md. If both hold, it goes to Joshua as the lab's first breakthrough candidate, with an OEIS entry.
- [ ] **Physics:** a deeper literature search (Blote and Nightingale, dimer counts on the honeycomb torus) for the triangular counts, then an independent check by Pfaffian dimer counting, then an OEIS draft for Joshua.
- [ ] **Chemistry:** count stereoisomers or alcohols next (OEIS A000628, A000598) with the same two-method check.
- [ ] **Medicine:** read the ISIS-2 full text to see whether the combination's SD 5 comes from a stratified analysis, then recompute the 1954 Salk polio trial from the Francis report's own table.
- [ ] **Statistics:** the birthday problem's hard cousin, the chance that three people share a birthday (smallest n past a half is 88), computed exactly and checked against the published value.

## Not doing

Riemann stays literature-only. No structure prediction, model training, autonomous experiments or instrument control. No universal claim from a finite check.
