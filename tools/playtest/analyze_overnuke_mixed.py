"""Reads a run_overnuke_mixed.py infolog: did every allied silo, of every AI and
faction, fire at the one shared overnuke target once the breakpoint stood?

python analyze_overnuke_mixed.py <run dir or infolog.txt>

Prints the silos (team, kind, minute), every overnuke begin/release/end, and for
every launch: which silo, where it ended, and whether that was inside the
overnuke that was active at the time. VERDICT counts launches made while an
overnuke was active that went elsewhere ("strays").
"""
import math
import re
import sys
from pathlib import Path

FR = re.compile(r'\[f=(-?\d+)\]')
BEGIN = re.compile(r'NUKE: overnuke with (\d+) silos at \((-?\d+), (-?\d+)\): (\d+) launches')
MOVE = re.compile(r'NUKE: overnuke salvo moves from .* to \((-?\d+), (-?\d+)\)')
RELEASE = re.compile(r'NUKE: overnuke salvo released \((\w[\w ]*)\) after (\d+)s: (\d+) stocked in (\d+) silos')
END = re.compile(r'NUKE: overnuke (?:at \(.*\) )?(?:salvo at \(.*\) is empty|ends)')
ROLL = re.compile(r'NUKE: overnuke roll (\d+)\.\.(\d+) \((\d+) silos')
SILO = re.compile(r'\[MixedNukeTest\] silo (\d+) (\w+) team=(\d+) frame=(\d+)')
LAUNCH = re.compile(r'\[MixedNukeTest\] launch n=(\d+) frame=(\d+) team=(\d+) silo=(\w+)\((\d+)\) target=\((-?\d+),(-?\d+)\)')
ENDP = re.compile(r'\[MixedNukeTest\] end frame=(\d+) team=(\d+) silo=(\w+)\((\d+)\) at=\((-?\d+),(-?\d+)\) (\w+)')
ALLY = re.compile(r'\[MixedNukeTest\] ally (\d+) team=(\d+) side=(\w+)')
RADIUS = 1280.0


def main():
    path = Path(sys.argv[1])
    if path.is_dir():
        path = path / 'infolog.txt'
    events = []  # (frame, kind, data)
    for line in path.read_text(encoding='utf-8', errors='replace').splitlines():
        m = FR.search(line)
        frame = int(m.group(1)) if m else -1
        for kind, rx in (('begin', BEGIN), ('move', MOVE), ('release', RELEASE), ('end', END), ('roll', ROLL),
                         ('silo', SILO), ('launch', LAUNCH), ('endp', ENDP), ('ally', ALLY)):
            mm = rx.search(line)
            if mm:
                events.append((frame, kind, mm.groups(), line.strip()))
                break
    active = None  # (x, z) of the overnuke now
    strays, inside, before = 0, 0, 0
    launches = {}
    for frame, kind, g, line in events:
        t = '%5.1f min' % (frame / 1800.0) if frame >= 0 else '   -    '
        if kind == 'ally':
            print('%s ally %s team %s %s' % (t, g[0], g[1], g[2]))
        elif kind == 'silo':
            print('%s silo %s %s team %s' % (t, g[1], g[0], g[2]))
        elif kind == 'roll':
            print('%s %s' % (t, line[line.find('NUKE:'):]))
        elif kind == 'begin':
            active = (float(g[1]), float(g[2]))
            print('%s BEGIN %s silos at (%s,%s), %s launches' % (t, g[0], g[1], g[2], g[3]))
        elif kind == 'move':
            active = (float(g[0]), float(g[1]))
            print('%s MOVE to (%s,%s)' % (t, g[0], g[1]))
        elif kind == 'release':
            print('%s RELEASE (%s) %s stocked in %s silos' % (t, g[0], g[2], g[3]))
        elif kind == 'end':
            print('%s END  %s' % (t, line[line.find('NUKE:'):]))
            active = None
        elif kind == 'launch':
            tx, tz = float(g[5]), float(g[6])
            launches[g[0]] = active
            if active is None:
                where, before = 'no overnuke', before + 1
            else:
                dist = math.hypot(tx - active[0], tz - active[1])
                if dist <= RADIUS:
                    where, inside = 'overnuke target (%.0f off)' % dist, inside + 1
                else:
                    where, strays = 'STRAY %.0f from the overnuke at (%.0f,%.0f)' % (dist, active[0], active[1]), strays + 1
            print('%s launch %s team %s %s(%s) aimed (%s,%s): %s' % (t, g[0], g[2], g[3], g[4], g[5], g[6], where))
        elif kind == 'endp':
            print('%s   end team %s %s(%s) at (%s,%s) %s' % (t, g[1], g[2], g[3], g[4], g[5], g[6]))
    print('VERDICT launches with an overnuke active: %d at its target, %d strays; %d with none active' % (inside, strays, before))
    return 1 if strays else 0


if __name__ == '__main__':
    raise SystemExit(main())
