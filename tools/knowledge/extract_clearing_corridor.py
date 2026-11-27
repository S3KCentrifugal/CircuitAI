"""Compile the production corridor claim raster against a narrow test adapter."""
import argparse
from pathlib import Path
from extract_reservation_lifecycle import extract


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    source = (root / 'src/circuit/terrain/FactoryCorridors.cpp').read_text()
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text('// Generated production method; do not edit.\n'
                        + extract(source, 'void CFactoryCorridors::PaintWindow(') + '\n')


if __name__ == '__main__':
    main()
