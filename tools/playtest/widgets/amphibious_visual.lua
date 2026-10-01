-- Test-only camera observer. Never orders units or changes AI decisions.
function widget:GetInfo()
    return {name="Amphibious visual observer",desc="Screenshots of actual amphibious movements",author="CircuitAI",layer=115,enabled=true}
end
local seen, submerged, queue = {}, {}, {}
local pending, caption, lastShot = nil, "", -10000
local function echo(s) Spring.Echo("[AmphVisual] "..s) end
local function enqueue(key,id,label)
    if seen[key] then return end
    seen[key]=true
    queue[#queue+1]={id=id,label=label}
end
local function alive(id) return Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) end
function widget:Initialize() echo("widget loaded") end
local function restoreSpeed()
    if pending and pending.speed then Spring.SendCommands({"setmaxspeed "..pending.speed,"setminspeed "..pending.speed}) end
end
function widget:Shutdown() restoreSpeed() end
function widget:GameFrame(f)
    if f<930 or f%15~=0 then return end
    for team=0,1 do
        for _,id in ipairs(Spring.GetTeamUnits(team)) do
            local def=UnitDefs[Spring.GetUnitDefID(id)]
            if def and (def.name=="legamph" or def.name=="armmar") then
                local x,y,z=Spring.GetUnitPosition(id)
                local depth=Spring.GetGroundHeight(x,z)
                local kind=def.name=="legamph" and "Telchines" or "Marauders"
                local role=team==0 and "TECH" or "AIR"
                local key=team..":"..def.name
                if depth < -30 then
                    submerged[id]=true
                    if team==0 then enqueue(key..":water",id,role.." "..kind.." - underwater crossing") end
                elseif depth>=0 and submerged[id] then
                    enqueue(key..":land",id,role.." "..kind.." - actual landfall")
                end
                local sx,sy,sz=Spring.GetTeamStartPosition(team)
                local ex,ey,ez=Spring.GetTeamStartPosition(2)
                if depth>=0 and (x-ex)^2+(z-ez)^2<0.35^2*((sx-ex)^2+(sz-ez)^2) then
                    enqueue(key..":enemy",id,role.." "..kind.." - enemy-side land push")
                end
                if team==0 and f>=9000 then enqueue(key..":late",id,role.." "..kind.." - five-minute position") end
            end
        end
    end
end
function widget:Update()
    if pending then
        if pending.draws>=3 and Spring.DiffTimers(Spring.GetTimer(),pending.started)>=1.3 then
            Spring.SendCommands("screenshot png")
            echo(string.format("screenshot frame=%d unit=%d at=%.0f,%.0f label=%s",Spring.GetGameFrame(),pending.id,pending.x,pending.z,pending.label))
            restoreSpeed();pending=nil;lastShot=Spring.GetGameFrame()
        end
        return
    end
    if #queue==0 or Spring.GetGameFrame()-lastShot<180 then return end
    local item=table.remove(queue,1)
    if not alive(item.id) then return end
    local x,y,z=Spring.GetUnitPosition(item.id)
    -- Frame the nearby members of this wave, with the land edge visible.
    local group={}
    for _,id in ipairs(Spring.GetTeamUnits(Spring.GetUnitTeam(item.id))) do
        if Spring.GetUnitDefID(id)==Spring.GetUnitDefID(item.id) then
            local ux,uy,uz=Spring.GetUnitPosition(id)
            if ux and (ux-x)^2+(uz-z)^2<1000^2 then group[#group+1]=id end
        end
    end
    Spring.SelectUnitArray(group)
    Spring.SendCommands("viewta")
    Spring.SetCameraTarget(x,math.max(0,Spring.GetGroundHeight(x,z)),z,0)
    Spring.SetCameraState({height=1600,dist=1600},0)
    caption=item.label..string.format(" | %.2f game minutes | %d nearby units",Spring.GetGameFrame()/1800,#group)
    item.x,item.z,item.started,item.draws=x,z,Spring.GetTimer(),0
    item.speed=Spring.GetGameSpeed()
    -- Recoil rejects setmaxspeed <= 0.2; use a supported slow-motion speed.
    Spring.SendCommands({"setminspeed 0.25","setmaxspeed 0.25"})
    pending=item
end
function widget:DrawScreen()
    if pending then pending.draws=pending.draws+1 end
    if caption=="" then return end
    local w,h=Spring.GetViewGeometry()
    gl.Color(0,0,0,0.8);gl.Rect(310,h-95,w-15,h-40)
    gl.Color(1,1,1,1);gl.Text(caption,322,h-64,18,"o")
    gl.Text("Controlled capability fixture: supplied units, frozen construction, full vision",322,h-84,13,"o")
end
