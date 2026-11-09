#!/usr/bin/env python3
"""Read-only reports on BAR games saved on mcgill-data, run on the node itself.

Run it over SSH without copying it there (stdlib only, reads nothing but the
volumes):

  ssh -o BatchMode=yes mcgill-data-ro python3 -I - <command> [game] [opts] < bar_game.py

Commands:
  list [N]          the last N archived games (default 15), newest first, numbered
  live              the run directory of the game running now (or last unarchived)
  summary GAME      manifest: when, map, outcome, players, AI, lag and load summaries
  files GAME        every file of the game with its size
  lag GAME          how far the engine was behind real time, every 3 min (from
                    engine-timeline.csv when it has data, else from the infolog's
                    [t=][f=] stamps)
  load GAME [MIN]   CPU, sim thread, preemption, CPU pressure, threads, memory per
                    MIN-minute bucket (default 2), from timeline.csv/threads.csv
  logtop GAME [N]   the N most frequent infolog message shapes (numbers folded)
  errors GAME       infolog lines with error/warning/crash/desync, first 60
  config GAME       springsettings.cfg and script.txt

GAME is one of: a number from `list` (1 = newest), `latest`, `live`, a
substring of an archive folder name (map, date, game id), or a full path to an
archive folder or a run directory.
"""
import collections
import csv
import gzip
import io
import json
import os
import re
import sys

ENV = os.environ.get("BAR_ENV", "test")
ARCHIVE = "/mnt/data/k8s-volumes/rjm-bar-archive/%s/games" % ENV
WORK = "/mnt/cache/k8s-volumes/rjm-bar-lobbies/%s/work" % ENV
SOURCE = os.environ.get("BAR_SOURCE", "bar-lobbies.clyde")
RUN_RE = re.compile(r"^\d{8}-\d{6}-\d+$")
STAMP = re.compile(r"^\W*\[t=(\d+):(\d+):(\d+(?:\.\d+)?)\](?:\[f=(-?\d+)\])?")


def die(msg):
    sys.exit("bar_game: " + msg)


def index_rows():
    path = os.path.join(ARCHIVE, "_index", SOURCE + ".jsonl")
    if not os.path.exists(path):
        return []
    with open(path, encoding="utf-8") as f:
        return [json.loads(l) for l in f if l.strip()]


def run_dirs():
    if not os.path.isdir(WORK):
        return []
    return sorted(d for d in os.listdir(WORK) if RUN_RE.match(d))


def resolve(game):
    """An archive folder or run directory for GAME."""
    if game is None:
        die("which game? (a number from list, latest, live, a name substring, or a path)")
    if game.startswith("/"):
        if os.path.isdir(game):
            return game
        die("no such directory: " + game)
    if game == "live":
        runs = run_dirs()
        if not runs:
            die("no run directory in %s (no game running, all archived)" % WORK)
        return os.path.join(WORK, runs[-1])
    rows = index_rows()
    if game == "latest":
        game = "1"
    if game.isdigit():
        n = int(game)
        if not 1 <= n <= len(rows):
            die("no game %d (%d archived)" % (n, len(rows)))
        return os.path.join(ARCHIVE, rows[-n]["folder"])
    hits = [r for r in rows if game.lower() in r["folder"].lower() or game in (r.get("gameId") or "")]
    if not hits:
        die("no archived game matches %r" % game)
    if len(hits) > 1:
        print("(%d games match %r; using the newest)" % (len(hits), game), file=sys.stderr)
    return os.path.join(ARCHIVE, hits[-1]["folder"])


def find(d, *names):
    """The first existing file among names (archive or run-dir layout, .gz or not)."""
    for n in names:
        for p in (os.path.join(d, n), os.path.join(d, n) + ".gz"):
            if os.path.exists(p):
                return p
    return None


def opentext(p):
    if p.endswith(".gz"):
        return io.TextIOWrapper(gzip.open(p), encoding="utf-8", errors="replace")
    return open(p, encoding="utf-8", errors="replace")


def rows_of(d, name):
    p = find(d, "metrics/" + name, name)
    if not p:
        return []
    with opentext(p) as f:
        return list(csv.DictReader(f))


