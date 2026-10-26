import json
import sqlite3
import tempfile
import unittest
from unittest.mock import patch
from Bio import SeqIO
from Bio.SeqFeature import BeforePosition, SimpleLocation

from evidna import DATA, analyze, connect, hypothesize, save, study


class LabTests(unittest.TestCase):
    def test_study_prediction_and_negative_control(self):
        result = study()
        mutant, _, control = result['variants']
        self.assertEqual(mutant['differences'], [{'position': 7, 'reference': 'E', 'mutant': 'V'}])
        self.assertAlmostEqual(mutant['mass_delta_da'], -29.983, places=3)
        self.assertAlmostEqual(mutant['charge_delta_pH7'], 0.99719, places=5)
        self.assertEqual((control['differences'], control['mass_delta_da'], control['charge_delta_pH7']), ([], 0, 0))
        self.assertTrue(result['cross_check']['matches_uniprot_sequence'])

    def test_reference_and_known_substitution(self):
        r = analyze(DATA, 'c.20A>T')
        self.assertEqual((r['accession'], r['cds_bases'], r['protein_residues']), ('NM_000518.5', 444, 147))
        self.assertEqual((r['reference_codon'], r['mutant_codon'], r['reference_amino_acid'], r['mutant_amino_acid']), ('GAG', 'GTG', 'E', 'V'))
        self.assertEqual(r['consequence'], 'missense')

    def test_consequences(self):
        for variant, expected in [('c.21G>A', 'synonymous'), ('c.19G>T', 'stop gained'), ('c.1A>G', 'start-codon change'), ('c.442T>C', 'stop lost'), ('c.444A>G', 'stop retained')]:
            with self.subTest(variant=variant):
                self.assertTrue(analyze(DATA, variant)['consequence'].startswith(expected))

    def test_bad_variants(self):
        for v in ['c.0A>T', 'c.999A>T', 'c.20C>T', 'c.20A>A', '20A>T', 'c.20A>N']:
            with self.subTest(variant=v), self.assertRaises(ValueError):
                analyze(DATA, v)

    def test_evidence_and_revision(self):
        with connect(':memory:') as db, patch('evidna.ask', return_value='Mock output, not scientific evidence') as ask:
            report = analyze(DATA, 'c.20A>T')
            first = hypothesize(db, report)
            with self.assertRaises(ValueError):
                hypothesize(db, report, first['id'])
            save(db, 'observation', {'text': 'Test fixture', 'source': 'unit test'}, first['id'])
            revised = hypothesize(db, report, first['id'])
            self.assertEqual(revised['status'], 'unvalidated')
            self.assertEqual(ask.call_count, 4)
            self.assertIn('Test fixture', json.dumps(ask.call_args_list[2].args))
            with self.assertRaises(ValueError):
                hypothesize(db, analyze(DATA, 'c.21G>A'), first['id'])
            with self.assertRaises(sqlite3.IntegrityError):
                save(db, 'observation', {}, 999)

    def test_saved_notebook(self):
        with tempfile.TemporaryDirectory() as folder:
            path = folder + '/notebook.sqlite3'
            with connect(path) as db:
                save(db, 'hypothesis', {'status': 'unvalidated'})
            with connect(path) as db:
                self.assertEqual(db.execute('SELECT count(*) FROM entries').fetchone()[0], 1)

    def test_unsupported_cds_annotations(self):
        for qualifier, value in [('transl_table', '2'), ('codon_start', '2'), ('partial', 'true')]:
            record = SeqIO.read(DATA, 'genbank')
            feature = next(f for f in record.features if f.type == 'CDS')
            if qualifier == 'partial':
                feature.location = SimpleLocation(BeforePosition(feature.location.start), feature.location.end)
            else:
                feature.qualifiers[qualifier] = [value]
            with tempfile.TemporaryDirectory() as folder:
                path = folder + '/fixture.gb'
                SeqIO.write(record, path, 'genbank')
                with self.assertRaises(ValueError):
                    analyze(path, 'c.20A>T')


if __name__ == '__main__':
    unittest.main()
