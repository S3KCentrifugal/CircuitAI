"""Publish completed validation evidence before pruning its owned raw game."""
from pathlib import Path
import gzip
import json
import shutil
import subprocess
import sys

import storage


def publish_and_prune(report, diagnostic=None, *, failed=False):
    archive = Path(report).resolve().parent
    if archive.parent.name != 'runs' or not (archive / 'result.json').is_file():
        raise ValueError('Expected an archived game report with result.json')
    logs = []
    # Numerical arena assertions can fail after the watcher's pattern PASS.
    if failed or json.loads((archive / 'result.json').read_text()).get('verdict') == 'FAIL':
        logs.append(archive / 'infolog.txt')
    if diagnostic:
        logs.append(Path(diagnostic))
    for log in logs:
        if log.is_file():
            # Preserve original failures and launcher transcripts, compressed;
            # the original result retains the infolog's uncompressed hash.
            # Compress before publication so the immutable manifest covers the
            # diagnostic. Deterministic headers make a retry byte-identical.
            with log.open('rb') as source, (archive / (log.name + '.gz')).open('wb') as packed:
                with gzip.GzipFile(filename='', mode='wb', fileobj=packed, mtime=0) as destination:
                    shutil.copyfileobj(source, destination)
    publication = storage.publish(archive)
    # The standard pruner validates benchmark boundaries and refuses an active
    # engine. Call only after numeric scoring/telemetry extraction has finished.
    subprocess.run([sys.executable, str(Path(__file__).with_name('prune_benchmarks.py')),
                    '--apply', '--path', str(archive.parent.parent)], check=True,
                   stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return str(publication)
