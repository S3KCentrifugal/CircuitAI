function widget:GetInfo()
    return {name="Tactical guide UX checks",desc="Real controls, fresh surveys, map screenshots",author="CircuitAI",layer=110,enabled=true}
end
local stage, frozenFrame = 0,nil
local function buildSite(def,x,y,z)
    if not def then return 0 end
    local direct=Spring.TestBuildOrder(def.id,x,y,z,0)
    if direct>0 then return direct end
    local builder=UnitDefNames.legaceb
    local reach=builder and UnitDefs[builder.id].buildDistance or 0
    -- Placement is beside the travel line, within the actual constructor's
    -- reach. This is a test probe, not widget-side planning or build orders.
    for dx=-96,96,96 do for dz=-96,96,96 do
        local px,pz=x+dx,z+dz
        if px>=0 and pz>=0 and px<Game.mapSizeX and pz<Game.mapSizeZ then
            local py=Spring.GetGroundHeight(px,pz)
            if dx*dx+dz*dz+(py-y)^2<=reach*reach then
                local b=Spring.TestBuildOrder(def.id,px,py,pz,0)
                if b>0 then return b end
            end
        end
    end end
    return 0
end
local function shelfMetrics(route, name)
    if not route or not Game.mapName:find("Glacial") then return end
    local count, high, steep, buildable, defenses, height = 0,0,0,0,0,0
    local lateral, streak, longest = 0,0,0
    local radar = UnitDefNames.legarad
    local defense = UnitDefNames.legacluster
    local f = io.open("shelf-"..name..".csv", "w")
    if f then f:write("x,z,height,slope,buildable\n") end
    for i,p in ipairs(route.points) do
        if p[1]>Game.mapSizeX*0.2 and p[1]<Game.mapSizeX*0.8 then
            local h=Spring.GetGroundHeight(p[1],p[2])
            local _,_,_,s=Spring.GetGroundNormal(p[1],p[2],true)
            local b=buildSite(radar,p[1],h,p[2])
            local d=buildSite(defense,p[1],h,p[2])
            count=count+1; height=height+h
            if s>0.412 then steep=steep+1 end
            local grade=0
            for _,j in ipairs({i-1,i+1}) do
                local q=route.points[j]
                if q then
                    local distance=math.sqrt((q[1]-p[1])^2+(q[2]-p[2])^2)
                    grade=math.max(grade,math.abs(Spring.GetGroundHeight(q[1],q[2])-h)/math.max(1,distance))
                end
            end
            if s>0.412 and grade<0.5 then lateral=lateral+1; streak=streak+1 else streak=0 end
            longest=math.max(longest,streak)
            if p[2]<Game.mapSizeZ*0.1 or p[2]>Game.mapSizeZ*0.9 then high=high+1 end
            if b>0 then buildable=buildable+1 end
            if d>0 then defenses=defenses+1 end
            if f then f:write(p[1],",",p[2],",",h,",",s,",",b,"\n") end
        end
    end
    if f then f:close() end
    Spring.Echo(string.format("[TacticalGuide] shelf %s route=%d lesson=%d samples=%d edge=%d steep=%d buildable=%d defenses=%d meanHeight=%.1f",
        name,route.id,route.lesson,count,high,steep,buildable,defenses,height/math.max(1,count)))
    Spring.Echo(string.format("[TacticalGuide] shelf %s lateral=%d longest=%d",name,lateral,longest))
    -- Glacial Gap v1.1's upper shelves are approximately 500 elmos high.
    -- A valley route that merely touches the ridge must fail this fixture.
    -- Short steep crossings of the cuts are desirable; sustained sideways
    -- travel along a cliff is the regression. Do not count them as equivalent.
    local sustained = count>30 and height/count>=450 and high/count>=0.8 and lateral/count<=0.05 and longest<=1
    Spring.Echo("[TacticalGuide] "..(sustained and "PASS " or "FAIL ")..name.." sustained upper shelf")
    local construction = count>30 and buildable/count>=0.7 and defenses/count>=0.6
    Spring.Echo("[TacticalGuide] "..(construction and "PASS " or "FAIL ")..name.." Legion shelf construction sites")
