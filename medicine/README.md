# Noema medicine

Big medical trials print their raw counts. This lane takes those counts and redoes the math, to see whether the headline number really follows from them.

```sh
python3 -m unittest discover -s tests
python3 trials.py
```

First trial: ISIS-2 (Lancet, 1988), 17,187 people with a suspected heart attack. From the death counts in the abstract alone, the clot-buster streptokinase cuts the odds of dying within five weeks by 25%, aspirin by 23%, and both together by 42%, with a 95% range of 34% to 50%. All of that matches the paper, and a second odds-ratio method agrees to within a point.

One small thing does not line up. The paper gives the combination's uncertainty as 5 points, but its own 34% to 50% range and the raw counts both point to about 4. The full paper may explain it with an adjusted analysis, so this stays an open note until someone reads it, not a claim that the paper is wrong.

This recomputes published results. It is arithmetic on public numbers, not medical advice.
