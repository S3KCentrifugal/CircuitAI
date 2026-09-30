"""Verify archived lane/production/combat evidence and retain the global verdict."""
import argparse, collections, json, re
from pathlib import Path
import scorecard

def verify(directory, run):
    directory,run=Path(directory),Path(run)
    manifest=scorecard.read_json(directory/'scorecard-manifest.json')
    text=(run/'infolog.txt').read_text(encoding='utf-8',errors='replace')
    surveys=collections.defaultdict(list)
    for t,n in re.findall(r':::AI LOG:S:\d+:T:(\d+):[^\n]*\[Lanes\] qualified specialists=(\d+)',text): surveys[int(t)].append(int(n))
    effects={}
    for line in text.splitlines():
        if '[FlankEffect] minute=' in line:
            row=dict(re.findall(r'(\w+)=([^ ]+)',line.split('[FlankEffect] ',1)[1]))
            effects[int(row['team'])]={k:float(v) for k,v in row.items() if k!='samples'}
    expected={t['team'] for t in manifest['teams']}
    gates={int(t) for t in re.findall(r'\[MountainTest\] income gate team=(\d+)',text)}
    criteria={'every team surveyed and refreshed':all(len(surveys[t])>=2 for t in expected)}
    supreme=manifest['map'].startswith('Supreme Isthmus')
    survey_only=manifest['scenario']['minutes_limit']==6
    criteria['map appropriate lanes']=all(all(n==0 for n in surveys[t]) if supreme else any(n>0 for n in surveys[t]) for t in expected)
    if not survey_only:
        criteria['both income gates reached']={0,1}<=gates
    if supreme:
        if not survey_only:
            for t in expected:
                criteria[f'team {t} explicitly rejected flank']=bool(re.search(r':::AI LOG:S:\d+:T:'+str(t)+r':[^\n]*\[TECH\]\[Flank\] no reachable specialist lane',text))
        criteria['no dedicated flank orders or production']=not re.search(r'\[TECH\]\[Flank\] (ordered|produce|routed)',text)
    else:
        for t in expected:
            frames=[int(f) for f in re.findall(r':::AI LOG:S:\d+:T:'+str(t)+r':F:(\d+):[^\n]*\[TECH\]\[Flank\] produce ',text)]
            e=effects.get(t,{})
            criteria[f'team {t} sustained recruitment']=len(frames)>=8 and max(frames,default=0)-min(frames,default=0)>=9000
            criteria[f'team {t} actual mountain movement']=e.get('high',0)>=2
        criteria['mountain attackers fought']=sum(e.get('kills',0) for e in effects.values())>0
    parsed=scorecard.parse_log(run/'infolog.txt')
    result={'manifest':manifest,'run':str(run.resolve()),'criteria':criteria,'functional_pass':all(criteria.values()),'surveys':dict(surveys),'combat':effects,'invariants':parsed['invariants'],'errors':parsed['errors']}
    result['overall_pass']=result['functional_pass'] and not result['invariants'] and not result['errors']
    scorecard.write_json(run/'mountain-results.json',result)
    card=scorecard.record(directory,run)
    print(json.dumps({k:v for k,v in result.items() if k not in ('manifest','surveys')},indent=2))
    print('scorecard:',card)
    return result['overall_pass']
if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('directory');p.add_argument('--run',required=True);a=p.parse_args()
    raise SystemExit(0 if verify(a.directory,a.run) else 1)