end
local function check(ok,name) Spring.Echo("[TacticalGuide] "..(ok and "PASS " or "FAIL ")..name) end
local function click(ui,id)
    local r=ui.ButtonRect(id)
    if not r then check(false,"missing control "..id); return end
    local x,y=(r[1]+r[3])/2,(r[2]+r[4])/2
    ui.MousePress(x,y,1); ui.MouseRelease(x,y,1)
end
local function choose(ui,cls)
    local s=ui.TheatreSnapshot(0)
    if s then for _,l in ipairs(s.details) do if l.class==cls then ui.SelectLane(0,l.id); return l end end end
end
local function mountain(ui,south)
    local team=(south and Game.mapName:find("Glacial")) and 1 or 0
    local s=ui.TheatreSnapshot(team); local best,score=nil,south and -1 or 1e9
    if Game.mapName:find("Glacial") then
        -- Select a sustained mountain crossing, not the lane with one extreme
        -- point followed by a long valley route.
        local bestHeight=-1e9
        if s then for _,l in ipairs(s.details) do if l.class==4 then
            local h,z,n=0,0,0
            for _,p in ipairs(l.points) do
                if p[1]>Game.mapSizeX*0.2 and p[1]<Game.mapSizeX*0.8 then
                    h=h+Spring.GetGroundHeight(p[1],p[2]); z=z+p[2]; n=n+1
                end
            end
            if n>20 and (south and z/n>Game.mapSizeZ*0.75 or not south and z/n<Game.mapSizeZ*0.25)
                and h/n>bestHeight then best,bestHeight,score=l,h/n,z/n end
        end end end
        if best then ui.SelectLane(team,best.id) end
        return best,score
    end
    if s then for _,l in ipairs(s.details) do if l.class==4 and (not Game.mapName:find("Ascendancy") or l.lesson==5) then
        for _,p in ipairs(l.points) do if p[1]>Game.mapSizeX*0.35 and p[1]<Game.mapSizeX*0.65 then
            if (south and p[2]>score) or (not south and p[2]<score) then best,score=l,p[2] end
        end end
    end end end
    if best then ui.SelectLane(team,best.id) end
    return best,score
end
function widget:Initialize()
    Spring.Echo("[TacticalGuide] loaded")
    Spring.Echo("[TacticalGuide] engine armor vtol="..tostring(Game.armorTypes.vtol).." subs="..tostring(Game.armorTypes.subs))
