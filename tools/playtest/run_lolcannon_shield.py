"""Lolcannon vs shields arena, headless (owner 2026-11-20).

One game per cannon (armvulc Ragnarok, corbuzz Calamity, legstarfall Starfall)
and target (an advanced fusion or a fusion). Full Metal Plate (12288 square,
cannot be dug). The host plays team 1 (ally 1) and owns the cannons; team 0 is
NullAI and owns the targets and the shields. widgets/lolcannon_shield_arena.lua
runs five lanes per round: a target RANGE elmos from its lane's cannon with N
shields (Keeper armgate, radius 550) laid out round it (ring 260 out; random
130-440 out; front: half round it, half on the line of fire in front), all
charged to full, then the cannon attacks it until it dies or TIMEOUT. Each
trial logs one "[LolShield] RESULT" line; summarize() reads them.

Rules: BelowNormal priority (BAR_PLAYTEST_LOW_PRIORITY=1; Idle crashed 16-AI
loads), x10, at most 3 spring-headless on the PC (waits for a slot), a
watchdog (no new log line for STALL s, or WALL min) stops the game.
"""
import argparse
import json
import os
import re
import statistics
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
SPEED = {'armvulc': 900.0, 'corbuzz': 950.0, 'legstarfall': 900.0}
MUZZLE = {'armvulc': 133.0, 'corbuzz': 118.0, 'legstarfall': 120.0}
LIVE_DLL = Path(r'C:\Users\artib\BAR\lolshield-runs\dll\SkirmishAI.dll')  # a copy with no .dbg beside it (no symbol store)


def headless_count():
    out = subprocess.run(['powershell', '-NoProfile', '-Command',
                          '@(Get-Process spring-headless -ErrorAction SilentlyContinue).Count'],
                         capture_output=True, text=True).stdout.strip()
    try:
        return int(out or 0)
    except ValueError:
        return 0


def trials(args):
    out = []
    seed = args.seed
    counts = [int(c) for c in args.counts.split(',')]
    for n in counts:
        for layout, reps in (('ring', args.ring_reps), ('random', args.random_reps), ('front', args.front_reps)):
            if n == 0 and layout != 'ring':
                continue
            if layout == 'front' and (args.cannon == 'legstarfall' or n < 2):
                continue
            for _ in range(reps if n > 0 else reps + (args.random_reps if layout == 'ring' else 0)):
                seed += 7919
                out.append({'n': n, 'layout': layout, 'seed': seed})
    return out


