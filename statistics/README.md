# Noema statistics

Two classic puzzles about chance, worked out exactly and then checked by rolling the dice a few hundred thousand times.

```sh
python3 -m unittest discover -s tests
python3 chance.py
```

Birthday problem: with 23 people in a room, the chance that two share a birthday is 50.7297%, and 23 is the smallest group where it passes a half. Coupon collector: to see every face of a die you need 14.7 rolls on average, and for 50 kinds of coupon about 225 draws. The exact answers are fractions, computed with no rounding. A seeded simulation lands within a few standard errors of each.

Both are textbook results, reproduced here so the lane has a tested base before it takes on anything harder.
