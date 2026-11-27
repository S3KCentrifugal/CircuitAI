"""Supplied real-map TECH clearing test; never changes installed AI files."""
import argparse,json,os,subprocess,sys
from pathlib import Path
import playtest,storage
from run_retirement_regression import inject_entry

def main():
 p=argparse.ArgumentParser();p.add_argument('--dll',type=Path,required=True);p.add_argument('--negative-control',action='store_true');a=p.parse_args()
 d=storage.allocate('tech','layout','lolcannon-clearing','all_that_glitters','regression',seed=20261127)
 print('CLEARING_DIRECTORY='+str(d),flush=True)
 Path('C:/Users/artib/BAR/clearing-regression-directory.txt').write_text(str(d))
 call=[sys.executable,str(playtest.HERE/'playtest.py')]
 subprocess.run(call+['stage','--dir',str(d),'--dll',str(a.dll),'--data',str(Path(__file__).resolve().parents[2]/'data'),
  '--map','All That Glitters v2.2.3','--map-file',str(Path(__file__).resolve().parents[2]/'data/script/src/maps/all_that_glitters.as'),
  '--game','Beyond All Reason test-32071-e1cbffe','--engine','recoil_2026.09.03','--role','TECH',
  '--roles','TECH,AIR','--side','armada','--isolated','--isolated-allies',
  '--ai-option','profile=experimental_balanced','--ai-option','random_seed=20261127',
  '--bonus','0','--mode','fast','--speed','10','--minutes','3','--headless',
  '--modoption','startmetal=100000','--modoption','startmetalstorage=100000',
  '--modoption','startenergy=1000000','--modoption','startenergystorage=1000000',
  '--extra-widget',str(playtest.HERE/'widgets/lolcannon_clearing_fixture.lua')],check=True)
 s=d/'AI/Skirmish/BARbTest/test/script';src=s/'src';profile=s/'experimental_balanced/main.as'
 (src/'clearing_probe.as').write_bytes((playtest.HERE/'fixtures/lolcannon_clearing_probe.as').read_bytes())
 profile.write_text('#include "../src/clearing_probe.as"\n'+profile.read_text())
 inject_entry(profile,'void AiUpdate()','ClearingProbe::Tick(); if(ai.frame>=0) return;')
 inject_entry(profile,'void AiMessage(const string& in msg, int fromTeamId)','if(ClearingProbe::Message(msg)) return;')
 inject_entry(src/'manager/builder.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)','if(ai.frame>=0) return ClearingProbe::Retain(u);')
 # Override inputs only: production loop, native placement and TrySite are unchanged.
 cannon=src/'systems/construction/lolcannon.as'
 inject_entry(cannon,'array<AIFloat3> TargetStarts(string &out why)',
  'if(ClearingProbe::freeSearch) { why="controlled fixture"; return {AIFloat3(1008,0,1000)}; }')
 inject_entry(cannon,'bool PickClear(CCircuitDef@ gun,',
  'if(ClearingProbe::freeSearch) { ClearingProbe::premature=true; return false; }')
 text=cannon.read_text();needle='        // FRONT runs no layout: the reservations are taken for the search only.'
 assert needle in text
 if a.negative_control:
  text=text.replace('if (IsFront() && !clearTried && clr.length()', 'if (!clearTried && clr.length()',1)
 text=text.replace(needle,'''        if(ClearingProbe::freeSearch) {
            best.resize(0);bestD.resize(0);bestF.resize(0);bestS.resize(0);
            best.insertLast(AIFloat3(1008,0,6928)); bestD.insertLast(10000); bestF.insertLast(2); bestS.insertLast(0);
            best.insertLast(AIFloat3(510,0,8528)); bestD.insertLast(9000000); bestF.insertLast(2); bestS.insertLast(0);
        }
'''+needle,1);text=text.replace('            const bool keepForClear =', '            if(ClearingProbe::freeSearch && i==1) ClearingProbe::Check("blocked candidate retained",clr.length()>0);\n            const bool keepForClear =',1);cannon.write_text(text)
 checks=d/'clearing-checks.json'
 checks.write_text(json.dumps({'stop_minute':3,'complete_on':{'key':'done','pattern':r'\[ClearingProbe\] DONE','scope':'any'},
  'completion_grace_seconds':3,'expect':[{'key':'done','pattern':r'\[ClearingProbe\] DONE','scope':'any','by_minute':3}],
  'forbid':[{'key':'fail','pattern':r'\[ClearingProbe\] FAIL|: ERR\s+:|SCRIPT CRASH|Lib exception|Access violation|has crashed|Fatal:','scope':'any'}]},indent=2))
 try:
  subprocess.run(call+['launch','--dir',str(d),'--engine','recoil_2026.09.03','--headless'],check=True)
  result=subprocess.call(call+['watch','--dir',str(d),'--role','TECH','--checks',str(checks),'--minutes','3','--wall-minutes','6'])
  Path('C:/Users/artib/BAR/clearing-regression-result.json').write_text(json.dumps({'directory':str(d),'status':result},indent=2))
  return result
 finally: subprocess.run(call+['stop','--dir',str(d)],check=False)
if __name__=='__main__': raise SystemExit(main())

