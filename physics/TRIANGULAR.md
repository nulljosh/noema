# Triangular antiferromagnet ground states on the n x n torus

Status: candidate. A closed form found by fitting and checked against exact counts, plus a divisibility bound with a written argument that rests on that closed form.

## The count

Put Ising spins on the n x n triangular torus: site (r, c) bonds to (r, c+1), (r+1, c) and (r+1, c-1), indices mod n. Ground states of the antiferromagnet are the 2-colourings with no one-colour triangle. Call their number a(n).

a(2..15) = 6, 42, 42, 3630, 263640, 2620800, 906124242, 547003370634, 44898196092066, 81999223056043590, 379028233842678000000, 237768934267004683405590, 2576994357762460833834817536, 87934912263192096558472630935552.

Three independent counts agree: the full energy polynomial (`density_of_states(n, triangular=True)`, n <= 9), a 0/1 row transfer (`no_mono_triangle_count`, n <= 15) and listing every colouring (n <= 5).

## Closed form (observed, n <= 15)

Let P(s, t) be the product of (1 + a + b) over all a with a^n = s and all b with b^n = t. Then

a(n) = ((-1)^n P(1, 1) + 3 P(-1, 1)) / 2.

This has the shape of a Kasteleyn torus formula for dimers on the dual honeycomb lattice: each ground-state pair is one perfect matching, and the torus splits matchings into parity sectors. The coefficients were found by fitting and then hold exactly for all 14 known values with no free parameters left. It is not derived here yet. `triangular_ground_states_formula(n)` computes it with exact integers in milliseconds.

## Divisibility (written argument, conditional on the closed form)

**Claim.** If p = 2n + 1 is prime, then p^(ceil(n/2) - 1) divides a(n).

**Argument.** Write A = P(1, 1) and B = P(-1, 1). Both are rational integers, since the factors are permuted by the Galois group of K = Q(zeta_2n). Because p = 2n + 1, p is 1 mod 2n, so p splits completely in K. Fix a prime ideal q above p. Reduction mod q sends the 2n-th roots of unity one to one onto F_p^*, which has order 2n. The n-th roots of 1 go to the nonzero squares and the n-th roots of -1 to the non-squares.

Since p is unramified, v_p(A) = v_q(A), the sum of v_q(1 + a + b) over all factors. Each factor with 1 + a + b in q adds at least 1. So v_p(A) is at least the number N_A of pairs (x, y) of nonzero squares in F_p with 1 + x + y = 0. Likewise v_p(B) >= N_B, with x a non-square and y a square. If A = 0 (this happens when 3 divides n), only B matters.

These are Gauss's cyclotomic numbers of order 2. Since -1 is a square exactly when p = 1 mod 4, which is when n is even:

- n even: N_A = n/2 - 1, N_B = n/2.
- n odd: N_A = (n + 1)/2, N_B = (n - 1)/2.

Since p >= 5, 2 and 3 are units at p. So v_p(a(n)) >= min(v_p(A), v_p(B)) >= ceil(n/2) - 1.

**Check.** Every prime p = 2n + 1 with n <= 90 satisfies the bound. v_p(A) equals N_A exactly in every case where A is nonzero. v_p(B) equals N_B except at n = 29, 41 and 89, where it is larger.

## What is missing

1. A derivation of the closed form: the Kasteleyn signs and spin-lifting parity on this torus. Until then the claim holds only for n <= 15 plus the formula's own checks.
2. A literature check. Exact ground-state enumeration on finite triangular domains exists (Computer Physics Communications, 2006, "Exact enumeration of the ground states of a triangular Ising antiferromagnet"), and it may contain these torus counts. The divisibility bound was not found anywhere.
