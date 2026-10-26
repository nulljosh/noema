"""Busy Beaver by tree enumeration: grow 2-symbol Turing machines only along transitions they actually use."""
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


def enumerate_machines(states, cap):
    """Every machine reachable this way is distinct in behaviour from a blank tape.
    The first move is fixed to the right; the mirror image behaves the same."""
    best_steps, best_ones, halters, holdouts, cycles, translated = 0, 0, 0, 0, 0, 0
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
            holdouts += 1
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
            'holdouts_at_cap': holdouts}


if __name__ == '__main__':
    top = int(sys.argv[1]) if sys.argv[1:] else 3
    for n in range(1, top + 1):
        started = time.monotonic()
        result = enumerate_machines(n, {1: 10, 2: 50, 3: 200, 4: 2000}[n])
        result['seconds'] = round(time.monotonic() - started, 2)
        print(json.dumps(result))
