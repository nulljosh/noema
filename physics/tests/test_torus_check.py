import os
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import torus_check


class TorusCheckTest(unittest.TestCase):
    def test_dual_graph_is_the_honeycomb_torus(self):
        """2 n^2 triangles, 3 n^2 bonds, every triangle in exactly 3 of them."""
        for n in (2, 3):
            es = torus_check.bonds(n)
            self.assertEqual(len(es), 3 * n * n)
            self.assertEqual(len(torus_check.triangles(n)), 2 * n * n)
            degree = {}
            for u, d, _, _ in es:
                degree[u] = degree.get(u, 0) + 1
                degree[d] = degree.get(d, 0) + 1
            self.assertEqual(set(degree.values()), {3})

    def test_determinants_reproduce_the_enumerated_classes(self):
        """Step 4 of TRIANGULAR.md: the four P(s, t) invert to the four crossing-parity class counts."""
        for n in (2, 3, 4, 5):
            direct, det, _, _ = torus_check.check(n)
            self.assertEqual({k: abs(v) for k, v in det.items()}, direct, n)

    def test_ground_states_are_twice_one_class(self):
        """a(n) = 2 N(n mod 2, n mod 2), against the independent transfer-matrix count."""
        for n in (2, 3, 4, 5):
            _, _, a, counted = torus_check.check(n)
            self.assertEqual(a, counted, n)

    def test_only_the_used_class_is_positive(self):
        """The class a(n) reads off comes out positive, the other three negative."""
        for n in (2, 3, 4, 5):
            _, det, _, _ = torus_check.check(n)
            positive = [k for k, v in det.items() if v > 0]
            self.assertEqual(positive, [(n % 2, n % 2)], n)


if __name__ == '__main__':
    unittest.main()
