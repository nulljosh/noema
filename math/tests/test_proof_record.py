import hashlib
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ProofRecordTests(unittest.TestCase):
    def test_published_source_matches_checked_hash(self):
        source = (ROOT/'proofs/Noema.lean').read_bytes()
        report = json.loads((ROOT/'proofs/verification.json').read_text())
        self.assertEqual(hashlib.sha256(source).hexdigest(), report['source_sha256'])
        self.assertEqual(source, (ROOT/'landing/Noema.lean').read_bytes())
        self.assertEqual((ROOT/'proofs/verification.json').read_bytes(),
                         (ROOT/'landing/proof-check.json').read_bytes())
        self.assertEqual((ROOT/'proofs/lean-toolchain').read_text().strip(), report['toolchain'])
