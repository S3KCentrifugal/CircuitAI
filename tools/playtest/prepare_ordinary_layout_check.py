"""Add the read-only ordinary-placement observer to an isolated balanced game."""
import argparse
from pathlib import Path
from benchmark_store import RAW_ROOT

ROOT = Path(__file__).resolve().parents[2]

def prepare(directory):
    base = Path(directory).resolve()
    if not base.is_relative_to(RAW_ROOT.resolve()):
        raise ValueError("Fixture must be inside the external benchmark build-theatres directory")
    path = base / "AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as"
    source = path.read_text(encoding="utf8")
    tick = "ArtilleryPolicy::Check();"
    message = "Team::HandleMessage(msg, fromTeamId);"
    if source.count(tick) != 1 or source.count(message) != 1 or "OrdinaryLayoutProbe" in source:
        raise ValueError("Expected unmodified balanced observer hooks")
    source = source.replace(tick, tick + "\n        OrdinaryLayoutProbe::Tick();")
    source = source.replace(message, message + "\n        OrdinaryLayoutProbe::Message(msg);")
    path.write_text(source + "\n" + (ROOT / "tools/playtest/ordinary_layout_probe.as").read_text(encoding="utf8"), encoding="utf8")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dir", required=True, type=Path)
    prepare(parser.parse_args().dir)
