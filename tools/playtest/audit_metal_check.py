"""Audit observer measurements independently of the AI's own policy logs.

This focused audit never replaces the playtest's invariant verdict. No resource
gifts are used. Normal-map controls must retain positive finite spot counts.
"""
import argparse
import collections
import json
import re
from pathlib import Path


def audit(path, metal):
    text = path.read_text(encoding="utf-8", errors="replace")
    teams = collections.defaultdict(list)
    for row in re.findall(r"\[MetalWatch\] sample ([^\r\n]+)", text):
        values = dict(re.findall(r"(\w+)=([\d./-]+)", row))
        for key, value in list(values.items()):
            if "/" in value:
                current, capacity = map(float, value.split("/"))
                values[key] = current
                values[key + "Capacity"] = capacity
            else:
                values[key] = float(value)
        teams[int(values["team"])].append(values)
    failures = []
    classification = re.findall(r"MetalWatch\] classification mex_count=(-?\d+)", text)
    modes = sorted(set(map(int, re.findall(r"METAL_FIELD: team=(\d+) mode=1", text))))
    if not classification or (int(classification[-1]) == -1) != metal:
        failures.append("unexpected/missing game metal classification")
    if (bool(modes) != metal) or (metal and set(modes) != set(teams)):
        failures.append("mode/observed team mismatch")
    errors = re.findall(r"[^\n]*(?:SCRIPT CRASH|: ERR  :|Exception:|Access violation|has crashed)[^\n]*", text)
    if errors:
        failures.append("runtime error (inspect retained log)")
    result = {}
    for team, samples in sorted(teams.items()):
        last = samples[-1]
        if last["frame"] < 36000:
            failures.append(f"team {team}: missing 20-minute census")
        if metal:
            if any(s["converterStarts"] or s["converters"] for s in samples):
                failures.append(f"team {team}: converter construction")
            if not any(s["mex"] >= 1 and s["labs"] >= 1 and s["frame"] <= 9000 for s in samples):
                failures.append(f"team {team}: no functioning mex/factory opening")
            if max(s["mex"] for s in samples) < 4 and max(s["mexYield"] for s in samples) < 20:
                failures.append(f"team {team}: insufficient observed extraction growth")
        checkpoints = {}
        for minute in (1, 5, 10, 15, 20, 25, 30):
            seen = [s for s in samples if s["frame"] <= minute * 1800]
            if seen:
                checkpoints[str(minute)] = seen[-1]
        full = [s for s in samples if s["frame"] >= 9000 and s["bankM"] >= .95 * s["bankMCapacity"]]
        result[str(team)] = {"checkpoints": checkpoints, "full_metal_samples_after_5m": len(full),
                             "peak_mex": max(s["mex"] for s in samples),
                             "peak_mex_yield": max(s["mexYield"] for s in samples),
                             "peak_energy": max(s["E"] for s in samples),
                             "peak_to_final_mex_loss": max(s["mex"] for s in samples) - last["mex"],
                             "first_factory_minute": next((s["frame"] / 1800 for s in samples if s["labs"]), None),
                             "first_40_mex_minute": next((s["frame"] / 1800 for s in samples if s["mex"] >= 40), None)}
        positions = [(int(x), int(z)) for x, z in re.findall(
            rf"MetalWatch\] mex-finished frame=\d+ team={team} id=\d+ x=(\d+) z=(\d+)", text)]
        positions = list(set(positions))
        # Measures the spacing of observed construction sites, not survivors.
        result[str(team)]["observed_mex_sites"] = len(positions)
        result[str(team)]["sites_with_64_elmo_neighbour"] = sum(
            any(0 < (x-a)**2 + (z-b)**2 <= 64**2 for a, b in positions) for x, z in positions)
        result[str(team)]["factory_events"] = [
            {"event": event, "minute": int(frame)/1800, "def": definition}
            for event, frame, definition in re.findall(
                rf"MetalWatch\] factory-(created|finished) frame=(\d+) team={team} def=(\w+)", text)]
        result[str(team)]["worker_assignments"] = [
            {"minute": int(frame)/1800, "slot": int(slot), "unit": int(unit)}
            for frame, slot, unit in re.findall(
                rf"AI LOG:S:\d+:T:{team}:F:(\d+):L::\[METAL\]\[Worker\] assignment=(\d) id=(\d+)", text)]
        result[str(team)]["fighter_screen_minute"] = next((int(frame)/1800 for frame in re.findall(
            rf"AI LOG:S:\d+:T:{team}:F:(\d+):L::\[METAL\]\[Transition\] initial fighter screen complete", text)), None)
    if not teams:
        failures.append("no observer samples")
    return {"log": str(path.resolve()), "metal": metal, "mode_teams": modes,
            "focused_pass": not failures, "failures": failures,
            "invariants": dict(collections.Counter(re.findall(r"\[INVARIANT\] (INV-\d+)", text))),
            "teams": result}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("log", type=Path)
    parser.add_argument("--metal", action="store_true")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    report = audit(args.log, args.metal)
    rendered = json.dumps(report, indent=2) + "\n"
    if args.output:
        args.output.write_text(rendered, encoding="utf-8")
    print(json.dumps({k: v for k, v in report.items() if k != "teams"}, indent=2))
    raise SystemExit(0 if report["focused_pass"] else 1)
