"""TECH layout and engineering/home-worker isolation check. Supplied economy, not a benchmark."""
import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path

import playtest
import ranged_arena
import ranged_benchmark
import storage
from run_retirement_regression import inject_entry


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll', type=Path, required=True)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--mode', choices=['fast', 'visual', 'performance'], default='fast')
    parser.add_argument('--packing-repeats', type=int, default=0,
                        help='Component comparison: identical live CanPackNearGroup queries before mutation')
    parser.add_argument('--geometry-only', action='store_true',
                        help='Separate packing component fixture; excludes construction/task handoff')
    parser.add_argument('--packing-nanos', type=int, default=0,
                        help='Supply remote completed turrets to measure owned-population scaling (0..512)')
    args = parser.parse_args()
    if not 0 <= args.packing_repeats <= 1000:
        parser.error('--packing-repeats must be 0..1000')
    if not 0 <= args.packing_nanos <= 512 or (args.packing_nanos and not args.geometry_only):
        parser.error('--packing-nanos must be 0..512 and requires --geometry-only')
    if args.packing_repeats and args.mode != 'performance':
        parser.error('Repeated cost fixture requires --mode performance')
    if args.packing_repeats and any(k in os.environ for k in ('CIRCUIT_VERIFY_PACK_CANDIDATES', 'CIRCUIT_VERIFY_EMPTY_PACK')):
        parser.error('Disable verification oracles for cost comparisons')
    case = 'tech-layout-saturation'
    probe_name = 'tech_layout_probe'
    namespace = 'TechLayoutProbe'
    arena = argparse.Namespace(case=case, dll=args.dll, data=args.data,
        variant='ranged', profile='experimental_balanced', game=None, seed=2071,
        minutes=3, speed=20, mode=args.mode, headless=False)
    if args.packing_nanos:
        supplied = json.loads(storage.resolve_definition(case, 'cases').read_text())
        supplied['storage_scenario'] = 'tech-packing-population'
        supplied['batch_spawn'] = True
        # Each site uses its own terrain-height reference. A single large group
        # inherits its first site's height and rejects remote candidates
        # on this uneven map. Separate sites also exceed the arena's 96-elmo
        # spacing requirement; actual owned membership is asserted below.
        supplied['groups'].extend({'unit':'cornanotc','team':0,'count':1,
            'position':[1000+(i%32)*128,5256+(i//32)*128],'after_seconds':10}
            for i in range(args.packing_nanos))
        with tempfile.TemporaryDirectory(prefix='circuit-packing-') as scratch:
            definition = Path(scratch)/'packing.json'
            definition.write_text(json.dumps(supplied))
            arena.case = str(definition)
            directory, call = ranged_arena.prepare(arena)
    else:
        directory, call = ranged_arena.prepare(arena)
    source = directory/'AI/Skirmish/BARbTest/test/script'
    probe = playtest.HERE/'fixtures'/f'{probe_name}.as'
    (source/'src'/f'{probe_name}.as').write_bytes(probe.read_bytes())
    if args.packing_nanos:
        target = source/'src'/f'{probe_name}.as'
        text = target.read_text()
        needle = 'slot=Layout::PackSetAnywhere(af,Layout::boxCentre,1);'
        assert text.count(needle) == 1
        population = ('array<Id>@ population=ai.GetOwnedUnitIds(); int ownedNanos=0;\n'
            'for(uint member=0;member<population.length();++member) { '
            'CCircuitUnit@ unit=ai.GetTeamUnit(population[member]); '
            'if(unit !is null && unit.circuitDef.GetName()=="cornanotc") ++ownedNanos; }\n'
            f'AiLog("[TechLayoutProbe] support_population expected={args.packing_nanos} actual="+ownedNanos);\n'
            f'Check("owned_support_population",ownedNanos=={args.packing_nanos});\n')
        target.write_text(text.replace(needle, population+needle))
    verify_repeats = 'CIRCUIT_VERIFY_PACK_CANDIDATES' in os.environ
    if verify_repeats:
        target = source/'src'/f'{probe_name}.as'
        text = target.read_text()
        needle = 'slot=Layout::PackSetAnywhere(af,Layout::boxCentre,1);'
        assert text.count(needle) == 1
        # Exercise actual positive cache hits as well as the following mutation
        # misses. The native oracle compares every ranked candidate in order.
        statement = ('bool repeated=true;\nfor(int ask=0;ask<3;++ask) '
            'repeated=aiTerrainMgr.CanPackNearGroup(Layout::boxZone,af,Layout::nanoGroup,0,0.0f,0.0f) && repeated;\n'
            'Check("repeated_positive_admission",repeated);\n')
        target.write_text(text.replace(needle,statement+needle))
    if args.geometry_only:
        target = source/'src'/f'{probe_name}.as'
        text = target.read_text()
        needle = '            // Bind a distant engineering cohort'
        assert text.count(needle) == 1
        target.write_text(text.replace(needle,
            '            if(ai.frame>=0) { phase=99; AiLog("[TechLayoutProbe] geometry complete"); return; }\n'+needle))
    if args.packing_repeats:
        target = source/'src'/f'{probe_name}.as'
        text = target.read_text()
        needle = 'slot=Layout::PackSetAnywhere(af,Layout::boxCentre,1);'
        assert text.count(needle) == 1
        statement = ('AiPerfBeginLabel("packing-repeated-admission");\n'
                     'bool any=false;\n'
                     f'for(int repeat=0;repeat<{args.packing_repeats};++repeat) '
                     'any=aiTerrainMgr.CanPackNearGroup(Layout::boxZone,af,Layout::nanoGroup,0,0.0f,0.0f) || any;\n'
                     'AiPerfEndLabel();\nCheck("packing_has_candidates",any);\n'
                     'AiPerfBeginLabel("packing-empty-admission");\n'
                     'bool impossible=false;\n'
                     f'for(int repeat=0;repeat<{args.packing_repeats};++repeat) '
                     'impossible=aiTerrainMgr.CanPackNearGroup(Layout::boxZone,af,Layout::nanoGroup,0,1.0f,0.0f) || impossible;\n'
                     'AiPerfEndLabel();\nCheck("packing_empty",!impossible);\n')
        target.write_text(text.replace(needle, statement+needle))
    profile = source/'experimental_balanced/main.as'
    profile.write_text(f'#include "../src/{probe_name}.as"\n'+profile.read_text())
    inject_entry(profile, 'void AiUpdate()', f'{namespace}::Tick();')
    inject_entry(source/'src/manager/builder.as', 'IUnitTask@ AiMakeTask(CCircuitUnit@ u)',
        'if (ai.teamId==0) { IUnitTask@ retained=TechLayoutProbe::Retain(u); if (retained !is null) return retained; }')
    inject_entry(source/'src/systems/construction/frontline_engineering.as', 'void Tick(bool released)', 'if (ai.frame>=0) return; // independent energy admission fixture')
    inject_entry(source/'src/systems/diagnostics/invariants.as', 'void Tick()', 'if (ai.frame>=0) return; // supplied economy layout')
    inject_entry(source/'src/roles/tech/tech_build.as', 'void Tick()', 'if(ai.frame>=0) return; // isolated geometry fixture')
    (directory/'tech-layout-saturation-inputs.json').write_text(json.dumps({
        'probe_sha256':storage.file_hash(probe),
        'packing_repeats':args.packing_repeats,
        'packing_nanos':args.packing_nanos,
        'geometry_only':args.geometry_only,
        'oracle_repeat_queries':3 if verify_repeats else 0,
        'overrides':['supplied two turret layout zones and fusion funding', 'ordinary work frozen; actual packing and support construction'],
        'files':{str(p.relative_to(source)):storage.file_hash(p) for p in source.rglob('*.as')}
    }, indent=2))
    checks = case
    if args.packing_repeats or args.geometry_only or verify_repeats:
        comparison_checks = json.loads(storage.resolve_definition(case, 'checks').read_text())
        comparison_checks['forbid'].append({'key':'arena-fixture-errors',
            'pattern':r'\[RangedArena\].*ERROR','scope':'any'})
        if args.geometry_only:
            geometry = {'fixture', 'primary_ring_first', 'planned_is_not_build_power',
                        'all_sides_used', 'overflow_only_when_full'}
            comparison_checks['expect'] = [check for check in comparison_checks['expect'] if check['key'] in geometry]
            comparison_checks['complete_on']['pattern'] = r'\[TechLayoutProbe\] geometry complete'
        if verify_repeats:
            comparison_checks['expect'].append({'key':'repeated-positive-admission',
                'pattern':r'\[TechLayoutProbe\] PASS repeated_positive_admission','scope':'any','by_minute':2.8})
        # Fixed windows for cost evidence; the separate geometry fixture never
        # claims to clear the original support/construction assertions.
        if args.packing_repeats:
            comparison_checks['expect'].append({'key':'packing-timer',
                'pattern':'label=packing-repeated-admission calls=1 ', 'scope':'any', 'by_minute':2.8})
            comparison_checks['expect'].append({'key':'empty-packing-timer',
                'pattern':'label=packing-empty-admission calls=1 ', 'scope':'any', 'by_minute':2.8})
        if args.packing_nanos:
            comparison_checks['expect'].append({'key':'owned-support-population',
                'pattern':r'\[TechLayoutProbe\] PASS owned_support_population','scope':'any','by_minute':2.8})
    if args.packing_repeats:
        comparison_checks.pop('complete_on', None)
        comparison_checks.pop('completion_grace_seconds', None)
    if args.packing_repeats or args.geometry_only or verify_repeats:
        checks = str(directory/'packing-comparison-checks.json')
        Path(checks).write_text(json.dumps(comparison_checks, indent=2))
    try:
        env = dict(os.environ)
        if args.packing_repeats: env['CIRCUIT_PERF_PHASES'] = '1'
        subprocess.run(call+['launch','--dir',str(directory),'--engine','recoil_2026.07.04'],env=env,check=True)
        status = subprocess.call(call+['watch','--dir',str(directory),'--role','TECH',
            '--checks',checks,'--minutes','3','--wall-minutes','8'])
        return status if status else (0 if ranged_benchmark.summarize(directory)['passed'] else 1)
    finally:
        subprocess.run(call+['stop','--dir',str(directory)],check=False)


if __name__ == '__main__':
    sys.exit(main())


