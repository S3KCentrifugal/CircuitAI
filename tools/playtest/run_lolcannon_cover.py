"""Targeted +100 headless regression for stale reservations and moved cannons.

Only the isolated staged scripts receive fixture state/ordinary-work holds.
The observer supplies constructors/resources; AI code orders and builds cover.
Use --data with an installed baseline to retain a failing control.
"""
import argparse
import hashlib
import json
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def prepare(args):
    directory = args.dir.resolve()
    directory.mkdir(parents=True, exist_ok=True)
    starts = directory / 'fixture-starts.as'
    starts.write_text('StartSpot(AIFloat3(1536,0,3840), AiRole::TECH, false),\n'
                      'StartSpot(AIFloat3(10752,0,3840), AiRole::TECH, false),\n')
    cmd = [sys.executable, str(HERE/'playtest.py')]
    subprocess.run(cmd + ['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
        '--engine', 'recoil_2026.07.04', '--game', args.game, '--map', 'Full Metal Plate 1.7', '--map-file', str(starts),
        '--role', 'TECH', '--roles', 'TECH', '--side', 'armada', '--others', 'none', '--bonus', '100',
        '--modoption', 'experimentalextraunits=1', '--modoption', 'allowunitcontrolwidgets=1',
        '--modoption', 'allowuserwidgets=1', '--speed', '20', '--minutes', str(args.minutes), '--headless',
        '--ai-option', 'profile=experimental_balanced', '--extra-widget', str(HERE/'widgets/lolcannon_cover_watch.lua')], check=True)
    staged = directory/'AI/Skirmish/BARbTest/test'
    setup = staged/'script/src/setup.as'
    setup.write_text(setup.read_text().replace('Global::AISettings::Role = derivedRole;',
        'derivedRole = AiRole::TECH; Global::AISettings::Role = derivedRole; // isolated TECH cover fixture'))
    role = staged/'script/src/roles/tech/tech.as'
    role.write_text(role.read_text().replace('void Tech_EconomyUpdate()\n\t{',
        'void Tech_EconomyUpdate()\n\t{\n        if (ai.teamId >= 0) return; // supplied construction fixture: no normal economy planning/invariants'))
    path = staged/'script/src/systems/construction/lolcannon.as'
    source = path.read_text()
    fixture = '''
    bool coverFixtureReady = false;
    bool coverFixtureMoved = false;
    bool coverFixtureStore = false;
    void CoverFixtureTick()
    {
        if (ai.teamId != 0) return;
        if (!coverFixtureReady && ai.frame >= 15*SECOND) {
            coverFixtureReady = true;
            Global::AISettings::Role = AiRole::TECH;
            Global::LolCannon::AirCrew = 50;
            Global::LolCannon::StoreCrew = 5;
            Global::LolCannon::GroundCrew = 0;
            Global::LolCannon::TurretsBeforeCannon = 0;
            site = AIFloat3(5008, 0, 4096); facing = 1;
            siteTarget = AIFloat3(8000, 0, 4096);
            blockCentre = AIFloat3(5008, 0, 4600);
            stripCentre = AIFloat3(5008, 0, 3600);
            turretPos.resize(0); storePos.resize(0);
            gunRes = aiTerrainMgr.ReserveBuilding(Gun(), site, facing);
            if (gunRes < 0) GenericHelpers::LogUtil("[CannonCoverFixture] ERROR no initial reservation", 1);
            // Invalidated reservation mirrors a consumed/erased slot on retry.
            aiTerrainMgr.ReleaseReservation(gunRes);
            Begin(false);
            GenericHelpers::LogUtil("[CannonCoverFixture] initialized stale_slot=" + gunRes, 1);
        }
        if (!coverFixtureReady) return;
        // A finished project remains isolated; no second economic cannon roll.
        if (phase == IDLE && built > 0) nextPlan = ai.frame + 60*SECOND;
        __MOVED__
        __STORES__
    }
'''
    moved = '''
        if (!coverFixtureMoved && phase == BUILD) {
            coverFixtureMoved = true;
            if (gunTask !is null && !gunTask.IsDead()) aiBuilderMgr.AbortTask(gunTask);
            @gunTask = OrderAt(Task::BuildType::BIG_GUN, Gun(), AIFloat3(5296,0,4048), -1);
            IBuilderTask@ movedTask = cast<IBuilderTask>(gunTask);
            if (movedTask !is null) movedTask.siteRadius = 128.0f;
            gunOrderedAt = ai.frame; orderFrame = ai.frame;
            GenericHelpers::LogUtil("[CannonCoverFixture] injected relocated program task 292 from anchor", 1);
        }
'''
    fixture = fixture.replace('__MOVED__', moved if args.variant == 'relocated' else '')
    stores = '''
        if (!coverFixtureStore && phase == BUILD) {
            CCircuitUnit@ g = ProjectGun();
            if (g !is null && g.GetBuildProgress() >= 1.0f) {
                coverFixtureStore = true;
                const AIFloat3 p(4800,0,3600);
                storePos.insertLast(p); storeRes.insertLast(aiTerrainMgr.ReserveBuilding(Store(), p, facing));
                storeTask.insertLast(null); storeMiss.insertLast(0); storeDead.insertLast(false);
                GenericHelpers::LogUtil("[CannonCoverFixture] pending storage added at cannon completion",1);
            }
        }
'''
    fixture = fixture.replace('__STORES__', stores if args.variant == 'stores' else '')
    source = source.replace('    void Tick()\n', fixture+'\n    void Tick()\n', 1)
    source = source.replace('        Lock();\n',
        '        CoverFixtureTick();\n        if (!coverFixtureReady || ai.teamId != 0) return;\n        Lock();\n', 1)
    path.write_text(source)
    # Freeze ordinary construction only: the real program builds its cannon and
    # its five defenses with its normal BuilderTask/ExtraWork and native tasks.
    path = staged/'script/src/manager/builder.as'
    source = path.read_text()
    pos = source.index('{', source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
    source = source[:pos]+'''\n
        if (ai.teamId == 0) {
            IUnitTask@ coverWork = LolCannon::BuilderTask(u);
            return coverWork is null ? aiBuilderMgr.Enqueue(TaskB::Wait(3*SECOND)) : coverWork;
        }
        if (ai.teamId != 0) return aiBuilderMgr.Enqueue(TaskB::Wait(3*SECOND)); // inert fixture opponent
'''+source[pos:]
    path.write_text(source)
    manifest = {'variant': args.variant, 'bonus': 100, 'profile': 'experimental_balanced',
        'dll_sha256': hashlib.sha256(args.dll.read_bytes()).hexdigest(), 'source_data': str(args.data.resolve()),
        'fixture': ['56 supplied T2 air constructors', 'four supplied AFUS and periodic resources',
            'ordinary construction and TECH economy planning held; inert opponent', 'no preliminary turret/storage slots',
            'stale initial cannon reservation', 'real cannon and cover construction by AI'],
        'source_hashes': {str(p.relative_to(args.data)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in args.data.rglob('*') if p.is_file()}}
    (directory/'cover-fixture.json').write_text(json.dumps(manifest, indent=2))
    checks = json.loads((HERE/'checks/tech/reliability/lolcannon-cover-retry.json').read_text())
    if args.variant in ('retry','stores'):
        checks['expect'].append({'key':'reservation repaired', 'pattern':r'\[LolCannon\] cannon retry reservation=\d+ at', 'by_minute':1})
    else:
        checks['expect'].append({'key':'moved frame tracked', 'pattern':r'\[LolCannon\] project cannon unit=.* 29[12] from anchor', 'by_minute':5})
    if args.variant == 'stores':
        # Existing policy explicitly permits the 300s storage finishing timeout;
        # either outcome must advance to all five completed cover structures.
        checks['expect'].append({'key':'storage phase ended', 'pattern':r'\[LolCannon\] REPORT storages [01]/1 turrets 0/0', 'by_minute':12})
    (directory/'fixture-checks.json').write_text(json.dumps(checks, indent=2))
    return cmd, directory


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dir', type=Path, required=True)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, default=ROOT/'data')
    parser.add_argument('--variant', choices=['retry','relocated','stores'], required=True)
    parser.add_argument('--minutes', type=int, default=15)
    parser.add_argument('--game', default='Beyond All Reason test-31836-b250a16')
    args = parser.parse_args()
    cmd, directory = prepare(args)
    started = time.monotonic()
    result = None
    try:
        subprocess.run(cmd+['launch','--dir',str(directory),'--engine','recoil_2026.07.04','--headless'], check=True)
        result = subprocess.run(cmd+['watch','--dir',str(directory),'--minutes',str(args.minutes),
            '--checks',str(directory/'fixture-checks.json'),'--wall-minutes','12','--play-decided'])
        return result.returncode
    finally:
        # watch owns cleanup on every normal return, including FAIL. Reattach
        # only when launch/watch itself failed, avoiding an already-exited PID.
        if result is None:
            subprocess.run(cmd+['stop','--dir',str(directory)], check=False)
        (directory/'runner-timing.json').write_text(json.dumps({'wall_seconds':time.monotonic()-started}))


if __name__ == '__main__':
    raise SystemExit(main())
