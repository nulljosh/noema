"""Backward finite automata reduction (FAR) for 2-symbol Turing machines, run from a blank tape.

A configuration is written as a word over the letters 0, 1 (tape cells) and (q, a) (the head: state q over
symbol a). A word denotes the infinite configuration with zeros outside it. A single-head word u has a one-step
successor fwd(u), which rewrites the window at the head. A certificate is a regular language L of words such that

  E   every word containing an undefined letter (q, a) is in L,
  I1  no word of the form 0^i (A, 0) 0^j is in L (every representative of the blank configuration is outside L),
  I3  pre(L) is contained in L, where pre(L) = {u : fwd(u) is defined and in L}.

Soundness, by induction on the number of steps k needed to reach an undefined letter. Claim: if a configuration C
reaches an undefined letter within k steps, then every representative u of C whose head is at least k cells from
both ends is in L. For k = 0, u contains the undefined letter, so u is in E, which is in L. For k > 0, the head of u
has room for the window, so fwd(u) is defined and represents the successor of C, with its head at least k-1 cells
from both ends. By induction fwd(u) is in L, so u is in pre(L), so u is in L by I3. If blank reached an undefined
letter within k steps, then 0^k (A, 0) 0^k would be in L, which I1 forbids. So blank never reads an undefined letter.
The check is by automaton construction (holds). far_verify.py cross-checks it by rewriting words directly.
"""
import time
from collections import deque

DEAD = 'dead'


class DFA:
    """A complete DFA over letters 0..nl-1 with start state 0."""

    def __init__(self, delta, acc):
        self.delta = delta
        self.acc = acc
        self.nl = len(delta[0])

    def __len__(self):
        return len(self.delta)


def letter_count(states):
    return 2 + 2 * states


def state_letter(q, a):
    return 2 + 2 * q + a


def undefined_letters(machine, states):
    return {state_letter(q, a) for q in range(states) for a in (0, 1) if (q, a) not in machine}


def empty_word_dfa(machine, states):
    """Accepts every word containing an undefined letter (E)."""
    undef = undefined_letters(machine, states)
    nl = letter_count(states)
    delta = [[1 if x in undef else 0 for x in range(nl)], [1] * nl]
    return DFA(delta, [False, True])


def reachable(dfa):
    seen, order, queue = {0}, [0], deque([0])
    while queue:
        s = queue.popleft()
        for t in dfa.delta[s]:
            if t not in seen:
                seen.add(t)
                order.append(t)
                queue.append(t)
    return order


def minimize(dfa):
    """Reachable part, then Moore partition refinement, renumbered from 0."""
    order = reachable(dfa)
    index = {s: i for i, s in enumerate(order)}
    delta = [[index[t] for t in dfa.delta[s]] for s in order]
    acc = [dfa.acc[s] for s in order]
    block = [int(a) for a in acc]
    while True:
        sig = {}
        new = []
        for i in range(len(delta)):
            key = (block[i], tuple(block[t] for t in delta[i]))
            new.append(sig.setdefault(key, len(sig)))
        if len(sig) == len(set(block)):
            block = new
            break
        block = new
    # Renumber so the start block is 0.
    rep = {}
    for i in range(len(delta)):
        rep.setdefault(block[i], i)
    blocks = sorted(rep, key=lambda b: rep[b])
    num = {b: k for k, b in enumerate(blocks)}
    new_delta = [None] * len(blocks)
    new_acc = [False] * len(blocks)
    for i in range(len(delta)):
        b = num[block[i]]
        new_delta[b] = [num[block[t]] for t in delta[i]]
        new_acc[b] = acc[i]
    return DFA(new_delta, new_acc)


def product(a, b, op):
    start = (0, 0)
    index = {start: 0}
    delta, acc = [], []
    queue = deque([start])
    pairs = [start]
    while queue:
        p, q = queue.popleft()
        row = []
        for x in range(a.nl):
            t = (a.delta[p][x], b.delta[q][x])
            if t not in index:
                index[t] = len(pairs)
                pairs.append(t)
                queue.append(t)
            row.append(index[t])
        delta.append(row)
        acc.append(op(a.acc[p], b.acc[q]))
    # delta rows were appended in BFS order, which matches the index numbering.
    return DFA(delta, acc)


