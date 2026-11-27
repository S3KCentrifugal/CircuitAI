"""Isolated +50, x10, Below Normal natural integration games for TECH clearing."""
import argparse,ctypes,json,os,subprocess,sys
from pathlib import Path
import playtest,storage

def main():
 p=argparse.ArgumentParser();p.add_argument('--dll',required=True);p.add_argument('--data',required=True);p.add_argument('--minutes',type=int,default=90);p.add_argument('--maps',default='glitters,scylla,hera');p.add_argument('--adopt-dir',type=Path);p.add_argument('--status-file',type=Path);a=p.parse_args()
 os.environ['BAR_PLAYTEST_LOW_PRIORITY']='1'
 cli=[sys.executable,str(playtest.HERE/'playtest.py')]
 output=a.status_file or Path('C:/Users/artib/BAR/tech-clearing-map-matrix.json'); rows=[]
 for slug,name,filename in [('glitters','All That Glitters v2.2.3','all_that_glitters.as'),('scylla','Scylla and Charybdis 1.1','scylla_and_charybdis.as'),('hera','Hera Planum 0.9.2','hera_planum.as')]:
  if slug not in a.maps.split(','):continue
  d=a.adopt_dir or storage.allocate('tech','layout','clearing-natural-plus50',slug,'natural',seed=20261127)
  row={'map':name,'directory':str(d),'status':'staging','bonus_all':50,'requested_speed':10,'priority':'BelowNormal','horizon_minutes':a.minutes};rows.append(row);output.write_text(json.dumps(rows,indent=2));print('MATRIX '+json.dumps(row),flush=True)
  if not a.adopt_dir:
   subprocess.run(cli+['stage','--dir',str(d),'--dll',a.dll,'--data',a.data,'--map',name,'--map-file',str(playtest.REPO/'data/script/src/maps'/filename),
    '--game','Beyond All Reason test-32071-e1cbffe','--engine','recoil_2026.09.03','--role','TECH','--roles','all','--side','armada',
    '--ai-option','profile=experimental_balanced','--ai-option','random_seed=20261127','--bonus-all','50','--speed','10','--speed-plan','0:10',
    '--mode','fast','--headless','--minutes',str(a.minutes),'--modoption','deathmode=com',
    '--extra-widget',str(playtest.HERE/'widgets/full_match_perf.lua'),'--extra-widget',str(playtest.HERE/'widgets/perf_spectator_cleanup.lua')],check=True)
   cfg=d/'LuaUI/Config';cfg.mkdir(exist_ok=True)
   (cfg/'full_match_perf.lua').write_text('return {teams=16,screenshots=false,horizon_frame='+str(a.minutes*1800)+'}\n')
   (cfg/'perf_spectator_cleanup.lua').write_text('return {teams=16}\n')
   checks={'stop_minute':a.minutes,'expect':[{'key':'roster','pattern':r'\[PerfFixture\] spectator_units=0 competing_ai_teams=16','scope':'any','by_minute':1}],
    'pass_on':{'key':'completion','pattern':r'\[FullMatch(?:End|Horizon)\]','scope':'any'},
    'forbid':[{'key':'script','pattern':r': ERR\s+:|SCRIPT CRASH|Lib exception|Access violation|Fatal:|has crashed','scope':'any'},
     {'key':'invariant','pattern':'INVARIANT','scope':'any'},{'key':'fixture','pattern':r'\[PerfFixture\] ERROR|Error in GameFrame','scope':'any'}]}
   (d/'matrix-checks.json').write_text(json.dumps(checks,indent=2))
   text=(d/'script.txt').read_text(); assert text.count('Handicap=50;')==16
   (d/'script.txt').write_text(text.replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed=20261127;',1))
  try:
   if not a.adopt_dir:subprocess.run(cli+['launch','--dir',str(d),'--engine','recoil_2026.09.03','--headless'],check=True)
   launch=json.loads((d/'launched.json').read_text());pid=launch['pid']
   api=ctypes.WinDLL('kernel32',use_last_error=True);api.OpenProcess.argtypes=[ctypes.c_ulong,ctypes.c_int,ctypes.c_ulong];api.OpenProcess.restype=ctypes.c_void_p;api.GetPriorityClass.argtypes=[ctypes.c_void_p];api.GetPriorityClass.restype=ctypes.c_ulong;api.CloseHandle.argtypes=[ctypes.c_void_p]
   handle=api.OpenProcess(0x1000,False,pid)
   if not handle:raise ctypes.WinError(ctypes.get_last_error())
   priority=api.GetPriorityClass(handle);api.CloseHandle(handle)
   row.update(status='running',pid=pid,priority_class=priority);output.write_text(json.dumps(rows,indent=2));assert priority==0x4000,priority
   code=subprocess.call(cli+['watch','--dir',str(d),'--role','TECH','--checks',str(d/'matrix-checks.json'),'--play-decided','--keep-going','--minutes',str(a.minutes+1),'--wall-minutes','180'])
   row.update(status='finished',exit_code=code)
  except Exception as e:row.update(status='infrastructure-error',error=str(e))
  finally:
   subprocess.run(cli+['stop','--dir',str(d)],check=False)
   output.write_text(json.dumps(rows,indent=2));print('MATRIX_RESULT '+json.dumps(row),flush=True)
 return int(any(row.get('exit_code')!=0 for row in rows))
if __name__=='__main__':raise SystemExit(main())
