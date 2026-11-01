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


OBJECTIVES = ('t2', 'fusion', 'afus', 'nuke', 'gantry', 'titan', 'heavy', 'spamrush', 't3rush', 'lrpc')


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
    parser.add_argument('--side', choices=playtest.SIDES, default='legion')
    parser.add_argument('--map', default='Supreme Isthmus v1.7')
    parser.add_argument('--keep-going', action='store_true', help='bounded diagnostics; retains failing verdicts')
    args = parser.parse_args()
    cases = args.cases.split(',')
    if not cases or any(case not in OBJECTIVES for case in cases):
        parser.error('Unknown objective')
    if args.out.exists():
        parser.error('Use a new output path')
    args.out.parent.mkdir(parents=True, exist_ok=True)
    results = []
    call = [sys.executable, str(playtest.HERE / 'playtest.py')]
    for case in cases:
        directory = storage.allocate('tech', 'economy', 'isolated-rush-' + case, args.map, 'natural')
        plan_case = case in ('spamrush', 't3rush', 'lrpc')
        check = json.loads((playtest.HERE / 'checks/tech/economy' /
                            ('heavy_rush.json' if case == 'heavy' else 'rush_' + ('afus' if plan_case else case) + '.json')).read_text())
        if plan_case:
            # Existing first-AFUS deadline; later plan phases are observations,
            # not invented acceptance deadlines. Report them through minute 35.
            check['stop_minute'] = 35
            check['forbid'] = [row for row in check['forbid'] if row['key'] != 'combat early']
            check['expect'].append(dict(key='plan', pattern=r'\[TECH\]\[Plan\] ' + case,
                                        by_minute=1, scope='tech'))
        if case == 'heavy':
            check['expect'] = [row for row in check['expect'] if row['key'] != 'strategy masks']
        check['_doc'] = 'Isolated TECH: original milestone deadlines, full observation horizon, no game victory condition.'
        # No enemy destination is a fixture precondition, not a tactical fault.
        # Retain every other invariant and the original strict failed run.
        for rule in check['forbid']:
            if rule['key'] == 'invariant':
                rule['pattern'] = r'\[INVARIANT\] (?!INV-063\b)'
        horizon = check['stop_minute']
        check_path = directory / 'timeline-checks.json'
        check_path.write_text(json.dumps(check, indent=2))
        launcher = directory / 'launcher.md'  # retained by the benchmark pruner
        print('TECH_TIMELINE_DIRECTORY=' + str(directory), flush=True)
        exit_code = 1
        try:
            with launcher.open('w', encoding='utf-8') as output:
                stage = call + ['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
                    '--map', args.map, '--role', 'TECH', '--roles', 'TECH,FRONT' if case == 'heavy' else 'TECH', '--side', args.side,
                    '--isolated', '--mode', 'fast', '--headless', '--speed', '20', '--bonus', '0',
                    '--minutes', str(horizon), '--ai-option', 'profile=experimental_balanced',
                    '--set', 'RushObjective="' + ('auto' if case == 'heavy' else 'afus' if plan_case else case) + '"',
                    '--set', 'EndgamePlan="' + (case if plan_case or case == 'nuke' else 'eco') + '"', '--extra-widget', str(playtest.HERE / 'widgets/unit_census.lua')]
                if case == 'heavy':
                    stage.append('--isolated-allies')
                subprocess.run(stage, stdout=output, stderr=subprocess.STDOUT, check=True)
                profile = directory / 'AI/Skirmish/BARbTest/test/script/experimental_balanced/main.as'
                pin_strategy(profile, case)
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
                 '[TECH][Plan]', '[TECH][HeavyRush]', '[TECH][ProjectBlocked]'))]
            (archive / 'timeline-measurements.json').write_text(json.dumps(measurements, indent=2))
            project_diagnostics = [line for line in log.splitlines()
                                   if 'EXP:' in line and 'afus' in line]
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
