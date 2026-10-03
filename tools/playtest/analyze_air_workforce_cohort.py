"""Compare matched workforce games over the same observed simulation interval."""
import argparse
import json
from pathlib import Path
from statistics import median
import analyze_air_natural
from workforce_metrics import compare


def load(directory, end_frame=None):
    directory=Path(directory)
    teams=json.loads((directory/'teams.json').read_text())
    fixture=json.loads((directory/'natural-fixture.json').read_text())
    inputs=json.loads((directory/'run-inputs.json').read_text())
    data=analyze_air_natural.analyze(directory/'infolog.txt',teams['teams'],end_frame)
    meta=dict(map=teams['map'],game=teams['game'],engine=inputs['engine_sha256'],
        seed=fixture['seed'],side=fixture['side'],minutes=end_frame/1800 if end_frame is not None else fixture['minutes_requested'],
        kind='supplied' if fixture['supplied_assets'] else 'natural',dll=fixture['dll_sha256'])
    row=data['air']['0']
    return meta,dict(directory=str(directory),minutes=data['minutes'],observed_minutes=row['observed_minutes'],
        requested_minutes=fixture['minutes_requested'],first=row['first'],
        workforce=row['workforce'],peak_all_apm=row['peak_all_apm'],peak_air_apm=row['peak_air_apm'],
        air_invariants=row['invariants'],all_invariants=data['all_invariants'],errors=data['errors'])


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('cohort',type=Path)
    p.add_argument('--final',type=Path,help='Final-source Armada repeat, compared with its matching baseline')
    a=p.parse_args()
    jobs=json.loads((a.cohort/'cohort.json').read_text())['jobs']
    pairs=[];missing=[]
    for base in [j for j in jobs if j['revision']=='baseline']:
        revised=next(j for j in jobs if j['revision']=='revised' and j['seed']==base['seed'])
        for name in ['supreme','glacial','glitters','tundra','caldera']:
            dirs=[Path(base['directory'])/name,Path(revised['directory'])/name]
            if a.final:
                if base['seed']!=1811001:continue
                dirs[1]=a.final/name
            if any(not (d/'report.md').exists() for d in dirs):
                missing.append([str(d) for d in dirs]);continue
            first=[load(d) for d in dirs]
            common=int(min(x[1]['observed_minutes'] for x in first)*1800)
            rows=[load(d,common) for d in dirs]
            comparable=compare(rows[0][0],rows[1][0])
            if rows[0][0]['dll']!=rows[1][0]['dll']:comparable['comparable']=False;comparable['different'].append('dll')
            pairs.append(dict(seed=base['seed'],side=base['side'],map=name,comparison=comparable,
                common_minutes=common/1800,baseline=rows[0][1],revised=rows[1][1]))
    summary=dict(pairs=pairs,missing=missing,
        note='Matched inputs, diverging battles. Point-sample resource observations; not a causal proof of optimal play.')
    for metric in ['full_bank_sample_fraction','usageM_mean','idleBP_mean']:
        values=[r['revised']['workforce'][metric]-r['baseline']['workforce'][metric]
                for r in pairs if r['comparison']['comparable'] and r['revised']['workforce'][metric] is not None]
        summary[metric+'_median_paired_delta']=median(values) if values else None
    output=(a.final or a.cohort)/'workforce-comparison.json'
    output.write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps({k:v for k,v in summary.items() if k!='pairs'},indent=2))
    for row in pairs:
        print(row['side'],row['map'],[(side,row[side]['first'].get('fusion'),row[side]['first'].get('t2_lab'),
            row[side]['first'].get('afus'),row[side]['peak_all_apm']) for side in ['baseline','revised']])
    return bool(missing) or any(not r['comparison']['comparable'] for r in pairs)


if __name__=='__main__':raise SystemExit(main())
