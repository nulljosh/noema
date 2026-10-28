import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import outcomes  # noqa: E402


def measure(param, unit, value, n):
    return {'paramType': param, 'unitOfMeasure': unit,
            'denoms': [{'counts': [{'groupId': 'OG000', 'value': str(n)}]}],
            'classes': [{'categories': [{'measurements': [{'groupId': 'OG000', 'value': str(value)}]}]}]}


class OutcomeTests(unittest.TestCase):
    def test_bounds(self):
        self.assertEqual(outcomes.flags(measure('COUNT_OF_PARTICIPANTS', 'Participants', 12, 20)), [])
        self.assertEqual(outcomes.flags(measure('COUNT_OF_PARTICIPANTS', 'Participants', 21, 20)),
                         [('count > analysed', 'OG000', 21.0, 20.0)])
        self.assertEqual(outcomes.flags(measure('NUMBER', 'percentage of participants', 104.5, 20)),
                         [('percent > 100', 'OG000', 104.5, 100)])
        self.assertEqual(outcomes.flags(measure('MEAN', 'mg/dL', 400, 20)), [])  # not a count


if __name__ == '__main__':
    unittest.main()
