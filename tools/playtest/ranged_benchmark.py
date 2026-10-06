"""Summarize immutable ranged fixtures, or run a serial supplied-force matrix.

These measurements describe this fixture, not multiplayer FPS. Keep failed
runs and their pins; never overwrite a prior result with a better trial.
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def summarize(directory):
    directory = Path(directory)
    cfg = json.loads((directory / 'ranged-arena.json').read_text())
    text = (directory / 'infolog.txt').read_text(errors='replace')
    units, shooters, deaths, orders, first, damage = {}, set(), [], 0, None, 0
    positions, separations, shots, samples = {}, [], [], []
    fps, cloaked, children, friendly_damage = [], set(), {}, 0
    order_frame = last_frame = 0
    spawned, sensor_advance = {}, {}
    dx = cfg.get('starts', [[0,0],[0,1]])[1][0] - cfg.get('starts', [[0,0],[0,1]])[0][0]
    dz = cfg.get('starts', [[0,0],[0,1]])[1][1] - cfg.get('starts', [[0,0],[0,1]])[0][1]
    norm = max(1, (dx*dx+dz*dz)**.5)
    for line in text.splitlines():
        if '[WorkforcePerf]' in line and 'ai_all_p95_ms=' in line:
            sample = {k: float(v) for k, v in re.findall(r'(\w+)=([\d.]+)', line)}
            if sample.get('frame', 0) <= cfg['minutes']*1800:
                samples.append(sample)
        if '[RangedArena] frame=' not in line:
            continue
        row = dict(re.findall(r'(\w+)=([^ ]+)', line))
        # A process stop can truncate any final event, not only positions.
        event=re.search(r'\[RangedArena\] frame=\d+ (\w+)',line)
        required={'spawn':('id','unit','team','x','z'), 'unit':('id','unit','x','z','hp','host'),
                  'orders':('team','nonlua','lua'), 'death':('id','team','unit','cost'),
                  'damage':('id','team','amount','attacker','attackerTeam','weapon'),
                  'shot':('id','unit','weapon','target','distance','intent'), 'render':('fps',)}
        if event and not all(k in row for k in required.get(event[1],())): continue
        frame = int(row['frame'])
        last_frame = max(last_frame, frame)
        # Watcher shutdown includes a grace interval. Compare the same game
        # window across runs instead of counting whichever extra frames ran.
        if frame > cfg['minutes']*1800: continue
        if ' spawn ' in line:
            units[int(row['id'])] = (row['unit'], int(row['team']))
            if 'x' in row: spawned[int(row['id'])] = (int(row['x']),int(row['z']))
        if ' child ' in line:
            host = int(row.get('host', row.get('parent', -1)))
            children[int(row['id'])] = host
        if ' render fps=' in line and frame >= 1800:
            fps.append(float(row['fps']))
        if ' unit id=' in line and row.get('cloak') == 'true':
            cloaked.add(int(row['id']))
        if ' shot ' in line and row['unit'] in cfg.get('units', [cfg['unit']]):
            shooters.add(int(row['id']))
            shots.append(row)
        if ' damage ' in line and row.get('attackerTeam') == '0':
            attacker = int(row['attacker'])
            attacker = children.get(attacker, attacker)
            if units.get(attacker, ('', -1))[0] in cfg.get('units', [cfg['unit']]):
                damage += max(0, int(row['amount']))
                first = frame if first is None else first
                if row['team'] == '0': friendly_damage += max(0, int(row['amount']))
        if ' death ' in line:
            deaths.append(row)
        if ' orders ' in line and row['team'] == '0':
            orders = int(row['nonlua'])
            order_frame = frame
        # The watcher can stop the engine while the final log line is being
        # written. Incomplete position rows supply no geometry evidence.
        if ' unit id=' in line and 'x' in row and 'z' in row and row.get('unit') in cfg.get('sensor_units', []):
            origin = spawned.get(int(row['id']))
            if origin:
                advance = ((int(row['x'])-origin[0])*dx+(int(row['z'])-origin[1])*dz)/norm
                sensor_advance[row['unit']] = max(sensor_advance.get(row['unit'],0),advance)
        if ' unit id=' in line and 'x' in row and 'z' in row and row.get('unit') in cfg.get('units', [cfg['unit']]):
            positions.setdefault(frame, []).append((int(row['x']), int(row['z'])))
    for frame, points in positions.items():
        if frame < 1800 or len(points) < 2:
            continue
        separations.append(min(((a[0]-b[0])**2+(a[1]-b[1])**2)**.5
                               for i, a in enumerate(points) for b in points[:i]))
    watched = cfg.get('units', [cfg['unit']])
    losses = [d for d in deaths if d['team'] == '0' and d['unit'] in watched]
    unrelated = [d for d in deaths if d['team'] == '0' and d['unit'] not in watched]
    kills = [d for d in deaths if d['team'] == '1']
    checks = cfg.get('assertions', {})
    failures = []
    assigned_types = sorted(set(re.findall(r'RANGED: assigned (\w+)\(', text)))
    if len(assigned_types) < checks.get('min_types_assigned',0): failures.append('missing ranged unit admissions')
    if len(kills) < checks.get('min_kills', 1): failures.append('insufficient target kills')
    if len(shooters) < checks.get('min_shooters', 1) and cfg['unit'] != 'legvcarry': failures.append('no verified shots')
    if len(shots) > checks.get('max_shots', float('inf')): failures.append('unexpected shots')
    if len(losses) > checks.get('max_losses', 0): failures.append('ranged casualties')
    if len(unrelated) < checks.get('min_unrelated_losses', 0): failures.append('unrelated death not exercised')
    if len(cloaked) < checks.get('min_cloaked', 0): failures.append('cloak never observed')
    if friendly_damage > checks.get('max_friendly_damage', float('inf')): failures.append('friendly splash damage')
    for name in cfg.get('sensor_units', []):
        if sensor_advance.get(name,0) < checks.get('min_sensor_advance',0): failures.append('sensor did not advance: '+name)
    if last_frame < cfg['minutes']*1800-300: failures.append('incomplete observation window')
    archives = sorted((directory/'runs').glob('*/result.json'))
    verdict = json.loads(archives[-1].read_text()).get('verdict') if archives else None
    if verdict and verdict != 'PASS': failures.append('original watch verdict: '+verdict)
    if re.search(r'\[INVARIANT\]|\[RangedArena\].*ERROR|Error in.*ranged_arena', text): failures.append('runtime/fixture error')
    result = dict(schema=5, case=cfg['name'], variant=cfg['variant'], seed=cfg['seed'], directory=str(directory),
                  measurement_deadline_frame=cfg['minutes']*1800,
                  first_damage_seconds=first/30 if first else None, raw_damage_including_overkill=damage,
                  shooters_fired=len(shooters), shots=len(shots), enemy_kills=len(kills), friendly_losses=len(losses),
                  enemy_metal_destroyed=sum(float(d['cost']) for d in kills),
                  nonlua_commands=orders, commands_per_game_minute=orders/(order_frame/1800) if order_frame else None,
                  command_window_frame=order_frame, last_observed_frame=last_frame, watch_verdict=verdict,
                  sensor_forward_progress=sensor_advance,
                  assigned_unit_types=assigned_types,
                  minimum_sampled_spacing_after_60s=min(separations) if separations else None,
                  render_fps_after_60s=fps, cloaked_units_observed=len(cloaked),
                  carrier_children_observed=len(children), friendly_damage_including_overkill=friendly_damage,
                  deaths=deaths,
                  engine_ai_windows=samples, failures=failures, passed=not failures)
    # New analysis schema gets a new path. Earlier immutable measurements
    # remain valid evidence rather than being silently recomputed in place.
    output = directory / 'ranged-measurements-v5.json'
    if output.exists() and json.loads(output.read_text()) != result:
        raise RuntimeError('Refusing to overwrite a different measurement: ' + str(output))
    output.write_text(json.dumps(result, indent=2)+'\n')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--summarize', type=Path)
    parser.add_argument('--cases', nargs='+')
    parser.add_argument('--dll', type=Path)
    parser.add_argument('--data', type=Path, default=ROOT/'data')
    parser.add_argument('--variant', default='ranged', choices=['baseline','siege','ranged'])
    parser.add_argument('--profile', default='experimental_balanced')
    parser.add_argument('--minutes', type=int, default=4)
    parser.add_argument('--speed', type=int, default=8)
    args = parser.parse_args()
    if args.summarize:
        print(json.dumps(summarize(args.summarize), indent=2))
        return 0
    if not args.cases or not args.dll: parser.error('--cases and --dll required')
    failures = 0
    for case in args.cases:
        command = [sys.executable, str(HERE/'ranged_arena.py'), '--case', case, '--dll', str(args.dll),
                   '--data', str(args.data), '--variant', args.variant, '--profile', args.profile,
                   '--minutes', str(args.minutes), '--speed', str(args.speed)]
        print('BEGIN_CASE='+case, flush=True)
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        directory = None
        for line in process.stdout:
            print(line, end='', flush=True)
            if line.startswith('RANGED_ARENA='): directory = Path(line.strip().split('=',1)[1])
        code = process.wait()
        if directory and (directory/'infolog.txt').exists():
            result = summarize(directory)
            print('MEASUREMENTS='+json.dumps(result), flush=True)
            failures += bool(code or not result['passed'])
            # Reaching the observation deadline is not proof of production.
            # Keep the original combat/watch result immutable, and require the
            # separate completed-unit/queue analysis for production scenarios.
            cfg = json.loads((directory/'ranged-arena.json').read_text())
            if cfg.get('production_assertions'):
                analysis = subprocess.run([sys.executable, str(HERE/'land_siege_report.py'), str(directory)])
                failures += bool(analysis.returncode)
            if cfg.get('trace_spam'):
                analysis = subprocess.run([sys.executable, str(HERE/'spam_report.py'), str(directory)])
                failures += bool(analysis.returncode)
            if cfg.get('deployment_assertions'):
                criteria = cfg['deployment_assertions']
                analysis = subprocess.run([sys.executable, str(HERE/'deployment_report.py'), str(directory),
                    '--seconds', str(criteria['seconds']), '--minimum', str(criteria['minimum'])])
                failures += bool(analysis.returncode)
        else: failures += 1
    return bool(failures)


if __name__ == '__main__': sys.exit(main())