def stage(args, d):
    d.mkdir(parents=True, exist_ok=True)
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    starts = d / 'arena-starts.as'
    starts.write_text('StartSpot(AIFloat3(11500,0,11500), AiRole::TECH, false),' + chr(10)
                      + 'StartSpot(AIFloat3(700,0,700), AiRole::TECH, false),' + chr(10))
    subprocess.run(cmd + ['stage', '--dir', str(d), '--map-file', str(starts), '--dll', str(args.dll), '--data', str(ROOT / 'data'),
                          '--engine', args.engine, '--map', 'Full Metal Plate 1.7', '--isolated',
                          '--role', 'TECH', '--roles', 'TECH', '--side', 'armada', '--others', 'none', '--bonus', '0',
                          '--modoption', 'deathmode=neverend', '--modoption', 'allowuserwidgets=1',
                          '--modoption', 'allowunitcontrolwidgets=1', '--modoption', 'experimentalextraunits=1',
                          '--speed', str(args.speed), '--minutes', str(args.minutes), '--headless', '--lean-render',
                          '--extra-widget', str(HERE / 'widgets/lolcannon_shield_arena.lua')], cwd=ROOT, check=True)
    script = d / 'script.txt'
    s = script.read_text(encoding='utf-8')
    head = s[:s.index('\t[ALLYTEAM0]')]
    tail = ('\t[ALLYTEAM0] { NumAllies=0; }\n\t[ALLYTEAM1] { NumAllies=0; }\n'
            '\t[PLAYER0] { Name=Playtest; Spectator=0; Team=1; IsFromDemo=0; Rank=0; }\n'
            '\t[TEAM1] { AllyTeam=1; TeamLeader=0; Side=armada; RgbColor=0.2 0.6 1.0; StartPosX=700; StartPosZ=700; Handicap=0; }\n'
            '\t[TEAM0] { AllyTeam=0; TeamLeader=0; Side=armada; RgbColor=1.0 0.5 0.1; StartPosX=11500; StartPosZ=11500; Handicap=0; }\n'
            '\t[AI0] { ShortName=NullAI; Version=0.1; Name=Targets; Team=0; Host=0; IsFromDemo=0; }\n}\n')
    script.write_text(head + tail, encoding='utf-8')
    ts = trials(args)
    lua = 'return {\n  cannon=%r, target=%r, shield=%r, range=%d, cannonX=%d, laneZ={%s}, mapSize=12288,\n' % (
        args.cannon, args.target, args.shield, args.range, args.cannon_x, ','.join(str(z) for z in args.lanes))
    lua += '  speed=%.1f, muzzle=%.1f, high=%s, timeout=%d, chargeTo=6100, chargeMax=70, hitRadius=150,\n' % (
        SPEED[args.cannon], MUZZLE[args.cannon], 'true' if args.cannon == 'legstarfall' else 'false', args.timeout)
    lua += '  fireState=%d,' % args.fire_state + chr(10)
    lua += '  trials={\n' + ''.join('    {n=%d, layout=%r, seed=%d},\n' % (t['n'], t['layout'], t['seed']) for t in ts) + '  },\n}\n'
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/lolshield_arena.lua').write_text(lua.replace("'", '"'), encoding='utf-8')
    (d / 'arena.json').write_text(json.dumps({'args': {k: str(v) for k, v in vars(args).items()}, 'trials': len(ts)}, indent=2))
    return len(ts)


def run(args, d):
    sys.path.insert(0, str(HERE))
    from playtest import running_pids
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    while headless_count() >= 3:
        print('[arena] 3 headless games running; waiting for a slot', flush=True)
        time.sleep(30)
    env = dict(os.environ, BAR_PLAYTEST_LOW_PRIORITY='1')
    subprocess.run(cmd + ['launch', '--dir', str(d), '--headless', '--engine', args.engine], cwd=ROOT, check=True, env=env)
    info = d / 'infolog.txt'
    start = time.time()
    last_size, last_change = -1, time.time()
    verdict = 'wall'
    try:
        while time.time() - start < args.wall * 60:
            time.sleep(10)
            size = info.stat().st_size if info.exists() else 0
            text = info.read_text(errors='replace') if info.exists() else ''
            # progress = new arena lines (the engine's heartbeat keeps the file growing regardless)
            marks = text.count('[LolShield]')
            if marks != last_size:
                last_size, last_change = marks, time.time()
            if '[LolShield] DONE' in text:
                verdict = 'done'
                break
            if 'ERROR cannons missing' in text:
                verdict = 'setup-error'
                break
            if time.time() - last_change > args.stall:
                verdict = 'stall'
                break
            if size and not running_pids(d):
                verdict = 'exited'
                break
    finally:
        subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)
    (d / 'verdict.txt').write_text(verdict + '\n')
    print('[arena] %s: %s' % (d.name, verdict), flush=True)
    return verdict


RESULT = re.compile(r'\[LolShield\] RESULT (.*)')


def parse(d):
    rows = []
    info = d / 'infolog.txt'
    if not info.exists():
        return rows
    for m in RESULT.finditer(info.read_text(errors='replace')):
        row = {}
        for kv in m.group(1).split():
            k, _, v = kv.partition('=')
            try:
                row[k] = float(v) if re.fullmatch(r'-?\d+(\.\d+)?', v) else v
            except ValueError:
                row[k] = v
        rows.append(row)
    return rows


