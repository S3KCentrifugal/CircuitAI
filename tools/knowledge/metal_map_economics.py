#!/usr/bin/env python3
"""Reproduce metal-map design arithmetic; not a gameplay simulation.

Reads the sibling game-knowledge cache and verifies the scalar inputs against
the pinned BAR source. Run from any directory; optionally pass --output PATH.
No game files are written. No growth-rate or win-rate prediction is made.
"""
import argparse
import json
import math
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]


def calculate():
    cache = ROOT.parent / 'rjm.bar.docs/tools/knowledge/.cache/kb.json'
    kb = json.loads(cache.read_text(encoding='utf-8'))
    game = ROOT.parent / 'bar-Beyond-All-Reason'
    names = ['armmex', 'armmoho', 'armwin', 'armfus', 'armafus', 'armfig',
             'armthund', 'armhawk', 'armpnix', 'corhurc', 'armca', 'armaca',
             'armnanotc', 'armaap']
    keys = ['metalcost', 'energycost', 'buildtime', 'workertime',
            'extractsmetal', 'energyupkeep', 'energymake', 'windgenerator']
    units = {}
    for name in names:
        cached = kb['units'][name]
        source = (game / cached['file']).read_text(encoding='utf-8')
        values = {'source': cached['file']}
        for key in keys:
            if key not in cached:
                continue
            match = re.search(r'^\s*' + key + r'\s*=\s*([0-9.+-]+)\s*,', source, re.M)
            if match is None or float(match[1]) != float(cached[key]):
                raise ValueError(f'{name}.{key}: cache does not match source')
            values[key] = cached[key]
        units[name] = values

    def disk(radius):
        bound = math.ceil(radius / 16) + 1
        return sum((16 * (x + .5)) ** 2 + (16 * (z + .5)) ** 2 < radius ** 2
                   for x in range(-bound, bound) for z in range(-bound, bound))

    mex = units['armmex']
    moho = units['armmoho']
    fields = []
    # These are explicit uniform-field fixtures, not a rerun of map extraction.
    for name, scale, byte, radius in [('plate_fixture', 7.5, 79, 24),
                                      ('speedmetal_fixture', 10, 255, 30)]:
        v = mex['extractsmetal'] * scale * byte * disk(radius)
        fields.append({'fixture': name, 'max_metal': scale, 'raw_byte': byte,
                       'radius': radius, 'cells': disk(radius), 't1_mps': v,
                       'moho_mps': v * moho['extractsmetal'] / mex['extractsmetal'],
                       'winds_at_25_to_fund_mex_output_as_armfig':
                           (v * units['armfig']['energycost'] / units['armfig']['metalcost']
                            + mex['energyupkeep']) / 25})

    def costs(name, count):
        return {k: units[name][k] * count for k in ['metalcost', 'energycost', 'buildtime']}

    wave = {k: 20 * (units['armpnix'][k] + units['armhawk'][k])
            for k in ['metalcost', 'energycost', 'buildtime']}
    lab_bp = units['armaap']['workertime'] + 20 * units['armnanotc']['workertime']
    wave['target_seconds_example'] = 120
    wave['metal_per_second'] = wave['metalcost'] / 120
    wave['energy_per_second'] = wave['energycost'] / 120
    wave['minimum_effective_build_power'] = wave['buildtime'] / 120
    wave['one_lab_20_nanos_resource_unlimited_seconds_no_startup'] = wave['buildtime'] / lab_bp
    wave['limitations'] = 'No unit startup/launch delay, travel, losses, other spending or upkeep included.'
    upgrade = {k: moho[k] for k in ['metalcost', 'energycost', 'buildtime']}
    upgrade['net_metal_after_refund'] = moho['metalcost'] - mex['metalcost']
    upgrade['additional_upkeep'] = moho['energyupkeep'] - mex['energyupkeep']
    upgrade['additional_t1_equivalent_yield'] = moho['extractsmetal'] / mex['extractsmetal'] - 1
    growth_rival = costs('armmex', 3)
    growth_rival['additional_upkeep'] = 3 * mex['energyupkeep']
    m, e, upkeep, ratio, margin = 100, 1000, 30, 20, .05
    spendable = min(m, (e - upkeep) / ratio)
    computed_need = spendable * ratio + upkeep
    result = {
        'kind': 'derived arithmetic, not an engine simulation or measured PvP benchmark',
        'source_cache_meta': kb['meta'], 'source_checked_units': units,
        'strict_circle_counts': {str(r): disk(r) for r in [24, 30, 40, 60, 70, 80, 90, 100, 120]},
        'uniform_field_fixtures': fields,
        'unit_energy_per_metal': {n: units[n]['energycost'] / units[n]['metalcost']
                                  for n in ['armfig', 'armthund', 'armhawk', 'armpnix', 'corhurc']},
        'upgrade_of_existing_t1': upgrade, 'three_additional_t1_mexes': growth_rival,
        'equal_3000_energy_at_constant_25_wind': {
            '120_winds': costs('armwin', 120), '4_fusions': costs('armfus', 4),
            '1_afus': costs('armafus', 1)},
        'twenty_armpnix_plus_twenty_armhawk': wave,
        'original_energy_loop_counterexample': {
            'M': m, 'E': e, 'upkeep': upkeep, 'r': ratio, 'margin': margin,
            'spendable': spendable, 'computed_need_E': computed_need,
            'requests_energy_with_full_bank_and_zero_drains': e < computed_need * (1 - margin),
            'energy_to_fund_full_100_mps': m * ratio + upkeep},
    }
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = calculate()
    encoded = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.write_text(encoded, encoding='utf-8')
        print(f'Wrote {args.output}; scalar inputs cross-checked against BAR source.')
    else:
        print(encoded, end='')
