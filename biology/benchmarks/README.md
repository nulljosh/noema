# HBB benchmark v1

Run `uv run evidna.py benchmark`. It exits nonzero on a changed baseline metric or input fingerprint. CI runs it on every push and pull request.

Nine source-anchored sequence cases cover missense, synonymous, start-codon changes, stop gains, stop losses, and retained stops. The full scan covers all 1,332 single-base CDS substitutions. It is cross-checked with 261 pinned UniProt natural-variant annotations: 256 reproduced, two not explainable by one coding substitution, and three complex annotations excluded. Coverage is visible; this is not a 100% clinical-accuracy claim.

`baseline.json` freezes initial correctness and coverage metrics and input hashes. It is a regression baseline, not independent proof of correctness. Never overwrite it automatically to make a failure pass. Review and explain dataset or algorithm changes before establishing a new suite version.

`latest.json` is the latest score. `history.jsonl` retains measurements across runs. Each complete research cycle writes both. Timing is informational: compare the same machine, software environment, and similar load. It is not gated in CI because shared-runner noise makes that misleading. Three initial runs had identical biological metrics and a median around 0.72 seconds on the development Mac.

These benchmarks do not measure AI hypothesis quality, novelty, clinical effects, or physical experiments. A future hypothesis benchmark needs a held-out evidence set, predeclared predictions, and blinded scoring. Keep that separate from software correctness.
