# Noema biology

Python 3.13, Biopython, uv. `evidna.py` is analysis and the evidence notebook, `research.py` and `benchmarks.py` are the research queue, `heldout.py` is the held-out ClinVar benchmark.

- Test: `uv run python -m unittest discover -s tests`. Studies: `uv run evidna.py benchmark`, `uv run heldout.py`. After data changes, `uv run evidna.py export-demo`.
- Pinned public data only; refresh with the explicit `fetch` commands, never from tests. Notebooks and secrets stay out of Git.
- Positions are 1-based CDS coordinates, standard genetic code. Keep initiator-methionine numbering apart from mature beta-globin numbering.
- Never present an AI proposal or a ClinVar assertion as measured evidence. Never change a declared predictor or split after seeing labels. No instrument code.
- Current state and next steps: `../roadmap.md`, `roadmap.md`, `../docs/LOOP-HANDOFF.md`.
