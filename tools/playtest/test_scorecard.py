"""Boundary tests: mismatched conditions and censored games must not contaminate ratings."""
import copy
import tempfile
import unittest
from pathlib import Path

import scorecard as s


def fixture():
    manifest={'schema':1,'run_id':'test','started_at_utc':'2026-09-29T16:00:00+00:00',
        'map':'Glacial Gap v1.1','game':'BAR pinned','engine_version':'recoil pinned','engine_sha256':'engine',
        'modoptions':{'experimentallegionfaction':'1','date_day':'29','multiplier_weapondamage':'1'},
        'teams':[{'team':0,'ally':0,'side':'cortex','role':'TECH','x':100,'z':100},
                 {'team':1,'ally':1,'side':'legion','role':'TECH','x':900,'z':100}],
        'ai_options':[{'profile':'experimental_balanced'}]*2,'handicaps':['0','0'],
        'scenario':{},'widgets':{'scorecard_metrics.lua':'hash'},'dll_sha256':'dll','data_sha256':'data'}
    sample={'frame':1800,'metalIncome':210,'combatCompleted':2,'factories':1,'idleFactories':0,
            'metalProduced':2000,'metalReceived':0,'metalUsed':1800,'metalExcess':20,'dead':False}
    parsed={'events':[('init',{'mapChecksum':'map','gameChecksum':'game'}),
                      ('sample',dict(sample,team=0)),('sample',dict(sample,team=1))],
        'roles':{0:{'side':'cortex','role':2},1:{'side':'legion','role':2}},'starts':{0:[100,100],1:[900,100]},
        'invariants':{},'errors':[],'flanks':{},'last_frame':1800}
    return manifest,parsed


