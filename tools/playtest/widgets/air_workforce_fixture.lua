function widget:GetInfo() return {name="AIR workforce fixture", layer=125, enabled=true, handler=true} end
local cfg=VFS.Include("LuaUI/Config/air_workforce.lua")
local queue, donated, produced = {}, 0, 0
local builtByAI = {}
local prior, hook
local function log(s) Spring.Echo("[WorkforceFixture] "..s) end
local function give(name,team,x,z,n)
    queue[#queue+1]="give "..(n or 1).." "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
function widget:Initialize()
    local g=getfenv(0);prior=rawget(g,"RecvSkirmishAIMessage")
    hook=function(team,text)
        if team==0 then
            local name,x,z=text:match("^barb|workforceprobe|%d+|%d+|give|([^|]+)|([^|]+)|([^|]+)$")
            if name then give(name,0,tonumber(x),tonumber(z)) end
        end
        if prior then return prior(team,text) end
    end
    rawset(g,"RecvSkirmishAIMessage",hook);Script.UpdateCallIn("RecvSkirmishAIMessage")
    log("supplied scenario="..cfg.scenario.."; gifts are not natural income")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands({"cheat 1","globallos"}) end
    if f==900 then
        local x,_,z=Spring.GetTeamStartPosition(0)
        local prefix=cfg.side=="cortex" and "cor" or cfg.side=="legion" and "leg" or "arm"
        give(prefix.."aca",0,x+150,z,2)
        give(prefix.."mstor",0,x+650,z-300,6)
        give(prefix.."estor",0,x+1000,z-300,6)
        if cfg.scenario~="energy-starved" then give(prefix.."fus",0,x+1500,z-600,6) end
        local dx,_,dz=Spring.GetTeamStartPosition(1)
        give(prefix.."mstor",1,dx+250,dz,10)
        log("seed economy and donor storage requested")
    end
    if f%15==0 and #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if cfg.scenario=="lifecycle" then
        if f==14400 then
            for _,id in ipairs(Spring.GetTeamUnits(0)) do
                local d=UnitDefs[Spring.GetUnitDefID(id)]
                if d.name:find("nanotc") then Spring.SendLuaRulesMsg("$dev$:destroyunits "..id);log("requested loss id="..id);break end
            end
        end
        if f==25200 then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|SUPPORT");log("requested AIR exit") end
        if f==26100 then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|AIR");log("requested AIR reentry") end
    end
    -- Real allied transfers, preceded by a donor-only cheat grant. Receiving
    -- resources are visible in the engine's RECEIVED field, not fake AI income.
    if f>=1800 and f<cfg.stop*30 then
        local phase=f%150
        if phase==0 then Spring.SendCommands({"team 1","atm 6000"}) end
        if phase==15 then Spring.ShareResources(0,"metal",5000);donated=donated+1 end
        if phase==30 then Spring.SendCommands("spectator") end
    elseif f==cfg.stop*30 then log("donor stopped bursts="..donated);Spring.SendCommands("spectator") end
    if f%300==0 then
        local cur,_,pull,income,usage,_,_,received=Spring.GetTeamResources(0,"metal")
        log(string.format("frame=%d bank=%.1f own=%.1f usage=%.1f pull=%.1f received=%.1f built=%d",f,cur,income,usage,pull,received or 0,produced))
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            if d.isFactory then
                local target=Spring.GetUnitIsBuilding(id)
                if target then
                    local td=UnitDefs[Spring.GetUnitDefID(target)]
                    local _,_,_,_,progress=Spring.GetUnitHealth(target)
                    if td and td.isBuilder and td.canFly then
                        log(string.format("recruit plant=%d target=%d progress=%.5f priority=%s",id,target,progress or 0,tostring(Spring.GetUnitRulesParam(id,"builderPriority"))))
                    end
                end
            end
        end
    end
end
function widget:UnitCreated(id,def,team,builder)
    if team==0 and builder then builtByAI[id]=true end
end
function widget:UnitDestroyed(id,def,team)
    if team==0 then log("destroyed id="..id.." def="..UnitDefs[def].name) end
end
function widget:UnitFinished(id,def,team)
    if team~=0 then return end
    local d=UnitDefs[def]
    if d.isBuilder and builtByAI[id] then produced=produced+1;log("completed id="..id.." def="..d.name) end
    builtByAI[id]=nil
end
function widget:Shutdown()
    local g=getfenv(0)
    if rawget(g,"RecvSkirmishAIMessage")==hook then rawset(g,"RecvSkirmishAIMessage",prior);Script.UpdateCallIn("RecvSkirmishAIMessage") end
end
