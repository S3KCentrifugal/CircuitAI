"""Isolated SEA combat fixtures. Assets are supplied; AI alone commands combat."""
import argparse, hashlib, json, re, subprocess, sys
from pathlib import Path
import playtest, storage
from air_arena import lua

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]

def prepare(a):
    case=json.loads(storage.resolve_definition(a.case,'cases').read_text())
    label=a.case[:19]+('-ctrl' if a.control else '-cand')
    d=storage.allocate('sea','combat',label,'glacial','supplied',seed=a.seed)
    starts=d/'starts.as'; starts.write_text('StartSpot(AIFloat3(2300,0,4400), AiRole::SEA, false),\nStartSpot(AIFloat3(4600,0,4400), AiRole::SEA, false),\n')
    call=[sys.executable,str(HERE/'playtest.py')]
    subprocess.run(call+['stage','--dir',str(d),'--dll',str(a.dll),'--data',str(a.data),'--map','Glacial Gap v1.1','--map-file',str(starts),
        '--game','Beyond All Reason test-31479-433a460','--engine','recoil_2026.07.04','--role','SEA','--roles','all','--ally-spots','1','--side',a.side,
        '--speed',str(a.speed),'--minutes',str(a.minutes),'--shots','0.4@2400@3400:4450,0.7@2400@3400:4450,3@3200@3400:4450,7@4000@3400:4450',
        '--width','1280','--height','720','--lean-render','--bonus','0','--ai-option','profile='+a.profile,'--ai-option','random_seed='+str(a.seed),
        '--modoption','deathmode=neverend','--modoption','startenergy=1000000','--modoption','startenergystorage=1000000',
        '--extra-widget',str(HERE/'widgets/sea_arena.lua'),
        '--extra-widget',str(HERE/'widgets/workforce_perf_watch.lua')],check=True)
    script=d/'script.txt'; s=script.read_text();s=s.replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed='+str(a.seed)+';',1);script.write_text(s)
    staged=d/'AI/Skirmish/BARbTest/test/script'; g=staged/'src/global.as';s=g.read_text();before,sea=s.split('namespace Sea {',1)
    sea,n=re.subn(r'bool ExperimentalBuild = (true|false);','bool ExperimentalBuild = true;',sea,count=1);assert n==1
    if a.control: sea=sea.replace('bool AdaptiveFleet = true;','bool AdaptiveFleet = false;')
    if a.order_slack is not None:
        sea,n=re.subn(r'float OrderPositionSlack = [^;]+;', 'float OrderPositionSlack = '+str(a.order_slack)+'f;',sea,count=1);assert n==1
    g.write_text(before+'namespace Sea {'+sea)
    # Constructors are frozen in all combat-only tests. Production is real only
    # in response cases, where actual supplied economy funds new hulls.
    for name,manager,wait in [('builder','aiBuilderMgr','TaskB::Wait(60*SECOND)'),('factory','aiFactoryMgr','TaskS::Wait(false,60*SECOND)')]:
        if name=='factory' and case.get('production'): continue
        p=staged/'src/manager'/(name+'.as');s=p.read_text();b=s.index('{',s.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))
        # Recovery submarines must retain their native reclaim/repair task and
        # leave the yard. Freezing them like construction ships can obstruct
        # subsequent hulls and turn a response test into a fixture artifact.
        condition='(SeaEconomy::ConstructorDef(u.circuitDef) || UnitHelpers::IsCommander(u.circuitDef))' if name=='builder' and case.get('support_turrets') else 'ai.frame>=0'
        p.write_text(s[:b+1]+'\n if ('+condition+') return '+manager+'.Enqueue('+wait+'); // supplied fixture only\n'+s[b+1:])
    if case.get('production'):
        # Finish the supplied initial workforce before the first recruitment
        # decision; otherwise the just-spawned yard creates an extra builder.
        p=staged/'src/manager/factory.as';s=p.read_text();b=s.index('{',s.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))
        p.write_text(s[:b+1]+'\n if (ai.frame<600) return aiFactoryMgr.Enqueue(TaskS::Wait(false,SECOND)); // fixture setup barrier\n'+s[b+1:])
    setup=staged/'src/setup.as';s=setup.read_text();s=s.replace('Global::AISettings::Role = derivedRole;','derivedRole=AiRole::SEA;\nGlobal::AISettings::Role = derivedRole;');setup.write_text(s)
    case.update(seed=a.seed,side=a.side,minutes=a.minutes,control=a.control,order_slack=a.order_slack)
    (d/'LuaUI/Config').mkdir(exist_ok=True,parents=True);(d/'LuaUI/Config/sea_arena.lua').write_text('return '+lua(case)+'\n')
    (d/'sea-arena.json').write_text(json.dumps(case,indent=2))
    (d/'sea-arena-pins.json').write_text(json.dumps({
        'dll_sha256':hashlib.sha256(a.dll.read_bytes()).hexdigest(),
        'staged_data':{str(p.relative_to(staged.parent)):hashlib.sha256(p.read_bytes()).hexdigest()
            for p in staged.parent.rglob('*') if p.is_file() and p.suffix in ('.as','.json')},
        'observer_sha256':hashlib.sha256((HERE/'widgets/sea_arena.lua').read_bytes()).hexdigest(),
        'overrides':['SEA role forced','economic builders frozen; recovery active in supported fixtures','factories frozen unless production fixture; setup barrier at frame 600','supplied forces and startup energy','fixed engine RNG seed']},indent=2))
    subprocess.run([sys.executable,str(ROOT/'tools/knowledge/check_script_api.py'),'--dll',str(a.dll),'--scripts',str(staged)],check=True)
    print('SEA_ARENA='+str(d),flush=True)
    return d,call,case.get('checks','sea-arena')

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--case',default='surface-line');p.add_argument('--dll',required=True,type=Path)
    p.add_argument('--data',type=Path,default=ROOT/'data');p.add_argument('--side',default='armada');p.add_argument('--profile',default='experimental_hard')
    p.add_argument('--control',action='store_true');p.add_argument('--seed',type=int,default=1891);p.add_argument('--minutes',type=int,default=8);p.add_argument('--speed',type=int,default=10)
    p.add_argument('--order-slack',type=float,help='Isolate optional native naval order changes; zero uses native defaults')
    a=p.parse_args();d,call,checks=prepare(a)
    subprocess.run(call+['launch','--dir',str(d),'--engine','recoil_2026.07.04'],check=True)
    return subprocess.run(call+['watch','--dir',str(d),'--role','SEA','--checks',checks,'--minutes',str(a.minutes),'--wall-minutes','15']).returncode

if __name__=='__main__':sys.exit(main())
