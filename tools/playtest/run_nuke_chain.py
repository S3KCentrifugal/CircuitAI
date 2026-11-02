"""Nuke chain-kill headless test (owner 2026-11-02, branch nuke-chain-kill, test only).

Full Metal Plate (flat). Team 0: the AI under test (FRONT, cortex), isolated;
widgets/nuke_chain_fixture.lua gives it a corsilo and the economy to stock it,
and full LOS (globallos 0). Team 1: the host, a real player on its own ally
team; its commander self-destructs and the fixture gives it the target
structures at exact coordinates. --layout A..G lets the AI choose its own aim
(the "NUCLEAR ... value=" line is its prediction); --layout F fires debug pos
strikes at probe rings to measure the blast falloff.
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
CENTRE = (8192, 6144)
# calibration: each shot a ring of probes (def, distance) spread evenly around the aim
CALIB = [
    {'x': 8000, 'z': 2000, 'probes': [('corafus', 300), ('corafus', 500), ('corafus', 700)]},
    {'x': 8000, 'z': 4600, 'probes': [('corafus', 400), ('corafus', 600), ('corafus', 800)]},
    {'x': 8000, 'z': 7200, 'probes': [('armfus', 300), ('armfus', 500), ('armfus', 700), ('armfus', 900)]},
    {'x': 8000, 'z': 9800, 'probes': [('armfus', 400), ('armfus', 600), ('armfus', 800), ('armfus', 1000)]},
    {'x': 10600, 'z': 3300, 'probes': [('armafus', 450), ('armafus', 600), ('armafus', 750)]},
    {'x': 10600, 'z': 8500, 'probes': [('legafus', 450), ('legafus', 600), ('legafus', 750)]},
]
# --calib-set 3: box-shaped defs probed along their diagonals (the box corner faces the blast)
CALIB3 = [
    {'x': 8000, 'z': 2500, 'probes': [('legafus', 430, 45), ('legafus', 500, 135), ('legafus', 600, 225), ('legafus', 700, 315)]},
    {'x': 8000, 'z': 6500, 'probes': [('armafus', 500, 45), ('armafus', 560, 135), ('armafus', 650, 225), ('armafus', 750, 315)]},
    {'x': 10600, 'z': 4500, 'probes': [('armfus', 700, 45), ('armfus', 760, 135), ('armfus', 850, 225), ('armfus', 950, 315)]},
]
# --calib-set 2: the remaining defs, cleaner (fewer silos, 90 s apart)
CALIB2 = [
    {'x': 8000, 'z': 2000, 'probes': [('legafus', 450), ('legafus', 600), ('legafus', 750)]},
    {'x': 8000, 'z': 5000, 'probes': [('corfus', 500), ('corfus', 700), ('corfus', 850)]},
    {'x': 8000, 'z': 8000, 'probes': [('corageo', 500), ('corageo', 700), ('corageo', 850)]},
    {'x': 10600, 'z': 3500, 'probes': [('corgeo', 700), ('corgeo', 850), ('corgeo', 950)]},
    {'x': 10600, 'z': 7000, 'probes': [('legafus', 500), ('legafus', 650), ('legafus', 800)]},
]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--layout', required=True, help='A..E, G (AI aims) or F (calibration)')
    p.add_argument('--minutes', type=float, default=None)
    p.add_argument('--wall-minutes', type=float, default=25)
    p.add_argument('--stage-only', action='store_true')
    p.add_argument('--calib-set', type=int, default=1)
    p.add_argument('--place-at', type=int, default=400, help='layout give frame (5100: about 20 s before the silo stocks)')
    p.add_argument('--stagger', type=int, default=60, help='seconds between the calibration silos')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    calib = a.layout.upper() == 'F'
    minutes = a.minutes or (20 if calib else 9)
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': minutes, 'expect': [
        {'key': 'done', 'pattern': r'\[NukeChain\] DONE', 'by_minute': minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', MAP,
                   '--map-file', str(ROOT / 'data/script/src/maps/full_metal_plate.as'),
                   '--role', 'FRONT', '--roles', 'FRONT', '--side', 'cortex', '--isolated',
                   '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced',
                   '--mode', 'fast', '--speed', '20', '--minutes', str(minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/nuke_chain_fixture.lua')]
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
    if calib:
        CAL = {2: CALIB2, 3: CALIB3}.get(a.calib_set, CALIB)
        shots = ',\n'.join('  {x=%d, z=%d, probes={%s}}' % (c['x'], c['z'], ','.join(('{"%s",%d,%d}' if len(pr) == 3 else '{"%s",%d}') % pr for pr in c['probes']))
                           for c in CAL)
        conf = 'return {mode="calib", aiStart={%d,%d}, timeoutMin=%d, silos=%d, siloStaggerSec=%d, stockSec=170, shots={\n%s}}\n' % (AI_START + (int(minutes), len(CAL), a.stagger) + (shots,))
    else:
        conf = 'return {mode="layout", layout="%s", cx=%d, cz=%d, aiStart={%d,%d}, timeoutMin=%d, placeAt=%d}\n' % (
            (a.layout.upper(),) + CENTRE + AI_START + (int(minutes), a.place_at))
    (d / 'LuaUI/Config/nuke_chain.lua').write_text(conf)
    (d / 'scenario.json').write_text(json.dumps({'dll': a.dll, 'map': MAP, 'layout': a.layout.upper(),
        'centre': CENTRE, 'ai_start': AI_START, 'host_start': HOST_START, 'calib': {2: CALIB2, 3: CALIB3}.get(a.calib_set, CALIB) if calib else None}, indent=2))
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
