#!/usr/bin/env python3
"""Audit independent local-LOS/engine-order observations from an AFUS arena.

Usage: python tools/playtest/audit_afus_handoff.py build-theatres/d176-legion
Does not interpret first damage as proof of an explicit AFUS target order.
"""
import argparse
import hashlib
import json
import re
from pathlib import Path


def audit(folder):
    log = folder / 'infolog.txt'
    contacts, damages, deaths, transitions, orders = {}, {}, {}, {}, []
    failures = []
    with log.open(encoding='utf-8', errors='replace') as stream:
        for line in stream:
            if '[INVARIANT]' in line or '[AirOrders] ERROR' in line:
                failures.append(line.strip())
            match = re.search(r'WAVE: committed attack target=(\d+)', line)
            if match:
                target = int(match[1])
                transitions[target] = transitions.get(target, 0) + 1
            match = re.search(r'\[AirOrders\] frame=(\d+) team=0 all_apm=(\d+) air_apm=(\d+) repeated=(\d+)', line)
            if match:
                orders.append(dict(zip(('frame', 'all_apm', 'air_apm', 'repeated'), map(int, match.groups()))))
            if '[AirArena] event=' not in line:
                continue
            fields = dict(re.findall(r'(\w+)=([^\s]+)', line))
            event = fields['event']
            frame = int(fields['frame'])
            if event in ('priority_visible', 'priority_attack'):
                key = (int(fields['wave']), int(fields['target']))
                record = contacts.setdefault(key, {'wave': key[0], 'target': key[1]})
                record['visible_frame' if event == 'priority_visible' else 'attack_frame'] = frame
                record['visible_distance' if event == 'priority_visible' else 'attack_distance'] = int(fields['distance'])
                record['bombers'] = int(fields['alive'])
            elif event == 'damage' and fields.get('adef') in ('armpnix', 'corhurc', 'legphoenix'):
                damages.setdefault(int(fields['victim']), frame)
            elif event == 'death':
                deaths[int(fields['id'])] = frame
            elif event == 'commitment' and fields['escorts'] != fields['owned']:
                failures.append('Escort ownership mismatch: ' + line.strip())
    for record in contacts.values():
        visible, attack = record.get('visible_frame'), record.get('attack_frame')
        if visible is None or attack is None or not 0 <= attack-visible <= 30:
            failures.append('Missing or late attack handoff: ' + str(record))
        record['handoff_seconds'] = (attack-visible)/30 if visible is not None and attack is not None else None
        record['first_damage_frame'] = damages.get(record['target'])
        record['death_frame'] = deaths.get(record['target'])
        record['attack_transitions'] = transitions.get(record['target'], 0)
    if not contacts:
        failures.append('No qualifying visible priority contact observed')
    manifest = json.loads((folder / 'arena-manifest.json').read_text())
    report = (folder / 'report.md').read_text(encoding='utf-8')
    if '- Verdict: **PASS**' not in report:
        failures.append('Strict playtest report is not PASS')
    result = {'passed': not failures, 'directory': folder.as_posix(),
              'dll_sha256': manifest['dll_sha256'], 'case': manifest['case']['name'],
              'profile': manifest['profile'], 'visibility': manifest['case']['visibility'],
              'log_sha256': hashlib.sha256(log.read_bytes()).hexdigest(),
              'contacts': list(contacts.values()), 'orders': orders, 'failures': failures}
    (folder / 'afus-handoff-audit.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path)
    args = parser.parse_args()
    result = audit(args.directory.resolve())
    print(json.dumps(result, indent=2))
    return 0 if result['passed'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
