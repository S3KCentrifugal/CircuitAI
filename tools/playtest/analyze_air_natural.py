"""Extract AIR milestones and command traffic from a natural playtest archive.

Only the team-0 AirWatch observer supplies complete unit-completion coverage.
Other AIR teams supply policy and command telemetry, not invented milestones.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import re
from workforce_metrics import parse_sample, summarize


def analyze(log, teams, end_frame=None):
    air = {str(t['team']): {'side': t['side'], 'first': {}, 'finished': Counter(),
           'waves': [], 'raids': [], 'recon': [], 'orders': [], 'starter_distance': [],
           'retirements': [], 'invariants': Counter(), 'first_rule': {}, 'workforce_samples': [], 'removed_frame': None}
           for t in teams if t['role'] == 'AIR'}
    violations, observer_violations, errors, last_frame = Counter(), Counter(), [], 0
    milestones = {'armap':'t1_lab', 'corap':'t1_lab', 'legap':'t1_lab',
                  'armaap':'t2_lab', 'coraap':'t2_lab', 'legaap':'t2_lab',
                  'armfus':'fusion', 'corfus':'fusion', 'legfus':'fusion',
                  'armafus':'afus', 'corafus':'afus', 'legafus':'afus',
                  'armpnix':'t2_bomber', 'corhurc':'t2_bomber', 'legphoenix':'t2_bomber',
                  'armthund':'t1_bomber', 'corshad':'t1_bomber', 'legmos':'t1_gunship'}
    with Path(log).open(encoding='utf-8', errors='replace') as stream:
        for line in stream:
            if not line.endswith('\n'):
                continue
            f = re.search(r'\[f=(\d+)\]', line)
            frame = int(f[1]) if f else 0
            if end_frame is not None and frame > end_frame:
                continue
            last_frame = max(last_frame, frame)
            minute = round(frame/1800, 3)
            removed = re.search(r'local skirmish AI .* being removed from team (\d+)', line)
            if removed and removed[1] in air and air[removed[1]]['removed_frame'] is None:
                air[removed[1]]['removed_frame'] = frame
            sample = parse_sample(line)
            if sample is not None and '0' in air and air['0']['removed_frame'] is None:
                air['0']['workforce_samples'].append(sample)
            inv = re.search(r'\[INVARIANT\] (INV-\d+)', line)
            if inv:
                violations[inv[1]] += 1
                if 'AIR observer:' in line:
                    observer_violations[inv[1]] += 1
            if re.search(r': ERR\s+:|SCRIPT CRASH|Lib exception|Access violation|Fatal:|\[AirOrders\] ERROR', line):
                errors.append(line.strip())
            finished = re.search(r'\[AirWatch\] finished id=\d+ def=(\w+)', line)
            if finished and '0' in air:
                row = air['0']; name = finished[1]
                row['finished'][name] += 1
                if name in milestones:
                    key = milestones[name]
                    row['first'].setdefault(key, minute)
                    if row['finished'][name] == 2:
                        row['first'].setdefault('second_'+key, minute)
            command = re.search(r'\[AirOrders\] frame=(\d+) team=(\d+) all_apm=(\d+) air_apm=(\d+) repeated=(\d+)', line)
            if command and command[2] in air:
                air[command[2]]['orders'].append({'minute': minute, 'all': int(command[3]),
                                                'air': int(command[4]), 'repeated': int(command[5])})
            intent = re.search(r':::AI LOG:S:\d+:T:(\d+):F:\d+:L::(.*)', line)
            if not intent or intent[1] not in air:
                continue
            row, text = air[intent[1]], intent[2]
            if inv:
                row['invariants'][inv[1]] += 1
            for key, pattern in (('waves', r'\[AIR\]\[Waves\] Wave \d+ launched'),
                                 ('raids', r'\[AIR\]\[Raid\] launched'),
                                 ('recon', r'\[AIR\]\[Recon\] synchronized'),
                                 ('retirements', r'\[LIFECYCLE\].*AIR starter')):
                if re.search(pattern, text):
                    row[key].append({'minute': minute, 'text': text})
            distance = re.search(r'\[AIR\]\[Starter\] nearby distance=(\d+)', text)
            if distance:
                row['starter_distance'].append(int(distance[1]))
            rule = re.search(r'\[AIR\]\[Rule\] ([\w.]+)', text)
            if rule:
                row['first_rule'].setdefault(rule[1], minute)
    for row in air.values():
        row['observed_minutes'] = round(min(last_frame, row['removed_frame'] if row['removed_frame'] is not None else last_frame)/1800, 3)
        row['workforce'] = summarize(row.pop('workforce_samples'))
        row['peak_air_apm'] = max((v['air'] for v in row['orders']), default=0)
        row['peak_all_apm'] = max((v['all'] for v in row['orders']), default=0)
    return {'log': str(Path(log).resolve()), 'minutes': round(last_frame/1800, 3),
            'air': air, 'air_observer_invariants': dict(observer_violations),
            'all_invariants': dict(violations), 'errors': errors}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path)
    parser.add_argument('--log', type=Path)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--end-frame', type=int)
    args = parser.parse_args()
    log = args.log
    if log is None:
        report = (args.directory/'report.md').read_text(encoding='utf-8')
        log = Path(re.search(r'^- Log: (.+)$', report, re.M)[1].strip())
    teams = json.loads((args.directory/'teams.json').read_text())['teams']
    result = analyze(log, teams, args.end_frame)
    if args.output:
        args.output.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({**result, 'air': {k: {f:v for f,v in r.items() if f not in ('orders','finished','first_rule')}
                                      for k,r in result['air'].items()}}, indent=2))


if __name__ == '__main__':
    main()
