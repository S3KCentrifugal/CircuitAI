"""Embedded VM/index/transaction checks, with real native task callbacks."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

import playtest
import storage
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    args = parser.parse_args()
    directory = storage.allocate('shared', 'reliability', 'clyde-performance', 'supreme', 'supplied')
    print('CLYDE_REGRESSION_DIRECTORY=' + str(directory), flush=True)
    call = [sys.executable, str(playtest.HERE / 'playtest.py')]
    subprocess.run(call + ['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
        '--map', 'Supreme Isthmus v1.7', '--engine', 'recoil_2026.07.04', '--roles', 'TECH', '--role', 'TECH',
        '--side', 'armada', '--ai-option', 'profile=experimental_balanced',
        '--ai-option', 'random_seed=516', '--mode', 'fast', '--speed', '20', '--minutes', '2', '--headless'], check=True)
    scripts = directory / 'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE / 'fixtures/clyde_performance_probe.as'
    (scripts / 'src/clyde_performance_probe.as').write_bytes(probe.read_bytes())
    profile = scripts / 'experimental_balanced/main.as'
    profile.write_text('#include "../src/clyde_performance_probe.as"\n' + profile.read_text())
    inject_entry(profile, 'void AiUpdate()', 'ClydePerfProbe::Tick();')
    inject_entry(scripts / 'src/manager/builder.as', 'void AiTaskAdded(IUnitTask@ task)',
                 'if (ClydePerfProbe::OnAdded(task)) return;')
    (directory / 'fixture-inputs.json').write_text(json.dumps({
        'probe': storage.file_hash(probe),
        'scripts': {str(p.relative_to(scripts)): storage.file_hash(p) for p in scripts.rglob('*.as')},
        'overrides': ['isolated TECH', 'probe creates/cancels two radar tasks', 'nested cancellation callback']}, indent=2))
    try:
        subprocess.run(call + ['launch', '--dir', str(directory), '--engine', 'recoil_2026.07.04', '--headless'],
                       env={**os.environ, 'CIRCUIT_VERIFY_PACK_CANDIDATES': '1', 'CIRCUIT_VERIFY_EMPTY_PACK': '1'}, check=True)
        return subprocess.call(call + ['watch', '--dir', str(directory), '--role', 'TECH',
            '--checks', 'shared/reliability/clyde-performance', '--minutes', '2', '--wall-minutes', '8'])
    finally:
        subprocess.run(call + ['stop', '--dir', str(directory)], check=False)


if __name__ == '__main__':
    sys.exit(main())
