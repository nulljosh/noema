# Noema landing QA

October 14, 2026. Internal acceptance grade: A+. This is a subjective design review against the checklist below, not an independent rating, accessibility certification or claim of perfection.

## Review cycle

First pass: B+. The initial page had supporting labels too small for comfortable reading and no reusable identity specification. The original ornamental mark lost detail at favicon sizes.

Second pass: increased supporting text to 12px, explanatory copy to 14px and short metadata to 10px; enlarged preset controls to 44px; adopted the exact clrs.cc base palette; simplified the symbol and made a dedicated 16px version. Added a downloadable brand kit and shared CSS/JSON tokens.

Final pass: A+ against the requested scope. The hero, real Collatz plot, hands-on experiments, bounded findings, sources and research path form one complete experience. The brand kit uses the same mark and tokens. No invented breakthroughs or unsupported universal claims.

## Verified

Screenshots inspected at desktop and 320px mobile width. Landing overflow checks passed at 320, 375, 768 and 1440px. Brand page passed at 320 and 1440px. Relative page links and report downloads returned 200. All nine brand downloads returned 200.

Browser calculations matched known controls: Collatz 27 takes 111 steps and peaks at 9,232; 6,171 takes 261 steps; Goldbach 7,426 has minimum prime addend 173; four has pair 2+2. The SAT example has exactly three satisfied clauses for all four assignments. Invalid bounds, nonintegers and odd Goldbach inputs fail native validation.

Tabs show one panel, maintain selection and use roving focus. Arrow-key navigation reaches the next tab. Skip links, form labels, plot summaries, scale labels, textual result states and reduced-motion CSS are present. Seven intended palette text combinations meet 4.5:1 in the automated test. Fourteen Python tests pass; JavaScript syntax passes.

## Limits

No native Safari, Android hardware, screen-reader or independent user study has run. Viewports are browser emulation. Wordmark SVGs use live system-font text; letterforms can vary. Name/trademark availability was not checked. Numerical controls and regression baselines do not prove an open conjecture.

The first-descent findings section was subsequently checked at 320px and 1440px without overflow. The three-stage JSON report loads and its final record matches the displayed 287-step case. noema.jaybulb.com returned HTTPS 200 after hostname activation.

Cycle 2 adds a source-linked remainder-group note and expands the downloadable descent report. No interactive controls or brand tokens changed.

Cycle 3 adds the modulo-32 results, a downloadable Lean source file and its source-hashed verification record. Sixteen Python tests pass, including export integrity. The exact three-step theorem passed Lean 4.35.0 with warnings as errors and lake build locally. The two new eight-step written arguments are explicitly labelled not yet Lean-checked. Hosted GitHub CI has not run.
