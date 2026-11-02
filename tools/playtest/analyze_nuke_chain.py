"""Analyse nuke_chain_fixture runs (owner 2026-11-02): predicted vs actual metal
killed per layout run, and the blast distance model from the calibration run.

python analyze_nuke_chain.py <run dir> [<run dir> ...]
"""
import math
import re
import sys
from pathlib import Path

ND, NR = 15000.0, 960.0   # nuke default damage, radius (aoe 1920), edge 0
EXP = {'afus': (10600, 640), 'fus': (2650, 240), 'geo': (1420, 260)}
KIND = {'corafus': 'afus', 'armafus': 'afus', 'legafus': 'afus', 'corageo': 'afus', 'armageo': 'afus', 'legageo': 'afus',
        'corfus': 'fus', 'armfus': 'fus', 'legfus': 'fus', 'corgeo': 'geo', 'armgeo': 'geo', 'leggeo': 'geo'}

UNIT = re.compile(r'\[NukeChain\] unit id=(\d+) def=(\w+) pos=\((-?\d+),(-?\d+),(-?\d+)\) hp=(\d+) metal=(\d+) radius=([\d.]+) '
                  r'height=[\d.-]+ xsize=(\d+) zsize=(\d+) vol=([\d.]+),([\d.]+),([\d.]+) type=(\d+) axis=(\d+) off=(-?[\d.]+),(-?[\d.]+),(-?[\d.]+)')
DMG = re.compile(r'\[NukeChain\] dmg frame=(\d+) id=(\d+) def=(\w+) damage=(\d+)')
DEATH = re.compile(r'\[NukeChain\] death frame=(\d+) id=(\d+)')
IMPACT = re.compile(r'\[NukeChain\] impact frame=(\d+) at=\((-?[\d.]+),(-?[\d.]+),(-?[\d.]+)\).*shot=(\d+)')
RESULT = re.compile(r'\[NukeChain\] RESULT shot=(\d+) .*killedMetal=(\d+) killed=(\d+) \{([^}]*)\}')
AIM = re.compile(r'NUCLEAR (\w+)\((\d+)\): rank=(-?\d+) targets=(\d+) value=(\d+) at \((-?\d+),(-?\d+)\)')


def area(D, R, d, edge=0.0):
    if d >= R:
        return 0.0
    d = max(0.0, d)
    return D * (R - d) / (R - d * edge)


def surface(u, x, z, model, factor=1.0):
    """distance from (x,z) to unit u under a distance model"""
    dx, dz = x - (u['x'] + u['ox']), z - (u['z'] + u['oz'])
    c = math.hypot(x - u['x'], z - u['z'])
    if model == 'centre':
        return c
    if model == 'volume':
        if u['type'] == 1:   # cylinder (axis Y): radius = x scale / 2
            return max(0.0, math.hypot(dx, dz) - u['sx'] / 2 * factor)
        hx, hz = u['sx'] / 2 * factor, u['sz'] / 2 * factor   # box
        return math.hypot(max(0.0, abs(dx) - hx), max(0.0, abs(dz) - hz))
    if model == 'footprint':
        return max(0.0, c - u['xsize'] * 8 / 2 / 2 * factor)   # Lua xsize = footprint x 2
    if model == 'radius':
        return max(0.0, c - u['radius'] * factor)
    raise ValueError(model)


def parse(d):
    info = (Path(d) / 'infolog.txt').read_text(encoding='utf-8', errors='replace')
    units, dmg, deaths, impacts, results, aims = {}, [], {}, [], [], []
    for line in info.splitlines():
        m = UNIT.search(line)
        if m:
            g = m.groups()
            units[int(g[0])] = dict(id=int(g[0]), def_=g[1], x=float(g[2]), y=float(g[3]), z=float(g[4]), hp=float(g[5]),
                                    metal=float(g[6]), radius=float(g[7]), xsize=int(g[8]), zsize=int(g[9]),
                                    sx=float(g[10]), sy=float(g[11]), sz=float(g[12]), type=int(g[13]),
                                    ox=float(g[15]), oz=float(g[17]))
            continue
        m = DMG.search(line)
        if m:
            dmg.append((int(m.group(1)), int(m.group(2)), float(m.group(4)))); continue
        m = DEATH.search(line)
        if m:
            deaths[int(m.group(2))] = int(m.group(1)); continue
        m = IMPACT.search(line)
        if m:
            impacts.append(dict(f=int(m.group(1)), x=float(m.group(2)), y=float(m.group(3)), z=float(m.group(4)), shot=int(m.group(5)))); continue
        m = RESULT.search(line)
        if m:
            results.append(dict(shot=int(m.group(1)), metal=int(m.group(2)), n=int(m.group(3)), list=m.group(4))); continue
        m = AIM.search(line)
        if m:
            aims.append(dict(value=int(m.group(5)), x=int(m.group(6)), z=int(m.group(7)), targets=int(m.group(4)), rank=int(m.group(3))))
    return units, dmg, deaths, impacts, results, aims


