function widget:GetInfo() return {name="Commander idle probe",layer=130,enabled=true} end
local commander,feature,fx,fz,originX,originZ,chosen,commandSeen,reclaimed
local maxTravelSq=0
local function log(pass,key) Spring.Echo("[CommanderIdleProbe] "..(pass and "PASS " or "FAIL ")..key) end
function widget:GameFrame(frame)
    if frame==2100 then
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            if d and d.customParams and d.customParams.iscommander then commander=id;break end
        end
        if not commander then log(false,"commander_missing");return end
        originX,_,originZ=Spring.GetUnitPosition(commander)
        local candidates={}
        for _,d in pairs(FeatureDefs) do
            if d.reclaimable and (d.metal or 0)==0 and (d.energy or 0)>=100 then candidates[#candidates+1]=d.name end
        end
        table.sort(candidates);chosen=candidates[1]
        if not chosen then log(false,"energy_feature_unavailable");return end
        fx,fz=originX+80,originZ
        Spring.SendCommands(string.format("give 1 %s @%d,%d,%d",chosen,fx,Spring.GetGroundHeight(fx,fz),fz))
    end
    if frame==2130 and chosen then
        for _,id in ipairs(Spring.GetFeaturesInCylinder(fx,fz,24)) do
            if FeatureDefs[Spring.GetFeatureDefID(id)].name==chosen then feature=id;break end
        end
        log(feature~=nil,"energy_feature")
    end
    if frame>2130 and frame<4500 and feature and commander and Spring.ValidUnitID(commander) then
        local x,_,z=Spring.GetUnitPosition(commander)
        maxTravelSq=math.max(maxTravelSq,(x-originX)^2+(z-originZ)^2)
        local cmd=Spring.GetUnitCurrentCommand(commander)
        if cmd==CMD.RECLAIM and not commandSeen then commandSeen=true;log(true,"reclaim_command") end
        if commandSeen and not Spring.ValidFeatureID(feature) and not reclaimed then reclaimed=true;log(true,"reclaimed") end
    end
    if frame==4500 then
        if not commander or not Spring.ValidUnitID(commander) then log(false,"commander_lost");return end
        local x,_,z=Spring.GetUnitPosition(commander)
        local stationary=originX and math.max(maxTravelSq,(x-originX)^2+(z-originZ)^2)<=8^2
        log(stationary,"stationary")
        log(reclaimed and commandSeen and stationary,"complete")
    end
end
