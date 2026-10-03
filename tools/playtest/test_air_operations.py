"""Regression tests for evidence boundaries and independent AIR attribution."""
import tempfile
import unittest
from pathlib import Path

from analyze_air_natural import analyze as natural
from analyze_air_operations import analyze as combat


class AirEvidenceTests(unittest.TestCase):
    def log(self, folder, lines):
        path = Path(folder)/"infolog.txt"
        path.write_text("\n".join(lines)+"\n", encoding="utf-8")
        return path

    def test_shutdown_overrun_cannot_inflate_bomber_kills(self):
        with tempfile.TemporaryDirectory() as folder:
            path = self.log(folder, [
                "[f=0000030] [AirArena] event=spawn id=7 unit=armpnix",
                "[f=0000060] [AirArena] event=death id=8 unit=armafus team=1 attackerTeam=0 attacker=7",
                "[f=0000090] [AirArena] event=death id=9 unit=armafus team=1 attackerTeam=0 attacker=7"])
            self.assertEqual(combat(path, 60)["strategic_last_hit_kills"], 1)

    def test_fighter_last_hits_are_not_credited_to_bombers(self):
        with tempfile.TemporaryDirectory() as folder:
            path = self.log(folder, [
                "[f=0000030] [AirArena] event=spawn id=7 unit=armhawk",
                "[f=0000060] [AirArena] event=death id=8 unit=armafus team=1 attackerTeam=0 attacker=7"])
            self.assertEqual(combat(path)["strategic_last_hit_kills"], 0)

    def test_independent_air_observer_failure_is_not_lost_without_ai_tag(self):
        with tempfile.TemporaryDirectory() as folder:
            path = self.log(folder, [
                "[f=0000030] [INVARIANT] INV-079 AIR observer: commander ordered mex",
                "[f=0000060] :::AI LOG:S:1:T:1:F:60:L::[INVARIANT] INV-008 TECH"])
            result = natural(path, [{"team": 0, "side": "armada", "role": "AIR"},
                                    {"team": 1, "side": "cortex", "role": "TECH"}])
            self.assertEqual(result["air_observer_invariants"], {"INV-079": 1})
            self.assertEqual(result["all_invariants"], {"INV-079": 1, "INV-008": 1})
            self.assertEqual(result["air"]["0"]["invariants"], {})

    def test_team_zero_completion_cannot_invent_enemy_air_milestones(self):
        with tempfile.TemporaryDirectory() as folder:
            path = self.log(folder, ["[f=0001800] [AirWatch] finished id=7 def=armaap"])
            result = natural(path, [{"team": 0, "side": "armada", "role": "AIR"},
                                    {"team": 1, "side": "cortex", "role": "AIR"}])
            self.assertEqual(result["air"]["0"]["first"]["t2_lab"], 1)
            self.assertEqual(result["air"]["1"]["first"], {})

    def test_command_observer_failure_is_retained_by_both_auditors(self):
        with tempfile.TemporaryDirectory() as folder:
            path = self.log(folder, ["[f=0001800] [AirOrders] ERROR observer_replaced"])
            self.assertEqual(len(combat(path)["violations"]), 1)
            self.assertEqual(len(natural(path, [])["errors"]), 1)


if __name__ == "__main__":
    unittest.main()
