"""Overnuke salvo vs an antinuke ring (owner 2026-10-30), one headless run.

Team 0 is SMRTBARb (TECH, Armada) given `silos` nuclear silos and the income
to stock them; its overnuke roll is pinned to `--salvo`. Team 1 is NullAI given
a target cluster ringed by `--antis` antinukes. The AI stocks and fires the
salvo itself; widgets/overnuke_salvo_fixture.lua follows every missile and
prints one `[SalvoTest] RESULT` line.
"""
import argparse
import json
import math
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
    p.add_argument('--salvo', type=int, required=True)
    p.add_argument('--antis', type=int, required=True)
    p.add_argument('--silos', type=int, default=0, help='0: max(3, ceil(salvo / 7)), what 15 minutes of stocking fills')
    p.add_argument('--minutes', type=float, default=32)
    p.add_argument('--look-minute', type=float, default=1, help='minute the AI first sees the target: later lets the antinukes stock up')
    p.add_argument('--map', default='Supreme Isthmus v1.7')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    silos = a.silos or max(3, math.ceil(a.salvo / 7))
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    map_source = ROOT / 'data/script/src/maps/supreme_isthmus_v1_7.as' if a.map == 'Supreme Isthmus v1.7' else None
    spots = map_spots(a.map, map_source)
    west = next(s for s in spots[:len(spots) // 2] if s[2] == 'TECH')
    east = next(s for s in spots[len(spots) // 2:] if s[2] == 'TECH')
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false)\n')
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': [
        {'key': 'stocking', 'pattern': r'NUKE: overnuke with \d+ silos .*stocking the salvo first', 'by_minute': a.look_minute + 5, 'scope': 'any'},
        {'key': 'released', 'pattern': r'NUKE: overnuke salvo released', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'result', 'pattern': r'\[SalvoTest\] RESULT ', 'by_minute': a.minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH', '--side', 'armada',
                   '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'ai_incomemultiplier=1', '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=22901',
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/overnuke_salvo_fixture.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/overnuke_salvo.lua').write_text(
        'return {salvo=%d, silos=%d, antis=%d, look=%d}\n' % (a.salvo, silos, a.antis, int(a.look_minute * 1800)))
    # pin the roll to the salvo under test
    staged = d / 'AI/Skirmish/BARbTest/test/config/experimental_balanced/behaviour.json'
    s = staged.read_text()
    for key in ('"overnuke_min": 10', '"overnuke_max": 25'):
        if s.count(key) != 1:
            raise ValueError('overnuke roll lever missing in ' + str(staged))
    s = s.replace('"overnuke_min": 10', '"overnuke_min": %d' % a.salvo).replace('"overnuke_max": 25', '"overnuke_max": %d' % a.salvo)
    # the team breakpoint (8+ silos across the allied AIs) has its own roll: pin it too
    s = s.replace('"overnuke_team_min": 15', '"overnuke_team_min": %d' % a.salvo).replace('"overnuke_team_max": 30', '"overnuke_team_max": %d' % a.salvo)
    staged.write_text(s)
    # Only the nuke matchup is under test: the AI's factories stay idle, so no
    # army reaches the defender's antinukes before the salvo.
    factory = d / 'AI/Skirmish/BARbTest/test/script/src/manager/factory.as'
    s = factory.read_text(); marker = 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)\n\t{'
    if s.count(marker) != 1:
        raise ValueError('factory hook changed')
    factory.write_text(s.replace(marker, marker + '\n\t\tif (u !is null) return null;  // salvo fixture: no production (a bare return is unreachable-code, an error)', 1))
    (d / 'scenario.json').write_text(json.dumps({'salvo': a.salvo, 'silos': silos, 'antis': a.antis,
        'dll': a.dll, 'map': a.map, 'supplied': 'silos, 6 AFUS, 8 converters (team 0); 4 AFUS, 6 converters, antinuke ring r=650 (team 1, NullAI)'}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '25', '--stop-when-met']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
