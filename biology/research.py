"""A finite research queue. No scheduler, model calls, or hardware access."""
from collections import Counter
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path
import tempfile
import time

from Bio import SeqIO
from evidna import DATA, ROOT, analyze, connect, save, study


def scan(deadline, output):
    record = SeqIO.read(DATA, 'genbank')
    cds = str(next(f for f in record.features if f.type == 'CDS').extract(record.seq))
    rows = []
    with output.open('w') as stream:
        for position, before in enumerate(cds, 1):
            for after in 'ACGT':
                if before == after:
                    continue
                if time.monotonic() >= deadline:
                    return rows
                report = analyze(DATA, f'c.{position}{before}>{after}')
                row = {key: report[key] for key in ('variant', 'codon_position', 'reference_codon', 'mutant_codon', 'reference_amino_acid', 'mutant_amino_acid', 'consequence')}
                stream.write(json.dumps(row) + '\n')
                stream.flush()
                rows.append(row)
    return rows


def benchmark(rows, annotation):
    """Check whether computed substitutions reproduce curated amino-acid changes."""
    by_change = {}
    for row in rows:
        key = (row['codon_position'], row['reference_amino_acid'], row['mutant_amino_acid'])
        by_change.setdefault(key, []).append(row['variant'])
    matches, missing, excluded = [], [], []
    for feature in annotation['features']:
        if feature['type'] != 'Natural variant':
            continue
        location = feature['location']
        start, end = location['start'].get('value'), location['end'].get('value')
        sequence = feature.get('alternativeSequence', {})
        original = sequence.get('originalSequence', '')
        alternatives = sequence.get('alternativeSequences', [])
        if start != end or len(original) != 1 or not alternatives:
            excluded.append(feature.get('featureId'))
            continue
        for alternative in alternatives:
            if len(alternative) != 1 or alternative not in 'ACDEFGHIKLMNPQRSTVWY':
                excluded.append(feature.get('featureId'))
                continue
            row = {'feature_id': feature.get('featureId'), 'position': start,
                   'reference': original, 'alternative': alternative}
            candidates = by_change.get((start, original, alternative), [])
            if candidates:
                matches.append({**row, 'coding_substitutions': candidates})
            else:
                missing.append(row)
    return {'matched_annotations': matches, 'not_reproduced_by_single_base_scan': missing,
            'excluded_annotation_ids': excluded,
            'limits': 'Protein-change concordance only, not phenotype validation. Unmatched annotations may require multiple nucleotide changes; investigate rather than calling them prediction errors. No held-out model evaluation was performed.'}


def paper_update(path, summary):
    block = '\n'.join([
        '<!-- research-loop:start -->',
        '## Latest bounded research run',
        '',
        f"Status: {summary['status']}. Updated {summary['updated']}.",
        f"Input: NM_000518.5, SHA-256 `{summary['reference_sha256']}`.",
        f"Scanned {summary.get('scanned', 0)} of 1,332 possible single-base coding substitutions.",
        '',
        *[f"{kind}: {count}." for kind, count in summary.get('consequences', {}).items()],
        '',
        f"UniProt protein annotations reproduced: {summary.get('matched_annotations', 'not yet checked')}.",
        f"Not reproduced by a single-base substitution: {summary.get('unmatched_annotations', 'not yet checked')}.",
        f"Excluded complex annotations: {summary.get('excluded_annotations', 'not yet checked')}.",
        '',
        'These are sequence-level computational checks, not experiments on protein function.',
        'The queue makes zero model calls and stops when its finite work is complete.',
        '<!-- research-loop:end -->',
    ])
    content = path.read_text()
    start, end = '<!-- research-loop:start -->', '<!-- research-loop:end -->'
    if start in content and end in content:
        before, remainder = content.split(start, 1)
        _, after = remainder.split(end, 1)
        content = before + block + after
    else:
        content = content.rstrip() + '\n\n' + block + '\n'
    temp = path.with_suffix('.tmp')
    temp.write_text(content)
    temp.replace(path)


def run(minutes=15, output_root=None, paper=None, database=None):
    if not math.isfinite(minutes) or not 0 < minutes <= 60:
        raise ValueError('Runtime must be greater than zero and at most 60 minutes.')
    started = time.monotonic()
    deadline = started + minutes * 60
    output_root = Path(output_root or ROOT / 'runs')
    output_root.mkdir(parents=True, exist_ok=True)
    directory = Path(tempfile.mkdtemp(prefix=datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ-'), dir=output_root))
    summary = {'status': 'running', 'directory': str(directory), 'max_minutes': minutes,
               'reference_sha256': hashlib.sha256(DATA.read_bytes()).hexdigest(),
               'model_calls': 0, 'notes': 'Finite foreground queue; never repeats identical jobs to fill time.'}
    paper = Path(paper or ROOT / 'WHITEPAPER.md')
    database = database or ROOT / 'notebook.sqlite3'

    def checkpoint():
        summary['updated'] = datetime.now(timezone.utc).isoformat()
        temp = directory / 'summary.tmp'
        temp.write_text(json.dumps(summary, indent=2) + '\n')
        temp.replace(directory / 'summary.json')
        paper_update(paper, summary)

    checkpoint()
    try:
        comparison = study()
        (directory / 'study.json').write_text(json.dumps(comparison, indent=2) + '\n')
        rows = scan(deadline, directory / 'scan.jsonl')
        summary.update(scanned=len(rows), consequences=dict(sorted(Counter(r['consequence'] for r in rows).items())))
        checkpoint()
        if len(rows) == 1332 and time.monotonic() < deadline:
            source = ROOT / 'data/hbb-uniprot.json'
            annotation = json.loads(source.read_text())
            reference = SeqIO.read(ROOT / 'data/hbb-uniprot.fasta', 'fasta')
            if annotation['primaryAccession'] != 'P68871' or annotation['sequence']['value'] != str(reference.seq):
                raise ValueError('UniProt JSON does not match the pinned protein sequence.')
            result = benchmark(rows, annotation)
            result['source'] = 'https://rest.uniprot.org/uniprotkb/P68871.json'
            result['source_sha256'] = hashlib.sha256(source.read_bytes()).hexdigest()
            (directory / 'benchmark.json').write_text(json.dumps(result, indent=2) + '\n')
            from benchmarks import evaluate
            scores = evaluate(rows, result, time.monotonic() - started)
            (directory / 'scores.json').write_text(json.dumps(scores, indent=2) + '\n')
            summary.update(matched_annotations=len(result['matched_annotations']),
                           unmatched_annotations=len(result['not_reproduced_by_single_base_scan']),
                           excluded_annotations=len(result['excluded_annotation_ids']),
                           benchmark_passed=scores['passed'], elapsed_seconds=scores['elapsed_seconds'],
                           status='complete' if scores['passed'] else 'benchmark regression; review required')
        else:
            summary['status'] = 'time limit reached; partial results saved'
        with connect(database) as db:
            summary['notebook_entry'] = save(db, 'research_run', summary)
        checkpoint()
    except BaseException as error:
        summary.update(status='interrupted' if isinstance(error, KeyboardInterrupt) else 'failed', error=type(error).__name__)
        checkpoint()
        raise
    return summary
