import tempfile
import unittest
from pathlib import Path

from run_front_layout import select_fixture_role


class FactoryLayoutFixtureTests(unittest.TestCase):
    def test_role_is_set_before_native_role_configuration(self):
        for role in ('FRONT', 'TACTICAL'):
            with self.subTest(role=role), tempfile.TemporaryDirectory() as directory:
                source = Path(directory)
                setup = source/'setup.as'
                setup.write_text('before;\nGlobal::AISettings::Role = derivedRole;\nafter;')
                select_fixture_role(source, role)
                self.assertEqual(setup.read_text(),
                    f'before;\nderivedRole = AiRole::{role};\n\t\tGlobal::AISettings::Role = derivedRole;\nafter;')

    def test_drift_does_not_modify_staged_setup(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory)
            setup = source/'setup.as'
            setup.write_text('changed setup')
            with self.assertRaises(ValueError):
                select_fixture_role(source, 'TACTICAL')
            self.assertEqual(setup.read_text(), 'changed setup')

    def test_unknown_role_is_rejected(self):
        with self.assertRaises(ValueError):
            select_fixture_role(Path('unused'), 'TECH')
