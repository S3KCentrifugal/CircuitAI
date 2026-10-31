"""Debug strike runs (run_debug_strike.py): one table row per strike from the
fixture's [DebugTest] lines and the striker's DEBUG: lines in infolog.txt.

    python tools/playtest/analyze_debug_strike.py <game dir> [<game dir> ...]
"""
import json
import math
import re
import sys
from pathlib import Path

FRAME = re.compile(r'\]\[f=(-?\d+)\]')
KV = re.compile(r'(\w+)=(\S+)')


def parse(log):
    rows, sends, events = [], [], []
    for line in log.read_text(encoding='utf-8', errors='replace').splitlines():
        m = FRAME.search(line)
        if not m:
            continue
        f = int(m.group(1))
        if '[DebugTest] RESULT ' in line:
            name = line.split('RESULT ', 1)[1].split()[0]
            rows.append(dict(name=name, frame=f, **dict(KV.findall(line.split('RESULT ', 1)[1]))))
        elif '[DebugTest] send ' in line:
            sends.append((f, line.split('msg=', 1)[1].strip()))
        elif '[DebugTest] end ' in line or '[DebugTest] launch ' in line or '[DebugTest] kill ' in line:
            events.append((f, line.split('[DebugTest] ', 1)[1]))
        elif 'DEBUG: ' in line:
            events.append((f, 'AI ' + line.split('DEBUG: ', 1)[1]))
    return rows, sends, events


def strike_windows(sends):
    """(weapon, tail, on frame, off frame) for each debug command."""
    out, open_ = [], {}
    for f, msg in sends:
        parts = msg.split('|')
        w, mode = parts[3], parts[4]
        if mode == 'off':
            if w in open_:
                on_f, tail = open_.pop(w)
                out.append((w, tail, on_f, f))
        else:
            open_[w] = (f, '|'.join(parts[4:]))
    return out


def summarize(d):
    log = Path(d) / 'infolog.txt'
    rows, sends, events = parse(log)
    windows = strike_windows(sends)
    result = []
    for (w, tail, on_f, off_f), row in zip(windows, rows):
        first_order = next((f for f, e in events if on_f <= f and e.startswith('AI ') and ' fires at ' in e and (('silo' in e) == (w == 'nuke'))), None)
        leaves = [f for f, e in events if off_f <= f < off_f + 900 and e.startswith('AI ') and 'leaves the strike' in e
                  and (('silo' in e) == (w == 'nuke'))]
        done = next((f for f, e in events if on_f <= f <= off_f and e.startswith('AI nuke strike on team') and ' done ' in e), None)
        launches = [e for f, e in events if on_f <= f <= off_f + 30 and e.startswith('AI nuke launch ')] if w == 'nuke' else []
        early = [f for f, e in events if on_f <= f <= off_f and e.startswith('AI ') and 'leaves the strike' in e]
        # lol impacts: distance of every logged end from the aim (pos strikes)
        dists = []
        if tail.startswith('pos|'):
            _, x, z = tail.split('|')
            x, z = float(x), float(z)
            for f, e in events:
                if on_f <= f and e.startswith('end ' + w) and 'phase=run' in e:
                    m = re.search(r'at=\((-?\d+),(-?\d+)\)', e)
                    if m and f <= off_f + 600:
                        dists.append(math.hypot(float(m.group(1)) - x, float(m.group(2)) - z))
        result.append({
            'strike': row['name'], 'command': w + '|' + tail,
            'shots': int(row['shots']), 'ended': int(row['ended']),
            'inRadius': int(row['inRadius']), 'aimOnTargetTeam': int(row['aimOnTargetTeam']),
            'endOnTargetTeam': int(row['endOnTargetTeam']), 'targetKills': int(row['targetKills']),
            'firstShotSec': row['firstShotSec'], 'firstOrderSec': None if first_order is None else round((first_order - on_f) / 30, 1),
            'aiDoneSec': None if done is None else round((done - on_f) / 30, 1),
            'offToNormalSec': None if not leaves else round((max(leaves) - off_f) / 30, 2),
            'unitsLeaving': len(leaves) + len(early), 'afterOffShots': int(row['afterOffShots']),
            'afterOffNearTarget': int(row['afterOffNearTarget']), 'why': row['why'],
            'aiDebugLaunches': len(launches), 'carryover': int(row.get('carryover', 0)),
            'loggedEndDistances': {'n': len(dists), 'median': round(sorted(dists)[len(dists) // 2]) if dists else None,
                                   'max': round(max(dists)) if dists else None},
        })
    return result


def main():
    out = {}
    for d in sys.argv[1:]:
        out[d] = summarize(d)
        print('==', d)
        for r in out[d]:
            print(json.dumps(r))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
