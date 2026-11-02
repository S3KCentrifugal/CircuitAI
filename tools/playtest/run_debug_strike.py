"""Debug strikes headless test (owner 2026-10-31, branch debug-widget-test).

Team 0: SMRTBARb TECH (Armada), the striker. A test-only data copy pins its
roll to the nuke rush, lowers the lolcannon gates and adds scout planes.
Team 1: SMRTBARb TECH (Armada) on its own data copy, the eco target: no rush,
no silo, no cannon, so it builds the TECH economy (fusions, advanced fusions,
converters, geothermals). Team 2: the host, a real player on its own ally
team. widgets/debug_strike_fixture.lua sends the team link widget's debug
commands to team 0 (nuke pos, lol pos, nuke player, lol player, nuke team,
lol team), follows every silo and cannon projectile and prints one
`[DebugTest] RESULT` line per strike. The default policy is unchanged: only the
staged copies are edited.
"""
import argparse
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

STRIKER_MAIN = [
    ('float Tech_NUKE_RUSH = 0.25f;', 'float Tech_NUKE_RUSH = 1.0f;'),
    ('float Tech_T3_RUSH = 0.35f;', 'float Tech_T3_RUSH = 0.0f;'),
    ('float Tech_T2_RUSH = 0.25f;', 'float Tech_T2_RUSH = 0.0f;'),
    ('float Tech_CAPITAL_RUSH = 0.10f;', 'float Tech_CAPITAL_RUSH = 0.0f;'),
    ('float Tech_Spam_Rush = 0.85f;', 'float Tech_Spam_Rush = 0.0f;'),
]
ECO_MAIN = STRIKER_MAIN[1:] + [('float Tech_NUKE_RUSH = 0.25f;', 'float Tech_NUKE_RUSH = 0.0f;')]


