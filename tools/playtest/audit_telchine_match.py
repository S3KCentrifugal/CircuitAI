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
for line in a.log.open(encoding='utf-8', errors='replace'):
    frame = re.search(r'\[f=(-?\d+)\]', line)
    if not frame:
        continue
    f = int(frame[1])
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
    'cutoff_time': stamp(cutoff),
    'telchines_completed': len(times(r'TelMatch\] finished')),
    'first_completed': next((stamp(f) for f in times(r'TelMatch\] finished')), None),
    'first_landing': stamp(landings[0][0]) if landings else None,
    'distinct_landed_units': len({int(re.search(r' id=(\d+)', s)[1]) for _, s in landings}),
    'unit_landfall_events': len(landings),
    'secured_wave_stops': len(times(r'\[AMPH\].* secured')),
    'coastal_guard_phases': len(times(r'\[AMPH\].*hold coastal guard')),
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
