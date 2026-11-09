function widget:GetInfo()
    return {name="BARb lane front visual check",desc="Rendered contested-zone evidence",author="CircuitAI",layer=100000,enabled=true}
end
local started,done,draws,shot=nil,false,0,nil
function widget:DrawScreen() draws=draws+1 end
function widget:GameFrame(frame)
    if done then return end
    local ui=WG.barblink
    if not ui or not ui.StrategySnapshot then return end
    if not started and frame>=450 then
        started=Spring.GetTimer()
        ui.SetOpen(false);ui.SetStrategy(true)
        Spring.SendCommands({"setminspeed 1","setmaxspeed 1"})
    end
    if not started then return end
    if Spring.DiffTimers(Spring.GetTimer(),started)>75 then
        Spring.Echo("[LaneFrontWidget] FAIL timeout")
        Spring.SendCommands({"setmaxspeed 20","setminspeed 20"});done=true;return
    end
    local snap=ui.StrategySnapshot()
    if #snap.teams==0 then ui.StrategyConfig({show=true,class=1,mode=1});return end
    local s=snap.teams[1];local danger=false
    for _,zone in ipairs(s.front and s.front.zones or {}) do if zone[3]>=2 then danger=true end end
    if not shot and danger and snap.ready and snap.dynamicLists>0 then
        Spring.SetCameraState({mode=1,px=4300,py=math.max(0,Spring.GetGroundHeight(4300,4400)),pz=4400,height=2400,angle=.8},0)
        shot=draws+15
    end
    if shot and draws>=shot then
        Spring.Echo("[Playtest] screenshot lane front contested zones")
        Spring.SendCommands("screenshot png")
        Spring.Echo("[LaneFrontWidget] PASS zones="..#s.front.zones.." geometry="..snap.dynamicLists)
        Spring.SendCommands({"setmaxspeed 20","setminspeed 20"});done=true
    end
end
