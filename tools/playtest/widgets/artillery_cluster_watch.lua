function widget:GetInfo() return {name="Artillery cluster regression",layer=10,enabled=true} end
local side="__SIDE__"
local t2=__T2__
local units={armada={"armnanotc","armllt","armbeamer",t2 and "armamb" or "armguard","armck","armack"},
    cortex={"cornanotc","corllt","corhllt",t2 and "cortoast" or "corpun","corck","corack"},
    legion={"legnanotc","leglht","legmg",t2 and "legacluster" or "legcluster","legck","legack"}}
local defs=units[side]
local created,finished={},{}
local passed=false
local function log(s) Spring.Echo("[ArtilleryWatch] "..s) end
function widget:Initialize()
    Spring.SendCommands("cheat")
    Spring.SendCommands("specfullview")
    log("loaded")
end
function widget:GameFrame(f)
    if f==30 then
        Spring.SendCommands("give 1 armhlt 0 @6000,0,4000")
        for i=5,6 do Spring.SendCommands("give 1 "..defs[i].." 0 @5700,0,"..(4100+i*40)) end
        Spring.SendCommands("give 2 corafus 0 @2000,0,5000")
    end
    if f%15~=0 then return end
    if f%30==0 then Spring.SendCommands("atm") end
    local points={}
    local all=true
    for k=1,4 do
        local count=0
        for _,id in ipairs(Spring.GetTeamUnits(0) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(id) or -1]
            if d and d.name==defs[k] then
                count=count+1
                local x,_,z=Spring.GetUnitPosition(id)
                local _,_,_,_,p=Spring.GetUnitHealth(id)
                points[k]={id=id,x=x,z=z,range=d.buildDistance or d.builddistance or 0,p=p}
                if not created[k] then
                    created[k]=f
                    if k>1 and not finished[k-1] then log("ERROR step began before previous finished step="..k) end
                    if k==4 and t2 and f<21600 then log("ERROR T2 before twelve minutes") end
                    log(string.format("created step=%d def=%s id=%d frame=%d x=%.0f z=%.0f",k,d.name,id,f,x,z))
                end
                if p and p>=1 and not finished[k] then
                    finished[k]=f
                    log("finished step="..k.." frame="..f)
                end
            end
        end
        if count>1 then log("ERROR duplicate step="..k) end
        if not points[k] or not points[k].p or points[k].p<1 then all=false end
    end
    if all and not passed then
        local n=points[1]
        -- Ally/enemy starts share z; this fixture's enemy direction is +x.
        for k=2,3 do
            if points[k].x<=math.max(n.x,points[4].x) then log("ERROR defensive gun behind rear row") return end
        end
        for k=2,4 do
            local p=points[k]
            local distance=math.sqrt((p.x-n.x)^2+(p.z-n.z)^2)
            log(string.format("nano reach step=%d distance=%.2f radius=%.2f",k,distance,n.range))
            if n.range<=0 or distance>n.range-15 then log("ERROR outside nano reach") return end
        end
        passed=true
        log("PASS ordered four completed structures; front guns ahead; nano covers all three")
    end
end
