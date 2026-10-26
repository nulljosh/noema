# One checked first-descent proof

Pinned toolchain: leanprover/lean4:v4.35.0. No Mathlib or third-party proof dependencies.

The ordinary Collatz map updates an odd number to 3n+1 and an even number to n/2. The theorem states that every start 4k+1 with natural k >= 1 first falls below its start after exactly three steps. It checks the actual iterated function and every earlier step, not just an isolated arithmetic inequality.

```sh
cd proofs
lake build
lean -DwarningAsError=true Noema.lean
```

Use the pinned Lean toolchain through elan, or put the official toolchain's bin directory on PATH. This Mac's checked toolchain is cached under ~/Library/Caches/noema/lean/lean-4.35.0-darwin_aarch64/bin. Runtime Python calculations do not require Lean.

verification.json records the source hash and actual compiler output. The theorem depends on standard Lean axioms propext and Quot.sound, with no custom Collatz assumption or unfinished proof. The file enables warnings as errors, so an unfinished proof is rejected. A GitHub proof job is configured, but this source repository currently uses Sites rather than a GitHub remote; no hosted CI result is claimed.

The eight-step lemmas for 32k+11 and 32k+23 are also checked (all k >= 0, same definitions, same axioms). The other written first-descent arguments are not yet formalized. A proof of first descent in selected starting classes does not by itself prove termination for those classes: the smaller endpoint may be outside them.

[Official tactic reference](https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference), [Lean release](https://github.com/leanprover/lean4/releases/tag/v4.35.0).