def copy_data(src, dst, main_edits, extra):
    if dst.exists():
        shutil.rmtree(dst)
    shutil.copytree(src, dst, ignore=shutil.ignore_patterns('__pycache__'))
    main = dst / 'script/experimental_balanced/main.as'
    s = main.read_text(encoding='utf-8')
    for old, new in main_edits:
        if s.count(old) != 1:
            raise ValueError('lever missing in main.as: ' + old)
        s = s.replace(old, new)
    marker = 'Global::LolCannon::Enabled = true;'
    if s.count(marker) != 1:
        raise ValueError('lolcannon switch missing in main.as')
    s = s.replace(marker, marker + ' ' + ' '.join(extra) + ' // debug strike test only', 1)
    main.write_text(s, encoding='utf-8')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', required=True)
    p.add_argument('--dll', required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--minutes', type=float, default=70)
    p.add_argument('--wall-minutes', type=float, default=55)
    p.add_argument('--bonus', type=int, default=200, help='striker handicap percent (income), so the silo and cannon come early')
    p.add_argument('--silo-cutoff', type=float, default=22, help='minute after which a missing silo is supplied')
    p.add_argument('--lol-cutoff', type=float, default=34, help='minute after which a missing cannon is supplied')
    p.add_argument('--seed', default='31337')
    p.add_argument('--stage-only', action='store_true')
    p.add_argument('--goal-pos', default='', help='x,z for the goal|pos step (default: the eco start)')
    p.add_argument('--goal-smoke', type=float, default=0, metavar='MINUTE',
                   help='instead of the strikes: from MINUTE, goal|pos at the eco start 60 s, off, goal|player|<host> 90 s, off '
                        '(widgets/debug_goal_fixture.lua; results in the AI log "DEBUG: goal" lines)')
    a = p.parse_args()
    d = Path(a.dir).resolve(); d.mkdir(parents=True, exist_ok=True)
    from playtest import map_spots, running_pids
    map_name = 'Supreme Isthmus v1.7'
    spots = map_spots(map_name, ROOT / 'data/script/src/maps/supreme_isthmus_v1_7.as')
    west = next(s for s in spots[:len(spots) // 2] if s[2] == 'TECH')
    east = next(s for s in spots[len(spots) // 2:] if s[2] == 'TECH')
    host = next(s for s in spots[len(spots) // 2:] if s[2] == 'SUPPORT')   # the host's commander: the east SUPPORT spot
    mapfile = d / 'selection.as'
    mapfile.write_text(f'StartSpot(AIFloat3({west[0]},0,{west[1]}), AiRole::TECH, false),\n'
                       f'StartSpot(AIFloat3({east[0]},0,{east[1]}), AiRole::TECH, false)\n')
    striker, eco = d / 'data-striker', d / 'data-eco'
    copy_data(a.data, striker, STRIKER_MAIN, [
        'Global::LolCannon::MetalIncomeGates = array<float> = {120.0f};',
        'Global::LolCannon::MinEnergyIncome = 1500.0f;',
        'Global::RoleSettings::Tech::NukeRushScouts = 6;',
        'Global::RoleSettings::Tech::NukeRushScoutSeconds = 60 * 60;'])
    copy_data(a.data, eco, ECO_MAIN, ['Global::LolCannon::Enabled = false;', 'Global::RoleSettings::Tech::NukeLimit = 0;'])
    check = d / 'checks.json'
    if a.goal_smoke:
        a.minutes = min(a.minutes, a.goal_smoke + 6)
    expect = ([{'key': 'goal', 'pattern': r'DEBUG: goal started', 'by_minute': a.minutes, 'scope': 'any'},
               {'key': 'done', 'pattern': r'\[DebugGoal\] DONE', 'by_minute': a.minutes, 'scope': 'any'}] if a.goal_smoke else
              [{'key': 'strike1', 'pattern': r'\[DebugTest\] RESULT nuke-pos', 'by_minute': a.minutes, 'scope': 'any'},
               {'key': 'done', 'pattern': r'\[DebugTest\] DONE all strikes', 'by_minute': a.minutes, 'scope': 'any'}])
    check.write_text(json.dumps({'stop_minute': a.minutes, 'expect': expect,
        'forbid': [{'key': 'script', 'pattern': r': ERR\s+:|SCRIPT CRASH|Lib exception', 'scope': 'any'}]}, indent=2))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    stage = cmd + ['stage', '--dir', str(d), '--dll', a.dll, '--data', str(striker), '--map', map_name,
                   '--map-file', str(mapfile), '--role', 'TECH', '--roles', 'TECH', '--side', 'armada',
                   '--enemies', 'prod', '--opponent-dll', a.dll, '--opponent-data', str(eco),
                   '--bonus', str(a.bonus),
                   '--modoption', 'dynamiccheats=0', '--modoption', 'deathmode=neverend',
                   '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=' + a.seed,
                   '--mode', 'fast', '--speed', '20', '--minutes', str(a.minutes), '--headless', '--lean-render',
                   '--extra-widget', str(HERE / ('widgets/debug_goal_fixture.lua' if a.goal_smoke else 'widgets/debug_strike_fixture.lua'))]
    subprocess.run(stage, cwd=ROOT, check=True)
    # the host plays: not a spectator, on its own ally team, its commander on the east SUPPORT spot
    script = d / 'script.txt'
    s = script.read_text(encoding='utf-8')
    m = re.search(r'\[PLAYER0\] \{ Name=Playtest; Spectator=1; Team=(\d+);', s)
    if not m:
        raise ValueError('host player line changed in script.txt')
    t = m.group(1)
    s = s.replace('Spectator=1; Team=%s;' % t, 'Spectator=0; Team=%s;' % t, 1)
    s, n = re.subn(r'(\[TEAM%s\] \{ AllyTeam=2; TeamLeader=0; Side=armada; RgbColor=[^;]*; )StartPosX=64; StartPosZ=64;' % t,
                   r'\g<1>StartPosX=%d; StartPosZ=%d;' % (host[0], host[1]), s)
    if n != 1:
        raise ValueError('host team line changed in script.txt')
    script.write_text(s, encoding='utf-8')
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/debug_strike.lua').write_text(
        'return {startA={%d,%d}, startB={%d,%d},\n' % (west[0], west[1], east[0], east[1]) +
        '        nukeLaunches=3, nukePosSec=900, nukePlayerSec=720, lolSec=120, lolRange=5750, lolRadius=150,\n'
        '        siloCutoffMin=%s, lolCutoffMin=%s, strikeScoutWait=240, baseSettleSec=120}\n' % (a.silo_cutoff, a.lol_cutoff))
    (d / 'LuaUI/Config/debug_goal.lua').write_text(
        'return {startA={%d,%d}, startB={%d,%d}, startMin=%s, posSec=60, playerSec=90, armyA={armstump=12, armpw=8}%s}\n'
        % (west[0], west[1], east[0], east[1], a.goal_smoke or 10, (', goalPos={%s}' % a.goal_pos) if a.goal_pos else ''))
    (d / 'scenario.json').write_text(json.dumps({
        'dll': a.dll, 'map': map_name, 'striker': {'team': 0, 'spot': west, 'bonus': a.bonus, 'data': str(striker),
            'overrides': 'roll pinned to NUKE_RUSH (no spam), lolcannon gate 120 m/s and 1500 E/s, 6 scout planes for 60 min'},
        'eco': {'team': 1, 'spot': east, 'data': str(eco), 'overrides': 'no rush roll, no lolcannon, NukeLimit 0'},
        'host': {'team': int(t), 'ally': 2, 'commander': host, 'spectator': False},
        'supplied_cutoffs': {'silo_min': a.silo_cutoff, 'lol_min': a.lol_cutoff}}, indent=2))
    if a.stage_only:
        return 0
    watch = cmd + ['watch', '--dir', str(d), '--role', 'TECH', '--checks', str(check),
                   '--minutes', str(a.minutes), '--wall-minutes', str(a.wall_minutes), '--stop-when-met', '--play-decided']
    try:
        subprocess.run(cmd + ['launch', '--dir', str(d), '--headless'], cwd=ROOT, check=True)
        return subprocess.run(watch, cwd=ROOT).returncode
    finally:
        if running_pids(d):
            subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)


if __name__ == '__main__':
    raise SystemExit(main())
