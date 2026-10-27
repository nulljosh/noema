import json
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import busy
import far
import far_lean


class LocalCheckTests(unittest.TestCase):
    def test_local_check_matches_holds(self):
        far.SYMBOLS = 2
        rows = json.load(open(os.path.join(far_lean.HERE, 'far-certificates.json')))
        for row in rows:
            machine, dfa = far_lean.oriented(row), far.DFA(row['delta'], row['acc'])
            self.assertTrue(far_lean.local_check(machine, 4, dfa), row['index'])
            broken = far.DFA(row['delta'], [not a for a in row['acc']])
            self.assertFalse(far_lean.local_check(machine, 4, broken), row['index'])

    def test_every_tape_decided_3_state_machine_has_a_certificate(self):
        flagged = []
        busy.enumerate_machines(3, 200, flagged=flagged)
        far.SYMBOLS = 2
        rows = json.load(open(os.path.join(far_lean.HERE, 'far-certificates-3.json')))
        self.assertEqual(len(flagged), 92)
        machines = [{(q, a): tuple(r) for (q, a), r in row['machine']} for row in rows]
        for machine in flagged:
            self.assertIn(machine, machines)
        for row in rows:
            dfa = far.DFA(row['delta'], row['acc'])
            self.assertTrue(far_lean.local_check(far_lean.oriented(row), 3, dfa), row['index'])


if __name__ == '__main__':
    unittest.main()
