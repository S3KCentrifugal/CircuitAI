"""Commander targeting evidence from a ranged arena game (D-383, D-430).

For every enemy commander the observer spawned: when it was first detected,
when a watched hull first chose it as its priority target (a `shot` row whose
intent is the commander), when it was first hit by team 0, whether and when it
was observed cloaked, and when it died. Prints one table and writes
commander-shots-v1.json beside the game. Silence about a commander is reported
as such, never as a pass.
"""
import argparse
import json
import re
import sys
from pathlib import Path


def analyse(directory):
    directory = Path(directory)
    cfg = json.loads((directory/'ranged-arena.json').read_text())
    text = (directory/'infolog.txt').read_text(errors='replace')
    watched = cfg.get('units', [cfg['unit']])
    enemy_team = cfg.get('enemy_team', 1)
    units, commanders = {}, {}
    for line in text.splitlines():
        if '[RangedArena] frame=' not in line: continue
        row = dict(re.findall(r'(\w+)=([^ ]+)', line))
        if not row.get('frame', '').isdigit(): continue
        frame = int(row['frame'])
        kind = re.search(r'\[RangedArena\] frame=\d+ (\w+)', line)
        kind = kind[1] if kind else ''
        if kind == 'spawn' and all(k in row for k in ('id', 'unit', 'team')):
            uid = int(row['id']); units[uid] = (row['unit'], int(row['team']))
            if int(row['team']) == enemy_team and row['unit'].endswith('com'):
                commanders[uid] = dict(unit=row['unit'], spawn=frame, detected=None, first_intent=None, intents=0,
                                       shooters=set(), first_hit=None, hits=0, damage=0, cloaked_first=None, cloak_samples=0,
                                       samples=0, death=None)
        elif kind == 'detected' and 'id' in row and int(row['id']) in commanders:
            c = commanders[int(row['id'])]; c['detected'] = c['detected'] if c['detected'] is not None else frame
        elif kind == 'shot' and 'intent' in row and row['intent'].isdigit() and int(row['intent']) in commanders and row.get('unit') in watched:
            c = commanders[int(row['intent'])]; c['intents'] += 1; c['shooters'].add(int(row['id']))
            if c['first_intent'] is None: c['first_intent'] = frame
        elif kind == 'damage' and 'id' in row and int(row['id']) in commanders and row.get('attackerTeam') == '0':
            c = commanders[int(row['id'])]; c['hits'] += 1; c['damage'] += max(0, int(row['amount']))
            if c['first_hit'] is None: c['first_hit'] = frame
        elif kind == 'unit' and 'id' in row and int(row['id']) in commanders:
            c = commanders[int(row['id'])]; c['samples'] += 1
            if row.get('cloak') == 'true':
                c['cloak_samples'] += 1
                if c['cloaked_first'] is None: c['cloaked_first'] = frame
        elif kind == 'death' and 'id' in row and int(row['id']) in commanders:
            commanders[int(row['id'])]['death'] = frame
    out = []
    for uid, c in commanders.items():
        c = dict(c); c['id'] = uid; c['shooters'] = sorted(c['shooters'])
        for k in ('spawn', 'detected', 'first_intent', 'first_hit', 'cloaked_first', 'death'):
            c[k + '_seconds'] = round(c[k] / 30, 1) if c[k] is not None else None
        c['response_seconds'] = round((c['first_hit'] - c['detected']) / 30, 1) if c['first_hit'] is not None and c['detected'] is not None else None
        out.append(c)
    summary = dict(schema=1, case=cfg['name'], directory=str(directory), commanders=out)
    (directory/'commander-shots-v1.json').write_text(json.dumps(summary, indent=2)+'\n')
    return summary


def table(summary):
    lines = [f"# {summary['case']}", '', '| Commander | Spawned | Detected | First targeted | First hit | Response | Hits | Damage | Shooters | Cloaked first | Cloak samples | Died |',
             '| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |']
    for c in summary['commanders']:
        lines.append(f"| {c['unit']} {c['id']} | {c['spawn_seconds']} s | {c['detected_seconds']} s | {c['first_intent_seconds']} s | {c['first_hit_seconds']} s | {c['response_seconds']} s | {c['hits']} | {c['damage']} | {len(c['shooters'])} | {c['cloaked_first_seconds']} s | {c['cloak_samples']}/{c['samples']} | {c['death_seconds']} s |")
    if not summary['commanders']: lines.append('No enemy commander was spawned by the observer.')
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path)
    args = parser.parse_args()
    print(table(analyse(args.directory)))
    return 0


if __name__ == '__main__': sys.exit(main())
