"""Word-level checker for FAR certificates. Independent of the automaton construction in far.py: it rewrites words
directly and runs the certificate DFA on each word. Exhaustive over all words up to max_len."""
import itertools
from far import DFA, state_letter


def run(dfa, word):
    s = 0
    for x in word:
        s = dfa.delta[s][x]
    return dfa.acc[s]


def fwd(machine, word):
    """One step of the configuration word, or None when the word is not a single-head configuration with the
    neighbours the rule needs. Cells are letters 0/1; the head cell is state_letter(q, a)."""
    heads = [i for i, x in enumerate(word) if x >= 2]
    if len(heads) != 1:
        return None
    i = heads[0]
    q, a = (word[i] - 2) // 2, (word[i] - 2) % 2
    rule = machine.get((q, a))
    if rule is None:
        return None
    write, move, nxt = rule
    w = list(word)
    j = i + move
    if j < 0 or j >= len(w):
        return None
    w[i] = write
    w[j] = state_letter(nxt, word[j])
    return tuple(w)


def in_closure(dfa, word):
    """Membership in the padding closure: some 0^a word 0^b is accepted (checked up to padding 3 each side)."""
    for a in range(4):
        for b in range(4):
            if run(dfa, (0,) * a + tuple(word) + (0,) * b):
                return True
    return False


def verify(machine, states, dfa, max_len=5):
    nl = 2 + 2 * states
    # I2: every word with an undefined letter is accepted (single head and any others), checked on the padded form.
    undef = {state_letter(q, a) for q in range(states) for a in (0, 1) if (q, a) not in machine}
    for n in range(1, max_len + 1):
        for word in itertools.product(range(nl), repeat=n):
            if any(x in undef for x in word) and not in_closure(dfa, word):
                return 'E not contained: %r' % (word,)
    # I1: blank representatives 0^i (A,0) 0^j are rejected.
    blank = state_letter(0, 0)
    for i in range(max_len):
        for j in range(max_len):
            if in_closure(dfa, (0,) * i + (blank,) + (0,) * j):
                return 'blank accepted'
    # I3: fwd(u) in L implies u in L, for every single-head word up to max_len.
    for n in range(1, max_len + 1):
        for word in itertools.product(range(nl), repeat=n):
            f = fwd(machine, word)
            if f is not None and in_closure(dfa, f) and not in_closure(dfa, word):
                return 'pre not contained at %r -> %r' % (word, f)
    return 'ok'
