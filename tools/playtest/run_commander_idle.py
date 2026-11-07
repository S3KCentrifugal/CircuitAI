"""Supplied stationary commander energy-reclaim correctness check."""
import argparse
import subprocess
import sys
from pathlib import Path

import playtest
import ranged_arena
import ranged_benchmark


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--mode', choices=['fast', 'visual'], default='fast')
    args = parser.parse_args()
    arena = argparse.Namespace(case='commander-idle-reclaim', dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=3, speed=20, mode=args.mode, headless=False)
    directory, call = ranged_arena.prepare(arena)
    try:
        subprocess.run(call+['launch', '--dir', str(directory), '--engine', 'recoil_2026.07.04'], check=True)
        status = subprocess.call(call+['watch', '--dir', str(directory), '--role', 'FRONT',
            '--checks', 'commander-idle-reclaim', '--minutes', '3', '--wall-minutes', '8'])
        return status if status else (0 if ranged_benchmark.summarize(directory)['passed'] else 1)
    finally:
        subprocess.run(call+['stop', '--dir', str(directory)], check=False)


if __name__ == '__main__':
    sys.exit(main())
