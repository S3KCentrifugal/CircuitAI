"""FRONT nukes and the ally-team overnuke (owner 2026-11-01), one headless run.

Team 0 is SMRTBARb TECH, team 1 its allied SMRTBARb FRONT, the enemy NullAI
with a target cluster. widgets/front_nuke_fixture.lua gives TECH --tech-silos
silos and FRONT --front-silos silos (together at the overnuke breakpoint, each
alone below it), FRONT the income for its silo grid gate and two T2
constructors at --con-minute. Expected: one overnuke over all of them
("overnuke with N silos", the salvo stocked in every reaching silo), and FRONT's
grid orders its next silo only from 35:00.
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
    p.add_argument('--tech-silos', type=int, default=2)
    p.add_argument('--front-silos', type=int, default=1)
    p.add_argument('--salvo', type=int, default=3, help='pinned overnuke roll')
    p.add_argument('--front-afus', type=int, default=5)
    p.add_argument('--front-conv', type=int, default=20)
    p.add_argument('--con-minute', type=int, default=30)
    p.add_argument('--minutes', type=float, default=38)
    p.add_argument('--map', default='Supreme Isthmus v1.7')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    silos = a.tech_silos + a.front_silos
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    spots = map_spots(a.map, ROOT / 'data/script/src/maps/supreme_isthmus_v1_7.as')
    half = len(spots) // 2
    west = next(s for s in spots[:half] if s[2] == 'TECH')
    westf = next(s for s in spots[:half] if s[2] == 'FRONT')
    east = next(s for s in spots[half:] if s[2] == 'TECH')
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                       f'StartSpot(AIFloat3({westf[0]},0,{westf[1]}), AiRole::FRONT, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false)\n')
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': [
        {'key': 'shared', 'pattern': r'NUKE: overnuke with %d silos' % silos, 'by_minute': 6, 'scope': 'any'},
        {'key': 'released', 'pattern': r'NUKE: overnuke salvo released .* in %d silos' % silos, 'by_minute': 20, 'scope': 'any'},
        {'key': 'grid', 'pattern': r'\[FRONT\]\[SiloGrid\] silo \d+ of 8', 'by_minute': a.minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH,FRONT', '--ally-spots', '1,2',
                   '--side', 'armada', '--others', 'test', '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'ai_incomemultiplier=1', '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=22901',
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/front_nuke_fixture.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/front_nuke.lua').write_text(
        'return {techSilos=%d, frontSilos=%d, frontAfus=%d, frontConv=%d, conMinute=%d}\n'
        % (a.tech_silos, a.front_silos, a.front_afus, a.front_conv, a.con_minute))
    staged = d / 'AI/Skirmish/BARbTest/test/config/experimental_balanced/behaviour.json'
    s = staged.read_text()
    for key in ('"overnuke_min": 10', '"overnuke_max": 25'):
        if s.count(key) != 1:
            raise ValueError('overnuke roll lever missing in ' + str(staged))
    s = s.replace('"overnuke_min": 10', '"overnuke_min": %d' % a.salvo).replace('"overnuke_max": 25', '"overnuke_max": %d' % a.salvo)
    s = s.replace('"overnuke_team_min": 15', '"overnuke_team_min": %d' % a.salvo).replace('"overnuke_team_max": 30', '"overnuke_team_max": %d' % a.salvo)
    staged.write_text(s)
    (d / 'scenario.json').write_text(json.dumps(vars(a) | {'data': str(a.data)}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '40']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
