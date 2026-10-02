"""Summarize AIR worker allocation, milestones and bank occupancy from staged logs."""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('log', type=Path)
p.add_argument('--output', type=Path)
a = p.parse_args()
result = {'log': str(a.log), 'milestones': {}, 'worker_samples': 0,
          'guard_samples': 0, 'maximum_t2_workers': 0, 'maximum_advanced_economy_workers': 0,
          'economy_samples': 0, 'metal_at_least_95_percent_samples': 0,
          'late_samples': 0, 'late_metal_at_least_95_percent_samples': 0,
          'advanced_economy_orders': {}, 'invariants': {}, 'invariants_by_team': {}, 'probe_results': [],
          'aircraft_finished': {}, 'overflow_reactors': 0}
orders, failures, aircraft = Counter(), Counter(), Counter()
failures_by_team = {}
for line in a.log.open(encoding='utf-8', errors='replace'):
    frame = re.search(r'\[f=(\d+)\]', line)
    minute = int(frame[1]) / 1800 if frame else 0
    ours = ':S:0:T:0:' in line
    if ours:
        m = re.search(r'\[AirEconomyProbe\] workers=(\d+) guard=(\d+) advancedEco=(\d+)', line)
        if m:
            total, guard, eco = map(int, m.groups())
            result['worker_samples'] += 1
            result['guard_samples'] += guard > 0
            result['maximum_t2_workers'] = max(result['maximum_t2_workers'], total)
            result['maximum_advanced_economy_workers'] = max(result['maximum_advanced_economy_workers'], eco)
        m = re.search(r'\[AirEconomyProbe\] ((?:PASS|FAIL|confirmed).*)', line)
        if m:
            result['probe_results'].append({'minute': round(minute, 3), 'result': m[1]})
        m = re.search(r'\[AIR\]\[EcoLayout\] place (\w+)', line)
        if m:
            orders[m[1]] += 1
        if '[AIR][Growth] afus reason=funded surplus' in line:
            result['overflow_reactors'] += 1
    m = re.search(r'\[Playtest\] finished (\w+) team 0 at ([\d.]+) min', line)
    if m and m[1] in ('armfus','corfus','legfus','armafus','corafus','legafus','armaap','coraap','legaap'):
        result['milestones'].setdefault(m[1], []).append(float(m[2]))
    m = re.search(r'\[AirWatch\] finished id=\d+ def=(\w+)', line)
    if m:
        aircraft[m[1]] += 1
    m = re.search(r'\[AirWatch\] eco t=([\d.]+) M=([\d.]+)/([\d.]+)', line)
    if m:
        seconds, current, storage = map(float, m.groups())
        full = storage > 0 and current >= storage * .95
        result['economy_samples'] += 1
        result['metal_at_least_95_percent_samples'] += full
        if seconds >= 25 * 60:
            result['late_samples'] += 1
            result['late_metal_at_least_95_percent_samples'] += full
    m = re.search(r'\[INVARIANT\]\s+(INV-\d+)', line)
    if m:
        failures[m[1]] += 1
        team = re.search(r':S:\d+:T:(\d+):', line)
        failures_by_team.setdefault(team[1] if team else 'unknown', Counter())[m[1]] += 1
result['advanced_economy_orders'] = dict(orders)
result['invariants'] = dict(failures)
result['invariants_by_team'] = {team: dict(counts) for team, counts in failures_by_team.items()}
result['aircraft_finished'] = {name: count for name, count in aircraft.items()
    if name in ('armaca','coraca','legaca','armhawk','corvamp','legvenator','armpnix','corhurc','legphoenix')}
encoded = json.dumps(result, indent=2)
if a.output:
    a.output.parent.mkdir(parents=True, exist_ok=True)
    a.output.write_text(encoded + '\n')
print(encoded)
