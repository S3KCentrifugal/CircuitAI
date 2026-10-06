"""Controlled all-role constructor loss with delayed TECH lab; optional Lua/ferry."""
import argparse
import json
from pathlib import Path
import subprocess
import sys
import playtest
import storage
from air_arena import lua

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dll',type=Path,required=True)
    p.add_argument('--ferry',action='store_true')
    p.add_argument('--relay',action='store_true')
    p.add_argument('--stage-only',action='store_true')
    p.add_argument('--profile',default='experimental_balanced')
    p.add_argument('--lab',choices=('armlab','corlab','leglab'),default='armlab')
    p.add_argument('--all-donations',action='store_true')
    p.add_argument('--destroy-lab',action='store_true')
    a=p.parse_args()
    scenario='recovery'+('-ferry' if a.ferry else '-walk')+('-lua' if a.relay else '-native')
    d=storage.allocate('shared','economy',scenario,'glacial','supplied',seed=218001)
    print('RECOVERY_DIRECTORY='+str(d),flush=True)
    Path('build-theatres/recovery-current.txt').write_text(str(d))
    cli=[sys.executable,str(playtest.HERE/'playtest.py')]
    cmd=cli+['stage','--dir',str(d),'--dll',str(a.dll),'--map','Glacial Gap v1.1',
        '--game','Beyond All Reason test-31479-433a460','--engine','recoil_2026.07.04',
        '--role','TECH','--roles','all','--side','armada','--bonus','0','--speed','12',
        '--minutes','8.1','--shots','2@2800@800:1400,4@3500@1000:1800,7@4000@1000:3000',
        '--set','InvariantForwardSeconds=100000','--set','FirstFactorySeconds=100000',
        '--width','1280','--height','720','--lean-render','--modoption','deathmode=neverend',
        '--ai-option','profile='+a.profile,'--extra-widget',str(playtest.HERE/'widgets/builder_recovery.lua')]
    if a.relay: cmd+=['--extra-widget',str(playtest.REPO/'tools/widgets/gui_barb_builder_recovery.lua')]
    subprocess.run(cmd,check=True)
    cfg={'teams':json.loads((d/'teams.json').read_text())['teams'],'ferry':a.ferry,
         'lab':a.lab,'independent':not a.all_donations,'destroy_lab':a.destroy_lab}
    (d/'LuaUI/Config').mkdir(parents=True,exist_ok=True)
    (d/'LuaUI/Config/builder_recovery.lua').write_text('return '+lua(cfg)+'\n')
    # Only fixture setup suppresses unrelated production/economy/combat. The
    # production policy under test, callbacks and request update are unchanged.
    base=d/'AI/Skirmish/BARbTest/test/script'
    for profile in ('experimental_balanced','experimental_hard','experimental_terrible'):
        path=base/profile/'main.as'; s=path.read_text()
        s=s.replace('Global::profileController.MainUpdate();','// fixture: freeze unrelated role economy/combat')
        path.write_text(s)
    path=base/'src/manager/builder.as';s=path.read_text()
    needle='IUnitTask@ AiMakeTask(CCircuitUnit@ u) {'
    assert needle in s
    s=s.replace(needle,needle+'\n if (Team::Ferry::IsGift(u.id)) return Team::Ferry::Park(u, false);\n if (ai.frame >= 0) return aiBuilderMgr.Enqueue(TaskB::Wait(2 * SECOND));\n')
    path.write_text(s)
    path=base/'src/manager/factory.as';s=path.read_text()
    needle='if (recovery !is null) return recovery;'
    assert needle in s
    s=s.replace(needle,needle+'\n if (ai.frame >= 0) return aiFactoryMgr.Enqueue(TaskS::Wait(false, 2 * SECOND));')
    path.write_text(s)
    (d/'fixture.json').write_text(json.dumps(vars(a),default=str,indent=2))
    checks=json.loads((playtest.HERE/'checks/shared/economy/builder-recovery.json').read_text())
    if a.all_donations:
        checks['forbid']=[c for c in checks['forbid'] if c['key']!='cancelled-request']
        checks['expect'].append({'key':'support-donation','pattern':'RecoveryFixture.*given team=3 ', 'by_minute':8,'scope':'any'})
    if a.destroy_lab:
        checks['expect'].append({'key':'replacement-lab','pattern':'RecoveryFixture.*replacement TECH lab supplied','by_minute':3,'scope':'any'})
    if a.relay:
        checks['expect'].append({'key':'lua-relay','pattern':'Recovery.*channel=lua verb=request','by_minute':2,'scope':'any'})
    if a.ferry:
        checks['expect'].append({'key':'ferry','pattern':'Ferry.*delivered constructor','by_minute':8,'scope':'any'})
    (d/'recovery-checks.json').write_text(json.dumps(checks,indent=2))
    if a.stage_only:return 0
    subprocess.run(cli+['launch','--dir',str(d),'--engine','recoil_2026.07.04'],check=True)
    return subprocess.run(cli+['watch','--dir',str(d),'--checks',str(d/'recovery-checks.json'),'--minutes','8.1','--keep-going']).returncode

if __name__=='__main__':raise SystemExit(main())

