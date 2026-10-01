"""Audit actual amphibious movement/combat telemetry, not just route announcements."""
import argparse
import json
import math
import re
from pathlib import Path

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('directory',type=Path)
p.add_argument('--log',type=Path)
a=p.parse_args()
log=a.log or a.directory/'infolog.txt'
teams=json.loads((a.directory/'teams.json').read_text())['teams']
enemy=next(t for t in teams if t['ally']==1)
metrics,failures,secured,scope,landed_ids={},[],set(),set(),{}
guard_range=guard_distance=None
for line in log.open(encoding='utf-8',errors='replace'):
    if '[INVARIANT]' in line or 'SCRIPT CRASH' in line or re.search(r'\.as \(\d+, \d+\) : (ERR|WARN)',line): failures.append(line.strip())
    if '[AmphFixture] INVALID' in line: failures.append(line.strip())
    match=re.search(r'AmphFixture\] metrics (\d+):(\w+) wet=(\d+) landed=(\d+) progress=(\d+) kills=(\d+)',line)
    if match:
        team,name,wet,landed,progress,kills=match.groups()
        metrics[f'{team}:{name}']=dict(wet=int(wet),landed=int(landed),progress=int(progress),kills=int(kills))
    match=re.search(r'AmphFixture\] landed team=(\d+) unit=(\w+) region=\d+ id=(\d+)',line)
    if match: landed_ids.setdefault(f'{match[1]}:{match[2]}',set()).add(match[3])
    match=re.search(r':T:(\d+):.*\[AMPH\].*kind=(\d+) secured',line)
    if match: secured.add(f'{match[1]}:{"legamph" if match[2]=="0" else "armmar"}')
    if re.search(r':T:[2-9]\d*:.*\[AMPH\]',line): failures.append('Amphibious controller activated for the FRONT control')
    match=re.search(r'scope control FRONT unit=(\w+)',line)
    if match: scope.add(match[1])
    match=re.search(r'AmphFixture\] guard at=.* radius=([\d.]+)',line)
    if match: guard_range=float(match[1])
    match=re.search(r'guard minimum underwater distance=(\d+)',line)
    if match: guard_distance=float(match[1])
for team in (0,1):
    start=next(t for t in teams if t['team']==team)
    distance=math.hypot(start['x']-enemy['x'],start['z']-enemy['z'])
    for name,count in [('legamph',6),('armmar',4)]:
        key=f'{team}:{name}';metric=metrics.get(key,{})
        if metric.get('wet',0)<count: failures.append(f'{key}: not every injected member entered water')
        if len(landed_ids.get(key,set()))<count: failures.append(f'{key}: incomplete observed landfall')
        if metric.get('progress',0)<distance*0.6: failures.append(f'{key}: insufficient forward movement beyond initial shore')
        if key not in secured: failures.append(f'{key}: no regrouped/secured foothold')
for name in ('legamph','armmar'):
    if sum(metrics.get(f'{team}:{name}',{}).get('kills',0) for team in (0,1))==0: failures.append(name+': no observed attributed kill')
if guard_range is not None and (guard_distance is None or guard_distance<guard_range): failures.append('Observed underwater movement entered the guarded weapon radius')
fixture=json.loads((a.directory/'amphibious-fixture.json').read_text())
if fixture.get('guarded') and guard_range is None: failures.append('Missing underwater guard')
if fixture.get('require_front_controls') and scope!={'legamph','armmar'}: failures.append('Missing out-of-scope FRONT control units')
result=dict(map=json.loads((a.directory/'teams.json').read_text())['map'],log=str(log),metrics=metrics,
    distinct_landings={k:len(ids) for k,ids in landed_ids.items()},secured=sorted(secured),front_controls=sorted(scope),
    guard_range=guard_range,guard_minimum_distance=guard_distance,failures=failures)
output=log.parent/'amphibious-audit.json'
output.write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
raise SystemExit(bool(failures))
