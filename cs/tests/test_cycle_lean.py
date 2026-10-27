import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import busy
import cycle_lean


class CycleLeanTests(unittest.TestCase):
    def test_every_cycler_repeats_in_lean_shape(self):
        found = []
        busy.enumerate_machines(3, 200, cyclers=found)
        self.assertEqual(len(found), 526)
        for machine in found:
            i, p = cycle_lean.lean_repeat(machine)
            self.assertGreater(p, 0)

    def test_every_translated_cycler_has_a_certificate(self):
        moved = []
        busy.enumerate_machines(3, 200, translated_found=moved)
        self.assertEqual(len(moved), 3027)
        for machine in moved:
            mirror = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
            cert = cycle_lean.lean_translated(machine) or cycle_lean.lean_translated(mirror)
            self.assertIsNotNone(cert, machine)

    def test_tcycles_rejects_a_wrong_period(self):
        machine = {(0, 0): (1, 1, 0)}  # writes 1 and moves right forever
        self.assertTrue(cycle_lean.tcycles(machine, 0, 1, 0))
        self.assertFalse(cycle_lean.tcycles(machine, 0, 0, 0))
        self.assertFalse(cycle_lean.tcycles({(0, 0): (1, 1, 1)}, 0, 1, 0))

    def test_halter_has_no_repeat(self):
        self.assertIsNone(cycle_lean.lean_repeat({(0, 0): (1, 1, 1)}))


if __name__ == '__main__':
    unittest.main()
