"""Per-wave trades of a line arena (D-430).

Reads one ranged_arena game directory: the case (ranged-arena.json, with its
"waves": name, after_seconds, units), the observer log (spawn, death, damage
rows) and the AI's LINE: order lines. Attributes every enemy kill and every
friendly loss to the wave whose units were on the field, prints the trade
table (metal killed against metal lost, first shot, first withdraw order and
the rear/screen stance timing) and writes line-waves-v1.json beside the
immutable ranged measurements. It never changes a verdict: a losing trade is
reported as a losing trade.
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
    waves = cfg.get('waves') or []
    units, spawn_frame = {}, {}
    deaths, damage, shots, orders, stances = [], [], [], [], []
    for line in text.splitlines():
        if '[RangedArena] frame=' in line:
            row = dict(re.findall(r'(\w+)=([^ ]+)', line))
            if not row.get('frame','').isdigit(): continue
            frame = int(row['frame'])
            event = re.search(r'\[RangedArena\] frame=\d+ (\w+)', line)
            kind = event[1] if event else ''
            if kind == 'spawn' and all(k in row for k in ('id','unit','team')):
                units[int(row['id'])] = (row['unit'], int(row['team'])); spawn_frame[int(row['id'])] = frame
            elif kind == 'death' and all(k in row for k in ('id','team','unit','cost')):
                deaths.append((frame, int(row['id']), int(row['team']), row['unit'], float(row['cost'])))
            elif kind == 'damage' and all(k in row for k in ('id','team','amount','attackerTeam')):
                # Death blasts and terrain carry no attacker ("nil"): attributed to no team.
                attacker = int(row['attackerTeam']) if row['attackerTeam'].lstrip('-').isdigit() else -1
                damage.append((frame, int(row['team']), attacker, max(0, int(row['amount']))))
            elif kind == 'shot' and 'unit' in row:
                shots.append((frame, row['unit']))
        elif 'LINE: line=' in line:
            m = re.search(r'LINE: line=(\d+) order=(\w+) (?:from=(\w+) source=(\w+).*?|screen=(\w+) rear=(\w+) elapsed=(\d+) screen_delay=(\d+) rear_delay=(\d+) )frame=(\d+)', line)
            if not m: continue
            frame = int(m[10])
            if m[3]: orders.append(dict(frame=frame, line=int(m[1]), order=m[2], previous=m[3], source=m[4]))
            else: stances.append(dict(frame=frame, line=int(m[1]), order=m[2], screen=m[5], rear=m[6], elapsed=int(m[7]), screen_delay=int(m[8]), rear_delay=int(m[9])))
    watched = cfg.get('units', [cfg['unit']])
    enemy_team = cfg.get('enemy_team', 1)
    # A wave owns the field from its arrival until the next wave arrives.
    bounds = []
    for i, w in enumerate(waves):
        start = int(w['after_seconds'])*30
        end = int(waves[i+1]['after_seconds'])*30 if i+1 < len(waves) else float('inf')
        bounds.append((w['name'], start, end, set(w['units'])))
    def wave_of(frame, unit=None):
        for name, start, end, members in bounds:
            if start <= frame < end and (unit is None or unit in members or unit in watched): return name
        for name, start, end, members in bounds:
            if unit in members: return name
        return 'before-waves' if bounds and frame < bounds[0][1] else 'unattributed'
    report = {}
    for name, *_ in bounds: report[name] = dict(enemy_kills=0, enemy_metal=0.0, losses=0, lost_metal=0.0, losses_by_unit={}, kills_by_unit={}, damage_dealt=0, damage_taken=0)
    for frame, uid, team, unit, cost in deaths:
        key = wave_of(frame, unit)
        row = report.setdefault(key, dict(enemy_kills=0, enemy_metal=0.0, losses=0, lost_metal=0.0, losses_by_unit={}, kills_by_unit={}, damage_dealt=0, damage_taken=0))
        if team == enemy_team:
            row['enemy_kills'] += 1; row['enemy_metal'] += cost; row['kills_by_unit'][unit] = row['kills_by_unit'].get(unit, 0)+1
        elif team == 0 and unit in watched:
            row['losses'] += 1; row['lost_metal'] += cost; row['losses_by_unit'][unit] = row['losses_by_unit'].get(unit, 0)+1
    for frame, team, attacker, amount in damage:
        key = wave_of(frame)
        row = report.setdefault(key, dict(enemy_kills=0, enemy_metal=0.0, losses=0, lost_metal=0.0, losses_by_unit={}, kills_by_unit={}, damage_dealt=0, damage_taken=0))
        if attacker == 0 and team == enemy_team: row['damage_dealt'] += amount
        elif team == 0 and attacker == enemy_team: row['damage_taken'] += amount
    for name, row in report.items():
        row['trade_ratio'] = round(row['enemy_metal']/row['lost_metal'], 2) if row['lost_metal'] > 0 else (None if row['enemy_metal'] == 0 else 'no losses')
    first_shot = min((f for f, _ in shots), default=None)
    withdraws = [o for o in orders if o['order'] == 'withdraw']
    tucks = text.count('BACKLINE: tuck unit=')  # D-432: backline tuck events
    staged = []
    for s in stances:
        if s['order'] == 'withdraw' and s['rear'] == 'withdraw' and s['screen'] in ('cover', 'hold'):
            staged.append(dict(frame=s['frame'], line=s['line'], screen=s['screen'], screen_delay=s['screen_delay']))
    summary = dict(schema=1, case=cfg['name'], directory=str(directory), waves=report,
                   first_shot_seconds=first_shot/30 if first_shot is not None else None,
                   line_orders=orders, stance_changes=len(stances),
                   staged_withdrawals=staged, tucks=tucks, first_withdraw_seconds=withdraws[0]['frame']/30 if withdraws else None,
                   total_enemy_kills=sum(1 for d in deaths if d[2] == enemy_team),
                   total_losses=sum(1 for d in deaths if d[2] == 0 and d[3] in watched),
                   lines_seen=sorted({o['line'] for o in orders}))
    (directory/'line-waves-v1.json').write_text(json.dumps(summary, indent=2)+'\n')
    return summary


def table(summary):
    lines = [f"# {summary['case']}", '', '| Wave | Enemy kills | Enemy metal | Losses | Lost metal | Trade | Dealt | Taken |', '| --- | --- | --- | --- | --- | --- | --- | --- |']
    for name, row in summary['waves'].items():
        losses = ', '.join(f'{k} {v}' for k, v in row['losses_by_unit'].items()) or '0'
        lines.append(f"| {name} | {row['enemy_kills']} | {row['enemy_metal']:.0f} | {losses} | {row['lost_metal']:.0f} | {row['trade_ratio']} | {row['damage_dealt']} | {row['damage_taken']} |")
    lines += ['', f"First shot: {summary['first_shot_seconds']} s. First withdraw order: {summary['first_withdraw_seconds']} s. "
              f"Orders: {len(summary['line_orders'])}, stance changes: {summary['stance_changes']}, staged withdrawals (rear first, screen covering): {len(summary['staged_withdrawals'])}, backline tucks: {summary.get('tucks', 0)}.",
              f"Totals: kills {summary['total_enemy_kills']}, losses {summary['total_losses']}."]
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path)
    args = parser.parse_args()
    summary = analyse(args.directory)
    print(table(summary))
    return 0


if __name__ == '__main__': sys.exit(main())
