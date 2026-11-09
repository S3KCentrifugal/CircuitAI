"""Run the real strategy renderer in Lua 5.1 with engine-free publication fixtures."""
from pathlib import Path
import unittest
from lupa.lua51 import LuaRuntime

ROOT = Path(__file__).resolve().parents[1]


class StrategyWidgetTest(unittest.TestCase):
    def setUp(self):
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.lua.execute('''
            Game={mapSizeX=128,mapSizeZ=128};GL={LINES=1,QUADS=2}
            permitted=true;frame=300;created=0;deleted=0;orders=0
            local tick=0
            function isPermittedTeam() return permitted end
            Spring={GetGameFrame=function()return frame end,GetTeamColor=function()return .2,.5,.8 end,
                GetGroundHeight=function()return 0 end,IsGUIHidden=function()return false end,
                GetTimer=function()tick=tick+.0001;return tick end,DiffTimers=function(a,b)return a-b end,
                TraceScreenRay=function()return "ground",{40,0,40}end,Echo=function(s)error(s)end}
            gl=setmetatable({CreateList=function(fn)created=created+1;fn();return created end,
                DeleteList=function()deleted=deleted+1 end,BeginEnd=function(_,fn)fn()end,
                GetViewSizes=function()return 1920,1080 end},{__index=function()return function()end end})
            model={gw=4,gh=4,cell=32,corridorRuns={[0]={{0,2,16}}},clearanceRuns={[0]={{0,6,16}}},
                corridors={[2]={id=2,class=0,name="Centre",x=64,z=64,width=96,length=128,spine={{0,64,96},{128,64,96}}}}}
            field={Model=function()return model end,Status=function()return "ready"end}
            territory={Snapshot=function()return {} end}
        ''')
        widget_source = (ROOT/'tools/widgets/gui_barb_team_link.lua').read_text(encoding='utf-8')
        metrics = widget_source.split('-- BEGIN DIALOG METRICS',1)[1].split('-- END DIALOG METRICS',1)[0]
        self.lua.globals().dialogUI = self.lua.execute(metrics+'\nreturn dialogUI')
        source = (ROOT/'tools/widgets/include/barb_strategy.lua').read_text()
        self.api = self.lua.execute(source+'\nreturn strategy')
        self.payload = '1;300;1;0;2;0;1;32,64;32;-1,-1,0;-1;123;0,2,-1,0,64,128,64;1,3,-1;0,64,0|64,64,4;290,1,3,80,90,75,0,75,64,0'

    def click(self,label):
        r=self.api.ButtonRect(label)
        self.assertIsNotNone(r,label)
        return self.api.MousePress((r[1]+r[3])/2,(r[2]+r[4])/2,1,False)

    def test_dialog_scales_with_resolution_and_ui_preference(self):
        sizes=[]
        for width,height in ((1280,720),(1920,1080),(2560,1440),(3840,2160)):
            self.lua.execute(f'gl.GetViewSizes=function()return {width},{height} end')
            self.api.Set(True);self.api.DrawScreen()
            p=self.api.PanelRect();r=self.api.ButtonRect("Freeze")
            self.assertGreaterEqual(p[1],0);self.assertGreaterEqual(p[2],0)
            self.assertLessEqual(p[3],width);self.assertLessEqual(p[4],height)
            sizes.append(r[4]-r[2])
            self.assertTrue(self.click("Freeze"));self.api.DrawScreen();self.click("Resume live")
        self.assertGreater(sizes[-1],sizes[1]*1.9)
        ui=self.lua.globals().dialogUI
        before=ui.Scale(3840,2160,560,520)
        self.lua.execute('Spring.GetConfigFloat=function()return 1.2 end')
        self.assertGreater(ui.Scale(3840,2160,560,520),before)

    def test_dialog_metrics_handle_invalid_preference_and_fit_long_labels(self):
        ui=self.lua.globals().dialogUI
        baseline=ui.Scale(1920,1080,560,520)
        self.lua.execute('Spring.GetConfigFloat=function()return 0/0 end;gl.GetTextWidth=function(t)return #t*.5 end')
        self.assertEqual(ui.Scale(1920,1080,560,520),baseline)
        self.assertEqual(ui.Fit("Short",12,100),"Short")
        fitted=ui.Fit("A very long control label",12,90)
        self.assertTrue(fitted.endswith('...'));self.assertLessEqual(len(fitted)*6,90)

    def test_territory_opacity_is_persisted_and_rebuilds_only_on_change(self):
        self.api.Receive(1,self.payload);self.ready();self.api.DrawScreen()
        before=self.lua.globals().created
        self.assertAlmostEqual(self.api.GetConfig()['territoryOpacity'],.28)
        self.click("Territory: 28%");self.ready()
        self.assertAlmostEqual(self.api.GetConfig()['territoryOpacity'],.4)
        self.assertGreater(self.lua.globals().created,before)
        after=self.lua.globals().created
        for _ in range(10):self.api.DrawScreen();self.api.Update()
        self.assertEqual(self.lua.globals().created,after)

    def ready(self):
        self.api.Set(True)
        for _ in range(100):
            self.api.Update()
            if not self.api.Snapshot()['preparing']:
                return
        self.fail('geometry never completed')

    def test_parses_real_snapshot_and_rejects_older_or_foreign(self):
        self.assertTrue(self.api.Receive(1,self.payload))
        self.ready()
        s=self.api.Snapshot()['teams'][1]
        self.assertEqual(s['corridor'],2)
        self.assertEqual(s['native'][5],90)
        self.assertEqual(len(s['route']),2)
        self.assertFalse(self.api.Receive(1,self.payload.replace(';300;',';299;',1)))
        self.lua.execute('permitted=false')
        self.assertFalse(self.api.Receive(1,self.payload))
        self.assertEqual(len(self.api.Snapshot()['teams']),0)
        self.api.DrawWorld()
        self.assertGreater(self.lua.globals().deleted,0)

    def test_defense_reason_is_optional_bounded_and_preserved(self):
        self.assertTrue(self.api.Receive(1,self.payload+';active;none;300;armanni energy_committed'))
        self.assertEqual(self.api.Snapshot()['teams'][1]['defense'],'armanni energy_committed')
        self.assertTrue(self.api.Receive(1,self.payload.replace(';300;',';600;',1)+';active;none;600;'+('x'*300)))
        self.assertEqual(len(self.api.Snapshot()['teams'][1]['defense']),180)

    def test_mismatched_field_revision_is_not_drawn_as_assignment(self):
        self.api.Receive(1,self.payload)
        self.lua.execute("model.corridorRevision='999'")
        self.ready()
        self.assertEqual(len(self.api.Snapshot()['teams']),0)
        self.assertEqual(self.api.Snapshot()['dynamicLists'],0)

    def test_panel_avoids_top_left_minimap(self):
        self.lua.execute('Spring.GetMiniMapGeometry=function()return 0,735,208,345 end')
        self.api.Receive(1,self.payload);self.ready();self.api.DrawScreen()
        self.assertFalse(self.api.MousePress(30,1000,1,True))
        self.assertTrue(self.click("Freeze"))
        self.assertTrue(self.api.Snapshot()['frozen'])

    def test_raster_binary_lookup_boundaries(self):
        runs=self.lua.table_from([self.lua.table_from([0,-1,3]),self.lua.table_from([3,7,5])])
        self.assertEqual(self.api.At(runs,2),-1)
        self.assertEqual(self.api.At(runs,3),7)
        self.assertEqual(self.api.At(runs,7),7)
        self.assertIsNone(self.api.At(runs,8))

    def test_front_zones_revision_permissions_and_malformed_input(self):
        self.api.Receive(1,self.payload)
        self.assertTrue(self.api.ReceiveFront(1,'1;301|0,32,3|32,64,2|64,128,4'))
        self.ready();self.api.DrawWorld();self.api.DrawScreen()
        s=self.api.Snapshot()['teams'][1]
        self.assertEqual(len(s['front']['zones']),3)
        self.assertEqual(s['front']['frame'],301)
        for bad in ('2;302|0,64,3','1;300|0,64,3','1;302|64,0,3','1;302|0,64,8','1;302|0,64,3|32,128,2'):
            self.assertFalse(self.api.ReceiveFront(1,bad))
        self.lua.execute('permitted=false')
        self.assertFalse(self.api.ReceiveFront(1,'1;302|0,64,3'))

    def test_frozen_front_is_immutable(self):
        self.api.Receive(1,self.payload)
        self.api.ReceiveFront(1,'1;301|0,64,3')
        self.ready();self.api.DrawScreen();self.click("Freeze" if not self.api.Snapshot()["frozen"] else "Resume live")
        self.api.ReceiveFront(1,'1;330|0,64,2')
        self.assertEqual(self.api.Snapshot()['teams'][1]['front']['frame'],301)

    def test_stale_front_is_marked_and_fresh_publication_recovers(self):
        self.api.Receive(1,self.payload)
        self.api.ReceiveFront(1,'1;301|0,64,3')
        self.ready()
        self.lua.execute('frame=500')
        self.ready()
        self.assertTrue(self.api.Snapshot()['teams'][1]['frontStale'])
        self.api.ReceiveFront(1,'1;500|0,64,2');self.ready()
        self.assertFalse(self.api.Snapshot()['teams'][1]['frontStale'])

    def test_front_strip_clips_across_a_route_bend(self):
        self.lua.execute('''
            redVertices={};local red=false
            gl.Color=function(r,g,b)red=r==1 and g==.15 and b==.15 end
            gl.Vertex=function(x,y,z)if red then redVertices[#redVertices+1]={x,z} end end
        ''')
        payload=self.payload.replace('0,2,-1,0,64,128,64','0,2,-1,0,64,64,64,64,128')
        self.api.Receive(1,payload)
        self.api.ReceiveFront(1,'1;301|0,80,3|80,128,0')
        self.ready()
        vertices=[(v[1],v[2]) for v in self.lua.globals().redVertices.values()]
        self.assertIn((64,80),vertices)
        self.assertIn((64,64),vertices)

    def test_heatmap_is_bounded_and_drawworld_does_not_resample_terrain(self):
        self.lua.execute('''heatVertices={};heightCalls=0;local heat=false;local primitive=0
            gl.BeginEnd=function(kind,fn)primitive=kind;fn();primitive=0 end
            gl.Color=function(r,g,b,a)heat=r==1 and g==.15 and b==.15 and a<.6 end
            gl.Vertex=function(x,y,z)if heat and primitive==GL.QUADS then heatVertices[#heatVertices+1]={x,z} end end
            Spring.GetGroundHeight=function()heightCalls=heightCalls+1;return 0 end
        ''')
        self.api.Receive(1,self.payload);self.api.ReceiveFront(1,'1;301|0,64,3')
        self.ready()
        vertices=list(self.lua.globals().heatVertices.values())
        self.assertGreater(len(vertices),0)
        self.assertTrue(all(0<=v[1]<=128 and 0<=v[2]<=128 for v in vertices))
        count=self.lua.globals().heightCalls
        for _ in range(10):
            self.api.DrawWorld();self.api.Update()
        self.assertEqual(self.lua.globals().heightCalls,count)

    def test_timestamp_only_front_update_reuses_heat_geometry(self):
        self.api.Receive(1,self.payload);self.api.ReceiveFront(1,'1;301|0,64,3')
        self.ready();before=self.lua.globals().created
        self.api.ReceiveFront(1,'1;330|0,64,3');self.ready()
        self.assertEqual(self.lua.globals().created-before,1)  # route/markers only
        self.lua.execute('Spring.GetMouseState=function()return 400,1040 end')
        self.api.DrawScreen()  # real two-value mouse callback, including hover

    def test_heat_toggle_retains_evidence_and_persists_preference(self):
        self.api.Receive(1,self.payload);self.api.ReceiveFront(1,'1;301|0,64,3')
        self.ready();self.api.DrawScreen()
        self.assertTrue(self.click("Heatmap ON"))
        self.assertFalse(self.api.GetConfig()['heat'])
        self.ready()
        self.assertEqual(self.api.Snapshot()['teams'][1]['front']['zones'][1][3],3)
        self.api.Config(self.lua.table_from({'show':True,'heat':True}))
        self.assertTrue(self.api.GetConfig()['heat'])

    def test_identical_state_files_do_not_rebuild_and_command_close_disposes(self):
        self.api.Receive(1,self.payload);self.ready()
        count=self.lua.globals().created
        self.assertFalse(self.api.Receive(1,self.payload))
        self.api.Update();self.assertEqual(self.lua.globals().created,count)
        self.assertTrue(self.api.TextCommand('barbstrategy'))
        self.assertFalse(self.api.Mode())
        self.assertEqual(self.api.Snapshot()['terrainLists'],0)
        self.assertEqual(self.api.Snapshot()['dynamicLists'],0)

    def test_dynamic_updates_reuse_static_geometry(self):
        self.api.Receive(1,self.payload);self.ready()
        before=self.lua.globals().created
        self.api.Receive(1,self.payload.replace(';300;',';600;',1));self.ready()
        self.assertEqual(self.lua.globals().created-before,1)
        self.api.DrawScreen();self.api.DrawWorld()

    def test_freeze_preserves_snapshot_and_resume_refreshes(self):
        self.api.Receive(1,self.payload);self.ready();self.api.DrawScreen()
        self.assertTrue(self.click("Freeze" if not self.api.Snapshot()["frozen"] else "Resume live"))  # Freeze
        self.assertTrue(self.api.Snapshot()['frozen'])
        self.api.Receive(1,self.payload.replace(';300;',';600;',1))
        self.assertEqual(self.api.Snapshot()['teams'][1]['frame'],300)
        self.api.DrawScreen();self.click("Freeze" if not self.api.Snapshot()["frozen"] else "Resume live")
        self.assertEqual(self.api.Snapshot()['teams'][1]['frame'],600)

    def test_inspection_does_not_capture_normal_game_clicks(self):
        self.api.Receive(1,self.payload);self.ready();self.api.DrawScreen()
        self.assertFalse(self.api.MousePress(1000,500,1,False))
        self.click("Inspect map")  # Inspect map
        self.assertFalse(self.api.MousePress(1000,500,1,True))
        self.assertTrue(self.api.MousePress(1000,500,1,False))
        self.api.Update();self.api.DrawScreen()



