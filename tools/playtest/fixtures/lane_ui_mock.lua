-- Lua 5.1 rendering/interaction harness. No engine, GPU or live installation.
local function noop() end
widget={}; WG={}; UnitDefs={}; Game={mapSizeX=16384,mapSizeZ=8192}
GL={LINES=1,LINE_STRIP=2,TRIANGLE_FAN=3,LINE_LOOP=4}
gl=setmetatable({GetViewSizes=function() return 1920,1080 end,
    GetTextWidth=function(s) return #s*0.5 end,
    BeginEnd=function(_,f,...) f(...) end}, {__index=function() return noop end})
Spring=setmetatable({
    GetViewGeometry=function() return 1920,1080 end, GetSpectatingState=function() return true end,
    GetTeamList=function() local t={} for i=0,15 do t[#t+1]=i end return t end,
    GetTeamInfo=function(id) return id,0,false,true,'cortex',math.floor(id/8) end,
    GetAIInfo=function(id) return id,'Player '..id,0 end, GetMyPlayerID=function() return 0 end,
    GetTeamColor=function() return 1,0.5,0.2 end, GetMyTeamID=function() return 0 end,
    GetConfigFloat=function(_,v) return v end, GetGameFrame=function() return 44400 end,
    GetMouseState=function() return 100,100 end, GetTimer=function() return 1 end,
    DiffTimers=function() return 1 end, GetGroundHeight=function() return 0 end,
    WorldToScreenCoords=function(x,y,z) return x/10,z/10,0.5 end,
    IsGUIHidden=function() return false end, GetTeamStartPosition=function() return 100,0,100 end,
    GetTeamUnits=function() return {} end,
}, {__index=function() return noop end})
VFS={FileExists=function() return false end}; widgetHandler={}; Script={}; KEYSYMS={}

function publish(team,lanes,points,cls)
    local prefix='barbtheatre|1|'..team..'|'
    widget:RecvSkirmishAIMessage(team,prefix..'begin|30,10')
    for lane=0,lanes-1 do
        local pts={} for i=1,points do pts[#pts+1]=(i*30)..','..(1000+team*100) end
        widget:RecvSkirmishAIMessage(team,prefix..'lane|'..lane..','..(cls or 4)..'|'..table.concat(pts,';'))
    end
    widget:RecvSkirmishAIMessage(team,prefix..'show|')
end
function click(id)
    local r=assert(WG.barblink.ButtonRect(id),'missing control '..id)
    local x,y=(r[1]+r[3])/2,(r[2]+r[4])/2
    WG.barblink.MousePress(x,y,1); WG.barblink.MouseRelease(x,y,1)
end
