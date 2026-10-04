"""Audit actual AIR mission choices against logged, unexpired failed-raid regions."""
import argparse
import json
from pathlib import Path
import re


def audit(path, team):
    regions = []
    failures = []
    missions = 0
    subsequent = 0
    feedback = []
    for line in path.open(encoding='utf-8', errors='replace'):
        owner = re.search(r':::AI LOG:S:\d+:T:(\d+):F:(\d+):', line)
        if not owner or int(owner[1]) != team:
            continue
        frame = int(owner[2])
        if 'INV-105' in line:
            failures.append(line.strip())
        exclusion = re.search(r'failed raid excluded aim=(\d+),(\d+) radius=(\d+) until=(\d+)', line)
        if exclusion:
            regions.append(tuple(map(int, exclusion.groups())))
        learned = re.search(r'learned resistance=([\d.]+) survival=([\d.]+)', line)
        if learned:
            feedback.append({'frame': frame, 'resistance': float(learned[1]), 'survival': float(learned[2])})
        mission = re.search(r'planned strike target=(\d+) bombers=(\d+) required=(\d+) aim=(\d+),(\d+)', line)
        if not mission:
            continue
        target, bombers, required, x, z = map(int, mission.groups())
        missions += 1
        if bombers < required:
            failures.append(f'Frame {frame}: {bombers} aircraft below {required} requirement')
        active = [region for region in regions[-8:] if frame < region[3]]
        if active:
            subsequent += 1
        for rx, rz, radius, until in active:
            if (x-rx)**2 + (z-rz)**2 <= radius**2:
                failures.append(f'Frame {frame}: target {target} inside failed region until {until}')
    if not any(item['resistance'] > 1 for item in feedback):
        failures.append('No observed loss feedback increased resistance')
    if subsequent == 0:
        failures.append('No observed subsequent mission while a failed region was active')
    return {'log': str(path.resolve()), 'team': team, 'missions': missions,
            'failed_regions': regions, 'missions_during_exclusion': subsequent,
            'feedback': feedback, 'failures': failures,
            'verdict': 'FAIL' if failures else 'PASS',
            'scope': 'Target exclusion and learned budgeting only; this does not override the full simulation verdict.'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('log', type=Path)
    parser.add_argument('--team', type=int, default=0)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = audit(args.log, args.team)
    text = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.write_text(text, encoding='utf-8')
    print(text)
    raise SystemExit(bool(result['failures']))
