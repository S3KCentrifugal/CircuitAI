-- Read-only battle observer. No orders, resources or vision are changed.
function widget:GetInfo()
    return {name="Flank effectiveness", desc="Factory-origin combat outcomes", author="CircuitAI", layer=110, enabled=true}
end
local candidates, teams, factories = {}, {}, {}
local names={armsptk=true,cortermite=true,legsrail=true}
local function say(s) Spring.Echo("[FlankEffect] "..s) end
local function state(t)
    if not teams[t] then teams[t]={built=0,lost=0,lostMetal=0,damage=0,kills=0,killedMetal=0,structures=0,high=0,enemy=0} end
    return teams[t]
end
function widget:Initialize() say("loaded") end
function widget:UnitCreated(id,def,team,builder)
    candidates[id]=nil -- engine IDs can be reused
    if names[UnitDefs[def].name] and builder then
        candidates[id]={team=team,def=def,builder=builder,frame=Spring.GetGameFrame()}
    end
end
local function damageEvent(id,def,team,damage,paralyzer,weapon,projectile,attacker,attackerDef,attackerTeam)
    local u=candidates[attacker]
    if u and u.routed and not paralyzer and not Spring.AreTeamsAllied(team,u.team) then
        state(u.team).damage=state(u.team).damage+math.max(0,damage)
    end
end
-- BAR's widget handler drops the attacker arguments of UnitDamaged. Observe
-- the engine call-in before forwarding it unchanged to the ordinary handler.
local previousDamage, damageHook, damageCoverageLost
function widget:Shutdown()
    local env=getfenv(0)
    if damageHook and rawget(env,"UnitDamaged")==damageHook then
        rawset(env,"UnitDamaged",previousDamage); Script.UpdateCallIn("UnitDamaged")
    end
end
function widget:UnitDestroyed(id,def,team,attacker,attackerDef,attackerTeam)
    local a=candidates[attacker]
    if a and a.routed and not Spring.AreTeamsAllied(team,a.team) then
        local s=state(a.team)
        s.kills=s.kills+1; s.killedMetal=s.killedMetal+(UnitDefs[def].metalCost or 0)
        if UnitDefs[def].isImmobile then s.structures=s.structures+1 end
        say("kill team="..a.team.." attacker="..attacker.." victim="..UnitDefs[def].name.." metal="..(UnitDefs[def].metalCost or 0))
    end
    local u=candidates[id]
    if u and u.routed then
        local s=state(u.team); s.lost=s.lost+1; s.lostMetal=s.lostMetal+(UnitDefs[def].metalCost or 0)
        say("loss team="..team.." unit="..id.." killer="..(attackerDef and UnitDefs[attackerDef].name or "unknown"))
    end
    candidates[id]=nil
end
function widget:GameFrame(f)
    if f==150 then
        local env=getfenv(0)
        previousDamage=rawget(env,"UnitDamaged")
        damageHook=function(...)
            damageEvent(...)
            if previousDamage then return previousDamage(...) end
        end
        rawset(env,"UnitDamaged",damageHook); Script.UpdateCallIn("UnitDamaged")
        say("exact damage observer installed")
    end
    if f%150~=0 then return end
    if damageHook and rawget(getfenv(0),"UnitDamaged")~=damageHook and not damageCoverageLost then
        damageCoverageLost=true
        say("damage coverage incomplete: LuaUI replaced the observer; use kills/losses, not damageRaw totals")
    end
    for id,u in pairs(candidates) do
        if Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
            local x,y,z=Spring.GetUnitPosition(id)
            local _,_,_,_,bp=Spring.GetUnitHealth(id)
            if not u.routed and bp and bp>=1 then
                local cmds=Spring.GetUnitCommands(id,500) or {}
                local moves,high=0,0
                local sx,sy,sz=Spring.GetTeamStartPosition(u.team)
                local base=Spring.GetGroundHeight(sx,sz)
                for _,c in ipairs(cmds) do
                    if c.id==CMD.MOVE and #c.params>=3 then
                        moves=moves+1
                        if c.params[2]>base+150 then high=high+1 end
                    end
                end
                if moves>=12 and high>=3 then
                    u.routed=true; state(u.team).built=state(u.team).built+1
                    if not factories[u.builder] then
                        factories[u.builder]=true
                        local fx,fy,fz=Spring.GetUnitPosition(u.builder)
                        say("factory team="..u.team.." id="..u.builder.." pos="..tostring(fx)..","..tostring(fz).." unit="..UnitDefs[u.def].name.." waypoints="..moves)
                    end
                end
            end
            if u.routed then
                local sx,_,sz=Spring.GetTeamStartPosition(u.team)
                if not u.high and y>Spring.GetGroundHeight(sx,sz)+150 then u.high=true; state(u.team).high=state(u.team).high+1 end
                local enemyX,_,enemyZ=Spring.GetTeamStartPosition(u.team==0 and 1 or 0)
                if not u.enemy and (x-enemyX)^2+(z-enemyZ)^2<1800^2 then u.enemy=true; state(u.team).enemy=state(u.team).enemy+1 end
            end
        end
    end
    if f%1800==0 then
        for t,s in pairs(teams) do
            local alive,army=0,0
            local samples={}
            for id,u in pairs(candidates) do if u.team==t and u.routed then
                alive=alive+1; army=army+(UnitDefs[u.def].metalCost or 0)
                if #samples<3 then
                    local x,y,z=Spring.GetUnitPosition(id)
                    samples[#samples+1]=string.format("%d@%.0f,%.0f,%.0f",id,x,y,z)
                end
            end end
            say(string.format("minute=%.1f team=%d produced=%d alive=%d armyMetal=%.0f lost=%d lostMetal=%.0f damageRaw=%.0f kills=%d killedMetal=%.0f structures=%d high=%d enemyBase=%d samples=%s",f/1800,t,s.built,alive,army,s.lost,s.lostMetal,s.damage,s.kills,s.killedMetal,s.structures,s.high,s.enemy,table.concat(samples,";")))
        end
    end
end
