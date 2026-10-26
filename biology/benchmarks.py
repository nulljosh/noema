"""Fixed-input regression and sequence-concordance benchmarks, separate from AI quality."""
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
import platform
import statistics
import sys

from Bio import __version__ as biopython_version
from evidna import ROOT, DATA, analyze


def compare(actual, baseline):
    return [{'metric': key, 'expected': expected, 'actual': actual.get(key)}
            for key, expected in baseline['metrics'].items() if actual.get(key) != expected]


def evaluate(rows, annotations, elapsed):
    cases = json.loads((ROOT / 'benchmarks/cases.json').read_text())['cases']
    checks = []
    for case in cases:
        report = analyze(DATA, case['variant'])
        checks.append({'variant': case['variant'], 'passed': report['mutant_amino_acid'] == case['amino_acid'] and report['consequence'] == case['consequence']})
    metrics = {'scanned': len(rows), 'unique_variants': len({r['variant'] for r in rows}),
               'consequences': dict(sorted(Counter(r['consequence'] for r in rows).items())),
               'known_cases_passed': sum(c['passed'] for c in checks), 'known_cases_total': len(checks),
               'matched_annotations': len(annotations['matched_annotations']),
               'unmatched_annotations': len(annotations['not_reproduced_by_single_base_scan']),
               'excluded_annotations': len(annotations['excluded_annotation_ids'])}
    inputs = {name: hashlib.sha256((ROOT / 'data' / name).read_bytes()).hexdigest()
              for name in ('hbb.gb', 'hbb-uniprot.fasta', 'hbb-uniprot.json')}
    baseline = json.loads((ROOT / 'benchmarks/baseline.json').read_text())
    regressions = compare(metrics, baseline)
    if inputs != baseline['inputs']:
        regressions.append({'metric': 'input_fingerprints', 'expected': baseline['inputs'], 'actual': inputs})
    result = {'suite': 'hbb-v1', 'created': datetime.now(timezone.utc).isoformat(), 'metrics': metrics,
              'inputs': inputs, 'regressions': regressions, 'passed': not regressions,
              'elapsed_seconds': round(elapsed, 6), 'cases': checks,
              'environment': {'python': sys.version.split()[0], 'biopython': biopython_version,
                              'os': platform.system(), 'machine': platform.machine()},
              'limits': 'Known-case correctness and fixed-input regression checks only. Annotation coverage is 256/261 in the initial snapshot; unmatched and excluded cases stay visible. Timing is informational and comparable only on the same machine under similar load. AI hypothesis quality is not scored.'}
    directory = ROOT / 'benchmarks'
    temp = directory / 'latest.tmp'
    temp.write_text(json.dumps(result, indent=2) + '\n')
    temp.replace(directory / 'latest.json')
    with (directory / 'history.jsonl').open('a') as stream:
        stream.write(json.dumps({k: v for k, v in result.items() if k not in ('cases', 'limits')}) + '\n')
    history = [json.loads(line) for line in (directory / 'history.jsonl').read_text().splitlines()]
    runs = [r for r in history if r['inputs'] == inputs and r['environment'] == result['environment']]
    findings = {'updated': result['created'], 'metrics': metrics,
                'reproducibility_runs': len(runs), 'passed_runs': sum(r['passed'] for r in runs),
                'identical_metrics': all(r['metrics'] == metrics for r in runs),
                'median_seconds': round(statistics.median(r['elapsed_seconds'] for r in runs), 3),
                'model_calls': 0, 'scope': result['limits']}
    (ROOT / 'landing/findings.json').write_text(json.dumps(findings, indent=2) + '\n')
    return result
