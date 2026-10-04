"""Audit confirmed strategic launches independently of target-selection logging."""
import argparse
import json
import re
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('log', type=Path)
parser.add_argument('--scenario', choices=['juno', 'nuclear'], required=True)
args = parser.parse_args()
shots, ranks, failures, drops, radii = [], [], [], 0, {}
for line in args.log.open(encoding='utf-8', errors='replace'):
    frame = re.search(r'\[f=(\d+)\]', line)
    if not frame:
        continue
    frame = int(frame[1])
    weapon = re.search(r'StrategicFixture.*weapon=\w+ id=(\d+).*radius=([\d.]+)', line)
    if weapon:
        radii[int(weapon[1])] = float(weapon[2])
    launch = re.search(r'(PULSE|NUKE): launched from (\w+)\((\d+)\) at \(([-\d.]+), ([-\d.]+)\)', line)
    if launch:
        kind, name, owner, x, z = launch.groups()
        shots.append(dict(kind=kind, name=name, owner=int(owner), x=float(x), z=float(z), frame=frame))
    rank = re.search(r'PULSE .*rank=(\d+)', line)
    if rank:
        ranks.append(int(rank[1]))
    if '[StrategicFixture] stock-drop' in line:
        drops += 1
    if '[INVARIANT]' in line or '[StrategicFixture] INVALID' in line:
        failures.append(line.strip())

if args.scenario == 'nuclear':
    shots = [s for s in shots if s['kind'] == 'NUKE']
    if any(s['frame'] < 5400 for s in shots):
        failures.append('Nuke fired during the mobile-only phase')
    if any((s['x']-10500)**2 + (s['z']-1800)**2 > 128**2 for s in shots):
        failures.append('Nuke aimed away from the only eligible building site')
    repeated = False
    for i, shot in enumerate(shots):
        for previous in shots[:i]:
            if shot['owner'] == previous['owner']:
                if shot['frame'] - previous['frame'] < 9000:
                    failures.append('Same silo repeated the fixture site before five minutes')
                else:
                    repeated = True
    if len({s['owner'] for s in shots}) < 2:
        failures.append('Two independent silos were not observed firing')
    if not repeated:
        failures.append('No same-silo shot observed after cooldown expiry')
else:
    shots = [s for s in shots if s['kind'] == 'PULSE']
    if list(dict.fromkeys(ranks))[:4] != [0, 1, 2, 3]:
        failures.append('The complete tower priority sequence was not observed')
    if not any(s['frame'] >= 5400 for s in shots):
        failures.append('No actual launch observed in the fog-scatter phase')
    if len({s['owner'] for s in shots}) < 2:
        failures.append('Both allied Junos were not observed firing')
    for i, shot in enumerate(shots):
        for previous in shots[:i]:
            if previous['owner'] not in radii:
                failures.append('Missing independently observed weapon radius')
                continue
            if shot['frame'] - previous['frame'] < 2700 and (shot['x']-previous['x'])**2 + (shot['z']-previous['z'])**2 <= radii[previous['owner']]**2:
                failures.append('Juno repeated an allied recent-shot area')
if drops == 0:
    failures.append('No independent stockpile drop was observed')
result = dict(scenario=args.scenario, source=str(args.log), shots=shots, ranks=ranks, stock_drops=drops, failures=failures, passed=not failures)
args.log.with_name('strategic-audit.json').write_text(json.dumps(result, indent=2))
print(json.dumps(result, indent=2))
raise SystemExit(bool(failures))
