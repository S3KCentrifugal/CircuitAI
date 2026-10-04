"""Compare observed AIR economy/combat windows; never changes check verdicts."""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

WINDOWS = [('early', 0, 10), ('mid', 10, 25), ('late', 25, 50)]

def summarize(path):
    windows = {name: dict(samples=0, covered_seconds=0, metal_full_seconds=0,
        energy_empty_seconds=0, income_m_sum=0, income_e_sum=0,
        metal_stalled_seconds=0, energy_stalled_seconds=0,
        completed=Counter(), damage=Counter(), losses=Counter(), kills=Counter(), nominal_kill_metal=Counter(), waves=0) for name, _, _ in WINDOWS}
    milestones = {}
    invariants = Counter()
    last_sample = None
    last_stalls = (0.0, 0.0)
    for line in path.open(encoding='utf-8', errors='replace'):
        frame = re.search(r'\[f=(\d+)\]', line)
        if not frame: continue
        second = int(frame[1]) / 30
        if 'INVARIANT' in line:
            found = re.search(r'INV-\d+', line)
            if found: invariants[found[0]] += 1
        selected = next((name for name, lo, hi in WINDOWS if lo*60 <= second < hi*60), None)
        if selected is None: continue
        w = windows[selected]
        if '[AirWatch]' in line:
            unit = re.search(r'(finished|lost) id=\d+ def=(\w+)', line)
            if unit:
                w['completed' if unit[1] == 'finished' else 'losses'][unit[2]] += 1
                if unit[1] == 'finished': milestones.setdefault(unit[2], round(second/60, 3))
            damage = re.search(r'damage attacker=\d+ def=(\w+) victim=\d+ amount=(\d+)', line)
            if damage: w['damage'][damage[1]] += int(damage[2])
            kill = re.search(r'kill attacker=\d+ def=(\w+) victim=\d+ victimDef=\w+ nominalMetal=([\d.]+)', line)
            if kill:
                w['kills'][kill[1]] += 1
                w['nominal_kill_metal'][kill[1]] += float(kill[2])
            sample = re.search(r'eco t=[\d.]+ M=([\d.]+)/([\d.]+) \+([\d.]+) pull=[\d.]+ E=([\d.]+)/([\d.]+) \+([\d.]+)', line)
            if sample:
                m, ms, mi, e, es, ei = map(float, sample.groups())
                dt = min(10, max(0, second-last_sample)) if last_sample is not None else 0
                last_sample = second
                w['samples'] += 1; w['covered_seconds'] += dt
                if ms > 0 and m/ms >= .95: w['metal_full_seconds'] += dt
                if e < 1: w['energy_empty_seconds'] += dt
                w['income_m_sum'] += mi; w['income_e_sum'] += ei
                stalls = re.search(r'stallSeconds=([\d.]+)/([\d.]+)', line)
                if stalls:
                    totals = tuple(map(float, stalls.groups()))
                    w['metal_stalled_seconds'] += max(0, totals[0] - last_stalls[0])
                    w['energy_stalled_seconds'] += max(0, totals[1] - last_stalls[1])
                    last_stalls = totals
        if re.search(r':::AI LOG:S:\d+:T:0:.*\[Waves\] Wave \d+ launched', line): w['waves'] += 1
    for w in windows.values():
        n = w['samples']
        for key in ['m', 'e']:
            w['mean_income_'+key] = round(w.pop('income_'+key+'_sum')/n, 2) if n else None
    return {'log': str(path.resolve()), 'windows': windows, 'first_finished_minute': milestones,
            'invariants_all_teams': invariants,
            'limits': 'Full/empty resource estimates use ten-second snapshots. Stalled seconds are deltas of the observer 0.5-second cumulative counters, attributed to the reporting window. Damage is observed (events >=20), not kill value. Invariants include all teams.'}

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('logs', nargs='+', type=Path)
    p.add_argument('--output', type=Path, required=True)
    args=p.parse_args()
    args.output.write_text(json.dumps([summarize(path) for path in args.logs], indent=2)+'\n', encoding='utf-8')
    print(args.output)

if __name__=='__main__': main()
