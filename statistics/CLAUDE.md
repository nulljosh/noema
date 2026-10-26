# Noema statistics

Python 3.9+, standard library only. `chance.py` computes exact probabilities with `fractions.Fraction` and checks them with a seeded simulation.

- Test: `python3 -m unittest discover -s tests`. Study: `python3 chance.py`.
- Simulations only ever check an exact answer, within a stated number of standard errors. They never replace one.
- Current state and next steps: `../roadmap.md`, `../docs/LOOP-HANDOFF.md`.
