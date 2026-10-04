function widget:GetInfo()
    return {name="AIR command observer",desc="Read-only synchronized order counts",author="CircuitAI",layer=126,enabled=true,handler=true}
end
local previous,hook
local counts,last={},{}
local function count(id,def,team,cmd,params,options,tag,player,fromSynced,fromLua)
    local c=counts[team] or {all=0,air=0,repeated=0,byDef={},byCommand={},byOrigin={}};counts[team]=c;c.all=c.all+1
    local origin=fromLua==true and "lua" or fromLua==false and "nonlua" or "unknown"
    c.byOrigin[origin]=(c.byOrigin[origin] or 0)+1
    local d=UnitDefs[def]
    local name=d and d.name or "unknown"
    c.byDef[name]=(c.byDef[name] or 0)+1
    c.byCommand[cmd]=(c.byCommand[cmd] or 0)+1
    if not d or not d.canFly then return end
    c.air=c.air+1
    local signature=tostring(cmd)
    for _,v in ipairs(params or {}) do signature=signature..":"..tostring(v) end
    if last[id]==signature then c.repeated=c.repeated+1 end
    last[id]=signature
    if (d.name=="armpnix" or d.name=="corhurc" or d.name=="legphoenix") and cmd==CMD.ATTACK and params and #params==1 then
        local target=UnitDefs[Spring.GetUnitDefID(params[1]) or -1]
        if target and (target.speed or 0)>0 and not target.canFly and tonumber((target.customParams or {}).techlevel or 1)<2 then
            Spring.Echo("[AirOrders] ERROR t2_bomber_attacks_t1 unit="..id.." target="..params[1].." name="..target.name)
        end
    end
end
function widget:Initialize()
    previous=widgetHandler.UnitCommand
    hook=function(self,...)
        count(...)
        if previous then return previous(self,...) end
    end
    widgetHandler.UnitCommand=hook;widgetHandler:UpdateCallIn("UnitCommand")
    Spring.Echo("[AirOrders] installed")
end
function widget:GameFrame(frame)
    if frame>0 and frame%1800==0 then
        if widgetHandler.UnitCommand~=hook then Spring.Echo("[AirOrders] ERROR observer_replaced") end
        for team,c in pairs(counts) do
            Spring.Echo(string.format("[AirOrders] frame=%d team=%d all_apm=%d air_apm=%d repeated=%d",frame,team,c.all,c.air,c.repeated))
            for name,n in pairs(c.byDef) do
                Spring.Echo(string.format("[AirOrdersDetail] frame=%d team=%d def=%s orders=%d",frame,team,name,n))
            end
            for cmd,n in pairs(c.byCommand) do
                Spring.Echo(string.format("[AirOrdersDetail] frame=%d team=%d cmd=%d orders=%d",frame,team,cmd,n))
            end
            for origin,n in pairs(c.byOrigin) do
                Spring.Echo("[CommandOrigin] frame="..frame.." team_source="..team..":"..origin.." count="..n)
            end
        end
        counts={}
    end
end
function widget:UnitDestroyed(id) last[id]=nil end
function widget:Shutdown()
    if widgetHandler.UnitCommand==hook then widgetHandler.UnitCommand=previous;widgetHandler:UpdateCallIn("UnitCommand") end
end
