"""Reuse the amphibious harness for a separately labelled Tundra naval-retreat probe."""
import argparse
import json
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--dir', type=Path, required=True)
p.add_argument('--dll', required=True)
a = p.parse_args()
base = a.dir.resolve()
if not base.is_relative_to(ROOT / 'build-theatres'):
    p.error('Use repository build-theatres')
subprocess.run([sys.executable, str(ROOT / 'tools/playtest/prepare_amphibious_check.py'),
    '--map', 'tundra', '--dir', str(base), '--dll', a.dll,
    '--windowed', '--speed', '8', '--minutes', '12'], check=True)
widgets = base / 'LuaUI/Widgets'
# Replace only this isolated run's injection and camera widgets.
shutil.copy2(ROOT / 'tools/playtest/widgets/telchine_shore_fixture.lua', widgets / 'amphibious_fixture.lua')
(widgets / 'amphibious_visual.lua').unlink()
shutil.copy2(ROOT / 'tools/playtest/widgets/telchine_match_watch.lua', widgets / 'telchine_match_watch.lua')
config = base / 'LuaUI/Config'
(config / 'telchine_observer.lua').write_text('return {controlled=true}\n')
(config / 'telchine_speed.txt').write_text('8\n')
(base / 'shore-probe.txt').write_text(
    'Controlled naval retreat probe: 6 gifted TECH Telchines, frozen builders and production, '
    'global LOS, spectator godmode for order permission; fixture orders only enemy team 2.\n')
(base / 'amphibious-fixture.json').write_text(json.dumps({
    'fixture': 'telchine_shore', 'controlled': True, 'injected_telchines': 6,
    'role': 'TECH', 'global_los': True, 'godmode': 3,
    'ordered_teams': [2], 'autonomous_builders': False,
    'natural_production': False, 'deathmode': 'neverend'}, indent=2) + '\n')
print(base)
