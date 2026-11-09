import unittest
from pathlib import Path
from lupa import LuaRuntime
from ranged_arena import group_fixture_policy,defense_fixture_policy
class GroupFixturePolicyTest(unittest.TestCase):
    def test_defense_override_uses_registered_api_and_rejects_code(self):
        self.assertIn('SetDefenseRule(3,"heavy",1.0f)',defense_fixture_policy([dict(slot=3,key='heavy',value=1)]))
        with self.assertRaises(ValueError):defense_fixture_policy([dict(slot=24,key='heavy',value=1)])
        with self.assertRaises(ValueError):defense_fixture_policy([dict(slot=3,key='x\");evil',value=1)])
        with self.assertRaises(ValueError):defense_fixture_policy([dict(slot=3,key='heavy',value=float('nan'))])
    def test_preserves_comments_and_other_settings(self):
        source='// comment\n{"commander_group_income":20,"other":5}'
        self.assertEqual(group_fixture_policy(source,{"commander_group_income":0}),source.replace(':20',':0'))
    def test_rejects_undeclared_non_numeric_and_non_group_keys(self):
        for key,value in [('other',1),('commander_group_missing',1),('commander_group_income','1'),('commander_group_income',float('nan'))]:
            with self.assertRaises(ValueError):group_fixture_policy('{"commander_group_income":20}',{key:value})

class RelativeWaveGroundTest(unittest.TestCase):
    def setUp(self):
        self.lua=LuaRuntime(unpack_returned_tuples=True)
        self.lua.execute('''
            widget={};VFS={Include=function() return {} end}
            UnitDefNames={pawn={id=1}}
            UnitDefs={[1]={canMove=true,speed=1}}
            Spring={GetGroundHeight=function(x,z) return math.abs(x-350)<32 and 128 or 0 end,
                TestMoveOrder=function(id,x,y,z) return y==0 end,
                GetGameFrame=function() return 0 end,Echo=function() end}
        ''')
        source=(Path(__file__).parent/'widgets/ranged_arena.lua').read_text()
        self.site=self.lua.execute(source.split('local function child(')[0]+'\nreturn site')

    def test_relative_wave_finds_valley_beside_nominal_mesa(self):
        group=self.lua.eval('{unit="pawn",position={350,150},anchorPosition={0,0},relative_to={max_distance=500}}')
        x,y,z=self.site(group,350,150)
        self.assertEqual(y,0)
        self.assertLessEqual(x*x+z*z,500*500)

    def test_absolute_wave_keeps_declared_height_constraint(self):
        group=self.lua.eval('{unit="pawn",position={350,150}}')
        self.assertIsNone(self.site(group,350,150))
