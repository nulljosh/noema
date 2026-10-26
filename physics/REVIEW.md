# Referee review of TRIANGULAR.md

Verdict: error (narrow). The closed form and the divisibility bound both hold. One numerical check in the prose is wrong, one notation is wrong, and one sentence contradicts the proof.

## What was checked

- Closed form: matches all 14 listed counts for n = 2..15.
- Ground-state counts: the formula, the 0/1 transfer and the energy polynomial agree for n = 2..9. Brute-force listing agrees for n = 2..4. The transfer was not re-run for n = 10..15.
- Steps 1 to 3: the matching enumeration for n = 2..5 gives 2 N(n mod 2, n mod 2) = 6, 42, 42, 3630. The triangle and bond definitions in ising.py match the proof once the labels are fixed (issue 3).
- Step 4: the class counts from enumeration match (e/4) times the sum of s^p t^q P(s,t) in all four parity classes, for n = 2..5.
- Step 5: P(1,-1) = P(-1,1) and P(-1,-1) = (-1)^n P(-1,1) hold for n = 2..12. The determinant of the weighted matrix equals P(s,t) for n = 2..5.
- Cyclotomic numbers: direct counts in F_p for all 76 primes p = 2n+1 below 400 (n = 2..198) match N_A and N_B.
- Bound: p^(ceil(n/2) - 1) divides a(n) for every prime p = 2n+1 with n = 2..120.

## Issues

1. **Error. Divisibility section, "Check" paragraph.** The text says v_p(A) equals N_A in every case where A is nonzero, and v_p(B) equals N_B except at n = 29, 41 and 89. Within n <= 120 this is false. B also fails at n = 96 (p = 193: actual 50, stated 48). A fails at n = 113 (p = 227: actual 63, stated 57). Fix: drop the equality sentences. The proof only uses v_p >= N_A and v_p >= N_B, so nothing else depends on them. If you keep them, limit them to n <= 90.

2. **Error. Step 4, "K(s,t) = I + sX + tY".** Read literally, s multiplies every X step, not only the wrap steps. Then X^n = I, not sI, and the eigenvalue step in Step 5 fails. Fix: write K = I + X_s + Y_t, where X_s has weight s only on the step out of row 0. Y_t is defined the same way for columns. This version gives det K = P(s,t).

3. **Minor. Step 4, site labels.** U(r,c) and D(r,c) are never defined as site sets. The adjacency claims hold only for U(r,c) = {(r,c-1), (r,c), (r+1,c-1)} and D(r,c) = {(r,c), (r+1,c), (r+1,c-1)}. The natural choice U(r,c) = {(r,c), (r,c+1), (r+1,c)} shares a vertical bond with D(r,c), not a diagonal. Fix: state both site sets.

4. **Contradiction. Closed form section.** It says "It is not derived here yet," but the status line claims a complete proof and Step 6 says "This proves the closed form." Fix: delete the sentence.

5. **Minor. Step 2.** "Closed path" should be "closed cycle."

6. **Minor. Step 3.** The parity class of M is absolute. M0 meets neither loop, so "relative to M0" is misleading. Drop it.

7. **Minor. Step 5.** The factor (-1)^n comes from the product of the a over the roots of a^n = -1, which is (-1)^n. Each a occurs n times among the pairs. Say so explicitly.

## Runtime

Formula calls for n = 2..60 took about 2.4 s in total. For n = 61..120, the full check (formula plus two exact products per prime) took about 460 s. The largest single call took about 30 s.
