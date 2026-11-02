"""FRONT T3 gantry production (owner 2026-11-01), one headless run.

Team 0 is SMRTBARb TECH, team 1 its allied SMRTBARb FRONT, the enemy NullAI.
widgets/front_gantry_fixture.lua gives FRONT the income for heavies and, at
--gantry-minute, a finished gantry of its side. Expected: FRONT orders its
first heavy ("[FRONT][Gantry] gantry=... unit=...") and the gantry finishes
products. --set Front.GantryHeavies=false --expect-none is the old native
picker (on Carrot Mountains 2026-11-01 it never built a unit).
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
    p.add_argument('--side', default='armada')
    p.add_argument('--gantry-minute', type=int, default=3)
    p.add_argument('--minutes', type=float, default=12)
    p.add_argument('--map', default='Supreme Isthmus v1.7')
    p.add_argument('--map-as', default='supreme_isthmus_v1_7.as')
    p.add_argument('--set', action='append', default=[], help='role setting override, e.g. Front.GantryHeavies=false')
    p.add_argument('--expect-none', action='store_true', help='pass when FRONT orders no heavy (the baseline)')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    spots = map_spots(a.map, ROOT / 'data/script/src/maps' / a.map_as)
    half = len(spots) // 2
    west = next(s for s in spots[:half] if s[2] == 'TECH')
    westf = next(s for s in spots[:half] if s[2] == 'FRONT')
    east = next(s for s in spots[half:] if s[2] == 'TECH')
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                       f'StartSpot(AIFloat3({westf[0]},0,{westf[1]}), AiRole::FRONT, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false)\n')
    ordered = {'key': 'ordered', 'pattern': r'\[FRONT\]\[Gantry\] gantry=', 'scope': 'any'}
    built = {'key': 'built', 'pattern': r'\[FrontGantryTest\] finished team=1 ', 'scope': 'any'}
    checks = {'stop_minute': a.minutes,
              'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}
    if a.expect_none:
        checks['forbid'] += [ordered, built]
        checks['expect'] = [{'key': 'given', 'pattern': r'\[FrontGantryTest\] gantry given', 'by_minute': a.gantry_minute + 1, 'scope': 'any'}]
    else:
        checks['expect'] = [ordered | {'by_minute': a.gantry_minute + 1}, built | {'by_minute': a.minutes}]
    check = d / 'checks.json'
    check.write_text(json.dumps(checks, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH,FRONT', '--ally-spots', '1,2',
                   '--side', a.side, '--others', 'test', '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'ai_incomemultiplier=1', '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=22901',
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/front_gantry_fixture.lua')] + [x for kv in a.set for x in ('--set', kv)]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/front_gantry.lua').write_text('return {gantryMinute=%d}\n' % a.gantry_minute)
    (d / 'scenario.json').write_text(json.dumps(vars(a) | {'data': str(a.data)}, indent=2))
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '30', '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
