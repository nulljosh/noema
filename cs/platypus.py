"""Placid Platypus: PP(n), the fewest states a 2-symbol Turing machine needs to halt with exactly n ones (A399346).

    python3 platypus.py [OUT]     # about 25 minutes; OUT holds the slow intermediate files

The 1- to 4-state spectra come from plainwalk.c with its ones count. The 5-state spectrum joins the cap-2000 walk
(every halter up to step 2000, no deciders) with the 333 halters past 2000 in halters-5.json; A004147(5) minus the
first count equals the second's weight, so no halter is missing. A 6-state witness for a missing n is a 5-state
machine whose halting row is sent to a new state F, with every choice of F's two rows (sixstate.c), tried on up
to 200 machines per 5-state count. Every witness is rerun from blank by sim() before it counts. Writes
platypus-5.json.
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
    res = {}
    for l in out.splitlines():
        if l.startswith('s '): res.setdefault(int(l.split()[1]), l.split()[2])
    return res


def six(exe, bases, S5, cap=150000, jobs=8):
    """Ones counts outside S5 that a sixth state reaches, from sixstate.c run on the bases in parallel."""
    chunks = [bases[i::jobs] for i in range(jobs)]
    procs = [subprocess.Popen([exe, str(cap)], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True) for _ in chunks]
    outs = [p.communicate(''.join('%d %s\n' % b for b in c))[0] for p, c in zip(procs, chunks)]
    found = {}
    for line in sorted((l for o in outs for l in o.splitlines()), key=lambda l: int(l.split()[0])):
        o, m = line.split()
        if int(o) not in S5: found.setdefault(int(o), m)
    return found


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, 'build')
    os.makedirs(out, exist_ok=True)
    pw, lo, sx = (os.path.join(out, x) for x in ('plainwalk', 'longones', 'sixstate'))
    for exe in (pw, lo, sx):
        subprocess.run(['cc', '-O2', '-o', exe, os.path.join(HERE, os.path.basename(exe) + '.c')], check=True)
    spec = {n: spectrum(pw, n, BB[n]) for n in (1, 2, 3, 4)}
    f5 = os.path.join(out, 'sig5_2000_k200.txt')
    if not os.path.exists(f5):
        open(f5, 'w').write(subprocess.run([pw, '5', '2000', '200'], capture_output=True, text=True, check=True).stdout)
    base, bases = {}, []
    for l in open(f5):
        if l.startswith('s '):
            v, m = int(l.split()[1]), l.split()[2]
            base.setdefault(v, m)
            if v >= 40: bases.append((v, m))
    h5 = json.load(open(os.path.join(HERE, 'halters-5.json')))
    longs = h5['long_halters']
    longs = ast.literal_eval(longs) if isinstance(longs, str) else longs
    rep = subprocess.run([lo], input=''.join('%d %s\n' % (s, m) for s, m, _ in longs), capture_output=True, text=True, check=True).stdout
    for line in rep.splitlines():
        step, t, b, m = line.split()
        assert step == t, line
        for w in '01':
            base.setdefault(int(b) + int(w), m.replace('---', w + 'RZ', 1))
            if int(step) < 100000: bases.append((int(b) + int(w), m.replace('---', w + 'RZ', 1)))
    S5 = set(base)
    sixes = six(sx, bases, S5)
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
