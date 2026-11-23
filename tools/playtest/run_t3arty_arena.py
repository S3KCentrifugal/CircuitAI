"""T3 artillery heavy-porc arena (owner 2026-11-23, test only): Daedalus + Myrmidons vs a Bastion, Persecutor,
Catalyst (tactical launcher) and Bertha, labs behind the porc. Adapted from run_daedalus_arena.py.
Original: Daedalus idle arena (owner 2026-11-21, test only): adapted from run_gantry_march.py.
Legion FRONT, 2 Daedalus at the gantry; host: 2 Annihilators ~1750 out, dragon's teeth,
Peewees + rez bots on hold position 700-900 from the gantry, a base far behind.
Original: Gantry march headless test (owner 2026-11-16, test only).

Catapults (corcat), Daedalus (legerailtank) and Myrmidons (legeallterrainmech)
idled near the gantry before going to the front. Full Metal Plate (flat).
Team 0: the AI under test (FRONT, cortex, isolated, experimental_balanced) gets
2 of each at its "gantry" by cheat give. Team 1: the host, a real player on its
own ally team; its units are destroyed and widgets/gantry_march_fixture.lua
gives it a porc line across the diagonal and an expensive base behind it.

--mode live : the AI has global LOS all game (identified base behind the porc)
--mode ghost: global LOS from 2 s to --los-off s, units given after it (ghosts only)
--mode blind: the AI never gets global LOS (only the start script)

Set CIRCUIT_RANGED_NO_MARCH=1 (--baseline) for the old behaviour with the same DLL.
The fixture writes TIMING/RESULT lines ([GantryMarch]); the AI writes RANGEDTIME lines.
"""
import os
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

MAP = 'Full Metal Plate 1.7'
HOST_START = (11800, 11800)
GANTRY = (2200, 1800)
UNITS = ['legerailtank', 'legerailtank', 'legeallterrainmech', 'legeallterrainmech', 'corcat', 'corcat']
# along the diagonal from the gantry toward the host: u = (0.707, 0.707), perpendicular v = (0.707, -0.707)
def at(along, side):
    return (GANTRY[0] + 0.7071 * (along + side), GANTRY[1] + 0.7071 * (along - side))
PORC = [('legbastion',) + tuple(int(c) for c in at(2300, 350)), ('cortoast',) + tuple(int(c) for c in at(2300, -350))]
OTHER_STATIC = [('cortron',) + tuple(int(c) for c in at(3000, 0)), ('armbrtha',) + tuple(int(c) for c in at(4800, 600)),
                ('corsilo',) + tuple(int(c) for c in at(4300, -900))]
DRAG = [('armdrag',) + tuple(int(c) for c in at(1600, s)) for s in range(-480, 481, 96)]
LABS = [('armvp',) + tuple(int(c) for c in at(2700, -100)), ('corvp',) + tuple(int(c) for c in at(2750, 250))]
MOBILES = ([('armpw',) + tuple(int(c) for c in at(900 + 60 * (i % 2), -300 + 120 * i)) for i in range(6)]
           + [('armrectr',) + tuple(int(c) for c in at(1050, -250 + 100 * i)) for i in range(4)])
