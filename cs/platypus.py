"""Placid Platypus: PP(n), the fewest states a 2-symbol Turing machine needs to halt with exactly n ones (A399346).

    python3 platypus.py [OUT]     # about 25 minutes; OUT holds the slow intermediate files

The 1- to 4-state spectra come from plainwalk.c with its ones count. The 5-state spectrum joins the cap-2000 walk
(every halter up to step 2000, no deciders) with the 333 halters past 2000 in halters-5.json; A004147(5) minus the
first count equals the second's weight, so no halter is missing. A 6-state witness for a missing n is a 5-state
machine whose halting row is sent to a new state F, with every choice of F's two rows. Every witness is rerun
from blank by sim() before it counts. Writes platypus-5.json.
"""
import ast, json, os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
BB = {1: 1, 2: 6, 3: 21, 4: 107}


def sim(m, cap=10 ** 8):
    """Run a machine in bbchallenge notation from blank: Z halts after its write, --- halts without one.
    Returns (states, steps, ones)."""
    rows = m.split('_'); tape = bytearray(1 << 20); p = 1 << 19; q = 0
    for t in range(cap):
        r = rows[q][3 * tape[p]:3 * tape[p] + 3]
        if r == '---': return len(rows), t + 1, sum(tape)
        tape[p] = int(r[0]); p += 1 if r[1] == 'R' else -1
        if r[2] == 'Z': return len(rows), t + 1, sum(tape)
        q = ord(r[2]) - 65
    raise RuntimeError('no halt within cap')


def spectrum(exe, n, cap):
    """{ones: witness} for every n-state machine that halts within cap steps."""
    out = subprocess.run([exe, str(n), str(cap), 's'], capture_output=True, text=True, check=True).stdout
    return {int(l.split()[1]): l.split()[2] for l in out.splitlines() if l.startswith('s ')}


def six(base, S5):
    """Ones counts outside S5 reached by sending a 5-state halting row to a sixth state F."""
    opts = [(w, 'R', 'Z') for w in '01'] + [(w, d, c) for w in '01' for d in 'LR' for c in 'ABCDEF']
    found = {}
    for v, m in sorted(base.items()):
        rows = m.split('_')
        h = [(q, s) for q in range(5) for s in range(2) if rows[q][3 * s + 2] == 'Z']
        if not h: continue
        q, s = h[0]
        for w in '01':
            for d in 'LR':
                r = list(rows); r[q] = r[q][:3 * s] + w + d + 'F' + r[q][3 * s + 3:]
                for f0 in opts:
                    for f1 in opts:
                        cand = '_'.join(r + [''.join(f0) + ''.join(f1)])
                        try: k, t, o = sim(cand, 20000)
                        except RuntimeError: continue
                        if o not in S5 and o not in found: found[o] = cand
    return found


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, 'build')
    os.makedirs(out, exist_ok=True)
    pw, lo = os.path.join(out, 'plainwalk'), os.path.join(out, 'longones')
    subprocess.run(['cc', '-O2', '-o', pw, os.path.join(HERE, 'plainwalk.c')], check=True)
    subprocess.run(['cc', '-O2', '-o', lo, os.path.join(HERE, 'longones.c')], check=True)
    spec = {n: spectrum(pw, n, BB[n]) for n in (1, 2, 3, 4)}
    f5 = os.path.join(out, 'sig5_2000.txt')
    if not os.path.exists(f5):
        open(f5, 'w').write(subprocess.run([pw, '5', '2000', 's'], capture_output=True, text=True, check=True).stdout)
    base = {int(l.split()[1]): l.split()[2] for l in open(f5) if l.startswith('s ')}
    h5 = json.load(open(os.path.join(HERE, 'halters-5.json')))
    longs = h5['long_halters']
    longs = ast.literal_eval(longs) if isinstance(longs, str) else longs
    rep = subprocess.run([lo], input=''.join('%d %s\n' % (s, m) for s, m, _ in longs), capture_output=True, text=True, check=True).stdout
    for line in rep.splitlines():
        step, t, b, m = line.split()
        assert step == t, line
        for w in '01':
            base.setdefault(int(b) + int(w), m.replace('---', w + 'RZ', 1))
    S5 = set(base)
    sixes = six({v: m for v, m in base.items() if sim(m)[1] < 100000}, S5)
    pp, wit, n = [], {}, 1
    while True:
        k = next((k for k in (1, 2, 3, 4) if n in spec[k]), None)
        if k is None: k = 5 if n in S5 else 6 if n in sixes else None
        if k is None: break
        m = spec[k][n] if k < 5 else base[n] if k == 5 else sixes[n]
        st, _, o = sim(m)
        assert o == n and st == k, (n, m)
        pp.append(k); wit[n] = m; n += 1
    res = {
        'what': 'PP(n), the fewest states of a 2-symbol Turing machine that halts from blank with exactly n ones (OEIS A399346), and the full 5-state ones spectrum',
        'command': 'python3 platypus.py',
        'sigma_1_to_4': [max(spec[k]) for k in (1, 2, 3, 4)],
        'spectrum_5': sorted(S5),
        'first_not_printable_by_5_states': min(set(range(max(S5))) - S5),
        'pp': pp, 'pp_known_through': len(pp), 'first_open': len(pp) + 1,
        'witness': wit,
    }
    json.dump(res, open(os.path.join(HERE, 'platypus-5.json'), 'w'), indent=1)
    print('PP known for n = 1 ..', len(pp), '; first n no 5-state machine prints:', res['first_not_printable_by_5_states'])
    print(','.join(map(str, pp)))


if __name__ == '__main__':
    main()
