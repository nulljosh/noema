import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import registry


def study(total_mean, total_sd='11.7', total_n='59'):
    def cell(g, m, s):
        return {'groupId': g, 'value': m, 'spread': s}
    return {'groups': [{'id': 'BG000', 'title': 'Control'}, {'id': 'BG001', 'title': 'Drug'},
                       {'id': 'BG002', 'title': 'Total'}],
            'denoms': [{'units': 'Participants', 'counts': [{'groupId': 'BG000', 'value': '41'},
                                                            {'groupId': 'BG001', 'value': '18'},
                                                            {'groupId': 'BG002', 'value': total_n}]}],
            'measures': [{'title': 'Age', 'paramType': 'MEAN', 'classes': [{'categories': [{'measurements': [
                cell('BG000', '40.7', '11.1'), cell('BG001', '58.5', '12.4'),
                cell('BG002', total_mean, total_sd)]}]}]}]}


class RegistryTests(unittest.TestCase):
    def test_a_weighted_total_passes(self):
        row, = registry.rows(study('46.1'))
        self.assertFalse(row['far'] or row['outside'] or row['unweighted'])

    def test_a_plain_average_is_named(self):
        row, = registry.rows(study('49.6', '11.75'))
        self.assertTrue(row['far'] and row['unweighted'] and row['sd_plain'])
        self.assertFalse(row['outside'])

    def test_outside_the_arms_and_other_people(self):
        row, = registry.rows(study('75.0'))
        self.assertTrue(row['outside'] and row['far'] and not row['unweighted'])
        self.assertEqual(list(registry.rows(study('75.0', total_n='60'))), [])


    def test_counts(self):
        cell = lambda g, v: {'groupId': g, 'value': v}
        s = study('46.1')
        s['measures'] = [{'title': 'Sex: Female, Male', 'paramType': 'COUNT_OF_PARTICIPANTS', 'classes': [{'categories': [
            {'measurements': [cell('BG000', '20'), cell('BG001', '9'), cell('BG002', '29')]},
            {'measurements': [cell('BG000', '22'), cell('BG001', '9'), cell('BG002', '30')]}]}]}]
        miss, over = registry.counts(s)
        self.assertEqual(miss, ['Sex: Female, Male'])
        self.assertEqual(over, [('Sex: Female, Male', 'BG000', 42, 41)])


if __name__ == '__main__':
    unittest.main()
