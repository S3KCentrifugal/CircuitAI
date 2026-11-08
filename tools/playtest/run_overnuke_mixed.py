"""Mixed-faction overnuke (owner 2026-11-08), one headless run.

Three allied SMRTBARb AIs - TECH (Legion), AIR (Armada) and FRONT (Cortex) -
against a NullAI with three structure clusters. widgets/overnuke_mixed_fixture.lua
gives each AI the silo of its own faction (Supernova, Armageddon, Apocalypse) at
staggered minutes (--plan), and the income to stock them. Expected: once the
third silo stands, one overnuke over all of them ("overnuke with N silos"), the
salvo stocked across every AI's silos, and every launch from then on at the one
shared target. analyze_overnuke_mixed.py reads the infolog afterwards.

--plan is ally:minute:count[:unitname], comma separated; ally 1 = TECH, 2 = AIR,
3 = FRONT. Default 1:0.5:1,2:2:1,3:4:1 (one silo each, the third at 4:00).
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def parse_plan(s):
    out = []
    for item in s.split(','):
        f = item.split(':')
        out.append((int(f[0]), float(f[1]), int(f[2]), f[3] if len(f) > 3 else None))
    return out


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--plan', default='1:0.5:1,2:2:1,3:4:1')
    p.add_argument('--salvo', type=int, default=0, help='pin the overnuke roll (0: the profile roll 6..11)')
    p.add_argument('--minutes', type=float, default=26)
    p.add_argument('--map', default='Supreme Isthmus v1.7')
    p.add_argument('--seed', default='22901')
    p.add_argument('--refill', action='store_true', help='five enemy clusters, each re-given once destroyed')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    plan = parse_plan(a.plan)
    silos = sum(c for _, _, c, _ in plan)
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    spots = map_spots(a.map, ROOT / 'data/script/src/maps/supreme_isthmus_v1_7.as')
    half = len(spots) // 2
    pick = lambda side, role: next(s for s in side if s[2] == role)
    west, east = spots[:half], spots[half:]
    chosen = [pick(west, 'TECH'), pick(west, 'AIR'), pick(west, 'FRONT'), pick(east, 'TECH')]
    mapfile = d / 'selection.as'
    mapfile.write_text(',\n'.join(f'StartSpot(AIFloat3({s[0]},0,{s[1]}), AiRole::{s[2]}, false)' for s in chosen) + '\n')
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': [
        {'key': 'shared', 'pattern': r'NUKE: overnuke with \d+ silos', 'by_minute': a.minutes, 'scope': 'any'},
        {'key': 'released', 'pattern': r'NUKE: overnuke salvo released', 'by_minute': a.minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', a.map,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH,AIR,FRONT', '--ally-spots', '1,2,3',
                   '--side', 'legion', '--others', 'test', '--enemies', 'prod', '--prod-ai', 'NullAI', '--prod-version', '0.1',
                   '--modoption', 'ai_incomemultiplier=1', '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=' + a.seed,
                   '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/overnuke_mixed_fixture.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    lua_plan = ','.join('{%d,%g,%d%s}' % (al, mi, c, (',"%s"' % u) if u else '') for al, mi, c, u in plan)
    (d / 'LuaUI/Config/overnuke_mixed.lua').write_text('return {plan={%s},refill=%s}\n' % (lua_plan, 'true' if a.refill else 'false'))
    if a.salvo > 0:
        staged = d / 'AI/Skirmish/BARbTest/test/config/experimental_balanced/behaviour.json'
        s = staged.read_text()
        for key in ('"overnuke_min": ', '"overnuke_max": '):
            if s.count(key) != 1:
                raise ValueError('overnuke roll lever missing in ' + str(staged))
        s = re.sub(r'"overnuke_(team_|tier3_)?(min|max)": \d+',
                   lambda m: '"overnuke_%s%s": %d' % (m.group(1) or '', m.group(2), a.salvo), s)
        staged.write_text(s)
    # Only the nukes are under test: the AIs' factories stay idle, so no army
    # walks into the enemy clusters (a silo never fires at ground holding a friend).
    factory = d / 'AI/Skirmish/BARbTest/test/script/src/manager/factory.as'
    s = factory.read_text(); marker = 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)\n\t{'
    if s.count(marker) != 1:
        raise ValueError('factory hook changed')
    factory.write_text(s.replace(marker, marker + '\n\t\tif (u !is null) return null;  // mixed overnuke fixture: no production', 1))
    (d / 'scenario.json').write_text(json.dumps(vars(a) | {'data': str(a.data), 'dir': str(d), 'silos': silos}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', '40', '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
