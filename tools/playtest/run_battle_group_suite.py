"""D-507: the battle group decision suite (Thugs with Aggravators, Cortex).

Each case is a supplied-force arena (ranged_arena.py) judged by
ranged_benchmark.py's assertions:

  battle-group-siege-sentries     towers the rockets outrange: every tower dies, no losses, no Thug shots
  battle-group-siege-depth        the same towers in depth: wait, advance as each falls
  battle-group-outranged-push     a Beamer outranging the rockets, a weak cluster: push, kill both, <= 1 loss
  battle-group-outranged-costly   HLT and Beamers: do not throw the group at them, <= 2 losses
  battle-group-outranged-retreat  a fortress against a small group: withdraw, <= 1 loss
  battle-group-jammer-control     an outranging wave, no jammer: the group withdraws at least once
  battle-group-jammer-hold        the same wave under our jammers: the group never withdraws
  battle-group-rush-help          D-510: 14 Pawns rush the group, Guardians 800 behind (too far): stand and fire
  battle-group-rush-lane          D-510: 16 Grunts rush the group, no help near: stand and fire
  battle-group-rush-near-help     D-510: 14 Pawns rush the group, Guardians 350 behind: kite to them
  battle-group-siege-memory       D-511: Sentries seen once, then out of sight and radar: the rockets still kill them

Usage: python tools/playtest/run_battle_group_suite.py --dll <pin>/SkirmishAI.dll --data <pin>/data [--cases ...]
Exit status is non-zero when any case fails. Prune the game folders afterwards
(tools/playtest/prune_benchmarks.py --apply --path <dir>).
"""
import argparse
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
CASES = ['battle-group-siege-sentries', 'battle-group-siege-depth', 'battle-group-outranged-push',
         'battle-group-outranged-costly', 'battle-group-outranged-retreat',
         'battle-group-jammer-control', 'battle-group-jammer-hold',
         'battle-group-rush-help', 'battle-group-rush-lane', 'battle-group-rush-near-help',  # D-510
         'battle-group-siege-memory']  # D-511


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--cases', nargs='+', default=CASES, choices=CASES)
    parser.add_argument('--minutes', type=int, default=6)
    parser.add_argument('--speed', type=int, default=20)
    args = parser.parse_args()
    command = [sys.executable, str(HERE / 'ranged_benchmark.py'), '--cases', *args.cases, '--dll', str(args.dll),
               '--data', str(args.data), '--minutes', str(args.minutes), '--speed', str(args.speed), '--headless']
    return subprocess.run(command).returncode


if __name__ == '__main__':
    sys.exit(main())
