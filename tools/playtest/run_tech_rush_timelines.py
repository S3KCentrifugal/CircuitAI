"""Serial isolated TECH economy timelines, normal resources and no win condition.

Preserves existing rush deadlines. Fixed horizons include post-milestone behavior.
The heavy overlay uses its existing 40-minute completion check. No supplied eco.
"""
import argparse
import json
from pathlib import Path
import re
import subprocess
import sys

import playtest
import storage
from run_retirement_regression import inject_entry


OBJECTIVES = ('t2', 'fusion', 'afus', 'nuke', 'gantry', 'titan', 'heavy', 'spamrush', 't3rush', 'lrpc', 'eco', 'autoeco')

# Pin normal conditions instead of inheriting the last local lobby's cheats.
NORMAL_OPTIONS = dict(ai_incomemultiplier=1, multiplier_resourceincome=1,
    multiplier_buildpower=1, multiplier_builddistance=1, multiplier_turnrate=1,
    startmetal=1000, startenergy=1000, startmetalstorage=1000,
    startenergystorage=1000, nowasting='default')


def normal_options():
    return [arg for key, value in NORMAL_OPTIONS.items()
            for arg in ('--modoption', f'{key}={value}')]


def pin_engine_seed(text, seed):
    if seed <= 0:
        raise ValueError('Engine seed must be positive; zero randomizes it')
    if re.search(r'\bFixedRNGSeed\s*=', text, re.IGNORECASE):
        raise ValueError('Unexpected existing engine seed')
    text, count = re.subn(r'(\[GAME\]\s*\{)',
                         lambda match: match[1] + f'\n\tFixedRNGSeed={seed};', text, count=1)
    if count != 1:
        raise ValueError('Missing GAME section')
    return text


