# Spreads labelled SD that are standard errors: a note for ClinicalTrials.gov

Sent 2026-10-28 through the NLM help desk form ("Submitted Successfully"). The channel is the NLM help desk form at https://support.nlm.nih.gov/support/create-case/ (NLM support article KA-03685 says to report record errors there, with the NCT number, the error and the correct information, and NLM forwards them to the sponsor). The form asks for the sender's name and email, Joshua's.

## The note

Hello,

I checked the posted results on ClinicalTrials.gov for one kind of label error and want to report the trials where a paper confirms it.

When a results table gives each arm's mean and spread, and an analysis gives the difference between arms with a 95% confidence interval, the spreads fix how wide that interval can be. If they are standard deviations, the half-width is about 1.96 times the square root of (SD1²/n1 + SD2²/n2). If they are standard errors, it is about 1.96 times the square root of (SE1² + SE2²), wider by roughly the square root of the arm size. Across all posted results, 292 analyses in 90 trials label the spreads Standard Deviation but have the standard-error width. (The 7,393 other SD-labelled analyses that fit one width or the other fit the SD one.)

For 16 of the 90 trials, the linked paper prints the same arm values and names the spread. 15 say standard error. In these 15 the error is the dispersion label of the listed outcome measures: it reads Standard Deviation and should read Standard Error.

NCT number, outcome measure (in posted order, from 1), paper PMID:

- NCT00427193, outcomes 6 and 7, PMID 31303390
- NCT00846365, outcomes 1 and 2, PMID 29334491
- NCT01040403, outcome 1, PMID 26404912
- NCT01289990, outcome 4, PMID 26701110
- NCT01875003, outcomes 2, 5, 6 and 7, PMID 35846226
- NCT02346136, outcomes 6 and 7, PMID 31116883
- NCT02720744, outcomes 1 and 3, PMID 40851446
- NCT02740231, outcomes 2 to 5, PMID 34666767
- NCT02856113, outcome 1, PMID 40032809
- NCT03163264, outcomes 1, 2, 6, 7, 9 and 10, PMID 40892413
- NCT03188666, outcome 9, PMID 37770652
- NCT04016779, outcome 2, PMID 35896943
- NCT04657016, outcome 19, PMID 37840095
- NCT05107115, outcomes 1 and 2, PMID 40266575
- NCT05998616, outcome 2, PMID 42112098

The 16th, NCT04581200, says SD in its paper (PMID 38957856), but there the posted interval for the difference, 0.09 (-0.57 to 0.74), is not the paper's 0.02 (-0.11 to 0.15), so one of the posted cells is wrong either way.

The other 74 trials have no readable paper that settles it. They are listed, with each analysis, at https://github.com/nulljosh/labs/blob/main/noema/medicine/registry-spread.json, and the method is at https://github.com/nulljosh/labs/blob/main/noema/medicine/docs/REGISTRY.md.

A reader who takes these spreads as SDs will think the outcome is far less variable than it is.

Thank you,
Joshua Trommel

## Before sending

- [x] Re-fetched NCT00846365, NCT01040403 and NCT02346136 live on 2026-10-28: still labelled Standard Deviation, still fit the SE width.
- [x] Counts recomputed from `registry-spread.json` rows: 292 analyses, 90 trials.
- [x] The 61 sign slips in confidence limits stay out; one finding per report.
