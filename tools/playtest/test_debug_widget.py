"""Lua 5.1 tests of the host widget's debug window (debug strikes, branch
debug-widget-test); uses the existing lane UI dependency and mock."""
import unittest
from test_lane_ui_memory import ROOT, LuaRuntime


class DebugWindowTests(unittest.TestCase):
    def setUp(self):
        self.lua = LuaRuntime()
        self.lua.execute((ROOT / 'tools/playtest/fixtures/lane_ui_mock.lua').read_text())
        self.lua.execute('''
            Spring.AreTeamsAllied=function(a,b) return math.floor(a/8)==math.floor(b/8) end
            messages={}
            Spring.SendSkirmishAIMessage=function(id,text) messages[#messages+1]=id..'>'..text; return true end
            function sent(text) for _,m in ipairs(messages) do if m==text then return true end end return false end
            function key(k) return widget:KeyPress(k,{},false) end
            function typeText(s) for i=1,#s do key(string.byte(s,i)) end end
        ''')
        self.lua.execute((ROOT / 'tools/widgets/gui_barb_team_link.lua').read_text(encoding='utf-8'))
        self.lua.execute('''
            widget:Initialize(); WG.barblink.SetOpen(true)
            widget:DrawScreen(); click('row3'); widget:DrawScreen()
            click('debugOpen'); widget:DrawScreen()
        ''')

    def test_position_nuke_goes_to_every_hosted_ai_and_toggles_off(self):
        self.lua.execute('''
            click('dbgFieldx'); typeText('1200'); key(9); typeText('3400.5')
            widget:DrawScreen(); messages={}
            click('debugNuke')
            assert(#messages==16, #messages)
            assert(sent('3>barb|debug|3|nuke|pos|1200|3401') and sent('12>barb|debug|12|nuke|pos|1200|3401'))
            widget:DrawScreen(); messages={}
            click('debugNuke')
            assert(#messages==16 and sent('5>barb|debug|5|nuke|off'))
        ''')

    def test_typing_is_digits_only_and_swallows_every_key(self):
        self.lua.execute('''
            click('dbgFieldx')
            assert(key(97)==true)          -- 'a': swallowed, not typed
            typeText('12.3.4'); key(8)     -- the second '.' is refused, backspace drops the 4
            key(0x40000059); key(0x40000062)   -- keypad 1 and 0
            key(27)                        -- escape: the field lets go
            assert(key(97)==false)
            widget:DrawScreen(); messages={}
            click('dbgFieldy'); typeText('50'); key(13)
            click('debugLol')
            assert(sent('0>barb|debug|0|lol|pos|12|50'), messages[1])
        ''')

    def test_team_strike_goes_only_to_enemies_of_the_team(self):
        self.lua.execute('''
            click('dbgFieldteam'); typeText('9'); key(13)
            widget:DrawScreen(); messages={}
            click('debugLol')
            assert(#messages==8, #messages)
            assert(sent('0>barb|debug|0|lol|team|9') and not sent('9>barb|debug|9|lol|team|9'))
        ''')

    def test_xy_wins_over_team_and_half_a_position_is_refused(self):
        self.lua.execute('''
            click('dbgFieldteam'); typeText('9')
            click('dbgFieldx'); typeText('100'); key(13)
            widget:DrawScreen(); messages={}
            click('debugNuke'); assert(#messages==0)   -- y is empty
            click('dbgFieldy'); typeText('200'); key(13)
            widget:DrawScreen(); click('debugNuke')
            assert(sent('1>barb|debug|1|nuke|pos|100|200'))
        ''')

    def test_off_map_is_refused(self):
        self.lua.execute('''
            click('dbgFieldx'); typeText('99999'); key(9); typeText('10'); key(13)
            widget:DrawScreen(); messages={}
            click('debugNuke'); assert(#messages==0)
        ''')

    def test_done_report_releases_the_nuke_button(self):
        self.lua.execute('''
            click('dbgFieldteam'); typeText('9'); key(13)
            widget:DrawScreen(); click('debugNuke'); messages={}
            widget:RecvSkirmishAIMessage(3,'barb|debug|3|0|team 9 2 1|off')
            widget:RecvSkirmishAIMessage(3,'barb|debug|3|0|done 9 4|off')
            widget:DrawScreen(); click('debugNuke')
            -- the button was released by the report, so this press starts a new strike
            assert(sent('3>barb|debug|3|nuke|team|9'), messages[1])
        ''')

    def test_close_keeps_strike_and_draws_nothing(self):
        self.lua.execute('''
            click('debugClose'); widget:DrawScreen()
            assert(WG.barblink.ButtonRect('debugNuke')==nil)
        ''')


if __name__ == '__main__':
    unittest.main()
