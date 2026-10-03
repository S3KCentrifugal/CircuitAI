"""Exercise the timing observer against the pinned engine's argument contract."""
from pathlib import Path
import unittest
try:
    from lupa.lua51 import LuaRuntime
except ImportError:
    LuaRuntime = None


@unittest.skipIf(LuaRuntime is None, 'Lua 5.1 test runtime unavailable')
class WorkforceTimingTests(unittest.TestCase):
    def test_explicit_boolean_and_exact_cumulative_percentiles(self):
        lua = LuaRuntime()
        lua.execute('''
            widget={}; logs={}; local total=0; local time=0;local enabled=false
            Spring={
              SendCommands=function(cmd) assert(cmd=="debug 1 0");enabled=true end,
              GetProfilerTimeRecord=function(name,wantFrames)
                assert(name=="AI" and wantFrames==false,"explicit engine boolean required")
                assert(enabled,"profiling must be enabled")
                total=total+2;return total
              end,
              GetTimer=function() time=time+60;return time end,
              DiffTimers=function(a,b)return a-b end,
              Echo=function(s)table.insert(logs,s)end
            }
        ''')
        lua.execute((Path(__file__).parent/'widgets/workforce_perf_watch.lua').read_text())
        lua.execute('widget:Initialize()')
        lua.execute('for f=0,18000 do widget:GameFrame(f) end')
        logs=list(lua.globals().logs.values())
        self.assertEqual(len(logs),11)
        self.assertIn('samples=18000 ai_all_p50_ms=2.000000 ai_all_p95_ms=2.000000 ai_all_max_ms=2.000000',logs[-1])


if __name__=='__main__':unittest.main()
