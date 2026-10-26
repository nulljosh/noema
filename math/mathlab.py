"""A finite, reproducible SAT study. Python standard library only."""
import argparse
from collections import Counter
from datetime import datetime, timezone
import hashlib
from itertools import combinations, product
import json
import math
from pathlib import Path
import platform
import time
import uuid

ROOT = Path(__file__).resolve().parent
SUITE = 'unit-propagation-v1'


def validate(n, formula):
    if type(n) is not int or not 0 <= n <= 3:
        raise ValueError('This study accepts zero through three variables.')
    for clause in formula:
        if any(type(x) is not int or x == 0 or abs(x) > n for x in clause):
            raise ValueError('Literals must be nonzero integers within the variable range.')
        if len(set(clause)) != len(clause) or any(-x in clause for x in clause):
            raise ValueError('Clauses must have distinct variables and no tautologies.')


def truth_table(n, formula):
    """Independent exhaustive decision procedure; witness bits are x1, x2, ... ."""
    validate(n, formula)
    checked = 0
    for bits in product((False, True), repeat=n):
        checked += 1
        if all(any(bits[abs(x) - 1] == (x > 0) for x in clause) for clause in formula):
            return {'sat': True, 'witness': list(bits), 'assignments_checked': checked}
    return {'sat': False, 'witness': None, 'assignments_checked': checked}


def unit_propagation(n, formula):
    validate(n, formula)
    clauses = [set(c) for c in formula]
    assigned = {}
    while True:
        if any(not c for c in clauses):
            return 'unsat', assigned
        if not clauses:
            return 'sat', assigned
        unit = next((next(iter(c)) for c in clauses if len(c) == 1), None)
        if unit is None:
            return 'stalled', assigned
        assigned[abs(unit)] = unit > 0
        clauses = [c - {-unit} for c in clauses if unit not in c]


def corpus():
    # Canonical clauses: variable order first, then False/True polarity order.
    for n in range(1, 4):
        clauses = [tuple(v if sign else -v for v, sign in zip(variables, signs))
                   for size in range(1, n + 1)
                   for variables in combinations(range(1, n + 1), size)
                   for signs in product((False, True), repeat=size)]
        for size in range(min(4, len(clauses)) + 1):
            for formula in combinations(clauses, size):
                yield n, formula


def study(minutes=15):
    if not math.isfinite(minutes) or not 0 < minutes <= 60:
        raise ValueError('Minutes must be finite, greater than zero, and at most 60.')
    started = time.monotonic()
    counts = Counter()
    examples = {}
    digest = hashlib.sha256()
    status = 'complete'
    try:
        for n, formula in corpus():
            if time.monotonic() - started >= minutes * 60:
                status = 'timed_out'
                break
            truth = truth_table(n, formula)
            result, assignment = unit_propagation(n, formula)
            category = f"{result}_{'sat' if truth['sat'] else 'unsat'}"
            counts['formulas'] += 1
            counts[f'variables_{n}'] += 1
            counts[category] += 1
            if result != 'stalled' and ((result == 'sat') != truth['sat']):
                counts['soundness_errors'] += 1
            # A partial SAT assignment must also extend to a valid full witness.
            if result == 'sat':
                bits = [assignment.get(v, False) for v in range(1, n + 1)]
                if not all(any(bits[abs(x)-1] == (x > 0) for x in c) for c in formula):
                    counts['witness_errors'] += 1
            digest.update((json.dumps([n, formula], separators=(',', ':')) + '\n').encode())
            if result == 'stalled' and category not in examples:
                examples[category] = {'variables': n, 'clauses': formula, **truth}
    except KeyboardInterrupt:
        status = 'interrupted'
    for key in ('soundness_errors', 'witness_errors'):
        counts.setdefault(key, 0)
    return {'suite': SUITE, 'status': status,
            'updated_at': datetime.now(timezone.utc).isoformat(),
            'python': platform.python_version(),
            'engine_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            'corpus_sha256': digest.hexdigest(), 'metrics': dict(sorted(counts.items())),
            'examples': examples, 'seconds': time.monotonic() - started}


def atomic_write(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_name(path.name + '.' + uuid.uuid4().hex + '.tmp')
    try:
        temp.write_text(text)
        temp.replace(path)
    finally:
        temp.unlink(missing_ok=True)


def regression(report):
    baseline = json.loads((ROOT / 'benchmarks/baseline.json').read_text())
    return (report['status'] == 'complete' and report['suite'] == baseline['suite']
            and report['metrics'] == baseline['metrics']
            and report['corpus_sha256'] == baseline['corpus_sha256'])


def publish(report):
    encoded = json.dumps(report, indent=2) + '\n'
    atomic_write(ROOT / 'runs' / (uuid.uuid4().hex + '.json'), encoded)
    if report['status'] != 'complete':
        return
    report['regression_passed'] = regression(report)
    encoded = json.dumps(report, indent=2) + '\n'
    atomic_write(ROOT / 'benchmarks/latest.json', encoded)
    with (ROOT / 'benchmarks/history.jsonl').open('a') as history:
        history.write(json.dumps(report) + '\n')
    # Failed runs remain inspectable but never replace accepted findings.
    if not report['regression_passed']:
        return
    atomic_write(ROOT / 'landing/results.json', encoded)
    whitepaper = ROOT / 'WHITEPAPER.md'
    text = whitepaper.read_text()
    start, rest = text.split('<!-- research-loop:start -->', 1)
    _, end = rest.split('<!-- research-loop:end -->', 1)
    m = report['metrics']
    summary = (f"\n## Latest measured run\n\nUpdated {report['updated_at']}.\n"
               f"Checked {m['formulas']:,} formulas. Soundness errors: {m['soundness_errors']}.\n"
               f"Unit propagation stalled on {m.get('stalled_sat', 0):,} satisfiable and "
               f"{m.get('stalled_unsat', 0):,} unsatisfiable formulas.\n"
               "This finite result measures one restricted algorithm, not P versus NP.\n")
    atomic_write(whitepaper, start + '<!-- research-loop:start -->' + summary
                 + '<!-- research-loop:end -->' + end)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('command', choices=('research', 'benchmark'))
    parser.add_argument('--minutes', type=float, default=15)
    args = parser.parse_args()
    try:
        report = study(args.minutes)
    except ValueError as error:
        parser.error(str(error))
    if args.command == 'research':
        publish(report)
    print(json.dumps(report, indent=2))
    return 0 if regression(report) else 1


if __name__ == '__main__':
    raise SystemExit(main())
