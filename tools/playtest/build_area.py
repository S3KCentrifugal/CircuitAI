#!/usr/bin/env python3
"""
Render and measure a map's buildable ground from the build_area widget's survey.

    python tools/playtest/build_area.py <infolog> [--out map.png] [--spot x,z ...] [--radius 1600,3000]

Reads the "[BuildArea]" rows (widgets/build_area.lua) and draws one pixel block
a cell: water blue, unbuildable land dark, turret-only ground grey, trees green,
lab ground tan, advanced-fusion ground light. For each --spot it prints, within
each radius, the land area by class and the count of separate lab-sized flat
patches (connected components of L/A cells), the numbers a layout choice needs.
"""
import argparse
import math
import re

COLORS = {
    "w": (90, 130, 180), "~": (40, 80, 160), "W": (20, 40, 110), "#": (45, 40, 38), "f": (40, 110, 50), "n": (120, 120, 120),
    "L": (200, 170, 110), "A": (240, 225, 180),
}


def read(path):
    rows, cell, w, h = [], 64, 0, 0
    with open(path, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if "[BuildArea] begin" in line:
                m = re.search(r"begin (\d+) (\d+) (\d+)", line)
                w, h, cell = int(m.group(1)), int(m.group(2)), int(m.group(3))
                rows = []
            elif "[BuildArea] r " in line:
                rows.append(line.split("[BuildArea] r ", 1)[1].strip())
    return rows, cell, w, h


def components(rows, keep, cells):
    seen, sizes = set(), []
    for start in cells:
        if start in seen:
            continue
        stack, n = [start], 0
        seen.add(start)
        while stack:
            x, z = stack.pop()
            n += 1
            for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                q = (x + dx, z + dz)
                if q in cells and q not in seen:
                    seen.add(q)
                    stack.append(q)
        sizes.append(n)
    return sorted(sizes, reverse=True)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("infolog")
    ap.add_argument("--out")
    ap.add_argument("--spot", action="append", default=[])
    ap.add_argument("--radius", default="1600,3000")
    ap.add_argument("--scale", type=int, default=4)
    a = ap.parse_args()
    rows, cell, w, h = read(a.infolog)
    if not rows:
        raise SystemExit("no [BuildArea] survey in " + a.infolog)
    area = cell * cell
    spots = [tuple(float(v) for v in s.split(",")) for s in a.spot]
    radii = [float(r) for r in a.radius.split(",")]
    for sx, sz in spots:
        for r in radii:
            counts = {k: 0 for k in COLORS}
            counts.setdefault("f", 0)
            lab = set()
            for iz, row in enumerate(rows):
                for ix, c in enumerate(row):
                    x, z = ix * cell + cell / 2, iz * cell + cell / 2
                    if (x - sx) ** 2 + (z - sz) ** 2 > r * r:
                        continue
                    counts[c] = counts.get(c, 0) + 1
                    if c in "LA":
                        lab.add((ix, iz))
            water = counts["w"] + counts["~"] + counts["W"]
            land = sum(counts.values()) - water
            comp = components(rows, "LA", lab)
            print("spot (%d, %d) within %d: land %.2f Mm2 (water %.2f: floatable %.2f, 25+ deep %.2f): lab ground %.2f, afus ground %.2f, turret-only %.2f, trees %.2f, unbuildable %.2f; "
                  "lab patches %d, largest %s cells" % (
                      sx, sz, r, land * area / 1e6, water * area / 1e6, (counts["~"] + counts["W"]) * area / 1e6, counts["W"] * area / 1e6,
                      (counts["L"] + counts["A"]) * area / 1e6, counts["A"] * area / 1e6, counts["n"] * area / 1e6,
                      counts["f"] * area / 1e6, counts["#"] * area / 1e6, len(comp), comp[:5]))
    if a.out:
        from PIL import Image, ImageDraw
        s = a.scale
        img = Image.new("RGB", (len(rows[0]) * s, len(rows) * s))
        d = ImageDraw.Draw(img)
        for iz, row in enumerate(rows):
            for ix, c in enumerate(row):
                d.rectangle([ix * s, iz * s, ix * s + s - 1, iz * s + s - 1], fill=COLORS.get(c, (255, 0, 255)))
        for sx, sz in spots:
            px, pz = sx / cell * s, sz / cell * s
            for r in radii:
                rr = r / cell * s
                d.ellipse([px - rr, pz - rr, px + rr, pz + rr], outline=(255, 60, 60), width=2)
            d.ellipse([px - 5, pz - 5, px + 5, pz + 5], fill=(255, 60, 60))
        img.save(a.out)
        print("image:", a.out)


if __name__ == "__main__":
    main()
