"""D-430: line_wave_report attributes kills and losses to waves and reads LINE: orders."""
import json
import tempfile
import unittest
from pathlib import Path

import line_wave_report


LOG = """
[RangedArena] frame=450 spawn id=10 team=0 unit=corthud x=3800 z=3700
[RangedArena] frame=451 spawn id=11 team=0 unit=corstorm x=3870 z=3480
[RangedArena] frame=1050 spawn id=20 team=1 unit=armpw x=3700 z=5200
[RangedArena] frame=1051 spawn id=21 team=1 unit=armpw x=3780 z=5200
[RangedArena] frame=1400 shot id=10 unit=corthud weapon=1 target=20 distance=370 intent=1
[RangedArena] frame=1500 damage id=20 team=1 amount=104 attacker=10 attackerTeam=0 weapon=1
[RangedArena] frame=1510 damage id=10 team=0 amount=60 attacker=20 attackerTeam=1 weapon=1
[RangedArena] frame=1511 damage id=10 team=0 amount=9 attacker=nil attackerTeam=nil weapon=nil
[RangedArena] frame=1600 death id=20 team=1 unit=armpw cost=52
Skirmish AI <BARb playtest-test>: :::AI LOG:S:0:T:0:F:1620:L::LINE: line=0 order=attack from=advance source=cohort screens=6 rears=4 short=2 peer=0 long=0 static=0 comm=0 metal=90 facing=0.00,-1.00 spread=1.00 frame=1620
[RangedArena] frame=2850 spawn id=30 team=1 unit=armwar x=3800 z=5300
Skirmish AI <BARb playtest-test>: :::AI LOG:S:0:T:0:F:3000:L::LINE: line=0 order=withdraw from=attack source=cohort screens=6 rears=4 short=0 peer=0 long=0 static=0 comm=0 metal=800 facing=0.00,-1.00 spread=1.00 frame=3000
Skirmish AI <BARb playtest-test>: :::AI LOG:S:0:T:0:F:3000:L::LINE: line=0 order=withdraw screen=cover rear=withdraw elapsed=0 screen_delay=30 rear_delay=0 frame=3000
Skirmish AI <BARb playtest-test>: :::AI LOG:S:0:T:0:F:3030:L::LINE: line=0 order=withdraw screen=withdraw rear=withdraw elapsed=30 screen_delay=30 rear_delay=0 frame=3030
[RangedArena] frame=3100 death id=11 team=0 unit=corstorm cost=135
[RangedArena] frame=3200 death id=30 team=1 unit=armwar cost=180
"""


class LineWaveReportTest(unittest.TestCase):
    def test_waves_orders_and_staging(self):
        with tempfile.TemporaryDirectory() as tmp:
            directory = Path(tmp)
            (directory/'ranged-arena.json').write_text(json.dumps({
                'name': 'synthetic', 'unit': 'corthud', 'units': ['corthud', 'corstorm'],
                'waves': [{'name': 'raiders', 'after_seconds': 35, 'units': ['armpw']},
                          {'name': 'riot', 'after_seconds': 95, 'units': ['armwar']}]}))
            (directory/'infolog.txt').write_text(LOG)
            summary = line_wave_report.analyse(directory)
            raiders, riot = summary['waves']['raiders'], summary['waves']['riot']
            self.assertEqual(raiders['enemy_kills'], 1)
            self.assertEqual(raiders['enemy_metal'], 52)
            self.assertEqual(raiders['losses'], 0)
            self.assertEqual(raiders['damage_dealt'], 104)
            self.assertEqual(raiders['damage_taken'], 60)
            self.assertEqual(raiders['trade_ratio'], 'no losses')
            self.assertEqual(riot['enemy_kills'], 1)
            self.assertEqual(riot['losses'], 1)
            self.assertEqual(riot['losses_by_unit'], {'corstorm': 1})
            self.assertEqual(riot['trade_ratio'], round(180/135, 2))
            self.assertEqual(summary['first_shot_seconds'], 1400/30)
            self.assertEqual(summary['first_withdraw_seconds'], 100.0)
            self.assertEqual([o['order'] for o in summary['line_orders']], ['attack', 'withdraw'])
            self.assertEqual(summary['stance_changes'], 2)
            self.assertEqual(len(summary['staged_withdrawals']), 1)
            self.assertEqual(summary['staged_withdrawals'][0]['screen'], 'cover')
            self.assertEqual(summary['total_enemy_kills'], 2)
            self.assertEqual(summary['total_losses'], 1)
            self.assertTrue((directory/'line-waves-v1.json').exists())
            text = line_wave_report.table(summary)
            self.assertIn('| raiders | 1 | 52 | 0 | 0 | no losses | 104 | 60 |', text)


if __name__ == '__main__':
    unittest.main()