def subset_of(small, big):
    """True when L(small) is contained in L(big)."""
    start = (0, 0)
    seen = {start}
    queue = deque([start])
    while queue:
        p, q = queue.popleft()
        if small.acc[p] and not big.acc[q]:
            return False
        for x in range(small.nl):
            t = (small.delta[p][x], big.delta[q][x])
            if t not in seen:
                seen.add(t)
                queue.append(t)
    return True


def _step(machine, ts, x):
    """One letter of the sequential transducer that rewrites u into fwd(u) with a lag of at most one letter.
    Returns the new transducer state and the output letters."""
    if ts == DEAD:
        return DEAD, ()
    if ts[0] == 'pre':
        buf = ts[1]
        if x < 2:
            return ('pre', x), ((buf,) if buf is not None else ())
        q, a = (x - 2) // 2, (x - 2) % 2
        rule = machine.get((q, a))
        if rule is None:
            return DEAD, ()
        write, move, nxt = rule
        if move == 1:
            return ('post', write, nxt), ((buf,) if buf is not None else ())
        if buf is None:
            return DEAD, ()
        return ('post', write, None), (state_letter(nxt, buf),)
    buf, need = ts[1], ts[2]
    if x >= 2:
        return DEAD, ()
    if need is not None:
        return ('post', None, None), (buf, state_letter(need, x))
    return ('post', x, None), ((buf,) if buf is not None else ())


def _finish(ts):
    """Output letters still owed at the end of the word, or None if the word is not a configuration."""
    if ts == DEAD or ts[0] == 'pre' or ts[2] is not None:
        return None
    return (ts[1],) if ts[1] is not None else ()


def pre_dfa(machine, dfa, states):
    """DFA for pre(L) = {u : fwd(u) is defined and in L}, built from the transducer and L together."""
    nl = letter_count(states)
    start = (('pre', None), 0)
    index = {start: 0}
    pairs = [start]
    delta, acc = [], []
    queue = deque([start])
    while queue:
        ts, d = queue.popleft()
        row = []
        for x in range(nl):
            ts2, outs = _step(machine, ts, x)
            if ts2 == DEAD:
                d2 = 0
            else:
                d2 = d
                for o in outs:
                    d2 = dfa.delta[d2][o]
            key = (ts2, d2)
            if key not in index:
                index[key] = len(pairs)
                pairs.append(key)
                queue.append(key)
            row.append(index[key])
        delta.append(row)
        fin = _finish(ts)
        if fin is None:
            acc.append(False)
        else:
            e = d
            for o in fin:
                e = dfa.delta[e][o]
            acc.append(dfa.acc[e])
    return DFA(delta, acc)


def _zero_closure(dfa, states, zero=0):
    """States reachable from start by reading zeros only."""
    seen = {states}
    queue = deque([states])
    while queue:
        s = queue.popleft()
        t = dfa.delta[s][zero]
        if t not in seen:
            seen.add(t)
            queue.append(t)
    return seen


def blank_rejected(dfa, states):
    """True when no word 0^i (A, 0) 0^j is accepted, that is every representative of the blank configuration."""
    head = {dfa.delta[s][state_letter(0, 0)] for s in _zero_closure(dfa, 0)}
    for s in set().union(*[_zero_closure(dfa, t) for t in head]) if head else ():
        if dfa.acc[s]:
            return False
    return True


def pad_closure(dfa):
    """Smallest padding-closed language containing L: {w : 0^i w 0^j is in L for some i, j}."""
    good = {s for s in range(len(dfa)) if dfa.acc[s]}
    changed = True
    while changed:  # states from which zeros lead to acceptance
        changed = False
        for s in range(len(dfa)):
            if s not in good and dfa.delta[s][0] in good:
                good.add(s)
                changed = True
    nl = dfa.nl
    start = frozenset(_zero_closure(dfa, 0))
    index = {start: 0}
    sets = [start]
    delta, acc = [], []
    queue = deque([start])
    while queue:
        cur = queue.popleft()
        row = []
        for x in range(nl):
            nxt = frozenset(dfa.delta[s][x] for s in cur)
            if nxt not in index:
                index[nxt] = len(sets)
                sets.append(nxt)
                queue.append(nxt)
            row.append(index[nxt])
        delta.append(row)
        acc.append(any(s in good for s in cur))
    return minimize(DFA(delta, acc))


