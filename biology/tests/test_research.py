from pathlib import Path
import tempfile
import unittest
from research import benchmark, paper_update, run, scan


class ResearchTests(unittest.TestCase):
    def test_full_scan_and_annotation_comparison(self):
        with tempfile.TemporaryDirectory() as folder:
            rows = scan(float('inf'), Path(folder) / 'scan.jsonl')
        self.assertEqual(len(rows), 1332)
        self.assertEqual(len({r['variant'] for r in rows}), 1332)
        stop = next(r for r in rows if r['variant'] == 'c.444A>G')
        self.assertEqual(stop['consequence'], 'stop retained')
        annotations = {'features': [{'type': 'Natural variant', 'featureId': 'fixture',
                                    'location': {'start': {'value': 7}, 'end': {'value': 7}},
                                    'alternativeSequence': {'originalSequence': 'E', 'alternativeSequences': ['V', 'W']}}]}
        result = benchmark(rows, annotations)
        self.assertEqual(result['matched_annotations'][0]['coding_substitutions'], ['c.20A>T'])
        self.assertEqual(result['not_reproduced_by_single_base_scan'][0]['alternative'], 'W')

    def test_time_limit_checkpoints(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            paper = root / 'paper.md'
            paper.write_text('# Keep this research\n')
            result = run(1e-12, output_root=root / 'runs', paper=paper, database=root / 'notebook.sqlite3')
            self.assertEqual(result['scanned'], 0)
            self.assertIn('time limit', result['status'])
            self.assertTrue((Path(result['directory']) / 'summary.json').exists())
            paper_update(paper, result)
            self.assertEqual(paper.read_text().count('<!-- research-loop:start -->'), 1)
            self.assertTrue(paper.read_text().startswith('# Keep this research'))

    def test_runtime_validation(self):
        for minutes in (0, -1, 61, float('nan'), float('inf')):
            with self.assertRaises(ValueError):
                run(minutes)

class BenchmarkTests(unittest.TestCase):
    def test_regression_detection(self):
        from benchmarks import compare
        baseline = {'metrics': {'scanned': 1332, 'known_cases_passed': 9}}
        self.assertEqual(compare({'scanned':1332,'known_cases_passed':9}, baseline), [])
        failures = compare({'scanned':1331,'known_cases_passed':8}, baseline)
        self.assertEqual({r['metric'] for r in failures}, {'scanned','known_cases_passed'})


if __name__ == '__main__':
    unittest.main()
