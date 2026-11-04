"""Drone AA headless test (owner 2026-11-04, test only).

Full Metal Plate (flat, metal everywhere). Team 0: the AI under test (FRONT,
isolated, experimental_balanced, --side armada/cortex/legion). It gets a lab,
a solar, a mex and a T1 constructor at SITE by cheat give, about 850 from the
Hive. Team 1: the host, a real player on its own ally team; its commander
self-destructs and widgets/drone_aa_fixture.lua gives it a finished Legion
Hive (leghive), one gun porc between the Hive and SITE, and an energy plant in
its own corner so the Hive can restock drones.
Pass: no script errors; read the "[DroneAA]" AI lines and the fixture's
"[DroneAAFix] AA created/finished/builder", "builder IN porc reach" and RESULT
lines (2 light AA towers next to the struck structure, outside the porc's
reach + cover_margin, no third tower).
"""
import argparse
import json
import math
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

MAP = 'Full Metal Plate 1.7'
HOST_START = (11800, 11800)
SITE = (2400, 1700)              # the AI's given structures, ~1000 from its start (1536,768)
HIVE_DIST = 850                  # Hive -> SITE, along +x+z (away from the AI)
PORC = {'leglht': 430, 'legmg': 575, 'corllt': 430, 'armllt': 430}
SIDE_UNITS = {'armada': ('armlab', 'armsolar', 'armmex', 'armck'),
              'cortex': ('corlab', 'corsolar', 'cormex', 'corck'),
              'legion': ('leglab', 'legsolar', 'legmex', 'legck')}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--side', choices=sorted(SIDE_UNITS), default='cortex')
    p.add_argument('--porc', choices=sorted(PORC), default='leglht')
    p.add_argument('--porc-from-hive', type=int, default=150, help='porc distance from the Hive toward SITE')
    p.add_argument('--los', action='store_true', help='global LOS for the AI from frame 60: the Hive is a seen (identified) carrier before its drones arrive')
    p.add_argument('--minutes', type=float, default=7)
    p.add_argument('--wall-minutes', type=float, default=20)
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': [
        {'key': 'done', 'pattern': r'\[DroneAAFix\] DONE', 'by_minute': a.minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception|\[INVARIANT\]', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', MAP,
                   '--map-file', str(ROOT / 'data/script/src/maps/full_metal_plate.as'),
                   '--role', 'FRONT', '--roles', 'FRONT', '--side', a.side, '--isolated',
                   '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced',
                   '--mode', 'fast', '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/drone_aa_fixture.lua')]
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
    u = math.sqrt(0.5)
    hive = (SITE[0] + HIVE_DIST * u, SITE[1] + HIVE_DIST * u)
    porc = (hive[0] - a.porc_from_hive * u, hive[1] - a.porc_from_hive * u)
    lab, solar, mex, con = SIDE_UNITS[a.side]
    ai = [(lab, 0, 0), (solar, -200, 60), (mex, 60, -200), (con, -260, -260)]
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    lua = lambda rows: '{' + ','.join('{"%s",%d,%d}' % r for r in rows) + '}'
    conf = ('return {side="%s", sx=%d, sz=%d, hx=%d, hz=%d, porc="%s", px=%d, pz=%d, porcRange=%d, ai=%s, '
            'power={{"armafus",%d,%d}}, aiLos=%s, aiAt=240, hiveAt=450, timeoutMin=%s}\n') % (
        a.side, SITE[0], SITE[1], hive[0], hive[1], a.porc, porc[0], porc[1], PORC[a.porc], lua(ai),
        HOST_START[0] - 300, HOST_START[1] - 300, 'true' if a.los else 'false', a.minutes - 0.2)
    (d / 'LuaUI/Config/drone_aa.lua').write_text(conf)
    (d / 'scenario.json').write_text(json.dumps({'dll': a.dll, 'map': MAP, 'side': a.side, 'site': SITE, 'hive': hive,
        'los': a.los, 'porc': a.porc, 'porc_at': porc, 'porc_range': PORC[a.porc], 'ai': ai}, indent=2))
    if a.stage_only:
        return 0
    from playtest import running_pids
    watch = cmd + ['watch', '--dir', str(d), '--role', 'FRONT', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', str(a.wall_minutes), '--stop-when-met', '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
