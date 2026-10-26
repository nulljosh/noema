# Design review

## Initial review

Logo B−: a generic DNA helix with weak recognition at small sizes.
Landing B+: coherent paper palette and a real interactive study, but tiny monospace labels, insufficient mobile readability, and an undistinctive wordmark.

## Second iteration

The new mark is an open evidence loop, with a lower-case e and a separated datum. Constraints: a 24-unit grid; one ink color; one continuous stroke and one circular point; 2.6-unit stroke; no gradients, shadows, text, or helix; readable at 16 pixels. The opening means the conclusion stays open to evidence. The point is the next observation. The dark app tile uses the same geometry.

Newsreader provides the editorial headings and wordmark. DM Sans provides proportionally spaced body copy, labels, controls, and examples. Fonts are self-hosted with their OFL licenses. No monospace type remains on the landing.

CSS starts with the narrow layout. Desktop enhancements are additive. Controls have at least 44-pixel touch targets, visible keyboard focus, a skip link, and a real select label. The DNA illustration is explicitly abstract.

## Acceptance gate

Check 320, 390, 768, and 1440-pixel layouts for horizontal overflow and readable content. Exercise all three variants and JSON download. Check font loading, focus behavior, color contrast, and browser errors. Review the mark at 16, 24, and 64 pixels. Record actual results before assigning a final grade.

A+ means the internal release checklist passed. It is a design judgment, not a claim of external certification or universal perfection.

## Release review

Second pass: logo A, page A. The first mobile Lighthouse run found a CSS specificity bug that gave two install-panel paragraphs insufficient contrast. The content-column selector was narrowed, and the next run passed with accessibility 100, best practices 100, SEO 100, and agentic browsing 100. Performance is a separate check, not part of these four scores.

Final internal grade: logo A+, landing A+. The constrained mark retains its open loop and distinct evidence point at 16, 24, and 64 pixels. The page has no horizontal overflow at 320, 390, 768, and 1440 pixels. Proportional fonts load successfully. All three variants update the codon, consequence, mass estimate, and charge estimate. The mobile layout keeps the content in one column; tablet and desktop use a two-column workbench. The third pass fixes the logo link's touch height to 44 pixels.

These are bounded release checks, not a claim of perfection. Native Safari and Android hardware, a screen reader session, user comprehension, and an external brand review have not been tested. Future observations should reopen the review rather than preserve the grade by assumption.
