import os
import sys
import unittest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))
import nubase


def line(a, zi, name, t, unit, flags='  ', jp=''):
    """One NUBASE2020 row with only the columns nubase.py reads filled in."""
    s = f'{a:03d} {zi:04d}'.ljust(11) + name.ljust(56)
    return (s + flags + f'{t:>9s}{unit:<2s}'.ljust(19) + jp).ljust(110)


class NubaseTest(unittest.TestCase):
    def test_columns(self):
        nb = nubase.nubase([line(239, 940, '239Pu', '24.11', 'ky', jp='1/2+*')])
        self.assertEqual(nb[(94, 239, '0')], (['24.11', 'ky'], '  ', '1/2+*'))
        self.assertAlmostEqual(nubase.seconds(['24.11', 'ky']) / nubase.Y, 24110)
        self.assertIsNone(nubase.seconds(['2#', 'm']))

    def test_swap(self):
        nb = nubase.nubase([line(138, 610, '138Pm', '3.24', 'm', jp='3-#'),
                            line(138, 611, '138Pmm', '10', 's', jp='1+#')])
        row = {'z': '61', 'n': '77', 'symbol': 'Pm', 'half_life': '10', 'unit_hl': 's', 'operator_hl': '',
               'jp': '(1+)', 'ENSDFpublicationcut-off': '30-Sep-2017', 'half_life_sec': '10', 'unc_hls': '2'}
        self.assertEqual(len(nubase.swaps(nb, [row])), 1)
        self.assertEqual(nubase.halflives(nb, [row])[0][1], '138Pm')
        flagged = nubase.nubase([line(138, 610, '138Pm', '3.24', 'm', ' &', '3-#'),
                                 line(138, 611, '138Pmm', '10', 's', jp='1+#')])
        self.assertEqual(nubase.swaps(flagged, [row]), [])


    def test_duplicates(self):
        row = lambda *m: dict({f'decay_{i + 1}': d for i, (d, _) in enumerate(m)},
                              **{f'decay_{i + 1}_%': p for i, (_, p) in enumerate(m)}, z='88', n='135', symbol='Ra')
        full = lambda r: {**{f'decay_{i}': '' for i in (1, 2, 3)}, **{f'decay_{i}_%': '' for i in (1, 2, 3)}, **r}
        bulk = full(row(('A', '100'), ('14C', '0.000000089'), ('14C', '0.000000077')))
        single = full(row(('A', '100'), ('14C', '0.000000089')))
        self.assertEqual(nubase.duplicates([bulk])[0][0], '223Ra')
        self.assertEqual(nubase.duplicates([single]), [])


if __name__ == '__main__':
    unittest.main()
