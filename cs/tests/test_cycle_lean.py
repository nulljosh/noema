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

    def test_halter_has_no_repeat(self):
        self.assertIsNone(cycle_lean.lean_repeat({(0, 0): (1, 1, 1)}))


if __name__ == '__main__':
    unittest.main()
