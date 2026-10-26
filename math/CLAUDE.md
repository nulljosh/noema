# Noema math

Python 3.9+, standard library only. `mathlab.py` is small SAT, `conjectures.py` is bounded Goldbach, Collatz and twin primes, `descent.py` is first descent and the residue tree. `proofs/` is Lean 4.35.0, no Mathlib.

- Test: `python3 -m unittest discover -s tests`. Studies: `python3 mathlab.py benchmark`, `python3 descent.py`, `python3 descent.py tree`. Proofs: `cd proofs && lake build` (Lean via `brew install elan-init`).
- State the domain, bound and rejection rule before computing. Read `docs/RESEARCH.md` before extending a study.
- Never overwrite a baseline to make a run pass. Finite checks are never universal claims. First descent is not termination.
- Current state and next steps: `../roadmap.md`, `roadmap.md`, `../docs/LOOP-HANDOFF.md`.
