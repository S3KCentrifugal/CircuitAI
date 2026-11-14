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
# The smrt-test commit the branch last merged (D-498, merge 3732edc3): every
# change outside the Thug, Aggravator, controller and formation blocks since
# then must be smrt-test's. Was d2d16b4a, the branch point, before the merge.
BASE = '0ce991c0'
NEUTRAL = ('corthud', 'corstorm', 'armham', 'armrock', 'controllers', 'formations',  # D-432: Mace and Rocketeer presets
           'armjeth', 'corcrash',  # D-509: the T1 anti-air bots ride as battle group escorts
           'armrectr', 'cornecro')  # D-514: the resurrection bots serve as the battle group's repair crew
# D-433 (thug-micro-fixes-proposal.md): the micro levers the balanced presets add
# on top of the D-430 block. Parity with the branch point is checked without them.
MICRO_KEYS = ('threat_weight', 'overkill_skip', 'retreat_health', 'retreat_veteran_bonus', 'repair_health', 'repair_radius',
              'repair_cooldown_seconds', 'height_weight', 'ramp_height', 'ramp_penalty',
              'static_support_loss_fraction',  # D-499
              'cohort_size', 'row_width', 'row_depth', 'direct_slots',  # D-501: the group layout levers
              'screen_retreat_delay', 'retreat_behind_support',  # D-502: the rockets lead a retreat
              'support_members', 'slot_hold_distance',  # D-503: join the vanguard's fight, keep rows
              'jammer_hold', 'siege_standoff', 'sustained_rush_static_weight',  # D-505, D-507
              'rush_kite', 'rush_range_margin', 'rush_closing_speed', 'rush_detect_radius', 'rush_min_count',  # D-510
              'rush_value_share', 'rush_hold_seconds', 'rush_help_slack', 'retreat_to_help', 'help_radius', 'help_ratio',
              'help_static_weight', 'help_cone', 'help_lane_step', 'escape_help_weight',
              'momentum_press', 'momentum_caution', 'momentum_push', 'momentum_fall_back', 'push_step',  # D-512
              'fall_back_distance', 'rush_hold_loss', 'rush_gather')  # D-513


# D-500: the formation families the base still names by their old (line) names.
RENAMED_FAMILIES = {'t1_cortex_line': 't1_cortex_group', 't1_bot_line': 't1_bot_group'}
def renamed(formation):
    out = dict(formation)
    if out.get('family') in RENAMED_FAMILIES: out['family'] = RENAMED_FAMILIES[out['family']]
    return out
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
        assert policy.pop('type') in ('skirmisher', 'support'), preset  # D-432: typed by job
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
        assert 1 <= policy['cohort_size'] <= (32 if 'controller' in after_doc['behaviour']['corthud'] else 12)  # D-501: the native cap
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
            # D-499: beside its rockets the screen spends more under porc, never past the mobile budget's bound
            assert policy['static_loss_fraction'] <= policy.get('static_support_loss_fraction', 0) < .9, profile+' Thug static support'
            assert family in after_doc.get('formations', {}), profile+' line template missing'
            assert after_doc['formations'][family]['type'] == 'battle_group'  # D-500: was 'line'
            # D-501: group size and ranks
            template = after_doc['formations'][family]
            assert 1 <= template['size_min'] <= template['size_target'] <= template['size_max'] <= 32, profile+' group size'
            assert template['split_link'] >= 0 and template['recruit_seconds'] > 0, profile+' group cohesion'
            assert set(template.get('ranks', {})) <= {'screen', 'support', 'air', 'repair'}, profile+' ranks'  # D-509, D-514
            air = template.get('ranks', {}).get('air')
            if air:  # D-509: escort types by unit, a per-screen share and a cap within the group
                assert air.get('units') and 0 < air.get('per_screen', 0) <= 1 and 1 <= air.get('max', 0) <= 32, profile+' air rank'
            repair = template.get('ranks', {}).get('repair')
            if repair:  # D-514: crew types by unit, one per per_units members, a cap within the group
                assert repair.get('units') and 1 <= repair.get('per_units', 0) <= 100 and 1 <= repair.get('max', 0) <= 32, profile+' repair rank'
                assert 0 < template['repair_trip_health'] < template['repair_trip_done'] <= 1, profile+' repair trip'
            assert template['size_max'] <= policy['cohort_size'] or policy['cohort_size'] >= template['size_target'], profile+' cohort bound'
            # D-432: Mace on the skirmisher preset carries the attribute block's values;
            # the Aggravator and the Rocketeer are support presets without sustained rush.
            mace_before, mace_policy_before = policy_of(before_doc['behaviour']['armham'], before_doc)
            mace_after, mace_policy = policy_of(after_doc['behaviour']['armham'], after_doc)
            assert mace_before == mace_after, profile+' Mace production/classification changed'
            assert without_micro(mace_policy) == without_micro(mace_policy_before), profile+' Mace policy values changed'
            assert mace_policy['formation'] == renamed(mace_policy_before['formation']) and mace_policy['formation']['family'] in after_doc['formations']
            check_micro(mace_policy, profile+' Mace')
            for unit in ('corstorm', 'armrock'):
                presets = after_doc['controllers']['presets']
                preset = after_doc['behaviour'][unit]['controller']
                rear = resolve(presets, preset)
                assert rear['type'] == 'support' and rear['formation']['position'] == 'rear', unit
                assert 'sustained_rush' not in rear and 'poke_in' not in rear and 'commander_focus' not in rear, unit
                assert rear['formation']['family'] in after_doc['formations'], unit
                assert 0 < rear['static_loss_fraction'] < rear['loss_fraction'] < .9 and rear['leak_radius'] > 0, unit
                # D-433: the support contribution fixes and the shared micro levers.
                check_micro(rear, unit)
                assert rear['fire_at_will'] is True and rear['splash_veto_health'] > 0 and rear['station_slack'] >= 0, unit
                assert rear['no_screen'] in (0, 1, 2) and rear['no_screen_seconds'] >= 0, unit
                # D-499: shoot the screen's target, shielded by the screen, siege, follow its assault, seek a screen
                assert rear['screen_target_bonus'] >= 1 and rear['screen_shield'] in (0, 1) and rear['siege'] in (0, 1), unit
                assert 0 <= rear['siege_margin'] <= 64 and 0 <= rear['siege_slack'] <= 64, unit
                assert rear['follow_screen_assault'] in (0, 1) and rear['pair_seek_radius'] >= rear['cohort_radius'], unit
    for path in (ROOT/'data/config').rglob('behaviour.json'):
        if path.parent.name in PROFILES: continue
        entry = parse(path.read_bytes()).get('behaviour',{}).get('corthud',{})
        assert 'controller' not in entry, str(path)
        assert not entry.get('ranged',{}).get('coordinated',False), str(path)
    print('Thug profiles: exactly three opt-ins (balanced by controller preset); production, other units and legacy profiles unchanged')

if __name__ == '__main__': main()
