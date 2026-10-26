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


if __name__ == '__main__':
    report = run()
    print(json.dumps({'suite': report['suite'], 'seconds': report['seconds'],
                      'stages': [{'limit': s['limit'], 'checked': s['starts_checked'],
                                  'unresolved': len(s['unresolved']),
                                  'longest': s['record_highs'][-1]}
                                 for s in report['stages']]}, indent=2))
