"""Busy Beaver by tree enumeration: grow 2-symbol Turing machines only along transitions they actually use."""
import itertools
import json
import sys
import time


def simulate(machine, cap):
    """Run from a blank tape. Returns ('undefined', key, steps, ones) or ('cycle'|'translated'|'cap', None, steps, ones).
    A translated cycler: the head reaches a new edge in the same state as an earlier edge record on that side,
    and the tape from that record back to the furthest point the head went since then repeats, shifted.
    Only defined transitions are used, so no completion of the machine can halt."""
    tape, head, state, seen = {}, 0, 0, set()
    heads, edges, lo, hi = [], {}, 0, 0
    for steps in range(cap):
        symbol = tape.get(head, 0)
        rule = machine.get((state, symbol))
        if rule is None:
            return 'undefined', (state, symbol), steps, sum(tape.values())
        heads.append(head)
        if head > hi or head < lo:
            side = 1 if head > hi else -1
            lo, hi = min(lo, head), max(hi, head)
            past = edges.setdefault((side, state), [])
            low = high = head
            end = steps + 1
            for old_step, old_head, old_tape in reversed(past):
                low = min(low, min(heads[old_step:end]))
                high = max(high, max(heads[old_step:end]))
                end = old_step
                span = range(low, old_head + 1) if side > 0 else range(old_head, high + 1)
                shift = head - old_head
                if all(old_tape.get(x, 0) == tape.get(x + shift, 0) for x in span):
                    return 'translated', None, steps, sum(tape.values())
            past.append((steps, head, dict(tape)))
        config = (state, head, frozenset(k for k, v in tape.items() if v))
        if config in seen:
            return 'cycle', None, steps, sum(tape.values())
        seen.add(config)
        write, move, state = rule
        tape[head] = write
        head += move
    return 'cap', None, cap, sum(tape.values())


def backward(machine, states, width=8, limit=50000):
    """Backward reasoning over patterns. A pattern (state, cells) stands for every configuration in that state
    whose cells at the listed offsets from the head hold the listed symbols; every other cell is arbitrary.
    Start from each configuration that reads an undefined transition, then add every predecessor under the
    defined rules until nothing new appears. Truncating a pattern only widens it, so the closure contains every
    configuration that can reach an undefined transition. If the blank tape matches none of them, the run from
    blank never reaches one, so it never halts however the undefined transitions are later completed.
    Returns True when proved, False when the blank tape matches a pattern or the closure grows past limit."""
    frontier = [(state, ((0, symbol),)) for state in range(states) for symbol in (0, 1)
                if (state, symbol) not in machine]
    seen = set(frontier)
    while frontier:
        state, cells = frontier.pop()
        known = dict(cells)
        if state == 0 and not any(known.values()):
            return False
        for (prev, read), (write, move, nxt) in machine.items():
            if nxt != state:
                continue
            anchor = -move
            if known.get(anchor, write) != write:
                continue
            new = {x - anchor: s for x, s in known.items() if x != anchor and abs(x - anchor) <= width}
            new[0] = read
            pattern = (prev, tuple(sorted(new.items())))
            if pattern not in seen:
                if len(seen) >= limit:
                    return False
                seen.add(pattern)
                frontier.append(pattern)
    return True


def _canon(tokens):
    """Merge a run-length tape. Each merge only widens the tapes it covers, so the check stays sound."""
    toks = list(tokens)
    changed = True
    while changed:
        changed = False
        out = []
        for word, mode in toks:
            if out and out[-1][0] == word:
                out[-1] = (word, 'star' if (out[-1][1] == 'star' and mode == 'star') else 'plus')
                changed = True
            else:
                out.append((word, mode))
        toks = out
        for i in range(len(toks) - 1):
            (a, am), (b, bm) = toks[i], toks[i + 1]
            if am == bm == 'one' and len(a) == 1 and len(b) == 1 and a != b:
                toks[i:i + 2] = [(a + b, 'one')]
                changed = True
                break
    while toks and toks[-1] == ((0,), 'star'):
        toks.pop()
    return tuple(toks)


def _enter(tokens, blank=0):
    """Yield (symbol under the head, remaining tokens) for each way the head can step onto the first symbol."""
    if not tokens:
        yield blank, ()
        return
    (word, mode), rest = tokens[0], tokens[1:]
    head, tail = word[0], word[1:]
    if mode == 'one':
        yield head, _canon((((tail, 'one'),) if tail else ()) + rest)
        return
    yield head, _canon((((tail, 'one'),) if tail else ()) + ((word, 'star'),) + rest)
    if mode == 'star':
        yield from _enter(rest, blank)


