-- Commander-lane fixes: observer for a FRONT commander parked at base. Every
-- 30 seconds logs each commander's team, distance from its start and current
-- order (CMD_GUARD 25 on a factory is the reported "assisting the lab"), so a
-- stuck commander is visible in the log without the AI's own trace.
function widget:GetInfo() return {name="Commander base watch",layer=126,enabled=true} end
local CMD_GUARD=25
local starts={}
local function emit(s) Spring.Echo("[CommanderBaseWatch] "..s) end
local function isCommander(defID)
    local def=UnitDefs[defID]
    return def and def.customParams and def.customParams.iscommander~=nil
end
function widget:GameFrame(f)
    if f==90 then emit("observer_started") end
    if f<300 or f%900~=0 then return end
    for _,team in ipairs(Spring.GetTeamList()) do
        for _,id in ipairs(Spring.GetTeamUnits(team)) do
            if isCommander(Spring.GetUnitDefID(id)) then
                local x,_,z=Spring.GetUnitPosition(id)
                if not starts[id] then starts[id]={x=x,z=z} end
                local s=starts[id]
                local distance=math.sqrt((x-s.x)^2+(z-s.z)^2)
                local cmd,_,_,p1=Spring.GetUnitCurrentCommand(id)
                local target=""
                if cmd==CMD_GUARD and p1 then
                    local tdef=Spring.GetUnitDefID(p1)
                    target=tdef and UnitDefs[tdef].name or "?"
                end
                emit(string.format("minute=%.1f team=%d unit=%d from_start=%.0f x=%.0f z=%.0f cmd=%s guard=%s",
                    f/1800,team,id,distance,x,z,tostring(cmd),target))
            end
        end
    end
end
