import unittest
from busy import enumerate_machines, simulate


class BusyBeaverTests(unittest.TestCase):
    # Published values: S(n) max steps and Sigma(n) max ones for n = 1, 2, 3 (Rado 1962, Lin and Rado 1965).
    KNOWN = {1: (1, 1), 2: (6, 4), 3: (21, 6)}

    def test_reproduces_published_values(self):
        for n, (steps, ones) in self.KNOWN.items():
            result = enumerate_machines(n, 200)
            self.assertEqual((result['max_steps'], result['max_ones']), (steps, ones), n)

    def test_two_state_champion_by_hand(self):
        # A0 -> 1RB, A1 -> 1LB, B0 -> 1LA, B1 halts: 6 steps, 4 ones.
        machine = {(0, 0): (1, 1, 1), (0, 1): (1, -1, 1), (1, 0): (1, -1, 0)}
        outcome, key, steps, ones = simulate(machine, 100)
        self.assertEqual((outcome, key, steps + 1, ones + 1 - key[1]), ('undefined', (1, 1), 6, 4))

    def test_cycle_detection(self):
        self.assertEqual(simulate({(0, 0): (0, 1, 1), (1, 0): (0, -1, 0)}, 50)[0], 'cycle')
