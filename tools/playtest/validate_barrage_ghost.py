from pathlib import Path
import re,json,math,sys
root=Path(sys.argv[1]);summary={}
for name in ['cap','wreck','pawn','grunt','radar','los']:
 d=root/('release-'+name)
 if not (d/'runs').exists():continue
 results=list((d/'runs').glob('*/result.json'))
 if not results:continue
 r=json.loads(results[-1].read_text());s=(d/'infolog.txt').read_text(errors='replace')
 frames=lambda pattern:[int(x) for x in re.findall(pattern,s)]
 volleys=[(int(f),int(n)) for f,n in re.findall(r'\[f=(\d+)\].*legbar \d+ ghost volley (\d+)/3',s)]
 shots=frames(r'shot frame=(\d+) owner=\d+ def=legbar')
 moves=frames(r'\[f=(\d+)\].*RANGED: move-replace')
 stops=frames(r'\[f=(\d+)\].*ARTY: legbar \d+ target \d+ wreck, stops')
 a={'runner_verdict':r['verdict'],'ghost_volleys':volleys,'shots':shots,'retreat_moves':moves,'wreck_stop':stops,'barrage_lost':bool(re.search(r'artyDead=\{legbar<',s)), 'fixture_errors':s.count('[ArtySnipe] ERROR'),'report':str(results[-1].parent/'report.md')}
 assert r['verdict']=='PASS' and not a['fixture_errors'],(name,a)
 if name=='cap':assert [n for f,n in volleys]==[1,2,3] and len(shots)==3 and not moves,a
 if name=='wreck':assert stops and max(shots)<1200 and len(volleys)<3,a
 if name in ['pawn','grunt']:assert moves and min(moves)>=1140 and min(moves)<1260 and len(volleys)<3,a
 if name in ['radar','los']:assert len(shots)>3 and not [f for f,n in volleys if f>=1140],a
 summary[name]=a
 print(name,'TACTICAL PASS','volleys',len(volleys),'shots',len(shots),'retreats',len(moves),'lost',a['barrage_lost'])
(root/'barrage-validation.json').write_text(json.dumps(summary,indent=2))
assert len(summary)==6, "All six archived cases are required"
