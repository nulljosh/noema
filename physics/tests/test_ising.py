import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ising  # noqa: E402


class IsingTests(unittest.TestCase):
    def test_transfer_matrix_matches_brute_force(self):
        for L in (2, 3, 4):
            self.assertEqual(ising.density_of_states(L), ising.brute_force(L))

    def test_known_small_tori(self):
        self.assertEqual([c for c in ising.density_of_states(3) if c], [2, 18, 48, 198, 144, 102])
        g4 = ising.density_of_states(4)
        self.assertEqual(g4[:12:2], [2, 0, 32, 64, 424, 1728])

    def test_structure(self):
        for L in range(3, 8):
            N, g = L * L, ising.density_of_states(L)
            self.assertEqual(sum(g), 2 ** N)
            self.assertTrue(all(c == 0 for c in g[1::2]))  # flipping a spin changes an even number of bonds
            self.assertEqual(g[0], 2)
            self.assertEqual(g[2], 0)  # a torus has no single domain wall
            self.assertEqual(g[4], 2 * N)  # one flipped spin, from either ground state
            if L % 2 == 0:
                self.assertEqual(g, g[::-1])  # flip every other spin: bipartite symmetry

    def test_kaufman_closed_form_both_sides_of_tc(self):
        for L in range(2, 8):
            g = ising.density_of_states(L)
            for K in (0.3, 0.6):  # Kc = 0.4407
                self.assertAlmostEqual(ising.log_z(g, K), ising.kaufman_log_z(L, K), places=9)

    def test_triangular_matches_brute_force(self):
        for L in (2, 3, 4):
            self.assertEqual(ising.density_of_states(L, triangular=True), ising.brute_force_triangular(L))

    def test_triangular_antiferromagnet_ground_states(self):
        # L = 5 was also checked by listing all 2^25 states (numpy, 2026-10-26): 3630.
        counts = [ising.triangular_ground_states(L)[1] for L in range(2, 8)]
        self.assertEqual(counts, [6, 42, 42, 3630, 263640, 2620800])
        self.assertEqual([ising.no_mono_triangle_count(L) for L in range(2, 8)], counts)  # second method
        self.assertEqual(ising.no_mono_triangle_count(10), 44898196092066)

    def test_closed_form_matches_transfer_counts(self):
        for n in range(2, 12):
            self.assertEqual(ising.triangular_ground_states_formula(n), ising.no_mono_triangle_count(n))

    def test_kasteleyn_signs_class_by_class(self):
        for n in range(2, 6):
            direct = ising.honeycomb_matchings_by_class(n)
            P = {(s, t): ising._torus_product(n, s, t) for s in (1, -1) for t in (1, -1)}
            for (p, q), count in direct.items():
                e = -(-1) ** ((p + 1) * (q + 1)) if n % 2 == 0 else (-1) ** (p * q)
                self.assertEqual(e * sum(s ** p * t ** q * P[s, t] for s in (1, -1) for t in (1, -1)), 4 * count)
            self.assertEqual(2 * direct[n % 2, n % 2], ising.no_mono_triangle_count(n))

    def test_divisibility_by_2n_plus_1(self):
        for n in range(2, 61):
            p = 2 * n + 1
            if all(p % d for d in range(2, int(p ** 0.5) + 1)):
                self.assertEqual(ising.triangular_ground_states_formula(n) % p ** (-(-n // 2) - 1), 0, n)

    def test_specific_heat_peak_falls_toward_onsager(self):
        peaks = [ising.specific_heat_peak(ising.density_of_states(L))[0] for L in range(4, 8)]
        self.assertEqual(peaks, sorted(peaks, reverse=True))
        self.assertTrue(all(p > ising.ONSAGER_TC for p in peaks))


if __name__ == "__main__":
    unittest.main()
