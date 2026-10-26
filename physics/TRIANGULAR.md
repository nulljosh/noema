# Triangular antiferromagnet ground states on the n x n torus

Status: candidate with a complete written proof (closed form and divisibility bound), checked numerically far past where it was found. Novelty is not yet confirmed: the counts, or the closed form, may already be published.

## The count

Put Ising spins on the n x n triangular torus: site (r, c) bonds to (r, c+1), (r+1, c) and (r+1, c-1), indices mod n. Ground states of the antiferromagnet are the 2-colourings with no one-colour triangle. Call their number a(n).

a(2..15) = 6, 42, 42, 3630, 263640, 2620800, 906124242, 547003370634, 44898196092066, 81999223056043590, 379028233842678000000, 237768934267004683405590, 2576994357762460833834817536, 87934912263192096558472630935552.

Three independent counts agree: the full energy polynomial (`density_of_states(n, triangular=True)`, n <= 9), a 0/1 row transfer (`no_mono_triangle_count`, n <= 15) and listing every colouring (n <= 5).

## Closed form (found by fitting, proved below)

Let P(s, t) be the product of (1 + a + b) over all a with a^n = s and all b with b^n = t. Then

a(n) = ((-1)^n P(1, 1) + 3 P(-1, 1)) / 2.

This has the shape of a Kasteleyn torus formula for dimers on the dual honeycomb lattice: each ground-state pair is one perfect matching, and the torus splits matchings into parity sectors. The coefficients were found by fitting and then hold exactly for all 14 known values with no free parameters left. It is not derived here yet. `triangular_ground_states_formula(n)` computes it with exact integers in milliseconds.

## Proof of the closed form

1. **Spins to matchings.** Each bond lies in one up triangle and one down triangle. So the dual graph H, with a vertex per triangle and an edge per bond, is a honeycomb lattice on the torus, and it is bipartite (up against down). In a ground state, each triangle has exactly one like bond. So the like bonds form a perfect matching M of H. Flipping every spin gives the same M, so the map is two to one.

2. **Which matchings come from spins.** Given M, call the bonds in M like and the rest unlike. Spins exist exactly when every closed path of bonds has an even number of unlike bonds. Around a triangle there are 3 bonds and 1 is like, so 2 are unlike: even. Triangles generate every contractible cycle. So only the two loops around the torus matter: a row γ1 of n horizontal bonds and a column γ2 of n vertical bonds. The condition is |M ∩ γ1| ≡ |M ∩ γ2| ≡ n (mod 2). So a(n) = 2 N(n, n), where N(e1, e2) counts matchings with those crossing parities.

3. **Reference matching.** The n^2 diagonal bonds (r, c)-(r+1, c-1) form a perfect matching M0: each diagonal is the shared bond of one up and one down triangle. M0 meets neither γ1 nor γ2. So the parity class of M relative to M0 is (|M ∩ γ1|, |M ∩ γ2|) mod 2.

4. **The determinant counts matchings with known signs.** Label up triangles U(r, c) and down triangles D(r, c). U(r, c) touches D(r, c) through its diagonal, D(r-1, c) through its horizontal bond and D(r, c-1) through its vertical bond. Let K(s, t) = I + sX + tY, where X sends (r, c) to (r-1, c), Y sends (r, c) to (r, c-1), and the weight s (or t) is picked up only on a step that wraps from row 0 (or column 0). A perfect matching is a permutation σ of the n^2 sites with every σ(x) - x in {0, -e_r, -e_c}, so det K(s, t) is the sum over matchings of sgn(σ) times its weight.

   Fixed points of σ are diagonal bonds, the reference M0. The other points form cycles that step only by -e_r and -e_c. So each cycle is a closed lattice path winding u >= 0 times around one way and v >= 0 times around the other, with (u, v) not (0, 0), and its length is n(u + v). Different cycles share no vertex, and grid edges meet only at vertices, so the cycles are disjoint simple closed curves on the torus. Disjoint non-contractible simple curves are parallel, so all k cycles have the same primitive class (u, v).

   Each cycle wraps u times in r and v times in c, so the weight is s^(ku) t^(kv). Each cycle passes every row u times and every column v times, and an r-step out of row 0 uses a horizontal bond of row 0. Likewise a c-step out of column c + 1 uses a vertical bond of column c. So |M ∩ γ1| = ku and |M ∩ γ2| = kv for any choice of row and column. With s, t = ±1, the weight is s^p t^q for the parity class (p, q). The sign is the product of (-1)^(length - 1) over cycles: (-1)^(k(n(u+v) - 1)).

   Reading off the classes: k = 0 or k even gives (0, 0) with sign +1. k odd gives (p, q) = (u, v) mod 2. Class (1, 0) or (0, 1) has u + v odd and sign (-1)^(n+1). Class (1, 1) has u + v even and sign -1. So e(0, 0) = +1, e(0, 1) = e(1, 0) = (-1)^(n+1) and e(1, 1) = -1. This is the classical Kasteleyn torus sign pattern (Kasteleyn 1961), derived here for this lattice. The direct class counts for n = 2..5 (`honeycomb_matchings_by_class`) match it class by class. Inverting over s, t in {1, -1} gives N(p, q) = e(p, q) / 4 times the sum over s, t of s^p t^q det K(s, t).

