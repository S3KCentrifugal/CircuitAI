"""Supplied FRONT reservation preference; no natural opening/timing claim."""
import argparse
import re
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
    parser.add_argument('--side', choices=('armada', 'cortex', 'legion'), default='cortex')
    parser.add_argument('--role', choices=('FRONT', 'TACTICAL'), default='FRONT')
    parser.add_argument('--visual', action='store_true')
    parser.add_argument('--policy', action='store_true', help='Exercise normal FRONT work selection with supplied resources')
    args = parser.parse_args()
    domain = args.role.lower()
    directory = storage.allocate(domain, 'layout', 'factory-policy' if args.policy else 'factory-preference', 'glitters', 'supplied', seed=2071)
    print('FRONT_LAYOUT_DIRECTORY='+str(directory), flush=True)
    starts = directory/'starts.as'
    starts.write_text(f'StartSpot(AIFloat3(4000,0,2400), AiRole::{args.role}, false),\n'
                      f'StartSpot(AIFloat3(4000,0,9800), AiRole::{args.role}, false),\n')
    command = [sys.executable, str(playtest.HERE/'playtest.py')]
    subprocess.run(command+['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
        '--map', 'All That Glitters v2.2', '--map-file', str(starts), '--role', args.role, '--roles', args.role,
        '--isolated', '--side', args.side, '--ai-option', 'profile=experimental_balanced',
        '--ai-option', 'random_seed=2071', '--modoption', 'deathmode=neverend',
        '--modoption', 'startmetal=100000', '--modoption', 'startenergy=100000',
        '--modoption', 'startmetalstorage=100000', '--modoption', 'startenergystorage=100000',
        '--mode', 'visual' if args.visual else 'fast', '--speed', '20', '--minutes', '6' if args.policy else '3',
        '--shots', '2@1600@4000:2400' if args.visual else '', '--lean-render'], check=True)
    script = directory/'script.txt'
    text, count = re.subn(r'(\[GAME\]\s*\{)', r'\1\n FixedRNGSeed=2071;', script.read_text(), count=1)
    if count != 1:
        raise ValueError('Missing GAME section for fixed engine seed')
    script.write_text(text)
    checks = domain + ('/layout/factory-policy' if args.policy else '/layout/factory-district')
    source = directory/'AI/Skirmish/BARbTest/test/script/src'
    # --map-file chooses fixture coordinates; the active map registry still
    # assigns live roles. Override only this staged fixture before role setup.
    select_fixture_role(source, args.role)
    if not args.policy:
        prepare_probe(source, args.role)
    playtest.validate_checks(checks)
    try:
        subprocess.run(command+['launch', '--dir', str(directory)]+([] if args.visual else ['--headless']), check=True)
        return subprocess.call(command+['watch', '--dir', str(directory), '--role', args.role,
            '--checks', checks, '--minutes', '6' if args.policy else '3', '--wall-minutes', '6'])
    finally:
        subprocess.run(command+['stop', '--dir', str(directory)], check=False)


def select_fixture_role(source, role):
    if role not in ('FRONT', 'TACTICAL'):
        raise ValueError('Unsupported factory fixture role')
    setup = source/'setup.as'
    text = setup.read_text()
    marker = 'Global::AISettings::Role = derivedRole;'
    if text.count(marker) != 1:
        raise ValueError('Role setup marker changed')
    setup.write_text(text.replace(marker, f'derivedRole = AiRole::{role};\n\t\t' + marker))


def prepare_probe(source, role='FRONT'):
    (source/'front_layout_probe.as').write_bytes((playtest.HERE/'fixtures/front_layout_probe.as').read_bytes())
    main_script = source.parent/'experimental_balanced/main.as'
    main_script.write_text('#include "../src/front_layout_probe.as"\n'+main_script.read_text())
    if role == 'FRONT':
        inject_entry(source/'roles/front/front.as', 'void Front_EconomyUpdate()', 'if (ai.teamId >= 0) return;')
        inject_entry(source/'roles/front/front.as',
                 'string Front_SelectFactoryHandler(const AIFloat3& in pos, bool isStart, bool isReset)',
                 'if (isStart) { const string name=UnitHelpers::GetT1BotLabForSide(Global::AISettings::Side); '
                 'FrontLayout::Plan(name,Global::AISettings::Side); return name; }')
    inject_entry(source/'manager/builder.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
                 'if (ai.teamId >= 0) return FrontLayoutProbe::Make(u);')


if __name__ == '__main__':
    sys.exit(main())
