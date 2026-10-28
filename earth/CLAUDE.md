# Noema earth science

Python 3.9+, standard library only. `quakes.py` reads the USGS earthquake catalog and estimates the Gutenberg-Richter b-value by Aki's maximum-likelihood formula.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 quakes.py fetch DIR 2020 2025` (raw CSVs into the session scratchpad), then `python3 quakes.py DIR`.
- Quote b per magnitude type and above a stated completeness magnitude; mixing mb and Mw changes the answer.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