class ScorecardTests(unittest.TestCase):
    def test_record_after_restaging_uses_archived_inputs_and_preserves_hashes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            directory, run = root/'working', root/'archive'
            directory.mkdir(); run.mkdir()
            manifest, _ = fixture()
            manifest['started_at_local'] = '2026-09-29T13:00:00-03:00'
            manifest['scenario']['headless'] = False
            s.write_json(run/'scorecard-manifest.json', manifest)
            s.write_json(run/'launched.json', {'engine':str(root/'old-engine')})
            s.write_json(run/'run-inputs.json', {'engine_sha256':'original-engine-hash'})
            (run/'script.txt').write_text('original start script')
            (run/'teams.json').write_text('{}')
            (run/'staged.json').write_text('{}')
            (run/'infolog.txt').write_text('')
            s.write_json(directory/'scorecard-manifest.json', {'a':'later experiment'})
            original = {p.name:p.read_bytes() for p in run.iterdir()}

            card_path = s.record(directory, run, root/'scorecards')

            card = s.read_json(card_path)
            self.assertEqual(card['manifest']['map'], 'Glacial Gap v1.1')
            self.assertEqual(card['manifest']['engine_sha256'], 'original-engine-hash')
            self.assertEqual({name:(run/name).read_bytes() for name in original}, original)

    def test_compare_legion_changed_rejects(self):
        m,p=fixture(); a=s.make_card(m,p)
        m=copy.deepcopy(m); m['modoptions']['experimentallegionfaction']='0'
        self.assertFalse(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_compare_build_changed_accepts_conditions(self):
        m,p=fixture(); a=s.make_card(m,p)
        m=copy.deepcopy(m); m['dll_sha256']='new-build'
        self.assertTrue(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_compare_wall_clock_only_preserves_cohort(self):
        m,p=fixture(); a=s.make_card(m,p)
        m=copy.deepcopy(m); m['started_at_utc']='2026-09-30T16:00:00+00:00'
        self.assertEqual(a['cohort'],s.make_card(m,p)['cohort'])

    def test_compare_game_calendar_changed_rejects(self):
        m,p=fixture(); a=s.make_card(m,p)
        m=copy.deepcopy(m); m['modoptions']['date_day']='30'
        self.assertFalse(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_compare_changed_start_rejects(self):
        m,p=fixture(); a=s.make_card(m,p)
        m=copy.deepcopy(m); m['teams'][0]['x']=120
        self.assertFalse(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_compare_map_checksum_changed_rejects(self):
        m,p=fixture(); a=s.make_card(m,p)
        p=copy.deepcopy(p); p['events'][0][1]['mapChecksum']='different'
        self.assertFalse(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_rating_censored_game_keeps_prior(self):
        m,p=fixture()
        ratings=s.ratings_for([s.make_card(m,p)])
        self.assertEqual(ratings['entrants'][0]['rated_games'],0)
        self.assertEqual(ratings['entrants'][0]['mu'],25)

    def test_rating_confirmed_win_updates_winner_up(self):
        m,p=fixture(); p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':'0'}))
        result=s.ratings_for([s.make_card(m,p)])['events'][0]
        self.assertGreater(result['after'][0]['mu'],result['before'][0]['mu'])
        self.assertLess(result['after'][1]['mu'],result['before'][1]['mu'])

    def test_rating_engine_draw_is_not_censored(self):
        m,p=fixture(); p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':''}))
        result=s.ratings_for([s.make_card(m,p)])['events'][0]
        self.assertTrue(result['updated'])
        self.assertAlmostEqual(result['after'][0]['mu'],result['after'][1]['mu'])

    def test_rating_duplicate_selfplay_excluded(self):
        m,p=fixture(); m['teams'][1]['side']='cortex'; p['roles'][1]['side']='cortex'
        p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':'0'}))
        self.assertFalse(s.make_card(m,p)['rating_eligible'])

    def test_role_mismatch_invalidates_measurement(self):
        m,p=fixture(); p['roles'][0]['role']=0
        self.assertEqual(s.make_card(m,p)['status'],'invalid')

    def test_confirmed_result_with_runtime_error_not_rated(self):
        m,p=fixture(); p['errors']=['Access violation']
        p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':'0'}))
        self.assertFalse(s.make_card(m,p)['rating_eligible'])

    def test_far_actual_start_rejects_comparison(self):
        m,p=fixture(); a=s.make_card(m,p)
        p=copy.deepcopy(p); p['starts'][0]=[140,100]
        self.assertFalse(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_small_actual_start_rounding_remains_comparable(self):
        m,p=fixture(); a=s.make_card(m,p)
        p=copy.deepcopy(p); p['starts'][0]=[103,100]
        self.assertTrue(s.compare(a,s.make_card(m,p))['strong_candidate'])

    def test_team_without_opponent_never_rated(self):
        m,p=fixture(); m['teams'][1]['ally']=0
        p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':''}))
        self.assertFalse(s.make_card(m,p)['rating_eligible'])

    def test_missing_samples_are_not_zero_economy(self):
        m,p=fixture(); p['events']=p['events'][:1]
        card=s.make_card(m,p)
        self.assertEqual(card['status'],'invalid')
        self.assertIsNone(card['metrics']['0']['metal_excess_fraction'])

    def test_postgame_snapshots_do_not_change_match_totals(self):
        m,p=fixture(); p['events'].append(('outcome',{'frame':1800,'source':'engine_GameOver','winners':'0'}))
        p['events'].append(('sample',{'frame':3600,'team':0,'combatCompleted':999}))
        self.assertEqual(s.make_card(m,p)['metrics']['0']['last']['combatCompleted'],2)

    def test_log_actual_role_and_observer_parse(self):
        with tempfile.TemporaryDirectory() as temp:
            path=Path(temp)/'infolog.txt'
            path.write_text("[f=0000151] [GameDetails] skirmishAI=0 team=0 side='cortex' sideId=1 role=2\n"
                            '[f=0000900] [Scorecard] sample {"frame":900,"team":0,"metalIncome":3}\n')
            parsed=s.parse_log(path)
        self.assertEqual(parsed['roles'][0],{'side':'cortex','role':2})
        self.assertEqual(parsed['events'][0][1]['metalIncome'],3)

    def test_options_preserve_embedded_semicolon(self):
        text='[MODOPTIONS]\n{\n tweakdefs=return {a=1;b=2};\n experimentallegionfaction=1;\n}\n'
        self.assertEqual(s.script_options(text)['tweakdefs'],'return {a=1;b=2}')


if __name__=='__main__': unittest.main()
