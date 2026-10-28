# Prior work on halting times of small Turing machines (novelty check)

Checked 2026-10-27. Machines are 2-symbol, 5-tuple, left/right moves, blank start tape, halting step counted (A060843 / A004147 convention).

## Bottom line (three claims, three statuses)

1. **Distinct runtimes, n = 1..5: 1, 6, 21, 79, 1207.** The values 1, 6, 21 are not new: they follow from published Lazy Beaver values. The values 79 and 1207 have no published count in any source I could open. They look new, pending a check of the bbchallenge Discord and Ligocki's work, which I could not reach.
2. **5-state step sum: 64,068,865,333,248.** Not in the published A386859 data line (4 terms only). Looks new. The OEIS history page that would show a pending submission returned 404, so this is unconfirmed.
3. **Second-longest 5-state runtime: 23,554,764.** Not new. Michel's survey states it outright as the Marxen-Buntrock runner-up. Aaronson's "gap" of 23,622,106 is the same fact in another form (47,176,870 - 23,554,764 = 23,622,106).

## 1. Does OEIS hold 1, 6, 21, 79 or 1, 6, 21, 79, 1207?

### Takeaway
No OEIS entry matches the 5-term prefix. The only 1, 6, 21, 79 hit is A026628, a different sequence that shares four initial terms by coincidence.

