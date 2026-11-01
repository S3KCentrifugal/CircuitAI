"""Replay production native lane geometry on installed map archives, without games.

Build tests/field_analysis_test.cpp with its normal companion sources first.
Inputs/results belong in the external benchmark store. Missing archives fail;
never report an unexecuted fixture as passed. --maps selects focused iterations.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path
import subprocess

from export_lane_input import export

ROOT = Path(__file__).resolve().parents[2]


def crossing(points, z):
    for a, b in zip(points, points[1:]):
        if min(a[1], b[1]) <= z <= max(a[1], b[1]) and a[1] != b[1]:
            return a[0] + (b[0]-a[0])*(z-a[1])/(b[1]-a[1])
    return None


def check(text, log, fixture):
    failures, corridors, grids = [], [], {}
    header = text.splitlines()[0].split('|')
    gw, gh, cell = map(int, header[3:6])
    for line in text.splitlines():
        f = line.split('|')
        if f[0] == 'corridorcells':
            values = []
            for run in f[2].split(';'):
                value, count = map(int, run.split('*'))
                values.extend([value]*count)
            if len(values) != gw*gh: raise ValueError('invalid ownership raster')
            grids[int(f[1])] = values
        if f[0] == 'corridor':
            corridors.append(dict(id=int(f[1]), cls=int(f[2]), width=float(f[5]),
                specialist=int(f[9]), points=[list(map(float, p.split(',')[:2])) for p in f[-1].split(';')]))
    for c in corridors:
        if c['specialist']: continue
        grid = grids[c['cls']]
        invalid = False
        for a, b in zip(c['points'], c['points'][1:]):
            steps = max(1, math.ceil(math.dist(a, b)/16))
            for i in range(steps+1):
                x, z = (a[k]+(b[k]-a[k])*i/steps for k in (0, 1))
                gx, gz = int(x/cell), int(z/cell)
                if not (0 <= gx < gw and 0 <= gz < gh) or grid[gz*gw+gx] < 0:
                    invalid = True
        if invalid: failures.append(f"lane {c['id']} crosses closed terrain or map edge")
    for cls in fixture.get('required_classes', [0, 1]):
        usable = [c for c in corridors if c['cls'] == cls and not c['specialist']]
        if not usable:
            failures.append(f'no usable class {cls} lane')
    for cls in fixture.get('absent_classes', []):
        if any(c['cls'] == cls and not c['specialist'] for c in corridors):
            failures.append(f'unexpected land connection for class {cls}')
    if 'CHECK FAILED:' in log:
        failures.append('native field invariants failed')
    if fixture.get('west_lanes'):
        for cls in [0, 1]:
            west = [c for c in corridors if c['cls'] == cls and not c['specialist']
                    and (crossing(c['points'], 6000) or 1e9) < 1800]
            if len(west) < 2:
                failures.append(f'class {cls}: west border and inner passage must both remain usable')
        bots = [c for c in corridors if c['cls'] == 1 and not c['specialist']]
        edge = min(bots, key=lambda c: crossing(c['points'], 6500) or 1e9) if bots else None
        prefix = f"laneleg|0|1|{edge['id']}|" if edge else 'no-lane'
        leg = next((line for line in log.splitlines() if line.startswith(prefix)), None)
        if not leg:
            failures.append('west start connector missing')
        else:
            points = [list(map(float, p.split(','))) for p in leg.split('|')[5].split(';') if p]
            if not points or any(x > 700 for x, z in points if z >= 8400):
                failures.append('west start detours through inner neighbour instead of outside its mesa')
    if 'mid_lane' in fixture:
        target = fixture['mid_lane']
        candidates = [(c, crossing(c['points'], target['select_z'])) for c in corridors
                      if c['cls'] == 0 and not c['specialist']]
        candidates = [(c, x) for c, x in candidates if x is not None]
        lane = min(candidates, key=lambda item: abs(item[1]-target['select_x']))[0] if candidates else None
        for z, maximum_x in target['gates']:
            x = crossing(lane['points'], z) if lane else None
            if x is None or x > maximum_x:
                failures.append(f'mid vehicle lane must stay toward mid at z={z}, x<={maximum_x}; got {x}')
    return failures, {str(cls):sum(c['cls']==cls and not c['specialist'] for c in corridors) for cls in range(6)}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--exe', type=Path, required=True)
    p.add_argument('--archives', type=Path, required=True)
    p.add_argument('--out', type=Path, required=True)
    p.add_argument('--config', type=Path, default=ROOT/'data/config/field.json')
    p.add_argument('--maps', help='comma-separated fixture keys; default is the complete matrix')
    a = p.parse_args()
    a.out.mkdir(parents=True, exist_ok=False)
    fixtures = json.loads((ROOT/'tests/fixtures/lane_maps.json').read_text())['maps']
    if a.maps:
        keys = set(a.maps.split(','))
        if keys - {f['key'] for f in fixtures}: p.error('unknown fixture key')
        fixtures = [f for f in fixtures if f['key'] in keys]
    results = []
    for f in fixtures:
        archive = a.archives/f['archive']; stem = a.out/f['key']
        try:
            export(archive, f['member'], stem.with_suffix('.bin'), f['name'], f['axis'], f['height_min'], f['height_max'])
            command = [str(a.exe.resolve()), str(stem.with_suffix('.bin')), str(stem.with_suffix('.txt')), '--config', str(a.config.resolve())]
            for x, z in f.get('starts', []): command += ['--lane-start', f'{x},{z}']
            run = subprocess.run(command, capture_output=True, text=True, timeout=120)
            stem.with_suffix('.log').write_text(run.stdout+run.stderr)
            failures, counts = check(stem.with_suffix('.txt').read_text(), run.stdout, f)
            if run.returncode: failures.append(f'native exit {run.returncode}')
            results.append(dict(map=f['key'], passed=not failures, failures=failures, usable=counts,
                config_sha256=hashlib.sha256(a.config.read_bytes()).hexdigest(),
                archive_sha256=hashlib.sha256(archive.read_bytes()).hexdigest()))
        except Exception as e:
            results.append(dict(map=f['key'], passed=False, failures=[str(e)]))
        print(json.dumps(results[-1]), flush=True)
        (a.out/'results.json').write_text(json.dumps(results, indent=2))
    return 0 if all(r['passed'] for r in results) else 1


if __name__ == '__main__':
    raise SystemExit(main())