def nuke_hits(units, dmg, imp):
    """the nuke's own hit on each unit: its first damage event from impact on (the blast
    front comes first; death explosions of its neighbours follow); small hits (< 50) are
    other weapons"""
    hits = {}
    for f, u, a in dmg:
        if u in units and u not in hits and imp['f'] - 3 <= f <= imp['f'] + 12 and a > 50:
            hits[u] = a
    return hits


def sim(units, imp, model, factor=1.0, chain=True):
    hp = {u: v['hp'] for u, v in units.items()}
    for u, v in units.items():
        hp[u] -= area(ND, NR, surface(v, imp['x'], imp['z'], model, factor))
    dead, frontier = set(), [u for u in units if hp[u] <= 0]
    while frontier:
        nxt = []
        for u in frontier:
            if u in dead:
                continue
            dead.add(u)
            if not chain:
                continue
            D, R = EXP[KIND.get(units[u]['def_'], 'geo')]
            for j, v in units.items():
                if j in dead or hp[j] <= 0:
                    continue
                hp[j] -= area(D, R, surface(v, units[u]['x'], units[u]['z'], model, factor))
                if hp[j] <= 0:
                    nxt.append(j)
        frontier = nxt
    return sum(units[u]['metal'] for u in dead), dead


FIT = []   # (def, residual per model) for every nuke hit below full damage


def main():
    for d in sys.argv[1:]:
        units, dmg, deaths, impacts, results, aims = parse(d)
        print('==', d)
        for imp in impacts:
            near = {u: v for u, v in units.items() if math.hypot(v['x'] - imp['x'], v['z'] - imp['z']) < 2500
                    and not (u in deaths and deaths[u] < imp['f'] - 30)}   # already dead before the launch landed
            print('impact shot %d at (%.0f,%.0f) frame %d' % (imp['shot'], imp['x'], imp['z'], imp['f']))
            hits = nuke_hits(near, dmg, imp)
            for u, v in sorted(near.items(), key=lambda kv: math.hypot(kv[1]['x'] - imp['x'], kv[1]['z'] - imp['z'])):
                c = math.hypot(v['x'] - imp['x'], v['z'] - imp['z'])
                h = hits.get(u)
                deff = NR * (1 - h / ND) if h else None
                if deff is not None and h < ND - 1 and Path(d).name.upper().startswith('F'):
                    FIT.append((v['def_'], {m: surface(v, imp['x'], imp['z'], m) - deff for m in ('centre', 'volume', 'footprint', 'radius')},
                                c - deff, v['radius'], v['sx'] / 2))
                died = deaths.get(u)
                print('  %-8s id=%-6d centre=%6.1f nukeHit=%s dEff=%s offset=%s died=%s(+%s) | model dist: vol=%.1f foot=%.1f rad=%.1f' % (
                    v['def_'], u, c, '%.0f' % h if h else '-', '%.1f' % deff if deff is not None else '-',
                    '%.1f' % (c - deff) if deff is not None else '-', died, (died - imp['f']) if died else '-',
                    surface(v, imp['x'], imp['z'], 'volume'), surface(v, imp['x'], imp['z'], 'footprint'),
                    surface(v, imp['x'], imp['z'], 'radius')))
            actual = sum(near[u]['metal'] for u in near if u in deaths and imp['f'] - 30 <= deaths[u] <= imp['f'] + 600)
            row = ['actual=%.0f' % actual]
            for model in ('centre', 'volume', 'footprint', 'radius'):
                row.append('%s: blast=%.0f chain=%.0f' % (model, sim(near, imp, model, chain=False)[0], sim(near, imp, model)[0]))
            print('  ' + ' | '.join(row))
            # radius x 0.77: the def radius scaled to the measured collision offsets
            print('  SUMMARY %s shot=%d actual=%.0f simVolume=%.0f simVolumeNoChain=%.0f simCentre(chain_sim)=%.0f simRadius1.0=%.0f simRadius0.77=%.0f' % (
                Path(d).name, imp['shot'], actual, sim(near, imp, 'volume')[0], sim(near, imp, 'volume', chain=False)[0],
                sim(near, imp, 'centre')[0], sim(near, imp, 'radius')[0], sim(near, imp, 'radius', 0.77)[0]))
        for r in results:
            print('  RESULT', r)
        for a in aims:
            print('  AI aim', a)
    if FIT:
        print('== distance model fit over %d nuke hits (residual = model distance - effective distance from damage)' % len(FIT))
        for m in ('centre', 'volume', 'footprint', 'radius'):
            r = [f[1][m] for f in FIT]
            print('  %-9s rms=%6.1f max|r|=%6.1f mean=%6.1f' % (m, math.sqrt(sum(x * x for x in r) / len(r)), max(abs(x) for x in r), sum(r) / len(r)))
        by = {}
        for f in FIT:
            by.setdefault(f[0], []).append(f)
        for k, fs in sorted(by.items()):
            off = [f[2] for f in fs]
            print('  %-8s n=%d offset mean=%.1f min=%.1f max=%.1f  def radius=%.1f -> factor %.3f  (collision x half %.1f)' % (
                k, len(fs), sum(off) / len(off), min(off), max(off), fs[0][3], sum(off) / len(off) / fs[0][3], fs[0][4]))


if __name__ == '__main__':
    main()
