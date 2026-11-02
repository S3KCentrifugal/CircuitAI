-- FRONT gantry fixture (owner 2026-11-01). Supplied preconditions only: the
-- allied FRONT (team 1) gets fusion income and converters at once and, at
-- cfg.gantryMinute, a finished gantry of its side. The AI chooses what the
-- gantry builds; read-only after setup: products started and finished.
function widget:GetInfo()
    return {name="FRONT gantry fixture",desc="FRONT gets a gantry; its products observed",layer=121,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/front_gantry.lua")
local queue={}
local front,enemy,gantryName,prefix
local gantries={}
local started,finished,later={},{},{}
local function echo(s) Spring.Echo("[FrontGantryTest] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
local function isGantry(name) return name=="armshltx" or name=="corgant" or name=="leggant" end
local function count(t) local n=0 for _ in pairs(t) do n=n+1 end return n end
function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") end
    if f==60 then
        local _,_,_,_,_,ally0=Spring.GetTeamInfo(0,false)
        for _,t in ipairs(Spring.GetTeamList()) do
            local _,_,_,_,_,ally=Spring.GetTeamInfo(t,false)
            if t~=0 and ally==ally0 and front==nil and t~=Spring.GetGaiaTeamID() then front=t end
            if ally~=ally0 and enemy==nil and t~=Spring.GetGaiaTeamID() then enemy=t end
        end
        local _,_,_,_,side=Spring.GetTeamInfo(front,false)
        prefix=({armada="arm",cortex="cor",legion="leg"})[side] or "arm"
        gantryName=({arm="armshltx",cor="corgant",leg="leggant"})[prefix]
        local fx,_,fz=Spring.GetTeamStartPosition(front)
        local ex=select(1,Spring.GetTeamStartPosition(enemy))
        local dx=(fx<ex) and 1 or -1
        for i=0,5 do give(prefix.."afus",front,fx-dx*(900+(i%3)*170),fz-700+math.floor(i/3)*170) end
        for i=0,11 do give(prefix.."mmkr",front,fx-dx*(900+(i%4)*90),fz+600+math.floor(i/4)*90) end
        echo(string.format("supplied: front=%d enemy=%d side=%s",front,enemy,tostring(side)))
    end
    if front and f==cfg.gantryMinute*1800 then
        local fx,_,fz=Spring.GetTeamStartPosition(front)
        local ex=select(1,Spring.GetTeamStartPosition(enemy))
        local dx=(fx<ex) and 1 or -1
        give(gantryName,front,fx+dx*450,fz)
        echo("gantry given: "..gantryName.." team="..front)
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    -- one second after a product finishes: the orders it walks out with (the gantry's waypoints)
    for u,at in pairs(later) do
        if f>=at then
            later[u]=nil
            if Spring.ValidUnitID(u) then
                local cmds=Spring.GetUnitCommands(u,8) or {}
                local first=cmds[1]
                echo(string.format("leaves unit=%d orders=%d first=%s",u,#cmds,
                    first and (tostring(first.id).." "..table.concat(first.params or {},",")) or "none"))
            end
        end
    end
    if f%1800==0 and front then
        local m=select(1,Spring.GetTeamResources(front,"metal"))
        echo(string.format("minute=%d front gantries=%d products started=%d finished=%d metal=%d",
            math.floor(f/1800),count(gantries),count(started),count(finished),math.floor(m or 0)))
    end
end
function widget:UnitCreated(u,def,team,builder)
    local name=UnitDefs[def].name
    if team==front and isGantry(name) then gantries[u]=true end
    if builder and gantries[builder] then
        started[u]=true
        echo(string.format("started team=%d gantry=%d unit=%s frame=%d",team,builder,name,Spring.GetGameFrame()))
    end
end
function widget:UnitFinished(u,def,team)
    if team==front and isGantry(UnitDefs[def].name) then gantries[u]=true end
    if started[u] then
        finished[u]=true
        later[u]=Spring.GetGameFrame()+30
        echo(string.format("finished team=%d unit=%s frame=%d",team,UnitDefs[def].name,Spring.GetGameFrame()))
    end
end
