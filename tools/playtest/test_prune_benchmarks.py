import tempfile
import unittest
from unittest.mock import patch
from pathlib import Path
import prune_benchmarks as p


class KeepTests(unittest.TestCase):
    def test_unretained_source_snapshot_config_is_input_not_result(self):
        self.assertFalse(p.keep_file(Path('session/source/data/config/behaviour.json'),65536))

    def test_exact_files_and_directories_are_not_deletion_candidates(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve()
            (root/'pin').mkdir()
            for name in ('pin/SkirmishAI.dll','pin/SkirmishAI.dbg.zip','pin/unwanted.obj'):
                (root/name).write_bytes(b'evidence')
            (root/'source').mkdir();(root/'source/file.cpp').write_text('source')
            kept=[root/'pin/SkirmishAI.dll',root/'pin/SkirmishAI.dbg.zip',root/'source']
            candidates=[x[0] for x in p.walk(root,kept)]
            self.assertEqual(candidates,[root/'pin/unwanted.obj'])

    def test_similar_prefix_is_not_retained(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve()
            (root/'keep').write_bytes(b'1');(root/'keep-other').write_bytes(b'2')
            self.assertEqual([x[0] for x in p.walk(root,[root/'keep'])],[root/'keep-other'])

    def test_apply_keeps_named_binary_and_archive(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();pin=root/'pin';pin.mkdir()
            dll=pin/'SkirmishAI.dll';archive=pin/'SkirmishAI.dbg.zip';obj=pin/'obsolete.obj'
            for item in (dll,archive,obj):item.write_bytes(b'unchanged')
            with patch.object(p.benchmark_store,'require_checkout',return_value=root), \
                 patch.object(p,'ignored_tops',return_value=[root]), \
                 patch.object(p,'engines_in',return_value=[]), \
                 patch('sys.argv',['prune','--apply','--keep',str(dll),'--keep',str(archive)]):
                self.assertEqual(p.main(),0)
            self.assertEqual(dll.read_bytes(),b'unchanged')
            self.assertEqual(archive.read_bytes(),b'unchanged')
            self.assertFalse(obj.exists())


if __name__=='__main__':unittest.main()
