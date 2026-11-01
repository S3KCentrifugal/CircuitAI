"""Natural TECH layout openings and optional growth screenshots across maps.

Normal-resource games retain the two-minute opening assertions. Longer visual
windows publish screenshots before pruning, without converting invariant
failures into passes.
"""
import argparse
import json
from pathlib import Path
import re
import subprocess
import sys

import playtest
import storage
from run_tech_rush_timelines import normal_options, pin_strategy
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--maps', nargs='+', default=['Supreme Isthmus v1.7'])
    parser.add_argument('--ally-spots', help='1-based allied start spots, e.g. 9,10,11,12,13,14,15,16')
    parser.add_argument('--sides', nargs='+', choices=playtest.SIDES, default=['legion'])
    parser.add_argument('--with-air', action='store_true', help='retain allied AIR roles to exercise shared layout admission')
    parser.add_argument('--terrain-check', action='store_true', help='one-shot engine buildability audit of unclaimed startup slots')
    parser.add_argument('--mode', choices=['fast', 'visual'], default='fast')
    parser.add_argument('--minutes', type=float, default=2)
    parser.add_argument('--objective', choices=['auto', 'afus'], default='auto',
                        help='afus selects the existing AFUS opening and eco endgame for growth observations')
    parser.add_argument('--keep-going', action='store_true', help='retain failures while collecting bounded visual evidence')
    args = parser.parse_args()
    if args.out.exists():
        parser.error('Use a new output path')
    if args.minutes < 2:
        parser.error('--minutes must preserve the two-minute opening check')
    args.out.parent.mkdir(parents=True, exist_ok=True)
    call = [sys.executable, str(playtest.HERE / 'playtest.py')]
    results = []
    for name in args.maps:
        for side in args.sides:
            directory = storage.allocate('tech', 'economy', 'dynamic-layout-' + side, name, 'natural')
            launcher = directory / 'launcher.md'
            print('LAYOUT_DIRECTORY=' + str(directory), flush=True)
            code = 1
            try:
                with launcher.open('w', encoding='utf-8') as output:
                    subprocess.run(call + ['stage', '--dir', str(directory), '--dll', str(args.dll),
                        '--data', str(args.data), '--map', name, '--role', 'TECH', '--roles', 'TECH,AIR' if args.with_air else 'TECH',
                        '--side', side, '--isolated', '--mode', args.mode, '--speed', '20',
                        '--bonus', '0', '--minutes', str(args.minutes), '--ai-option', 'profile=experimental_balanced']
                        + (['--headless'] if args.mode == 'fast' else ['--shots', f'{args.minutes - .25}@1800',
                            '--extra-widget', str(playtest.HERE.parent / 'widgets/gui_barb_team_link.lua'),
                            '--extra-widget', str(playtest.HERE / 'widgets/layout_evidence.lua')])
                        + normal_options() + (['--isolated-allies', '--others', 'test'] if args.with_air else [])
                        + (['--set', 'RushObjective="afus"', '--set', 'EndgamePlan="eco"']
                           if args.objective == 'afus' else [])
                        + (['--ally-spots', args.ally_spots] if args.ally_spots else []),
                        stdout=output, stderr=subprocess.STDOUT, check=True)
                    if args.objective == 'afus':
                        pin_strategy(directory / 'AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as', 'afus')
                    checks = playtest.HERE / 'checks/tech/economy/dynamic-layout.json'
                    if args.terrain_check:
                        profile = directory / 'AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as'
                        probe = profile.parent.parent / 'src/layout_terrain_probe.as'
                        probe.write_text((playtest.HERE / 'fixtures/layout_terrain_probe.as').read_text())
                        profile.write_text('#include "../src/layout_terrain_probe.as"\n' + profile.read_text())
                        inject_entry(profile, 'void AiUpdate()', 'LayoutTerrainProbe::Tick();')
                        check = json.loads(checks.read_text())
                        check['expect'].append(dict(key='terrain admission', pattern=r'\[LayoutTerrain\] PASS',
                                                    by_minute=.5, scope='any'))
                        check['forbid'].append(dict(key='invalid startup slot', pattern=r'\[LayoutTerrain\] FAIL', scope='any'))
                        checks = directory / 'terrain-checks.json'
                        checks.write_text(json.dumps(check, indent=2))
                    subprocess.run(call + ['launch', '--dir', str(directory)] + (['--headless'] if args.mode == 'fast' else []),
                        stdout=output, stderr=subprocess.STDOUT, check=True)
                    code = subprocess.call(call + ['watch', '--dir', str(directory), '--role', 'TECH',
                        '--play-decided', '--minutes', str(args.minutes), '--wall-minutes', '15', '--checks',
                        str(checks)]
                        + (['--keep-going'] if args.keep_going else []),
                        stdout=output, stderr=subprocess.STDOUT)
            finally:
                subprocess.run(call + ['stop', '--dir', str(directory)], check=True, stdout=subprocess.DEVNULL)
            reports = re.findall(r'\[playtest\] report: (.+)', launcher.read_text())
            archive = Path(reports[-1].strip()).parent if reports else None
            result = json.loads((archive / 'result.json').read_text()) if archive else None
            screenshots = []
            if archive:
                lines = (archive / 'infolog.txt').read_text(errors='replace').splitlines()
                (archive / 'layout-measurements.json').write_text(json.dumps([line for line in lines
                    if any(token in line for token in ('[Layout]', '[LayoutTerrain]', 'RESERVE:', '[INVARIANT]', 'SLOW:',
                        '[Playtest] finished', '[Playtest] eco', '[TECH][Air]', '[TECH][Plan]',
                        '[TECH][Share]', '[Rule]'))], indent=2))
                shots = [p.name for p in archive.glob('*.png') if p.stat().st_size > 1000]
                published = storage.publish(archive, screenshots=shots)
                screenshots = [str(published / shot) for shot in shots]
            if args.mode == 'visual' and not screenshots:
                code = 1
            row = dict(map=name, side=side, objective=args.objective, exit_code=code, result=result, screenshots=screenshots)
            results.append(row)
            args.out.write_text(json.dumps(results, indent=2))
            print(json.dumps(dict(map=name, side=side, exit_code=code, verdict=result.get('verdict') if result else None)), flush=True)
            subprocess.run([sys.executable, str(playtest.HERE / 'prune_benchmarks.py'),
                '--apply', '--path', str(directory)], check=True)
            if code and not args.keep_going:
                return code
    return int(any(row['exit_code'] for row in results))


if __name__ == '__main__':
    raise SystemExit(main())
