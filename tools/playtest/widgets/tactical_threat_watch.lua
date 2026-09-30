-- Isolated test only. Add an observed AA battery across an existing air route.
function widget:GetInfo()
    return {name="Tactical threat refresh check",desc="AA changes an AI-computed air approach",author="CircuitAI",layer=109,enabled=true}
end
local stage,centre,oldDistance,oldRevision=0,nil,nil,nil
local function air(ui)
    local s=ui.TheatreSnapshot(0)
    if s then for _,l in ipairs(s.details) do if l.class==6 then return l end end end
end
local function distance(l,p)
    local best=1e9
    for _,v in ipairs(l.points) do best=math.min(best,math.sqrt((v[1]-p[1])^2+(v[2]-p[2])^2)) end
    return best
end
function widget:GameFrame(f)
    local ui=WG.barblink; if not ui then return end
    if stage==0 and f>=4800 then
        local l=air(ui)
        if not l then Spring.Echo("[TacticalThreat] FAIL no air route"); stage=99; return end
        centre=l.points[math.floor(#l.points/2)]
        oldDistance,oldRevision=distance(l,centre),l.revision
        ui.TheatreOptions({live=true,context=false,sites=false,shores=false,labels=true})
        ui.SelectLane(0,l.id)
        Spring.Echo("[TacticalThreat] baseline clearance "..oldDistance.." revision "..oldRevision)
        -- Cheat permission is synced; wait for a later frame before /give.
        Spring.SendCommands("cheat 1")
        stage=1
    elseif stage==1 and f>=5100 then
        local enemy=1
        for _,team in ipairs(Spring.GetTeamList()) do
            if not Spring.AreTeamsAllied(0,team) and team~=Spring.GetGaiaTeamID() then enemy=team; break end
        end
        Spring.SendCommands("give 12 armflak "..enemy.." @"..centre[1]..","..Spring.GetGroundHeight(centre[1],centre[2])..","..centre[2])
        -- Use ordinary allied vision: global LOS does not reliably deliver new
        -- enemy definitions through the engine's AI callback interface.
        Spring.SendCommands("give armrad 0 @"..centre[1]..","..Spring.GetGroundHeight(centre[1],centre[2])..","..centre[2])
        Spring.Echo("[TacticalThreat] injected AA in isolated test at "..centre[1]..","..centre[2])
        stage=2
    elseif stage==2 and f>=5400 then
        local count,visible=0,0
        for _,id in ipairs(Spring.GetUnitsInCylinder(centre[1],centre[2],700)) do
            if Spring.GetUnitDefID(id)==UnitDefNames.armflak.id then
                count=count+1
                local los=Spring.GetUnitLosState(id,0)
                if los and los.los then visible=visible+1 end
            end
        end
        Spring.Echo("[TacticalThreat] "..(count>=12 and "PASS" or "FAIL").." AA fixture created "..count)
        Spring.Echo("[TacticalThreat] "..(visible>=12 and "PASS" or "FAIL").." AA observed by ally 0 "..visible)
        stage=2.5
    elseif stage==2.5 and f>=6900 then
        ui.SetTheatres(0); stage=3
    elseif stage==3 and f>=7200 then
        local l=air(ui); local d=l and distance(l,centre) or 0
        local ok=l and l.revision>oldRevision and d>oldDistance+300
        if l then ui.SelectLane(0,l.id) end
        Spring.Echo("[TacticalThreat] "..(ok and "PASS" or "FAIL").." reroute around observed AA clearance "..d)
        stage=4
    end
end
