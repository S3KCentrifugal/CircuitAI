-- Observer only: no resources, units or orders are supplied.
function widget:GetInfo()
    return {name="TECH T2 start observer", author="CircuitAI", layer=110, enabled=true}
end
local built, totals = {}, {}
local watched = {legamph=true, legstr=true, armfast=true, corpyro=true, armamph=true, coramph=true}
local function log(s) Spring.Echo("[TechT2Start] "..s) end
function widget:Initialize() log("loaded observer_only=1") end
function widget:UnitCreated(id, def, team, builder)
    local d = UnitDefs[def]
    if d and watched[d.name] and builder then
        built[id] = true
        log(string.format("created team=%d name=%s id=%d builder=%d",team,d.name,id,builder))
    end
end
function widget:UnitFinished(id, def, team)
    local d = UnitDefs[def]
    if not built[id] or not d then return end
    local key = team..":"..d.name
    totals[key] = (totals[key] or 0)+1
    log(string.format("finished team=%d name=%s count=%d id=%d",team,d.name,totals[key],id))
    built[id] = nil
end
function widget:UnitDestroyed(id) built[id] = nil end
