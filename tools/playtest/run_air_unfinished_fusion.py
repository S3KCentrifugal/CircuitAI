"""AIR bombers: finished fusions/AFUS before unfinished ones (owner 2026-11-23).

The Liche-strike arena (Supreme Isthmus, team 0 SMRTBARb AIR, team 1 SMRTBARb
FRONT, builders and factories held, global LOS) plus a NullAI target team.
widgets/air_unfinished_fusion_fixture.lua supplies Phoenix waves and, per
stage, an unfinished advanced fusion nearest the AIR base, a finished fusion
and a finished advanced fusion furthest out. Read the AI's "WAVE: strike
target" / "WAVE: immediate strike" lines (unfinished flag) and the fixture's
[AirUnfinished] died lines for the kill order.
Rules: BelowNormal priority, x10, +50, at most 3 headless games, watchdog.
"""
import argparse
import os
import re
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))
from run_lolcannon_shield import headless_count  # noqa: E402


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dir', type=Path, required=True)
    p.add_argument('--dll', type=Path, required=True)
    p.add_argument('--data', type=Path, default=ROOT / 'data')
    p.add_argument('--minutes', type=float, default=12)
    p.add_argument('--stage2-min', type=float, default=6)
    p.add_argument('--wall', type=float, default=30)
    p.add_argument('--seed', type=int, default=1621)
    p.add_argument('--bombers', type=int, default=30)
    p.add_argument('--stage-only', action='store_true', help='stage, then launch with BAR\scripts\headless-slot.ps1')
    p.add_argument('--engine', default='recoil_2026.09.03')
    a = p.parse_args()
    d = a.dir.resolve()
    d.mkdir(parents=True, exist_ok=True)
    starts = d / 'starts.as'
    starts.write_text('StartSpot(AIFloat3(2155,0,11747), AiRole::AIR, false),\n'
                      'StartSpot(AIFloat3(11456,0,1901), AiRole::FRONT, false),\n')
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    subprocess.run(cmd + ['stage', '--dir', str(d), '--dll', str(a.dll), '--data', str(a.data),
                          '--map', 'Supreme Isthmus v1.7', '--map-file', str(starts), '--engine', a.engine,
                          '--role', 'AIR', '--roles', 'all', '--side', 'armada', '--ally-spots', '1', '--bonus', '50',
                          '--mode', 'fast', '--speed', '10', '--minutes', str(a.minutes), '--headless',
                          '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=' + str(a.seed),
                          '--modoption', 'deathmode=neverend',
                          '--extra-widget', str(HERE / 'widgets/air_unfinished_fusion_fixture.lua')], cwd=ROOT, check=True)
    scripts = d / 'AI/Skirmish/BARbTest/test/script/src'
    script = d / 'script.txt'
    s = script.read_text(encoding='utf-8')
    s, n = re.subn(r'(\[GAME\]\s*\{)', lambda m: m[1] + '\n FixedRNGSeed=' + str(a.seed) + ';', s, count=1)
    assert n == 1
    teams = [int(t) for t in re.findall(r'\[TEAM(\d+)\]', s)]
    nteam = max(teams) + 1
    tail = s.rindex('}')
    s = s[:tail] + ('\t[TEAM%d] { AllyTeam=1; TeamLeader=0; Side=armada; RgbColor=1.0 0.5 0.1; StartPosX=6000; StartPosZ=4000; Handicap=0; }\n'
                    '\t[AI%d] { ShortName=NullAI; Version=0.1; Name=Targets; Team=%d; Host=0; IsFromDemo=0; }\n'
                    % (nteam, nteam, nteam)) + s[tail:]
    script.write_text(s, encoding='utf-8')
    setup = scripts / 'setup.as'
    t = setup.read_text()
    key = 'Global::AISettings::Role = derivedRole;'
    assert t.count(key) == 1
    setup.write_text(t.replace(key, 'derivedRole = ai.teamId == 0 ? AiRole::AIR : AiRole::FRONT;\n' + key))
    for name, manager, descriptor in [('builder', 'aiBuilderMgr', 'TaskB::Wait(60 * SECOND)'),
                                      ('factory', 'aiFactoryMgr', 'TaskS::Wait(false, 60 * SECOND)')]:
        path = scripts / 'manager' / (name + '.as')
        t = path.read_text()
        at = t.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)')
        brace = t.index('{', at)
        path.write_text(t[:brace + 1] + '\n if (ai.frame >= 0) return ' + manager + '.Enqueue(' + descriptor
                        + '); // controlled combat\n' + t[brace + 1:])
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/air_unfinished.lua').write_text('return {team=%d, stage2=%d, bombers=%d}\n'
                                                       % (nteam, int(a.stage2_min * 60 * 30), a.bombers))
    if a.stage_only:
        print(d / 'script.txt')
        return 0
    while headless_count() >= 3:
        print('[airunfinished] waiting for a headless slot', flush=True)
        time.sleep(30)
    env = dict(os.environ, BAR_PLAYTEST_LOW_PRIORITY='1')
    from playtest import running_pids
    subprocess.run(cmd + ['launch', '--dir', str(d), '--headless', '--engine', a.engine], cwd=ROOT, check=True, env=env)
    start = time.time()
    try:
        while time.time() - start < a.wall * 60:  # watchdog
            time.sleep(10)
            if not running_pids(d):
                break
    finally:
        subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)
    log = d / 'infolog.txt'
    if log.exists():
        for line in log.read_text(encoding='utf-8', errors='replace').splitlines():
            if ('[AirUnfinished]' in line or 'WAVE: strike target' in line or 'WAVE: immediate strike' in line
                    or 'WAVE: committed attack' in line or 'Error' in line and 'widget' in line.lower()):
                print(line[:220])
    print('[airunfinished] done', flush=True)


if __name__ == '__main__':
    raise SystemExit(main())
