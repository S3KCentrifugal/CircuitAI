"""Frontline Engineering group correctness check. Supplied units/economy, not a benchmark."""
import argparse
import json
import subprocess
import sys
from pathlib import Path

import playtest
import ranged_arena
import ranged_benchmark
import storage
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--maintenance', action='store_true', help='Repair and finish-before-relocation scenario')
    parser.add_argument('--expanded', action='store_true', help='Twitchers, Fiends and workforce replacement')
    args = parser.parse_args()
    case = 'frontline-engineers' if args.expanded else 'frontline-maintenance' if args.maintenance else 'frontline-engineering'
    probe_name = 'frontline_maintenance_probe' if args.maintenance else 'frontline_engineering_probe'
    namespace = 'MaintenanceProbe' if args.maintenance else 'EngineeringProbe'
    minutes=10.2 if args.expanded else 7.2
    arena = argparse.Namespace(case=case, dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=minutes, speed=20, mode='fast', headless=False)
    directory, call = ranged_arena.prepare(arena)
    source = directory/'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE/'fixtures'/f'{probe_name}.as'
    (source/'src'/f'{probe_name}.as').write_bytes(probe.read_bytes())
    profile = source/'experimental_balanced/main.as'
    profile.write_text(f'#include "../src/{probe_name}.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiUpdate()', f'{namespace}::Tick();')
    inject_entry(source/'src/manager/builder.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.teamId==0 && FrontlineEngineering::active && FrontlineEngineering::Eligible(u)) return TechRules::Evaluate(u);')
    if args.expanded:
        inject_entry(source/'src/manager/factory.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
            'if (ai.teamId==0 && UnitHelpers::IsT2BotLab(u.circuitDef.GetName())) { IUnitTask@ t=EngineeringReplacements::Recruit(u); return t is null?aiFactoryMgr.Enqueue(TaskS::Wait(false,SECOND)):t; }')
    invariants = source/'src/systems/diagnostics/invariants.as'
    inject_entry(invariants, 'void Tick()', 'if (ai.frame>=0) return; // supplied, frozen base economy only')
    (directory/'frontline-engineering-inputs.json').write_text(json.dumps({
        'probe_sha256':storage.file_hash(probe),
        'overrides':['supplied normalized lane summaries, three bots and two air constructors', 'supplied fusion income, relaxed T2 defense income gates', 'frozen ordinary production, real travel and construction', 'enemy tank observed by a supplied radar outside weapon range', 'base economy invariant Tick disabled for supplied layout; lifecycle assertions retained'],
        'files':{str(p.relative_to(source)):storage.file_hash(p) for p in source.rglob('*.as')}
    }, indent=2))
    try:
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'],check=True)
        status = subprocess.call(call+['watch','--dir',str(directory),'--role','TECH',
            '--checks',case,'--minutes',str(minutes),'--wall-minutes','8'])
        if status != 0:
            return status
        return 0 if ranged_benchmark.summarize(directory)['passed'] else 1
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)


if __name__ == '__main__':
    sys.exit(main())