BASE = [(['armfus', 'armalab', 'armavp', 'armfus'][j], 8600 + i * 420, 8600 + j * 420) for i in range(3) for j in range(4)]
PORC_DEFS = ['legbastion', 'cortoast']


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--mode', choices=['live', 'ghost', 'blind', 'radar'], required=True, help='radar: blind + an AI radar tower at the gantry (contacts past sight 750 are radar dots)')
    p.add_argument('--baseline', action='store_true', help='CIRCUIT_RANGED_NO_MARCH=1: the old controller, no march')
    p.add_argument('--watch-minutes', type=float, default=10, help='game minutes measured after the units are given')
    p.add_argument('--wall-minutes', type=float, default=30)
    p.add_argument('--los-off', type=int, default=90, help='ghost mode: game second global LOS goes off')
    p.add_argument('--speed', type=float, default=10)
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    os.environ["BAR_PLAYTEST_LOW_PRIORITY"] = "1"
    os.environ["CIRCUIT_RANGED_TRACE"] = "1"
    if a.baseline:
        os.environ["CIRCUIT_RANGED_NO_MARCH"] = "1"
    else:
        os.environ.pop("CIRCUIT_RANGED_NO_MARCH", None)
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    place_at = 300
    units_at = (a.los_off + 10) * 30 if a.mode == 'ghost' else 600
    minutes = units_at / 30 / 60 + a.watch_minutes + 0.5
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': minutes, 'expect': [
        {'key': 'observer', 'pattern': r'\[GantryMarch\] host team=', 'by_minute': 0.1, 'scope': 'any'},
        {'key': 'done', 'pattern': r'\[GantryMarch\] DONE', 'by_minute': minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', MAP,
                   '--map-file', str(ROOT / 'data/script/src/maps/full_metal_plate.as'),
                   '--role', 'FRONT', '--roles', 'FRONT', '--side', 'legion', '--isolated',
                   '--modoption', 'deathmode=neverend', '--modoption', 'allowunitcontrolwidgets=1',
                   '--ai-option', 'profile=experimental_balanced',
                   '--mode', 'fast', '--speed', str(a.speed), '--minutes', str(minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/daedalus_arena_fixture.lua'), '--extra-widget', str(HERE / 'widgets/t3arty_arena_watch.lua')]
    subprocess.run(stage, cwd=ROOT, check=True)
    script = d / 'script.txt'
    s = script.read_text(encoding='utf-8')
    m = re.search(r'\[PLAYER0\] \{ Name=Playtest; Spectator=1; Team=(\d+);', s)
    if not m:
        raise ValueError('host player line changed in script.txt')
    t = m.group(1)
    s = s.replace('Spectator=1; Team=%s;' % t, 'Spectator=0; Team=%s;' % t, 1)
    s, n = re.subn(r'(\[TEAM%s\] \{ AllyTeam=2; TeamLeader=0; Side=armada; RgbColor=[^;]*; )StartPosX=64; StartPosZ=64;' % t,
                   r'\g<1>StartPosX=%d; StartPosZ=%d;' % HOST_START, s)
    if n != 1:
        raise ValueError('host team line changed in script.txt')
    script.write_text(s, encoding='utf-8')
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    lua = lambda rows: '{' + ','.join('{"%s",%d,%d}' % r for r in rows) + '}'
    units = [(u, GANTRY[0] + 140 * i, GANTRY[1]) for i, u in enumerate(UNITS)]
    if a.mode == 'radar':
        units = units + [('legrad', GANTRY[0] - 300, GANTRY[1] - 300)]
    los_on = {'live': 60, 'ghost': 60, 'blind': None, 'radar': None}[a.mode]
    los_off = a.los_off * 30 if a.mode == 'ghost' else None
    conf = ('return {mode="%s", placeAt=%d, unitsAt=%d, watchSec=%d, losOnAt=%s, losOffAt=%s, porc=%s, base=%s, mobiles=%s, units=%s, '
            'unitDefs={%s}, porcDefs={%s}}\n') % (
        a.mode, place_at, units_at, int(a.watch_minutes * 60), los_on if los_on else 'nil', los_off if los_off else 'nil',
        lua(PORC), lua(BASE + DRAG + OTHER_STATIC + LABS), lua(MOBILES), lua(units), ''.join('%s=true,' % u for u in set(UNITS)), ''.join('%s=true,' % u for u in PORC_DEFS))
    (d / 'LuaUI/Config/gantry_march.lua').write_text(conf)
    (d / 'scenario.json').write_text(json.dumps({'dll': a.dll, 'map': MAP, 'mode': a.mode, 'baseline': a.baseline,
        'gantry': GANTRY, 'units': units, 'porc': PORC, 'other_static': OTHER_STATIC, 'labs': LABS, 'base': BASE, 'drag': DRAG, 'mobiles': MOBILES, 'units_at': units_at}, indent=2))
    if a.stage_only:
        return 0
    from playtest import running_pids
    watch = cmd + ['watch', '--dir', str(d), '--role', 'FRONT', '--checks', str(check),
                   '--minutes', str(minutes), '--wall-minutes', str(a.wall_minutes), '--stop-when-met', '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