def infolog(d):
    p = find(d, "logs/infolog.txt", "infolog.txt")
    if not p:
        die("no infolog in " + d)
    return opentext(p)


def num(x, default=0.0):
    try:
        return float(x)
    except (TypeError, ValueError):
        return default


def cmd_list(n="15"):
    rows = index_rows()
    print("#  start (UTC)       map                          outcome      min hum lagmax coresP95 mem")
    for i, r in enumerate(reversed(rows[-int(n):]), 1):
        print("%-2d %-17s %-28s %-11s %4s %3s %6s %8s %4s" % (
            i, r.get("startedUtc", "")[:16].replace("T", " "), r.get("map", "")[:28], r.get("outcome", ""),
            int(num(r.get("gameSeconds")) // 60) if r.get("gameSeconds") else "-", r.get("humans", "-"),
            r.get("lagMaxS") if r.get("lagMaxS") is not None else "-", r.get("coresP95", "-"),
            r.get("memPeakGiB", "-")))
    runs = run_dirs()
    if runs:
        print("\nnot archived yet (live or pending) in %s: %s" % (WORK, ", ".join(runs)))


def cmd_live():
    d = resolve("live")
    print(d)
    for name in sorted(os.listdir(d)):
        p = os.path.join(d, name)
        print("  %10s  %s" % (os.path.getsize(p) if os.path.isfile(p) else "dir", name))


def cmd_summary(game):
    d = resolve(game)
    p = os.path.join(d, "manifest.json")
    if not os.path.exists(p):
        g = os.path.join(d, "game.json")
        print("%s: no manifest (a live or partial game)%s" % (d, "; game.json follows" if os.path.exists(g) else ""))
        if os.path.exists(g):
            m = json.load(open(g, encoding="utf-8"))
            for k in ("startedUtc", "map", "founder", "title", "ai", "cpus"):
                print("  %-10s %s" % (k, m.get(k)))
            print("  players   ", [x.get("name") for x in m.get("players", [])])
        return
    m = json.load(open(p, encoding="utf-8"))
    print(d)
    for k in ("startedUtc", "endedUtc", "map", "outcome", "winningAllyTeams", "gameSeconds", "wallclockSeconds",
              "game", "engine", "room", "humans", "bots", "ai", "host", "replay", "replayError"):
        if k in m:
            print("  %-17s %s" % (k, m[k]))
    for group in ("lag", "load"):
        print("  %s:%s" % (group, "" if m.get(group) else " (none)"))
        for k, v in (m.get(group) or {}).items():
            if isinstance(v, dict):
                print("    %-20s " % k + "  ".join("%s %s" % (a, v.get(a)) for a in ("now", "avg", "p95", "max", "min") if a in v))
            else:
                print("    %-20s %s" % (k, v))
    print("  perf:", m.get("perf"))


def cmd_files(game):
    d = resolve(game)
    for root, _, names in sorted(os.walk(d)):
        for n in sorted(names):
            p = os.path.join(root, n)
            print("%10d  %s" % (os.path.getsize(p), os.path.relpath(p, d)))


def cmd_lag(game):
    d = resolve(game)
    et = [r for r in rows_of(d, "engine-timeline.csv") if r.get("behind_s") not in (None, "")]
    if et:
        print("from engine-timeline.csv (the metrics widget)")
        t0 = num(et[0].get("unix_s"))
        nxt = 0
        cols = [c for c in ("behind_s", "sim_fps", "ping_s", "cpu", "units") if c in et[0]]
        print("min   " + "  ".join("%8s" % c for c in cols))
        for r in et:
            t = num(r.get("unix_s")) - t0
            if t >= nxt:
                print("%4.0f  " % (t / 60) + "  ".join("%8s" % r.get(c, "") for c in cols))
                nxt += 180
        print("max behind %.1f s" % max(num(r["behind_s"]) for r in et))
        return
    print("from infolog [t=][f=] stamps (no widget data); assumes the server ran at speed 1.0")
    pts = []
    with infolog(d) as f:
        for line in f:
            m = STAMP.match(line)
            if m and m.group(4) and int(m.group(4)) > 0:
                pts.append((int(m.group(1)) * 3600 + int(m.group(2)) * 60 + float(m.group(3)), int(m.group(4))))
    if not pts:
        die("no frame stamps in the infolog (the game never started?)")
    t0 = pts[0][0] - pts[0][1] / 30.0
    print("game min  behind s  sim speed (vs real time, last 3 min)")
    nxt, last, worst = 0, None, 0.0
    for t, f in pts:
        behind = (t - t0) - f / 30.0
        worst = max(worst, behind)
        if t - t0 >= nxt:
            speed = "" if last is None else "%5.0f%%" % (100.0 * (f - last[1]) / 30.0 / max(t - last[0], 1e-6))
            print("%7.0f  %8.1f  %s" % (f / 1800.0, behind, speed))
            last, nxt = (t, f), nxt + 180
    t, f = pts[-1]
    print("end %5.0f  %8.1f   (max %.1f s)" % (f / 1800.0, (t - t0) - f / 30.0, worst))


def cmd_load(game, minutes="2"):
    d = resolve(game)
    rows = rows_of(d, "timeline.csv")
    if not rows:
        die("no timeline.csv in " + d)
    width = int(minutes) * 60
    t0 = num(rows[0]["unix_s"]) - num(rows[0].get("t_s"))
    workers = collections.defaultdict(float)
    counts = collections.Counter()
    for r in rows_of(d, "threads.csv"):
        b = int((num(r["unix_s"]) - t0) // width)
        if r.get("name", "").startswith("worker"):
            workers[b] += num(r.get("cores"))
    buckets = collections.defaultdict(list)
    for r in rows:
        b = int(num(r.get("t_s")) // width)
        buckets[b].append(r)
        counts[b] += 1

    def avg(g, c):
        return sum(num(x.get(c)) for x in g) / len(g)

    print("min  cores  sim-thr  preempt/s  cpuPress%  workers  threads  memGiB  top threads (last sample)")
    for b in sorted(buckets):
        g = buckets[b]
        print("%3d  %5.2f  %7.2f  %9.0f  %9.1f  %7.2f  %7.0f  %6.2f  %s" % (
            b * width // 60, avg(g, "cores"), avg(g, "main_thread_cores"), avg(g, "main_preempt_per_s"),
            avg(g, "cpu_pressure_pct"), workers[b] / counts[b], avg(g, "engine_threads"), avg(g, "mem_gib"),
            g[-1].get("top_threads", "")[:70]))


def cmd_logtop(game, n="25"):
    d = resolve(game)
    c = collections.Counter()
    total = 0
    with infolog(d) as f:
        for line in f:
            total += 1
            s = STAMP.sub("", line).strip()
            s = re.sub(r"-?\d+(\.\d+)?", "N", s)[:110]
            c[s] += 1
    print("%d lines" % total)
    for s, k in c.most_common(int(n)):
        print("%7d  %s" % (k, s))


def cmd_errors(game):
    d = resolve(game)
    pat = re.compile(r"error|warning|crash|desync|exception|assert|segfault|lua.*fail", re.I)
    shown = 0
    with infolog(d) as f:
        for line in f:
            if pat.search(line) and "exceeds bitset limit" not in line and "CrashHandler" not in line:
                print(line.rstrip()[:220])
                shown += 1
                if shown >= 60:
                    print("... (more; zgrep the infolog)")
                    break


def cmd_config(game):
    d = resolve(game)
    for name in ("config/springsettings.cfg", "springsettings.cfg", "config/script.txt", "script.txt"):
        p = find(d, name)
        if p:
            print("== " + os.path.relpath(p, d))
            with opentext(p) as f:
                print(f.read())


COMMANDS = {"list": cmd_list, "live": cmd_live, "summary": cmd_summary, "files": cmd_files, "lag": cmd_lag,
            "load": cmd_load, "logtop": cmd_logtop, "errors": cmd_errors, "config": cmd_config}

if __name__ == "__main__":
    if len(sys.argv) < 2 or sys.argv[1] not in COMMANDS:
        print(__doc__)
        sys.exit(2)
    COMMANDS[sys.argv[1]](*sys.argv[2:])
