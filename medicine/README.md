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

First scan: the 6,000 newest randomized-trial abstracts from each of 2022, 2023 and 2024. That is 18,000 abstracts with 1,256 checkable pairs. 23 pairs fail. Reading each abstract by hand, 17 pairs in 16 abstracts are clear mistakes, about 1 in 74. The other 6 are probably shares of a different total. Several of the clear ones can be traced: one abstract prints 24/73 and 8/70 for arms of 72 and 71 women, and 24/72 and 8/71 give exactly the printed 33.3% and 11.3%. Another prints 6/18 (66.6%), where 12/18 would be 66.7%. Every flagged pair, with its PubMed ID and the reason, is in `percents-2022-2024.json`.

These are slips in abstracts, and the full papers may print the right numbers. Each is an open note until the paper is read, not a claim that a result is wrong.

```sh
python3 percents.py 2023 6000
```

This recomputes published results. It is arithmetic on public numbers, not medical advice.
