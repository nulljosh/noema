# Noema medicine

Big medical trials print their raw counts. This lane takes those counts and redoes the math, to see whether the headline number really follows from them.

```sh
python3 -m unittest discover -s tests
python3 trials.py
```

First trial: ISIS-2 (Lancet, 1988), 17,187 people with a suspected heart attack. From the death counts in the abstract alone, the clot-buster streptokinase cuts the odds of dying within five weeks by 25%, aspirin by 23%, and both together by 42%, with a 95% range of 34% to 50%. All of that matches the paper, and a second odds-ratio method agrees to within a point.

One small thing does not line up. The paper gives the combination's uncertainty as 5 points, but its own 34% to 50% range and the raw counts both point to about 4. The full paper may explain it with an adjusted analysis, so this stays an open note until someone reads it, not a claim that the paper is wrong.

## Do the abstracts add up?

`percents.py` reads trial abstracts straight from PubMed and checks one thing: when an abstract prints a fraction and its percentage together, like "12/40 (30%)", do they agree? No other data is needed. A pair counts as wrong only if no rounding of the true percentage (nearest, up or down) gives the printed number, so small rounding habits never count.

First scan: the 6,000 newest randomized-trial abstracts from each of 2022, 2023 and 2024. That is 18,000 abstracts with 1,256 checkable pairs. 23 pairs fail. Reading each abstract by hand, 17 pairs in 16 abstracts are clear mismatches, about 1 in 74. The other 6 are probably shares of a different total. Several of the clear mismatches can be traced: one abstract prints 24/73 and 8/70 for arms of 72 and 71 women, and 24/72 and 8/71 give exactly the printed 33.3% and 11.3%. Another prints 6/18 (66.6%), where 12/18 would be 66.7%. Every flagged pair, with its PubMed ID and the reason, is in `percents-2022-2024.json`.

Full scan: the same check over all 235,860 randomized-trial abstracts from 2015 to 2024 finds 15,347 pairs, and 387 of them fail (in 283 abstracts). That is too many to read one by one, so a random 40 were read by hand. 33 are clear mismatches, 5 are ambiguous (two percentages, or a share of another total) and 1 was a false alarm that is now filtered out. So roughly 330 of the 387 are clear mismatches, about 1 in 47 pairs, with a 95% range of about 270 to 360. The rows and the labeled sample are in `percents-2015-2024.json`.

These are slips in abstracts, and the full papers may print the right numbers. Each is an open note until the paper is read, not a claim that a result is wrong.

```sh
python3 percents.py 2023 6000
```

## Do the P values add up?

`pvalues.py` goes one step further. Many abstracts print two groups' counts and a P value together, like "24/72 vs 8/71, P = 0.002". That is a whole 2x2 table, so the P can be redone. It is recomputed six ways: Pearson's chi-square, Yates' chi-square and Fisher's exact test, each two-sided and one-sided. A sentence that names a different analysis (adjusted, stratified, survival, non-inferiority and so on) is set aside, and so is any pair whose own percentage does not match its fraction.

The scan covers 235,860 randomized-trial abstracts from 2015 to 2024 (PubMed and Europe PMC). They hold 2,825 such pairs, and 1,895 are plain 2x2 comparisons. 364 of those print a P that no rounding of any of the six tests gives. Most of these are small gaps, likely a test we did not try. The sharp case is the one statcheck counts (Nuijten et al. 2016): the printed P lands on the other side of 0.05 from every test. That happens 26 times. Reading each abstract by hand, 14 of the 26, in 13 abstracts, are clear mismatches. The other 12 turn out to be paired designs, scores written like fractions, or markup debris. One example prints 8/47 vs 14/47 with chi-square 19.394 and P = 0.004, but those counts give a chi-square of about 1.9. Another calls 3/30 vs 2/30 significant at P = 0.008. Every case, with its PubMed ID and the reason, is in `pvalues-2015-2024.json`.

As with the percentages, each one is an open note until the full paper is read.

## Do the ratios add up?

