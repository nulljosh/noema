"""Run every sound decider here over a published holdout list, with raised limits.

    python3 holdouts.py LIST STATES SYMBOLS [SECONDS]    # one machine per line, standard notation; SECONDS per decider
"""
import json, signal, sys, time
sys.path.insert(0, __import__('os').path.dirname(__import__('os').path.abspath(__file__)))
import busy, far

path, states, symbols = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
far.SYMBOLS = symbols


def parse(text):
    m = {}
    for q, row in enumerate(text.strip().split('_')):
        for a in range(symbols):
            t = row[3 * a:3 * a + 3]
            if t[2] in '-Z' or t == '---':
                continue
            m[(q, a)] = (int(t[0]), 1 if t[1] == 'R' else -1, ord(t[2]) - 65)
    return m


class Out(Exception):
    pass


def alarm(*_):
    raise Out


signal.signal(signal.SIGALRM, alarm)
tests = [('sim', lambda m: busy.simulate(m, 200000)[0] in ('cycle', 'translated') or None),
         ('backward', lambda m: busy.backward(m, states, width=12, limit=500000))]
if symbols == 2:
    tests += [('tape', lambda m: busy.closed_tape(m, 8, 200000)),
              ('block', lambda m: any(busy.closed_block(m, k, 8, 200000) for k in (2, 3, 4, 5, 6))),
              ('ngram', lambda m: any(busy.ngram_cps(m, n, k, 2000000) for n, k in ((2, 2), (3, 3), (4, 4), (5, 5))))]
tests += [('far', lambda m: far.direct_certificate(m, states, sizes=(1, 2, 3, 4, 5))
                            or far.direct_certificate({k: (w, -d, n) for k, (w, d, n) in m.items()}, states,
                                                      sizes=(1, 2, 3, 4, 5)))]
rows = []
for line in open(path):
    text = line.split()[0] if line.strip() else ''
    if not text:
        continue
    m, hit = parse(text), None
    for name, f in tests:
        signal.alarm(int(sys.argv[4]) if len(sys.argv) > 4 else 20)
        try:
            ok = f(m)
            signal.alarm(0)
            hit = name if ok else None
        except Out:
            signal.alarm(0)
        if hit:
            break
    rows.append({'machine': text, 'decided': hit})
    print(text, hit, flush=True)
print(json.dumps({'list': path, 'n': len(rows), 'decided': [r for r in rows if r['decided']]}))
