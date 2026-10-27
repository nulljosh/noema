"""Export the machines busy.py proves cyclic as Lean data, each with steps (i, p) where Lean's run repeats.

    python3 cycle_lean.py        # 2 and 3 states; writes proofs/FarCerts/Cycles*.lean

busy.simulate spots a cycle by absolute head position and the nonzero cells. Lean's Config is relative to the
head and keeps the blank cells the head has visited, so the same machine may repeat later in Lean's shape.
lean_repeat runs that shape exactly and returns the first repeat; main asserts one exists for every machine.
"""
import os

import busy
import far_lean

HERE = os.path.dirname(os.path.abspath(__file__))


def lean_repeat(machine, budget=5000):
    """(i, p) with Lean's configuration at step i equal to the one at step i + p, or None within budget."""
    q, L, a, R, seen = 0, (), 0, (), {}
    for t in range(budget):
        key = (q, L, a, R)
        if key in seen:
            return seen[key], t - seen[key]
        seen[key] = t
        rule = machine.get((q, a))
        if rule is None:
            return None
        w, m, q = rule
        if m == 1:
            L, a, R = (w,) + L, (R[0] if R else 0), R[1:]
        else:
            L, a, R = L[1:], (L[0] if L else 0), (w,) + R
    return None


def lean_machine(machine, states):
    rules = ', '.join('(%d, %d, %d, %s, %d)' % (q, a, w, 'true' if m == 1 else 'false', n)
                      for (q, a), (w, m, n) in sorted(machine.items()))
    return '{ S := 2, n := %d, rules := [%s] }' % (states, rules)


if __name__ == '__main__':
    rows = []
    for states, cap in ((2, 50), (3, 200)):
        found = []
        busy.enumerate_machines(states, cap, cyclers=found)
        for machine in found:
            ip = lean_repeat(machine)
            assert ip is not None, machine
            rows.append((states, machine, ip))
    names = []
    for k in range(0, len(rows), 110):  # ponytail: 110 per file keeps each under the repo's 5000-token file limit
        names.append('Cycles%d' % (k // 110 + 1))
        name = 'cycles' + names[-1][6:]
        out = ['import FarCerts.Cycle', '', 'set_option maxRecDepth 100000', '', 'namespace FAR', '',
               'def %s : List (Machine × Nat × Nat) := [' % name]
        out += ['  (%s, %d, %d)%s' % (lean_machine(m, s), i, p, ',' if j < len(rows[k:k + 110]) - 1 else '')
                for j, (s, m, (i, p)) in enumerate(rows[k:k + 110])]
        out += [']', '', 'theorem %s_never_halt : ∀ x ∈ %s, ¬ Halts x.1 := all_cycle %s (by decide +kernel)'
                % (name, name, name), '', 'end FAR', '']
        open(os.path.join(HERE, 'proofs', 'FarCerts', names[-1] + '.lean'), 'w').write('\n'.join(out))
    far_lean.write_root()
    print('%d cyclic machines repeat in Lean shape; wrote %d files' % (len(rows), len(names)))
