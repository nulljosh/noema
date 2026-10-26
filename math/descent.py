"""Bounded Collatz first descent, counted in ordinary (uncombined) steps."""
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import time

from mathlab import ROOT, atomic_write


def first_descent(start, cap=1000):
    if type(start) is not int or not 2 <= start <= 1000000:
        raise ValueError('Use an integer start from two through one million.')
    if type(cap) is not int or not 1 <= cap <= 1000:
        raise ValueError('Use an integer step cap from one through 1000.')
    n = start
    for steps in range(1, cap + 1):
        n = 3 * n + 1 if n % 2 else n // 2
        if n < start:
            return {'start': start, 'steps': steps, 'first_below': n, 'status': 'descended'}
    return {'start': start, 'steps': cap, 'first_below': None, 'status': 'unresolved_at_cap'}


def accelerated_check(start, cap):
    """Separate implementation combines odd steps with the following halving."""
    value, elapsed = start, 0
    while value >= start and elapsed < cap:
        if value & 1 and elapsed + 2 <= cap:
            # While value >= start, 3*value+1 cannot be the first lower term.
            value = (3 * value + 1) >> 1
            elapsed += 2
        elif value & 1:
            value = 3 * value + 1
            elapsed += 1
        else:
            value >>= 1
            elapsed += 1
    return elapsed, value if value < start else None


def study(limit):
    if type(limit) is not int or not 2 <= limit <= 1000000:
        raise ValueError('Use an integer study bound from two through one million.')
    digest, histogram, records, unresolved = hashlib.sha256(), Counter(), [], []
    groups = {str(modulus): [dict(remainder=r, checked=0, unresolved=0,
                                minimum_steps=None, maximum=None)
                            for r in range(modulus)] for modulus in (8, 16, 32)}
    for start in range(2, limit + 1):
        result = first_descent(start)
        expected = accelerated_check(start, 1000)
        if (result['steps'], result['first_below']) != expected:
            raise RuntimeError(f'Independent descent calculation disagrees at start {start}.')
        digest.update((json.dumps(result, sort_keys=True, separators=(',', ':')) + '\n').encode())
        for modulus in (8, 16, 32):
            if modulus == 32 and start % 16 not in (7, 11, 15):
                continue
            group = groups[str(modulus)][start % modulus]
            group['checked'] += 1
            if result['status'] != 'descended':
                group['unresolved'] += 1
            else:
                if group['minimum_steps'] is None or result['steps'] < group['minimum_steps']:
                    group['minimum_steps'] = result['steps']
                if group['maximum'] is None or result['steps'] > group['maximum']['steps']:
                    group['maximum'] = result
        if result['status'] == 'descended':
            if start % 2 == 0 and result['steps'] != 1:
                raise RuntimeError(f'Even-start control failed at {start}.')
            if start % 4 == 1 and result['steps'] != 3:
                raise RuntimeError(f'4k+1 control failed at {start}.')
            if start % 32 in (11, 23) and result['steps'] != 8:
                raise RuntimeError(f'Modulo-32 eight-step control failed at {start}.')
        if result['status'] == 'descended':
            histogram[result['steps']] += 1
            if not records or result['steps'] > records[-1]['steps']:
                records.append(result)
        else:
            unresolved.append(start)
    return {'limit': limit, 'starts_checked': limit - 1, 'cap': 1000,
            'unresolved': unresolved, 'record_highs': records,
            'step_histogram': {str(k): v for k, v in sorted(histogram.items())},
            'independent_disagreements': 0, 'evidence_sha256': digest.hexdigest(),
            'residue_groups': {m: [g for g in rows if m != '32' or g['remainder'] % 16 in (7, 11, 15)]
                               for m, rows in groups.items()}}


def residue_tree(max_level=20):
    """Split starts by remainder mod 2^m. A class closes when its forced affine prefix
    first falls below the start for every member (start 1 and 0 excluded)."""
    if type(max_level) is not int or not 1 <= max_level <= 24:
        raise ValueError('Use an integer level from one through 24.')
    levels, open_classes = [], [0, 1]
    for level in range(1, max_level + 1):
        modulus, still_open, closed = 2 ** level, [], {}
        for r in open_classes:
            a, b, k0, steps = modulus, r, 1 if r < 2 else 0, 0
            start = modulus * k0 + r
            while a % 2 == 0:
                a, b = (a // 2, b // 2) if b % 2 == 0 else (3 * a, 3 * b + 1)
                steps += 1
                if a <= modulus and a * k0 + b < start:
                    closed[r] = steps
                    break
            else:
                still_open.append(r)
        levels.append({'level': level, 'modulus': modulus, 'open': len(still_open),
                       'closed': len(closed), 'open_fraction': len(still_open) / modulus,
                       'closed_steps': dict(sorted({str(v): list(closed.values()).count(v)
                                                    for v in set(closed.values())}.items(),
                                                   key=lambda kv: int(kv[0])))})
        if level < max_level:
            open_classes = still_open + [r + modulus for r in still_open]
            open_classes.sort()
        levels[-1]['_open'], levels[-1]['_closed'] = still_open, closed
    return levels


def run():
    started = time.monotonic()
    report = {'suite': 'first-descent-v3', 'status': 'complete',
              'updated_at': datetime.now(timezone.utc).isoformat(),
              'engine_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'stages': [study(n) for n in (10000, 100000, 1000000)],
              'limits': 'Finite ordinary-step first descent. Start 1 is excluded. '
                        'Stages overlap. No universal termination claim.'}
    report['seconds'] = time.monotonic() - started
    baseline = json.loads((ROOT / 'benchmarks/first-descent-baseline.json').read_text())
    unchanged = [{key: value for key, value in stage.items() if key != 'residue_groups'}
                 for stage in report['stages']]
    for stage in report['stages']:
        parents = stage['residue_groups']['16']
        children = stage['residue_groups']['32']
        for r in (7, 11, 15):
            if sum(g['checked'] for g in children if g['remainder'] % 16 == r) != parents[r]['checked']:
                raise RuntimeError('Modulo-32 groups do not partition their parent.')
    if unchanged != baseline['stages']:
        raise RuntimeError('First-descent regression: accepted findings were not replaced.')
    encoded = json.dumps(report, indent=2) + '\n'
    atomic_write(ROOT / 'benchmarks/first-descent-latest.json', encoded)
    atomic_write(ROOT / 'landing/descent.json', encoded)
    return report


def tree_report(max_level=20):
    levels = [{k: v for k, v in level.items() if not k.startswith('_')}
              for level in residue_tree(max_level)]
    report = {'suite': 'residue-tree-v1', 'updated_at': datetime.now(timezone.utc).isoformat(),
              'levels': levels, 'reference': 'OEIS A076227, surviving Collatz residues mod 2^n',
              'limits': 'Counts residue classes whose forced prefix has not yet descended. '
                        'Open classes are not counterexamples. Known sequence, reproduced.'}
    atomic_write(ROOT / 'benchmarks/residue-tree-latest.json', json.dumps(report, indent=2) + '\n')
    return report


if __name__ == '__main__':
    import sys
    if sys.argv[1:] == ['tree']:
        print(json.dumps([(l['modulus'], l['open']) for l in tree_report()['levels']]))
        raise SystemExit
    report = run()
    print(json.dumps({'suite': report['suite'], 'seconds': report['seconds'],
                      'stages': [{'limit': s['limit'], 'checked': s['starts_checked'],
                                  'unresolved': len(s['unresolved']),
                                  'longest': s['record_highs'][-1]}
                                 for s in report['stages']]}, indent=2))
