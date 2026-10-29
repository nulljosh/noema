# Nuclear data cross-check

`nubase.py` compares NUBASE2020 (Kondev et al. 2021, Chin. Phys. C 45, 030001) with the ENSDF ground states served by the IAEA LiveChart API, over 2,775 nuclides that both give a measured half-life.

Every plutonium isotope agrees. 22 ground states differ by more than a factor of 2 and 5 sigma (ENSDF's error only). Most are known kinds of drift: NUBASE marks the ground state and isomer order as uncertain or reversed (`*` or `&`) for 70Co, 119Ag, 154Tb, 192At, 245Md, 256Es and 261Rf, and newer measurements explain 208Hg and 209Hg. 128Te's double beta half-life is a known split between geochemical and direct values.

One is not covered by NUBASE's own flags. For 138Pm, ENSDF (cut-off 30 Sep 2017, the edition NUBASE lists in its ENSDF-year column) puts the ground state at (1+) with 10 s. NUBASE puts 3-# at 3.24 m as the ground state and 1+# at 10 s as the isomer, which is the reverse order, yet the line carries neither `&` ("order reversed compared to ENSDF") nor `*`. Observed from both files; NUBASE's text on 138Pm was not read.

249No is newer data too: NUBASE keeps a 2003 value of 57 us with unsure decay modes, while measurements from 2021 on (Khuyagbaatar et al., Svirikhin et al., arXiv:2203.15659) give alpha decay at about 38 ms, which ENSDF's 2023 edition carries. 271Ds is a flagged order swap (`*&`). Open: 277Mt, where NUBASE gives 9 +- 6 s by fission against ENSDF's 2021 value of 4 ms; secondary tables give about 5 ms and NUBASE's own note was not read. The 1,810 ground-state spins both tables give firmly (no brackets or #) agree, apart from the flagged 154Tb swap and a missing parity on ENSDF's 223Rn. Isotopic abundances sum to 100 percent for every element in both tables (tantalum's 0.012 percent sits on the 180mTa isomer).

## The LiveChart bulk export duplicates five decay modes

The IAEA LiveChart `ground_states` query returns a different decay-mode list for the same nuclide depending on whether it is asked for one nuclide or for all of them. Asked for all (`nuclides=all`), five rows name one mode twice; asked for that nuclide alone, each names it once:

| Nuclide | `nuclides=all` | single nuclide |
| --- | --- | --- |
| 48Ca | 2B- 78, 2B- 74, B- 22 | 2B- 78, B- 22 |
| 223Ra | A 100, 14C 8.9e-8, 14C 7.7e-8 | A 100, 14C 8.9e-8 |
| 100Mo | 2B- 100, 2B- 100 | 2B- 100 |
| 70Zn | 2B- 100, 2B- (blank) | 2B- 100 |
| 198Pt | 2B- (blank), 2B- (blank) | 2B- (blank) |

For 48Ca and 223Ra the repeat carries a different branching ratio, so code that reads `decay_2` or sums the three columns off the bulk export picks up a second value for a mode it has already counted. The bulk file was identical on two downloads 50 minutes apart, so this is not a transient. Observed on 2026-10-28 against the live API; which of the two branchings ENSDF intends was not checked, and the cause (likely two evaluated datasets flattened into three fixed columns) is a guess.
