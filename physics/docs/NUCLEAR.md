# Nuclear data cross-check

`nubase.py` compares NUBASE2020 (Kondev et al. 2021, Chin. Phys. C 45, 030001) with the ENSDF ground states served by the IAEA LiveChart API, over 2,775 nuclides that both give a measured half-life.

Every plutonium isotope agrees. 22 ground states differ by more than a factor of 2 and 5 sigma (ENSDF's error only). Most are known kinds of drift: NUBASE marks the ground state and isomer order as uncertain or reversed (`*` or `&`) for 70Co, 119Ag, 154Tb, 192At, 245Md, 256Es and 261Rf, and newer measurements explain 208Hg and 209Hg. 128Te's double beta half-life is a known split between geochemical and direct values.

One is not covered by NUBASE's own flags. For 138Pm, ENSDF (cut-off 30 Sep 2017, the edition NUBASE lists in its ENSDF-year column) puts the ground state at (1+) with 10 s. NUBASE puts 3-# at 3.24 m as the ground state and 1+# at 10 s as the isomer, which is the reverse order, yet the line carries neither `&` ("order reversed compared to ENSDF") nor `*`. Observed from both files; NUBASE's text on 138Pm was not read.

Open: 249No (ENSDF 38.1 ms, NUBASE 57 us) and the superheavies 277Mt and 271Ds differ by more than 100 times and are not explained here.
