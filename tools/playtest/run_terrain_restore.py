"""Terrain restore (owner 2026-10-31), one headless run.

Team 0 is SMRTBARb (experimental_balanced) at a TECH spot; team 1 is NullAI.
widgets/terrain_restore_fixture.lua supplies the damage only, `--case` is a
comma list:
  bomb  a commander self-destructs on a free metal spot near the AI's base
  nuke  an enemy silo nukes a point `--nuke-offset` elmos into the base
  path  the silo nukes one point `--path-at` of the way along the lane between
        the starts, `--path-nukes` times (craters a Thor cannot climb)
  lava  the silo nukes low ground near the lane on a lava map (crater lava)
  both  bomb,nuke
The AI finds and restores the ground itself; the fixture compares each site
with the engine's original heightmap, the lava level, Thor passability and a
probe building's placement, and prints one `[RestoreTest] RESULT` line.

`--units` sets restore.units in the staged profile; `--give armrectr,armrectr`
gives the AI units at the start (`--t2 armack` is the same for one unit), so
`--units t1,rez --give armrectr,armrectr` proves rez bots go out.
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
    p.add_argument('--case', default='both', help='comma list of bomb, nuke, path, lava, both')
    p.add_argument('--units', default='commander,t1,rez', help='restore.units, comma separated (commander, t1, t2, rez)')
    p.add_argument('--t2', default='', help='give the AI this T2 constructor at the start (e.g. armack)')
    p.add_argument('--give', default='', help='comma list of units given to the AI at the start')
    p.add_argument('--path-at', type=float, default=0.45, help='fraction of the lane from the AI start for path/lava')
    p.add_argument('--path-nukes', type=int, default=2, help='missiles on the path point')
    p.add_argument('--nuke-gap', type=float, default=8, help='seconds between missiles')
    p.add_argument('--lava-band', type=float, default=30, help='lava case: original ground up to this far above the lava')
    p.add_argument('--probe', default='armfus', help='building tested for placement at each site')
    p.add_argument('--radius', type=int, default=150, help='fixture measuring radius around each site')
    p.add_argument('--bomb', default='corcom', help='the unit that self-destructs on the metal spot')
    p.add_argument('--bomb-minute', type=float, default=1.5)
    p.add_argument('--nuke-minute', type=float, default=4.0)
    p.add_argument('--nuke-offset', type=int, default=900, help='elmos from the AI start toward the enemy')
    p.add_argument('--minutes', type=float, default=12)
    p.add_argument('--map', default='Forge')
    p.add_argument('--side', default='armada')
    p.add_argument('--role', default='TECH', help='the AI role (FRONT sends the ground army down the lanes)')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    for c in a.case.split(','):
        if c not in ('bomb', 'nuke', 'path', 'lava', 'both'):
            p.error('unknown case ' + c)
    give = [u.strip() for u in a.give.split(',') if u.strip()] + ([a.t2] if a.t2 else [])
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    spots = map_spots(a.map)
    half = len(spots) // 2
    west = next((s for s in spots[:half] if s[2] == a.role), spots[0])
    east = next((s for s in spots[half:] if s[2] == a.role), spots[half])
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::{a.role}, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::{a.role}, false)\n')
    expect = [
        {'key': 'config', 'pattern': r'RESTORE: on units=', 'by_minute': 1, 'scope': 'any'},
        {'key': 'start', 'pattern': r'RESTORE: start ', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'done', 'pattern': r'RESTORE: done ', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'result', 'pattern': r'\[RestoreTest\] RESULT ', 'by_minute': a.minutes, 'scope': 'any'}]
    if 'path' in a.case or 'lava' in a.case:
        expect.append({'key': 'path', 'pattern': r'RESTORE: start .*reason=(path|lava)', 'by_minute': a.minutes, 'scope': 'any'})
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': expect,
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', a.role, '--roles', a.role, '--side', a.side,
                   '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=31031',
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/terrain_restore_fixture.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    fps = 30
    (d / 'LuaUI/Config/terrain_restore.lua').write_text(
        'return {case=%s, units=%s, give={%s}, bomb=%s, bombFrame=%d, nukeFrame=%d, nukeOffset=%d, radius=%d, endFrame=%d,'
        ' pathAt=%s, pathNukes=%d, nukeGap=%d, lavaBand=%s, probe=%s, thor="armthor"}\n' % (
            json.dumps(a.case), json.dumps(a.units), ', '.join(json.dumps(u) for u in give), json.dumps(a.bomb),
            int(a.bomb_minute * 60 * fps), int(a.nuke_minute * 60 * fps), a.nuke_offset, a.radius,
            int((a.minutes - 0.5) * 60 * fps), repr(a.path_at), a.path_nukes, int(a.nuke_gap * fps),
            repr(a.lava_band), json.dumps(a.probe)))
    # the unit classes under test
    staged = d / 'AI/Skirmish/BARbTest/test/config/experimental_balanced/behaviour.json'
    s = staged.read_text()
    key = '"units": ["commander", "t1", "rez"],  // add "t2" to send T2 constructors too'
    if s.count(key) != 1:
        raise ValueError('restore.units lever missing in ' + str(staged))
    units = ', '.join(json.dumps(u.strip()) for u in a.units.split(',') if u.strip())
    staged.write_text(s.replace(key, '"units": [%s],' % units))
    (d / 'scenario.json').write_text(json.dumps({'case': a.case, 'units': a.units, 'give': give, 'bomb': a.bomb,
        'path_at': a.path_at, 'path_nukes': a.path_nukes, 'probe': a.probe,
        'bomb_minute': a.bomb_minute, 'nuke_minute': a.nuke_minute, 'nuke_offset': a.nuke_offset,
        'dll': a.dll, 'map': a.map}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', a.role, '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '25']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
