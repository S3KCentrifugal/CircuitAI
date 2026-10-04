"""Generate terrain-specific supplied-combat cases from the real map start tables.

No game or AI policy is modified. Generated files belong in a scratch directory.
"""
import argparse
import json
from pathlib import Path
import playtest

MAPS = [
    ("supreme", "Supreme Isthmus v1.7", "cortex", "armada", None),
    ("glacial", "Glacial Gap v1.1", "armada", "cortex", "corflak"),
    ("glitters", "All That Glitters v2.2.3", "legion", "armada", "armmercury"),
    ("tundra", "Tundra Continents v2.3.1", "cortex", "legion", "armflak"),
    ("caldera", "Serene Caldera v1.3", "legion", "cortex", "cormadsam"),
]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    matrix = []
    for key, name, side, defender, aa in MAPS:
        spots = playtest.map_spots(name)
        enemy = spots[len(spots)//2:]
        def site(i):
            return list(enemy[i % len(enemy)][:2])
        case = {
            "name": "committed-"+key,
            "description": "Supplied T2 bombers and committed escort versus replenished defenders; strategic targets and T1 decoys",
            "bomber_only": False,
            "aircraft": [{"unit":"$t2", "count":64, "team":0},
                         {"unit":"$fighter2", "count":32, "team":0},
                         {"unit":"$fighter2", "count":12, "team":1}],
            "targets": [{"unit":"armafus", "count":1, "position":site(0)},
                        {"unit":"armmmkr", "count":4, "position":site(1)},
                        {"unit":"armaap", "count":1, "position":site(2)},
                        {"unit":"armflash", "count":12, "position":site(3)}],
            "defenses": [] if aa is None else [{"unit":aa, "count":2, "position":site(0)}],
            "refill_seconds":90,
        }
        output = args.output/(key+".json")
        output.write_text(json.dumps(case, indent=2)+"\n")
        matrix.append(dict(key=key, map=name, side=side, defender=defender, case=str(output.resolve())))
    (args.output/"matrix.json").write_text(json.dumps(matrix, indent=2)+"\n")
    print("Generated five non-metal map cases in", args.output)


if __name__ == "__main__":
    main()
