"""Verify the four-step forward artillery cluster for each faction and tier."""
import argparse
import json
import subprocess
import sys
from pathlib import Path

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir',type=Path,required=True)
    p.add_argument('--dll',type=Path,required=True)
    p.add_argument('--data',type=Path,default=ROOT/'data')
    p.add_argument('--side',choices=['armada','cortex','legion'],required=True)
    p.add_argument('--tier',type=int,choices=[1,2],required=True)
    p.add_argument('--visual',action='store_true')
    p.add_argument('--faults',action='store_true',help='cancel an LLT frame and force a mid-chain tier change in the staged fixture')
    args=p.parse_args()
    d=args.dir.resolve(); d.mkdir(parents=True,exist_ok=True)
    minutes=6 if args.tier==1 else 18
    starts=d/'starts.as'
    starts.write_text('StartSpot(AIFloat3(1536,0,3840), AiRole::FRONT, false),\n'
                      'StartSpot(AIFloat3(10752,0,3840), AiRole::FRONT, false),\n')
    def fixture(path):
        return path.read_text().replace('__SIDE__',args.side).replace('__T2__',str(args.tier==2).lower()).replace('__FAULTS__',str(args.faults).lower())
    observer=d/'observer.lua'
    observer.write_text(fixture(HERE/'widgets/artillery_cluster_watch.lua'))
    cmd=[sys.executable,str(HERE/'playtest.py')]
    result=None
    try:
        display=['--mode','visual','--shots','2.8@1600@6000:4000','--width','1280','--height','720'] if args.visual else ['--headless']
        subprocess.run(cmd+['stage','--dir',str(d),'--dll',str(args.dll),'--data',str(args.data),
            '--engine','recoil_2026.07.04','--game','Beyond All Reason test-31836-b250a16','--map','Full Metal Plate 1.7',
            '--map-file',str(starts),'--role','FRONT','--roles','FRONT','--side',args.side,'--others','none',
            '--speed','20','--minutes',str(minutes),'--ai-option','profile=experimental_balanced',
            '--modoption','experimentallegionfaction=1','--modoption','allowunitcontrolwidgets=1',
            '--modoption','allowuserwidgets=1','--extra-widget',str(observer)]+display,check=True)
        staged=d/'AI/Skirmish/BARbTest/test/script'
        setup=staged/'src/setup.as'
        setup.write_text(setup.read_text().replace('Global::AISettings::Role = derivedRole;',
            'derivedRole=AiRole::FRONT; Global::AISettings::Role = derivedRole;'))
        (staged/'src/artillery_cluster_probe.as').write_text(fixture(HERE/'fixtures/artillery_cluster_probe.as'))
        for file,signature,injection in [
            ('experimental_balanced/main.as','void AiUpdate()', 'if (ai.teamId>=0) { ArtilleryClusterProbe::Tick(); return; }'),
            ('src/manager/builder.as','IUnitTask@ AiMakeTask(CCircuitUnit@ u)','if (ai.teamId>=0) return ArtilleryClusterProbe::Work(u);'),
            ('src/manager/economy.as','void AiUpdateEconomy()','if (ai.teamId>=0) return;'),
            ('src/roles/front/front.as','void Front_EconomyUpdate()','if (ai.teamId>=0) return;')]:
            path=staged/file; source=path.read_text()
            pos=source.index('{',source.index(signature))+1
            source=source[:pos]+'\n'+injection+'\n'+source[pos:]
            if file=='experimental_balanced/main.as': source='#include "../src/artillery_cluster_probe.as"\n'+source
            path.write_text(source)
        checks={'stop_minute':minutes,'expect':[
            {'key':'observer','pattern':r'\[ArtilleryWatch\] loaded','scope':'any','by_minute':1},
            {'key':'fixture','pattern':r'\[ArtilleryTest\] fixture ready','scope':'any','by_minute':1},
            {'key':'complete','pattern':r'\[ArtilleryWatch\] PASS ordered four completed','scope':'any','by_minute':minutes}],
            'forbid':[{'key':'scripts','pattern':r': ERR\s+:|: WARN\s+:|SCRIPT CRASH|Lib exception|Access violation','scope':'any'},
                {'key':'assertions','pattern':r'\[Artillery(Test|Watch)\] (FAIL|ERROR)','scope':'any'}],
            'complete_on':{'key':'done','pattern':r'\[ArtilleryWatch\] PASS ordered four completed'},'completion_grace_seconds':20}
        if args.faults:
            checks['expect'] += [
                {'key':'cancelled','pattern':r'\[ArtilleryTest\] PASS cancelled task dead','scope':'any','by_minute':minutes},
                {'key':'transition','pattern':r'\[ArtilleryTest\] forced mid-chain tier transition','scope':'any','by_minute':minutes},
                {'key':'recovered','pattern':r'\[ArtilleryTest\] PASS cancelled task never reused','scope':'any','by_minute':minutes}]
        (d/'checks.json').write_text(json.dumps(checks,indent=2))
        subprocess.run(cmd+['launch','--dir',str(d),'--engine','recoil_2026.07.04']+([] if args.visual else ['--headless']),check=True)
        result=subprocess.run(cmd+['watch','--dir',str(d),'--checks',str(d/'checks.json'),'--minutes',str(minutes),
            '--wall-minutes','6','--play-decided'])
        return result.returncode
    finally:
        if result is None: subprocess.run(cmd+['stop','--dir',str(d)],check=False)


if __name__=='__main__':
    raise SystemExit(main())
