"""Supplied shoreline support: real naval construction and land assistance."""
import argparse
import json
from pathlib import Path
import re
import subprocess
import sys
import playtest
import storage
from run_retirement_regression import inject_entry

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll',type=Path,required=True)
    parser.add_argument('--data',type=Path,required=True)
    args=parser.parse_args()
    directory=storage.allocate('tech','economy','coastal-support','tundra','supplied',seed=3211)
    print('COASTAL_DIRECTORY='+str(directory),flush=True)
    starts=directory/'starts.as'
    starts.write_text('StartSpot(AIFloat3(2800,0,800), AiRole::TECH, true),\nStartSpot(AIFloat3(6000,0,11400), AiRole::FRONT, true),\n')
    call=[sys.executable,str(playtest.HERE/'playtest.py')]
    subprocess.run(call+['stage','--dir',str(directory),'--dll',str(args.dll),'--data',str(args.data),
        '--map','Tundra Continents v2.3.1','--map-file',str(starts),'--role','TECH','--roles','all','--ally-spots','1',
        '--side','cortex','--ai-option','profile=experimental_balanced','--mode','fast','--headless','--speed','20',
        '--minutes','12','--shots','','--bonus','0','--modoption','deathmode=neverend',
        '--modoption','startmetal=100000','--modoption','startmetalstorage=1000000',
        '--modoption','startenergy=1000000','--modoption','startenergystorage=1000000',
        '--extra-widget',str(playtest.HERE/'widgets/coastal_support_watch.lua')],check=True)
    source=directory/'AI/Skirmish/BARbTest/test/script/src'
    (source/'coastal_support_probe.as').write_text((playtest.HERE/'fixtures/coastal_support_probe.as').read_text())
    profile=source.parent/'experimental_balanced/main.as'
    profile.write_text('#include "../src/coastal_support_probe.as"\n'+profile.read_text())
    inject_entry(profile,'void AiLuaMessage(const string& in data)','if (CoastalProbe::Handle(data)) return;')
    inject_entry(profile,'void AiUpdate()','CoastalProbe::Tick();')
    inject_entry(source/'roles/tech/tech.as','void Tech_EconomyUpdate()','if (ai.frame>=0) return;')
    inject_entry(source/'manager/builder.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)','if (ai.frame>=0) return CoastalProbe::Task(u);')
    inject_entry(source/'manager/factory.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.frame>=0) { if (CoastalProbe::phase>=1 && u.circuitDef.GetName()=="cornanotcplat") {'
        'IUnitTask@ work=RoleTech::Tech_TurretWork(u,true); if(work !is null) return work; } '
        'return aiFactoryMgr.Enqueue(TaskS::Wait(false,SECOND)); }')
    inject_entry(source/'systems/diagnostics/invariants.as','void Tick()','if (ai.frame>=0) return;')
    checks={'stop_minute':12,'complete_on':{'key':'done','pattern':r'\[CoastalTest\] PASS reachable advanced factory completed','scope':'any'},
        'completion_grace_seconds':10,'expect':[{'key':label,'pattern':r'\[CoastalTest\] PASS '+label,'scope':'any','by_minute':12}
            for label in ['shore fixture','incapable builder stays land only','naval turret completed','air builder released','naval turret assists land',
                          'ridge blocks original factory','reachable advanced factory completed']],
        'forbid':[{'key':'error','pattern':r'\[CoastalTest\] FAIL|: ERR\s+:|SCRIPT CRASH|Lib exception|has crashed|Access violation','scope':'any'}]}
    check=directory/'checks.json';check.write_text(json.dumps(checks,indent=2))
    (directory/'fixture-inputs.json').write_text(json.dumps({'overrides':['supplied resources, corcs, coraca and corck',
        'bounded artificial shore zone on real Tundra terrain','normal economy/factory work held',
        'general economy invariants disabled for supplied fixture'],'profile':'experimental_balanced'},indent=2))
    launcher=directory/'launcher.md'
    code=1
    try:
        with launcher.open('w') as log:
            subprocess.run(call+['launch','--dir',str(directory),'--headless'],stdout=log,stderr=subprocess.STDOUT,check=True)
            code=subprocess.call(call+['watch','--dir',str(directory),'--role','TECH','--minutes','12','--wall-minutes','8',
                '--checks',str(check)],stdout=log,stderr=subprocess.STDOUT)
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)
    reports=re.findall(r'\[playtest\] report: (.+)',launcher.read_text())
    if reports:
        archive=Path(reports[-1].strip()).parent
        (archive/'coastal-evidence.json').write_text(json.dumps([line for line in
            (archive/'infolog.txt').read_text(errors='replace').splitlines()
            if any(key in line for key in ('Coastal','RESERVE:','[Playtest]','ERR','WARN'))],indent=2))
        print('PUBLISHED='+str(storage.publish(archive)),flush=True)
        print((archive/'result.json').read_text(),flush=True)
        subprocess.run([sys.executable,str(playtest.HERE/'prune_benchmarks.py'),'--apply','--path',str(directory)],check=True)
    return code

if __name__=='__main__': sys.exit(main())
