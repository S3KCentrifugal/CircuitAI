import argparse
import unittest
import playtest


class IsolationTests(unittest.TestCase):
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
