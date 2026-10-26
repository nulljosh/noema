<img src="landing/logo.svg" width="80" alt="Noema icon">

# Noema

A small lab for math and biology. Exact questions, fixed bounds, checks that can fail, and claims that stay as small as the evidence.

[noema.jaybulb.com](https://noema.jaybulb.com) · [Math](https://noema.jaybulb.com/math/) · [Biology](https://noema.jaybulb.com/biology/)

| Lab | What it studies | Run |
|---|---|---|
| [math](math) | Collatz first descent, Goldbach, tiny SAT formulas, one Lean lemma. Python standard library only. | `cd math && python3 -m unittest discover -s tests` |
| [biology](biology) | Every one-base change in human beta-globin (HBB), checked against UniProt. Python 3.13, Biopython. | `cd biology && uv run python -m unittest discover -s tests` |

Results so far are in the discovery ledger in [roadmap.md](roadmap.md). Every row so far reproduces known work, which is how each engine earns trust before it is pointed at anything new.

Both labs run the same loop: state one question, compute inside a fixed bound, check a second way, keep failures visible, and say what was observed apart from what was proved. No model calls, no background jobs, no automatic pushes. Read [roadmap.md](roadmap.md) for what is next and [docs/LOOP-HANDOFF.md](docs/LOOP-HANDOFF.md) to restart a loop.

`./deploy.sh` tests both labs, assembles one site (hub, `/math`, `/biology`) and deploys it with wrangler. Git pushes do not deploy.

For the plain-language background on fields like these, see [Fieldbook](../fieldbook).

Independent and unaffiliated with Anthropic or Apple. MIT.
