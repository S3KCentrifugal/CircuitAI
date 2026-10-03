"""Aggregate engine AI timer and actual synchronized orders in paired 8v8 games."""
import argparse
from collections import Counter
import json
from pathlib import Path
import re


def analyze(text):
    totals, minutes, orders, removals = [], [], [], []
    roles = {}
    invariants=[]
    errors = []
    for line in text.splitlines():
        removed=re.search(r'\[f=(\d+)\].*local skirmish AI .* being removed from team (\d+)',line)
        if removed:removals.append(dict(frame=int(removed[1]),team=int(removed[2])))
        invariant=re.search(r':::AI LOG:S:\d+:T:(\d+):F:\d+:L::.*\[INVARIANT\] (INV-\d+)',line)
        if invariant:invariants.append(dict(team=int(invariant[1]),id=invariant[2]))
        # The startup snapshot is authoritative after a staged role override.
        role = re.search(r':::AI LOG:S:\d+:T:(\d+):F:\d+:L::.*role[=: ]+(AIR|TECH|FRONT|SEA|TACTICAL|SUPPORT)\b', line)
        if role:
            roles[int(role[1])] = role[2]
        timing=re.search(r'\[WorkforcePerf(?:Total)?\] (.*)',line)
        if timing:
            row = {k: float(v) for k, v in re.findall(r'(\w+)=([\d.]+)', timing[1])}
            if 'samples' in row:
                (totals if '[WorkforcePerfTotal]' in line else minutes).append(row)
        if re.search(r'Error in GameFrame\(\)|Removed widget: Workforce performance observer|\[WorkforcePerf\] ERROR',line):
            errors.append(line)
        command = re.search(r'\[AirOrders\] frame=(\d+) team=(\d+) all_apm=(\d+) air_apm=(\d+) repeated=(\d+)', line)
        if command:
            orders.append(dict(zip(('frame','team','all','air','repeated'),map(int,command.groups()))))
    return dict(scope='all engine AI callbacks per simulation frame, not per AIR instance',
        totals=totals, minutes=minutes, roles=roles, orders=orders, removals=removals, errors=errors,invariants=invariants,
        valid_timing=bool(totals) and not errors and any(r.get('ai_all_max_ms',0)>0 for r in totals))


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('index',type=Path)
    args=parser.parse_args()
    rows=[]
    for entry in json.loads(args.index.read_text()):
        root=Path(entry['directory'])
        fixture=json.loads((root/'performance-fixture.json').read_text())
        result=analyze((root/'infolog.txt').read_text(errors='replace'))
        # teams.json records the intended starts; the multi fixture explicitly
        # converts SUPPORT and TACTICAL starts to AIR before role registration.
        teams=json.loads((root/'teams.json').read_text())['teams']
        air={t['team'] for t in teams if t['role']=='AIR' or fixture['multiple_air'] and t['role'] in ('SUPPORT','TACTICAL')}
        commands=[r for r in result['orders'] if r['team'] in air]
        result.update(fixture=fixture, air_teams=sorted(air),
            air_invariants=dict(Counter(r['id'] for r in result['invariants'] if r['team'] in air)),
            peak_air_role_apm=max((r['all'] for r in commands),default=None),
            air_role_minutes_over_3000=sum(r['all']>3000 for r in commands),
            air_minutes_over_3000=sum(r['air']>3000 for r in commands))
        (root/'performance-analysis.json').write_text(json.dumps(result,indent=2)+'\n')
        rows.append(dict(directory=str(root),**result))
    pairs=[]
    for multi in (False,True):
        matches=[r for r in rows if r['fixture']['multiple_air']==multi]
        if len(matches)!=2:continue
        base=next(r for r in matches if r['fixture']['revision']=='baseline')
        revised=next(r for r in matches if r['fixture']['revision']=='revised')
        if not base['valid_timing'] or not revised['valid_timing']:continue
        common=sorted({r['frame'] for r in base['totals']} & {r['frame'] for r in revised['totals']})
        for frame in common:
            b=next(r for r in base['totals'] if r['frame']==frame)
            r=next(r for r in revised['totals'] if r['frame']==frame)
            pairs.append(dict(multiple_air=multi,frame=frame,baseline=b,revised=r,
                full_roster_window=not any(x['frame']<=frame for x in base['removals']+revised['removals']),
                p95_change_percent=100*(r['ai_all_p95_ms']/b['ai_all_p95_ms']-1) if b['ai_all_p95_ms'] else None))
    output=args.index.with_name('workforce-performance-analysis.json')
    output.write_text(json.dumps(dict(runs=rows,pairs=pairs),indent=2)+'\n')
    print(json.dumps(dict(pairs=pairs,runs=[dict(revision=r['fixture']['revision'],multiple_air=r['fixture']['multiple_air'],
        air_teams=r['air_teams'],peak=r['peak_air_role_apm'],minutes_over_3000=r['air_role_minutes_over_3000']) for r in rows]),indent=2))


if __name__=='__main__':main()
