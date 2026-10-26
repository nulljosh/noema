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

## Impossible spreads

`spread.py` looks for a median printed outside its own interquartile range, or a value outside its own range. Neither can ever be right. Across the 235,860 abstracts there are 6,638 such pairs. 27 are flagged, and a hand read of all 27 leaves 15 clear mismatches in 13 abstracts, like "10 [IQR 7-7]", a median follow-up of 22.9 months with an IQR of 27.5 to 33.3, and "8 months (range 1-6)". The other 12 are units, times or group labels read as the value. All 27, with reasons, are in `spread-2015-2024.json`.

## Headcounts that do not add up

`totals.py` checks sex splits against the total they split, like "55 patients (22 males and 34 females)". 997 splits can be checked. 4 add up to more people than the total, which cannot happen: 56 of 55, 69 of 62, 1,648 of 1,612 and 500 of 400. 8 more fall short with no missing or other group named, such as 43 of 53, which may be unreported data. Three flags were not mismatches and are marked so in `totals-2015-2024.json`.

## Are flagged papers retracted more often?

No. PubMed marks 685 of the 235,860 abstracts as retracted, 0.29%. Of the 428 abstracts flagged by any of the three checks, 1 is retracted (0.23%, PMID 29636004). One would be expected by chance. So these slips look like ordinary typing errors, not a sign of a bad paper. The test is weak, though: with only 428 flagged abstracts it would miss anything smaller than about a fivefold rise. The slips also do not cluster: of 440 abstracts flagged by any check, only one (PMID 39086232) fails two. Four of the 13 abstracts mention a model elsewhere in the text, which might explain theirs.

```sh
python3 pvalues.py CACHE_DIR    # a folder of {pmid: abstract} JSON files from percents.fetch or fetch_epmc
```

This recomputes published results. It is arithmetic on public numbers, not medical advice.
