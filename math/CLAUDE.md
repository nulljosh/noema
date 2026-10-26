# Noema
Python 3.9+, standard library only. mathlab.py owns exhaustive small-SAT checks and reports. conjectures.py owns bounded Goldbach, Collatz and twin-prime studies. descent.py owns first descent through one million, with a separate accelerated cross-check. landing/ contains the public viewer.

Run python3 -m unittest discover -s tests -v, python3 mathlab.py benchmark, and python3 conjectures.py. Run python3 mathlab.py research --minutes 15 for a finite foreground cycle.

Read docs/RESEARCH.md before extending a study. State exact domains, controls and rejection rules first. Bounded observations are not universal proofs. Keep baseline failures visible; never automatically overwrite baselines. No background automation, paid model calls or automatic pushes. No subagents unless requested.

Run python3 descent.py for the finite three-stage descent study. Modulo 8/16 summaries and three elementary first-descent proofs are complete. Modulo-32 splits are complete; the two eight-step lemmas are Lean-checked; next inspect remaining groups 7/15/27/31 modulo 64 at the same bound. Preserve the first-descent-v1 baseline and the distinction between first descent and termination.

## The loop

Read docs/LOOP-HANDOFF.md for the current state and paste-ready restart prompt. The modulo-32 cycle and first Lean proof are complete. The eight-step Lean lemmas are done. Next: split remaining classes modulo 64. Keep the bound fixed and preserve the frozen baseline.

proofs/ pins Lean 4.35.0 with no Mathlib. `cd proofs && lake build` checks the 4k+1 three-step lemma and the 32k+11 and 32k+23 eight-step lemmas. Its recorded verification is proofs/verification.json. Runtime studies need no Lean.
