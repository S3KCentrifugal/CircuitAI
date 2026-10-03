"""Analyze settled fixed-population windows, excluding the spawning minute."""
import argparse
import json
from pathlib import Path
import re
from analyze_workforce_performance import analyze


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('index',type=Path);a=p.parse_args()
    runs=[]
    for entry in json.loads(a.index.read_text()):
        root=Path(entry['directory']);text=(root/'infolog.txt').read_text(errors='replace')
        result=analyze(text);fixture=json.loads((root/'scaling-fixture.json').read_text())
        populations={int(f):int(n) for f,n in re.findall(r'\[WorkforceScale\] frame=(\d+) constructors=(\d+)',text)}
        windows=[]
        for frame,count in [(7200,100),(12600,500),(18000,1000)]:
            row=next((r for r in result['minutes'] if r['frame']==frame),None)
            windows.append(dict(expected_workers=count,observed_workers=populations.get(frame),
                frame=frame,timing=row,valid=row is not None and populations.get(frame)==count and result['valid_timing']))
        row=dict(directory=str(root),fixture=fixture,windows=windows,errors=result['errors'],
            invariants=result['invariants'],
            whole_game_verdict=re.search(r'Verdict: \*\*(\w+)\*\*',(root/'report.md').read_text())[1],
            scope='Two AI instances, fixed idle constructors, zero active projects. Aggregate callbacks, not isolated census.')
        (root/'performance-analysis.json').write_text(json.dumps(row,indent=2)+'\n');runs.append(row)
    out=a.index.with_name('workforce-scaling-analysis.json')
    out.write_text(json.dumps(dict(runs=runs),indent=2)+'\n')
    print(json.dumps(dict(runs=runs),indent=2))
    return any(not w['valid'] for r in runs for w in r['windows'])


if __name__=='__main__':raise SystemExit(main())