`ratios.py` checks odds, risk and hazard ratios printed with a 95% interval, like "OR 1.5 (95% CI 1.2-1.9), P = 0.30". No test choice is needed. The estimate must sit inside its own interval. An interval that clearly leaves out 1 must go with P under 0.05, and one that clearly holds 1 with P over 0.05. Borderline cases are skipped: bounds within rounding of 1, P between 0.04 and 0.06, and sentences about interaction, heterogeneity, non-inferiority or one-sided tests.

Across the same 235,860 abstracts there are 31,021 ratios with an interval. 68 sit outside their own interval, like OR 0.217 with an interval of 0.056 to 0.085. 64 more disagree with their P, like HR 1.33 (0.67 to 2.63) printed with P = 0.037. A random 40 of the 132 were read by hand. 28 are clear mismatches, and 12 are ambiguous (a P that belongs to the next item, a borderline bound, a one-sided test). So roughly 90 are clear, about 1 in 340 ratios. Georgescu and Wren (2018) ran this kind of check across MEDLINE and found far more, up to 7.5% of ratios, but they also counted the smaller gaps this scan skips. A third check recovers the P from the interval alone, the way Altman and Bland (BMJ, 2011) show: the standard error comes from the log bounds and z from the log estimate, trying every rounding of the printed numbers. 114 printed P values sit more than ten times outside what their own interval allows, like HR 2.12 (1.67 to 2.69) printed with P = .02 when the interval gives about one in a billion. A hand-read of 31 found 21 clear, so about 80 more. Everything is in `ratios-2015-2024.json`.

## Do the differences add up?

`diffs.py` runs the same three checks on mean and risk differences, on the raw scale with 0 as the null. Across the 235,860 abstracts there are 11,237 differences with a 95% interval. 50 sit outside their own interval, like a difference of 3.20% printed with an interval of 3.22% to 9.72%, which most likely lost a minus sign. 61 disagree with their P, like MD -0.83 (-5.81 to 4.14) printed with P = 0.02. 16 more print a P far smaller than the interval allows. Only that side counts here, because t tests and exact tests on small trials give larger P than the normal curve, never smaller. A hand-read of 39 found 28 clear, so about 90 clear mismatches. Medians, Hodges-Lehmann, bootstrap and non-inferiority sentences are skipped. Everything is in `diffs-2015-2024.json`.

## Impossible spreads

`spread.py` looks for a median printed outside its own interquartile range, or a value outside its own range. Neither can ever be right. Across the 235,860 abstracts there are 6,638 such pairs. 27 are flagged, and a hand read of all 27 leaves 15 clear mismatches in 13 abstracts, like "10 [IQR 7-7]", a median follow-up of 22.9 months with an IQR of 27.5 to 33.3, and "8 months (range 1-6)". The other 12 are units, times or group labels read as the value. All 27, with reasons, are in `spread-2015-2024.json`.

An SD can be too big for its range too. Data that all sit between a and b with mean m have a variance of at most (m - a)(b - m), the Bhatia-Davis inequality (2000), and a sample SD is at most the square root of twice that. 533 abstracts print a mean, an SD and a range together. 8 SDs in 4 abstracts break the bound, like a hospital stay of 2.8 ± 1.78 days with a range of 2.29 to 3.31. All 8 read as a 95% interval printed under the word range.

## Headcounts that do not add up

`totals.py` checks sex splits against the total they split, like "55 patients (22 males and 34 females)". 997 splits can be checked. 4 add up to more people than the total, which cannot happen: 56 of 55, 69 of 62, 1,648 of 1,612 and 500 of 400. 8 more fall short with no missing or other group named, such as 43 of 53, which may be unreported data. Three flags were not mismatches and are marked so in `totals-2015-2024.json`.

Trial arms get the same check. "95 patients were randomized to MA (n = 50) or KA (n = 49)" puts 99 people in 95 places. 2,099 sentences give a randomized total and at least two arm sizes. 13 arms overflow their total, and all 13 were read by hand: 9 are clear, like 674 women split into 337 and 377. One is markup debris and three are unclear, such as families counted against children. A run of arms that adds to the total exactly is never flagged, since that is a factorial design or a later "of whom" count.

## Does the number needed to treat add up?

