# Noema computer science

Python 3.9+, standard library only. `busy.py` enumerates 2-symbol Turing machines as a tree, growing only transitions a run actually reaches.

- Test: `python3 -m unittest discover -s tests` (n up to 3, under a second). Study: `python3 busy.py 4` (about four minutes).
- A machine still running at the step cap is a holdout, not a proof of non-halting. Max steps are "within the cap" until every holdout is decided.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
