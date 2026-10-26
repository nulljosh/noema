# OEIS draft: triangular antiferromagnet ground states

Not submitted. Joshua reviews it first.

**Name.** Number of ground states of the antiferromagnetic Ising model on the n X n triangular lattice with periodic boundary conditions; equivalently, the number of 2-colorings of the vertices of the n X n triangular torus with no monochromatic triangle.

**Offset.** 2.

**Data (n = 2..10).** 6, 42, 42, 3630, 263640, 2620800, 906124242, 547003370634, 44898196092066

**Comments.** The torus has n^2 sites, 3n^2 bonds and 2n^2 triangles. Site (r, c) bonds to (r, c+1), (r+1, c) and (r+1, c-1), indices mod n. A 2-coloring has the most unlike bonds (2n^2) exactly when every triangle has one like bond, which is when no triangle has all three vertices the same color. log(a(n))/n^2 tends to Wannier's residual entropy 0.33831 (G. H. Wannier, Phys. Rev. 79 (1950), 357); it is 0.33368 at n = 9 and 0.31435 at n = 10. Observed: for n = 4..10 the n = 1 (mod 3) sizes sit lowest (0.234, 0.302, 0.314), so convergence depends on n mod 3.

**Checks.** Two independent programs agree for n = 2..9: a full energy polynomial by row transfer (`ising.py`, `density_of_states(n, triangular=True)`) and a 0/1 transfer over rows with no monochromatic triangle (`no_mono_triangle_count`). Listing all 2^n^2 colorings agrees for n <= 5.

**Program.** Python, `noema/physics/ising.py`: `python3 ising.py tri 12`.

**Literature search (2026-10-26).** No OEIS entry for these terms and no published table found by web search for the exact torus counts. The limit is classical (Wannier 1950; Houtappel 1950; Stephenson 1964 via dimers).
