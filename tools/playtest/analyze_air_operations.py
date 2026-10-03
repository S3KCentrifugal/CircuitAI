"""Read independent arena damage/death events and synchronized command counts.

Never infer a kill from the AI's disappearing enemy cache. Attribution here is
the observer's last damaging unit; it is not necessarily exclusive damage.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

BOMBERS = {"armthund", "corshad", "armpnix", "corhurc", "legphoenix"}
STRATEGIC = {"armafus", "corafus", "legafus", "armmmkr", "cormmkr", "legadveconv", "armaap", "coraap", "legaap"}


def analyze(path, end_frame=None):
    units, commands = {}, {}
    damage, kills, lost = Counter(), Counter(), Counter()
    launches, attacks, violations = [], [], []
    last_frame = 0
    with Path(path).open(encoding="utf-8", errors="replace") as stream:
        for line in stream:
            frame = re.search(r"\[f=\s*(\d+)\]", line)
            if frame and end_frame is not None and int(frame[1]) > end_frame:
                continue
            if frame:
                last_frame = max(last_frame, int(frame[1]))
            if "[AirArena] event=" in line:
                fields = dict(re.findall(r"(\w+)=([^\s]+)", line))
                event = fields.get("event")
                if event == "spawn":
                    units[fields["id"]] = fields["unit"]
                elif event == "damage" and fields.get("adef") in BOMBERS and fields.get("attackerTeam") == "0":
                    if fields.get("emp") == "0":
                        damage[fields["vdef"]] += float(fields["amount"])
                elif event == "death":
                    if fields.get("team") == "1" and fields.get("attackerTeam") == "0" and units.get(fields.get("attacker")) in BOMBERS:
                        kills[fields["unit"]] += 1
                    if fields.get("team") == "0" and fields.get("unit") in BOMBERS:
                        lost[fields["unit"]] += 1
                elif event == "launch":
                    launches.append(fields)
            order = re.search(r"\[AirOrders\] frame=(\d+) team=(\d+) all_apm=(\d+) air_apm=(\d+) repeated=(\d+)", line)
            if order:
                values = [int(x) for x in order.groups()]
                commands.setdefault(str(values[1]), []).append(dict(zip(("frame", "all", "air", "repeated"), (values[0], *values[2:]))))
            if "WAVE: committed attack" in line:
                attacks.append(line.split("WAVE: ", 1)[1])
            if "[INVARIANT]" in line or "[AirOrders] ERROR" in line or ": ERR " in line:
                violations.append(line)
    return {
        "log": str(Path(path).resolve()), "minutes": round(last_frame/1800, 2),
        "launches": len(launches), "attack_transitions": len(attacks),
        "bomber_damage_by_target": dict(damage), "bomber_last_hit_kills": dict(kills),
        "bomber_losses": dict(lost), "strategic_last_hit_kills": sum(kills[k] for k in STRATEGIC),
        "peak_apm": {team: max(row["air"] for row in rows) for team, rows in commands.items()},
        "command_minutes": commands, "violations": violations,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("log", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--end-frame", type=int, help="Exclude shutdown overrun after this game frame")
    args = parser.parse_args()
    result = analyze(args.log, args.end_frame)
    text = json.dumps(result, indent=2)+"\n"
    if args.output:
        args.output.write_text(text)
    print(json.dumps({k: v for k, v in result.items() if k != "command_minutes"}, indent=2))


if __name__ == "__main__":
    main()
