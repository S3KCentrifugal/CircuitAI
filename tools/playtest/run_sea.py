"""Pin, run and archive an isolated SEA migration comparison (ordinary resources)."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import playtest
import storage

MAPS = {'glacial':'Glacial Gap v1.1', 'supreme':'Supreme Isthmus v1.7',
        'tundra':'Tundra Continents v2.3.1', 'caldera':'Serene Caldera v1.3',
        'erebos':'Erebos Lakes v1.0', 'shore':'Shore_to_Shore_V3'}

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--map',choices=MAPS,default='glacial')
    p.add_argument('--dll',type=Path,required=True)
    p.add_argument('--data',type=Path,default=playtest.REPO/'data')
    p.add_argument('--scenario',default='migration')
    p.add_argument('--legacy',action='store_true')
    p.add_argument('--minutes',type=float,default=30)
    p.add_argument('--speed',type=float,default=15)
    p.add_argument('--seed',type=int,default=1881001)
    p.add_argument('--side',choices=('armada','cortex','legion'),default='armada')
    p.add_argument('--profile',default='experimental_hard')
    p.add_argument('--roles',default='SEA')
    p.add_argument('--headless',action='store_true')
    p.add_argument('--stage-only',action='store_true')
    p.add_argument('--keep-going',action='store_true',help='Preserve failed checks but continue to the requested horizon')
    p.add_argument('--base-observer',action='store_true',help='Observe completed later-yard facing and economy separation')
    p.add_argument('--expansion-observer',action='store_true',help='Record mex advance, naval defenses and worker losses')
    p.add_argument('--checks',help='Explicit categorized gameplay assertions; default is the existing SEA smoke suite')
    p.add_argument('--fixture',choices=['harbor'])
    a=p.parse_args()
    if a.fixture and (a.map!='glacial' or a.side!='armada' or a.legacy):
        p.error('The supplied harbor fixture currently requires migrated Armada on Glacial Gap')
    d=storage.allocate('sea','layout' if a.fixture else 'economy',a.scenario,a.map,'supplied' if a.fixture else 'benchmark',seed=a.seed)
    print('SEA_DIRECTORY='+str(d),flush=True)
    call=[sys.executable,str(playtest.HERE/'playtest.py')]
    shots='' if a.headless else '5,10,20,29'
    if a.map=='glacial' and not a.headless: shots='5@2800@1450:4350,10@3200@1450:4350,20@3800@1700:4550,29@4000@1700:4550'
    if a.fixture and not a.headless: shots='5@3500@2200:4200,10@3500@2200:4200,19@4000@2200:4200'
    cmd=call+['stage','--dir',str(d),'--dll',str(a.dll),'--data',str(a.data),'--map',MAPS[a.map],
        '--game','Beyond All Reason test-31479-433a460','--engine','recoil_2026.07.04','--role','SEA',
        '--roles',a.roles,'--side',a.side,'--bonus','0','--speed',str(a.speed),'--minutes',str(a.minutes),
        '--shots',shots,'--width','1280','--height','720','--lean-render',
        '--ai-option','profile='+a.profile,'--ai-option','random_seed='+str(a.seed),
        '--extra-widget',str(playtest.HERE/'widgets/sea_watch.lua')]
    if a.headless: cmd.append('--headless')
    if a.map=='shore':
        cmd += ['--map-file',str(playtest.REPO/'data/script/src/maps/shore_to_shore.as')]
    if a.base_observer:
        cmd += ['--extra-widget',str(playtest.HERE/'widgets/sea_allied_base_watch.lua')]
    if a.expansion_observer:
        cmd += ['--extra-widget',str(playtest.HERE/'widgets/sea_expansion_watch.lua')]
        if a.map=='glacial': cmd[cmd.index('--shots')+1]='5@5000@2800:4800,10@5500@4000:4800,14@7000@6500:4800'
    if a.fixture:
        cmd += ['--extra-widget',str(playtest.HERE/'widgets/sea_harbor_fixture.lua'),'--modoption','deathmode=neverend']
    subprocess.run(cmd,check=True)
    if a.base_observer:
        from air_arena import lua
        (d/'LuaUI/Config').mkdir(parents=True,exist_ok=True)
        (d/'LuaUI/Config/sea_base.lua').write_text('return '+lua({'supplied':False,'teams':json.loads((d/'teams.json').read_text())['teams']})+'\n')
    script=d/'script.txt'
    script.write_text(script.read_text().replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed='+str(a.seed)+';',1))
    globals_file=d/'AI/Skirmish/BARbTest/test/script/src/global.as'
    s=globals_file.read_text()
    if 'namespace Sea {' in s and 'bool ExperimentalBuild' in s.split('namespace Sea {',1)[1].split('namespace ',1)[0]:
        before,sea=s.split('namespace Sea {',1)
        import re
        sea,n=re.subn(r'bool ExperimentalBuild = (?:false|true);','bool ExperimentalBuild = '+('false' if a.legacy else 'true')+';',sea,count=1)
        assert n==1
        globals_file.write_text(before+'namespace Sea {'+sea)
    elif not a.legacy:
        raise ValueError('SEA migration flag missing from pinned data')
    if a.fixture:
        scripts=globals_file.parent
        (scripts/'roles/sea_harbor_probe.as').write_text((playtest.HERE/'sea_harbor_probe.as').read_text())
        build=scripts/'roles/sea_build.as'; text=build.read_text()
        needle='LayoutHelpers::CheckAlliedPlacements();'
        assert text.count(needle)==1
        build.write_text('#include "sea_harbor_probe.as"\n'+text.replace(needle,needle+'\n        SeaHarborProbe::Tick();'))
        for name,manager,descriptor in [('builder','aiBuilderMgr','TaskB::Wait(60 * SECOND)'),('factory','aiFactoryMgr','TaskS::Wait(false,60 * SECOND)')]:
            path=scripts/'manager'/(name+'.as'); text=path.read_text(); at=text.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'); brace=text.index('{',at)
            path.write_text(text[:brace+1]+'\n if (ai.teamId!=0) return '+manager+'.Enqueue('+descriptor+');\n'+text[brace+1:])
    (d/'sea-fixture.json').write_text(json.dumps({'enabled':not a.legacy,'supplied_assets':bool(a.fixture),
        'map':MAPS[a.map],'seed':a.seed,'engine_seed':a.seed,'minutes':a.minutes,'profile':a.profile,'side':a.side,
        'dll_sha256':hashlib.sha256(a.dll.read_bytes()).hexdigest()},indent=2))
    subprocess.run([sys.executable,str(playtest.REPO/'tools/knowledge/check_script_api.py'),'--dll',str(a.dll),'--scripts',str(globals_file.parent.parent)],check=True)
    if a.stage_only: return 0
    subprocess.run(call+['launch','--dir',str(d),'--engine','recoil_2026.07.04']+(['--headless'] if a.headless else []),check=True)
    return subprocess.run(call+['watch','--dir',str(d),'--role','SEA','--checks',a.checks or ('harbor-lifecycle' if a.fixture else 'sea_compile'),'--minutes',str(a.minutes),'--wall-minutes','30']+(['--keep-going'] if a.keep_going else [])).returncode

if __name__=='__main__': sys.exit(main())
