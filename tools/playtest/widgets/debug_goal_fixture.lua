-- Debug goal smoke fixture (owner 2026-11-01, branch debug-widget-test). The
-- host (a real player on its own ally team) sends the team link widget's goal
-- commands to the striker AI (team 0) the way the widget does: goal|pos at the
-- eco start, goal|off, goal|player|<host>, goal|off. The AI log carries the
-- results ("DEBUG: goal ..."); this only sends, counts the striker's army on
-- the way and prints DONE.
function widget:GetInfo()
    return {name="Debug goal fixture",desc="Sends debug goal commands to the striker AI",layer=122,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/debug_goal.lua")
local A=0
local me
local steps
local function echo(s) Spring.Echo("[DebugGoal] "..s) end
local function army()
    local n=0
    for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and d.canMove and (d.buildSpeed or 0)<=0 and not d.canFly then n=n+1 end
    end
    return n
end
function widget:Initialize()
    me=Spring.GetMyPlayerID()
    local name,_,spec,team=Spring.GetPlayerInfo(me,false)
    echo(string.format("host player id=%d name=%s spectator=%s team=%s",me,tostring(name),tostring(spec),tostring(team)))
    local f0=math.floor(cfg.startMin*1800)
    -- a goal|pos takes only units within half the map's long edge of the point
    local bx,bz=(cfg.goalPos or cfg.startB)[1],(cfg.goalPos or cfg.startB)[2]
    steps={
        {f=f0, msg=string.format("goal|pos|%d|%d",bx,bz)},
        {f=f0+cfg.posSec*30, msg="goal|off"},
        {f=f0+(cfg.posSec+10)*30, msg="goal|player|"..me},
        {f=f0+(cfg.posSec+10+cfg.playerSec)*30, msg="goal|off"},
    }
    steps.doneFrame=steps[4].f+20*30
    steps.giveFrame=f0-1800   -- a minute before the goal: the striker's army, placed by the arena
end
function widget:GameFrame(f)
    if f==45 then
        local _,_,_,_,_,ally=Spring.GetTeamInfo(Spring.GetMyTeamID(),false)
        Spring.SendCommands("cheat 1"); Spring.SendCommands("globallos "..ally)
    end
    if f==steps.giveFrame and cfg.armyA then
        local ax,az=cfg.startA[1],cfg.startA[2]
        local n=0
        for name,count in pairs(cfg.armyA) do
            for i=1,count do
                local x,z=ax+400+(n%6)*60,az-200+math.floor(n/6)*60
                Spring.SendCommands("give 1 "..name.." "..A.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
                n=n+1
            end
        end
        echo(string.format("supplied the striker's army (arena placed): %d units at frame %d",n,f))
    end
    for _,s in ipairs(steps) do
        if f==s.f then
            local ok=Spring.SendSkirmishAIMessage(A,"barb|debug|"..A.."|"..s.msg)
            echo(string.format("send frame=%d ok=%s msg=%s army=%d",f,tostring(ok),s.msg,army()))
        end
    end
    if f%900==0 then echo(string.format("frame=%d army=%d",f,army())) end
    if f==steps.doneFrame then echo("DONE") end
end
