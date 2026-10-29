# Noema AI

Python 3.9+, standard library only. `bench.py` checks a published benchmark score against the files the
submission itself released.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 bench.py fetch DIR` (raw files into the
  session scratchpad), then `python3 bench.py DIR`.
- Plain GETs, no API key, no login, no model calls. Nothing here runs a model or scores a new submission.
- A mismatch is a contradiction between published files, not a claim that a reported score is wrong.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
