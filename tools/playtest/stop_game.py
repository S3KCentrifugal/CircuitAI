#!/usr/bin/env python
"""Stop the playtest engine (and only it): python tools/playtest/stop_game.py [--dir C:\\bardev\\barb-playtest]

Kills the spring.exe processes whose command line names the playtest write
directory, plus the pid the launcher recorded. A game the user started from
the lobby runs on the install's data dir and is never touched.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import playtest  # noqa: E402

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--dir", default=str(playtest.DEFAULT_DIR))
    ap.add_argument("--role", default="TECH")
    playtest.stop(ap.parse_args())
