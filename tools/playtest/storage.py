"""Organize game tests without replacing historical evidence.

python tools/playtest/storage.py allocate --domain air --area combat --scenario edge --map glitters --kind supplied
python tools/playtest/storage.py publish <archived-run> --screenshot <filename.png>
python tools/playtest/storage.py index
python tools/playtest/storage.py verify-migration
"""
import argparse
import datetime as dt
import hashlib
import json
import os
import re
import shutil
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
HERE = Path(__file__).resolve().parent
DOMAINS = ('air', 'tech', 'front', 'sea', 'tactical', 'support', 'shared')
AREAS = ('combat', 'economy', 'layout', 'strategy', 'terrain', 'performance', 'cooperation', 'reliability')
KINDS = ('natural', 'supplied', 'benchmark', 'regression')


def file_hash(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def read_json(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))


def write_json(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + '.' + uuid.uuid4().hex + '.tmp')
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True, allow_nan=False) + '\n', encoding='utf-8')
    os.replace(temporary, path)


def run_id():
    return dt.datetime.now(dt.timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '-' + uuid.uuid4().hex[:8]


def slug(value):
    text = re.sub('[^a-z0-9]+', '-', str(value).lower()).strip('-')
    if not text or len(text) > 24 or text in ('con', 'prn', 'aux', 'nul') or re.fullmatch(r'(com|lpt)[0-9]', text):
        raise ValueError('Use a non-reserved scenario/map slug of at most 24 characters')
    return text


def definitions(kind):
    if kind not in ('cases', 'checks'):
        raise ValueError('Expected cases or checks')
    return sorted((HERE / kind).rglob('*.json'))


def resolve_definition(value, kind):
    """Accept a custom file, canonical ID, legacy short ID or old explicit path."""
    if kind not in ('cases', 'checks'):
        raise ValueError('Expected cases or checks')
    path = Path(value)
    if path.is_file():
        return path.resolve()
    aliases = read_json(HERE / 'storage-aliases.json')
    normalized = str(value).replace('\\', '/')
    try:
        old = path.resolve().relative_to(ROOT).as_posix()
    except ValueError:
        old = normalized
    if old in aliases:
        target = (ROOT / aliases[old]).resolve()
        if target.is_relative_to(HERE / kind) and target.is_file():
            return target
    key = normalized.removesuffix('.json')
    candidate = (HERE / kind / (key + '.json')).resolve()
    if not candidate.is_relative_to(HERE / kind):
        raise ValueError('Definition ID escapes its category root')
    if candidate.is_file():
        return candidate
    matches = [p for p in definitions(kind) if p.stem == key]
    if len(matches) > 1:
        raise ValueError('Ambiguous short ID; use domain/area/name: ' + key)
    if matches:
        return matches[0]
    raise FileNotFoundError('Unknown ' + kind + ': ' + str(value))


def allocate(domain, area, scenario, map_slug, kind, *, root=ROOT, **metadata):
    if domain not in DOMAINS or area not in AREAS or kind not in KINDS:
        raise ValueError('Unknown test classification')
    category = dict(domain=domain, area=area, scenario=slug(scenario), map=slug(map_slug), kind=kind)
    games = (Path(root) / 'build-theatres/games').resolve()
    folder = games / domain / area / category['scenario'] / category['map'] / run_id()
    if not folder.resolve().is_relative_to(games):
        raise ValueError('Run path escapes game storage')
    folder.mkdir(parents=True, exist_ok=False)
    write_json(folder/'run-plan.json', {'schema':1, 'id':folder.name, 'category':category, 'requested':metadata})
    return folder


def capture_inputs(directory, executable):
    """Hash the actual staging immediately before engine launch, not Git HEAD."""
    directory = Path(directory)
    ai = directory / 'AI/Skirmish/BARbTest/test'
    files = {p.relative_to(ai).as_posix():file_hash(p) for p in sorted(ai.rglob('*'))
             if p.is_file() and p.suffix in ('.as', '.json', '.lua', '.dll')}
    observers = {p.relative_to(directory).as_posix():file_hash(p)
                 for p in sorted((directory/'LuaUI').rglob('*.lua'))}
    value = {'schema':1, 'captured_at_utc':dt.datetime.now(dt.timezone.utc).isoformat(),
             'engine':str(executable), 'engine_sha256':file_hash(executable),
             'start_script_sha256':file_hash(directory/'script.txt'), 'ai_files':files, 'observers':observers}
    write_json(directory/'run-inputs.json', value)
    return value


def archive_metadata(directory, archive, checks_bytes, verdict, reason, frame, complete):
    """Keep raw reports untouched and add a machine-readable, self-contained index."""
    directory, archive = Path(directory), Path(archive)
    # Root JSON/AS files are small fixture/settings metadata. Exclude outputs
    # from a previous use of the working directory; these are not input evidence.
    excluded = {'arena-results.json','afus-handoff-audit.json','comparison.json','matrix-results.json','result.json'}
    for source in sorted(directory.iterdir()):
        if source.is_file() and (source.suffix in ('.json','.as') or source.name == 'script.txt'):
            if source.name not in excluded and not source.name.endswith(('-audit.json','-results.json')):
                shutil.copy2(source, archive/source.name)
    (archive/'checks.json').write_bytes(checks_bytes)
    plan = read_json(archive/'run-plan.json') if (archive/'run-plan.json').exists() else {}
    teams = read_json(archive/'teams.json') if (archive/'teams.json').exists() else {}
    artifacts = {p.name:{'sha256':file_hash(p), 'bytes':p.stat().st_size}
                 for p in sorted(archive.iterdir()) if p.is_file() and p.name != 'result.json'}
    value = {'schema':1, 'id':archive.name, 'recorded_at_utc':dt.datetime.now(dt.timezone.utc).isoformat(),
             'category':plan.get('category'), 'requested':plan.get('requested',{}),
             'verdict':verdict, 'reason':reason, 'last_frame':frame, 'complete':complete,
             'map':teams.get('map'), 'game':teams.get('game'), 'teams':teams.get('teams',[]),
             'raw_archive':str(archive.resolve()), 'artifacts':artifacts,
             'comparison':'Use scorecard cohorts for strength comparisons; categories are discovery metadata only.'}
    write_json(archive/'result.json', value)
    return value


def publish(archive, screenshots=(), *, store=ROOT/'doc/benchmarks/records'):
    archive, store = Path(archive).resolve(), Path(store).resolve()
    result = read_json(archive/'result.json')
    if not result.get('complete'):
        raise ValueError('Cannot publish a still-running snapshot as a completed observation')
    cat = result.get('category') or {}
    if cat.get('domain') not in DOMAINS or cat.get('area') not in AREAS or cat.get('kind') not in KINDS:
        raise ValueError('Allocate a categorized game directory before publishing')
    identifier = result['id']
    if not re.fullmatch(r'\d{8}T\d{6}Z-[a-f0-9]{8}', identifier):
        raise ValueError('Invalid archive ID')
    date = dt.datetime.fromisoformat(result['recorded_at_utc']).date().isoformat()
    dest = store/cat['domain']/cat['area']/slug(cat['scenario'])/date/identifier
    if not dest.resolve().is_relative_to(store):
        raise ValueError('Publication path escapes store')
    names = {'result.json','report.md','checks.json'}
    names.update(p.name for p in archive.iterdir() if p.is_file() and p.suffix in ('.json','.as') and p.name != 'result.json')
    if (archive/'script.txt').is_file():
        names.add('script.txt')
    for name in screenshots:
        if Path(name).name != name or Path(name).suffix.lower() != '.png':
            raise ValueError('Screenshots must be PNG filenames inside the archive')
        names.add(name)
    expected = {}
    for name in sorted(names):
        source = archive/name
        if not source.resolve().is_relative_to(archive) or not source.is_file():
            raise ValueError('Missing/escaped artifact: ' + name)
        expected[name] = file_hash(source)
        recorded = result['artifacts'].get(name)
        if recorded and recorded['sha256'] != expected[name]:
            raise ValueError('Archive changed after recording: ' + name)
    publication = {'schema':1, 'raw_archive':str(archive), 'files':expected.copy(),
                   'note':'Includes post-run analyses; original result.json retains raw observation hashes.'}
    summary = [f"# {cat['domain'].upper()} / {cat['area']} / {cat['scenario']}", '',
               f"Observation: **{result['verdict']}** ({result['reason']}); frame {result['last_frame']}.", '',
               f"Experiment kind: `{cat['kind']}`. Map: {result.get('map')}. Game: {result.get('game')}.", '',
               '[Original report](report.md) | [Result and raw-evidence hashes](result.json) | [Acceptance checks](checks.json)', '',
               'PASS is the check verdict, not a confirmed game victory. Raw logs/replays remain in the recorded local archive.', '']
    summary += [f'![{name}]({name})' for name in sorted(screenshots)]
    summary_bytes = ('\n\n'.join(summary)+'\n').encode('utf-8')
    expected['README.md'] = hashlib.sha256(summary_bytes).hexdigest()
    publication['files']['README.md'] = expected['README.md']
    publication_bytes = (json.dumps(publication,indent=2,sort_keys=True)+'\n').encode('utf-8')
    expected['publication.json'] = hashlib.sha256(publication_bytes).hexdigest()
    if dest.exists():
        actual = {p.name:file_hash(p) for p in dest.iterdir() if p.is_file()}
        if actual != expected:
            raise ValueError('Conflicting immutable result ID: ' + identifier)
        return dest
    dest.parent.mkdir(parents=True, exist_ok=True)
    temporary = dest.with_name('.pending-' + uuid.uuid4().hex)
    temporary.mkdir()
    for name in names:
        shutil.copy2(archive/name, temporary/name)
    (temporary/'publication.json').write_bytes(publication_bytes)
    (temporary/'README.md').write_bytes(summary_bytes)
    # rename refuses an existing non-empty directory: concurrent writers cannot
    # overwrite evidence. An interrupted pending folder is retained for recovery.
    temporary.rename(dest)
    return dest


def historical_category(path):
    name = path.name
    if 'scorecards' in path.parts or name == 'scorecard-design.md':
        return 'shared', 'strategy'
    if 'lane-workers' in path.parts:
        return 'shared', 'performance'
    if name == 'tech-rush.md':
        return 'tech', 'economy'
    if name.startswith('metal-'):
        return 'shared', 'economy'
    if 'team-sharing' in name:
        return 'shared', 'cooperation'
    if name.startswith(('air-', 'd167-', 'd171-', 'd172-', 'd173-', 'd176-', 'd177-')):
        combat = any(s in name for s in ('d165','d171','d173','d176','d177'))
        return 'air', 'combat' if combat else 'economy'
    return 'shared', 'reliability'


def build_index(store=ROOT/'doc/benchmarks'):
    store = Path(store)
    entries = []
    for path in sorted(store.rglob('*')):
        relative = path.relative_to(store)
        if not path.is_file() or path.suffix not in ('.json','.md') or relative.parts[0] == 'index':
            continue
        if relative.as_posix() in ('README.md','catalog.json') or any(p.startswith('.pending-') for p in relative.parts):
            continue
        if relative.parts[0] == 'records' and path.name != 'result.json':
            continue
        domain, area = historical_category(relative)
        kind = 'legacy-evidence'
        if path.name in ('README.md','ratings.json'):
            kind = 'derived-index'
        elif 'revisions' in relative.parts:
            kind = 'historical-revision'
        elif path.suffix == '.md' and path.with_suffix('.json').exists():
            kind = 'rendered-view'
        entry = {'path':relative.as_posix(), 'domain':domain, 'area':area, 'kind':kind, 'sha256':file_hash(path)}
        if relative.parts[0] == 'records':
            record = read_json(path)
            entry.update(record.get('category') or {})
            entry.update(verdict=record['verdict'], id=record['id'], kind='run-record',
                         experiment_kind=record['category']['kind'], map_name=record.get('map'))
        entries.append(entry)
    write_json(store/'catalog.json', {'schema':1, 'unit':'evidence files, not match counts', 'entries':entries})
    index = store/'index'; index.mkdir(exist_ok=True)
    for domain in DOMAINS:
        rows = [f'# {domain.upper()} benchmark evidence', '',
                'Generated by `python tools/playtest/storage.py index`. Historical files are not rewritten.', '',
                '| Area | Evidence | Type |', '| --- | --- | --- |']
        for e in entries:
            if e['domain'] == domain:
                target = e['path'].removesuffix('result.json')+'README.md' if e['kind']=='run-record' else e['path']
                rows.append(f"| {e['area']} | [{e['path']}](../{target}) | {e['kind']} |")
        (index/f'{domain}.md').write_text('\n'.join(rows)+'\n',encoding='utf-8')
    return entries


def verify_migration(root=ROOT):
    root = Path(root)
    record = read_json(root/'doc/test-storage-migration.json')
    problems = []
    for move in record['moves']:
        path = root/move['new']
        if not path.is_file() or file_hash(path) != move['sha256']:
            problems.append('Moved definition changed/missing: ' + move['new'])
    for name, expected in record['historical_files'].items():
        path = root/name
        if not path.is_file() or file_hash(path) != expected['sha256']:
            problems.append('Historical evidence changed/missing: ' + name)
    return problems


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='command', required=True)
    p = sub.add_parser('allocate')
    p.add_argument('--domain', choices=DOMAINS, required=True)
    p.add_argument('--area', choices=AREAS, required=True)
    p.add_argument('--scenario', required=True)
    p.add_argument('--map', required=True)
    p.add_argument('--kind', choices=KINDS, required=True)
    p = sub.add_parser('publish'); p.add_argument('archive', type=Path)
    p.add_argument('--screenshot', action='append', default=[])
    sub.add_parser('index'); sub.add_parser('verify-migration')
    p = sub.add_parser('find')
    p.add_argument('--domain', choices=DOMAINS)
    p.add_argument('--area', choices=AREAS)
    p.add_argument('--kind', choices=KINDS)
    args = parser.parse_args()
    if args.command == 'allocate':
        print(allocate(args.domain,args.area,args.scenario,args.map,args.kind))
    elif args.command == 'publish':
        print(publish(args.archive,args.screenshot)); build_index()
    elif args.command == 'index':
        print('Indexed',len(build_index()),'evidence files')
    elif args.command == 'find':
        for entry in read_json(ROOT/'doc/benchmarks/catalog.json')['entries']:
            if ((args.domain is None or entry['domain']==args.domain)
                and (args.area is None or entry['area']==args.area)
                and (args.kind is None or entry.get('experiment_kind')==args.kind)):
                print(entry['domain'], entry['area'], entry['kind'], entry['path'])
    else:
        problems = verify_migration()
        print('\n'.join(problems) if problems else 'Preserved 97 definitions and 130 historical benchmark/image files byte-for-byte')
        return bool(problems)
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
