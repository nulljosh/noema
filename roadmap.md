# Noema roadmap

> Priority tier 5: exploratory. Each lane keeps its detailed queue in `math/roadmap.md` and `biology/roadmap.md`. This file is the order across both. Raise one study's scope at a time.

## Now

- [x] **Math:** the eight-step lemmas for 32k+11 and 32k+23 are Lean-checked (2026-10-26). 28 of 32 classes have a written first descent; 7, 15, 27 and 31 remain.
- [ ] **Biology:** review `benchmarks/latest.json`, then read the two annotations no one-base change explains and the original Hb Bristol paper.
- [x] **Both:** ship the merged site (2026-10-26). Run `./deploy.sh`, move the noema.jaybulb.com DNS from the Sites CNAME to the wrangler custom domain, and check that evidna.jaybulb.com still opens.

## Next

- [x] **Math:** split classes 7, 15, 27 and 31 modulo 64 (2026-10-26, none resolve) (now the first math task). Derive the forced prefixes before computing anything, and keep the bound at one million.
- [x] **Biology:** held-out benchmark declared and scored (`uv run heldout.py`, 2026-10-26). v0 = 0.67 balanced accuracy on 28 held-out records.
- [x] **Biology:** inputs v1 with NM_000518.4 titles (2026-10-26): 41 held out, v0 still 0.67.
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
| 2026-10-26 | biology | Inputs v1 (NM_000518.4 titles too, identical CDS) grow the labeled set 93 to 134 and the held-out set 28 to 41; v0 unchanged scores 0.67 again (sensitivity 0.59, specificity 0.75) | observed | engine matches ClinVar's protein change on all 134; both transcripts' CDS byte-identical from NCBI | same ClinVar pin; spec amended with a dated inputs_v1 block, v0 and split untouched | baseline held, not a finding |
| 2026-10-26 | cs | Wider block n-gram deciders cut 4-state holdouts 643 to 41 (32 counter-like, 7 square-root growth, 2 other); run 24 s; maxima still 107 steps, 13 ones | machine-decided (sound deciders, Python) | all 20,528 flagged 4-state machines rerun 100,000 steps with no decider, none halt | Brady (1983) BB(4) = 107; bbchallenge CPS | reproduced, 41 to go |
| 2026-10-26 | physics | Ground states of the triangular Ising antiferromagnet on L x L tori, L = 2..9: 6, 42, 42, 3630, 263640, 2620800, 906124242, 547003370634; entropy per spin 0.3337 at L = 9, toward Wannier's 0.3383 | observed (exact counts) | brute force L <= 4 and a separate numpy listing of all 2^25 states at L = 5 | Wannier (1950) limit matches; no OEIS entry and no exact torus table found in one search | candidate for an OEIS entry, not a breakthrough |
| 2026-10-26 | physics | Same ground states recounted a second way (2-colourings of the triangular torus with no one-colour triangle, 0/1 row transfer), extended to n = 10: 44898196092066 | observed (exact counts) | agrees with the full energy polynomial for n = 2..9 and with listing all states for n <= 5 | no OEIS entry; no published torus table found in two web searches | candidate (new OEIS sequence, draft in physics/OEIS-DRAFT.md awaiting Joshua) |
| 2026-10-26 | physics | Triangular ground-state counts extended to n = 15 (8.79e31 at n = 15). Pattern: for odd n with 2n+1 prime (n = 3, 5, 9, 11, 15), (2n+1)^((n-1)/2) exactly divides a(n) | observed (exact counts; pattern on 5 cases) | counts from the 0/1 transfer, which agrees with the polynomial method to n = 9 | no OEIS entry; pattern not found in literature yet | candidate pattern, needs a product formula to test large n |
| 2026-10-26 | physics | Closed form a(n) = ((-1)^n P(1,1) + 3 P(-1,1)) / 2 for triangular ground states (P = product of 1+a+b over n-th roots of s and t); and if p = 2n+1 is prime, p^(ceil(n/2)-1) divides a(n) | written argument for the bound, conditional on the closed form; closed form observed | closed form equals the exact counts for n = 2..15; bound holds for every prime 2n+1 with n <= 90 | divisibility not found in literature; finite-domain enumeration exists (Comput. Phys. Commun. 2006), may hold the counts | candidate (see physics/TRIANGULAR.md); breakthrough needs the closed form derived |
| 2026-10-26 | physics | Closed form for the triangular ground states derived: spins to honeycomb matchings with an n-parity crossing rule, then Kasteleyn's torus theorem and Fourier diagonalisation. The 2n+1 divisibility bound now has a full written argument | written (cites Kenyon's form of Kasteleyn's theorem) | the 14 exact counts pin every sign convention; bound checked to n = 90 | divisibility not found in literature; counts may be in Comput. Phys. Commun. 2006 | candidate, proof written; needs an outside check and a novelty check before "breakthrough" |
| 2026-10-26 | cs | Finite automata reduction decider with stored, rechecked certificates cuts 4-state holdouts 41 to 27 (20 counters, 5 square-root, 2 other) | machine-decided (sound, certificates rechecked) | the 14 newly decided run 1,000,000 steps with no decider, none halt; maxima unchanged | bbchallenge FAR | reproduced, 27 to go |
| 2026-10-26 | cs | BB(4) = 107 steps and Sigma(4) = 13 ones, decided by this code: direct FAR (left DFA plus pushdown post*) certifies the last 27 four-state holdouts, 0 remain | machine-decided (41 stored certificates rechecked exactly each run and word by word) | all 27 run 1,000,000 steps with no deciders, none halts; the champion gets no certificate | Brady 1983; bbchallenge FAR (Blanchard) | reproduced |
| 2026-10-26 | physics | Proof completed: the Kasteleyn signs for this torus follow from a cycle argument (k parallel cycles of class (u, v) have sign (-1)^(k(n(u+v)-1))), so the closed form and the bound p^(ceil(n/2)-1) dividing a(n) for prime p = 2n+1 hold for every n | written proof (physics/TRIANGULAR.md) | class-by-class matching counts n = 2..5; closed form equals exact counts n = 2..15; bound checked to n = 90 | divisibility not found in literature; counts or closed form may be published (Comput. Phys. Commun. 2006) | candidate with proof; needs an outside reader and a real novelty search to become a breakthrough |
| 2026-10-26 | physics | Literature: Krawczyk (arXiv:1004.1070, 2010) gives 3630 and 263640 ground states for the periodic 5x5 and 6x6 triangular lattices, matching a(5), a(6) | literature | independent published values agree with our counts | counts for n = 5, 6 reproduced; no closed form or divisibility in that paper | counts known in part; closed form and 2n+1 bound still candidate |
| 2026-10-26 | physics | The closed form's pieces are Wendt determinants: (-1)^n P(1,1) = A096964(n), and for odd n P(-1,1) = A048954(n). So for odd n the triangular ground-state count is (A096964(n) + 3 A048954(n)) / 2 | observed identity (checked n = 3..13) on top of the written proof | OEIS terms of both Wendt sequences | 2n+1 divisibility of Wendt determinants is classical (Fee-Granville 1991, Ford-Jha 1993), so our bound is likely a corollary; no source links Wendt determinants to dimers or the Ising model | candidate (the bridge), divisibility downgraded to likely known |
| 2026-10-26 | physics | Novelty pass on the Wendt bridge: the honeycomb torus product formula is standard (Kasteleyn; Kenyon's lectures; Boutillier and de Tilière), and binomial circulant determinants are studied on their own, but no source found joins them | literature | two extended searches, OEIS A048954 and A096964 comments | no paper links Wendt or binomial circulant determinants to dimers or the Ising antiferromagnet | candidate stands: small, an identification rather than a new theorem |
| 2026-10-26 | physics | Correction: the triangular ground-state entropy per spin converges to 0.32307 (0.32313 at n = 120), the Mahler measure of 1+x+y, not 0.3383. Earlier rows quoting 0.3383 used the misprint in Wannier's 1950 paper, corrected in his 1973 erratum | exact (closed form to n = 120) | numeric integral (2/pi) int_0^{pi/3} log(2 cos w) dw = 0.3230659 | Wannier, Phys. Rev. B 7, 5017 (1973) | earlier rows corrected by this one |

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
- [x] **CS:** BB(4) decided here (2026-10-26). Direct FAR cleared the last 27.
- [ ] **CS:** port the FAR certificate check to Lean or Coq so BB(4) is machine-checked, not just Python. Then try 5 states.
- [ ] **CS:** second study, optimal sorting-network sizes for n up to 6 by search, checked against OEIS A003075.
- [ ] **Biology:** after the held-out benchmark, predict the effect class of every HBB substitution and score it only against held-out ClinVar records.
- [ ] **Physics:** the 3x3 and 4x4 Ising rows are missing from OEIS. Draft an entry for Joshua to review before anything is submitted.
- [x] **Physics:** triangular antiferromagnet ground states to 9x9 (2026-10-26), heading toward Wannier's 0.3383.
- [ ] **Physics:** novelty search for the triangular closed form and the 2n+1 divisibility (read the 2006 Comput. Phys. Commun. paper, dimer-on-torus divisibility papers), then an outside reader for TRIANGULAR.md. If both hold, it goes to Joshua as the lab's first breakthrough candidate, with an OEIS entry.
- [ ] **Physics:** a deeper literature search (Blote and Nightingale, dimer counts on the honeycomb torus) for the triangular counts, then an independent check by Pfaffian dimer counting, then an OEIS draft for Joshua.
- [ ] **Chemistry:** count stereoisomers or alcohols next (OEIS A000628, A000598) with the same two-method check.
- [ ] **Medicine:** read the ISIS-2 full text to see whether the combination's SD 5 comes from a stratified analysis, then recompute the 1954 Salk polio trial from the Francis report's own table.
- [ ] **Statistics:** the birthday problem's hard cousin, the chance that three people share a birthday (smallest n past a half is 88), computed exactly and checked against the published value.
- [x] **Hub:** cards for physics, chemistry, medicine and statistics, deployed 2026-10-26.

## Not doing

Riemann stays literature-only. No structure prediction, model training, autonomous experiments or instrument control. No universal claim from a finite check.
