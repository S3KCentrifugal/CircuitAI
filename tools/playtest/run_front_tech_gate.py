"""Focused FRONT delivery-plan admission check. Supplied economy, not a benchmark."""
import argparse
import json
import subprocess
import sys
from pathlib import Path

import playtest
import ranged_arena
import storage
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--energy', action='store_true', help='Run the FRONT fusion/AFUS admission case')
    args = parser.parse_args()
    case = 'front-energy-gate' if args.energy else 'front-tech-gate'
    probe_name = 'front_energy_probe' if args.energy else 'front_tech_gate_probe'
    namespace = 'FrontEnergyProbe' if args.energy else 'FrontTechGateProbe'
    arena = argparse.Namespace(case=case, dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=2, speed=20, mode='fast', headless=False)
    directory, call = ranged_arena.prepare(arena)
    source = directory/'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE/'fixtures'/f'{probe_name}.as'
    (source/'src'/f'{probe_name}.as').write_bytes(probe.read_bytes())
    profile = source/'experimental_balanced/main.as'
    profile.write_text(f'#include "../src/{probe_name}.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiUpdate()', f'{namespace}::Tick();')
    (directory/'front-tech-gate-inputs.json').write_text(json.dumps({
        'probe_sha256':storage.file_hash(probe),
        'overrides':(['supplied T2 worker and sliding-minimum income snapshots', 'frozen ordinary production',
                      'role/map cap and explicit fusion admission probes'] if args.energy else
                     ['supplied TECH roster entry', 'sliding-minimum income snapshots',
                     'requester cache reset tests persistent plan', 'frozen ordinary production']),
        'files':{str(p.relative_to(source)):storage.file_hash(p) for p in source.rglob('*.as')}
    }, indent=2))
    try:
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'],check=True)
        return subprocess.call(call+['watch','--dir',str(directory),'--role','FRONT',
            '--checks',case,'--minutes','2','--wall-minutes','8'])
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)


if __name__ == '__main__':
    sys.exit(main())
