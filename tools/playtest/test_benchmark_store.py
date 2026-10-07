"""External evidence ownership, path safety and migration preservation."""
import contextlib
import io
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

import benchmark_store
import migrate_benchmark_repository as migration
import storage
from test_storage import archived_game


class BenchmarkStoreTests(unittest.TestCase):
    def test_environment_override_selects_another_checkout(self):
        with tempfile.TemporaryDirectory() as tmp:
            env = dict(os.environ, CIRCUIT_BENCHMARK_REPO=tmp)
            value = subprocess.check_output(
                [sys.executable, '-c', 'import benchmark_store; print(benchmark_store.EVIDENCE_ROOT)'],
                cwd=Path(__file__).parent, env=env, text=True).strip()
            self.assertEqual(Path(value), Path(tmp).resolve() / 'doc/benchmarks')

    def test_missing_checkout_fails_before_creating_run_directories(self):
        with tempfile.TemporaryDirectory() as tmp:
            external = Path(tmp) / 'missing'
            with patch.object(benchmark_store, 'BENCHMARK_REPO', external), \
                    patch.object(storage, 'RAW_ROOT', external / 'build-theatres'):
                with self.assertRaisesRegex(FileNotFoundError, 'Clone'):
                    storage.allocate('air', 'combat', 'edge', 'glitters', 'supplied')
            self.assertFalse(external.exists())

    def test_default_allocator_uses_external_raw_store(self):
        with tempfile.TemporaryDirectory() as tmp:
            external = Path(tmp)
            (external / 'benchmark-store.json').write_text('{}')
            with patch.object(benchmark_store, 'BENCHMARK_REPO', external), \
                    patch.object(storage, 'RAW_ROOT', external / 'build-theatres'):
                folder = storage.allocate('sea', 'combat', 'subs', 'supreme', 'supplied')
            self.assertTrue(folder.is_relative_to(external / 'build-theatres/games/sea/combat/subs/supreme'))
            self.assertTrue((folder / 'run-plan.json').is_file())

    def test_default_publisher_keeps_failure_in_external_evidence_store(self):
        with tempfile.TemporaryDirectory() as tmp:
            external = Path(tmp) / 'external'
            external.mkdir()
            (external / 'benchmark-store.json').write_text('{}')
            _, archive = archived_game(Path(tmp) / 'fixtures')
            with patch.object(benchmark_store, 'BENCHMARK_REPO', external), \
                    patch.object(storage, 'EVIDENCE_ROOT', external / 'doc/benchmarks'):
                result = storage.publish(archive)
            self.assertTrue(result.is_relative_to(external / 'doc/benchmarks/records'))
            self.assertEqual(storage.read_json(result / 'result.json')['verdict'], 'FAIL')

    def test_historical_evidence_resolves_without_rewriting_old_manifest(self):
        with tempfile.TemporaryDirectory() as tmp, patch.object(benchmark_store, 'BENCHMARK_REPO', Path(tmp)):
            self.assertEqual(benchmark_store.historical_path('doc/benchmarks/tech-rush.md'),
                             Path(tmp) / 'doc/benchmarks/tech-rush.md')

    def test_historical_path_refuses_traversal(self):
        with self.assertRaises(ValueError):
            benchmark_store.historical_path('../outside')


class MigrationTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.source = self.root / 'source'
        self.dest = self.root / 'destination'
        self.manifest = self.root / 'manifest'
        for tree in migration.TREES:
            path = self.source / tree
            path.mkdir(parents=True)
            (path / 'original.txt').write_bytes(b'original\r\nretained bytes\n')
        with contextlib.redirect_stdout(io.StringIO()):
            migration.snapshot(self.source, self.manifest)
        for tree in migration.TREES:
            dest = self.dest / tree
            dest.parent.mkdir(parents=True, exist_ok=True)
            (self.source / tree).rename(dest)

    def test_same_volume_move_preserves_evidence_and_original_directory_identity(self):
        with contextlib.redirect_stdout(io.StringIO()):
            result = migration.verify(self.dest, self.manifest)
        self.assertTrue(result['verified'])

    def test_published_content_change_is_detected_even_with_original_size_and_mtime(self):
        path = self.dest / 'doc/benchmarks/original.txt'
        stat = path.stat()
        path.write_bytes(path.read_bytes().replace(b'original', b'modified'))
        os.utime(path, ns=(stat.st_atime_ns, stat.st_mtime_ns))
        with self.assertRaisesRegex(ValueError, 'differs'):
            migration.verify(self.dest, self.manifest)

    def test_extra_raw_file_is_detected(self):
        (self.dest / 'build-theatres/unrecorded.txt').write_text('unexpected')
        with contextlib.redirect_stdout(io.StringIO()), self.assertRaisesRegex(ValueError, 'differs'):
            migration.verify(self.dest, self.manifest)

    def test_missing_raw_file_is_detected(self):
        (self.dest / 'build-theatres/original.txt').unlink()
        with contextlib.redirect_stdout(io.StringIO()), self.assertRaisesRegex(ValueError, 'Missing'):
            migration.verify(self.dest, self.manifest)


if __name__ == '__main__':
    unittest.main()
