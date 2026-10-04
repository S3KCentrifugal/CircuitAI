function widget:GetInfo()
    return {name="AIR workforce observer",desc="Observe mobile economy command ownership and throughput",author="CircuitAI",layer=122,enabled=true}
end
local guards, reported = {}, {}
function widget:GameFrame(f)
    if f%30~=0 then return end
    local t1,t2,nanos,working,idle,guarded=0,0,0,0,0,0
    local workingBP, idleBP, nanoWorking, factoriesWorking = 0,0,0,0
    for _,id in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        local _,_,_,_,p=Spring.GetUnitHealth(id)
        if p and p>=1 then
            local aircraft=d.canFly and d.isBuilder and d.buildSpeed>0
            if aircraft then
                if tonumber((d.customParams or {}).techlevel or 1)>=2 then t2=t2+1 else t1=t1+1 end
                local c=(Spring.GetUnitCommands(id,1) or {})[1]
                if c and c.id==CMD.GUARD then
                    guarded=guarded+1; guards[id]=guards[id] or f
                    if f-guards[id]>300 and not reported[id] then
                        Spring.Echo("[INVARIANT] INV-106 AIR observer: mobile economy aircraft retains guard id="..id.." target="..tostring(c.params[1]))
                        reported[id]=true
                    end
                else guards[id]=nil;reported[id]=nil end
                if Spring.GetUnitIsBuilding(id) then working=working+1;workingBP=workingBP+d.buildSpeed
                else idle=idle+1;idleBP=idleBP+d.buildSpeed end
            elseif d.name=="armnanotc" or d.name=="cornanotc" or d.name=="legnanotc" then
                nanos=nanos+1
                if Spring.GetUnitIsBuilding(id) then nanoWorking=nanoWorking+1;workingBP=workingBP+d.buildSpeed end
            elseif d.isFactory and Spring.GetUnitIsBuilding(id) then factoriesWorking=factoriesWorking+1 end
        end
    end
    if f%900==0 then
        local m,ms,mp,mi,mu,_,sent,mr,excess=Spring.GetTeamResources(0,"metal")
        local e,_,_,ei,eu=Spring.GetTeamResources(0,"energy")
        Spring.Echo(string.format("[AirWorkforce] frame=%d t1=%d t2=%d nanos=%d working=%d idle=%d guards=%d metal=%.0f/%.0f income=%.1f pull=%.1f received=%.1f energy=%.0f incomeE=%.1f usageM=%.1f usageE=%.1f sent=%.1f excess=%.1f workingBP=%.1f idleBP=%.1f nanoWorking=%d factoriesWorking=%d",f,t1,t2,nanos,working,idle,guarded,m,ms,mi,mp,mr or 0,e,ei,mu or 0,eu or 0,sent or 0,excess or 0,workingBP,idleBP,nanoWorking,factoriesWorking))
    end
end