end
function widget:GameFrame(f)
    local ui=WG.barblink; if not ui then return end
    if stage==0 and f>=330 then
        -- Test presentation only: remove diagnostic chat from the screenshots.
        Spring.SendCommands("luaui disablewidget Chat", "console 0")
        ui.SetOpen(false)
        ui.TheatreOptions({live=true,routes=true,sites=false,shores=false,cues=true,teaching=true,labels=true,context=false,opacity=0.85,collapsed=false})
        ui.SetTheatres(Game.mapName:find("Glacial") and "all" or 0); stage=1
    elseif stage==1 and f>=600 then
        Spring.SendSkirmishAIMessage(0,"barb|draw|0|clear")
        local s=ui.TheatreSnapshot(0)
        check(s and s.lanes>0 and s.details[1].revision,"AI metadata")
        if s then
            for c,n in pairs(s.classes) do Spring.Echo("[TacticalGuide] class "..c.." lanes "..n) end
            for _,l in ipairs(s.details) do
                local minZ,maxZ=1e9,-1
                for _,p in ipairs(l.points) do minZ=math.min(minZ,p[2]); maxZ=math.max(maxZ,p[2]) end
                Spring.Echo("[TacticalGuide] lane "..l.id.." class "..l.class.." mask "..tostring(l.mask).." z "..minZ..".."..maxZ
                    .." lesson "..tostring(l.lesson).." anchor "..(l.anchor and table.concat(l.anchor,",") or "none"))
            end
        end
        if Game.mapName:find("Ascendancy") or Game.mapName:find("Glacial") then
            local route,z=mountain(ui,false)
            shelfMetrics(route,"north")
            check(route and z<Game.mapSizeZ*(Game.mapName:find("Ascendancy") and 0.15 or 0.18),"northern mountain crossing")
            if Game.mapName:find("Ascendancy") then
                check(route and route.lesson==5 and route.anchor and route.anchor[1]>Game.mapSizeX*0.88
                    and route.anchor[2]<Game.mapSizeZ*0.25,"northern passage then enemy-facing cliff descent")
                check(route and route.ascent and route.ascent[1]<Game.mapSizeX*0.15
                    and route.cliffQuality and route.cliffQuality[1]>1.5 and route.cliffQuality[2]>1.5,
                    "steep walker-only cliffs at both ends")
                if route and route.ascent then Spring.Echo("[TacticalGuide] cliff entry "..table.concat(route.ascent,",")
                    .." exit "..table.concat(route.anchor,",").." quality "..table.concat(route.cliffQuality,",")) end
                local west=false
                if route then for _,p in ipairs(route.points) do
                    if p[1]<Game.mapSizeX*0.2 and p[2]<Game.mapSizeZ*0.18 then west=true end
                end end
                check(west,"western passage approach")
            end
        else choose(ui,0) end
        stage=2
    elseif stage==2 and f>=2100 then
        if Game.mapName:find("Supreme") then choose(ui,5); ui.TheatreOptions({sites=true,shores=true})
        elseif Game.mapName:find("Glacial") then
            local route,z=mountain(ui,true)
            shelfMetrics(route,"south")
            check(route and z>Game.mapSizeZ*0.82,"southern mountain crossing")
        elseif Game.mapName:find("Ascendancy") then
            mountain(ui,false); ui.TheatreOptions({labels=false})
        else click(ui,"guideNext") end
        stage=3
    elseif stage==3 and f>=2800 then
        click(ui,"guideLive")
        local s=ui.TheatreSnapshot(0); frozenFrame=s and s.frame
        check(s and not s.live,"freeze control")
        Spring.SendSkirmishAIMessage(0,"barb|theatres|0|refresh")
        stage=4
    elseif stage==4 and f>=3300 then
        local s=ui.TheatreSnapshot(0)
        check(s and s.frame==frozenFrame,"frozen snapshot retained")
        click(ui,"guideRefresh"); stage=5
    elseif stage==5 and f>=3500 then
        local s=ui.TheatreSnapshot(0)
        check(s and s.frame>frozenFrame,"manual refresh while frozen")
        ui.TheatreOptions({labels=true})
        click(ui,"guide_labels"); check(not ui.TheatreConfig().labels,"label control")
        click(ui,"guide_labels")
        for _,key in ipairs({"routes","sites","shores","cues","context"}) do
            local before=ui.TheatreConfig()[key]
            click(ui,"guide_"..key)
            check(ui.TheatreConfig()[key]~=before,key.." control")
            click(ui,"guide_"..key)
        end
        local before=ui.TheatreConfig().classes[4]
        click(ui,"guideClass4"); check(ui.TheatreConfig().classes[4]~=before,"movement filter")
        click(ui,"guideClass4")
        click(ui,"guideCollapse"); check(ui.TheatreConfig().collapsed,"collapse control")
        click(ui,"guideCollapse")
        local ink=ui.TheatreConfig().opacity
        click(ui,"guide_opacity"); check(ui.TheatreConfig().opacity<ink,"opacity control")
        ui.TheatreOptions({opacity=ink})
        click(ui,"guideLive"); stage=6
    elseif stage==6 and f>=4400 then
        local s=ui.TheatreSnapshot(0)
        check(s and s.details[1].revision>=2,"dynamic survey revision")
        click(ui,"guideHide")
        check(not ui.TheatreSnapshot(0).visible,"hide control")
        Spring.SendSkirmishAIMessage(0,"barb|theatres|0|refresh"); stage=7
    elseif stage==7 and f>=4500 then
        check(not ui.TheatreSnapshot(0).visible,"hidden refresh stays hidden")
        ui.SetTheatres(0); stage=8
    end
end
