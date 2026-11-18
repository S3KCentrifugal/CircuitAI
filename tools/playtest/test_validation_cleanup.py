import json
import gzip
import shutil
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from validation_cleanup import publish_and_prune


class ValidationCleanupTests(unittest.TestCase):
    def test_numeric_failure_preserves_log_even_when_watcher_passed(self):
        with tempfile.TemporaryDirectory() as folder:
            archive = Path(folder) / 'runs' / 'stamp'
            archive.mkdir(parents=True)
            publication = Path(folder) / 'published'
            publication.mkdir()
            (archive / 'result.json').write_text('{"verdict":"PASS"}')
            (archive / 'infolog.txt').write_bytes(b'numerical assertion evidence\n')
            def prune(command, **kwargs):
                with gzip.open(publication / 'infolog.txt.gz', 'rb') as stream:
                    self.assertEqual(stream.read(), b'numerical assertion evidence\n')
            def publish(path):
                shutil.copy2(path / 'infolog.txt.gz', publication)
                return publication
            with patch('validation_cleanup.storage.publish', side_effect=publish), \
                 patch('validation_cleanup.subprocess.run', side_effect=prune):
                publish_and_prune(archive / 'report.md', failed=True)

    def test_failed_log_is_preserved_before_prune(self):
        with tempfile.TemporaryDirectory() as folder:
            archive = Path(folder) / 'runs' / 'stamp'
            archive.mkdir(parents=True)
            publication = Path(folder) / 'published'
            publication.mkdir()
            (archive / 'result.json').write_text('{"verdict":"FAIL"}')
            (archive / 'infolog.txt').write_bytes(b'original failure\n')
            diagnostic = Path(folder) / 'launcher.txt'
            diagnostic.write_bytes(b'original launcher\n')
            def prune(command, **kwargs):
                with gzip.open(publication / 'infolog.txt.gz', 'rb') as stream:
                    self.assertEqual(stream.read(), b'original failure\n')
                with gzip.open(publication / 'launcher.txt.gz', 'rb') as stream:
                    self.assertEqual(stream.read(), b'original launcher\n')
            def publish(path):
                for name in ('infolog.txt.gz', 'launcher.txt.gz'):
                    shutil.copy2(path / name, publication)
                return publication
            with patch('validation_cleanup.storage.publish', side_effect=publish), \
                 patch('validation_cleanup.subprocess.run', side_effect=prune):
                publish_and_prune(archive / 'report.md', diagnostic)

    def test_publishes_before_identity_checked_prune(self):
        with tempfile.TemporaryDirectory() as folder:
            game = Path(folder) / 'game'
            archive = game / 'runs' / 'stamp'
            archive.mkdir(parents=True)
            (archive / 'result.json').write_text(json.dumps({'verdict': 'FAIL'}))
            calls = []
            def publish(path):
                calls.append(('publish', path))
                return 'published-evidence'
            def prune(command, **kwargs):
                calls.append(('prune', command))
            with patch('validation_cleanup.storage.publish', side_effect=publish), \
                 patch('validation_cleanup.subprocess.run', side_effect=prune):
                result = publish_and_prune(archive / 'report.md')
            self.assertEqual(result, 'published-evidence')
            self.assertEqual([c[0] for c in calls], ['publish', 'prune'])
            self.assertEqual(calls[1][1][-2:], ['--path', str(game.resolve())])

    def test_unarchived_report_cannot_trigger_cleanup(self):
        with patch('validation_cleanup.subprocess.run') as run:
            with self.assertRaises(ValueError):
                publish_and_prune(Path(tempfile.gettempdir()) / 'unarchived-report.md')
            run.assert_not_called()

    def test_publication_failure_keeps_raw_evidence(self):
        with tempfile.TemporaryDirectory() as folder:
            archive = Path(folder) / 'runs' / 'stamp'
            archive.mkdir(parents=True)
            (archive / 'result.json').write_text('{}')
            with patch('validation_cleanup.storage.publish', side_effect=RuntimeError('failed')), \
                 patch('validation_cleanup.subprocess.run') as run:
                with self.assertRaises(RuntimeError): publish_and_prune(archive / 'report.md')
                run.assert_not_called()
