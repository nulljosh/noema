# Noema roadmap

> Priority tier 5: exploratory. Each lane keeps its detailed queue in `math/roadmap.md` and `biology/roadmap.md`. This file is the order across both. Raise one study's scope at a time.

## Now

- [x] **Math:** the eight-step lemmas for 32k+11 and 32k+23 are Lean-checked (2026-10-26). 28 of 32 classes have a written first descent; 7, 15, 27 and 31 remain.
- [ ] **Biology:** review `benchmarks/latest.json`, then read the two annotations no one-base change explains and the original Hb Bristol paper.
- [ ] **Both:** ship the merged site. Run `./deploy.sh`, move the noema.jaybulb.com DNS from the Sites CNAME to the wrangler custom domain, and check that evidna.jaybulb.com still opens.

## Next

- [ ] **Math:** split classes 7, 15, 27 and 31 modulo 64 (now the first math task). Derive the forced prefixes before computing anything, and keep the bound at one million.
- [ ] **Biology:** write the held-out hypothesis-quality benchmark with predeclared scoring, before claiming any improvement.
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

## Frontier

Each tick adds the sharpest next question its result raised. Prune anything that stays untouched for ten ticks.

- [ ] **Math:** binary patterns in the longest-surviving residues mod 2^20.
- [ ] **Biology:** after the held-out benchmark, predict the effect class of every HBB substitution and score it only against held-out ClinVar records.

## Not doing

Riemann stays literature-only. No structure prediction, model training, autonomous experiments or instrument control. No universal claim from a finite check.
