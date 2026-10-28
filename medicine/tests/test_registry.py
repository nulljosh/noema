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


def aged(mean, sd, n='74'):
    return {'groups': [{'id': 'BG000', 'title': 'Arm'}],
            'denoms': [{'units': 'Participants', 'counts': [{'groupId': 'BG000', 'value': n}]}],
            'measures': [{'title': 'Age, Continuous', 'paramType': 'MEAN', 'dispersionType': 'STANDARD_DEVIATION',
                          'unitOfMeasure': 'years', 'classes': [{'categories': [{'measurements': [
                              {'groupId': 'BG000', 'value': mean, 'spread': sd}]}]}]}]}


class RegistryTests(unittest.TestCase):
    def test_age_against_eligibility(self):  # NCT03900650 posts 24.96 (74) for ages 21 to 30
        self.assertEqual(registry.age_flags(aged('24.96', '74'), '21 Years', '30 Years')[0]['kind'], 'wide')
        self.assertEqual(registry.age_flags(aged('24.96', '2.98'), '21 Years', '30 Years'), [])
        self.assertEqual(registry.age_flags(aged('45.0', '5.9'), '40 Years', '50 Years')[0]['kind'], 'over cap')
        self.assertEqual(registry.age_flags(aged('7.2', '65'), '50 Years', '80 Years')[0]['kind'], 'mean outside')
        self.assertEqual(registry.age_flags(aged('30', '40'), '18 Years', None), [])  # one-sided limits say nothing

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

    def test_arms_posted_as_standard_errors(self):  # arm SDs 11.1 and 12.4 posted as SEs 1.73 and 2.92
        def sem_study(total_sd):
            st = study('45.6', total_sd)
            cells = st['measures'][0]['classes'][0]['categories'][0]['measurements']
            cells[0].update(value='45.0', spread='1.73')
            cells[1].update(value='47.0', spread='2.92')
            return st
        self.assertEqual(list(registry.arms_as_sem(sem_study('11.4'))), ['Age'])
        self.assertEqual(list(registry.arms_as_sem(sem_study('11.4'), 2.0)), [])  # a decoy factor misses
        self.assertEqual(list(registry.arms_as_sem(sem_study('30.0'))), [])  # high, but not an SE slip

    def test_sd_impossible(self):
        self.assertEqual(list(registry.sd_impossible(study('46.1'))), [])  # 11.7 fits arms of 11.1 and 12.4
        (_, _, sd, lo, hi, kind), = registry.sd_impossible(study('46.1', '1.5'))
        self.assertEqual((sd, kind), (1.5, 'se'))  # 11.05 / sqrt(59) is 1.44
        self.assertEqual(next(registry.sd_impossible(study('46.1', '46.1')))[-1], 'mean')
        self.assertEqual(list(registry.sd_impossible(study('75.0', '1.5'))), [])  # mean outside: another check

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
