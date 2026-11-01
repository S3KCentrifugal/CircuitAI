"""Backline coverage of spam routes: for each enemy start, how close the spam units came
and how many passed within --radius. Reads tools/playtest/spam_lanes output dirs.

Usage: python coverage.py --repo <CircuitAI worktree> --out <batch dir> [--radius 800]"""
import argparse
import re
import sys
from pathlib import Path


def starts(d):
    """(team, allyteam, x, z) per team from the staged script.txt."""
    s = (d / "script.txt").read_text(errors="replace")
    out = []
    for m in re.finditer(r"\[TEAM(\d+)\]\s*\{([^}]*)\}", s, re.S):
        b = m.group(2)
        a = re.search(r"AllyTeam=(\d+);", b)
        x = re.search(r"StartPosX=(\d+);", b)
        z = re.search(r"StartPosZ=(\d+);", b)
        if a and x and z:
            out.append((int(m.group(1)), int(a.group(1)), int(x.group(1)), int(z.group(1))))
    return out


def segd(px, pz, a, b):
    ax, az = a
    bx, bz = b
    dx, dz = bx - ax, bz - az
    L = dx * dx + dz * dz
    t = 0 if L == 0 else max(0.0, min(1.0, ((px - ax) * dx + (pz - az) * dz) / L))
    return ((px - ax - t * dx) ** 2 + (pz - az - t * dz) ** 2) ** 0.5


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--repo", type=Path, required=True)
    ap.add_argument("--out", type=Path, required=True)
    ap.add_argument("--radius", type=float, default=800)
    a = ap.parse_args()
    sys.path.insert(0, str(a.repo / "tools" / "playtest" / "spam_lanes"))
    import parse
    r2 = a.radius ** 2
    lines = ["# Spam backline coverage", "", "Per enemy start: spam units (all lanes) whose walked trail came within %d elmos, "
             "the closest any came, and the first time one did. Per lane: which enemy starts it passed." % a.radius, ""]
    for d in sorted(p for p in a.out.iterdir() if p.is_dir() and (p / "script.txt").exists()):
        g = parse.load(d)
        if g is None:
            continue
        st = starts(d)
        ours = {t for t, al, x, z in st if al == 0}
        enemy = [(t, x, z) for t, al, x, z in st if al == 1]
        spam = {u: tr for u, tr in g["trails"].items() if tr["team"] in ours}
        lines += ["## %s" % g["mapname"], "", "Spam units with a trail: %d; trails to %s." % (len(spam), parse.clock(g["end_frame"])), "",
                  "| Enemy start | Units within %d | Closest | First at |" % a.radius, "| --- | --- | --- | --- |"]
        covered = 0
        for t, ex, ez in enemy:
            n, best, first = 0, 1e18, None
            for u, tr in spam.items():
                hit = False
                for k, (x, z) in enumerate(tr["pts"]):
                    dd = (x - ex) ** 2 + (z - ez) ** 2
                    best = min(best, dd)
                    if dd <= r2 and not hit:
                        hit = True
                        f = tr["born"] + 150 * k   # samples every 5 s
                        first = f if first is None else min(first, f)
                n += hit
            covered += n > 0
            lines.append("| team %d (%d,%d) | %d | %d | %s |" % (t, ex, ez, n, best ** 0.5, parse.clock(first) if first else "-"))
        lines += ["", "**%d of %d enemy starts reached by walked trails** (includes units released at a lane's end "
                  "to normal attacks, and units that died near a spawn)." % (covered, len(enemy)), ""]
        # planned routes only: distance from each enemy start to each lane's polyline
        lines += ["Planned routes (the lanes' waypoint lines, no attack-move after release):", "",
                  "| Enemy start | Lanes passing within %d | Nearest lane line |" % a.radius, "| --- | --- | --- |"]
        pcov = 0
        for t, ex, ez in enemy:
            n, best = 0, 1e18
            for (team, key), p in g["plans"].items():
                if team not in ours or len(p["pts"]) < 2:
                    continue
                dmin = min(segd(ex, ez, p["pts"][i], p["pts"][i + 1]) for i in range(len(p["pts"]) - 1))
                best = min(best, dmin)
                n += dmin <= a.radius
            pcov += n > 0
            lines.append("| team %d (%d,%d) | %d | %d |" % (t, ex, ez, n, best))
        lines += ["", "**%d of %d enemy starts on a planned lane line.**" % (pcov, len(enemy)), "", "Lanes:", ""]
        for (team, key), p in sorted(g["plans"].items(), key=lambda kv: (kv[0][0], kv[0][1])):
            us = [u for u in g["units"].get((team, key), []) if u in spam]
            hits = []
            for t, ex, ez in enemy:
                c = sum(1 for u in us if any((x - ex) ** 2 + (z - ez) ** 2 <= r2 for x, z in spam[u]["pts"]))
                if c:
                    hits.append("t%d:%d" % (t, c))
            lines.append("- team %d %s %s, %d units, plan %s; passed %s" % (team, g["roles"].get(team, "?"), p["kind"] if key != "edge" else p["kind"],
                         len(us), parse.text(p["pts"]), " ".join(hits) or "no enemy start"))
        lines.append("")
    text = "\n".join(lines) + "\n"
    (a.out / "COVERAGE.md").write_text(text, encoding="utf-8")
    print(text)


if __name__ == "__main__":
    main()