The number needed to treat is one over the absolute risk difference. `nnt.py` finds 518 NNTs in the 235,860 abstracts and checks each against the difference printed just before it: an absolute risk reduction, or the last "A% vs B%" pair in the sentence. Any rounding of the NNT up, down or to the nearest is forgiven. It also checks 104 relative risk reductions against 1 minus the RR or HR beside them. 23 flags came out, and all were read by hand. 7 in 6 abstracts are clear mismatches. One prints responder rates of 42% and 18% and an NNT of 3.5, where 1 / 0.24 is 4.2. Another prints 12.1% vs 26.1% with an NNT of 9, where the difference gives 7. One prints an absolute risk reduction of "0.08%" beside 21% vs 13% and an NNT of 12.4, which fits 8 points, so the unit is the slip. The other 16 are wrong pairings (subgroups, "respectively", three arms) or a different NNT, and none of the relative risk reductions is a clear mismatch. Each is an open note until the full text is read. Results are in `nnt-2015-2024.json`.

## Do the test statistics add up?

A t, z, chi-square or F statistic printed with its P fixes that P, which is the check statcheck runs on psychology papers (Nuijten et al. 2016). `stats.py` recomputes it for every such pair in the 235,860 abstracts, trying every rounding of the statistic and letting a t or z be one-sided. When no degrees of freedom are printed it only uses bounds that hold for any df: the normal curve gives the smallest P a t can have and df = 1 the largest, and a chi-square on 1 df gives the smallest. An F without its df is skipped, and an F(45, 1) is also read as F(1, 45).

4,243 statistics can be checked. 433 print a P that does not fit, mostly small gaps. 55 are gross: every P the statistic allows sits on the other side of 0.05. All 55 were read by hand. 41, in 37 abstracts, are clear mismatches. One prints t(28) = .46 with P = .008, where that t gives about 0.65. Another calls F(1, 78) = 2.81 significant at P < 0.05, where it gives about 0.10. 33 of the 41 print a significant P, the same lean toward significance statcheck found in psychology. 7 more are slips with an obvious reading, like a chi-square that is really a z, or a t of 1256 that lost its decimal point. 5 have a df that cannot be right, like t(1) in a trial of many patients, and 2 are markup debris. Each is an open note until the full text is read. Everything is in `stats-2015-2024.json`.

## Do the ratios match the arm rates?

"Mortality 20% vs 10% (RR 0.50)" fixes the crude ratio. `crude.py` recomputes it for every risk or odds ratio printed right after an "A% vs B%" pair, trying every rounding, both arm orders and, for a risk ratio, the complement (the people with no event). Sentences that say adjusted, regression, stratified, cluster or rate ratio are skipped. A ratio is flagged only when it sits more than 1.5 times from every crude value.

747 ratios can be compared, and 17 are far off. All 17 were read by hand. 3, in 2 abstracts, are clear mismatches. One trial with 70 patients per arm prints discharge rates of 52.9% and 71% with an OR of 4.75 (95% CI 2.1 to 10.8). The crude OR is 2.2, and the printed P = 0.029 fits 2.2, not 4.75. Another calls its ORs univariate, yet 76.1% vs 48.8% in 46 and 43 patients gives 3.3, not the printed 1.78. 6 more are open notes with no adjustment named, like an OR of 14.61 beside 41% vs 27%, where the crude OR is 1.9. 7 are explained by a design the abstract names elsewhere (cluster trials, multilevel or adjusted models, exact tests), and 1 is a misread. Each is an open note until the full text is read. One search found no scan like this. Results are in `crude-2015-2024.json`.

## Does Cohen's d match the means?

"4.1 ± 2.6 vs 5.7 ± 2.4, d = 0.64" fixes d up to the choice of SD. `cohen.py` allows the pooled SD, either arm's SD alone and a small-sample shrink of up to a quarter, over every rounding. Sentences about change, baseline, differences, adjusted values or standard errors are skipped. A d is flagged only when it sits more than 1.5 times outside that range.

