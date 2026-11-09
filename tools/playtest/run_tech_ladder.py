"""Supplied post-nuke income ladder regression, not a timing benchmark."""
import argparse
import json
import subprocess
import sys
from pathlib import Path

import playtest
import storage
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--scenario', choices=('stale', 'gift'), default='stale')
    args = parser.parse_args()
    directory = storage.allocate('tech', 'economy', 'post-nuke-ladder', 'supreme', 'supplied', seed=3062)
    print('TECH_LADDER_DIRECTORY='+str(directory), flush=True)
    call = [sys.executable, str(playtest.HERE/'playtest.py')]
    allies = ['--ally-spots', '1,2,3,4,5,6,7,8,10'] if args.scenario == 'gift' else []
    subprocess.run(call+['stage', '--dir', str(directory), '--dll', str(args.dll), '--data', str(args.data),
        '--map', 'Supreme Isthmus v1.7', '--engine', 'recoil_2026.07.04', '--role', 'TECH', '--roles', 'TECH',
        '--side', 'cortex', '--ai-option', 'profile=experimental_balanced', '--ai-option', 'random_seed=3062',
        '--bonus', '0', '--mode', 'fast', '--speed', '20', '--minutes', '8', '--shots', '', '--lean-render',
        '--modoption', 'deathmode=neverend', '--modoption', 'startmetal=100000',
        '--modoption', 'startmetalstorage=1000000', '--modoption', 'startenergy=1000000',
        '--modoption', 'startenergystorage=1000000', '--extra-widget', str(playtest.HERE/'widgets/tech_ladder_watch.lua')]+allies, check=True)
    widget = directory/'LuaUI/Widgets/tech_ladder_watch.lua'
    widget.write_text(widget.read_text().replace('local giftScenario=false',
        'local giftScenario='+str(args.scenario == 'gift').lower()))
    source = directory/'AI/Skirmish/BARbTest/test/script/src'
    (source/'tech_ladder_probe.as').write_bytes((playtest.HERE/'fixtures/tech_ladder_probe.as').read_bytes())
    profile = source.parent/'experimental_balanced/main.as'
    profile.write_text('#include "../src/tech_ladder_probe.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiLuaMessage(const string& in data)', 'if (TechLadderProbe::Handle(data)) return;')
    inject_entry(source/'roles/tech/tech.as', 'void Tech_EconomyUpdate()', 'if (ai.teamId >= 0) { TechLadderProbe::Tick(); return; }')
    inject_entry(source/'manager/builder.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
                 'if (ai.teamId >= 0) return TechLadderProbe::Task(u);')
    inject_entry(source/'manager/factory.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
                 'if (ai.teamId >= 0) return aiFactoryMgr.Enqueue(TaskS::Wait(false, SECOND));')
    # Supplied geometry cannot satisfy natural-base layout assertions.
    inject_entry(source/'systems/diagnostics/invariants.as', 'void Tick()', 'if (ai.frame >= 0) return;')
    checks = directory/'tech-ladder-checks.json'
    pattern = r'\[TechLadderTest\] PASS reactor_completed'
    gift_checks = [{'key':key, 'pattern':r'\[TechLadderTest\] PASS '+key,
                    'by_minute':1, 'scope':'any'} for key in
                   ('owned_before_gift', 'gift_received', 'gift_cache_invalidated')] if args.scenario == 'gift' else []
    checks.write_text(json.dumps({'stop_minute':8, 'complete_on':{'key':'complete','pattern':pattern,'scope':'any'},
        'completion_grace_seconds':5, 'expect':[
            {'key':'ordinary admission', 'pattern':r'\[TechLadderTest\] PASS ordinary_rejects_stale_mex', 'by_minute':1, 'scope':'any'},
            {'key':'admission', 'pattern':r'\[TechLadderTest\] PASS stale_mex_releases_reactor', 'by_minute':1, 'scope':'any'},
            {'key':'completion', 'pattern':pattern, 'by_minute':8, 'scope':'any'}]+gift_checks,
        'forbid':[{'key':'failure','pattern':r'\[TechLadderTest\] FAIL|\[INVARIANT\]|: ERR\s+:|SCRIPT CRASH|Lib exception|Access violation|has crashed|Fatal:','scope':'any'}]}, indent=2))
    (directory/'tech-ladder-inputs.json').write_text(json.dumps({
        'scenario':args.scenario,
        'overrides':['supplied worker/nanos/banks', 'stale remembered mex', 'ordinary economy suspended',
                     'funded-growth clock', 'supplied nanos repair the real reactor frame', 'base geometry Tick suspended'],
        'files':{str(p.relative_to(directory)):storage.file_hash(p) for p in source.parent.rglob('*.as')},
        'widget_sha256':storage.file_hash(directory/'LuaUI/Widgets/tech_ladder_watch.lua')}, indent=2))
    try:
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'], check=True)
        return subprocess.call(call+['watch','--dir',str(directory),'--role','TECH','--minutes','8',
                                    '--wall-minutes','10','--checks',str(checks)])
    finally:
        subprocess.run(call+['stop','--dir',str(directory)], check=False)


if __name__ == '__main__':
    sys.exit(main())