def pin_strategy(path, case):
    text = path.read_text()
    selected = {'heavy': 'Tech_T2_RUSH', 'spamrush': 'Tech_Spam_Rush',
                't3rush': 'Tech_T3_RUSH', 'nuke': 'Tech_NUKE_RUSH'}.get(case)
    for key in ('Tech_Spam_Rush', 'Tech_T3_RUSH', 'Tech_NUKE_RUSH', 'Tech_T2_RUSH'):
        value = '1.0f' if key == selected else '0.0f'
        text, count = re.subn(r'(float\s+' + key + r'\s*=\s*)[0-9.]+f',
                             lambda match: match[1] + value, text)
        if count != 1:
            raise ValueError('Missing unique strategy weight: ' + key)
    path.write_text(text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--cases', default=','.join(OBJECTIVES))
    parser.add_argument('--bonus', type=int, default=0, help='AI income bonus, percent')
    parser.add_argument('--without-cluster-coordinator', action='store_true',
                        help='paired control: disable only the new TECH economy-cluster coordinator')
    parser.add_argument('--supply-growth-air', action='store_true', help='Armada-only handover fixture: supply two T2 and one T1 air constructor at minute 20')
    parser.add_argument('--growth-check', action='store_true', help='Observe retirement-triggered economy workers without changing decisions')
    parser.add_argument('--side', choices=playtest.SIDES, default='legion')
    parser.add_argument('--map', default='Supreme Isthmus v1.7')
    parser.add_argument('--ally-spots', help='ordered 1-based allied spots; first selects the isolated TECH start')
    parser.add_argument('--with-air', action='store_true', help='include active allied AIR for neighbour-layout timing')
    parser.add_argument('--keep-going', action='store_true', help='bounded diagnostics; retains failing verdicts')
    parser.add_argument('--seed', type=int, default=431, help='positive engine and AI seed for paired game-time observations')
    args = parser.parse_args()
    if args.seed <= 0:
        parser.error('--seed must be positive')
    if args.supply_growth_air and (not args.growth_check or args.side != 'armada'):
        parser.error('--supply-growth-air requires --growth-check --side armada')
    cases = args.cases.split(',')
    if not cases or any(case not in OBJECTIVES for case in cases):
        parser.error('Unknown objective')
    if args.with_air and 'heavy' in cases:
        parser.error('--with-air cannot replace the heavy case FRONT fixture')
    if args.out.exists():
        parser.error('Use a new output path')
    args.out.parent.mkdir(parents=True, exist_ok=True)
    results = []
    call = [sys.executable, str(playtest.HERE / 'playtest.py')]
    for case in cases:
        directory = storage.allocate('tech', 'economy', 'isolated-rush-' + case, args.map, 'natural')
        plan_case = case in ('spamrush', 't3rush', 'lrpc')
        check = json.loads((playtest.HERE / 'checks/tech/economy' /
                            ('eco_growth.json' if case == 'eco' else 'heavy_rush.json' if case == 'heavy'
                             else 'rush_' + ('afus' if plan_case or case == 'autoeco' else case) + '.json')).read_text())
        if case == 'autoeco':
            check['stop_minute'] = 35  # retain the 18-minute deadline; observe late completion too
            check['expect'].append(dict(key='eco plan', pattern=r'\[TECH\]\[Plan\] eco',
                                        by_minute=0.5, scope='tech'))
        if plan_case:
            # Existing first-AFUS deadline; later plan phases are observations,
            # not invented acceptance deadlines. Report them through minute 35.
            check['stop_minute'] = 35
            check['forbid'] = [row for row in check['forbid'] if row['key'] != 'combat early']
            check['expect'].append(dict(key='plan', pattern=r'\[TECH\]\[Plan\] ' + case,
                                        by_minute=1, scope='tech'))
        if case == 'heavy':
            check['expect'] = [row for row in check['expect'] if row['key'] != 'strategy masks']
        if case != 'eco':
            check['_doc'] = 'Isolated TECH: original milestone deadlines, full observation horizon, no game victory condition.'
        # No enemy destination is a fixture precondition, not a tactical fault.
        # Retain every other invariant and the original strict failed run.
        for rule in check['forbid']:
            if rule['key'] == 'invariant':
                rule['pattern'] = r'\[INVARIANT\] (?!INV-063\b)'
        if args.growth_check:
            for label in ('activated after accepted reclaim', 'three distinct economy workers',
                          'turret worker constructs', 'AFUS worker constructs', 'converter worker constructs',
                          'air replaces both T2 economy workers', 'AFUS completed after air handover'):
                check['expect'].append(dict(key=label, pattern=r'\[GrowthTest\] PASS '+label,
                                            by_minute=check['stop_minute'], scope='any'))
            check['forbid'].append(dict(key='growth ownership', pattern=r'\[GrowthTest\] FAIL', scope='any'))
        horizon = check['stop_minute']
        check.pop('pass_on', None)  # retain the complete post-milestone window
        check_path = directory / 'timeline-checks.json'
        check_path.write_text(json.dumps(check, indent=2))
        launcher = directory / 'launcher.md'  # retained by the benchmark pruner
        print('TECH_TIMELINE_DIRECTORY=' + str(directory), flush=True)
        exit_code = 1
        try:
            with launcher.open('w', encoding='utf-8') as output:
                stage = call + ['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
                    '--map', args.map, '--role', 'TECH', '--roles', 'TECH,FRONT' if case == 'heavy' else 'TECH,AIR' if args.with_air else 'TECH', '--side', args.side,
                    '--isolated', '--mode', 'fast', '--headless', '--speed', '20', '--bonus', str(args.bonus),
                    '--minutes', str(horizon), '--ai-option', 'profile=experimental_balanced',
                    '--ai-option', f'random_seed={args.seed}',
                    '--set', 'RushObjective="' + ('auto' if case in ('heavy', 'autoeco') else 'afus' if plan_case else case) + '"',
                    '--set', 'EndgamePlan="' + (case if plan_case or case == 'nuke' else 'eco') + '"', '--extra-widget', str(playtest.HERE / 'widgets/unit_census.lua')]
                if args.supply_growth_air:
                    stage += ['--extra-widget', str(playtest.HERE/'widgets/tech_growth_supply.lua')]
                if case == 'heavy':
                    stage.append('--isolated-allies')
                if args.with_air:
                    stage += ['--isolated-allies', '--others', 'test']
                stage += normal_options()
                if args.without_cluster_coordinator:
                    stage += ['--set', 'ClusterEconomyEnabled=false']
                if args.ally_spots:
                    stage += ['--ally-spots', args.ally_spots]
                subprocess.run(stage, stdout=output, stderr=subprocess.STDOUT, check=True)
                profile = directory / 'AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as'
                pin_strategy(profile, case)
                if args.growth_check:
                    probe=profile.parent.parent/'src/tech_growth_probe.as'
                    probe.write_text((playtest.HERE/'fixtures/tech_growth_probe.as').read_text())
                    profile.write_text('#include "../src/tech_growth_probe.as"\n'+profile.read_text())
                    inject_entry(profile,'void AiUpdate()','GrowthProbe::Tick();')
                    (directory/'growth-fixture.json').write_text(json.dumps(dict(bonus=args.bonus,
                        supplied_air_at_minute=20 if args.supply_growth_air else None,
                        overrides='Only supplied replacements; ordinary economy and construction policy remain active'),indent=2))
                setup = directory / 'script.txt'
                setup.write_text(pin_engine_seed(setup.read_text(), args.seed))
                subprocess.run(call + ['launch', '--dir', str(directory), '--headless'],
                               stdout=output, stderr=subprocess.STDOUT, check=True)
                watch = call + ['watch', '--dir', str(directory), '--role', 'TECH', '--play-decided',
                    '--minutes', str(horizon), '--wall-minutes', '15', '--checks', str(check_path)]
                if args.keep_going:
                    watch.append('--keep-going')
                exit_code = subprocess.run(watch, stdout=output, stderr=subprocess.STDOUT).returncode
        finally:
            subprocess.run(call + ['stop', '--dir', str(directory)], stdout=subprocess.DEVNULL, check=True)
        matches = re.findall(r'\[playtest\] report: (.+)', launcher.read_text())
        archive = Path(matches[-1].strip()).parent if matches else None
        result = json.loads((archive / 'result.json').read_text()) if archive and (archive / 'result.json').exists() else None
        if archive and (archive / 'infolog.txt').exists():
            log = (archive / 'infolog.txt').read_text(errors='replace')
            # Preserve exact completion times and bounded census/economy samples
            # before pruning raw logs; no player text is retained here.
            measurements = [line for line in log.splitlines() if any(token in line for token in
                ('[Playtest] finished ', '[Playtest] eco team 0', '[Census]', '[INVARIANT]', '[TECH][Chain]',
                 '[TECH][Plan]', '[TECH][Growth]', '[GrowthTest]', '[TECH][Bootstrap]', '[GrowthState]', '[TECH][HeavyRush]', '[TECH][ProjectBlocked]', '[Layout]', '[Rule]',
                 'RESERVE: packed ', 'RESERVE: planned ', 'SLOW:', 'Cheat', 'cheat', 'Invalid', 'Unknown', 'armaca'))]
            (archive / 'timeline-measurements.json').write_text(json.dumps(measurements, indent=2))
            # Keep the bounded construction tail too: a reactor can be blocked
            # by an earlier generator or reservation, not just its own task.
            project_diagnostics = [line for line in log.splitlines()
                                   if 'EXP:' in line or 'RESERVE:' in line]
            (archive / 'reactor-task-diagnostics.json').write_text(json.dumps(
                dict(total=len(project_diagnostics), first=project_diagnostics[:200],
                     last=project_diagnostics[-200:]), indent=2))
        row = dict(case=case, directory=str(directory), exit_code=exit_code, result=result)
        results.append(row)
        args.out.write_text(json.dumps(results, indent=2))
        print(json.dumps(dict(case=case, exit_code=exit_code, archive=str(archive),
            verdict=result.get('verdict') if result else None, reason=result.get('reason') if result else None)), flush=True)
        if archive:
            storage.publish(archive)
            subprocess.run([sys.executable, str(playtest.HERE / 'prune_benchmarks.py'),
                            '--apply', '--path', str(directory)], check=True)
        if exit_code and not args.keep_going:
            break
    return int(any(row['exit_code'] for row in results) or len(results) != len(cases))


if __name__ == '__main__':
    raise SystemExit(main())
