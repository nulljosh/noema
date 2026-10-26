# Noema medicine

Python 3.9+, standard library only. `trials.py` recomputes landmark trial results from the counts the papers print.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 trials.py`.
- Every count is copied from a named primary source (journal, year, PMID) and fetched, never recalled from memory.
- A mismatch with a paper is an open note until the full text is read. Never medical advice.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
