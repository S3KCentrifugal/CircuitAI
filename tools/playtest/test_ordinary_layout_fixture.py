import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch
import prepare_ordinary_layout_check as fixture

class OrdinaryLayoutFixtureTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.base = self.root / "game"
        self.main = self.base / "AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as"
        self.main.parent.mkdir(parents=True)
        self.main.write_text("ArtilleryPolicy::Check();\nTeam::HandleMessage(msg, fromTeamId);\n", encoding="utf8")
        self.patch = patch.object(fixture, "RAW_ROOT", self.root)
        self.patch.start()
        self.addCleanup(self.patch.stop)

    def test_prepare_adds_read_only_observer_hooks(self):
        fixture.prepare(self.base)
        source = self.main.read_text(encoding="utf8")
        self.assertEqual(source.count("OrdinaryLayoutProbe::Tick();"), 1)
        self.assertEqual(source.count("OrdinaryLayoutProbe::Message(msg);"), 1)
        self.assertIn("namespace OrdinaryLayoutProbe", source)
        self.assertIn("ArtilleryPolicy::Check();", source)

    def test_prepare_rejects_duplicate_without_mutating(self):
        fixture.prepare(self.base)
        before = self.main.read_bytes()
        with self.assertRaises(ValueError):
            fixture.prepare(self.base)
        self.assertEqual(before, self.main.read_bytes())

    def test_prepare_rejects_path_outside_benchmark_store(self):
        with self.assertRaises(ValueError):
            fixture.prepare(self.root.parent)

if __name__ == "__main__":
    unittest.main()
