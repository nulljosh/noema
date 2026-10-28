# Kepler's third law across the exoplanet archive

`kepler.py` takes every planet in the NASA Exoplanet Archive composite table with a period, a semi-major axis and a stellar mass, 5,609 of them on 2026-10-28, and computes a^3 / ((M_star + M_planet) P^2) in AU, years and solar masses. The law holds: the median is 1.000 and half the planets sit within 0.014 dex of it. 324 give exactly 1, because the archive or the paper derived a from P and M by the law itself. 55 miss by more than a factor of two, and in 41 of those all three numbers come from one reference, so the contradiction is not the archive mixing sources. 13 of the 41 come from Stassun et al. (2017), which re-derived stellar masses from Gaia parallaxes while the orbit sizes stayed as published.

## Papers read

XO-6 b (Crouzet et al. 2017, AJ 153, 94, arXiv:1612.02776), ratio 3.46. The paper's Table 5 gives P = 3.7650007 days and a = 0.0815 ± 0.0077 au, and Table 6 gives M_star = 1.47 ± 0.06 and R_star = 1.93 ± 0.18 solar. The archive copies them faithfully. The 0.0815 au is a/R_star = 9.08 times R_star = 1.93 solar radii, so the orbit size comes from the transit shape and the spectroscopic radius, not from the period and mass. Kepler's law with P and M gives 0.054 au, or a/R_star = 6.0 with that radius. The two disagree because the transit's stellar density (the table's 1.0 g/cm^3) wants a star near 1.3 solar radii, not 1.93; the paper points to its own discussion of the radius. So this outlier is a known tension inside the paper, not a transcription error.

## How the outliers arise

16 of the 55 have a equal, within 3 percent, to the archive's own a/R_star times R_star (TOI-262 b, K2-285 d and e, TOI-2274 b, K2-184 b, XO-6 b among them): the orbit size came from the transit's shape and the star's radius, not from the period and mass, so it misses Kepler whenever the transit's stellar density and the star disagree. An eccentric orbit does that, and so does a misjudged star. Many of the rest are radial-velocity planets with no transit at all, where a was published beside a stellar mass the archive later replaced (the Stassun et al. 2017 rows).

KOI-2513.01 is different. The archive's default solution for it (Cañas et al. 2023) lists a = 0.5000 au and a/R_star = 100.000, round values, while every Kepler KOI table gives 0.141 to 0.146 au for the same 19.005-day orbit. Kepler's law gives 0.135 au. Read on 2026-10-28 (arXiv:2302.07713, Table 9): the paper prints a = 0.5 (+0.2, -0.4) au for this grazing brown dwarf, an orbit the transit shape barely constrains, so the archive copies the paper faithfully and the law's 0.135 au sits inside the paper's lower error. Not a placeholder: a weak fit made the default solution.

Next: read the other single-source outliers outside Stassun et al., starting with TOI-262 b (5.1) and K2-285 e (4.3), and sort each into transcription, unit slip or a tension like XO-6 b's.

## Minimum mass against true mass

M sin i can never exceed M. In the composite table, 440 planets have both, and 99 show M sin i above M (5 of them limits). In 96 the two come from different papers, so the composite has paired one paper's minimum mass with another's true mass. 8 differ by more than twice their combined error: GJ 876 b posts M sin i 760.9 ± 1.0 Earth masses (Trifonov et al. 2018) beside M = 723.2 ± 1.4 (Rivera et al. 2010), and 55 Cnc e, NN Ser c, HD 82943 b, Kepler-56 c, Kepler-25 c, GJ 876 c and HD 38529 c do the same. Three pairs share a source (TOI-763 b and c, K2-266 d) and differ by 2 to 6 percent. A reader who takes the composite row as one planet's solution gets a sine above one.
