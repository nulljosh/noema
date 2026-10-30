# Noema loop handoff (2026-10-30, morning)

## What a loop is

`/loop forever until we find a breakthrough discovery; don't tell me it's not possible.` Each tick is a bounded cycle: state one exact question, compute inside a fixed bound, check a second way, keep failures and baselines visible, separate what was observed from what was proved. Ticks re-arm themselves every 25 to 30 minutes and alternate CS and medicine unless another lane's ledger row is older. Long searches run as background shell jobs inside the session (never cron or daemons), each sized to finish in 15 to 20 minutes and flushing every result line; the next tick reads their output. Time a small sample first and assume the Mac is shared (load can sit near 90 from other sessions). Commits push automatically once tests are green. No paid models.

Joshua decides nothing mid-loop: make the call, act, report in one line. The exceptions are his: logins, passwords and 2FA. For a CAPTCHA, send him the image (and the audio version when the site has one) and type the code he replies with; never solve it.

## Tick protocol (every loop tick, in order)

0. Read any finished background job's output, and check `https://oeis.org/draft?user=Joshua%20Trommel`: OEIS allows three pending edits, so submit the next queued one the moment a slot opens (queue below).
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

Computer science: every 2-, 3- and 4-state machine and every 2-state 3-symbol machine is settled in Python. BB(2) = 6, BB(3) = 21 and BB(2,3) = 38 are proved in full in Lean (`FAR.bb2`, `FAR.bb3`, `FAR.bb23`), `Count2.lean` machine-checks A004147(2) and A386859(2) over all 20,736 two-state tables, and `Count3.lean` machine-checks A004147(3), A386859(3) and R(3) = 21 by a tree-counting theorem (`CountTree.lean`), in 182 pieces from `count_lean.py`. Axioms propext and Quot.sound only. `halters.c` counts every halting machine and sums the halting times. At 5 states it gives 26,751,695,615,616 halters, exactly A004147(5), and a sum of 64,068,865,333,248, a new fifth term for A386859 (OEIS edit waits on Joshua, `docs/OEIS-A386859.md`). The runtime spectrum is 1, 6, 21, 79, 1,207 for 1 to 5 states; `runtimes.py`, a plain walk sharing no code with halters.c, agrees through 4 states (draft for Joshua in `docs/OEIS-runtime-spectrum.md`). The runner-up 23,554,764 is Marxen and Buntrock's, not ours. `plainwalk.c`, a decider-free C walk, matches the 5-state count to step 2000 exactly (919 runtimes), and with A004147(5) that shows the 333 long halters are complete. `platypus.py` adds the ones each halter leaves: 74 is the smallest count no 5-state machine prints, and PP(n) (A399346, Placid Platypus) is known for n = 1 to 181, where OEIS has 37 (a 130-term b-file is in review). Witnesses past 130 come from the sixth-state extender started from 5-state machines with 25 or more ones, from a random walk over 6-state machines (`walk.c`), and from `nbhd.c`, which tries every machine within two transition changes of a known witness; all land in `platypus-walk.txt` and every one is rerun by `platypus.sim`. Witnesses come in adjacent pairs, because a machine halts by writing one cell, so the way to close a hole is to seed `nbhd.c` from the machines printing the counts either side of it and ask for the hole alone: that is what gave 178. 182 is the first open n. `circular.c` extends A394183 (2-state machines on a circular tape) from 19 to 27 terms. `sortnet.py` reproduces optimal sorting networks to 7 inputs. Novelty report: `docs/reports/Noema candidates novelty check.md`.

Medicine: 235,860 abstracts scanned for numbers that contradict themselves. On ClinicalTrials.gov (details in `medicine/docs/REGISTRY.md`): 328 baseline Totals are the plain average of unequal arms; 407 Total SDs cannot come from any arm sizes, and 71 of the too-wide ones fit once the arms are read as standard errors; 61 CIs in 52 trials have a sign slip the p-value confirms; 292 outcome intervals in 90 trials are labelled SD but fit standard errors (`registry-spread.json`, with a scale rule that drops mixed units); linked papers confirm it: 15 of the 16 that print the flagged values and name the spread say SE, and the 16th shows a wrong registry interval instead. One-sided P values posted without a label explain most interval-versus-P clashes. The Salk primary source (AJPH 1955, PMID 14361811) has no open copy. Raw downloads live in the session scratchpad: `analyses.py fetch` and `fetch-arms`, `registry.py fetch`.

Medicine, 2026-10-28 afternoon: three more registry-wide checks over all 80,750 studies with results, each a counting rule the data cannot break. Adverse events (`ae.py`): 28 serious totals in 26 trials exceed the sum of their terms, 6 group counts in 3 trials exceed those at risk. Outcomes (`outcomes.py`): 274 participant counts in 79 trials exceed the number analysed, 62 percentages in 11 trials pass 100. Participant flow (`flow.py`): conserved everywhere except 11 cells in 4 trials. The registry enforces the per-cell rules on entry, not the group sums.

