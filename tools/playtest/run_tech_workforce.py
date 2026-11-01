"""Focused TECH workforce policy check. Supplied units/economy, not a benchmark."""
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
    args = parser.parse_args()
    case = 'tech-workforce'
    probe_name = 'tech_workforce_probe'
    namespace = 'TechWorkforceProbe'
    arena = argparse.Namespace(case=case, dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=1.5, speed=20, mode='fast', headless=False)
    directory, call = ranged_arena.prepare(arena)
    source = directory/'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE/'fixtures'/f'{probe_name}.as'
    (source/'src'/f'{probe_name}.as').write_bytes(probe.read_bytes())
    profile = source/'experimental_balanced/main.as'
    profile.write_text(f'#include "../src/{probe_name}.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiUpdate()', f'{namespace}::Tick();')
    (directory/'tech-workforce-inputs.json').write_text(json.dumps({
        'probe_sha256':storage.file_hash(probe),
        'overrides':['supplied 3 constructors, 4 assist bots and 2 labs', 'frozen ordinary production', 'real role/donation callback probes'],
        'files':{str(p.relative_to(source)):storage.file_hash(p) for p in source.rglob('*.as')}
    }, indent=2))
    try:
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'],check=True)
        return subprocess.call(call+['watch','--dir',str(directory),'--role','TECH',
            '--checks',case,'--minutes','1.5','--wall-minutes','8'])
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)


if __name__ == '__main__':
    sys.exit(main())
