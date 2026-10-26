"""Held-out HBB benchmark: a predeclared rule scored against pinned ClinVar labels."""
import json
from pathlib import Path
import re
import sys
import urllib.parse
import urllib.request

from Bio.Align import substitution_matrices

from evidna import analyze

ROOT = Path(__file__).resolve().parent
DATA, GENBANK = ROOT / 'data/clinvar-hbb.json', ROOT / 'data/hbb.gb'
EUTILS = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
TITLE = re.compile(r'NM_000518\.5\(HBB\):(c\.[1-9]\d*[ACGT]>[ACGT])(?: \(p\.(\w+)\))?$')
# inputs v1 also takes NM_000518.4 titles: its CDS is byte-identical to .5 (checked 2026-10-26), so c. positions agree
TITLE_V1 = re.compile(r'NM_000518\.[45]\(HBB\):(c\.[1-9]\d*[ACGT]>[ACGT])(?: \(p\.(\w+)\))?$')
POSITIVE = {'Pathogenic', 'Likely pathogenic', 'Pathogenic/Likely pathogenic'}
NEGATIVE = {'Benign', 'Likely benign', 'Benign/Likely benign'}
THREE = {'Ala': 'A', 'Arg': 'R', 'Asn': 'N', 'Asp': 'D', 'Cys': 'C', 'Gln': 'Q', 'Glu': 'E',
         'Gly': 'G', 'His': 'H', 'Ile': 'I', 'Leu': 'L', 'Lys': 'K', 'Met': 'M', 'Phe': 'F',
         'Pro': 'P', 'Ser': 'S', 'Thr': 'T', 'Trp': 'W', 'Tyr': 'Y', 'Val': 'V', 'Ter': '*'}


def fetch():
    """Pin the public ClinVar HBB summaries. Run by hand; tests never touch the network."""
    def get(endpoint, **params):
        params.update(db='clinvar', retmode='json')
        body = urllib.parse.urlencode(params).encode()
        with urllib.request.urlopen(EUTILS + endpoint, body, timeout=60) as response:
            return json.load(response)
    ids = get('esearch.fcgi', term='HBB[gene]', retmax=5000)['esearchresult']['idlist']
    rows = []
    for i in range(0, len(ids), 300):
        result = get('esummary.fcgi', id=','.join(ids[i:i + 300]))['result']
        for uid in result['uids']:
            d = result[uid]
            rows.append({'uid': uid, 'accession': d['accession'], 'title': d['title'],
                         'classification': d['germline_classification'].get('description', ''),
                         'review_status': d['germline_classification'].get('review_status', ''),
                         'protein_change': d.get('protein_change', '')})
    rows.sort(key=lambda r: r['accession'])
    DATA.write_text(json.dumps({'source': EUTILS, 'query': 'HBB[gene]',
                                'records': rows}, indent=1) + '\n')
    return len(rows)


def predict(report, blosum=substitution_matrices.load('BLOSUM62')):
    consequence = report['consequence']
    if consequence == 'synonymous':
        return 0
    if consequence == 'missense':
        return int(blosum[report['reference_amino_acid']][report['mutant_amino_acid']] <= -2)
    return 1


def score(pairs):
    tp = sum(1 for y, p in pairs if y == p == 1)
    tn = sum(1 for y, p in pairs if y == p == 0)
    pos, neg = sum(y for y, _ in pairs), sum(1 - y for y, _ in pairs)
    sensitivity, specificity = tp / pos if pos else None, tn / neg if neg else None
    balanced = (sensitivity + specificity) / 2 if pos and neg else None
    return {'n': len(pairs), 'positives': pos, 'negatives': neg, 'tp': tp, 'tn': tn,
            'fp': neg - tn, 'fn': pos - tp, 'sensitivity': sensitivity,
            'specificity': specificity, 'balanced_accuracy': balanced}


def run(title=TITLE, suite_name='hbb-heldout-v1'):
    records = json.loads(DATA.read_text())['records']
    labeled, disagreements, skipped = [], [], 0
    for r in records:
        match = title.match(r['title'])
        label = 1 if r['classification'] in POSITIVE else 0 if r['classification'] in NEGATIVE else None
        if not match or label is None:
            skipped += 1
            continue
        report = analyze(GENBANK, match[1])
        if match[2]:
            m = re.fullmatch(r'([A-Z][a-z]{2})(\d+)([A-Z][a-z]{2}|=)', match[2])
            expected = m and (THREE.get(m[1]), int(m[2]),
                              THREE.get(m[1]) if m[3] == '=' else THREE.get(m[3]))
            actual = (report['reference_amino_acid'], report['codon_position'], report['mutant_amino_acid'])
            if expected and expected != actual:
                disagreements.append({'accession': r['accession'], 'title': r['title'], 'engine': actual})
        labeled.append((int(r['accession'][3:]), label, predict(report), report['consequence']))
    labeled.sort()
    cut = int(len(labeled) * 0.7)
    development, held_out = labeled[:cut], labeled[cut:]
    majority = int(sum(y for _, y, _, _ in development) * 2 >= len(development))
    def suite(rows):
        return {'predictor_v0': score([(y, p) for _, y, p, _ in rows]),
                'majority_class': score([(y, majority) for _, y, _, _ in rows]),
                'non_synonymous_is_1': score([(y, int(c != 'synonymous')) for _, y, _, c in rows])}
    return {'suite': suite_name, 'records': len(records), 'skipped': skipped,
            'labeled': len(labeled), 'engine_disagreements': disagreements,
            'held_out_from_accession': f'VCV{held_out[0][0]:09d}' if held_out else None,
            'development': suite(development), 'held_out': suite(held_out),
            'limits': 'ClinVar classifications are submitter assertions, not measurements. '
                      'Balanced accuracy on one gene says nothing about other genes.'}


if __name__ == '__main__':
    if sys.argv[1:] == ['fetch']:
        print(fetch(), 'records pinned')
        raise SystemExit
    for name, report in (('heldout-latest.json', run()), ('heldout-inputs-v1-latest.json', run(TITLE_V1, 'hbb-heldout-inputs-v1'))):
        (ROOT / 'benchmarks' / name).write_text(json.dumps(report, indent=2) + '\n')
        print(json.dumps({k: report[k] for k in ('suite', 'labeled', 'held_out_from_accession')} |
                         {'engine_disagreements': len(report['engine_disagreements']),
                          'held_out': {k: v['balanced_accuracy'] for k, v in report['held_out'].items()}}, indent=1))
