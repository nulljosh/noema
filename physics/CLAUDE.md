# Noema physics

Python 3.9+, standard library only. `ising.py` counts exact 2D Ising energy levels on L x L tori with a row transfer matrix, polynomials packed into big ints. `nubase.py` cross-checks NUBASE2020 against ENSDF ground states (`docs/NUCLEAR.md`).

- Test: `python3 -m unittest discover -s tests` (under ten seconds). Study: `python3 ising.py` writes `benchmarks/ising-latest.json`.
- Every new size must pass brute force (L <= 4) or Kaufman's closed form before a number leaves this folder.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
