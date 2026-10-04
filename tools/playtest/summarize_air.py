"""Summarize observed AIR outcomes without changing the playtest verdict.

Usage: python tools/playtest/summarize_air.py <infolog.txt> [--output <json>]
The AIR observer records team 0; AI intent lines are filtered to --team.
Damage is observed health damage, not a kill or win-rate estimate.
"""
import argparse
from collections import Counter, defaultdict
import json
from pathlib import Path
import re


def summarize(path, team=0):
    result = {'log': str(path.resolve()), 'team': team, 'last_frame': 0,
              'completed': {}, 'lost': {}, 'states': {}, 'rules': {},
              'peak_t1_plants': 0, 'peak_t2_plants': 0, 'peak_nanos_by_bay': {},
              'waves': [], 'transport_requests': [], 'transport_orders': [],
              'transport_deliveries': [], 'role_switches': [], 'damage': {},
              'observer_gaps': [], 'violations': {}, 'script_errors': [],
              'crashes': [], 'last_resources': None}
    damage = defaultdict(lambda: {'events': 0, 'amount': 0})
    violations = Counter()
    for line in path.open(encoding='utf-8', errors='replace'):
        # A bounded engine stop may leave its final buffered record incomplete.
        if not line.endswith('\n'):
            continue
        match = re.search(r'\[f=(\d+)\]', line)
        frame = int(match[1]) if match else 0
        result['last_frame'] = max(frame, result['last_frame'])
        ai = re.search(r':::AI LOG:S:\d+:T:(\d+):F:(\d+):L::(.*)', line)
        text = ai[3] if ai and int(ai[1]) == team else ''
        def event(value):
            return {'frame': frame, 'minute': round(frame / 1800, 3), 'text': value.strip()}
        if '[INVARIANT]' in line:
            inv = re.search(r'INV-\d+', line)
            violations[inv[0] if inv else 'unknown'] += 1
        if re.search(r': ERR\s+:|SCRIPT CRASH|Lib exception', line):
            result['script_errors'].append(event(line))
        if re.search(r'Access violation|has crashed|Fatal:', line):
            result['crashes'].append(event(line))
        if text:
            state = re.search(r'\[AIR\]\[State\] (\w+)', text)
            if state:
                result['states'].setdefault(state[1], event(text))
            rule = re.search(r'\[AIR\]\[Rule\] ([\w.]+)', text)
            if rule:
                result['rules'].setdefault(rule[1], event(text))
            plants = re.search(r'plants=(\d+)/(\d+)', text)
            if plants:
                result['peak_t1_plants'] = max(result['peak_t1_plants'], int(plants[1]))
                result['peak_t2_plants'] = max(result['peak_t2_plants'], int(plants[2]))
            bay = re.search(r'\[Bay\] (\d+).*nanos=(\d+)\+', text)
            if bay:
                result['peak_nanos_by_bay'][bay[1]] = max(result['peak_nanos_by_bay'].get(bay[1], 0), int(bay[2]))
            for field, pattern in [
                ('waves', r'\[Waves\] Wave \d+ launched'),
                ('transport_requests', r'\[Ferry\] AIR: queued request'),
                ('transport_orders', r'\[Ferry\] AIR: ordered one'),
                ('transport_deliveries', r'\[Ferry\] AIR: transport .* arrived and transferred'),
                ('role_switches', r'Role switch complete:')]:
                if re.search(pattern, text):
                    result[field].append(event(text))
        if '[AirWatch]' not in line or team != 0:
            continue
        unit = re.search(r'\[AirWatch\] (finished|lost) id=\d+ def=(\w+)', line)
        if unit:
            field = 'completed' if unit[1] == 'finished' else 'lost'
            row = result[field].setdefault(unit[2], {'count': 0, 'first': frame, 'last': frame})
            row['count'] += 1
            row['last'] = frame
        hit = re.search(r'damage attacker=\d+ def=(\w+) victim=\d+ amount=(\d+)', line)
        if hit:
            damage[hit[1]]['events'] += 1
            damage[hit[1]]['amount'] += int(hit[2])
        if 'damage coverage' in line:
            result['observer_gaps'].append(event(line))
        if '[AirWatch] eco ' in line:
            result['last_resources'] = event(line.split('[AirWatch] ', 1)[1])
    result['damage'] = dict(damage)
    result['violations'] = dict(violations)
    result['minutes'] = round(result['last_frame'] / 1800, 3)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('log', type=Path)
    parser.add_argument('--team', type=int, default=0)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = summarize(args.log, args.team)
    payload = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.write_text(payload, encoding='utf-8')
    else:
        print(payload, end='')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
