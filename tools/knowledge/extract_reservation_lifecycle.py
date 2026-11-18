"""Compile real lifecycle method bodies against the small native test adapter.

This deliberately extracts the production implementations: copying their logic
into a test would miss a retry/cancellation call-site regression. The adapter
models footprint occupancy, not engine pathing or save/load integration.
"""
import argparse
from pathlib import Path


def extract(source, signature):
    start = source.index(signature)
    opening = source.index('{', start)
    # All selected definitions end at column zero. Nested blocks are indented;
    # avoid counting braces in comments/string literals as C++ syntax.
    end = source.index('\n}', opening) + 2
    return source[start:end]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    terrain = (args.source/'src/circuit/terrain/TerrainManager.cpp').read_text()
    task = (args.source/'src/circuit/task/builder/BuilderTask.cpp').read_text()
    bodies = [extract(terrain, 'void CTerrainManager::'+name+'(int id)')
              for name in ('ReleaseReservation', 'RestoreReservation', 'UnclaimReservation')]
    bodies.append(extract(task, 'void IBuilderTask::Cancel()'))
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text('// Generated from production source; do not edit.\n'+'\n\n'.join(bodies)+'\n')


if __name__ == '__main__':
    main()
