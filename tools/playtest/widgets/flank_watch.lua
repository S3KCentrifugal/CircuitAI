function widget:GetInfo()
    return {name="TECH flank regression", desc="Observe factory origin and mountain traversal", author="CircuitAI", layer=110, enabled=true}
end
local states, born, passed, ordinary = {}, {}, {}, {}
local combat = {armsptk=true, cortermite=true, legsrail=true}
local labs = {armalab=true, coralab=true, legalab=true}
local fast = {armfast=true, corpyro=true, legstr=true}
local spam = {armpw=true, corak=true, leggob=true}
local function say(s) Spring.Echo("[FlankTest] "..s) end
local function check(key,ok,detail)
    if passed[key] then return end
    if ok then passed[key]=true; say("PASS "..key.." "..(detail or "")) end
end
function widget:UnitFinished(id,def,team)
    if not states[team] or not next(states[team].factories) then return end
    ordinary[team]=ordinary[team] or {fast=0,spam=0}
    local s=ordinary[team]
    if fast[UnitDefs[def].name] then s.fast=s.fast+1 end
    if spam[UnitDefs[def].name] then s.spam=s.spam+1 end
    check("normal production team="..team,s.fast>0 and s.spam>0,"fast="..s.fast.." spam="..s.spam)
end
function widget:UnitCreated(id,def,team,builder)
    local name=UnitDefs[def].name
    if labs[name] then
        local _,_,_,income=Spring.GetTeamResources(team,"metal")
        born[id]={builder=builder,income=income or 0,frame=Spring.GetGameFrame()}
        say("lab frame team="..team.." id="..id.." builder="..tostring(builder).." income="..math.floor(income or 0))
    end
    if combat[name] and builder then
        states[team]=states[team] or {factories={},units={},high={},crossed={},last=0}
        local s=states[team]
        s.units[id]={factory=builder,frame=Spring.GetGameFrame()}
    end
end
function widget:GameFrame(f)
    local ui=WG.barblink
    if f==36000 and ui then ui.SetTheatres("all"); ui.TheatreOptions({live=true,context=false,sites=false,shores=false,labels=true}) end
    if f==36600 and ui then
        local snapshot=ui.TheatreSnapshot(0)
        if snapshot then for _,l in ipairs(snapshot.details) do if l.class==4 then ui.SelectLane(0,l.id); break end end end
    end
    if f%150~=0 then return end
    for team,s in pairs(states) do
        local sx,_,sz=Spring.GetTeamStartPosition(team)
        for id,u in pairs(s.units) do
            if Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
                local x,y,z=Spring.GetUnitPosition(id)
                local _,_,_,_,progress=Spring.GetUnitHealth(id)
                local cmds=Spring.GetUnitCommands(id,500)
                local mountain=false
                for _,c in ipairs(cmds or {}) do
                    if (c.id==CMD.MOVE or c.id==CMD.FIGHT) and #c.params>=3 and c.params[3]<800 and c.params[1]>Game.mapSizeX*.4 and c.params[1]<Game.mapSizeX*.6 then mountain=true end
                end
                if mountain then
                    u.routed=true
                    s.factories[u.factory]=(s.factories[u.factory] or {})
                    if progress and progress>=1 then s.factories[u.factory][id]=true end
                end
                if u.routed and y>350 and z<800 and x>Game.mapSizeX*.35 and x<Game.mapSizeX*.65 then s.high[id]=true end
                if u.routed and ((sx<Game.mapSizeX*.5 and x>Game.mapSizeX*.85) or (sx>Game.mapSizeX*.5 and x<Game.mapSizeX*.15)) then s.crossed[id]=true end
            end
        end
        for fac,units in pairs(s.factories) do
            local n,first,last=0,1e9,0
            for id in pairs(units) do n=n+1; first=math.min(first,s.units[id].frame); last=math.max(last,s.units[id].frame) end
            local b=born[fac]
            -- The income gate is checked at order time (native policy trace).
            -- Current income may dip while the builder walks to the footprint.
            check("built team="..team, b and b.builder and n>=1,"factory="..fac.." frameIncome="..math.floor(b.income))
            check("continuous team="..team,n>=3,"factory="..fac.." completed="..n)
            check("sustained team="..team,n>=8 and last-first>=9000,"factory="..fac.." completed="..n.." span="..(last-first))
        end
        local high,cross=0,0
        for _ in pairs(s.high) do high=high+1 end
        for _ in pairs(s.crossed) do cross=cross+1 end
        check("mountain team="..team,high>=2,"units="..high)
        check("crossed team="..team,cross>=1,"units="..cross)
        if f-s.last>=1800 then
            s.last=f
            local alive,dead,furthest=0,0,0
            for id,u in pairs(s.units) do if u.routed then
                if Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
                    alive=alive+1
                    local x,y,z=Spring.GetUnitPosition(id)
                    local p=sx<Game.mapSizeX/2 and x/Game.mapSizeX or 1-x/Game.mapSizeX
                    furthest=math.max(furthest,p)
                else dead=dead+1 end
            end end
            say("progress team="..team.." high="..high.." crossed="..cross.." alive="..alive.." dead="..dead.." furthest="..string.format("%.2f",furthest))
        end
    end
end
