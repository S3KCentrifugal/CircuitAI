"""Serial natural-economy 8v8 diagnostics, ending on GameOver or a safety horizon.

Only the staged tree gains timing wrappers and, for Full Metal Plate, explicit
start/role registration. Production policy, cadence and commands stay intact.
"""
import argparse,json,os,re,subprocess,sys
from pathlib import Path
import playtest,storage
from air_arena import lua


def wrap(path,name,result,args,call,label):
    source=path.read_text(encoding='utf-8')
    pattern=re.compile(r'\b'+re.escape(result)+r'\s+'+name+r'\s*\('+re.escape(args)+r'\)\s*\{')
    matches=list(pattern.finditer(source))
    if len(matches)!=1:raise ValueError(f'Expected one definition: {path} {name}')
    match=matches[0]
    private='_Perf_'+name
    value='' if result=='void' else result+' value = '
    returned='' if result=='void' else 'return value;'
    wrapper=(f'{result} {name}({args}) {{\n'
             f' if (AiPerfEnabled) AiPerfBeginLabel("{label}");\n'
             f' {value}{private}({call});\n'
             f' if (AiPerfEnabled) AiPerfEndLabel();\n {returned}\n}}\n'
             f'{result} {private}({args}) {{')
    path.write_text(source[:match.start()]+wrapper+source[match.end():],encoding='utf-8')


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--map',choices=['metal-plate','glacial'],required=True)
    p.add_argument('--dll',type=Path,required=True)
    p.add_argument('--minutes',type=int,default=90,help='Safety horizon; GameOver ends earlier')
    p.add_argument('--stage-only',action='store_true')
    p.add_argument('--detail-sea',action='store_true',help='Additional staged SEA subphase labels; use in a separate attribution run')
    a=p.parse_args()
    # Native oracles deliberately repeat old work (and snapshot verification
    # rebuilds the legacy ally view). Presence, even value "0", enables them.
    # Reject contaminated timing rather than silently unsetting user intent.
    if any(name in os.environ for name in ('CIRCUIT_VERIFY_RANGED_QUERIES','CIRCUIT_VERIFY_RANGED_SNAPSHOT')):
        p.error('Unset CIRCUIT_VERIFY_RANGED_QUERIES and CIRCUIT_VERIFY_RANGED_SNAPSHOT for timing runs')
    d=storage.allocate('shared','performance','full-match-profile',a.map,'natural',seed=220001)
    print('FULL_MATCH_DIRECTORY='+str(d),flush=True)
    (playtest.REPO/'build-theatres/perf-current.txt').write_text(str(d))
    name='Full Metal Plate 1.7' if a.map=='metal-plate' else 'Glacial Gap v1.1'
    extra=[]
    if a.map=='metal-plate':
        first=[(1400,1200,'TECH'),(3400,900,'AIR'),(800,3400,'SUPPORT'),(2100,2500,'TACTICAL'),
               (4600,1600,'FRONT'),(3600,3000,'FRONT'),(2200,4300,'FRONT'),(800,5100,'FRONT')]
        spots=first+[(12288-x,12288-z,r) for x,z,r in first]
        fixture='namespace FullMatchPlate {\nStartSpot@[] spots={\n'+',\n'.join(
            f'StartSpot(AIFloat3({x},0,{z}),AiRole::{r},false)' for x,z,r in spots)
        fixture+='\n};\ndictionary limits;\nMapConfig config=MapConfig("Full Metal Plate",limits,spots,null);\n}\n'
        map_file=d/'metal-plate-eight.as';map_file.write_text(fixture)
        extra=['--map-file',str(map_file)]
    focus={'x':2800,'z':2600,'height':6500} if a.map=='metal-plate' else {'x':2000,'z':3200,'height':6500}
    # The screenshot callback captures the current speed before queued speed
    # commands apply. Resume after the screenshot, never in the same frame.
    shot_minutes=[5,10,15,20,30,40,50,60,70,80,89]
    changes=[(0,12),(4,1),(19,1),(39,1),(59,1),(79,1)]
    # Glacial includes adjacent 1x profiler-on/off/on observations. Populations
    # still evolve, so this is a confound check, not an exact overhead estimate.
    if a.map=='glacial':changes += [(29,1),(34.15,12)]
    changes += [(m+.15,12) for m in shot_minutes if not (a.map=='glacial' and m==30)]
    plan=','.join(f'{m}:{speed}' for m,speed in sorted(changes))
    shots=','.join(f'{m}@{focus["height"]}@{focus["x"]}:{focus["z"]}' for m in shot_minutes)
    cli=[sys.executable,str(playtest.HERE/'playtest.py')]
    cmd=cli+['stage','--dir',str(d),'--dll',str(a.dll),'--map',name,*extra,
       '--game','Beyond All Reason test-31479-433a460','--engine','recoil_2026.07.04',
       '--roles','all','--role','AIR','--side','armada','--bonus','0',
       '--ai-option','profile=experimental_hard','--ai-option','random_seed=220001',
       '--modoption','deathmode=com','--minutes',str(a.minutes),'--speed','12','--speed-plan',plan,
       '--shots',shots,'--width','1280','--height','720','--lean-render']
    for widget in ['skirmish_perf_watch.lua','air_command_watch.lua','perf_spectator_cleanup.lua','full_match_perf.lua']:
        cmd+=['--extra-widget',str(playtest.HERE/'widgets'/widget)]
    subprocess.run(cmd,check=True)
    scripts=d/'AI/Skirmish/BARbTest/test/script'
    if a.map=='metal-plate':
        (scripts/'src/maps/full_match_plate.as').write_text(fixture)
        path=scripts/'src/maps.as';source=path.read_text()
        needle='void registerMaps() {';assert source.count(needle)==1
        path.write_text('#include "maps/full_match_plate.as"\n'+source.replace(needle,needle+'\n mapManager.RegisterMapConfig(FullMatchPlate::config);'))
    for manager in ['builder','factory','military']:
        wrap(scripts/f'src/manager/{manager}.as','AiMakeTask','IUnitTask@','CCircuitUnit@ u','u',manager+'-dispatch')
    wrap(scripts/'src/manager/economy.as','AiUpdateEconomy','void','','','economy-update')
    for role in ['air','tech','sea','front','support','tactical']:
        wrap(scripts/f'src/roles/{role}.as',role.title()+'_MainUpdate','void','','',role+'-update')
    if a.detail_sea:
        for section in ['economy','combat','patrol','operations','recovery','coast','expansion','invasion','eco_layout']:
            wrap(scripts/f'src/manager/sea_{section}.as','Tick','void','','','sea.'+section)
        for section in ['build','factories']:
            wrap(scripts/f'src/roles/sea_{section}.as','Tick','void','','','sea.'+section)
        wrap(scripts/'src/manager/sea_layout.as','RefreshGeometry','void','','','sea.geometry')
    cfg=d/'LuaUI/Config';cfg.mkdir(exist_ok=True)
    (cfg/'full_match_perf.lua').write_text('return '+lua(focus)+'\n')
    profiler={'profiling':True}
    if a.map=='glacial':profiler['changes']=[{'minute':30,'enabled':False},{'minute':32,'enabled':True}]
    (cfg/'skirmish_perf.lua').write_text('return '+lua(profiler)+'\n')
    path=d/'script.txt';source=path.read_text();assert source.count('[GAME]\n{')==1
    path.write_text(source.replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed=220001;',1))
    checks=json.loads((playtest.HERE/'checks/shared/performance/full-match-profile.json').read_text())
    checks['stop_minute']=a.minutes
    (d/'full-match-checks.json').write_text(json.dumps(checks,indent=2))
    (d/'full-match-manifest.json').write_text(json.dumps({
        'map':name,'seed':220001,'profile':'experimental_hard','native_phases':True,'engine_profiler':True,
        'ranged_verification_oracles':False,
        'labels':'staged wrappers only; no policy/cadence/command changes','camera':focus,'safety_horizon':a.minutes,
        'ordinary_resources':True,'deathmode':'com','spectator_cleanup':True,'engine_profiler_plan':profiler,'sea_subphases':a.detail_sea,
        'data_hashes':{str(x.relative_to(scripts.parent)):storage.file_hash(x) for x in scripts.parent.rglob('*') if x.is_file() and x.suffix!='.dbg'}},indent=2))
    subprocess.run([sys.executable,str(playtest.REPO/'tools/knowledge/check_script_api.py'),'--dll',str(a.dll),'--scripts',str(scripts)],check=True)
    if a.stage_only:return 0
    subprocess.run(cli+['launch','--dir',str(d),'--engine','recoil_2026.07.04'],env={**os.environ,'CIRCUIT_PERF_PHASES':'1'},check=True)
    return subprocess.run(cli+['watch','--dir',str(d),'--role','AIR','--checks',str(d/'full-match-checks.json'),
        '--minutes',str(a.minutes),'--wall-minutes','180','--keep-going']).returncode


if __name__=='__main__':raise SystemExit(main())