Astronomy (`astronomy/`, new): Kepler's third law holds over 5,609 archive planets (median ratio 1.000, IQR 0.014 dex); 55 miss by 2x, 16 because a = (a/R*) R* (XO-6 b traced to its paper), KOI-2513.01's default is its paper's weak grazing fit (a = 0.5 +0.2 -0.4 au, so the law's 0.135 fits inside). M sin i exceeds M for 99 of 440 composite rows (`docs/KEPLER.md`).

Information engineering (`information/`, new): A(n, d) reproduced to n = 7 by exhaustive clique search; A(8,3) = 20 is slow in Python, a C search is next.

Earth science (`earth/`, new): Gutenberg-Richter b = 1.03 +- 0.02 (Mw, above 5.5) on USGS 2020 to 2025; the catalog has no self-contradicting rows on the fields checked.

Physics: the triangular closed form and 2n + 1 bound are not in OEIS or the arXiv sources read on 2026-10-27; three papers that could settle novelty block scripts (see roadmap). Krawczyk citation fixed.

Both sites now deploy as one from `./deploy.sh` (last deploy 2026-10-30, after the labs link fix).

PP hunt, 2026-10-29 small hours: PP(n) now runs unbroken to 181 and 182 is the first open n, with 221, 222, 227, 228, 231, 232 and 246 to 251 behind it. What works is the straddle search, not more compute: witnesses come in adjacent pairs because a machine halts by writing one cell, so collect the machines printing the two counts either side of a hole and run `nbhd.c` depth 2 from them with the hole as the only window. That gave 178 in ten hits after million-step probes and general depth-2 sweeps had all come back empty. Two cheaper tricks come first: keep every machine a sweep prints rather than one per ones count (the discards are the best seeds, and one depth-1 pass over 4,339 of them gave 188 plus 23 more), and rewrite the halting write on machines already in hand, which costs one simulation each. The step cap matters least; past 200,000 it stopped paying. 182 is hard because its straddle set is only 10 machines against 178's 52, and that set is closed: depth 1 over all 22,258 pool machines and depth 2 over all 146 witnesses both return the same 10. Depth 3 on those 10 (`scratchpad/pp177/e3.sh K`, about 12 minutes a seed) is the last unexplored space near it. Sweeps must pipe through `awk '!seen[$2]++'`: an unfiltered one wrote 350,000 lines and filled the disk, killing four jobs at once.

Repo links: after the labs split (2026-10-29) every link in the repo points at github.com/nulljosh/noema, fixed 2026-10-30 across the landing, proofs, OEIS drafts, Mac app, `discoveries.json` and the Evidna page.

Mac app (`macos/`): reads `discoveries.json` and checks OEIS and ClinicalTrials.gov live; installed at ~/Applications/Noema.app. Add a row to `discoveries.json` for each new or reported result.

Outside the lab: two reports went to the NLM help desk on 2026-10-28, SD-as-SE (`medicine/docs/SDSE-NOTE.md`) and sign slips (`medicine/docs/SIGN-NOTE.md`). OEIS drafts are checked with curl on the public page https://oeis.org/draft?user=Joshua%20Trommel, so Joshua's Safari tabs stay his; open a new tab only to edit. OEIS edits in review from Joshua's account: A386859 (a(5)), A394183 (to 27 terms; the draft link now points at nulljosh/noema and a reply went to Jason Yuen on 2026-10-30) and A399346 (130-term b-file). Queued for the next free slot, texts in the scratchpad `oeisedit/`: A332718 (rule 110, to 34 terms), then the new runtime-spectrum sequence (`NEW.new.txt`, via edit?seq=A999999999&internal=1). The A332717 b-file goes up the same way the A399346 one did (a File set on the edit page's upload input).

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
Continue Noema's CS lane. Read CLAUDE.md, cs/CLAUDE.md, cs/README.md and ledger.md. In cs/, run python3 -m unittest discover -s tests. Next: PP(177) onward: the extender from 5-state machines with fewer than 25 ones, then the walk aimed at the first gap; or prove the mirror and state-swap weights sound in CountTree.lean so the 4-state counts come within reach. Every claim names its level. No universal claims from finite checks. Stop when the cycle ends.
```

Medicine lane:

```text
Continue Noema's medicine lane. Read CLAUDE.md, medicine/CLAUDE.md, medicine/README.md and ledger.md. Run python3 -m unittest discover -s tests. Next: read a seeded sample of the 61 sign slips against their papers, then the unread "mean outside range" and over-cap age flags. A mismatch with a paper is an open note until the full text is read. NCBI calls use tool=noema only. Stop when the cycle ends.
```

Cross-lab (use when both lanes are quiet):

```text
Continue Noema across every lane. Read CLAUDE.md and roadmap.md. Build the claims ledger: a claims.json in each lane with claim, exact domain, bound, level (observed, written, machine-checked, literature) and source, then make each landing page render its claims from it. Add the Fieldbook links. Run every lane's tests and ./deploy.sh's checks, but do not deploy without Joshua's yes. Stop at the end of the cycle.
```
