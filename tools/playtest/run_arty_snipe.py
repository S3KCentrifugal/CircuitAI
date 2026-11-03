"""Artillery snipe headless test (owner 2026-11-03, test only).

Full Metal Plate (flat). Team 0: the AI under test (FRONT, cortex, isolated,
experimental_balanced) gets Thanatos, Arbiter, Boreas, Negotiator and
Ambassador artillery by cheat give. Team 1: the host, a real player on its own
ally team; its commander self-destructs and widgets/arty_snipe_fixture.lua
gives it a Persecutor (cortoast) ringed by Bulwark, Pulsar, HLT and Twin Guard.
--mode seen: the AI has global LOS all game. --mode ghost: global LOS only
until --los-off seconds, so the cluster is a set of ghost images after that.
Pass: "CONFIG ... artillery snipe enabled", SNIPE start/prep/fired/done lines,
no script errors; the RESULT line says whether the Persecutor died and which
artillery died to what.
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

MAP = 'Full Metal Plate 1.7'
AI_START = (1536, 768)
HOST_START = (11800, 11800)
CLUSTER = (6800, 5200)
ARTY_AT = (3400, 2600)
# ghost mode: given after LOS goes off, about 2100 from the Persecutor (inside its reach + trigger_distance),
# because the native controller does not walk artillery toward ghost-only targets from far away
ARTY_NEAR = (CLUSTER[0] - 1500, CLUSTER[1] - 1500)
PORC = [('cortoast', 0, 0), ('cordoom', -260, -260), ('armanni', -260, 260), ('corhlt', -420, 0),
        ('corhllt', -330, 140), ('corhllt', -330, -140), ('armhlt', 0, -380), ('armhlt', 0, 380)]
ARTY = [('leghrk', 0, 0), ('leghrk', 80, 0), ('corhrk', 0, 80), ('corhrk', 80, 80), ('legavroc', 160, 0),
        ('corvroc', 160, 80), ('armmerl', 0, 160), ('armmerl', 80, 160)]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--mode', choices=['seen', 'ghost'], required=True)
    p.add_argument('--minutes', type=float, default=10)
    p.add_argument('--wall-minutes', type=float, default=25)
    p.add_argument('--los-off', type=int, default=25, help='ghost mode: game seconds when global LOS goes off')
    p.add_argument('--extra', default='', help='host units at absolute spots, "def,x,z;def,x,z" (e.g. a parked commander or Tremor for the artillery_commander priority)')
    p.add_argument('--damage', default='', help='pre-damage host porc, "def:healthPct,..." (e.g. cortoast:18,armanni:20; BAR dev sethealth, cheats on)')
    p.add_argument('--pulsar-offset', default='', help='"dx,dz": the Pulsar (armanni) moved to this offset from the Persecutor (e.g. -1131,1131 for a ~0.3 half-disc share)')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    minutes = a.minutes
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': minutes, 'expect': [
        {'key': 'done', 'pattern': r'\[ArtySnipe\] DONE', 'by_minute': minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', MAP,
                   '--map-file', str(ROOT / 'data/script/src/maps/full_metal_plate.as'),
                   '--role', 'FRONT', '--roles', 'FRONT', '--side', 'cortex', '--isolated',
                   '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced',
                   '--mode', 'fast', '--speed', '20', '--minutes', str(minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/arty_snipe_fixture.lua')]
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
    porc = PORC
    if a.pulsar_offset:
        dx, dz = (int(v) for v in a.pulsar_offset.split(','))
        porc = [('armanni', dx, dz) if r[0] == 'armanni' else r for r in PORC]
    lua = lambda rows: '{' + ','.join('{"%s",%d,%d}' % r for r in rows) + '}'
    defs = '{' + ','.join('%s=true' % r[0] for r in ARTY) + '}'
    extra = [tuple(int(v) if i else v for i, v in enumerate(e.split(','))) for e in a.extra.split(';') if e]
    ghost = a.mode == 'ghost'
    at = ARTY_NEAR if ghost else ARTY_AT
    conf = ('return {mode="%s", cx=%d, cz=%d, ax=%d, az=%d, porc=%s, arty=%s, artyDefs=%s, placeAt=300, artyAt=%d, '
            'losOnAt=60, extra=%s, extraDefs=%s, damage=%s, %stimeoutMin=%d, afterKill=60}\n') % (
        a.mode, CLUSTER[0], CLUSTER[1], at[0], at[1], lua(porc), lua(ARTY), defs, a.los_off * 30 + 60 if ghost else 360, lua(extra), '{' + ''.join('%s=true,' % e[0] for e in extra) + '}',
        '{' + ''.join('%s=%s,' % tuple(kv.split(':')) for kv in a.damage.split(',') if kv) + '}',
        ('losOffAt=%d, ' % (a.los_off * 30)) if a.mode == 'ghost' else '', int(minutes))
    (d / 'LuaUI/Config/arty_snipe.lua').write_text(conf)
    (d / 'scenario.json').write_text(json.dumps({'dll': a.dll, 'map': MAP, 'mode': a.mode, 'cluster': CLUSTER,
        'arty_at': at, 'porc': porc, 'arty': ARTY}, indent=2))
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