### Cited Findings
- Search for "1,6,21,79" returns one result, A026628, "a(n) = A026626(2*n, n-1)", with terms 1, 6, 21, 79, 296, 1117, 4237, ... — [OEIS search](https://oeis.org/search?q=1,6,21,79&fmt=short); [A026628](https://oeis.org/A026628) (entry page not opened; name and terms taken from the search listing)
- Search for "1,6,21,79,1207" returns "Sorry, but the terms do not match anything in the table." — [OEIS search](https://oeis.org/search?q=1,6,21,79,1207&fmt=short)
- Search for "64068865333248" returns no match. The same page does not mention 23554764 either, and no separate search for 23554764 was run. — [OEIS search](https://oeis.org/search?q=64068865333248&fmt=short)
- Search for "Turing machine running time distinct" returns "no matching results" for the distinct-count question. — [OEIS search](https://oeis.org/search?q=Turing+machine+running+time+distinct&fmt=short)
- Search for "Turing machines halt steps" returns 36 hits. The closest are A060843 (BB values 1, 6, 21, 107, 47176870), A125269 (minimal states for exactly n steps), A386859 (step sum), A337805 (Lazy Beaver), and A400605 (square array of max steps). None is a count of distinct runtimes. — [OEIS search](https://oeis.org/search?q=Turing+machines+halt+steps&fmt=short)

### Inferences
- A distinct-runtime count for n = 1..5 is not an OEIS entry at the time of checking.

### Gaps
- The OEIS search pages were read through a summarizer, not raw. Open the search URLs to confirm "no results".

## 2. Published 5-state step sum, runtime-spectrum size, or second-longest runtime

### Takeaway
The second-longest 5-state runtime is already published (Michel, via Marxen and Buntrock). The runtime-spectrum size and the step sum are not published as numbers in any source I could open.

### Cited Findings
- A386859 ("Sum of the number of steps taken by all n-state Turing machines that halt"): data line "32, 13504, 13141792, 23076152576", so 4 terms. Comments say it is noncomputable and bounded by max(A004147(n), A060843(n)) and their product. — [A386859](https://oeis.org/A386859)
- A004147 ("Number of n-state Turing machines which halt"): data line "32, 9784, 7571840, 11140566368, 26751695615616". The 5-state halting count matches the notes. — [A004147](https://oeis.org/A004147)
- Michel, "The Busy Beaver Competition: a historical survey", arXiv:0906.3749 (math.LO). The survey lists the 5-state Marxen-Buntrock champion at 47,176,870 steps (sigma = 4,098), and the runner-up at 23,554,764 steps (sigma = 4,097), in Sections 4.4 and 5.2.2. The 4-state record table in Section 4.3 gives 107, 97, 96, 96, 84, 83, 78 for seven good machines. — [arXiv 0906.3749](https://arxiv.org/abs/0906.3749); [ar5iv rendering](https://ar5iv.labs.arxiv.org/html/0906.3749). These figures come from an automated read of the ar5iv page, not from the PDF text; confirm in the PDF before quoting.
- Michel's survey has no sentence on distinct running times, the runtime spectrum, the step sum over halting machines, or Lazy Beaver. This is checked across the full ar5iv text (about 120k characters). — [ar5iv rendering](https://ar5iv.labs.arxiv.org/html/0906.3749)
- Aaronson, "The Busy Beaver Frontier" (2020), section 5.9 "The Spectrum of Runtimes". He defines R(n) as the set of runtimes of n-state machines on the all-0 input. He asks (quoted): "how many distinct runtimes are there for n-state machines?" and "how does the gap between BB(n) and the second-longest runtime behave, as a function of n?" He gives the gap as 1 for n = 2, 3; 10 for n = 4; and "for n = 5, assuming Conjecture 10, it appears to be 23,622,106, almost exactly half the runtime of the current 5-state champion (see Michel [12])." The "see Michel" reference attaches to the champion's runtime. — [Survey PDF](https://www.scottaaronson.com/papers/bb.pdf); ECCC listing [eccc 2020/115](https://eccc.weizmann.ac.il/report/2020/115)
- Aaronson's gap for n = 4 (10) matches Michel's 4-state table: 107 - 10 = 97, which is in that table. — [ar5iv rendering](https://ar5iv.labs.arxiv.org/html/0906.3749)
- Aaronson defines the Lazy Beaver LB(n) as the least k not in R(n), notes LB(n) is computable, and gives the counting bound LB(n) <= |T(n)| + 1. — [Survey PDF](https://www.scottaaronson.com/papers/bb.pdf)
- bbchallenge wiki "Sequences" page: "Runtime Spectrum size R(n)" has values "see 'The Spectrum of Runtimes' in 'The Busy Beaver Frontier'". No value is given. No entry exists for total steps summed over halting machines. — [wiki Sequences](https://wiki.bbchallenge.org/wiki/Sequences)
- bbchallenge wiki "Lazy Beaver" page: LB(n, m) table, with LB values for 2-symbol machines 7, 22, 72, 427, 8,407 for n = 2..6 and crediting "Terry and Shawn Ligocki in 2021". The page has no runtime lists, no set R(n), and no count of distinct runtimes. — [wiki Lazy_Beaver](https://wiki.bbchallenge.org/wiki/Lazy_Beaver)
- bbchallenge wiki "Busy Beaver" page defines R(n) as "(The runtime spectrum function)" with no values. — [wiki Busy Beaver](https://wiki.bbchallenge.org/wiki/Busy_Beaver)
- bbchallenge wiki "Busy Beaver Frontier" page: the survey introduces Lazy Beaver and Beeping Busy Beaver and states Conjecture 10, BB(5) = 47,176,870, which the wiki says was proved in 2024. No runtime-spectrum values. — [wiki Busy_Beaver_Frontier](https://wiki.bbchallenge.org/wiki/Busy_Beaver_Frontier)

### Inferences
- Second-longest 5-state runtime: already published by Marxen and Buntrock, per Michel's survey. Not a new result. Aaronson's gap is the same fact.
- Runtime-spectrum counts: the wiki's R(n) entry points to Aaronson for values, and Aaronson gives no counts. So a count for n = 4 or 5 would be the first published value for that entry, as far as these sources show.
- Step-sum trend: average steps per halting machine. For n = 1..5 this is 32/32 = 1, 13504/9784 = 1.38, 13141792/7571840 = 1.74, 23076152576/11140566368 = 2.07, and 64068865333248/26751695615616 = 2.39. The smooth increase supports the 5-state step sum, but this proves nothing about its exact value.

### Gaps
- No source gives the 5-state step sum, the runtime-spectrum counts 79 or 1207, or the 4-state distinct-runtime count.
- The OEIS history for A386859 (pending a fifth term or submitter name) returned HTTP 404 and was not retried.

## 3. What Aaronson section 5.9 asks, and what the wiki says about spectra and halting-time distributions

### Takeaway
Section 5.9 poses the runtime-count question and the second-longest-gap question, and offers the Lazy Beaver as a computable companion. The wiki says the counts are undetermined and points back to the survey.

### Cited Findings
- Section 5.9 text (quoted): "There are many interesting questions that we could ask about R(n), beyond just its maximum element (namely BB(n)). As one example, how many distinct runtimes are there for n-state machines?" — [Survey PDF](https://www.scottaaronson.com/papers/bb.pdf)
- Wiki R(n) entry: "The number of distinct runtimes for a machine with a given number of symbols, for increasing number of states" with values "see 'The Spectrum of Runtimes'". — [wiki Sequences](https://wiki.bbchallenge.org/wiki/Sequences)
- Wiki Lazy Beaver is the smallest step count where "no n-state, m-symbol Turing machine halts in exactly a(n) steps". — [wiki Lazy_Beaver](https://wiki.bbchallenge.org/wiki/Lazy_Beaver); the 2-symbol version is A337805 ([A337805](https://oeis.org/A337805)), with data line "2, 7, 22, 72, 427, 8407" for n = 1..6.
- A125269 ("Minimal number of states required for a 2-symbol, 5-tuple Turing machine that takes n steps on an initially blank tape"): gives, for each step count, the fewest states that reach it. Its value at n = BB(n) is n. Terms with value 1 to 3 come from exhaustive search; value-4 terms "were inferred, not fully searched". It gives no distinct-count totals. — [A125269](https://oeis.org/A125269)

### Inferences
- Lazy Beaver values fix the small-n runtime counts. LB(n) = BB(n) + 1 for n = 1, 2, 3 (A337805: 2, 7, 22 against A060843: 1, 6, 21). Every runtime below LB(n) is achieved, and nothing at or above LB(n) is excluded by it. So R(n) = [1, BB(n)] for n <= 3, and the counts are 1, 6, 21. This is a derivation from published values, not a new result.
- For n = 4: LB(4) = 72 and BB(4) = 107 imply 71 values in [1, 71] and none at 72. The count 79 then needs exactly 8 values in [73, 107]. Michel's 4-state table already lists six distinct values there (78, 83, 84, 96, 97, 107), so 79 is consistent with the table but needs two more values to be found. This is a consistency check, not a proof.
- A125269 implies the runtime counts (count of steps t with minimal states <= n). Its fetched data line was truncated, so this is not a full count. For n = 4 and 5, A125269's terms are not fully searched and cannot confirm 79 or 1207.

### Gaps
- Section 5.9 text was read from a local `pdftotext` extraction of the same PDF.

## 4. Other prior work surfaced (leads, not verified)

### Cited Findings
- Zenil, "Computer Runtimes and the Length of Proofs", arXiv:1201.0825. Search summary says it tabulates halting step counts for 2-state, 2-symbol machines. Not opened. — [arXiv 1201.0825](https://arxiv.org/abs/1201.0825)
- Riedel and Zenil, arXiv:1102.5389. Search summary says it reports average runtime rising with the number of states for 2-, 3-, 4-state machines. Not opened. — [arXiv 1102.5389](https://arxiv.org/abs/1102.5389)
- Soler-Toscano / Zenil output-frequency paper, arXiv:1211.1302 (also 1211.4891). Search summary says it runs 5-state machines to a 500-step cutoff and samples out to 5000 steps. This is cutoff sampling, not full enumeration. Not opened. — [arXiv 1211.1302](https://arxiv.org/pdf/1211.1302); [arXiv 1211.4891](https://arxiv.org/pdf/1211.4891)
- "Determination of the fifth Busy Beaver value", arXiv:2509.12337 (bbchallenge). Search result title only; not opened. The search summary says it proves BB(5) = 47,176,870 by enumerating 181,385,789 5-state machines. — [arXiv 2509.12337](https://arxiv.org/abs/2509.12337)
- Aaronson's blog post on the survey: [scottaaronson.blog/?p=4916](https://scottaaronson.blog/?p=4916). Search result only; not opened.

### Inferences
- The Zenil and Soler-Toscano papers are the likeliest places for prior halting-time tables. Open arXiv 1201.0825 before claiming a 2-state table is new.

### Gaps
- None of these papers was opened, so none is cited for a number.

## 5. Gaps and things not checked

- Checked: Michel's survey (arXiv:0906.3749), full text via ar5iv. No runtime spectrum, distinct-runtime count, or step sum. The one runtime fact used (the runner-up of 23,554,764) comes from an automated read and should be confirmed in the PDF.
- Checked: bbchallenge wiki Lazy Beaver page. No runtime lists.
- Not checked: the OEIS A386859 history page (404), so the submitter of the A386859 data is unknown.
- Not checked: the bbchallenge Discord (not reachable from search; searches returned nothing).
- Not checked: Ligocki's blog, post by post. The index at https://www.sligocki.com lists 2019 to 2025 posts; no title matches runtime spectrum, distinct halting times, or total steps. Titles are the only evidence. [sligocki.com](https://www.sligocki.com)
- Not checked: Ligocki's arXiv listing. The URL https://arxiv.org/a/ligocki_s_1 returned 404 and was not retried.
- Not checked: bbchallenge.org (main site) and a full-text arXiv search for "runtime spectrum" or "distinct runtimes".
- Search summaries for the bbchallenge and Ligocki queries were low quality, with garbled facts (for example, a "bCBB+ (25)" claim and a "Knuth up-arrow" claim). Those were not used.