def closed_tape(machine, max_tokens=6, limit=20000):
    """Closed tape: the run-length tapes reachable from blank. A token is one copy of a word of one or two
    symbols ('one'), one or more copies ('plus') or zero or more copies ('star'); cells past the tokens are
    zeros. Every reachable tape is covered by some reachable abstract configuration, so if none of them
    reads an undefined transition, the run from blank never halts. Returns True when proved."""
    start = (0, 0, (), ())
    seen, stack = {start}, [start]
    while stack:
        state, sym, left, right = stack.pop()
        rule = machine.get((state, sym))
        if rule is None:
            return False
        write, move, nxt = rule
        if move > 0:
            new_left = _canon((((write,), 'one'),) + left)
            options = [(ns, new_left, rem) for ns, rem in _enter(right)]
        else:
            new_right = _canon((((write,), 'one'),) + right)
            options = [(ns, rem, new_right) for ns, rem in _enter(left)]
        for ns, l2, r2 in options:
            if len(l2) > max_tokens or len(r2) > max_tokens:
                return False
            new = (nxt, ns, l2, r2)
            if new not in seen:
                if len(seen) >= limit:
                    return False
                seen.add(new)
                stack.append(new)
    return True


def closed_block(machine, k=2, max_tokens=6, limit=50000):
    """Block-aligned closed tape: the same run-length tapes, cut into absolutely aligned blocks of k cells, so a
    run of identical blocks keeps the parity of its cells. The head is one cell inside a block; a symbol is a
    block (a k-tuple). Same soundness argument as closed_tape. Returns True when proved."""
    blank = (0,) * k
    start = (0, blank, 0, (), ())  # state, current block, offset in block, left tokens, right tokens
    seen, stack = {start}, [start]
    while stack:
        state, block, off, left, right = stack.pop()
        rule = machine.get((state, block[off]))
        if rule is None:
            return False
        write, move, nxt = rule
        cells = block[:off] + (write,) + block[off + 1:]
        off2 = off + move
        if 0 <= off2 < k:
            options = [(nxt, cells, off2, left, right)]
        elif move > 0:
            new_left = _canon((((cells,), 'one'),) + left)
            options = [(nxt, b, 0, new_left, rem) for b, rem in _enter(right, blank)]
        else:
            new_right = _canon((((cells,), 'one'),) + right)
            options = [(nxt, b, k - 1, rem, new_right) for b, rem in _enter(left, blank)]
        for cand in options:
            if len(cand[3]) > max_tokens or len(cand[4]) > max_tokens:
                return False
            if cand not in seen:
                if len(seen) >= limit:
                    return False
                seen.add(cand)
                stack.append(cand)
    return True


def ngram_cps(machine, n=2, k=2, limit=200000):
    """n-gram Closed Position Set over blocks of k aligned cells (k=1 is plain cells). A configuration is
    (state, block under the head, offset in that block, left n-gram, right n-gram), each n-gram listing blocks
    nearest the head first. Sets L and R hold every n-gram seen on each side, starting from the blank pair. A move
    that leaves the head block pushes the block onto the other side's n-gram, and pops a new block from this side:
    any block b such that the old n-gram shifted and extended by b is already stored. A configuration that is blocked
    on a pop waits for that window to appear, and is rerun only then, so the loop ends once nothing is waiting or new.
    The sets are finite and only grow. Every concrete configuration matches an abstract one (its windows are in the
    sets), so the abstract closure contains every reachable configuration.
    Returns True when no abstract configuration reads an undefined transition."""
    blank = (0,) * k
    blocks_all = list(itertools.product((0, 1), repeat=k))
    zero = (blank,) * n
    left_set, right_set = {zero}, {zero}
    left_wait, right_wait = {}, {}
    start = (0, blank, 0, zero, zero)
    seen, work = {start}, [start]
    while work:
        config = work.pop()
        state, cur, off, left, right = config
        rule = machine.get((state, cur[off]))
        if rule is None:
            return False
        write, move, nxt = rule
        cells = cur[:off] + (write,) + cur[off + 1:]
        off2 = off + move
        successors = []
        if 0 <= off2 < k:
            successors.append((nxt, cells, off2, left, right))
        elif move > 0:
            window = (cells,) + left[:-1]
            if window not in left_set:
                left_set.add(window)
                work.extend(left_wait.pop(window[:-1], ()))
            prefix = right[1:]
            right_wait.setdefault(prefix, set()).add(config)
            successors.extend((nxt, right[0], 0, window, prefix + (b,))
                              for b in blocks_all if prefix + (b,) in right_set)
        else:
            window = (cells,) + right[:-1]
            if window not in right_set:
                right_set.add(window)
                work.extend(right_wait.pop(window[:-1], ()))
            prefix = left[1:]
            left_wait.setdefault(prefix, set()).add(config)
            successors.extend((nxt, left[0], k - 1, prefix + (b,), window)
                              for b in blocks_all if prefix + (b,) in left_set)
        for succ in successors:
            if succ not in seen:
                if len(seen) >= limit:
                    return False
                seen.add(succ)
                work.append(succ)
    return True


