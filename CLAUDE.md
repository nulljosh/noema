# Noema

One lab, two sides. `math/` is Python standard library only (mathlab, conjectures, descent, a Lean proof). `biology/` is Python 3.13 with Biopython and uv (evidna, research, benchmarks). Each side keeps its own CLAUDE.md, roadmap, tests, benchmarks and whitepaper; read the side you touch.

- `landing/` is the hub page. `math/landing` and `biology/landing` are the two studies. `./deploy.sh` copies all three into ignored `dist/` and runs `wrangler deploy` (noema.jaybulb.com and evidna.jaybulb.com both serve it).
- CI is `.github/workflows/noema-math.yml` and `noema-biology.yml` at the labs root.
- Claims use four levels and never blur them: observed (bounded computation), written (algebra on paper), machine-checked (Lean), literature (someone else's result, with source). A finite check is never a universal claim.
- Foreground loops only: no daemons, no automatic model calls, no automatic pushes. See `roadmap.md` and `docs/LOOP-HANDOFF.md`.
- Front matter style: plain English, no em dashes, no emojis, system font, no purple.