class NuclearWarningRelayTest(unittest.TestCase):
    def setUp(self):
        self.lua=LuaRuntime(unpack_returned_tuples=True)
        self.lua.execute('''
            widget={};sent={};spectator=false;frame=100;aiOrder={1,2}
            Spring={GetGameFrame=function() return frame end}
            function isSpectator() return spectator end
            function spGetMyPlayerID() return 7 end
            function mayCommand(id) return id==1 end
            function spSendSkirmishAIMessage(id,message) sent[#sent+1]={id,message} end
        ''')
        source=(ROOT/'tools/widgets/gui_barb_team_link.lua').read_text(encoding='utf8')
        self.lua.execute('local lastNuclearWarning'+source.split('local lastNuclearWarning',1)[1].split('local theatrePending',1)[0])

    def test_public_enemy_warning_only_reaches_owned_allies_once_per_frame(self):
        self.lua.execute('widget:NotificationEvent("NukeLaunched 7");widget:NotificationEvent("NukeLaunched 7")')
        self.assertEqual(len(self.lua.globals().sent),1)
        self.assertEqual(self.lua.globals().sent[1][2],'barb|nuclear-warning|1')

    def test_spectator_foreign_and_allied_alerts_are_not_relayed(self):
        self.lua.execute('widget:NotificationEvent("NukeLaunched 8");widget:NotificationEvent("AlliedNukeLaunched 7");spectator=true;widget:NotificationEvent("NukeLaunched 7")')
        self.assertEqual(len(self.lua.globals().sent),0)


if __name__ == '__main__':
    unittest.main()
