"""Natural FRONT opener: energy worker, turret worker, commander handoff."""
import argparse
import json
import re
from pathlib import Path
import subprocess
import sys
import playtest
import storage
from run_front_layout import select_fixture_role
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--side', choices=('armada', 'cortex', 'legion'), default='armada')
    parser.add_argument('--bot', action='store_true', help='Select a bot opening; retain natural resources and policy')
    args = parser.parse_args()
    directory = storage.allocate('front', 'layout', 'constructor-opener', 'glitters', 'natural', side=args.side)
    print('OPENER_DIRECTORY='+str(directory), flush=True)
    command = [sys.executable, str(playtest.HERE/'playtest.py')]
    subprocess.run(command+['stage', '--dir', str(directory), '--dll', str(args.dll),
        '--ai-option', 'random_seed=2071', '--role', 'FRONT', '--roles', 'FRONT', '--isolated',
        '--side', args.side, '--map', 'All That Glitters v2.2.3',
        '--game', 'Beyond All Reason test-31783-a096d9f', '--engine', 'recoil_2026.07.04',
        '--modoption', 'deathmode=neverend', '--headless', '--mode', 'fast', '--speed', '20',
        '--extra-widget', str(playtest.HERE/'widgets/front_opening.lua')], check=True)
    source = directory/'AI/Skirmish/BARbTest/test/script/src'
    script = directory/'script.txt'
    text, count = re.subn(r'(\[GAME\]\s*\{)', r'\1\n FixedRNGSeed=2071;', script.read_text(), count=1)
    if count != 1:
        raise ValueError('Missing GAME section for fixed engine seed')
    script.write_text(text)
    select_fixture_role(source, 'FRONT')
    if args.bot:
        inject_entry(source/'roles/front/front.as',
            'string Front_SelectFactoryHandler(const AIFloat3& in pos, bool isStart, bool isReset)',
            'if (isStart) { const string name=UnitHelpers::GetT1BotLabForSide(Global::AISettings::Side); '
            'FrontLayout::Plan(name,Global::AISettings::Side); return name; }')
    try:
        subprocess.run(command+['launch', '--dir', str(directory), '--headless',
            '--engine', 'recoil_2026.07.04'], check=True)
        result = subprocess.run(command+['watch', '--dir', str(directory), '--role', 'FRONT',
            '--checks', 'front/layout/two-constructors', '--minutes', '8', '--wall-minutes', '5', '--poll', '2'])
    finally:
        subprocess.run(command+['stop', '--dir', str(directory)], check=False)
    log = (directory/'infolog.txt').read_text(errors='replace')
    diagnostics = [line for line in log.splitlines() if any(key in line for key in
        ('FrontConstructors', 'FrontOpeningProbe', 'CommanderFront] ready', ': ERR', 'achieved'))]
    archives = sorted((directory/'runs').iterdir())
    if archives:
        (archives[-1]/'opener-diagnostics.json').write_text(json.dumps(diagnostics, indent=2))
        print('PUBLISHED='+str(storage.publish(archives[-1])), flush=True)
    subprocess.run([sys.executable, str(playtest.HERE/'prune_benchmarks.py'), '--apply', '--path', str(directory)], check=True)
    return result.returncode


if __name__ == '__main__':
    sys.exit(main())
