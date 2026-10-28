# Noema information engineering

Python 3.9+, standard library only. `codes.py` finds A(n, d), the largest binary code of length n and minimum distance d, by an exhaustive maximum-clique search, and prints a code that attains it.

- Test: `python3 -m unittest discover -s tests` (n up to 7, under a second, each code checked distance by distance). Study: `python3 codes.py 8 3`.
- Check against the published tables (Brouwer). An exhaustive search gives an exact value; a heuristic one only a lower bound, and says so.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
