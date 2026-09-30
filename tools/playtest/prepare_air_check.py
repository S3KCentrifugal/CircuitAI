"""Prepare isolated AIR fixtures after playtest.py stage; never edits production data."""
import argparse
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dir', type=Path, required=True)
    parser.add_argument('--scenario', choices=['natural', 'constructor', 'transport', 'capacity', 'loss', 'windloss', 'switch', 'attack', 'legacy'], default='natural')
    parser.add_argument('--seed', type=int, default=930146)
    args = parser.parse_args()
    base = args.dir.resolve()
    if not base.is_relative_to((ROOT / 'build-theatres').resolve()):
        parser.error('fixture directory must be under repository build-theatres')
    script = base / 'script.txt'
    text = script.read_text()
    text = re.sub(r'\bFixedRNGSeed\s*=\s*\d+;', '', text, flags=re.I)
    text = text.replace('[GAME]\n{', '[GAME]\n{\n\tFixedRNGSeed=' + str(args.seed) + ';', 1)
    if 'FixedRNGSeed=' not in text:
        text = re.sub(r'(\[GAME\]\s*\{)', r'\1\n FixedRNGSeed=' + str(args.seed) + ';', text, count=1, flags=re.I)
    script.write_text(text)
    config = {'scenario': args.scenario, 'seed': args.seed}
    (base / 'air-fixture.json').write_text(json.dumps(config, indent=2))
    widgets = base / 'LuaUI/Widgets'
    if args.scenario not in ['natural', 'legacy']:
        (widgets / 'air_fixture.lua').write_text('local scenario = ' + json.dumps(args.scenario) + '\n' + (ROOT / 'tools/playtest/widgets/air_fixture.lua').read_text())
    if args.scenario == 'legacy':
        path = base / 'AI/Skirmish/BARbTest/test/script/src/global.as'
        source = path.read_text()
        before, marker, after = source.partition('namespace Air {')
        if not marker or 'bool ExperimentalBuild = true;' not in after:
            parser.error('staged AIR flag not found')
        path.write_text(before + marker + after.replace('bool ExperimentalBuild = true;', 'bool ExperimentalBuild = false;', 1))
    if args.scenario == 'transport':
        # Real allied-message protocol; two roles request together, one duplicate.
        staged = base / 'AI/Skirmish/BARbTest/test/script'
        for profile in ['experimental_balanced', 'experimental_hard', 'experimental_terrible']:
            path = staged / profile / 'main.as'
            source = path.read_text()
            source = source.replace('ArtilleryPolicy::Check();', '''ArtilleryPolicy::Check();
        if (!airProbeRequested && ai.teamId != 0 && ai.frame >= 1800 && ai.frame < 1900) {
            airProbeRequested = true;
            Team::Ferry::RequestTransport("AIR fixture: any allied role");
            AiSendMessage("barbferry|req|" + int(Global::Map::StartPos.x) + "|" + int(Global::Map::StartPos.z));
        }''')
            source += '\nnamespace Main { bool airProbeRequested = false; }\n'
            path.write_text(source)
    print('AIR fixture:', args.scenario, 'seed', args.seed, base)

if __name__ == '__main__':
    main()
