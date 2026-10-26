<img src="icon.svg" width="80" alt="Noema icon">

# Noema

![Version](https://img.shields.io/badge/version-0.1.0-555) ![License](https://img.shields.io/badge/license-MIT-555)

A mathematics research lab. Start small. Check carefully. Ask a harder question.

[Open Noema](https://noema.jaybulb.com/math/) · [Brand kit](https://noema.jaybulb.com/math/brand.html)

Inspired by Evidna's finite evidence loop. Independent and unaffiliated with Anthropic or Apple. Noema is a name, not a claim of trademark availability.

## Run

```sh
python3 -m unittest discover -s tests -v
python3 mathlab.py research --minutes 15
python3 conjectures.py
python3 descent.py
python3 mathlab.py benchmark
python3 -m http.server 8080 --directory landing --bind 127.0.0.1
```

No dependencies, accounts or model calls. Foreground queues stop when their work is complete. SAT timeout and Ctrl-C save partial summaries under ignored runs/ without replacing accepted findings. Complete SAT cycles compare a fixed baseline, record history and update the whitepaper. Number-theory stages stop at 100, 1,000 and 10,000 and cap each orbit at 1,000 steps.

Read [WHITEPAPER.md](WHITEPAPER.md), [research and sources](docs/RESEARCH.md), [roadmap.md](roadmap.md), and [loop handoff](docs/LOOP-HANDOFF.md). No open problem has been solved. Browser examples are bounded teaching tools; published figures come from Python reports.

First descent now covers starts 2 through 1,000,000. Every start descended, and two implementations agreed on the ordinary-step counts and endpoints. This is a bounded result. [Brand system](landing/brand.html) · [QA and limitations](docs/design/QA.md).

Modulo-32 studies now isolate four remaining classes. Written algebra covers first descent in 28 of 32 classes. Lean 4.35.0 verifies three exact first-descent lemmas (4k+1, 32k+11, 32k+23); see [proofs/README.md](proofs/README.md). No general Collatz termination claim follows.
