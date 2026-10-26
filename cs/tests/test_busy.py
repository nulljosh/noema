import unittest
from busy import backward, closed_block, closed_tape, decide_holdout, enumerate_machines, ngram_cps, simulate


machine_halts_in_three = {(0, 0): (1, 1, 1), (1, 0): (1, 1, 2)}


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

    def test_translated_cycler_by_hand(self):
        # A0 -> 1RB, A1 -> 1RA, B0 -> 1LA, B1 undefined. Right-edge records in state B: cell 1 at step 1 and
        # cell 3 at step 5. Tape 0..1 at the first record is [1, 0]; tape 2..3 at the second is [1, 0].
        # Shift 2, period 4, never halts: detected at step 5 with three 1s on the tape.
        machine = {(0, 0): (1, 1, 1), (0, 1): (1, 1, 0), (1, 0): (1, -1, 0)}
        self.assertEqual(simulate(machine, 100), ('translated', None, 5, 3))

    def test_three_state_holdouts(self):
        # Translated cyclers leave 92. Backward reasoning proves 55, the closed tape 28, the block tape 5 and the
        # 2-cell-block n-gram closure 4, leaving none.
        result = enumerate_machines(3, 200)
        self.assertEqual((result['holdouts_at_cap'], result['backward_proved'], result['closed_tape_proved'],
                          result['block_tape_proved'], result['ngram_proved']), (0, 55, 28, 5, 4))

    def test_ngram_proves_translated_cycler(self):
        # The same translated cycler as above, closed by plain-cell 2-grams.
        machine = {(0, 0): (1, 1, 1), (0, 1): (1, 1, 0), (1, 0): (1, -1, 0)}
        self.assertTrue(ngram_cps(machine, 2, 1))

    def test_block_tape_proves_parity_machine(self):
        # A run of ones alternates states C and A cell by cell, so a cell-run tape loses the parity and fails.
        # Blocks of two cells keep it, and the block tape proves non-halting.
        machine = {(0, 0): (1, 1, 1), (0, 1): (1, -1, 2), (1, 0): (1, -1, 2), (1, 1): (1, 1, 1), (2, 1): (1, -1, 0)}
        self.assertFalse(closed_tape(machine))
        self.assertTrue(closed_block(machine, 2))

    def test_deciders_prove_a_non_halting_machine(self):
        # A0 -> 1RB, A1 -> 1RA, B0 -> 1LA, B1 undefined never halts (the translated cycler above).
        machine = {(0, 0): (1, 1, 1), (0, 1): (1, 1, 0), (1, 0): (1, -1, 0)}
        self.assertTrue(closed_tape(machine))

    def test_deciders_refuse_a_halting_machine(self):
        # A0 -> 1RB, B0 -> 1RC, C0 undefined: halts after three steps, so neither decider may prove it.
        machine = {(0, 0): (1, 1, 1), (1, 0): (1, 1, 2)}
        self.assertEqual(simulate(machine, 100)[0], 'undefined')
        self.assertFalse(backward(machine, 3))
        self.assertFalse(closed_tape(machine))
        self.assertFalse(closed_block(machine, 2))
        self.assertFalse(ngram_cps(machine, 2, 2))
        self.assertFalse(ngram_cps(machine, 2, 1))
        # The two-state champion halts, so every decider must also refuse it.
        champion = {(0, 0): (1, 1, 1), (0, 1): (1, -1, 1), (1, 0): (1, -1, 0)}
        self.assertFalse(backward(champion, 2))
        self.assertFalse(closed_tape(champion))
        self.assertFalse(closed_block(champion, 2))
        self.assertFalse(ngram_cps(champion, 2, 2))
        self.assertFalse(ngram_cps(champion, 2, 1))
        # The wider deciders must also refuse both halting machines.
        for machine in (machine_halts_in_three, champion):
            self.assertFalse(closed_block(machine, 3))
            self.assertFalse(closed_block(machine, 4))
            self.assertFalse(ngram_cps(machine, 3, 2))
            self.assertFalse(ngram_cps(machine, 2, 3))
            self.assertFalse(ngram_cps(machine, 3, 4))
            self.assertIsNone(decide_holdout(machine, 3 if machine is machine_halts_in_three else 2))

    def test_wider_deciders_on_a_three_state_machine(self):
        # A0 -> 1RB, B0 -> 1RC, C0 undefined: halts in three steps. Every wider decider must refuse it.
        self.assertEqual(simulate(machine_halts_in_three, 100)[0], 'undefined')
