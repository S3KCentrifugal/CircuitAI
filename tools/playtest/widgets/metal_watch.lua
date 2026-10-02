function widget:GetInfo()
    return {name="Metal field observer", desc="Read-only economy and converter census", author="CircuitAI", layer=111, enabled=true}
end
local tag = "[MetalWatch] "
local created = {}
local function converter(d)
    local p = d.customParams or {}
    return (tonumber(p.energyconv_capacity) or 0) > 0 and (tonumber(p.energyconv_efficiency) or 0) > 0
end
local function sample(frame)
    for _, team in ipairs(Spring.GetTeamList()) do
        local _,_,dead,isAI = Spring.GetTeamInfo(team, false)
        if isAI and not dead then
            local mex, conv, wind, labs, workers, building = 0,0,0,0,0,0
            local yield = 0
            for _, id in ipairs(Spring.GetTeamUnits(team)) do
                local d = UnitDefs[Spring.GetUnitDefID(id)]
                local _,_,_,_,progress = Spring.GetUnitHealth(id)
                if converter(d) then conv = conv + 1 end
                if (d.extractsMetal or 0) > 0 and progress >= 1 then
                    mex = mex + 1
                    local mm = Spring.GetUnitResources(id)
                    yield = yield + (mm or 0)
                end
                if (d.windGenerator or 0) > 0 and progress >= 1 then wind = wind + 1 end
                if d.isFactory and progress >= 1 then labs = labs + 1 end
                if d.isBuilder and not d.isFactory and progress >= 1 then workers = workers + 1 end
                if progress < 1 then building = building + 1 end
            end
            local mc,ms,_,mi,me,_,_,_,mp = Spring.GetTeamResources(team,"metal")
            local ec,es,_,ei,ee,_,_,_,ep = Spring.GetTeamResources(team,"energy")
            Spring.Echo(tag..string.format("sample frame=%d team=%d mex=%d mexYield=%.2f converters=%d converterStarts=%d wind=%d labs=%d workers=%d frames=%d M=%.1f bankM=%.1f/%.1f spendM=%.1f E=%.1f bankE=%.1f/%.1f spendE=%.1f",frame,team,mex,yield,conv,created[team] or 0,wind,labs,workers,building,mi,mc,ms,me,ei,ec,es,ee))
        end
    end
end
function widget:UnitCreated(id, defID, team)
    if UnitDefs[defID].isFactory then
        Spring.Echo(tag.."factory-created frame="..Spring.GetGameFrame().." team="..team.." def="..UnitDefs[defID].name)
    end
    if converter(UnitDefs[defID]) then
        created[team] = (created[team] or 0) + 1
        Spring.Echo(tag.."converter-created team="..team.." def="..UnitDefs[defID].name)
    end
end
function widget:UnitFinished(id, defID, team)
    if UnitDefs[defID].isFactory then
        Spring.Echo(tag.."factory-finished frame="..Spring.GetGameFrame().." team="..team.." def="..UnitDefs[defID].name)
    end
    if (UnitDefs[defID].extractsMetal or 0) > 0 then
        local x, _, z = Spring.GetUnitPosition(id)
        Spring.Echo(tag..string.format("mex-finished frame=%d team=%d id=%d x=%.0f z=%.0f def=%s",
            Spring.GetGameFrame(), team, id, x, z, UnitDefs[defID].name))
    end
end
function widget:GameFrame(frame)
    if frame == 30 then Spring.Echo(tag.."classification mex_count="..tostring(Spring.GetGameRulesParam("mex_count"))) end
    if frame > 0 and frame % 900 == 0 then sample(frame) end
end