def union(a, b):
    return product(a, b, lambda x, y: x or y)


def determinize_quotient(dfa, classes):
    """Over-approximating quotient: merge states by a class map, read the quotient as an NFA, determinize."""
    nclass = max(classes) + 1
    trans = [[set() for _ in range(dfa.nl)] for _ in range(nclass)]
    accepting = [False] * nclass
    for s in range(len(dfa)):
        c = classes[s]
        accepting[c] = accepting[c] or dfa.acc[s]
        for x in range(dfa.nl):
            trans[c][x].add(classes[dfa.delta[s][x]])
    start = frozenset([classes[0]])
    index = {start: 0}
    sets = [start]
    delta, acc = [], []
    queue = deque([start])
    while queue:
        cur = queue.popleft()
        row = []
        for x in range(dfa.nl):
            nxt = frozenset(t for c in cur for t in trans[c][x])
            if nxt not in index:
                index[nxt] = len(sets)
                sets.append(nxt)
                queue.append(nxt)
            row.append(index[nxt])
        delta.append(row)
        acc.append(any(accepting[c] for c in cur))
    return minimize(DFA(delta, acc))


def _merge(dfa, a, b):
    classes = [a if c == b else c for c in range(len(dfa))]
    ids = {c: i for i, c in enumerate(sorted(set(classes)))}
    classes = [ids[c] for c in classes]
    return minimize(pad_closure(determinize_quotient(dfa, classes)))


def _closes(machine, states, dfa, depth, cap, deadline):
    """Saturate dfa (pre-closure plus padding) and widen by merging states when it grows past cap. True when a
    pre-closed language with a blank-rejecting padding closure is reached within depth rounds."""
    if time.monotonic() > deadline:
        return None
    pre = pre_dfa(machine, dfa, states)
    if subset_of(pre, dfa):
        return dfa if blank_rejected(dfa, states) else None
    if depth == 0:
        return None
    grown = minimize(pad_closure(union(dfa, pre)))
    if not blank_rejected(grown, states):
        return None
    if len(grown) <= cap:
        return _closes(machine, states, grown, depth - 1, cap, deadline)
    for a in range(len(grown)):
        for b in range(a + 1, len(grown)):
            q = _merge(grown, a, b)
            if len(q) <= cap and blank_rejected(q, states):
                found = _closes(machine, states, q, depth - 1, cap, deadline)
                if found is not None:
                    return found
            if time.monotonic() > deadline:
                return None
    return None


def find_certificate(machine, states, cap=10, depth=8, budget=20.0):
    """Search for a certificate L: E in L, blank rejected, pre(L) in L. Returns the DFA or None.
    Saturation is exact backward reachability. When it grows past cap, a merge of two states is kept only if the
    search can close from the merged language within the remaining depth."""
    base = minimize(empty_word_dfa(machine, states))
    return _closes(machine, states, base, depth, cap, time.monotonic() + budget)


def holds(machine, states, dfa):
    """Exact automaton check of a certificate: E is in L, blank is rejected, and pre(L) is in L."""
    return (subset_of(empty_word_dfa(machine, states), dfa)
            and blank_rejected(dfa, states)
            and subset_of(pre_dfa(machine, dfa, states), dfa))


def certify(machine, states, budget=20.0):
    """Return (orientation, certificate DFA) when a certificate is found for the machine or its mirror, else None.
    The mirror image (every move flipped) runs the same from blank, so either orientation proves the machine."""
    found = find_certificate(machine, states, budget=budget)
    if found is not None:
        return 'direct', found
    mirror = {k: (w, -m, n) for k, (w, m, n) in machine.items()}
    found = find_certificate(mirror, states, budget=budget)
    if found is not None:
        return 'mirror', found
    return None


def far_proves(machine, states, budget=20.0):
    return certify(machine, states, budget) is not None
