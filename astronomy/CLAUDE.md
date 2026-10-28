# Noema astronomy

Python 3.9+, standard library only. `kepler.py` tests Kepler's third law on every planet in the NASA Exoplanet Archive composite table and lists the planets whose posted orbit misses it by more than a factor of two.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 kepler.py fetch PS_JSON` (raw table into the session scratchpad), then `python3 kepler.py PS_JSON`.
- An outlier is a contradiction in the posted numbers, not a claim about the planet. A mismatch with a paper stays an open note until the full text is read.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
