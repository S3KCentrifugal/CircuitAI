"""Observed workforce samples; no interpolation of missing resource intervals."""
import re
from statistics import mean


def parse_sample(line):
    if '[AirWorkforce]' not in line:
        return None
    values = dict(re.findall(r'(\w+)=(-?\d+(?:\.\d+)?)', line.split('[AirWorkforce]', 1)[1]))
    if 'frame' not in values:
        return None
    row = {k: float(v) for k, v in values.items()}
    row['frame'] = int(row['frame'])
    bank = re.search(r'metal=([\d.]+)/([\d.]+)', line)
    if bank:
        row['metal'], row['storage'] = map(float, bank.groups())
    return row


def summarize(samples):
    # Duplicate log reads must not weight an interval twice. Retain only one
    # observation per frame; absent fields remain unavailable, never zero.
    rows = list({row['frame']: row for row in samples}.values())
    result = {'samples': len(rows), 'resource_totals': None,
              'note': 'Point samples; do not infer total donations/overflow from these intervals.'}
    for key in ('usageM', 'usageE', 'workingBP', 'idleBP', 'nanos', 'nanoWorking', 'factoriesWorking', 't1', 't2'):
        values = [row[key] for row in rows if key in row]
        result[key+'_mean'] = mean(values) if values else None
        result[key+'_max'] = max(values) if values else None
    banks = [row for row in rows if row.get('storage', 0) > 0]
    result['full_bank_sample_fraction'] = mean(row['metal'] >= row['storage']*.9 for row in banks) if banks else None
    result['negative_own_balance_full_samples'] = sum(row['metal'] >= row['storage']*.9
        and row['usageM'] > row['income'] for row in banks if 'usageM' in row and 'income' in row)
    return result


def compare(baseline, revised):
    # Outcomes are meaningful only inside the same recorded experiment cohort.
    required = ('map', 'engine', 'game', 'seed', 'side', 'minutes', 'kind')
    missing = [key for key in required if key not in baseline or key not in revised]
    different = [key for key in required if key not in missing and baseline[key] != revised[key]]
    return {'comparable': not missing and not different, 'missing': missing, 'different': different}
