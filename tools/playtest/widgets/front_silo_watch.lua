-- FRONT silo grid observer (owner 2026-10-30). Read-only: no gifts, reveal or orders.
-- Logs every finished nuclear silo with its team and position, the grid tightness per
-- team (pairs of silos exactly one footprint apart, side by side), and once a minute
-- from minute 25 the ground units that look trapped: a move/fight/patrol order they
-- have not made 64 elmos of progress on in 120 s, counted by distance to the nearest silo.
function widget:GetInfo()
    return {name="FRONT silo grid observer",desc="Silo grids and trapped units",layer=116,enabled=true}
end
local silos={}          -- id -> {team,x,z,w,d}
local samples={}        -- id -> {x,z,frame} two minutes ago
local CMD_MOVE,CMD_FIGHT,CMD_PATROL=CMD.MOVE,CMD.FIGHT,CMD.PATROL
local function echo(s) Spring.Echo("[SiloWatch] "..s) end
local function isSilo(d) return d and (d.name=="armsilo" or d.name=="corsilo" or d.name=="legsilo") end
function widget:UnitFinished(id,def,team)
    local d=UnitDefs[def]
    if not isSilo(d) then return end
    local x,_,z=Spring.GetUnitPosition(id)
    silos[id]={team=team,x=x,z=z,w=(d.xsize or 0)*8,d=(d.zsize or 0)*8}
    echo(string.format("silo finished team=%d id=%d at=%.0f,%.0f frame=%d",team,id,x,z,Spring.GetGameFrame()))
end
function widget:UnitDestroyed(id) silos[id]=nil; samples[id]=nil end
local function gridReport()
    local byTeam={}
    for id,s in pairs(silos) do byTeam[s.team]=byTeam[s.team] or {}; table.insert(byTeam[s.team],s) end
    for team,list in pairs(byTeam) do
        local touching,isolated=0,0
        for i=1,#list do
            local a=list[i]; local n=0
            for j=1,#list do if i~=j then
                local b=list[j]
                local dx,dz=math.abs(a.x-b.x),math.abs(a.z-b.z)
                if (dz<2 and math.abs(dx-a.w)<2) or (dx<2 and math.abs(dz-a.d)<2) then n=n+1 end
            end end
            if n>0 then touching=touching+1 else isolated=isolated+1 end
        end
        echo(string.format("grid team=%d silos=%d side-by-side=%d isolated=%d frame=%d",team,#list,touching,isolated,Spring.GetGameFrame()))
    end
end
function widget:GameFrame(f)
    if f%1800~=0 or f<25*1800 then return end
    gridReport()
    local stuck,nearSilo,checked=0,0,0
    for _,team in ipairs(Spring.GetTeamList()) do
        local _,_,_,isAI=Spring.GetTeamInfo(team,false)
        if isAI then
            for _,u in ipairs(Spring.GetTeamUnits(team) or {}) do
                local d=UnitDefs[Spring.GetUnitDefID(u)]
                if d and d.canMove and not d.canFly and not d.isBuilding then
                    local x,_,z=Spring.GetUnitPosition(u)
                    local cmds=Spring.GetUnitCommands(u,1)
                    local moving=cmds and cmds[1] and (cmds[1].id==CMD_MOVE or cmds[1].id==CMD_FIGHT or cmds[1].id==CMD_PATROL)
                    local s=samples[u]
                    if moving and s and f-s.frame>=3600 then
                        checked=checked+1
                        if (x-s.x)^2+(z-s.z)^2<64*64 then
                            stuck=stuck+1
                            local best=1e18
                            for _,si in pairs(silos) do best=math.min(best,(x-si.x)^2+(z-si.z)^2) end
                            if best<1000*1000 then nearSilo=nearSilo+1 end
                        end
                    end
                    if not s or f-s.frame>=3600 then samples[u]={x=x,z=z,frame=f} end
                end
            end
        end
    end
    echo(string.format("trapped frame=%d checked=%d stuck=%d within1000ofSilo=%d",f,checked,stuck,nearSilo))
end
