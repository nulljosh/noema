"""Export the machines busy.py proves cyclic or translated-cyclic, and every halting branch, as Lean data.

    python3 cycle_lean.py        # 2 and 3 states; writes proofs/FarCerts/Cycles*, Translated* and Halts*.lean

busy.simulate spots a cycle by absolute head position and the nonzero cells. Lean's Config is relative to the
head and keeps the blank cells the head has visited, so the same machine may repeat later in Lean's shape.
lean_repeat runs that shape exactly and returns the first repeat. lean_translated finds (i, p, d) for
Translated.lean's tcycles, on the machine or its mirror, and tcycles below is the same check in Python.
Main asserts a certificate exists for every machine.
"""
import os

import busy
import far_lean

HERE = os.path.dirname(os.path.abspath(__file__))


def lean_step(machine, q, L, a, R):
    """Lean's step on (q, L, a, R), or None on a halt."""
    rule = machine.get((q, a))
    if rule is None:
        return None
    w, m, n = rule
    if m == 1:
        return n, (w,) + L, (R[0] if R else 0), R[1:]
    return n, L[1:], (L[0] if L else 0), (w,) + R


def lean_repeat(machine, budget=5000):
    """(i, p) with Lean's configuration at step i equal to the one at step i + p, or None within budget."""
    c, seen = (0, (), 0, ()), {}
    for t in range(budget):
        if c in seen:
            return seen[c], t - seen[c]
        seen[c] = t
        c = lean_step(machine, *c)
        if c is None:
            return None
    return None


def tcycles(machine, i, p, d):
    """Translated.lean's tcycles: from the step-i configuration on the right edge, p steps that keep inside the
    nearest d cells on the left come back to the same state and symbol on the right edge with those d cells."""
    c = (0, (), 0, ())
    for _ in range(i):
        c = lean_step(machine, *c)
        if c is None:
            return False
    q, L, a, R = c
    if p <= 0 or R or d > len(L):
        return False
    e = (q, L[:d], a, ())
    for _ in range(p):
        if machine.get((e[0], e[2])) is None or (machine[(e[0], e[2])][1] == -1 and not e[1]):
            return False
        e = lean_step(machine, *e)
    return e[0] == q and e[2] == a and not e[3] and e[1][:d] == L[:d] and d <= len(e[1])


def lean_translated(machine, budget=3000):
    """(i, p, d) for tcycles, or None. Only right-edge moments (R empty) are compared."""
    c, pos, heads, edges = (0, (), 0, ()), 0, [], {}
    for t in range(budget):
        heads.append(pos)
        q, L, a, R = c
        if not R:
            for s, Ls in edges.get((q, a), []):
                d = heads[s] - min(heads[s:t + 1])
                if d <= len(Ls) and d <= len(L) and L[:d] == Ls[:d] and tcycles(machine, s, t - s, d):
                    return s, t - s, d
            edges.setdefault((q, a), []).append((t, L))
        rule = machine.get((q, a))
        if rule is None:
            return None
        pos += rule[1]
        c = lean_step(machine, *c)
    return None


def lean_machine(machine, states):
    rules = ', '.join('(%d, %d, %d, %s, %d)' % (q, a, w, 'true' if m == 1 else 'false', n)
                      for (q, a), (w, m, n) in sorted(machine.items()))
    return '{ S := 2, n := %d, rules := [%s] }' % (states, rules)


def lean_halts(machine, k):
    """True when Lean's run reaches step k from blank and no rule applies there."""
    c = (0, (), 0, ())
    for _ in range(k):
        c = lean_step(machine, *c)
        if c is None:
            return False
    return (c[0], c[2]) not in machine


def write(stem, module, typ, check, rows, per, claim='¬ Halts x.1', suffix='never_halt'):
    """rows of Lean tuples, per to a file; returns the module names."""
    names = []
    for k in range(0, len(rows), per):  # ponytail: per file keeps each under the repo's 5000-token file limit
        names.append('%s%d' % (stem, k // per + 1))
        name = names[-1][0].lower() + names[-1][1:]
        chunk = rows[k:k + per]
        out = ['import FarCerts.' + module, '', 'set_option maxRecDepth 100000', '', 'namespace FAR', '',
               'def %s : List (%s) := [' % (name, typ)]
        out += ['  %s%s' % (r, ',' if j < len(chunk) - 1 else '') for j, r in enumerate(chunk)]
        out += [']', '', 'theorem %s_%s : ∀ x ∈ %s, %s := %s %s (by decide +kernel)'
                % (name, suffix, name, claim, check, name), '', 'end FAR', '']
        open(os.path.join(HERE, 'proofs', 'FarCerts', names[-1] + '.lean'), 'w').write('\n'.join(out))
    return names


def write_bb3(names):
    """The longest listed 3-state halter takes 20 steps, then halts on its 21st."""
    lists = ' ++ '.join(n[0].lower() + n[1:] for n in names)
    out = ['import FarCerts.' + n for n in names] + ['', 'set_option maxRecDepth 100000', '', 'namespace FAR', '',
           'theorem bb3_listed_steps : (((%s).filter (·.1.n == 3)).map (·.2)).max? = some 20 := by decide +kernel'
           % lists, '', 'end FAR', '']
    open(os.path.join(HERE, 'proofs', 'FarCerts', 'BB3.lean'), 'w').write('\n'.join(out))


if __name__ == '__main__':
    cycles, translated, halts = [], [], []
    for states, cap in ((2, 50), (3, 200)):
        found, moved, halted = [], [], []
        busy.enumerate_machines(states, cap, cyclers=found, translated_found=moved, halted=halted)
        for machine, k in halted:
            assert lean_halts(machine, k), machine
            halts.append('(%s, %d)' % (lean_machine(machine, states), k))
        for machine in found:
            ip = lean_repeat(machine)
            assert ip is not None, machine
            cycles.append('(%s, %d, %d)' % (lean_machine(machine, states), ip[0], ip[1]))
        for machine in moved:
            mirror = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
            for flag, run in (('false', machine), ('true', mirror)):
                cert = lean_translated(run)
                if cert:
                    break
            assert cert is not None, machine
            translated.append('(%s, %s, %d, %d, %d)' % ((lean_machine(machine, states), flag) + cert))
    a = write('Cycles', 'Cycle', 'Machine × Nat × Nat', 'all_cycle', cycles, 110)
    b = write('Translated', 'Translated', 'Machine × Bool × Nat × Nat × Nat', 'all_tcycle', translated, 100)
    c = write('Halts', 'Halt', 'Machine × Nat', 'all_halt', halts, 110, 'Halts x.1', 'halt')
    write_bb3(c)
    far_lean.write_root()
    print('%d cycles, %d translated cyclers and %d halters certified; wrote %d files'
          % (len(cycles), len(translated), len(halts), len(a + b + c) + 1))
