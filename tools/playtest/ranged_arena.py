"""Supplied-force ranged combat: unchanged AI commands team 0; fixture owns team 1.

Each invocation allocates an immutable run identity. Economy is frozen only in
the staged scripts. --variant siege isolates the original two-list proposal;
--variant baseline takes a pinned pre-change --data/--dll pair.
"""
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path
import storage
from air_arena import lua

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def pool_symbols(staged):
    """Keep immutable symbols per content hash, not ~400 MB per short trial.

    Never link to the mutable build output: rebuilding it would corrupt older
    evidence. All original run paths remain valid and retain identical bytes.
    """
    path = staged / 'SkirmishAI.dbg'
    if not path.exists():
        return
    digest = storage.file_hash(path)
    pool = ROOT / 'build-theatres/ranged-rework/symbols'
    pool.mkdir(parents=True, exist_ok=True)
    target = pool / (digest + '.dbg')
    if not target.exists():
        path.replace(target)
    else:
        if storage.file_hash(target) != digest:
            raise RuntimeError('Corrupt symbol pool: ' + str(target))
        path.unlink()
    try:
        os.link(target, path)
    except OSError:
        import shutil
        shutil.copy2(target, path)


def prepare(args):
    case = json.loads(storage.resolve_definition(args.case, 'cases').read_text())
    directory = storage.allocate('shared', 'combat', case['name'], case['map_key'], 'supplied', seed=args.seed)
    starts = directory / 'starts.as'
    starts.write_text(''.join(f'StartSpot(AIFloat3({x},0,{z}), AiRole::FRONT, false),\n' for x,z in case['starts']))
    command = [sys.executable, str(HERE / 'playtest.py')]
    stage = command + ['stage','--dir',str(directory),'--dll',str(args.dll),'--data',str(args.data),
        '--map',case['map'],'--map-file',str(starts),'--role','FRONT','--roles','all','--ally-spots','1',
        '--side',case.get('side','armada'),'--game','Beyond All Reason test-31479-433a460',
        '--engine','recoil_2026.07.04','--speed',str(args.speed),'--minutes',str(args.minutes),
        '--shots','','--width','1280','--height','720','--lean-render','--bonus','0',
        '--ai-option','profile='+args.profile,'--ai-option','random_seed='+str(args.seed),
        '--modoption','deathmode=neverend','--modoption','startenergy='+str(case.get('start_energy',1000000)),
        '--modoption','startmetal='+str(case.get('start_metal',1000)),
        '--modoption','startmetalstorage='+str(case.get('start_metal',1000)),
        '--modoption','startenergystorage=1000000',
        '--extra-widget',str(HERE/'widgets/ranged_arena.lua'),
        '--extra-widget',str(HERE/'widgets/workforce_perf_watch.lua')]
    if args.headless: stage += ['--headless']
    subprocess.run(stage, check=True)
    script = directory/'script.txt'
    script.write_text(script.read_text().replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed='+str(args.seed)+';',1))
    staged = directory/'AI/Skirmish/BARbTest/test'
    pool_symbols(staged)
    setup=staged/'script/src/setup.as'
    setup.write_text(setup.read_text().replace('Global::AISettings::Role = derivedRole;',
        'derivedRole=AiRole::FRONT; Global::AISettings::Role = derivedRole;'))
    for name,manager,wait in [('builder','aiBuilderMgr','TaskB::Wait(60*SECOND)'),('factory','aiFactoryMgr','TaskS::Wait(false,60*SECOND)')]:
        path = staged/'script/src/manager'/(name+'.as')
        source = path.read_text(); start = source.index('{',source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
        repair='\n if (ai.teamId==1 && !u.circuitDef.IsMobile()) return aiBuilderMgr.DefaultMakeTask(u);' if name=='builder' and case.get('enemy_repair') else ''
        path.write_text(source[:start]+repair+'\n if (ai.frame>=0) return '+manager+'.Enqueue('+wait+'); // supplied arena only\n'+source[start:])
    path = staged/'script/src/manager/military.as'
    source = path.read_text(); start = source.index('{',source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
    # No commands to friendly combat units. The enemy follows a declared path
    # or holds its supplied position, with normal engine weapon firing.
    destination = case.get('enemy_destination')
    point = f'AIFloat3({destination[0]},0,{destination[1]})' if destination else 'u.GetPos(ai.frame)'
    override = '''
        if (ai.teamId==1 && u.circuitDef.IsMobile()) {
            CRouteTask@ route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            array<AIFloat3> points={'''+point+'''};
            route.SetTraversal(true,48,false); route.SetRoute(points); return route;
        } // enemy fixture only
'''
    path.write_text(source[:start]+override+source[start:])
    if args.variant=='siege':
        for path in (staged/'config').rglob('behaviour*.json'):
            data=path.read_bytes()
            for name in case.get('units',[case['unit']]):
                pattern=rb'("'+name.encode()+rb'"\s*:\s*\{)(.*?)(\n[ \t]*\},?)'
                match=re.search(pattern,data,re.S)
                if not match: continue
                block=re.sub(rb'("role"\s*:\s*)\[[^\]]*\]',rb'\1["artillery"]',match[2])
                if b'"attribute"' in block: block=re.sub(rb'("attribute"\s*:\s*)\[[^\]]*\]',rb'\1["siege"]',block)
                else: block=re.sub(rb'("role"[^\n]*\n)',rb'\1\t\t\t\t"attribute": ["siege"],\n',block)
                data=data[:match.start(2)]+block+data[match.end(2):]
            path.write_bytes(data)
    case.update(variant=args.variant,profile=args.profile,seed=args.seed,minutes=args.minutes,speed=args.speed,headless=args.headless)
    config=directory/'LuaUI/Config';config.mkdir(parents=True,exist_ok=True)
    (config/'ranged_arena.lua').write_text('return '+lua(case)+'\n')
    (directory/'ranged-arena.json').write_text(json.dumps(case,indent=2)+'\n')
    pins={'dll_sha256':hashlib.sha256(args.dll.read_bytes()).hexdigest(),
          'files':{str(p.relative_to(staged)):storage.file_hash(p) for p in staged.rglob('*') if p.is_file() and p.suffix in ('.as','.json')},
          'observer_sha256':storage.file_hash(HERE/'widgets/ranged_arena.lua'),
          'overrides':['supplied forces','fixed seed','startup energy'] +
              (['frozen economic builders/factories','scripted enemy path']
               if args.profile.startswith('experimental_') else ['native legacy economy remains active'])}
    (directory/'ranged-arena-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
    subprocess.run([sys.executable,str(ROOT/'tools/knowledge/check_script_api.py'),'--dll',str(args.dll),'--scripts',str(staged/'script')],check=True)
    print('RANGED_ARENA='+str(directory),flush=True)
    return directory, command


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case',required=True)
    parser.add_argument('--dll',required=True,type=Path)
    parser.add_argument('--data',type=Path,default=ROOT/'data')
    parser.add_argument('--variant',choices=['baseline','siege','ranged'],default='ranged')
    parser.add_argument('--profile',default='experimental_balanced')
    parser.add_argument('--seed',type=int,default=2071)
    parser.add_argument('--minutes',type=int,default=4)
    parser.add_argument('--speed',type=int,default=8)
    parser.add_argument('--headless',action='store_true')
    parser.add_argument('--stage-only',action='store_true')
    args=parser.parse_args();directory,command=prepare(args)
    if args.stage_only: return 0
    launch=command+['launch','--dir',str(directory),'--engine','recoil_2026.07.04']
    if args.headless: launch+=['--headless']
    subprocess.run(launch,check=True)
    case=json.loads((directory/'ranged-arena.json').read_text())
    return subprocess.run(command+['watch','--dir',str(directory),'--role','FRONT','--checks',case.get('checks','ranged-arena'),
        '--minutes',str(args.minutes),'--wall-minutes','8'],check=False).returncode

if __name__=='__main__':sys.exit(main())
