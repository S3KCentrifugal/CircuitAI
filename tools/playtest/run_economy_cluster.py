"""Supplied TECH cluster priority, local batching and actual construction progress."""
import argparse
import json
from pathlib import Path
import re
import subprocess
import sys
import playtest
import storage
from run_retirement_regression import inject_entry
from run_tech_rush_timelines import pin_strategy

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll',type=Path,required=True)
    parser.add_argument('--data',type=Path,required=True)
    args=parser.parse_args()
    directory=storage.allocate('tech','economy','economy-cluster','isthmus','supplied',seed=3211)
    print('CLUSTER_DIRECTORY='+str(directory),flush=True)
    starts=directory/'starts.as'
    starts.write_text('StartSpot(AIFloat3(11184,0,2128), AiRole::TECH, true),\nStartSpot(AIFloat3(6000,0,6000), AiRole::FRONT, true),\n')
    call=[sys.executable,str(playtest.HERE/'playtest.py')]
    subprocess.run(call+['stage','--dir',str(directory),'--dll',str(args.dll),'--data',str(args.data),
        '--map','Supreme Isthmus v1.7','--map-file',str(starts),'--role','TECH','--roles','all','--ally-spots','1',
        '--side','cortex','--ai-option','profile=experimental_balanced','--mode','fast','--headless','--speed','20',
        '--minutes','12','--shots','','--bonus','0','--modoption','deathmode=neverend',
        '--modoption','startmetal=100000','--modoption','startmetalstorage=1000000',
        '--modoption','startenergy=1000000','--modoption','startenergystorage=1000000',
        '--extra-widget',str(playtest.HERE/'widgets/economy_cluster_supply.lua')],check=True)
    source=directory/'AI/Skirmish/BARbTest/test/script/src'
    (source/'economy_cluster_probe.as').write_text((playtest.HERE/'fixtures/economy_cluster_probe.as').read_text())
    profile=source.parent/'experimental_balanced/main.as'
    profile.write_text('#include "../src/economy_cluster_probe.as"\n'+profile.read_text())
    pin_strategy(profile,'autoeco')
    inject_entry(profile,'void AiLuaMessage(const string& in data)','if (ClusterProbe::Handle(data)) return;')
    inject_entry(profile,'void AiUpdate()','ClusterProbe::Tick();')
    inject_entry(source/'roles/tech/tech.as','void Tech_EconomyUpdate()','if (ai.frame>=0) return;')
    inject_entry(source/'manager/builder.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)','if (ai.frame>=0) return ClusterProbe::Task(u);')
    inject_entry(source/'manager/factory.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.frame>=0) { if (ClusterProbe::phase>=1 && u.circuitDef.GetName()=="cornanotc") {'
        'IUnitTask@ work=EconomyCluster::Assist(u,true); if(work !is null) return work; } '
        'return aiFactoryMgr.Enqueue(TaskS::Wait(false,SECOND)); }')
    inject_entry(source/'systems/diagnostics/invariants.as','void Tick()','if (ai.frame>=0) return;')
    checks={'stop_minute':12,'complete_on':{'key':'done','pattern':r'\[ClusterTest\] PASS completed locally in priority order','scope':'any'},
        'completion_grace_seconds':10,'expect':[{'key':label,'pattern':r'\[ClusterTest\] PASS '+label,'scope':'any','by_minute':12}
            for label in ['TECH role resolved','scoped index group and invalid queries','fixture reservations',
                          'frames and first turret ready','ten distinct local projects','unchanged repair task retained',
                          'turrets prioritize turret frames','surplus redirects to converter','AFUS after converter',
                          'fusion after AFUS','completed locally in priority order']],
        'forbid':[{'key':'error','pattern':r'\[ClusterTest\] FAIL|: ERR\s+:|SCRIPT CRASH|Lib exception|has crashed|Access violation','scope':'any'}]}
    check=directory/'checks.json';check.write_text(json.dumps(checks,indent=2))
    (directory/'fixture-inputs.json').write_text(json.dumps({'overrides':['supplied resources, 12 corca, 3 coraca and four completed AFUS',
        'two bounded clusters on real Isthmus terrain; remote cluster must remain untouched','normal economy/factory work held',
        'energy admission disabled to stage an older unfinished fusion alongside supplied AFUS',
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
        (archive/'cluster-evidence.json').write_text(json.dumps([line for line in
            (archive/'infolog.txt').read_text(errors='replace').splitlines()
            if any(key in line for key in ('Cluster','RESERVE:','EXP:','[Playtest]','ERR','WARN'))],indent=2))
        print('PUBLISHED='+str(storage.publish(archive)),flush=True)
        print((archive/'result.json').read_text(),flush=True)
        subprocess.run([sys.executable,str(playtest.HERE/'prune_benchmarks.py'),'--apply','--path',str(directory)],check=True)
    return code

if __name__=='__main__': sys.exit(main())