Only 62 d values sit right after a mean ± SD pair, and 14 are far off. All 14 were read by hand. None is a clear mismatch. 4 fit exactly once the ± is read as a standard error of the mean rather than an SD, like a crossover in 8 men where 22.4 ± 6.1 vs 12.2 ± 4.3 gives d 0.68, the printed 0.67. 4 are within-subject designs, where a paired d can be larger. 1 is a misread. 5, in 3 abstracts, are open notes. The clearest is a parallel trial with 55 women per arm that prints d = 0.030 for 77.52 ± 18.27 vs 72.35 ± 16.39. The SD gives 0.30 and a standard error gives 0.04. Results are in `cohen-2015-2024.json`.

## Do hazard ratios match the medians?

When hazards stay constant, a hazard ratio is the inverse ratio of the two median times. They rarely stay constant, and an abstract seldom says which arm is the reference, so `hazard.py` checks only size: a pair is flagged when the whole interval for the ratio sits more than 3 times farther from 1 than the medians, or less than a third as far.

In 323 pairs, 1 is flagged, and it is a misread ("Pathway 1 and 25 days"). No clear mismatch. Direction was tried first and dropped: 8 significant ratios point the other way from their medians, and every one reads fine once the reference arm is the other one.

## Do registry Totals add up?

ClinicalTrials.gov posts a baseline table for every trial with results: each arm's count, mean and SD, then a Total column. `registry.py fetch` pulls all 55,075 trials that post a mean with an SD, and `registry.py` checks 71,214 Totals against their arms. None of the Totals falls outside the range of its arm means. The registry may check that itself.

The Total should be the mean weighted by arm size. 2,154 miss that by more than ten roundings. Missing values may explain many of them, because the posted counts are not always the people measured. But 328 Totals, in 234 trials, land to the last digit on the plain average of the arm means. That is right only when the arms are the same size, and luck would give about 27. A decoy test agrees. Take the point as far from the weighted mean as the plain average, on the other side. Missing data should push Totals to either side alike. Where both points fit inside the arm range, 283 Totals land on the plain average and 11 on the decoy. In 168 of the 328 the Total SD is also the plain average of the arm SDs and falls outside every pooled SD the arms allow. These look like Totals typed in as a spreadsheet AVERAGE of the arms.

To be safe, the clear set keeps only trials whose arms differ at least twofold in size and carry no note about missing data: 134 Totals in 107 trials, listed in `registry-baseline.json`. In one, arms of 8 and 18 people have mean BMIs of 27.7 and 33.53. The Total is 30.615, the plain average; weighted, it is 31.74.

Two literature searches found studies of missing and inconsistent registry fields, but none that checks the Total column this way, and no sign of how the registry validates Totals.

## Are flagged papers retracted more often?

No. PubMed marks 685 of the 235,860 abstracts as retracted, 0.29%. Of the 428 abstracts flagged by any of the three checks, 1 is retracted (0.23%, PMID 29636004). One would be expected by chance. So these slips look like ordinary typing errors, not a sign of a bad paper. The test is weak, though: with only 428 flagged abstracts it would miss anything smaller than about a fivefold rise. The slips also do not cluster: of 440 abstracts flagged by any check, only one (PMID 39086232) fails two. Four of the 13 abstracts mention a model elsewhere in the text, which might explain theirs.

```sh
python3 pvalues.py CACHE_DIR    # a folder of {pmid: abstract} JSON files from percents.fetch or fetch_epmc
```

This recomputes published results. It is arithmetic on public numbers, not medical advice.

## Are flagged papers corrected more often?

At first glance yes. 30 of 659 flagged abstracts carry a PubMed erratum link, 4.6%, against 69 of a random 3,000, 2.3% (Fisher P = 0.002). But flagged abstracts are long and full of numbers, and the journals that print such abstracts also print more corrections. Against 3,000 unflagged abstracts that are just as long and also report a ratio with an interval, the gap is gone: 164 of 3,000 (5.5%) against 17 of the 274 flagged abstracts of that kind (6.2%), Fisher P = 0.58. Most notices that do exist fix other things, like conflict of interest forms or author lists, and PubMed rarely holds their text, so a slip and its fix cannot be paired from here.
