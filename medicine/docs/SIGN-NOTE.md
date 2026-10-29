# Confidence limits posted with a lost minus sign: a note for ClinicalTrials.gov

Second report through the NLM help desk form (https://support.nlm.nih.gov/support/create-case/), after `SDSE-NOTE.md`. Values re-fetched live on 2026-10-28. Sent 2026-10-28 ("Submitted Successfully"), acknowledged as case CAS-1718369-M9R1F3. Reply expected in 2 to 5 business days.

## The note

Hello,

Two posted results on ClinicalTrials.gov have a confidence limit whose minus sign was lost. In each, the posted interval crosses zero although the posted p-value is well below 0.05, and the trial's own paper prints the same estimate with the sign the p-value needs.

- NCT00288912, outcome measure 1 (Pain): posted difference -0.6, 95% CI -1.0 to 0.2, p = 0.007. The paper (PMID 21041576, abstract) gives "0.6 point lower (CI, -1.0 to -0.2 point; P = 0.007)". The upper limit should read -0.2.
- NCT03192176, outcome measure 1 (change in mean frequency of moderate to severe vasomotor symptoms at week 4), the analysis with difference -2.4: posted 95% CI -4.06 to 0.76, p = 0.0042. The paper (PMID 32102086, results table) gives -4.06 to -0.76. The upper limit should read -0.76.

One more for the sponsor to check, which the paper cannot settle because it prints the same values: NCT04636528, outcome measure 6 (Least Pain Level) posts -1.1 (-1.5 to 0.6) with p < .001, and outcome measure 2 (Worst Pain Level) posts -0.6 (-1.4 to -0.2) with p = 0.12. Each interval disagrees with its own p-value (PMID 37490337).

These came from a check of every posted two-sided interval for a difference, flagging intervals that become symmetric about the estimate when one limit changes sign and whose p-value agrees only with the flipped interval. The full list of 61 such intervals in 52 trials is at https://github.com/nulljosh/labs/blob/main/noema/medicine/registry-ci-sign.json.

Thank you,
Joshua Trommel
