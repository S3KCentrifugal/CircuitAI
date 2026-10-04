"""Focused physical workforce evidence; never replaces a whole-game verdict."""
import argparse
import collections
import json
from pathlib import Path
import re
from workforce_metrics import parse_sample, summarize


def audit(directory):
    directory = Path(directory)
    fixture = json.loads((directory/'workforce-fixture.json').read_text())
    case = json.loads((Path(__file__).parent/'cases/air/economy'/('workforce-'+fixture['scenario']+'.json')).read_text())
    text = (directory/'infolog.txt').read_text(errors='replace')
    samples = [row for line in text.splitlines() if (row := parse_sample(line))]
    complete = re.findall(r'\[WorkforceFixture\] completed id=(\d+) def=(\w+)', text)
    low = set(re.findall(r'\[WorkforceFixture\] recruit plant=\d+ target=(\d+) progress=[\d.]+ priority=0', text))
    stats = summarize(samples)
    observed = {
        'completed-workers': any(re.fullmatch(r'(?:arm|cor|leg)(?:aca|ca|nanotc)', name) for _, name in complete),
        'negative-own-balance-full-bank': stats['negative_own_balance_full_samples'] > 0,
        'donor-stop': bool(re.search(r'\[WorkforceFixture\] donor stopped bursts=[1-9]\d*', text)),
        'six-working-factories': any(row.get('factoriesWorking', 0) >= 6 for row in samples),
        'economic-static-power': bool(re.search(r'\[AIR\]\[Capacity\].*ecoStatic=[1-9]\d*', text)),
        'old-nine-slot-adoption': '[WorkforceProbe] PASS old nine-slot adoption' in text,
        'blocked-support-relocation': '[WorkforceProbe] PASS blocked support relocates unused module' in text,
        'cancelled-support': '[WorkforceProbe] PASS cancelled unframed support' in text,
        'both-tiers-released': '[WorkforceProbe] PASS both tiers released idle guards' in text,
        'player-ownership': '[WorkforceProbe] PASS player worker unavailable and ownership preserved' in text,
        'role-reentry': 'Role switch complete: now SUPPORT' in text and 'Role switch complete: now AIR' in text,
    }
    missing = [key for key in case['focused_assertions'] if not observed[key]]
    invariants = dict(collections.Counter(re.findall(r'\[INVARIANT\] (INV-\d+)', text)))
    errors = re.findall(r'[^\n]*(?:SCRIPT CRASH|: ERR\s+:|: WARN\s+:|Access violation)[^\n]*', text)
    return dict(fixture=fixture, observations=observed, missing=missing, invariants=invariants, errors=errors,
        focused_pass=not missing and not errors and not invariants, workforce=stats,
        completed_by_definition=dict(collections.Counter(name for _,name in complete)),
        low_priority_targets=len(low), low_priority_targets_completed=len(low & {unit for unit,_ in complete}),
        priority_note='Completion after observing priority 0 is not a matched causal low/high-pull experiment.')


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('directory',type=Path);a=p.parse_args()
    result=audit(a.directory)
    (a.directory/'workforce-audit.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
    raise SystemExit(not result['focused_pass'])
