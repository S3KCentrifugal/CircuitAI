"""Antinuke-cover scenarios (owner 2026-11-03): layouts + a mirror of the DLL's nuke scoring
(SelectAreaTarget/ChainKill/CoverEdgeAims, antinuke factor 0.70 per covering antinuke, floor 0.05).
python scenarios.py            -> prints the model's best aims per scenario
python scenarios.py --lua S1   -> prints the fixture's unit list for scenario S1
"""
import math, sys

ND, NR = 15000.0, 960.0
DEF = {  # hp, metal, volume (cyl radius | box half x, half z), death blast (damage, radius)
    'corafus': (9400, 9700, ('cyl', 42), (10600, 640)),
    'corageo': (4150, 1500, ('cyl', 48), (10600, 640)),
    'armamd': (3300, 1500, ('box', 26.5, 26.5), (28, 32)),
}
COVER, MARGIN, FACTOR, FLOOR = 2000.0, 64.0, 0.70, 0.05


def block(cx, cz, n, cols, step=160):
    rows = math.ceil(n / cols)
    out = []
    for i in range(n):
        r, c = divmod(i, cols)
        out.append(('corafus', cx + (c - (cols - 1) / 2) * step, cz + (r - (rows - 1) / 2) * step, 100))
    return out


def anti(x, z):
    return [('armamd', x, z, 100)]


S = {
    # 1 = 2a: 4 AFUS under one antinuke (1000 away) vs 3 uncovered AFUS far away
    'S1': anti(9000, 2500) + block(9000, 3500, 4, 2) + block(6000, 9000, 3, 3),
    # 2b: 5 under one antinuke vs the same 3 uncovered
    'S2': anti(9000, 2500) + block(9000, 3550, 5, 3) + block(6000, 9000, 3, 3),
    # 3a: 2 under one antinuke vs 2 under two antinukes
    'S3a': anti(5000, 2500) + block(5000, 3500, 2, 2) + anti(9000, 2500) + anti(9200, 2500) + block(9100, 3500, 2, 2),
    # 3b: 2 under one antinuke vs 3 under two antinukes
    'S3b': anti(5000, 2500) + block(5000, 3500, 2, 2) + anti(9000, 2500) + anti(9200, 2500) + block(9100, 3500, 3, 3),
    # 4: edge chain - antinuke at A, an AFUS at 960 hurt to 4,000 HP, an advanced geo at 1,380 on the same line
    'S4': anti(9000, 3000) + [('corafus', 9000, 3960, 4000 / 9400 * 100), ('corageo', 9000, 4380, 100)],
    # 4 control: no geo
    'S4c': anti(9000, 3000) + [('corafus', 9000, 3960, 4000 / 9400 * 100)],
}


def surf(u, p):
    d, x, z = DEF[u[0]][2], p[0] - u[1], p[1] - u[2]
    if d[0] == 'cyl':
        return max(0.0, math.hypot(x, z) - d[1])
    return math.hypot(max(0.0, abs(x) - d[1]), max(0.0, abs(z) - d[2]))


def dmg(D, R, d):
    return 0.0 if d >= R else D * (R - d) / R


def chain(units, aim):
    hp = [DEF[u[0]][0] * u[3] / 100 - dmg(ND, NR, surf(u, aim)) for u in units]
    dead, frontier = set(), [i for i, h in enumerate(hp) if h <= 0]
    while frontier:
        nxt = []
        for i in frontier:
            if i in dead:
                continue
            dead.add(i)
            D, R = DEF[units[i][0]][3]
            for j, u in enumerate(units):
                if j in dead or hp[j] <= 0:
                    continue
                hp[j] -= dmg(D, R, surf(u, (units[i][1], units[i][2])))
                if hp[j] <= 0:
                    nxt.append(j)
        frontier = nxt
    return sum(DEF[units[i][0]][1] for i in dead), sorted(dead)


def cover(ics, p):
    return sum(1 for a in ics if math.hypot(p[0] - a[0], p[1] - a[1]) < COVER + MARGIN)


def best(units):
    ics = [(u[1], u[2]) for u in units if u[0] == 'armamd']
    aims = [(u[1], u[2], 'on ' + u[0]) for u in units]
    for a in ics:
        mine = []
        for u in units:
            d = math.hypot(u[1] - a[0], u[2] - a[1])
            if d >= COVER + MARGIN or d < 1:
                continue
            r = COVER + MARGIN + 8
            p = (a[0] + (u[1] - a[0]) / d * r, a[1] + (u[2] - a[1]) / d * r)
            if all(math.hypot(p[0] - q[0], p[1] - q[1]) >= 128 for q in mine):
                mine.append(p)
        aims += [(p[0], p[1], 'edge') for p in mine]
    out = []
    for x, z, kind in aims:
        if not any(math.hypot(u[1] - x, u[2] - z) < NR for u in units):
            continue
        n = cover(ics, (x, z))
        f = 1.0 if n == 0 else max(FLOOR, FACTOR ** n)
        m, dead = chain(units, (x, z))
        out.append((m * f, m, n, f, x, z, kind, len(dead)))
    return sorted(out, reverse=True)


if __name__ == '__main__':
    if len(sys.argv) > 2 and sys.argv[1] == '--lua':
        print('{' + ','.join('{"%s",%d,%d,%.3f}' % (u[0], round(u[1]), round(u[2]), u[3]) for u in S[sys.argv[2]]) + '}')
        sys.exit(0)
    for k, units in S.items():
        print('==', k)
        for v, m, n, f, x, z, kind, nd in best(units)[:4]:
            print('  score %7.0f  = killed %6.0f x %.3f (covering %d)  aim (%5.0f,%5.0f) %s  dead=%d' % (v, m, f, n, x, z, kind, nd))
