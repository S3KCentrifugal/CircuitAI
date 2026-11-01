import argparse
import json
import unittest
import playtest
import run_tech_rush_timelines as timelines


class IsolationTests(unittest.TestCase):
    def test_nonrush_eco_observes_no_chain_and_eco_plan(self):
        check = json.loads((playtest.HERE / 'checks/tech/economy/eco_growth.json').read_text())
        keys = {row['key']: row for row in check['expect']}
        self.assertIn('no rush objective', keys['no rush']['pattern'])
        self.assertIn('eco', keys['eco plan']['pattern'])
        self.assertEqual(keys['milestone']['by_minute'], check['stop_minute'])
        self.assertNotIn('pass_on', check)

    def test_layout_saturation_uses_normal_ranges_despite_lobby_options(self):
        case = json.loads((playtest.HERE / 'cases/shared/combat/tech-layout-saturation.json').read_text())
        for name in ('multiplier_builddistance', 'multiplier_buildpower', 'multiplier_resourceincome'):
            self.assertEqual(case['modoptions'][name], 1)
        self.assertGreater(case['start_metal'], 1000)  # supplied geometry test, not an economy benchmark

    def test_seed_is_pinned_in_game_section(self):
        text = timelines.pin_engine_seed('[GAME]\n{\nMapName=Test;\n}', 431)
        self.assertIn('[GAME]\n{\n\tFixedRNGSeed=431;', text)
        self.assertIn('MapName=Test;', text)

    def test_seed_rejects_random_or_ambiguous_input(self):
        for text, seed in (('[GAME]{ }', 0), ('[OTHER]{}', 1), ('[GAME]{FixedRNGSeed=2;}', 1)):
            with self.assertRaises(ValueError):
                timelines.pin_engine_seed(text, seed)

    def test_timelines_pin_normal_economy_and_construction(self):
        args = timelines.normal_options()
        self.assertEqual(args[::2], ['--modoption'] * len(timelines.NORMAL_OPTIONS))
        values = dict(value.split('=', 1) for value in args[1::2])
        self.assertEqual(values['multiplier_resourceincome'], '1')
        self.assertEqual(values['multiplier_buildpower'], '1')
        self.assertEqual(values['multiplier_builddistance'], '1')
        self.assertEqual(values['startmetal'], '1000')
        self.assertEqual(values['nowasting'], 'default')
    def test_donation_fixture_retains_front_without_enemy(self):
        args = argparse.Namespace(ally_spots=None, roles='TECH,FRONT', role='TECH',
            side='legion', isolated=True, isolated_allies=True, others='test', enemies=None)
        teams = playtest.choose_teams(args, [(0,0,'FRONT'), (1,1,'TECH'),
            (2,2,'TECH'), (3,3,'FRONT')])
        self.assertEqual(len(teams), 2)
        self.assertTrue(all(row[1] == 0 for row in teams))
    def test_isolation_keeps_only_requested_role_and_no_fallback_enemy(self):
        args = argparse.Namespace(ally_spots=None, roles='all', role='TECH',
                                  side='legion', isolated=True)
        self.assertEqual(playtest.choose_teams(args, [(0,0,'FRONT'), (1,1,'TECH'),
            (2,2,'TECH'), (3,3,'FRONT')]), [(1,0,'test','legion')])

    def test_normal_run_retains_enemy(self):
        args = argparse.Namespace(ally_spots=None, roles='TECH', role='TECH',
            side='legion', isolated=False, others='none', enemies=None)
        self.assertTrue(any(row[1] == 1 for row in playtest.choose_teams(args,
            [(0,0,'TECH'), (1,1,'TECH')])))
