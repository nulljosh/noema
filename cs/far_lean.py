"""Export the FAR certificates in far-certificates.json as Lean data with witnesses the kernel can check locally.

    python3 far_lean.py        # checks every certificate locally, then writes proofs/FarCerts/Certs*.lean

far.holds checks pre(L) in L by building a product automaton. Here the same condition is split into local facts
that Lean checks by `decide`, given witnesses computed below:
  rel        the greatest relation on DFA states with acc p -> acc q, closed under tape letters. (p, q) in rel means
             every tape-only suffix that p accepts, q accepts too.
  I3         for every state s reached by tape letters and every rule window before -> after, (s.after, s.before)
             is in rel. fwd only rewrites the window of a single-head word, so this is exactly pre(L) in L.
  E          every undefined head letter, read from any reachable state, lands in an all-accepting closed set.
  I1         zeros, the blank head letter, then zeros never reach an accepting state.
"""
import json
import os

import far

HERE = os.path.dirname(os.path.abspath(__file__))


def _closure(start, letters, d):
    seen, todo = set(start), list(start)
    while todo:
        s = todo.pop()
        for x in letters:
            t = d(s, x)
            if t not in seen:
                seen.add(t)
                todo.append(t)
    return seen


def _greatest(cands, ok):
    """Largest subset of cands where ok(item, current set) holds for every item."""
    cur = set(cands)
    while True:
        bad = {c for c in cur if not ok(c, cur)}
        if not bad:
            return cur
        cur -= bad


def witnesses(machine, states, dfa):
    S, nl = far.SYMBOLS, far.letter_count(states)
    d = lambda s, x: dfa.delta[s][x]
    tape, every = range(S), range(nl)
    reach_all = _closure({0}, every, d)
    good = _greatest(range(len(dfa)), lambda s, cur: dfa.acc[s] and all(d(s, x) in cur for x in every))
    reach_tape = _closure({0}, tape, d)
    pairs = [(p, q) for p in range(len(dfa)) for q in range(len(dfa))]
    rel = _greatest(pairs, lambda pq, cur: (not dfa.acc[pq[0]] or dfa.acc[pq[1]])
                    and all((d(pq[0], x), d(pq[1], x)) in cur for x in tape))
    z = _closure({0}, [0], d)
    z2 = _closure({d(s, far.state_letter(0, 0)) for s in z}, [0], d)
    return reach_all, good, reach_tape, rel, z, z2


def windows(machine):
    """(before, after) for every rule and every neighbour symbol b."""
    for (q, a), (w, m, n) in machine.items():
        for b in range(far.SYMBOLS):
            if m == 1:
                yield (far.state_letter(q, a), b), (w, far.state_letter(n, b))
            else:
                yield (b, far.state_letter(q, a)), (far.state_letter(n, b), w)


def local_check(machine, states, dfa):
    reach_all, good, reach_tape, rel, z, z2 = witnesses(machine, states, dfa)
    run = lambda s, word: s if not word else run(dfa.delta[s][word[0]], word[1:])
    e = all(dfa.delta[s][x] in good for s in reach_all for x in far.undefined_letters(machine, states))
    i1 = not any(dfa.acc[s] for s in z2)
    i3 = all((run(s, after), run(s, before)) in rel for s in reach_tape for before, after in windows(machine))
    return e and i1 and i3


def oriented(row):
    machine = {(q, a): tuple(r) for (q, a), r in row['machine']}
    if row['orientation'] == 'mirror':
        machine = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
    return machine


def write_root():
    """proofs/FarCerts.lean imports every module in proofs/FarCerts, so far_lean.py and cycle_lean.py share it."""
    mods = sorted(f[:-5] for f in os.listdir(os.path.join(HERE, 'proofs', 'FarCerts')) if f.endswith('.lean'))
    open(os.path.join(HERE, 'proofs', 'FarCerts.lean'), 'w').write(''.join('import FarCerts.%s\n' % m for m in mods))


def lean_cert(row, states):
    machine = {(q, a): tuple(r) for (q, a), r in row['machine']}
    dfa = far.DFA(row['delta'], row['acc'])
    reach_all, good, reach_tape, rel, z, z2 = witnesses(oriented(row), states, dfa)
    nat = lambda xs: '[' + ', '.join(str(x) for x in sorted(xs)) + ']'
    rules = ', '.join('(%d, %d, %d, %s, %d)' % (q, a, w, 'true' if m == 1 else 'false', n)
                      for (q, a), (w, m, n) in sorted(machine.items()))
    name = 'm_' + str(row['index']).replace('-', '_')
    return '\n'.join([
        'def %s : Machine := { S := %d, n := %d, rules := [%s] }' % (name, far.SYMBOLS, states, rules),
        'def %s_cert : Cert := {' % name,
        '  delta := [%s],' % ', '.join('[' + ', '.join(map(str, r)) + ']' for r in row['delta']),
        '  acc := [%s],' % ', '.join('true' if a else 'false' for a in row['acc']),
        '  reachAll := %s, good := %s, reachTape := %s,' % (nat(reach_all), nat(good), nat(reach_tape)),
        '  rel := [%s],' % ', '.join('(%d, %d)' % pq for pq in sorted(rel)),
        '  z := %s, z2 := %s }' % (nat(z), nat(z2)),
        'theorem %s_never_halts : ¬ Halts %s := %s %s %s_cert (by decide +kernel)' % (
            name, name, 'never_halts_of_mirror' if row['orientation'] == 'mirror' else 'never_halts',
            name, name),
        ''])


if __name__ == '__main__':
    rows = json.load(open(os.path.join(HERE, 'far-certificates.json')))
    states = 4
    far.SYMBOLS = 2
    for row in rows:
        machine, dfa = oriented(row), far.DFA(row['delta'], row['acc'])
        assert far.holds(machine, states, dfa) == local_check(machine, states, dfa) == True, row['index']
        broken = far.DFA(row['delta'], [not a for a in row['acc']])  # a wrong certificate must fail both ways
        assert far.holds(machine, states, broken) == local_check(machine, states, broken) == False, row['index']
    names = []
    for k in range(0, len(rows), 8):  # ponytail: 8 per file keeps each under the repo's 5000-token file limit
        names.append('Certs%d' % (k // 8 + 1))
        out = ['import FarCerts.Basic', '', 'set_option maxRecDepth 100000', '', 'namespace FAR', '']
        out += [lean_cert(row, states) for row in rows[k:k + 8]] + ['end FAR', '']
        open(os.path.join(HERE, 'proofs', 'FarCerts', names[-1] + '.lean'), 'w').write('\n'.join(out))
    write_root()
    print('%d certificates agree with far.holds; wrote %d files' % (len(rows), len(names)))
