# Noema physics

The Ising model is a grid of tiny magnets that each point up or down and want to match their neighbours. Heat it and they scramble. Cool it and they line up. Onsager solved the infinite grid in 1944 and found the switch happens at temperature 2.269.

```sh
python3 -m unittest discover -s tests
python3 ising.py       # 2x2 up to 8x8, about two seconds
python3 ising.py 10    # 10x10, about two and a half minutes
```

`ising.py` counts, exactly, how many arrangements of an L by L grid that wraps around at the edges have each number of mismatched neighbours. It does it one row at a time and never lists the states, so 8x8 (2^64 arrangements) takes about a second and 10x10 (2^100) about two and a half minutes. Every count is checked three ways: listing every state for grids up to 4x4, Kaufman's 1949 formula for the same finite grids on both sides of the switch, and simple facts any answer must obey (the total is 2^N, one flipped magnet has exactly 2N arrangements).

From the counts, the point where the grid soaks up heat fastest falls from 2.511 on a 2x2 grid to 2.345 on 10x10, heading toward Onsager's 2.269. That is a trend on small grids, not a measurement of the limit.

Flip the rule so each magnet wants to point opposite its neighbours, and put the magnets on a triangle grid. Now no arrangement can please everyone, so the coldest state is not unique: a 9x9 grid has 547,003,370,634 equally cold arrangements. `python3 ising.py tri 9` counts them exactly. The leftover disorder per magnet heads to 0.3231: 0.3240 at 30x30 and 0.3231 at 120x120, from the exact formula in TRIANGULAR.md. That is Wannier's value as corrected in his 1973 erratum. The 0.3383 printed in his 1950 paper, and still quoted in places, is the misprint. The 5x5 count (3,630) was also checked by listing all 33 million states.

These counts are not in OEIS, and one search found no published table for these exact grids. The limit has been known since 1950. What looks new is in TRIANGULAR.md: an exact formula for every grid size, built from Wendt's determinant.

The square-grid results reproduce known work. Beale (Physical Review Letters 76, 78, 1996) gave the exact counts for finite periodic grids from Kaufman's formula, and later work runs his method to 192x192.
