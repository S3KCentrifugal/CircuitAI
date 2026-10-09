import unittest
from sea_arena import scenario_label, frozen_actor_condition


class ScenarioLabelTests(unittest.TestCase):
    def test_repair_fixture_freezes_production_not_static_assistance(self):
        self.assertEqual(frozen_actor_condition('factory',True), 'SeaEconomy::SupportedFactory(u.circuitDef)')
        self.assertIn('ConstructorDef', frozen_actor_condition('builder',True))
        self.assertEqual(frozen_actor_condition('factory',False), 'ai.frame>=0')
    def test_existing_short_categories_are_unchanged(self):
        self.assertEqual(scenario_label('surface-line'), 'surface-line-cand')

    def test_long_related_cases_do_not_collapse(self):
        names = [scenario_label('legion-submarine-'+end, control)
                 for end in ('supported', 'unsupported') for control in (True, False)]
        self.assertEqual(len(set(names)), 4)
        self.assertTrue(all(len(name)<=24 for name in names))


if __name__ == '__main__':
    unittest.main()
