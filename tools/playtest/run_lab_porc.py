"""Supplied Cortex FRONT construction/lifecycle regression, experimental_balanced.

The probe holds unrelated work only in staged scripts. The planner/native
tasks issue all build/repair orders; a physical observer requires completion.
"""
import argparse
import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dir', type=Path, required=True)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, default=ROOT/'data')
    parser.add_argument('--variant', choices=['shared', 'help', 'cancel', 'loss'], required=True)
    parser.add_argument('--baseline', action='store_true')
    parser.add_argument('--visual', action='store_true')
    args = parser.parse_args()
    d = args.dir.resolve()
    d.mkdir(parents=True, exist_ok=True)
    starts = d/'starts.as'
    starts.write_text('StartSpot(AIFloat3(1536,0,3840), AiRole::FRONT, false),\n'
                      'StartSpot(AIFloat3(10752,0,3840), AiRole::FRONT, false),\n')
    widget = (HERE/'widgets/lab_porc_watch.lua').read_text().replace('__LOSS__', str(args.variant=='loss').lower())
    (d/'observer.lua').write_text(widget)
    cmd = [sys.executable, str(HERE/'playtest.py')]
    result = None
    display_args = ['--mode','visual','--shots','0.7@1400@5300:4000','--width','1280','--height','720'] if args.visual else ['--headless']
    try:
        subprocess.run(cmd+['stage', '--dir', str(d), '--dll', str(args.dll), '--data', str(args.data),
            '--engine', 'recoil_2026.07.04', '--game', 'Beyond All Reason test-31836-b250a16',
            '--map', 'Full Metal Plate 1.7', '--map-file', str(starts), '--role', 'FRONT', '--roles', 'FRONT',
            '--side', 'cortex', '--others', 'none', '--speed', '20', '--minutes', '4', *display_args,
            '--ai-option', 'profile=experimental_balanced', '--modoption', 'allowunitcontrolwidgets=1',
            '--modoption', 'allowuserwidgets=1', '--extra-widget', str(d/'observer.lua')], check=True)
        staged = d/'AI/Skirmish/BARbTest/test/script'
        setup = staged/'src/setup.as'
        setup.write_text(setup.read_text().replace('Global::AISettings::Role = derivedRole;',
            'derivedRole = AiRole::FRONT; Global::AISettings::Role = derivedRole;'))
        fixture = (HERE/'fixtures/lab_porc_probe.as').read_text()
        for key, value in {'__CANCEL__':args.variant=='cancel', '__LOSS__':args.variant=='loss',
                           '__SHARED__':args.variant=='shared'}.items():
            fixture = fixture.replace(key, str(value).lower())
        fixture = fixture.replace('__NULL_CHECK__', '' if args.baseline else
            'Check("null help rejected",FrontLabPorc::Help(null) is null);')
        fixture = fixture.replace('__HELP_DIAG__', '' if args.baseline else '''
            IBuilderTask@ pb=cast<IBuilderTask>(project);
            array<CCircuitUnit@>@ members=project.GetUnits();
            GenericHelpers::LogUtil("[LabPorcTest] help diagnostics t2="+FrontMexUp::IsT2Constructor(candidate)
                +" help="+(FrontLabPorc::Help(candidate) !is null)+" members="+members.length()
                +" dead="+project.IsDead()+" recovery="+FrontRecovery::Active()
                +" pos="+pb.GetBuildPos().x+","+pb.GetBuildPos().z+" role="+int(Global::AISettings::Role),1);
''')
        if args.baseline:
            fixture = fixture.replace('Check("null helper rejected",!FrontMexUp::Helper(null));', '')
        fixture = fixture.replace('__REPAIR_CHECK__', '' if args.baseline else '''
            IUnitTask@ repair=aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH,frame,120*SECOND));
            if (repair !is null && !repair.IsDead()) {
                aiBuilderMgr.AssignTask(ai.GetTeamUnit(spare),repair);
                Check("generic repair assigned",ai.GetTeamUnit(spare).task is repair);
                Check("generic defence repair protected",!FrontMexUp::Helper(ai.GetTeamUnit(spare)));
                aiBuilderMgr.AbortTask(repair);
            } else Check("generic defence repair allocated",false);
''')
        (staged/'src/lab_porc_probe.as').write_text(fixture)
        main_file = staged/'experimental_balanced/main.as'
        source = main_file.read_text()
        source = '#include "../src/lab_porc_probe.as"\n'+source
        pos = source.index('{', source.index('void AiUpdate()'))+1
        source = source[:pos]+'\n if (ai.teamId>=0) { LabPorcProbe::Tick(); return; }\n'+source[pos:]
        main_file.write_text(source)
        builder = staged/'src/manager/builder.as'
        source = builder.read_text()
        pos = source.index('{', source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
        source = source[:pos]+'\n if (ai.teamId>=0) return LabPorcProbe::Work(u);\n'+source[pos:]
        builder.write_text(source)
        economy = staged/'src/manager/economy.as'
        source = economy.read_text()
        pos = source.index('{', source.index('void AiUpdateEconomy()'))+1
        economy.write_text(source[:pos]+'\n if (ai.teamId>=0) return;\n'+source[pos:])
        # EconomyUpdate has a separate native cadence; hold ordinary providers
        # while retaining explicit calls to the real helper census in the probe.
        front = staged/'src/roles/front/front.as'
        source = front.read_text()
        pos = source.index('{', source.index('void Front_EconomyUpdate()'))+1
        front.write_text(source[:pos]+'\n if (ai.teamId>=0) return;\n'+source[pos:])
        checks = {'stop_minute':4, 'expect':[
            {'key':'observer','pattern':r'\[LabPorcWatch\] loaded','scope':'any','by_minute':1},
            {'key':'fixture','pattern':r'\[LabPorcTest\] PASS fixture ready','scope':'any','by_minute':1},
            {'key':'joined','pattern':r'\[LabPorcTest\] PASS helper joined active defence','scope':'any','by_minute':1},
            {'key':'protected','pattern':r'\[LabPorcTest\] PASS shared defence is not expendable','scope':'any','by_minute':1},
            {'key':'physical','pattern':r'\[LabPorcWatch\] original Scorpion completed','scope':'any','by_minute':4},
            {'key':'complete','pattern':r'\[LabPorcTest\] COMPLETE','scope':'any','by_minute':4}],
            'forbid':[{'key':'scripts','pattern':r': ERR\s+:|SCRIPT CRASH|Lib exception|Access violation','scope':'any'},
                      {'key':'fixture-failure','pattern':r'\[LabPorc(Test|Watch)\] (FAIL|ERROR)','scope':'any'}],
            'complete_on':{'key':'complete','pattern':r'\[LabPorcTest\] COMPLETE'},'completion_grace_seconds':20}
        (d/'checks.json').write_text(json.dumps(checks, indent=2))
        subprocess.run(cmd+['launch','--dir',str(d),'--engine','recoil_2026.07.04']+([] if args.visual else ['--headless']), check=True)
        result = subprocess.run(cmd+['watch','--dir',str(d),'--minutes','4','--checks',str(d/'checks.json'),
            '--wall-minutes','5','--play-decided'])
        return result.returncode
    finally:
        if result is None:
            subprocess.run(cmd+['stop','--dir',str(d)], check=False)


if __name__ == '__main__':
    raise SystemExit(main())
