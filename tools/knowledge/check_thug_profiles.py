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
NEUTRAL = ('corthud', 'corstorm', 'armham', 'armrock', 'controllers', 'formations')  # D-432: Mace and Rocketeer presets
# D-433 (thug-micro-fixes-proposal.md): the micro levers the balanced presets add
# on top of the D-430 block. Parity with the branch point is checked without them.
MICRO_KEYS = ('threat_weight', 'overkill_skip', 'retreat_health', 'retreat_veteran_bonus', 'repair_health', 'repair_radius',
              'repair_cooldown_seconds', 'height_weight', 'ramp_height', 'ramp_penalty')


def without_micro(policy):
    return {k: v for k, v in policy.items() if k != 'formation' and k not in MICRO_KEYS}


def check_micro(policy, name):
    assert 0 <= policy['threat_weight'] <= 5 and policy['overkill_skip'] is True, name
    assert .2 <= policy['retreat_health'] <= .6 and 0 <= policy['retreat_veteran_bonus'] <= .5, name
    assert policy['retreat_health'] < policy['repair_health'] <= 1 and policy['repair_radius'] > 0 and policy['repair_cooldown_seconds'] > 0, name
    assert policy['height_weight'] >= 0 and policy['ramp_height'] > 0 and 0 <= policy['ramp_penalty'] <= 3, name


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
        assert policy.pop('type') in ('skirmisher', 'backline'), preset  # D-432: typed by job
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
        compared = without_micro(policy_before)
        assert without_micro(policy) == compared, profile+' Thug policy values changed'
        assert policy['formation']['position'] == 'front' and family
        if 'controller' in after_doc['behaviour']['corthud']:
            check_micro(policy, profile+' Thug')  # D-433: the skirmisher preset carries the micro levers
            assert family in after_doc.get('formations', {}), profile+' line template missing'
            assert after_doc['formations'][family]['type'] == 'line'
            # D-432: Mace on the skirmisher preset carries the attribute block's values;
            # the Aggravator and the Rocketeer are backline presets without sustained rush.
            mace_before, mace_policy_before = policy_of(before_doc['behaviour']['armham'], before_doc)
            mace_after, mace_policy = policy_of(after_doc['behaviour']['armham'], after_doc)
            assert mace_before == mace_after, profile+' Mace production/classification changed'
            assert without_micro(mace_policy) == without_micro(mace_policy_before), profile+' Mace policy values changed'
            assert mace_policy['formation'] == mace_policy_before['formation'] and mace_policy['formation']['family'] in after_doc['formations']
            check_micro(mace_policy, profile+' Mace')
            for unit in ('corstorm', 'armrock'):
                presets = after_doc['controllers']['presets']
                preset = after_doc['behaviour'][unit]['controller']
                rear = resolve(presets, preset)
                assert rear['type'] == 'backline' and rear['formation']['position'] == 'rear', unit
                assert 'sustained_rush' not in rear and 'poke_in' not in rear and 'commander_focus' not in rear, unit
                assert rear['formation']['family'] in after_doc['formations'], unit
                assert 0 < rear['static_loss_fraction'] < rear['loss_fraction'] < .9 and rear['leak_radius'] > 0, unit
                # D-433: the backline contribution fixes and the shared micro levers.
                check_micro(rear, unit)
                assert rear['fire_at_will'] is True and rear['splash_veto_health'] > 0 and rear['station_slack'] >= 0, unit
                assert rear['no_screen'] in (0, 1, 2) and rear['no_screen_seconds'] >= 0, unit
    for path in (ROOT/'data/config').rglob('behaviour.json'):
        if path.parent.name in PROFILES: continue
        entry = parse(path.read_bytes()).get('behaviour',{}).get('corthud',{})
        assert 'controller' not in entry, str(path)
        assert not entry.get('ranged',{}).get('coordinated',False), str(path)
    print('Thug profiles: exactly three opt-ins (balanced by controller preset); production, other units and legacy profiles unchanged')

if __name__ == '__main__': main()
