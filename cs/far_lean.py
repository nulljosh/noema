"""Export the FAR certificates in far-certificates.json (4 states) and far-certificates-3.json (3 states) as Lean
data with witnesses the kernel can check locally.

    python3 far_lean.py        # checks every certificate locally, then writes proofs/FarCerts/Certs*.lean and Small*.lean

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
import re

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


BB3 = {'S': 2, 'N': 3, 'B': 20, 'tag': '3', 'stems': ('Cycles', 'Translated', 'Small'), 'certs': 'far-certificates-3.json',
       'file': 'BB3Tree.lean', 'what': 'BB(3) = 21', 'champion': '(0, 0, 1, true, 1), (1, 0, 1, false, 1), '
       '(1, 1, 0, true, 2), (2, 0, 1, false, 2), (2, 1, 1, false, 0)'}
BB23 = {'S': 3, 'N': 2, 'B': 37, 'tag': '23', 'stems': ('WCycles', 'WTranslated', 'WSmall'),
        'certs': 'far-certificates-23.json', 'file': 'BB23Tree.lean', 'what': 'BB(2,3) = 38', 'small_lists': True,
        'champion': '(0, 0, 1, true, 1), (0, 1, 2, false, 1), (1, 0, 2, false, 0), (1, 1, 2, true, 1), '
        '(1, 2, 1, false, 1)'}


def small_chain(mods):
    proof = '%s_never_halt' % (mods[0][0].lower() + mods[0][1:])
    for m in mods[1:]:
        proof = 'forall_append (%s) %s_never_halt' % (proof, m[0].lower() + m[1:])
    return proof


def small_list(stem, rows):
    """The machines one certificate file proves never halt, as a list with its proof."""
    names = ['m_' + str(row['index']).replace('-', '_') for row in rows]
    proof = 'fun _ h => nomatch h'
    for n in reversed(names):
        proof = 'List.forall_mem_cons.2 ⟨%s_never_halts, %s⟩' % (n, proof)
    low = stem[0].lower() + stem[1:]
    return ['def %s : List Machine := [%s]' % (low, ', '.join(names)),
            'theorem %s_never_halt : ∀ x ∈ %s, ¬ Halts x :=' % (low, low), '  ' + proof, '']


def write_tree(t):
    """<t>Tree.lean replays busy.py's tree for one shape in Lean against the three lists of machines proved never
    to halt, then proves the busy beaver value from it and a champion."""
    S, N, B, tag = t['S'], t['N'], t['B'], t['tag']
    folder = os.path.join(HERE, 'proofs', 'FarCerts')
    mods = lambda stem: sorted((f[:-5] for f in os.listdir(folder) if re.fullmatch(stem + r'\d+\.lean', f)),
                               key=lambda m: int(m[len(stem):]))
    low = lambda m: m[0].lower() + m[1:]
    cyc, tr, small = map(mods, t['stems'])
    names = ['m_' + row['index'] for row in json.load(open(os.path.join(HERE, t['certs'])))]

    def listed(name, parts, stem):
        joined = '%s_%s' % (low(parts[0]), stem)
        for m in parts[1:]:
            joined = 'forall_append (%s) %s_%s' % (joined, low(m), stem)
        return ['def %s : List Machine := ((%s).filter (fun x => x.1.n == %d && x.1.S == %d)).map (·.1)'
                % (name, ' ++ '.join(map(low, parts)), N, S),
                'theorem %s_never_halt : ∀ x ∈ %s, ¬ Halts x := by' % (name, name),
                '  intro x hx',
                '  unfold %s at hx' % name,
                '  obtain ⟨y, hy, rfl⟩ := List.mem_map.1 hx',
                '  exact (%s) y (List.mem_filter.1 hy).1' % joined, '']

    if t.get('small_lists'):  # each WSmall file lists its own machines, which keeps this file under 20 KB
        body, proof = ' ++ '.join(map(low, small)), small_chain(small)
    else:
        body = '[%s]' % ', '.join(names)
        proof = 'fun _ h => nomatch h'
        for n in reversed(names):
            proof = 'List.forall_mem_cons.2 ⟨%s_never_halts, %s⟩' % (n, proof)
    q = 'cyc%s, tr%s, far%s' % (tag, tag, tag)
    shape = '%d %d %d %d' % (S, N, B, S * N + 2)
    out = ['import FarCerts.Explore'] + ['import FarCerts.' + m for m in cyc + tr + small] + [
        '', 'set_option maxRecDepth 100000', '', 'namespace FAR', '']
    out += listed('cyc' + tag, cyc, 'never_halt') + listed('tr' + tag, tr, 'never_halt')
    out += ['def far%s : List Machine := %s' % (tag, body),
            'theorem far%s_never_halt : ∀ x ∈ far%s, ¬ Halts x :=' % (tag, tag), '  ' + proof, '',
            '/-- No %d-symbol, %d-state machine halts after more than %d steps from blank. -/' % (S, N, B),
            'theorem bb%s_steps_le : ∀ M, WF %d %d M → ∀ k, haltsAt M k = true → k ≤ %d :=' % (tag, S, N, B),
            '  bb_of_explore (by decide) (%s) ⟨cyc%s_never_halt, tr%s_never_halt, far%s_never_halt⟩ (by decide +kernel)'
            % (q, tag, tag, tag), '',
            'def champion%s : Machine := { S := %d, n := %d, rules := [%s] }' % (tag, S, N, t['champion']), '',
            '/-- %s: one machine takes %d steps and halts on its next, and none takes longer. -/' % (t['what'], B),
            'theorem bb%s : (∃ M, WF %d %d M ∧ haltsAt M %d = true) ∧ ∀ M, WF %d %d M → ∀ k, haltsAt M k = true → k ≤ %d :='
            % (tag, S, N, B, S, N, B),
            '  ⟨⟨champion%s, wf_of_rules (by decide), by decide +kernel⟩, bb%s_steps_le⟩' % (tag, tag), '',
            '-- sabotage: the replay fails without one never-halting machine, and the champion is not halted later',
            'example : (explore %s (root %d %d) (cyc%s, tr%s, far%s.tail)).isSome = false := by decide +kernel'
            % (shape, S, N, tag, tag, tag),
            'example : haltsAt champion%s %d = false := by decide +kernel' % (tag, B + 1), '', 'end FAR', '']
    open(os.path.join(folder, t['file']), 'w').write('\n'.join(out))


def write_root():
    """proofs/FarCerts.lean imports every module in proofs/FarCerts, so far_lean.py and cycle_lean.py share it."""
    for t in (BB3, BB23):
        if os.path.exists(os.path.join(HERE, t['certs'])):
            write_tree(t)
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
    far.SYMBOLS = 2
    names = []
    # far-certificates-3.json covers the 92 three-state machines busy.py settles by its tape deciders
    for path, states, stem in (('far-certificates.json', 4, 'Certs'), ('far-certificates-3.json', 3, 'Small')):
        rows = json.load(open(os.path.join(HERE, path)))
        for row in rows:
            machine, dfa = oriented(row), far.DFA(row['delta'], row['acc'])
            assert far.holds(machine, states, dfa) == local_check(machine, states, dfa) == True, row['index']
            broken = far.DFA(row['delta'], [not a for a in row['acc']])  # a wrong certificate must fail both ways
            assert far.holds(machine, states, broken) == local_check(machine, states, broken) == False, row['index']
        for k in range(0, len(rows), 8):  # ponytail: 8 per file keeps each under the repo's 5000-token file limit
            names.append('%s%d' % (stem, k // 8 + 1))
            out = ['import FarCerts.Basic', '', 'set_option maxRecDepth 100000', '', 'namespace FAR', '']
            out += [lean_cert(row, states) for row in rows[k:k + 8]] + ['end FAR', '']
            open(os.path.join(HERE, 'proofs', 'FarCerts', names[-1] + '.lean'), 'w').write('\n'.join(out))
        print('%d %d-state certificates agree with far.holds' % (len(rows), states))
    write_root()
    print('wrote %d files' % len(names))
