# Spreads labelled SD that are standard errors: a note for ClinicalTrials.gov. Draft for Joshua.

Nothing here has been sent. If Joshua wants it sent, the address for results questions is on the ClinicalTrials.gov contact page; he sends it himself. It names trials but accuses no one.

## The note

Hello,

I checked the posted results on ClinicalTrials.gov for one kind of label error and found 90 trials where it looks likely. I am writing in case the results team wants to follow up with the sponsors.

When a results table gives each arm's mean and spread, and an analysis gives the difference between arms with a 95% confidence interval, the spreads fix how wide that interval can be. If the spreads are standard deviations, the interval is about 1.96 times the square root of (SD1²/n1 + SD2²/n2) on each side. If they are standard errors, it is about the square root of n times wider. In 292 analyses in 90 trials, the spreads are labelled Standard Deviation but the posted interval matches the standard-error width, and not the SD width. (The 7,393 other SD-labelled analyses that fit either width fit the SD one.)

I read the linked papers for all 90 trials. 16 papers print the same arm values and say what the spread is. 15 say standard error: for example "least squares mean ± SE" (NCT00846365), "Trough FEV1 mean (SE)" (NCT01040403) and "mixed model estimates ± SE" (NCT02346136). The 16th says SD, and there the posted interval does not match the paper's, so a cell is wrong either way.

The 15 trials where a paper confirms it:

NCT00427193, NCT00846365, NCT01040403, NCT01289990, NCT01875003, NCT02346136, NCT02720744, NCT02740231, NCT02856113, NCT03163264, NCT03188666, NCT04016779, NCT04657016, NCT05107115, NCT05998616.

The full list of 90, with each analysis, is at https://github.com/nulljosh/labs/blob/main/noema/medicine/registry-spread.json, and the method is described at https://github.com/nulljosh/labs/blob/main/noema/medicine/docs/REGISTRY.md.

A reader who takes these spreads as SDs would think the outcome is far less variable than it is, by a factor of about the square root of the arm size.

Thank you,
Joshua Trommel

## Before sending

- Re-fetch three of the 15 trials live and confirm the labels are still wrong (they may have been fixed).
- Decide whether to also mention the 61 sign slips in confidence limits (`registry-ci-sign.json`); this note keeps to one finding.
