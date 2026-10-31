"""Terrain restore (owner 2026-10-31), one headless run.

Team 0 is SMRTBARb (experimental_balanced) at a TECH spot; team 1 is NullAI.
widgets/terrain_restore_fixture.lua supplies the damage only: a commander
self-destructs on a free metal spot near the AI's base (`--case bomb`), an
enemy silo nukes a point `--nuke-offset` elmos into the base (`--case nuke`),
or both. The AI finds and restores the ground itself; the fixture compares
each site with the engine's original heightmap (and the lava level on a lava
map such as Forge) and prints one `[RestoreTest] RESULT` line.

`--units` sets restore.units in the staged profile; `--t2 armack` gives the AI
a T2 constructor, so `--units t2 --t2 armack` proves T2 constructors restore.
"""
import argparse
import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--case', choices=['bomb', 'nuke', 'both'], default='both')
    p.add_argument('--units', default='commander,t1,rez', help='restore.units, comma separated (commander, t1, t2, rez)')
    p.add_argument('--t2', default='', help='give the AI this T2 constructor at the start (e.g. armack)')
    p.add_argument('--bomb', default='corcom', help='the unit that self-destructs on the metal spot')
    p.add_argument('--bomb-minute', type=float, default=1.5)
    p.add_argument('--nuke-minute', type=float, default=4.0)
    p.add_argument('--nuke-offset', type=int, default=900, help='elmos from the AI start toward the enemy')
    p.add_argument('--minutes', type=float, default=12)
    p.add_argument('--map', default='Forge')
    p.add_argument('--side', default='armada')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    spots = map_spots(a.map)
    west = next(s for s in spots[:len(spots) // 2] if s[2] == 'TECH')
    east = next(s for s in spots[len(spots) // 2:] if s[2] == 'TECH')
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false)\n')
    expect = [
        {'key': 'config', 'pattern': r'RESTORE: on units=', 'by_minute': 1, 'scope': 'any'},
        {'key': 'start', 'pattern': r'RESTORE: start ', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'done', 'pattern': r'RESTORE: done ', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'result', 'pattern': r'\[RestoreTest\] RESULT ', 'by_minute': a.minutes, 'scope': 'any'}]
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': expect,
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH', '--side', a.side,
                   '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=31031',
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/terrain_restore_fixture.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    fps = 30
    (d / 'LuaUI/Config/terrain_restore.lua').write_text(
        'return {case=%s, units=%s, t2=%s, bomb=%s, bombFrame=%d, nukeFrame=%d, nukeOffset=%d, radius=150, endFrame=%d}\n' % (
            json.dumps(a.case), json.dumps(a.units), json.dumps(a.t2), json.dumps(a.bomb),
            int(a.bomb_minute * 60 * fps), int(a.nuke_minute * 60 * fps), a.nuke_offset,
            int((a.minutes - 0.5) * 60 * fps)))
    # the unit classes under test
    staged = d / 'AI/Skirmish/BARbTest/test/config/experimental_balanced/behaviour.json'
    s = staged.read_text()
    key = '"units": ["commander", "t1", "rez"],  // add "t2" to send T2 constructors too'
    if s.count(key) != 1:
        raise ValueError('restore.units lever missing in ' + str(staged))
    units = ', '.join(json.dumps(u.strip()) for u in a.units.split(',') if u.strip())
    staged.write_text(s.replace(key, '"units": [%s],' % units))
    (d / 'scenario.json').write_text(json.dumps({'case': a.case, 'units': a.units, 't2': a.t2, 'bomb': a.bomb,
        'bomb_minute': a.bomb_minute, 'nuke_minute': a.nuke_minute, 'nuke_offset': a.nuke_offset,
        'dll': a.dll, 'map': a.map}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '25']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
