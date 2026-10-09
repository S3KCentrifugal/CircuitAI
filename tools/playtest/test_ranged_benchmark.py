import json
import tempfile
import unittest
from pathlib import Path
from ranged_benchmark import summarize


class MeasurementsTest(unittest.TestCase):
    def test_logs_and_overkill_are_not_confused_with_fixture_events(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)
            (path/'ranged-arena.json').write_text(json.dumps(dict(name='test',unit='armsnipe',variant='ranged',seed=1,minutes=4)))
            (path/'infolog.txt').write_text('''[Playtest] expect [RangedArena] unit damaged
[RangedArena] frame=300 spawn id=1 team=0 unit=armsnipe x=0 z=0
[RangedArena] frame=310 spawn id=2 team=1 unit=armllt x=0 z=800
[RangedArena] frame=600 shot id=1 unit=armsnipe weapon=1 target=2 distance=880 intent=2
[RangedArena] frame=610 damage id=2 team=1 amount=2500 attacker=1 attackerTeam=0 weapon=283
[RangedArena] frame=610 death id=2 team=1 unit=armllt cost=85
[RangedArena] frame=7200 orders team=0 total=50 nonlua=40 lua=10
''')
            result=summarize(path)
            self.assertTrue(result['passed'])
            self.assertEqual(result['enemy_metal_destroyed'],85)
            self.assertEqual(result['commands_per_game_minute'],10)
            self.assertEqual(result['raw_damage_including_overkill'],2500)
            self.assertEqual(result,summarize(path))
            (path/'infolog.txt').write_text('[RangedArena] frame=700 ERROR test\n')
            with self.assertRaises(RuntimeError): summarize(path)

    def test_early_failure_uses_observed_command_window_and_fails_acceptance(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)
            (path/'ranged-arena.json').write_text(json.dumps(dict(name='test',unit='armsnipe',variant='ranged',seed=1,minutes=4,
                assertions=dict(min_kills=0,min_shooters=0))))
            (path/'infolog.txt').write_text('[RangedArena] frame=1800 orders team=0 nonlua=120 lua=0\n')
            result=summarize(path)
            self.assertFalse(result['passed'])
            self.assertEqual(result['commands_per_game_minute'],120)
            self.assertIn('incomplete observation window',result['failures'])

    def test_failed_watch_verdict_and_missing_sensor_movement_remain_failures(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)
            (path/'ranged-arena.json').write_text(json.dumps(dict(name='test',unit='armsnipe',variant='ranged',seed=1,minutes=4,
                sensor_units=['armseer'],assertions=dict(min_kills=0,min_shooters=0,min_sensor_advance=600))))
            (path/'infolog.txt').write_text('[RangedArena] frame=7200 orders team=0 nonlua=120 lua=0\n')
            archive=path/'runs/test';archive.mkdir(parents=True)
            (archive/'result.json').write_text('{"verdict":"FAIL"}')
            result=summarize(path)
            self.assertFalse(result['passed'])
            self.assertIn('original watch verdict: FAIL',result['failures'])
            self.assertIn('sensor did not advance: armseer',result['failures'])

    def test_shutdown_grace_and_partial_events_do_not_extend_measurements(self):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)
            (path/'ranged-arena.json').write_text(json.dumps(dict(name='test',unit='armsnipe',variant='ranged',seed=1,minutes=4,
                assertions=dict(min_kills=0,min_shooters=0))))
            (path/'infolog.txt').write_text('''[RangedArena] frame=7200 orders team=0 nonlua=120 lua=0
[WorkforcePerf] frame=7200 ai_all_p95_ms=0.2
[RangedArena] frame=7500 orders team=0 nonlua=999 lua=0
[WorkforcePerf] frame=7500 ai_all_p95_ms=9
[RangedArena] frame=7501 damage id=2 team=1 amount=25
''')
            result=summarize(path)
            self.assertTrue(result['passed'])
            self.assertEqual(result['commands_per_game_minute'],30)
            self.assertEqual(result['last_observed_frame'],7500)
            self.assertEqual(len(result['engine_ai_windows']),1)


if __name__=='__main__': unittest.main()
