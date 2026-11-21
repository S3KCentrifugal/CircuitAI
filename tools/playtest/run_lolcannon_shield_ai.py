"""Lolcannon shields, the AI's side, headless (owner 2026-11-20).

Team 0: SMRTBARb TECH (this build), builders held and no economy planning;
the fixture gives it a finished cannon (--gun) and the energy to fire it.
Team 2: NullAI with four shielded target groups (widgets/lolcannon_shield_ai_fixture.lua).
The AI's own tiered fire picks the targets: read its TIER lines for the area
dwell ("dwell N s", "s<shields>" per area), the downrank and the chain line.
Rules: BelowNormal priority, x10, at most 3 headless games on the PC, watchdog.
"""
import argparse
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
    p.add_argument('--gun', default='armvulc')
    p.add_argument('--afus', default='legafus')
    p.add_argument('--fus', default='legfus')
    p.add_argument('--range', type=int, default=4800)
    p.add_argument('--minutes', type=float, default=14)
    p.add_argument('--ghost-min', type=float, default=8)
    p.add_argument('--wall', type=float, default=40)
    p.add_argument('--engine', default='recoil_2026.09.03')
    a = p.parse_args()
    d = a.dir.resolve()
    d.mkdir(parents=True, exist_ok=True)
    starts = d / 'arena-starts.as'
    starts.write_text('StartSpot(AIFloat3(700,0,6144), AiRole::TECH, false),' + chr(10)
                      + 'StartSpot(AIFloat3(11500,0,6144), AiRole::TECH, false),' + chr(10))
    cmd = [sys.executable, str(HERE / 'playtest.py')]
    subprocess.run(cmd + ['stage', '--dir', str(d), '--map-file', str(starts), '--dll', str(a.dll), '--data', str(a.data),
                          '--engine', a.engine, '--map', 'Full Metal Plate 1.7', '--isolated',
                          '--role', 'TECH', '--roles', 'TECH', '--side', 'armada', '--others', 'none', '--bonus', '50',
                          '--modoption', 'deathmode=neverend', '--modoption', 'allowuserwidgets=1',
                          '--modoption', 'allowunitcontrolwidgets=1', '--modoption', 'experimentalextraunits=1',
                          '--ai-option', 'profile=experimental_balanced',
                          '--speed', '10', '--minutes', str(a.minutes), '--headless', '--lean-render',
                          '--extra-widget', str(HERE / 'widgets/lolcannon_shield_ai_fixture.lua')], cwd=ROOT, check=True)
    staged = d / 'AI/Skirmish/BARbTest/test'
    setup = staged / 'script/src/setup.as'
    s = setup.read_text()
    assert s.count('Global::AISettings::Role = derivedRole;') == 1
    setup.write_text(s.replace('Global::AISettings::Role = derivedRole;',
        'derivedRole = AiRole::TECH; Global::AISettings::Role = derivedRole; // shield fixture'))
    role = staged / 'script/src/roles/tech/tech.as'
    s = role.read_text()
    assert s.count('void Tech_EconomyUpdate()\n\t{') == 1
    role.write_text(s.replace('void Tech_EconomyUpdate()\n\t{',
        'void Tech_EconomyUpdate()\n\t{\n        if (ai.teamId >= 0) return; // shield fixture: no economy planning'))
    path = staged / 'script/src/manager/builder.as'
    source = path.read_text()
    pos = source.index('{', source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)')) + 1
    source = source[:pos] + '\n        if (ai.teamId >= 0) return aiBuilderMgr.Enqueue(TaskB::Wait(3*SECOND)); // shield fixture: builders held\n' + source[pos:]
    path.write_text(source)
    script = d / 'script.txt'
    s = script.read_text(encoding='utf-8')
    m = re.search(r'\[PLAYER0\] \{ Name=Playtest; Spectator=1; Team=(\d+);', s)
    nteam = int(m.group(1)) + 1
    tail = s.rindex('}')
    s = s[:tail] + ('\t[TEAM%d] { AllyTeam=1; TeamLeader=0; Side=armada; RgbColor=1.0 0.5 0.1; StartPosX=11500; StartPosZ=6144; Handicap=0; }\n'
                    '\t[AI%d] { ShortName=NullAI; Version=0.1; Name=Targets; Team=%d; Host=0; IsFromDemo=0; }\n' % (nteam, nteam, nteam)) + s[tail:]
    script.write_text(s, encoding='utf-8')
    (d / 'LuaUI/Config').mkdir(parents=True, exist_ok=True)
    (d / 'LuaUI/Config/lolshield_ai.lua').write_text(
        'return {gun="%s", afus="%s", fus="%s", shield="armgate", gunX=1500, gunZ=6144, range=%d, ghostMin=%s}\n'
        % (a.gun, a.afus, a.fus, a.range, a.ghost_min))
    # NullAI is team 2 (ally 1); the fixture gives targets to "team 1" in its widget: fix the id
    w = d / 'LuaUI/Widgets/lolcannon_shield_ai_fixture.lua'
    t = w.read_text()
    t = t.replace('give(A,1,', 'give(A,%d,' % nteam).replace('give(F,1,', 'give(F,%d,' % nteam)
    t = t.replace('give(cfg.shield,1,', 'give(cfg.shield,%d,' % nteam).replace('GetTeamUnits(1)', 'GetTeamUnits(%d)' % nteam)
    w.write_text(t)
    while headless_count() >= 3:
        print('[shieldai] waiting for a headless slot', flush=True)
        time.sleep(30)
    import os
    env = dict(os.environ, BAR_PLAYTEST_LOW_PRIORITY='1')
    from playtest import running_pids
    subprocess.run(cmd + ['launch', '--dir', str(d), '--headless', '--engine', a.engine], cwd=ROOT, check=True, env=env)
    start = time.time()
    try:
        while time.time() - start < a.wall * 60:
            time.sleep(10)
            if not running_pids(d):
                break
    finally:
        subprocess.run(cmd + ['stop', '--dir', str(d)], cwd=ROOT, check=False)
    print('[shieldai] done', flush=True)


if __name__ == '__main__':
    raise SystemExit(main())
