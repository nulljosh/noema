# Evidna

Python 3.13+, Biopython, standard library. No server dependency. `evidna.py` owns analysis, AI calls, and the local evidence notebook. `landing/` is a static interactive viewer of Python-generated reports.

Run `uv run python -m unittest discover -s tests -v`. Regenerate `landing/results.json` with `uv run evidna.py export-demo` after analysis or data changes. Deploy with `./deploy.sh`; Git pushes do not deploy.

Use pinned public data. Keep notebooks and secrets out of Git. Never present an AI proposal or user-reported observation as validated evidence. Do not add instrument execution without explicit scoped authorization and a reviewed hardware design.

All current input positions are 1-based CDS coordinates, not genomic coordinates. Standard genetic code only. Keep initiator methionine numbering distinct from mature beta-globin numbering.

## The loop

Run `uv run evidna.py research --minutes 15` for the finite foreground queue. `uv run evidna.py benchmark` adds a nonzero exit on regressions. See `docs/LOOP-HANDOFF.md`. No automatic model calls, daemon, or Git pushes. Complete runs update benchmark history, landing findings data, and the marked whitepaper section; deploy explicitly to publish new findings.
