# Noema computer science

Python 3.9+, standard library only. `busy.py` enumerates 2-symbol Turing machines as a tree, growing only transitions a run actually reaches.

- `halters.c` (C, needs `cc` with `__int128`) counts halting machines and sums their halting times; `halters-5.json` is the 5-state result, curated, never overwrite it with raw output.
- Test: `python3 -m unittest discover -s tests` (n up to 3, under a second; the halters tests take about 15 seconds). Study: `python3 busy.py 4` (about 25 seconds; no holdouts remain at 4 states).
- A machine still running at the step cap is a holdout, not a proof of non-halting. Max steps are "within the cap" until every holdout is decided.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