5. **Diagonalising.** X and Y commute, X^n = sI and Y^n = tI, and they act on separate coordinates. So the eigenvalues of K(s, t) are 1 + a + b over every a with a^n = s and every b with b^n = t, and det K(s, t) = P(s, t). Swapping the roles of a and b gives P(1, -1) = P(-1, 1). Writing 1 + a + b = a(1 + a^-1 + b a^-1) maps the pairs for (-1, -1) one to one onto the pairs for (-1, 1). The leftover factor is (product of the a)^n = ((-1)^n)^n = (-1)^n, so P(-1, -1) = (-1)^n P(-1, 1).

6. **Assembling.** For even n, take class (0, 0), where e = +1: N(0, 0) = (A + B + B + B) / 4, so a(n) = (A + 3B) / 2. For odd n, take class (1, 1), where e = -1: N(1, 1) = -(A - B - B - B) / 4, so a(n) = (-A + 3B) / 2. Together, a(n) = ((-1)^n A + 3B) / 2.

This proves the closed form for every n >= 2. The 14 exact counts for n = 2..15 agree with it.

## Divisibility (theorem, with written proof)

**Claim.** If p = 2n + 1 is prime, then p^(ceil(n/2) - 1) divides a(n).

**Argument.** Write A = P(1, 1) and B = P(-1, 1). Both are rational integers, since the factors are permuted by the Galois group of K = Q(zeta_2n). Because p = 2n + 1, p is 1 mod 2n, so p splits completely in K. Fix a prime ideal q above p. Reduction mod q sends the 2n-th roots of unity one to one onto F_p^*, which has order 2n. The n-th roots of 1 go to the nonzero squares and the n-th roots of -1 to the non-squares.

Since p is unramified, v_p(A) = v_q(A), the sum of v_q(1 + a + b) over all factors. Each factor with 1 + a + b in q adds at least 1. So v_p(A) is at least the number N_A of pairs (x, y) of nonzero squares in F_p with 1 + x + y = 0. Likewise v_p(B) >= N_B, with x a non-square and y a square. If A = 0 (this happens when 3 divides n), only B matters.

These are Gauss's cyclotomic numbers of order 2. Since -1 is a square exactly when p = 1 mod 4, which is when n is even:

- n even: N_A = n/2 - 1, N_B = n/2.
- n odd: N_A = (n + 1)/2, N_B = (n - 1)/2.

Since p >= 5, 2 and 3 are units at p. So v_p(a(n)) >= min(v_p(A), v_p(B)) >= ceil(n/2) - 1.

**Check.** Every prime p = 2n + 1 with n <= 90 satisfies the bound. v_p(A) equals N_A exactly in every case where A is nonzero. v_p(B) equals N_B except at n = 29, 41 and 89, where it is larger.

## What is missing

1. An outside reader to check the proof, especially the cycle-sign step 4.
2. A literature check. Exact ground-state enumeration on finite triangular domains exists (Computer Physics Communications, 2006, "Exact enumeration of the ground states of a triangular Ising antiferromagnet"), and it may contain these torus counts. The divisibility bound was not found anywhere.
