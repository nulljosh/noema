# Noema roadmap

> Priority tier 5: exploratory. Each lane keeps its detailed queue in `math/roadmap.md` and `biology/roadmap.md`. This file is the order across both. Raise one study's scope at a time.

## Now

- [x] **Math:** the eight-step lemmas for 32k+11 and 32k+23 are Lean-checked (2026-10-26). 28 of 32 classes have a written first descent; 7, 15, 27 and 31 remain.
- [ ] **Biology:** review `benchmarks/latest.json`, then read the two annotations no one-base change explains and the original Hb Bristol paper.
- [x] **Both:** ship the merged site (2026-10-26). Run `./deploy.sh`, move the noema.jaybulb.com DNS from the Sites CNAME to the wrangler custom domain, and check that evidna.jaybulb.com still opens.

## Next

- [x] **Math:** split classes 7, 15, 27 and 31 modulo 64 (2026-10-26, none resolve) (now the first math task). Derive the forced prefixes before computing anything, and keep the bound at one million.
- [x] **Biology:** held-out benchmark declared and scored (`uv run heldout.py`, 2026-10-26). v0 = 0.67 balanced accuracy on 28 held-out records.
- [ ] **Biology:** widen inputs as v1 inputs: accept NM_000518.4 titles (243 records) after checking the two transcripts share the CDS, and report the held-out set again with v0 unchanged.
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

Every candidate goes here first. A candidate is a breakthrough only after it passes the gate in `docs/LOOP-HANDOFF.md`. Until then it is an observation.

| Date | Lane | Claim | Level | Second check | Literature | Status |
|---|---|---|---|---|---|---|
| 2026-10-26 | math | Lean checks 32k+11 and 32k+23 first descent in 8 steps | machine-checked | Python bound to 10^6 | known algebra | reproduced |
| 2026-10-26 | math | Mod-64 split resolves none of 7, 15, 27, 31 | written | symbolic run | expected by Terras | reproduced |
| 2026-10-26 | math | Open classes mod 2^m, m = 1..20 | observed | numeric descent of members | OEIS A076227, exact match | reproduced |
| 2026-10-26 | cs | Busy Beaver maxima for 1 to 4 states: 1, 6, 21, 107 steps; 1, 4, 6, 13 ones | observed (holdouts undecided) | hand-checked 2-state champion, exact-cycle decider | Rado; Lin and Rado; Brady (BB(4)) | reproduced |
| 2026-10-26 | biology | Predeclared BLOSUM62 rule scores 0.67 balanced accuracy on 28 held-out ClinVar HBB records vs 0.50 for both baselines | observed | engine matches ClinVar protein change on all 93 | BLOSUM-only predictors are known to be weak; n is tiny (4 negatives) | baseline set, not a finding |
| 2026-10-26 | physics | Exact Ising energy counts on L x L tori, L = 2..10 (2^100 states at L = 10); heat-capacity peak falls 2.511 to 2.345 toward Onsager's 2.269 | observed (exact counts) | brute force L <= 4, Kaufman 1949 closed form at K = 0.3 and 0.6 to 1e-15 | Beale, PRL 76, 78 (1996); later runs to 192 x 192. The 3x3 and 4x4 rows are not in OEIS | reproduced |
| 2026-10-26 | chemistry | Alkane isomer counts for 1 to 100 carbons | observed (exact counts) | brute-force canonical trees agree for n <= 12 | OEIS A000602, exact match to n = 100 | reproduced |
| 2026-10-26 | cs | Translated-cycler decider proves 3,027 of 3,119 three-state holdouts and 500,893 of 521,462 four-state holdouts never halt; 92 and 20,569 remain | observed | every flagged 3-state machine and 3,000 flagged 4-state ones rerun 5,000 to 10,000 steps without the decider, none halted | bbchallenge translated-cycler decider | reproduced |
| 2026-10-26 | math | Classes closing at each level of the residue tree, m = 1..24: 1, 1, 1, 2, 3, 7, 12, 30, 85, 173, 476, 961, 2652, 8045, 17637, 51033; open counts to m = 24 also match | observed | the A076227 open counts and a numeric descent check of every closed class to level 12 | OEIS A100982 (admissible sequences) and A186009, exact match | reproduced |
| 2026-10-26 | medicine | ISIS-2 from its printed counts: odds reductions 25% (streptokinase), 23% (aspirin), 42% (both, 95% 34 to 50) | observed (arithmetic on published counts) | Peto one-step and Woolf odds ratios agree within a point | ISIS-2, Lancet 1988, PMID 2899772, exact match; the combination's printed SD 5 recomputes to 4, open until the full text is read | reproduced |
| 2026-10-26 | statistics | Birthday problem: 23 people, P = 0.507297; coupon collector: 14.7 rolls for a die, 224.96 draws for 50 coupons | observed (exact fractions) | seeded simulation within four standard errors | textbook closed forms, exact match | reproduced |
| 2026-10-26 | cs | Backward reasoning plus two closed-tape deciders cut 3-state holdouts 92 to 4 and 4-state 20,569 to 1,539 (run 23 s); maxima unchanged | observed | 88 newly flagged 3-state machines run 100,000 steps and 2,000 sampled 4-state ones 20,000 steps, none halt | bbchallenge backward-reasoning and CTL deciders; BB(3) = 21 proved by Lin and Rado (1965) | reproduced |
| 2026-10-26 | cs | BB(3) = 21 steps and Sigma(3) = 6 ones, decided by this code: every 3-state machine halts within 21 steps or is proved never to halt (0 holdouts). 4-state holdouts 1,539 to 643 | machine-decided (sound deciders, Python) | each flagged machine rerun with no decider, 3-state to 1,000,000 steps and 896 four-state to 50,000, none halt | Lin and Rado (1965); bbchallenge n-gram CPS decider | reproduced |

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
- [x] **CS:** translated-cycler decider (2026-10-26). 3-state holdouts 3,119 to 92, 4-state 521,462 to 20,569, 4-state run 253 s to 14 s.
- [x] **CS:** BB(3) decided here (2026-10-26). Two-cell block n-gram CPS cleared the last 4 counters.
- [ ] **CS:** drive the 643 four-state holdouts to 0 so BB(4) = 107 is decided here too, then port the deciders to Lean or Coq so the result is machine-checked, not just Python.
- [ ] **CS:** second study, optimal sorting-network sizes for n up to 6 by search, checked against OEIS A003075.
- [ ] **Biology:** after the held-out benchmark, predict the effect class of every HBB substitution and score it only against held-out ClinVar records.
- [ ] **Physics:** the 3x3 and 4x4 Ising rows are missing from OEIS. Draft an entry for Joshua to review before anything is submitted.
- [ ] **Physics:** count ground states of the antiferromagnet on small triangular tori, where frustration leaves leftover entropy, and compare with Wannier's 1950 value.
- [ ] **Chemistry:** count stereoisomers or alcohols next (OEIS A000628, A000598) with the same two-method check.
- [ ] **Medicine:** read the ISIS-2 full text to see whether the combination's SD 5 comes from a stratified analysis, then recompute the 1954 Salk polio trial from the Francis report's own table.
- [ ] **Statistics:** the birthday problem's hard cousin, the chance that three people share a birthday (smallest n past a half is 88), computed exactly and checked against the published value.
- [x] **Hub:** cards for physics, chemistry, medicine and statistics, deployed 2026-10-26.

## Not doing

Riemann stays literature-only. No structure prediction, model training, autonomous experiments or instrument control. No universal claim from a finite check.
