"""Audit shared donation limits, cooldowns and opening protection in a played log."""
import argparse
import json
import re
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('directory', type=Path)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
base = args.directory
teams = {t['team']: t for t in json.loads((base/'teams.json').read_text())['teams']}
pat = re.compile(r':T:(\d+):F:(\d+):L::\[(\w+)\]\[Share\] metal (\d+) of (\d+) \((\d+)%\): sent (.*?);')
rows, failures, last, factories = [], [], {}, {}
for line in (base/'infolog.txt').open(encoding='utf-8', errors='replace'):
    m = re.search(r'first completed factory team=(\d+) frame=(\d+)', line)
    if m:
        factories[int(m[1])] = int(m[2])
    m = pat.search(line)
    if not m:
        continue
    team, frame, role, bank, storage, fill = m.groups()[:6]
    team, frame, bank, storage, fill = map(int, (team, frame, bank, storage, fill))
    gifts = [(int(n), int(t)) for n, t in re.findall(r'(\d+) to team (\d+)', m[7])]
    amount = sum(n for n, _ in gifts)
    if not gifts or fill < 95 or bank+1 < storage*0.95 or amount > storage*0.20+1:
        failures.append(f'bad threshold/budget: {line.strip()}')
    if team in last and frame-last[team] < 150:
        failures.append(f'cooldown: team {team}, frame {frame}')
    for n, target in gifts:
        if n < 25 or target == team or target not in teams or teams[target]['ally'] != teams[team]['ally']:
            failures.append(f'invalid gift: team {team} -> {target}, {n}')
    last[team] = frame
    rows.append(dict(team=team, frame=frame, role=role, bank=bank, storage=storage, gifts=gifts))
roles = sorted({r['role'] for r in rows})
if set(roles) != {'TECH', 'AIR', 'FRONT', 'SEA', 'TACTICAL', 'SUPPORT'}:
    failures.append(f'missing roles: {roles}')
# The fixture records first factory completion before later donations; all donor
# teams must have this witness in the final fixture version.
missing = sorted(set(last)-set(factories))
if missing:
    failures.append(f'no first-factory witness for teams: {missing}')
for row in rows:
    if row['team'] in factories and row['frame'] < factories[row['team']]:
        failures.append(f"opening: team {row['team']}, frame {row['frame']}")
result = dict(directory=str(base), roles=roles, donations=len(rows),
              minimum_gap_seconds=min((b['frame']-a['frame'])/30 for t in last
                  for a,b in zip([r for r in rows if r['team']==t], [r for r in rows if r['team']==t][1:])) if len(rows)>len(last) else None,
              first_factories=factories, failures=failures, rows=rows)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ('rows','first_factories')}))
raise SystemExit(bool(failures))
