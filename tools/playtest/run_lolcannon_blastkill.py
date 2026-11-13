"""Likely-killed lolcannon targets, headless fixture (owner 2026-11-12).

Team 0: SMRTBARb TECH (Armada), every builder held on Wait (no radar); the
observer gives it a finished Ragnarok 600 from its start (west spot of --map,
Proving Grounds by default; Full Metal Plate cannot be dug) and, only at frame 600,
the energy to fire it. Team 1: inert SMRTBARb TECH; the observer gives it, about
5,000-5,600 elmos from the gun: A, an advanced fusion with a fusion (330 away)
and an LLT (200 away) beside it; B, a second advanced fusion; D, an LLT.
Perimeter cameras of team 0 show them until frame 450, so the gun's task reads
their ground; at 510 the observer destroys A with no attacker. A's image goes
(its wreck is seen) but its blast kills its neighbours out of sight, and their
images stay. Pass: A's neighbours are marked likely killed after 510 (over A's
crater, or their own), B (shelled out of sight until the gun kills it) and D
never. At 20 min cameras show every spot again (dead images are removed).
widgets/lolcannon_blastkill_fixture.lua; --blast-off is the control.
"""
import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def prepare(args):
    directory = args.dir.resolve()
    directory.mkdir(parents=True, exist_ok=True)
    sys.path.insert(0, str(HERE))
    from playtest import map_spots
    spots = map_spots(args.map)
    west, east = min(spots, key=lambda p: p[0]), max(spots, key=lambda p: p[0])
    starts = directory / 'fixture-starts.as'
    starts.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                      f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false),\n')
    widget = directory / 'lolcannon_blastkill_fixture.lua'
    src = (HERE/'widgets/lolcannon_blastkill_fixture.lua').read_text()
    assert src.count('local START0, START1 = nil, nil') == 1
    widget.write_text(src.replace('local START0, START1 = nil, nil',
        f'local START0, START1 = {{{west[0]},{west[1]}}}, {{{east[0]},{east[1]}}}'))
    cmd = [sys.executable, str(HERE/'playtest.py')]
    subprocess.run(cmd + ['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
        '--engine', 'recoil_2026.07.04', '--game', args.game, '--map', args.map, '--map-file', str(starts),
        '--role', 'TECH', '--roles', 'TECH', '--side', 'armada', '--others', 'none', '--bonus', '0',
        '--modoption', 'experimentalextraunits=1', '--modoption', 'allowunitcontrolwidgets=1',
        '--modoption', 'allowuserwidgets=1', '--speed', '20', '--minutes', str(args.minutes), '--headless',
        '--ai-option', 'profile=experimental_balanced', '--extra-widget', str(widget)], check=True)
    staged = directory/'AI/Skirmish/BARbTest/test'
    setup = staged/'script/src/setup.as'
    s = setup.read_text()
    assert s.count('Global::AISettings::Role = derivedRole;') == 1
    setup.write_text(s.replace('Global::AISettings::Role = derivedRole;',
        'derivedRole = AiRole::TECH; Global::AISettings::Role = derivedRole; // isolated blast-kill fixture'))
    role = staged/'script/src/roles/tech/tech.as'
    s = role.read_text()
    assert s.count('void Tech_EconomyUpdate()\n\t{') == 1
    role.write_text(s.replace('void Tech_EconomyUpdate()\n\t{',
        'void Tech_EconomyUpdate()\n\t{\n        if (ai.teamId >= 0) return; // blast-kill fixture: no economy planning'))
    path = staged/'script/src/manager/builder.as'
    source = path.read_text()
    pos = source.index('{', source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
    source = source[:pos]+'\n        if (ai.teamId >= 0) return aiBuilderMgr.Enqueue(TaskB::Wait(3*SECOND)); // blast-kill fixture: builders held (no radar)\n'+source[pos:]
    path.write_text(source)
    if args.blast_off:
        path = staged/'script/src/settings/shared/lolcannon.as'
        s = path.read_text()
        assert s.count('float BlastMinRadius = 200.0f;') == 1
        path.write_text(s.replace('float BlastMinRadius = 200.0f;', 'float BlastMinRadius = 0.0f; // control: off'))
    manifest = {'blast_off': args.blast_off, 'dll_sha256': hashlib.sha256(args.dll.read_bytes()).hexdigest(),
        'source_data': str(args.data.resolve())}
    (directory/'blastkill-fixture.json').write_text(json.dumps(manifest, indent=2))
    checks = {
        'stop_minute': args.minutes,
        'expect': [
            {'key': 'loaded', 'pattern': r'\[BlastKillTest\] loaded', 'scope': 'any', 'by_minute': 1},
            {'key': 'gun', 'pattern': r'\[LolCannon\] armvulc \d+ fires at', 'scope': 'any', 'by_minute': 2},
            {'key': 'fired', 'pattern': r'TIER: team=0 .*armvulc.*tier 1 armafus', 'scope': 'any', 'by_minute': 4},
        ],
        'forbid': [
            {'key': 'scripts', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'},
        ],
    }
    if not args.blast_off:
        checks['expect'].append({'key': 'marked', 'pattern': r'TIER: team=0 .* likely killed', 'scope': 'any', 'by_minute': args.minutes})
    (directory/'fixture-checks.json').write_text(json.dumps(checks, indent=2))
    return cmd, directory


def analyse(directory):
    """The AI's marks against the fixture: A (destroyed with no attacker at the
    logged frame) and its neighbours must be marked after that frame; B (live,
    shelled until our gun kills it) and D (live) never."""
    log = None
    for p in directory.rglob('infolog.txt'):
        log = p
    if log is None:
        return {'error': 'no infolog'}
    text = log.read_text(errors='replace')
    roles = {int(m.group(2)): m.group(1) for m in re.finditer(r'\[BlastKillTest\] target (\w+) unit=(\d+)', text)}
    m = re.search(r'\[BlastKillTest\] destroyed A unit=\d+ frame=(\d+)', text)
    killed_at = int(m.group(1)) if m else None
    expected_dead = {'Afus', 'Allt'}
    marks = []
    for m in re.finditer(r'TIER: team=0 frame=(\d+) \S+: (\w+)\((\d+)\) at \(\S+\) likely killed(:| with it)', text):
        frame, name, uid = int(m.group(1)), m.group(2), int(m.group(3))
        role = roles.get(uid, '?')
        ok = role in expected_dead and killed_at is not None and frame >= killed_at
        marks.append({'unit': uid, 'role': role, 'def': name, 'frame': frame,
            'how': 'ground' if m.group(4) == ':' else 'neighbour', 'verdict': 'ok' if ok else 'FALSE'})
    marked = {x['role'] for x in marks}
    seen_empty = re.findall(r'ENEMY: ghost (\w+) (\d+) seen empty, removed', text)
    targets = [{'frame': int(f), 'tier': int(t), 'def': d, 'unit': int(u), 'role': roles.get(int(u), '?')}
        for f, t, d, u in re.findall(r'TIER: team=0 frame=(\d+) armvulc\(\d+\): tier (\d+) (\w+)\((\d+)\)', text)]
    result = {'roles': {str(k): v for k, v in roles.items()}, 'killed_A_frame': killed_at, 'marks': marks,
        'missed': sorted(expected_dead - marked), 'false_marks': sum(1 for x in marks if x['verdict'] != 'ok'),
        'seen_again': re.findall(r'TIER: team=0 .* seen again .*', text),
        'seen_empty': [{'def': d, 'unit': int(u), 'role': roles.get(int(u), '?')} for d, u in seen_empty],
        'targets': targets}
    result['verdict'] = 'PASS' if (not result['missed'] and result['false_marks'] == 0) else 'FAIL'
    (directory/'blastkill-result.json').write_text(json.dumps(result, indent=2))
    return result

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dir', type=Path, required=True)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, default=ROOT/'data')
    parser.add_argument('--minutes', type=int, default=22)
    parser.add_argument('--map', default='Proving Grounds v1.0', help='deformable; west and east AI spots 6,600+ apart')
    parser.add_argument('--blast-off', action='store_true', help='control: BlastMinRadius 0')
    parser.add_argument('--game', default='Beyond All Reason test-31836-b250a16')
    parser.add_argument('--analyse-only', action='store_true')
    args = parser.parse_args()
    if args.analyse_only:
        print(json.dumps(analyse(args.dir.resolve()), indent=2))
        return 0
    cmd, directory = prepare(args)
    started = time.monotonic()
    result = None
    try:
        subprocess.run(cmd+['launch', '--dir', str(directory), '--engine', 'recoil_2026.07.04', '--headless'], check=True)
        result = subprocess.run(cmd+['watch', '--dir', str(directory), '--minutes', str(args.minutes),
            '--checks', str(directory/'fixture-checks.json'), '--wall-minutes', '15', '--play-decided'])
        return result.returncode
    finally:
        if result is None:
            subprocess.run(cmd+['stop', '--dir', str(directory)], check=False)
        (directory/'runner-timing.json').write_text(json.dumps({'wall_seconds': time.monotonic()-started}))
        print(json.dumps(analyse(directory), indent=2))


if __name__ == '__main__':
    raise SystemExit(main())
