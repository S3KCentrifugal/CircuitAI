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
    parser.add_argument('--bootstrap',action='store_true',help='run support-worker relocation and recovery fixture')
    parser.add_argument('--bootstrap-worker',choices=('corca','corck'),default='corca')
    parser.add_argument('--dll',type=Path,required=True)
    parser.add_argument('--data',type=Path,required=True)
    args=parser.parse_args()
    probe='rush_bootstrap' if args.bootstrap else 'economy_cluster'
    namespace='BootstrapProbe' if args.bootstrap else 'ClusterProbe'
    directory=storage.allocate('tech','economy',probe.replace('_','-'),'isthmus','supplied',seed=3211)
    print('CLUSTER_DIRECTORY='+str(directory),flush=True)
    starts=directory/'starts.as'
    starts.write_text('StartSpot(AIFloat3(11184,0,2128), AiRole::TECH, true),\nStartSpot(AIFloat3(6000,0,6000), AiRole::FRONT, true),\n')
    widget=playtest.HERE/('widgets/'+probe+'_supply.lua')
    if args.bootstrap:
        supplied=directory/'bootstrap_supply.lua'
        supplied.write_text(widget.read_text().replace('corca',args.bootstrap_worker))
        widget=supplied
    call=[sys.executable,str(playtest.HERE/'playtest.py')]
    subprocess.run(call+['stage','--dir',str(directory),'--dll',str(args.dll),'--data',str(args.data),
        '--map','Supreme Isthmus v1.7','--map-file',str(starts),'--role','TECH','--roles','all','--ally-spots','1',
        '--side','cortex','--ai-option','profile=experimental_balanced','--mode','fast','--headless','--speed','20',
        '--minutes','12','--shots','','--bonus','0','--modoption','deathmode=neverend',
        '--modoption','startmetal=100000','--modoption','startmetalstorage=1000000',
        '--modoption','startenergy=1000000','--modoption','startenergystorage=1000000',
        '--extra-widget',str(widget)],check=True)
    source=directory/'AI/Skirmish/BARbTest/test/script/src'
    fixture=(playtest.HERE/('fixtures/'+probe+'_probe.as')).read_text()
    if args.bootstrap: fixture=fixture.replace('corca',args.bootstrap_worker)
    (source/(probe+'_probe.as')).write_text(fixture)
    profile=source.parent/'experimental_balanced/main.as'
    profile.write_text('#include "../src/'+probe+'_probe.as"\n'+profile.read_text())
    pin_strategy(profile,'autoeco')
    inject_entry(profile,'void AiLuaMessage(const string& in data)','if ('+namespace+'::Handle(data)) return;')
    inject_entry(profile,'void AiUpdate()',namespace+'::Tick();')
    inject_entry(source/'roles/tech/tech.as','void Tech_EconomyUpdate()','if (ai.frame>=0) return;')
    inject_entry(source/'manager/builder.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)','if (ai.frame>=0) return '+namespace+'::Task(u);')
    inject_entry(source/'manager/factory.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.frame>=0) { if ('+('false' if args.bootstrap else 'ClusterProbe::phase>=1')+' && u.circuitDef.GetName()=="cornanotc") {'
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
    if args.bootstrap:
        labels=['TECH role resolved','fixture reservations','unsafe route refused','one remote worker no claim',
                'protected construction retained','lost worker replaced','invalid slot recovered',
                'completed support after travel']
        checks['expect']=[dict(key=label,pattern=r'\[BootstrapTest\] PASS '+label,scope='any',by_minute=12) for label in labels]
        checks['complete_on']=dict(key='done',pattern=r'\[BootstrapTest\] PASS completed support after travel',scope='any')
        checks['forbid'][0]['pattern']=checks['forbid'][0]['pattern'].replace('ClusterTest','BootstrapTest')
    check=directory/'checks.json';check.write_text(json.dumps(checks,indent=2))
    overrides=['supplied resources, 12 corca, 3 coraca and four completed AFUS',
        'two bounded clusters on real Isthmus terrain; remote cluster must remain untouched','normal economy/factory work held',
        'energy admission disabled to stage an older unfinished fusion alongside supplied AFUS',
        'general economy invariants disabled for supplied fixture']
    if args.bootstrap:
        overrides=['supplied resources and three remote '+args.bootstrap_worker+' constructors','bounded real-terrain support reservations',
            'nuke support requirement set to two; normal economy/factory work held',
            'negative threat tolerance temporarily forces route refusal; restored to zero',
            'selected worker destroyed and selected reservation removed to test recovery',
            'general economy invariants disabled for supplied fixture']
    (directory/'fixture-inputs.json').write_text(json.dumps({'overrides':overrides,'profile':'experimental_balanced'},indent=2))
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
            if any(key in line for key in ('Cluster','Bootstrap','RESERVE:','EXP:','[Playtest]','ERR','WARN'))],indent=2))
        print('PUBLISHED='+str(storage.publish(archive)),flush=True)
        print((archive/'result.json').read_text(),flush=True)
        subprocess.run([sys.executable,str(playtest.HERE/'prune_benchmarks.py'),'--apply','--path',str(directory)],check=True)
    return code

if __name__=='__main__': sys.exit(main())
