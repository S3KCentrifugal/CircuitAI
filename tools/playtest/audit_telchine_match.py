"""Summarize natural Telchine evidence, excluding simulation frames after GameOver."""
import argparse
import collections
import json
import re
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('log', type=Path)
p.add_argument('--output', type=Path)
a = p.parse_args()
events = []
winner = None
manifest = next((parent / 'teams.json' for parent in a.log.parents
                 if (parent / 'teams.json').exists()), None)
roster = json.loads(manifest.read_text()).get('teams', []) if manifest else []
competitive = {int(t['team']): int(t['ally']) for t in roster}
dead = {}
defeated = None
for line in a.log.open(encoding='utf-8', errors='replace'):
    frame = re.search(r'\[f=(-?\d+)\]', line)
    if not frame:
        continue
    f = int(frame[1])
    census = re.search(r'\[TeamStats\].*?team (\d+) ally (\d+)( dead)?:', line)
    if census and int(census[1]) in competitive:
        team, ally = int(census[1]), int(census[2])
        dead[team] = bool(census[3])
        side = [t for t, side in competitive.items() if side == ally]
        if defeated is None and side and all(dead.get(t, False) for t in side):
            defeated = {'frame': f, 'allyteam': ally,
                        'meaning': 'First all-dead census; an upper bound, not exact elimination time.'}
    if '[TelMatch] gameover winners=' in line and winner is None:
        winner = {'frame': f, 'allyteams': line.strip().split('winners=')[1]}
    if '[TelMatch]' in line or '[AMPH]' in line or '[INVARIANT]' in line:
        events.append((f, line.strip()))
cutoff = winner['frame'] if winner else max((f for f, _ in events), default=0)
before = [(f, s) for f, s in events if f <= cutoff]
def times(pattern):
    return [f for f, s in before if re.search(pattern, s)]
def stamp(f):
    seconds = f // 30
    return f'{seconds // 60:02}:{seconds % 60:02}'
landings = [(f, s) for f, s in before if '[TelMatch] landfall' in s]
result = {
    'complete': winner is not None,
    'winner': winner,
    'first_defeated_ally_census': defeated,
    'competitive_endpoint_warning': bool(defeated and defeated['frame'] < cutoff),
    'cutoff_time': stamp(cutoff),
    'telchines_completed': len(times(r'TelMatch\] finished')),
    'first_completed': next((stamp(f) for f in times(r'TelMatch\] finished')), None),
    'first_landing': stamp(landings[0][0]) if landings else None,
    'distinct_landed_units': len({int(re.search(r' id=(\d+)', s)[1]) for _, s in landings}),
    'unit_landfall_events': len(landings),
    'secured_wave_stops': len(times(r'\[AMPH\].* secured')),
    'coastal_guard_phases': len(times(r'\[AMPH\].*hold coastal guard')),
    'retained_guard_groups': len(times(r'\[AMPH\].*guard retained')),
    'first_retained_guard': next((stamp(f) for f in times(r'\[AMPH\].*guard retained')), None),
    'telchine_losses': len(times(r'TelMatch\] lost')),
    'attributed_kills': len(times(r'TelMatch\] kill ')),
    'naval_hit_events': len(times(r'TelMatch\] naval_hit')),
    'pursuit_candidates': len(times('CHASE_CANDIDATE')),
    'last_metrics_before_gameover': [s for _, s in before if '[TelMatch] metrics' in s][-1:],
    'invariant_counts_before_gameover': dict(collections.Counter(
        re.search(r'INV-\d+', s)[0] for _, s in before if '[INVARIANT]' in s)),
    'post_game_events_excluded': sum(f > cutoff for f, _ in events),
    'limitation': 'No naval hits or target encounters means no-pursuit behavior is unexercised, not proven.',
}
text = json.dumps(result, indent=2)
if a.output:
    a.output.write_text(text + '\n', encoding='utf-8')
print(text)
