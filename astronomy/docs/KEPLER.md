# Kepler's third law across the exoplanet archive

`kepler.py` takes every planet in the NASA Exoplanet Archive composite table with a period, a semi-major axis and a stellar mass, 5,609 of them on 2026-10-28, and computes a^3 / ((M_star + M_planet) P^2) in AU, years and solar masses. The law holds: the median is 1.000 and half the planets sit within 0.014 dex of it. 324 give exactly 1, because the archive or the paper derived a from P and M by the law itself. 55 miss by more than a factor of two, and in 41 of those all three numbers come from one reference, so the contradiction is not the archive mixing sources. 13 of the 41 come from Stassun et al. (2017), which re-derived stellar masses from Gaia parallaxes while the orbit sizes stayed as published.

## Papers read

XO-6 b (Crouzet et al. 2017, AJ 153, 94, arXiv:1612.02776), ratio 3.46. The paper's Table 5 gives P = 3.7650007 days and a = 0.0815 ± 0.0077 au, and Table 6 gives M_star = 1.47 ± 0.06 and R_star = 1.93 ± 0.18 solar. The archive copies them faithfully. The 0.0815 au is a/R_star = 9.08 times R_star = 1.93 solar radii, so the orbit size comes from the transit shape and the spectroscopic radius, not from the period and mass. Kepler's law with P and M gives 0.054 au, or a/R_star = 6.0 with that radius. The two disagree because the transit's stellar density (the table's 1.0 g/cm^3) wants a star near 1.3 solar radii, not 1.93; the paper points to its own discussion of the radius. So this outlier is a known tension inside the paper, not a transcription error.

Next: read the other single-source outliers outside Stassun et al., starting with KOI-2513.01 (ratio 50), TOI-262 b (5.1) and K2-285 e (4.3), and sort each into transcription, unit slip or a tension like XO-6 b's.
