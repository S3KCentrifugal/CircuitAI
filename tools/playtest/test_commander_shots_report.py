"""D-430: commander_shots_report reads detection, intent, hits, cloak and death of an enemy commander."""
import json
import tempfile
import unittest
from pathlib import Path

import commander_shots_report


LOG = """
[RangedArena] frame=450 spawn id=10 team=0 unit=corthud x=3800 z=3700
[RangedArena] frame=2400 spawn id=20 team=1 unit=armcom x=3950 z=5150
[RangedArena] frame=2401 spawn id=21 team=1 unit=armpw x=3750 z=5250
[RangedArena] frame=2700 detected id=20 unit=armcom
[RangedArena] frame=2730 unit id=20 unit=armcom x=3900 z=4600 hp=3000 host=0 cloak=true
[RangedArena] frame=2790 unit id=20 unit=armcom x=3900 z=4500 hp=3000 host=0 cloak=false
[RangedArena] frame=2800 shot id=10 unit=corthud weapon=1 target=20 distance=360 intent=20
[RangedArena] frame=2810 damage id=20 team=1 amount=104 attacker=10 attackerTeam=0 weapon=1
[RangedArena] frame=2820 damage id=20 team=1 amount=50 attacker=nil attackerTeam=nil weapon=nil
[RangedArena] frame=2900 shot id=10 unit=corthud weapon=1 target=21 distance=300 intent=21
[RangedArena] frame=3300 death id=20 team=1 unit=armcom cost=2500
"""


class CommanderShotsReportTest(unittest.TestCase):
    def test_commander_timeline(self):
        with tempfile.TemporaryDirectory() as tmp:
            directory = Path(tmp)
            (directory/'ranged-arena.json').write_text(json.dumps({'name': 'synthetic', 'unit': 'corthud', 'units': ['corthud']}))
            (directory/'infolog.txt').write_text(LOG)
            summary = commander_shots_report.analyse(directory)
            self.assertEqual(len(summary['commanders']), 1)
            c = summary['commanders'][0]
            self.assertEqual(c['id'], 20)
            self.assertEqual(c['detected_seconds'], 90.0)
            self.assertEqual(c['first_intent'], 2800)
            self.assertEqual(c['intents'], 1)
            self.assertEqual(c['shooters'], [10])
            self.assertEqual(c['first_hit'], 2810)
            self.assertEqual(c['hits'], 1)
            self.assertEqual(c['damage'], 104)
            self.assertEqual(c['response_seconds'], round(110/30, 1))
            self.assertEqual(c['cloaked_first'], 2730)
            self.assertEqual(c['cloak_samples'], 1)
            self.assertEqual(c['samples'], 2)
            self.assertEqual(c['death_seconds'], 110.0)
            self.assertIn('| armcom 20 |', commander_shots_report.table(summary))
            self.assertTrue((directory/'commander-shots-v1.json').exists())


if __name__ == '__main__':
    unittest.main()
