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


class FiniteAutomataReductionTests(unittest.TestCase):
    @staticmethod
    def parse(text):
        machine = {}
        for state, rule in enumerate(text.split('_')):
            for symbol in (0, 1):
                entry = rule[3 * symbol:3 * symbol + 3]
                if entry[0] != '-':
                    machine[(state, symbol)] = (int(entry[0]), 1 if entry[1] == 'R' else -1, ord(entry[2]) - ord('A'))
        return machine

    def test_far_refuses_the_four_state_champion(self):
        # Halts at step 107, so no certificate may exist. The search gives up within its budget.
        import far
        champion = self.parse('1RB1LB_1LA0LC_---1LD_1RD0RA')
        self.assertIsNone(far.certify(champion, 4, budget=2.0))

    def test_direct_far_finds_a_known_certificate_and_refuses_the_champion(self):
        # The direct search must re-find a certificate for a machine the merge search already certified,
        # and find none for the champion, which halts at step 107.
        import json
        import far
        import busy
        with open(busy.CERTIFICATES) as handle:
            row = json.load(handle)[0]
        machine = {tuple(k): tuple(v) for k, v in row['machine']}
        self.assertIsNotNone(far.direct_certificate(machine, 4, sizes=(1, 2, 3)))
        self.assertIsNone(far.direct_certificate(self.parse('1RB1LB_1LA0LC_---1LD_1RD0RA'), 4))

    def test_stored_certificates_recheck_exactly(self):
        # Every row of far-certificates.json passes the exact automaton check that busy.py runs on each holdout.
        import json
        import busy
        with open(busy.CERTIFICATES) as handle:
            rows = json.load(handle)
        self.assertEqual(len(rows), 41)
        for row in rows:
            machine = {tuple(k): tuple(v) for k, v in row['machine']}
            self.assertTrue(busy.far_certified(machine, 4), row['index'])

    def test_word_checker_accepts_a_stored_certificate_and_rejects_a_bad_one(self):
        import far
        import far_verify
        import json
        import busy
        with open(busy.CERTIFICATES) as handle:
            row = json.load(handle)[0]
        machine = {tuple(k): tuple(v) for k, v in row['machine']}
        if row['orientation'] == 'mirror':
            machine = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
        dfa = far.DFA(row['delta'], row['acc'])
        self.assertEqual(far_verify.verify(machine, 4, dfa, max_len=3), 'ok')
        # The bare undefined-letter language is not a certificate for the champion: its predecessors escape it.
        bare = far.empty_word_dfa(self.parse('1RB1LB_1LA0LC_---1LD_1RD0RA'), 4)
        self.assertNotEqual(far_verify.verify(self.parse('1RB1LB_1LA0LC_---1LD_1RD0RA'), 4, bare, max_len=3), 'ok')

    def test_transducer_matches_direct_rewriting(self):
        # pre_dfa must accept u exactly when the direct one-step rewrite fwd(u) is defined and lies in L, over every
        # word up to length 5, for a stored certificate and for the bare undefined-letter language E.
        import itertools
        import json
        import far
        import far_verify
        import busy
        with open(busy.CERTIFICATES) as handle:
            row = json.load(handle)[0]
        machine = {tuple(k): tuple(v) for k, v in row['machine']}
        if row['orientation'] == 'mirror':
            machine = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
        cert = far.DFA(row['delta'], row['acc'])
        bare = far.minimize(far.empty_word_dfa(machine, 4))
        for dfa in (cert, bare):
            pre = far.pre_dfa(machine, dfa, 4)
            for n in range(1, 6):
                for word in itertools.product(range(10), repeat=n):
                    f = far_verify.fwd(machine, word)
                    expected = f is not None and far_verify.run(dfa, f)
                    self.assertEqual(far_verify.run(pre, word), expected, word)