WIDE_NGRAMS = ((3, 2), (2, 3), (3, 3), (3, 4))
LATE_CAP = 2000


def decide_holdout(machine, states):
    """Name of the first sound decider that proves a holdout never halts from blank, or None.
    The 2-cell n-gram closure runs before the wider deciders, so the 3-state counts do not move."""
    if backward(machine, states):
        return 'backward'
    if closed_tape(machine):
        return 'tape'
    if closed_block(machine):
        return 'block'
    if ngram_cps(machine, 2, 2):
        return 'ngram'
    if closed_block(machine, 3) or closed_block(machine, 4):
        return 'wide'
    if any(ngram_cps(machine, n, k) for n, k in WIDE_NGRAMS):
        return 'wide'
    return None


def enumerate_machines(states, cap, flagged=None):
    """Every machine reachable this way is distinct in behaviour from a blank tape.
    The first move is fixed to the right; the mirror image behaves the same.
    A machine that reaches the cap is a holdout. decide_holdout tries the sound deciders in turn. A holdout none of
    them settles is rerun at LATE_CAP through simulate, which catches a longer translated cycle or cycle, or a
    halt, which is then counted and its maxima recorded. Machines the deciders prove non-halting are appended to
    flagged, when given."""
    best_steps, best_ones, halters, holdouts, cycles, translated = 0, 0, 0, 0, 0, 0
    proved = {'backward': 0, 'tape': 0, 'block': 0, 'ngram': 0, 'wide': 0, 'rerun': 0}
    late_halters = 0
    stack = [{}]
    while stack:
        machine = stack.pop()
        outcome, key, steps, ones = simulate(machine, cap)
        if outcome == 'cycle':
            cycles += 1
            continue
        if outcome == 'translated':
            translated += 1
            continue
        if outcome == 'cap':
            name = decide_holdout(machine, states)
            if name is None:
                outcome, key, steps, ones = simulate(machine, LATE_CAP)
                if outcome == 'undefined':
                    late_halters += 1
                    best_steps = max(best_steps, steps + 1)
                    best_ones = max(best_ones, ones + (1 - key[1]))
                    continue
                if outcome in ('cycle', 'translated'):
                    name = 'rerun'
            if name is None:
                holdouts += 1
                continue
            proved[name] += 1
            if flagged is not None:
                flagged.append(dict(machine))
            continue
        # Halt on this undefined transition (writing 1 maximises the ones count).
        halters += 1
        best_steps = max(best_steps, steps + 1)
        tape_symbol = key[1]
        best_ones = max(best_ones, ones + (1 - tape_symbol))
        # Or define it, if at least one transition would stay undefined to halt on later.
        if len(machine) + 1 >= 2 * states:
            continue
        used = max([0] + [r[2] for r in machine.values()] + [k[0] for k in machine])
        for write in (0, 1):
            for move in ((1,) if not machine else (-1, 1)):
                for nxt in range(min(used + 2, states)):
                    stack.append({**machine, key: (write, move, nxt)})
    return {'states': states, 'cap': cap, 'max_steps': best_steps, 'max_ones': best_ones,
            'halting_branches': halters, 'cycles_proved': cycles, 'translated_cyclers': translated,
            'backward_proved': proved['backward'], 'closed_tape_proved': proved['tape'],
            'block_tape_proved': proved['block'], 'ngram_proved': proved['ngram'],
            'wide_proved': proved['wide'], 'rerun_proved': proved['rerun'],
            'late_halters': late_halters, 'holdouts_at_cap': holdouts}


if __name__ == '__main__':
    top = int(sys.argv[1]) if sys.argv[1:] else 3
    for n in range(1, top + 1):
        started = time.monotonic()
        result = enumerate_machines(n, {1: 10, 2: 50, 3: 200, 4: 300}[n])
        result['seconds'] = round(time.monotonic() - started, 2)
        print(json.dumps(result))
