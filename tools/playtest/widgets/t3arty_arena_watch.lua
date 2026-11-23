-- T3 artillery heavy-porc arena watch (owner 2026-11-23, test only). Lines: [T3Arty] ...
-- Per AI Daedalus/Myrmidon (team 0): every 2 s distance to the nearest enemy structure; first frame within 98% of
-- its real weapon range (Daedalus rail 1000, Myrmidon cluster plasma 1100) of any structure; deaths with killer;
-- host structure deaths with killer. Final SUMMARY lines at frame cfg.unitsAt + watchSec.
function widget:GetInfo()
    return {name="T3 arty arena watch",desc="close-to-98% check",layer=124,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/gantry_march.lua")
local A=0
local REACH={legerailtank=1000*0.98, legeallterrainmech=1100*0.98}
for _,n in ipairs({"corcat","armmerl","legbart"}) do if UnitDefNames[n] then REACH[n]=(UnitDefNames[n].maxWeaponRange or 0)*0.97 end end
local units={}   -- id -> {def, minD, in98, dead, by}
local done=false
local function echo(s) Spring.Echo("[T3Arty] "..s) end
local function isStructure(d) return d and (d.isImmobile or not d.canMove) and not d.canFly end
function widget:UnitDestroyed(u,ud,team,attacker,adef)
    local d=UnitDefs[ud]; local an=adef and UnitDefs[adef] and UnitDefs[adef].name or "-"
    local f=Spring.GetGameFrame()
    if units[u] then units[u].dead=f; units[u].by=an; echo(string.format("death f=%d id=%d %s by=%s",f,u,units[u].def,an))
    elseif team~=A and isStructure(d) and d.name~="armdrag" then echo(string.format("structure died f=%d %s id=%d by=%s",f,d.name,u,an)) end
end
function widget:GameFrame(f)
    if f<(cfg.unitsAt or 600)+30 or f%60~=0 or done then return end
    for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and REACH[d.name] and not units[u] then units[u]={def=d.name,minD=1e9,given=f} end
    end
    local structs={}
    for _,t in ipairs(Spring.GetTeamList() or {}) do
        if t~=A and t~=Spring.GetGaiaTeamID() then
            for _,s in ipairs(Spring.GetTeamUnits(t) or {}) do
                local sd=UnitDefs[Spring.GetUnitDefID(s)]
                if isStructure(sd) and sd.name~="armdrag" then local x,_,z=Spring.GetUnitPosition(s); structs[#structs+1]={s,sd.name,x,z} end
            end
        end
    end
    for u,t in pairs(units) do
        if not t.dead and Spring.ValidUnitID(u) then
            local x,_,z=Spring.GetUnitPosition(u)
            local best,bn=1e9,"-"
            for _,s in ipairs(structs) do local dd=math.sqrt((s[3]-x)^2+(s[4]-z)^2); if dd<best then best=dd; bn=s[2] end end
            t.minD=math.min(t.minD,best)
            if best<=REACH[t.def]+16 and not t.in98 then t.in98=f; echo(string.format("within98 f=%d id=%d %s of %s d=%.0f after=%.1f",f,u,t.def,bn,best,(f-t.given)/30)) end
            if f%600==0 then echo(string.format("pos f=%d id=%d %s at=%.0f,%.0f nearestStructure=%s@%.0f",f,u,t.def,x,z,bn,best)) end
        end
    end
    if f>=(cfg.unitsAt or 600)+(cfg.watchSec or 480)*30 then
        done=true
        for u,t in pairs(units) do
            echo(string.format("SUMMARY id=%d %s closest=%.0f reach98=%.0f within98=%s dead=%s by=%s",u,t.def,t.minD,REACH[t.def],
                t.in98 and string.format("%.1fs",(t.in98-t.given)/30) or "never",tostring(t.dead or "no"),t.by or "-"))
        end
    end
end
