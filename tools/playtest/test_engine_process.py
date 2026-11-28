import os
from pathlib import Path
import subprocess
import sys
import unittest

from engine_process import EngineProcess, attach


@unittest.skipUnless(os.name == 'nt', 'Windows kernel handle supervision')
class EngineProcessTest(unittest.TestCase):
    def test_stop_can_reattach_after_child_exit_with_original_handle_open(self):
        with subprocess.Popen([sys.executable, '-c', 'import time; time.sleep(30)']) as child:
            process = EngineProcess(child.pid)
            try:
                record = process.identity(Path.cwd())
                process.terminate()
                child.wait(timeout=5)
                # Both Popen and process retain handles to the exited kernel
                # object, just as the arena launcher does during final cleanup.
                self.assertIsNone(attach(record, Path.cwd()))
            finally:
                process.close()

    def test_live_identity_mismatch_still_refuses_access(self):
        with subprocess.Popen([sys.executable, '-c', 'import time; time.sleep(30)']) as child:
            process = EngineProcess(child.pid)
            try:
                record = process.identity(Path.cwd())
                record['created'] += 1
                with self.assertRaisesRegex(RuntimeError, 'identity changed'):
                    attach(record, Path.cwd())
                self.assertTrue(process.alive())
            finally:
                process.terminate()
                process.close()
                child.wait(timeout=5)


if __name__ == '__main__':
    unittest.main()
