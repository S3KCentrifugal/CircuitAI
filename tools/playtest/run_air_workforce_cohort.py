"""Run matched natural workforce cohorts using immutable data snapshots."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path
import shutil
import subprocess
import sys
import storage
import playtest


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dll', type=Path, required=True)
    p.add_argument('--baseline', type=Path, required=True)
    p.add_argument('--revised', type=Path, default=playtest.REPO/'data')
    p.add_argument('--jobs', type=int, default=2, choices=[1, 2, 3])
    p.add_argument('--minutes', type=int, default=30)
    a = p.parse_args()
    root = storage.allocate('air', 'economy', 'workforce-paired', 'cohort', 'natural')
    for name, source in [('baseline', a.baseline), ('revised', a.revised)]:
        shutil.copytree(source, root/name)
    shutil.copy2(a.dll, root/'SkirmishAI.dll')
    jobs = []
    for seed, side in [(1811001, 'armada'), (1811002, 'cortex'), (1811003, 'legion')]:
        for revision in ['baseline', 'revised']:
            out = storage.allocate('air', 'economy', f'wf-{revision}-{seed}', 'cohort', 'natural')
            jobs.append(dict(seed=seed, side=side, revision=revision, directory=str(out)))
    storage.write_json(root/'cohort.json', {'minutes': a.minutes, 'concurrent_games': a.jobs,
        'timing_note': 'Concurrent correctness/economy runs; wall time is not a performance benchmark.', 'jobs': jobs})
    print(root, flush=True)

    def run(job):
        out = Path(job['directory'])
        command = [sys.executable, str(playtest.HERE/'run_air_natural.py'), '--dir', str(out),
            '--dll', str(root/'SkirmishAI.dll'), '--data', str(root/job['revision']),
            '--seed', str(job['seed']), '--side', job['side'], '--minutes', str(a.minutes),
            '--speed', '30', '--wall-minutes', '45']
        with (out/'cohort-runner.log').open('w', encoding='utf-8') as log:
            exitcode = subprocess.call(command, stdout=log, stderr=subprocess.STDOUT)
        result = dict(job, exit=exitcode)
        storage.write_json(out/'cohort-result.json', result)
        print(json.dumps(result), flush=True)
        return result

    with ThreadPoolExecutor(max_workers=a.jobs) as pool:
        results = list(pool.map(run, jobs))
    storage.write_json(root/'results.json', results)
    return any(row['exit'] for row in results)


if __name__ == '__main__':
    raise SystemExit(main())
