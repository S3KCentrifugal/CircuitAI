-- prepare_team_share_check.py prefixes local donors from the staged teams.json.
function widget:GetInfo()
    return {name="Team metal share fixture", desc="Supplied overflow for every role",
        author="CircuitAI", layer=123, enabled=true}
end
local pending, lastPhase = nil, "Waiting for openings"
local lastTransfer, firstFactory = {}, {}
local function echo(s) Spring.Echo("[ShareFixture] "..s) end
local function hasFactory(team)
    for _,id in ipairs(Spring.GetTeamUnits(team) or {}) do
        local ud=UnitDefs[Spring.GetUnitDefID(id)]
        local _,_,_,_,progress=Spring.GetUnitHealth(id)
        if ud and ud.isFactory and progress and progress>=1 then return true end
    end
    return false
end
function widget:Initialize()
    echo("loaded; supplied banks/fallback factories, not natural economy evidence")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    -- A full TECH start bank must not be donated before its first lab.
    if f==450 then Spring.SendCommands("team 0") end
    if f==480 then
        Spring.SetShareLevel("metal",1)
        Spring.SendCommands("atm 10000")
        echo("opening full bank probe team=0 factory="..tostring(hasFactory(0)))
    end
    if f==510 then Spring.SendCommands("spectator") end
    if f==2700 then
        for _,d in ipairs(donors) do
            if not hasFactory(d.team) then
                Spring.SendCommands("give "..d.factory.." "..d.team.." @"..d.x..",0,"..d.z)
                echo("supplied completed factory role="..d.role.." team="..d.team)
            end
        end
    end
    -- Stagger full banks so another teammate still has room to receive metal.
    for i,d in ipairs(donors) do
        if f==3600+(i-1)*600 then
            Spring.SendCommands("team "..d.team)
            pending={d=d,frame=f+30}
        end
    end
    if pending and f==pending.frame then
        Spring.SetShareLevel("metal",1)
        Spring.SendCommands("atm 10000")
        lastPhase="Full bank supplied: "..pending.d.role.." (team "..pending.d.team..")"
        echo(lastPhase.." completedFactory="..tostring(hasFactory(pending.d.team)))
    end
    if pending and f==pending.frame+30 then Spring.SendCommands("spectator"); pending=nil end
    if f%30==0 then
        for _,d in ipairs(donors) do
            local bank,storage,_,_,_,_,sent,received=Spring.GetTeamResources(d.team,"metal")
            if bank then
                if (sent or 0)>=25 then lastTransfer[d.role]=sent end
                if (sent or 0)>0 or (received or 0)>0 then
                    echo(string.format("role=%s team=%d bank=%.1f storage=%.1f sent=%.1f received=%.1f",
                        d.role,d.team,bank,storage,sent or 0,received or 0))
                end
            end
        end
    end
end
function widget:UnitFinished(id,def,team)
    if UnitDefs[def].isFactory and not firstFactory[team] then
        firstFactory[team]=Spring.GetGameFrame()
        echo("first completed factory team="..team.." frame="..firstFactory[team])
    end
end
function widget:DrawScreen()
    gl.Color(0,0,0,0.75); gl.Rect(20,40,530,290); gl.Color(1,1,1,1)
    gl.Text("SHARED METAL DONATION TEST",35,260,20,"o")
    gl.Text("95% threshold / 20% capacity / 5 seconds",35,230,15,"o")
    gl.Text(lastPhase,35,205,14,"o")
    for i,d in ipairs(donors) do
        gl.Text(string.format("%s: last engine send sample %.0f",d.role,lastTransfer[d.role] or 0),
            35,180-(i-1)*20,14,"o")
    end
end
