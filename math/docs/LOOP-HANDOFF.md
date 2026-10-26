# Noema loop handoff (2026-10-14, morning)

## What the loop is

A finite foreground research cycle. State one exact question, calculate within a fixed bound, check independently, preserve failures, and separate observations from proof. No background automation, paid models or automatic Git pushes.

## Where things stand

Public site: https://noema.jaybulb.com. Brand kit: /brand.html. Sixteen Python tests pass; the first Lean lemma builds locally. SAT checked 18,069 formulas; Goldbach and Collatz total stopping cover 10,000. First descent checks starts two through one million with two implementations, maximum 287 ordinary steps at 626,331. Modulo 8 and 16 reports preserve the v1 baseline. Elementary written proofs cover even starts, 4k+1 above one, and 16k+3. These are known facts reproduced, not a universal termination theorem. Lean 4.35.0 verifies the exact three-step 4k+1 lemma. Two written eight-step arguments add remainders 11 and 23 modulo 32, covering 28 of 32 classes. Remaining classes: 7, 15, 27, 31.

## Next, in order

Read docs/RESEARCH.md and the three elementary arguments. Run the tests, SAT benchmark and descent study. Formalize the exact eight-step lemmas for 32k+11 and 32k+23, then split the remaining four groups modulo 64 at the existing bound. Derive forced affine prefixes before calculation. Preserve variable branches and exceptions. Keep the existing checked lemma passing and use no Collatz assumption in further proofs. Update the whitepaper and public findings from measured evidence; publish explicitly through Sites.

## Restart prompt

```text
Continue Noema's finite foreground research. Read CLAUDE.md, WHITEPAPER.md,
docs/RESEARCH.md, proofs/README.md and roadmap.md. Run Python tests,
python3 mathlab.py benchmark, python3 descent.py, and lake build in proofs/.
Formalize the exact eight-step first-descent lemmas for 32k+11 and 32k+23.
Use the actual ordinary Collatz map and rule out all earlier descents.
Then derive forced affine prefixes for remaining remainders 7, 15, 27
and 31 modulo 32 when split modulo 64, before any numerical comparison.
Keep the bound at one million. Preserve parity-dependent branches,
failures and the frozen baseline. Update proof status and measured
results separately. No paid models, background jobs, record claims
or universal conclusions from finite checks. Stop when the cycle ends.
```
