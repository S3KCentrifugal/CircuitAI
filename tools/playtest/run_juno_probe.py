"""Juno probing-shot headless test (owner 2026-11-03, test only).

Full Metal Plate (flat). Team 0: the AI under test (FRONT, armada, isolated,
experimental_balanced). Team 1: the host on its own ally team; its commander
self-destructs and widgets/juno_probe_fixture.lua gives it a Veil jammer over
two LLTs, a Beamer and an HLT. The AI has global LOS only while the porc is placed,
and the Veil is given after LOS goes off (never seen), so the cluster is a set of
jammed ghost images with no known jammer inside the radar tower it is given
(placed again --recycle seconds after it all died), with LLT/Beamer porc about 900 from the cluster.
--mode juno: the AI also gets a Juno (probing shot).
--mode group: the AI gets 5 AFUS and 12 T2 converters instead (commander-group
probe Juno: 45 metal/s, 1200 energy/s).
Report: PROBE / juno_probe / PULSE ... probe line counts, no script errors.
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
HOST_START = (11800, 11800)
CLUSTER = (4300, 3400)
JAMMED = [('armveil', 0, 0), ('armllt', 150, 0), ('armllt', -150, 0), ('armbeamer', 0, 150), ('armhlt', 0, -150)]
OURS = [('armrad', 3500, 2700), ('armllt', 3600, 2850), ('armllt', 3700, 2750), ('armbeamer', 3650, 2800)]
JUNO = [('armjuno', 2200, 1600)]
ECO = [('armafus', 600 + 300 * i, 2200) for i in range(5)] + \
      [('armmmkr', 600 + 150 * (i % 8), 2550 + 150 * (i // 8)) for i in range(12)]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--mode', choices=['juno', 'group'], required=True)
    p.add_argument('--minutes', type=float, default=26)
    p.add_argument('--wall-minutes', type=float, default=40)
    p.add_argument('--protect', action='store_true', help='heal the cluster porc to full on every hit, so it lives until a probe pulse')
    p.add_argument('--recycle', type=int, default=60, help='game seconds after the whole cluster died before it is placed again')
    p.add_argument('--stage-only', action='store_true')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    minutes = a.minutes
    check = d / 'checks.json'
    check.write_text(json.dumps({'stop_minute': minutes, 'expect': [
        {'key': 'probe', 'pattern': r'PROBE: clusters=[1-9]', 'by_minute': minutes, 'scope': 'any'}],
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(a.data), '--map', MAP,
                   '--map-file', str(ROOT / 'data/script/src/maps/full_metal_plate.as'),
                   '--role', 'FRONT', '--roles', 'FRONT', '--side', 'armada', '--isolated',
                   '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced',
                   '--mode', 'fast', '--speed', '20', '--minutes', str(minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / 'widgets/juno_probe_fixture.lua')]
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
    ours = OURS + (JUNO if a.mode == 'juno' else ECO)
    (d / 'LuaUI/Config/juno_probe.lua').write_text('return {mode="%s", cx=%d, cz=%d, cluster=%s, ours=%s, jammer="armveil", protect=%s, recycleSec=%d, timeoutMin=%d}\n' % (
        a.mode, CLUSTER[0], CLUSTER[1], lua(JAMMED), lua(ours), 'true' if a.protect else 'false', a.recycle, int(minutes)))
    (d / 'scenario.json').write_text(json.dumps({'dll': a.dll, 'map': MAP, 'mode': a.mode, 'cluster': CLUSTER,
        'jammed': JAMMED, 'ours': ours}, indent=2))
    if a.stage_only:
        return 0
    from playtest import running_pids
    watch = cmd + ['watch', '--dir', str(d), '--role', 'FRONT', '--checks', str(check),
                   '--minutes', str(minutes), '--wall-minutes', str(a.wall_minutes), '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
