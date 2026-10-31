"""Focused TECH single-reactor and air-assistance check. Supplied units/economy, not a benchmark."""
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
    args = parser.parse_args()
    case = 'tech-layout-saturation'
    probe_name = 'tech_layout_probe'
    namespace = 'TechLayoutProbe'
    arena = argparse.Namespace(case=case, dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=3, speed=20, mode='fast', headless=False)
    directory, call = ranged_arena.prepare(arena)
    source = directory/'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE/'fixtures'/f'{probe_name}.as'
    (source/'src'/f'{probe_name}.as').write_bytes(probe.read_bytes())
    profile = source/'experimental_balanced/main.as'
    profile.write_text(f'#include "../src/{probe_name}.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiUpdate()', f'{namespace}::Tick();')
    inject_entry(source/'src/manager/builder.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.teamId==0) { IUnitTask@ retained=TechLayoutProbe::Retain(u); if (retained !is null) return retained; }')
    inject_entry(source/'src/systems/construction/frontline_engineering.as', 'void Tick(bool released)', 'if (ai.frame>=0) return; // independent energy admission fixture')
    inject_entry(source/'src/systems/diagnostics/invariants.as', 'void Tick()', 'if (ai.frame>=0) return; // supplied economy layout')
    inject_entry(source/'src/roles/tech/tech_build.as', 'void Tick()', 'if(ai.frame>=0) return; // isolated geometry fixture')
    (directory/'tech-layout-saturation-inputs.json').write_text(json.dumps({
        'probe_sha256':storage.file_hash(probe),
        'overrides':['supplied two turret layout zones and fusion funding', 'ordinary work frozen; actual packing and support construction'],
        'files':{str(p.relative_to(source)):storage.file_hash(p) for p in source.rglob('*.as')}
    }, indent=2))
    try:
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'],check=True)
        status = subprocess.call(call+['watch','--dir',str(directory),'--role','TECH',
            '--checks',case,'--minutes','3','--wall-minutes','8'])
        return status if status else (0 if ranged_benchmark.summarize(directory)['passed'] else 1)
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)


if __name__ == '__main__':
    sys.exit(main())


