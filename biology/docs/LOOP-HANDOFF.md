# Evidna loop handoff (2026-10-13, evening)

## What the loop is

A finite foreground computational research queue. It checks the pinned HBB reference, scans 1,332 single-base substitutions, compares UniProt protein-change annotations, and records versioned regression scores. It has a runtime ceiling and stops when useful work is finished. No model calls, physical experiments, or background scheduler.

## Where things stand

Public site: https://evidna.jaybulb.com. Mobile-first CSS and proportional fonts. Findings include the full substitution counts, repeat-run agreement, known-case score, and a sourced explanation of Hb Bristol. The code reproduces 256 annotations; two are outside a one-base explanation and three complex annotations are excluded. The whitepaper records the limits. Eleven tests pass. Research history and landing findings are updated by complete runs.

## Next, in order

Review `benchmarks/latest.json` and any regressions before changing anything. Read the two unmatched annotations and the original Hb Bristol paper. Define a held-out hypothesis-quality benchmark before claiming scientific improvement. Add a second public gene only with independently specified expected cases. Keep evidence provenance and physical lab review separate from sequence correctness.

## Restart prompt

```text
Continue Evidna's foreground research loop. Read CLAUDE.md, WHITEPAPER.md, and benchmarks/README.md. Run uv run evidna.py benchmark and inspect results. Work through the next open roadmap item in a small, tested change. Update the whitepaper and public findings with actual measured evidence. Do not use Claude calls or background automation. Stop early when useful work is complete, then report results and remaining limits. Push reviewed changes and deploy with ./deploy.sh.
```
