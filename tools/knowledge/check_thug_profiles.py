"""Audit D-228's opt-in boundary without rewriting JSONC or line endings.

D-430: in the balanced profile the Thug is bound to the ranged controller
preset "thug" (behaviour.json "controllers"), the other experimental profiles
still carry the `ranged` attribute block. Both forms are checked against the
same policy assertions after resolving the preset's "extends" chain.
"""
import re
import subprocess
from pathlib import Path
from check_ranged_profiles import parse, span

ROOT = Path(__file__).resolve().parents[2]
PROFILES = ('experimental_balanced', 'experimental_hard', 'experimental_terrible')
BASE = 'd2d16b4a'  # the branch point of the controller rework
NEUTRAL = ('corthud', 'corstorm', 'controllers', 'formations')


def resolve(presets, name, depth=0):
    assert depth < 8, name
    node = dict(presets[name])
    parent = node.pop('extends', None)
    merged = resolve(presets, parent, depth+1) if parent else {}
    merged.update(node)
    return merged


def neutralize(raw):
    raw = raw.replace(b'\r\n', b'\n')  # Git's configured checkout conversion
    for unit in NEUTRAL:
        bounds = span(raw, unit)
        if bounds: raw = raw[:bounds[0]]+raw[bounds[1]:]
    raw = re.sub(rb'//[^\n]*', b'', raw)          # comments carry no policy
    raw = re.sub(rb',(\s*,)+', b',', raw)          # the removed blocks' trailing commas
    raw = re.sub(rb'\n[ \t]*(?=\n)', b'', raw)     # nor do the blank lines they leave
    return raw


def policy_of(entry, document):
    entry = dict(entry)
    if 'controller' in entry:
        preset = entry.pop('controller')
        policy = resolve(document['controllers']['presets'], preset)
        assert policy.pop('type') == 'ranged', preset
        return entry, policy
    policy = entry.pop('ranged')
    assert entry.pop('attribute') == ['ranged']
    return entry, policy


def main():
    for profile in PROFILES:
        path = ROOT/'data/config'/profile/'behaviour.json'
        raw = path.read_bytes()
        old = subprocess.check_output(['git', '-c', 'safe.directory='+ROOT.as_posix(),
                                       'show', BASE+':'+path.relative_to(ROOT).as_posix()])
        assert neutralize(old) == neutralize(raw), profile+' changed outside the Thug, Aggravator, controller and formation blocks'
        before_doc, after_doc = parse(old), parse(raw)
        before, policy_before = policy_of(before_doc['behaviour']['corthud'], before_doc)
        after, policy = policy_of(after_doc['behaviour']['corthud'], after_doc)
        assert before == after, profile+' changed production/classification'
        assert policy['coordinated'] is True
        assert .5 <= policy['range_fraction'] <= .99
        assert .1 <= policy['reaction_seconds'] <= 5
        assert 1 <= policy['cohort_size'] <= 12
        assert policy['rush_ratio'] > 1 and policy['catch_seconds'] > 0
        assert 0 < policy['engagement_seconds'] <= 30
        assert 1 <= policy['advantage_exit'] <= policy['advantage_enter'] <= 5
        assert 0 < policy['static_loss_fraction'] < policy['loss_fraction'] < .9
        # D-430: the preset form carries the same keys and values as the block it replaced.
        family = policy['formation']['family']
        compared = {k: v for k, v in policy_before.items() if k != 'formation'}
        assert {k: v for k, v in policy.items() if k != 'formation'} == compared, profile+' Thug policy values changed'
        assert policy['formation']['position'] == 'front' and family
        if 'controller' in after_doc['behaviour']['corthud']:
            assert family in after_doc.get('formations', {}), profile+' line template missing'
            assert after_doc['formations'][family]['type'] == 'line'
    for path in (ROOT/'data/config').rglob('behaviour.json'):
        if path.parent.name in PROFILES: continue
        entry = parse(path.read_bytes()).get('behaviour',{}).get('corthud',{})
        assert 'controller' not in entry, str(path)
        assert not entry.get('ranged',{}).get('coordinated',False), str(path)
    print('Thug profiles: exactly three opt-ins (balanced by controller preset); production, other units and legacy profiles unchanged')

if __name__ == '__main__': main()