def p90(values):
    v = sorted(values)
    if not v:
        return None
    k = max(0, min(len(v) - 1, int(round(0.9 * len(v) + 0.5)) - 1))
    return v[k]


def summarize(dirs):
    rows = []
    for d in dirs:
        rows += parse(Path(d))
    cells = {}
    for r in rows:
        if r['fired'] == 0 or (r.get('reorders', 0) > 0 and r['cannon'] != 'legstarfall'):   # a Starfall reloads 14 s: its re-orders are harmless
            continue   # the gun stopped firing (a lost order, the Calamity's stall): not a measurement
        # key by the shields the shot actually passes (a random layout can place fewer than asked)
        cells.setdefault((r['cannon'], r['target'], int(r.get('arc_shields', r['n']))), []).append(r)
    lines = ['cannon target n trials dead% t_kill_median t_kill_p90 fired_median absorbed_median hits_median breaks_median along_sd side_sd']
    for key in sorted(cells):
        rs = cells[key]
        dead = [r for r in rs if r['dead'] == 1]
        tk = [r['t_kill'] for r in dead]
        # a trial that did not kill counts as the timeout (worst case) in the p90
        tk_all = tk + [1e9] * (len(rs) - len(dead))
        med = lambda xs: statistics.median(xs) if xs else float('nan')
        lines.append('%s %s %d %d %.0f %.1f %s %.0f %.0f %.0f %.0f %.0f %.0f' % (
            key[0], key[1], key[2], len(rs), 100.0 * len(dead) / len(rs), med(tk),
            ('%.1f' % p90(tk_all)) if p90(tk_all) < 1e8 else 'never', med([r['fired'] for r in rs]),
            med([r['absorbed'] for r in rs]), med([r['hits'] for r in rs]), med([r['breaks'] for r in rs]),
            med([r['along_sd'] for r in rs]), med([r['side_sd'] for r in rs])))
    return '\n'.join(lines)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('command', choices=['run', 'stage', 'summarize'])
    p.add_argument('--dir', type=Path, nargs='+', required=True)
    p.add_argument('--cannon', choices=list(SPEED), default='armvulc')
    p.add_argument('--target', default='legafus')
    p.add_argument('--shield', default='armgate')
    p.add_argument('--counts', default='0,1,2,3,4,5,6,7,8')
    p.add_argument('--ring-reps', type=int, default=6)
    p.add_argument('--random-reps', type=int, default=4)
    p.add_argument('--front-reps', type=int, default=0)
    p.add_argument('--seed', type=int, default=1651)
    p.add_argument('--range', type=int, default=4800)
    p.add_argument('--cannon-x', type=int, default=1500)
    p.add_argument('--lanes', type=lambda s: [int(x) for x in s.split(',')], default=[1300, 3700, 6100, 8500, 10900])
    p.add_argument('--timeout', type=int, default=180, help='game seconds of fire before a trial counts as not killed')
    p.add_argument('--speed', type=float, default=10)
    p.add_argument('--minutes', type=float, default=600)
    p.add_argument('--wall', type=float, default=120, help='wall minutes before the watchdog stops the game')
    p.add_argument('--stall', type=float, default=300, help='wall seconds with no new log line')
    p.add_argument('--engine', default='recoil_2026.09.03')
    p.add_argument('--fire-state', type=int, default=0, help='cannon fire state: 0 hold, 2 fire at will')
    p.add_argument('--dll', type=Path, default=LIVE_DLL)
    a = p.parse_args()
    if a.command == 'summarize':
        print(summarize(a.dir))
        return 0
    d = a.dir[0].resolve()
    n = stage(a, d)
    print('[arena] staged %d trials in %s' % (n, d), flush=True)
    if a.command == 'stage':
        return 0
    run(a, d)
    print(summarize([d]))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
