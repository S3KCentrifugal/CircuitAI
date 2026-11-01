-- Embedded by tools/widgets/embed_strategy.py into gui_barb_team_link.lua.
-- Pure renderer of AI publications. No unit enumeration, orders or ownership inference.
local strategy = (function()
    local show, frozen, inspect = false, nil, false
    local frozenTerritory=nil
    local live, revision, built, modelSeen = {}, 0, -1, nil
    local lastPayload, lastTerritory = {}, {}
    local mode, cls, team, selectedCorridor = 1, 0, -1, nil
    local side=nil
    local heat=true
    local territoryOpacity=.28
    local zoneColours={[2]={1,.65,.1},[3]={1,.15,.15},[4]={.8,.3,1}}
    local modes = {"Overview", "Territory", "Commander", "Diagnostics"}
    local classes = {[0]="Vehicle", "Bot", "Amphibious", "Hover", "All-terrain", "Ship", "Sub"}
    -- Lane query classes differ from the field's class enum.
    local laneClass = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5}
    local controls, lists, terrainLists, job, inspection = {}, {}, {}, nil, nil
    local terrainKey=""
    local heatCache={}
    local view, panel, freezeFrame = {}, nil, nil
    local displayTeams={}
    local function split(s, sep)
        local out, at = {}, 1
        while true do
            local a,b=string.find(s or "",sep,at,true)
            if not a then out[#out+1]=string.sub(s or "",at);return out end
            out[#out+1]=string.sub(s,at,a-1);at=b+1
        end
    end
    local function numbers(s)
        local out={}
        for _,v in ipairs(split(s,",")) do
            local n=tonumber(v)
            if not n or n~=n or math.abs(n)>1e12 then return nil end
            out[#out+1]=n
        end
        return out
    end
    local function route(s)
        local n=numbers(s);local out={}
        if not n or #n<3 or (#n-3)%2~=0 or #n>8195 then return out end
        for i=4,#n,2 do
            if n[i]<0 or n[i+1]<0 or n[i]>Game.mapSizeX or n[i+1]>Game.mapSizeZ then return {} end
            out[#out+1]={n[i],n[i+1]}
        end
        return out
    end
    local function front(s)
        local parts=split(s or "","|")
        local stamp=tonumber(parts[1]);local zones={}
        if not stamp or stamp<0 or #parts>129 then return nil end
        local last=0
        for i=2,#parts do
            local n=numbers(parts[i])
            if not n or #n~=3 or n[1]<last or n[2]<=n[1] or n[2]>1000000
                or n[3]<0 or n[3]>4 or n[3]~=math.floor(n[3]) then return nil end
            zones[#zones+1]=n;last=n[2]
        end
        return {frame=stamp,zones=zones}
    end
    local function receive(id,payload)
        if not isPermittedTeam(id) or #payload>150000 or lastPayload[id]==payload then return false end
        local f=split(payload,";")
        if f[1]~="1" or #f<15 then return false end
        local frame,assignment,class,corridor,rank,count=tonumber(f[2]),tonumber(f[3]),tonumber(f[4]),tonumber(f[5]),tonumber(f[6]),tonumber(f[7])
        local pos,help=numbers(f[8]),numbers(f[10])
        if not frame or frame<0 or not assignment or not class or not corridor or not rank or not count or not pos or #pos~=2 or not help or #help~=3 then return false end
        if live[id] and live[id].frame>frame then return false end
        local samples={}
        for _,v in ipairs(split(f[15],"|")) do
            local n=numbers(v)
            if n and #n==3 and #samples<33 then samples[#samples+1]=n end
        end
        local ally=Spring.GetTeamInfo and select(6,Spring.GetTeamInfo(id,false)) or -1
        if side==nil then side=ally end
        live[id]={team=id,ally=ally,frame=frame,assignment=assignment,class=laneClass[class],corridor=corridor,rank=rank,count=count,
            pos=pos,progress=tonumber(f[9]) or -1,help=help,request=tonumber(f[11]) or -1,fieldRevision=f[12],
            route=route(f[13]),proposal=route(f[14]),samples=samples,native=numbers(f[16] or ""),status=f[17] or "legacy snapshot",proposalStatus=f[18] or "unknown",front=front(f[19]),defense=string.sub(f[20] or "unavailable",1,180)}
        lastPayload[id]=payload;revision=revision+1
        return true
    end
    local function receiveFront(id,payload)
        if not isPermittedTeam(id) or #payload>12000 then return false end
        local f=split(payload,";");local s=live[id]
        if #f~=2 or not s or tonumber(f[1])~=s.assignment then return false end
        local value=front(f[2])
        if not value or (s.front and value.frame<=s.front.frame) then return false end
        -- Copy the record: Freeze owns the preceding immutable table.
        local copy={};for k,v in pairs(s) do copy[k]=v end
        copy.front=value;live[id]=copy;revision=revision+1
        return true
    end
    local function invalidate() built=-1 end
    local function clearLists()
        for _,id in ipairs(lists) do gl.DeleteList(id) end
        for _,id in ipairs(terrainLists) do gl.DeleteList(id) end
        for _,entry in pairs(heatCache) do gl.DeleteList(entry.id) end
        heatCache={}
        lists={};terrainLists={};terrainKey="";job=nil
    end
    local function colour(id,alpha)
        if id==nil or id<0 then gl.Color(.52,.56,.61,alpha);return end
        local r,g,b=Spring.GetTeamColor(id);gl.Color(r or 1,g or 1,b or 1,alpha)
    end
    local function vertex(x,z) gl.Vertex(x,math.max(0,Spring.GetGroundHeight(x,z))+9,z) end
    local function line(points,dashed)
        gl.BeginEnd(GL.LINES,function()
            for i=2,#points do
                local a,b=points[i-1],points[i]
                if dashed then
                    local dx,dz=b[1]-a[1],b[2]-a[2];local length=math.sqrt(dx*dx+dz*dz)
                    for d=0,length,128 do
                        local u,v=d/math.max(1,length),math.min(length,d+64)/math.max(1,length)
                        vertex(a[1]+dx*u,a[2]+dz*u);vertex(a[1]+dx*v,a[2]+dz*v)
                    end
                else vertex(a[1],a[2]);vertex(b[1],b[2]) end
            end
        end)
    end
    local function cross(x,z,r)
        gl.BeginEnd(GL.LINES,function() vertex(x-r,z);vertex(x+r,z);vertex(x,z-r);vertex(x,z+r) end)
    end
    -- Sparse categorical heat cells, not an enemy-density estimate. Rebuilt only
    -- with publication/filter changes in Update; DrawWorld only calls lists.
    -- At most 128x128 map cells per team; overlapping samples keep the strongest
    -- category instead of accumulating opacity. Route sampling scales with length.
    local function drawHeat(s,m)
        if not heat or not s.front then return end
        local cell=math.max(96,math.max(Game.mapSizeX,Game.mapSizeZ)/128)
        local gw=math.ceil(Game.mapSizeX/cell)
        local corridor=m.corridors[s.corridor]
        local radius=math.max(cell,math.min(384,(corridor and corridor.width or 512)*.5))
        local length=0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            length=length+math.sqrt((b[1]-a[1])^2+(b[2]-a[2])^2)
        end
        local step=math.max(cell*.5,length/2048)
        local cells,keys={},{}
        local priority={[2]=1,[4]=2,[3]=3}
        local function stamp(x,z,kind)
            local reach=radius+cell*.71
            for gz=math.max(0,math.floor((z-reach)/cell)),math.min(math.ceil(Game.mapSizeZ/cell)-1,math.floor((z+reach)/cell)) do
                for gx=math.max(0,math.floor((x-reach)/cell)),math.min(gw-1,math.floor((x+reach)/cell)) do
                    local distance=math.sqrt(((gx+.5)*cell-x)^2+((gz+.5)*cell-z)^2)
                    if distance<reach then
                        local weight=math.max(.12,1-distance/reach)
                        local key=gz*gw+gx;local old=cells[key]
                        if not old then keys[#keys+1]=key end
                        if not old or priority[kind]>priority[old.kind] then
                            cells[key]={x=gx*cell,z=gz*cell,kind=kind,weight=weight}
                        elseif old.kind==kind then old.weight=math.max(old.weight,weight) end
                    end
                end
            end
        end
        local zi,progress=1,0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            local dx,dz=b[1]-a[1],b[2]-a[2];local len=math.sqrt(dx*dx+dz*dz)
            local finish=progress+len
            while s.front.zones[zi] and s.front.zones[zi][2]<=progress do zi=zi+1 end
            local j=zi
            while len>0 and s.front.zones[j] and s.front.zones[j][1]<finish do
                local zone=s.front.zones[j]
                local lo,hi=math.max(progress,zone[1]),math.min(finish,zone[2])
                if zone[3]>=2 and hi>lo then
                    local count=math.max(1,math.ceil((hi-lo)/step))
                    for k=0,count do
                        local t=(lo+(hi-lo)*k/count-progress)/len
                        stamp(a[1]+dx*t,a[2]+dz*t,zone[3])
                    end
                end
                if zone[2]>=finish then break end
                j=j+1
            end
            zi=j;progress=finish
        end
        gl.BeginEnd(GL.QUADS,function()
            for _,key in ipairs(keys) do
                local q=cells[key];local c=zoneColours[q.kind]
                if s.frontStale then gl.Color(.55,.58,.62,.12+q.weight*.12)
                else gl.Color(c[1],c[2],c[3],.12+q.weight*.42) end
                local right,bottom=math.min(Game.mapSizeX,q.x+cell),math.min(Game.mapSizeZ,q.z+cell)
                vertex(q.x,q.z);vertex(right,q.z);vertex(right,bottom);vertex(q.x,bottom)
            end
        end)
    end
    local function drawFront(s)
        if not s.front then return end
        -- Both intervals and route segments are ordered: sweep once, O(P+Z),
        -- rather than projecting every zone over the entire polyline.
        local zones=s.front.zones
        local zi,progress=1,0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            local dx,dz=b[1]-a[1],b[2]-a[2];local len=math.sqrt(dx*dx+dz*dz)
            local finish=progress+len
            while zones[zi] and zones[zi][2]<=progress do zi=zi+1 end
            local j=zi
            while len>0 and zones[j] and zones[j][1]<finish do
                local zone=zones[j];local kind=zone[3]
                local lo,hi=math.max(zone[1],progress),math.min(zone[2],finish)
                if kind>=2 and hi>lo then
                    if s.frontStale then gl.Color(.6,.6,.6,.45)
                    elseif kind==3 then gl.Color(1,.15,.15,.85)
                    elseif kind==2 then gl.Color(1,.65,.1,.8)
                    else gl.Color(.8,.3,1,.7) end
                    gl.LineWidth(kind==3 and 12 or 8)
                    local u,v=(lo-progress)/len,(hi-progress)/len
                    local points={{a[1]+dx*u,a[2]+dz*u},{a[1]+dx*v,a[2]+dz*v}}
                    line(points,kind~=3 or s.frontStale)
                    if kind==3 and not s.frontStale then cross((points[1][1]+points[2][1])*.5,(points[1][2]+points[2][2])*.5,45) end
                end
                if zone[2]>=finish then break end
                j=j+1
            end
            zi=j;progress=finish
        end
    end
    local function at(runs,cell)
        local lo,hi=1,#(runs or {})
        while lo<=hi do
            local mid=math.floor((lo+hi)/2);local r=runs[mid]
            if cell<r[1] then hi=mid-1 elseif cell>=r[1]+r[3] then lo=mid+1 else return r[2] end
        end
        return nil
    end
    local function snapshot()
        local out={}
        local m=field.Model()
        for id,s in pairs(frozen or live) do
            if isPermittedTeam(id) and (not m or not m.corridorRevision or s.fieldRevision==m.corridorRevision) and (side==nil or side<0 or side==s.ally) and (team<0 or team==id) and s.class==cls and (not selectedCorridor or s.corridor==selectedCorridor) then out[#out+1]=s end
        end
        table.sort(out,function(a,b)return a.team<b.team end)
        return out
    end
    local function prepare(m)
        view=snapshot();built=revision;displayTeams={}
        for _,s in ipairs(view) do displayTeams[s.team]=true end
        local key=tostring(m)..":"..cls..":"..mode..":"..tostring(selectedCorridor)..":"..team..":"..tostring(side)
        for _,s in ipairs(view) do key=key..":"..s.team.."/"..s.assignment.."/"..s.corridor end
        local rebuild=key~=terrainKey
        if rebuild then clearLists() else
            for _,id in ipairs(lists) do gl.DeleteList(id) end
            lists={};job=nil
        end
        modelSeen=m
        local owners={}
        for _,s in ipairs(view) do
            owners[s.corridor]=owners[s.corridor] or {};table.insert(owners[s.corridor],s.team)
        end
        job=coroutine.create(function()
            -- Each list holds at most 128 row spans. Build only in Update, never
            -- DrawWorld; yield between chunks. Revision/filter changes own invalidation.
            if rebuild and (mode==1 or mode==2 or mode==4) then
                local batch={}
                local function flush()
                    if #batch==0 then return end
                    terrainLists[#terrainLists+1]=gl.CreateList(function()
                        gl.BeginEnd(GL.QUADS,function()
                            for _,q in ipairs(batch) do
                                local own=owners[q[5]];local id=own and own[1] or -1
                                if own and #own>1 then gl.Color(1,.62,.12,math.min(.65,territoryOpacity+.12)) else colour(id,own and territoryOpacity or .06) end
                                vertex(q[1],q[2]);vertex(q[3],q[2]);vertex(q[3],q[4]);vertex(q[1],q[4])
                            end
                        end)
                    end)
                    batch={};coroutine.yield()
                end
                for _,r in ipairs(m.corridorRuns[cls] or {}) do
                    local first,last=r[1],r[1]+r[3]
                    while first<last do
                        local row=math.floor(first/m.gw);local stop=math.min(last,(row+1)*m.gw)
                        if r[2]>=0 and (not selectedCorridor or selectedCorridor==r[2]) then
                            batch[#batch+1]={(first%m.gw)*m.cell,row*m.cell,(stop-row*m.gw)*m.cell,(row+1)*m.cell,r[2]}
                            if #batch==128 then flush() end
                        end
                        first=stop
                    end
                end
                flush()
            end
            if rebuild then
            for id,c in pairs(m.corridors) do
                if c.class==cls and (not selectedCorridor or id==selectedCorridor) then
                    terrainLists[#terrainLists+1]=gl.CreateList(function()
                        local own=owners[id];colour(own and own[1],.65)
                        local points={};for _,p in ipairs(c.spine) do points[#points+1]={p[1],p[2]} end
                        gl.LineWidth(2);line(points,false);cross(c.x,c.z,40);gl.LineWidth(1)
                    end)
                    coroutine.yield()
                end
            end
            terrainKey=key
            end
            if mode==2 then
                for _,entry in pairs(frozenTerritory or territory.Snapshot()) do
                    local ally=Spring.GetTeamInfo and select(6,Spring.GetTeamInfo(entry.team,false)) or -1
                    if isPermittedTeam(entry.team) and (side==nil or side<0 or side==ally) then
                        displayTeams[entry.team]=true
                        lists[#lists+1]=gl.CreateList(function()
                            for _,spot in ipairs(entry.spots) do
                                if team<0 or spot.owner==team then
                                    local cell=math.floor(spot.z/m.cell)*m.gw+math.floor(spot.x/m.cell)
                                    local corridor=at(m.corridorRuns[cls],cell)
                                    local assigned=owners[corridor];local mismatch=assigned and spot.owner>=0
                                    for _,id in ipairs(assigned or {}) do if id==spot.owner then mismatch=false end end
                                    if not selectedCorridor or corridor==selectedCorridor then
                                        colour(spot.owner,1);cross(spot.x,spot.z,35)
                                        if mismatch then
                                            gl.Color(1,.4,.8,1)
                                            line({{spot.x-55,spot.z},{spot.x,spot.z+55},{spot.x+55,spot.z},{spot.x,spot.z-55},{spot.x-55,spot.z}},false)
                                        end
                                    end
                                end
                            end
                        end)
                        coroutine.yield()
                    end
                end
            end
            for _,s in ipairs(view) do
                -- Frame stamps alone do not change geometry. Keep the heat list
                -- across 1 Hz publications when route, bands and freshness agree.
                local parts={tostring(heat),tostring(s.frontStale or false),tostring(s.corridor)}
                for _,p in ipairs(s.route) do parts[#parts+1]=p[1]..","..p[2] end
                parts[#parts+1]="zones"
                for _,z in ipairs(s.front and s.front.zones or {}) do parts[#parts+1]=table.concat(z,",") end
                local key=table.concat(parts,";")
                local cached=heatCache[s.team]
                if not cached or cached.key~=key then
                    if cached then gl.DeleteList(cached.id) end
                    heatCache[s.team]={key=key,id=gl.CreateList(function()drawHeat(s,m)end)}
                end
                lists[#lists+1]=gl.CreateList(function()
                    colour(s.team,.75);gl.LineWidth(2);line(s.route,false)
                    drawFront(s)
                    if s.help[1]>=0 then gl.Color(1,.74,.25,.9);gl.LineWidth(2);line(s.proposal,true) end
                    if s.pos[1]>=0 then colour(s.team,1);cross(s.pos[1],s.pos[2],75) end
                    if mode==3 and s.native and #s.native>=10 and s.native[8]>=0 then
                        gl.Color(.4,1,.7,1);cross(s.native[8],s.native[9],105)
                    end
                    if mode==4 then
                        for _,p in ipairs(s.samples) do
                            gl.Color(p[3]>3 and 1 or .4,p[3]>3 and .25 or .85,.2,.85);cross(p[1],p[2],25)
                        end
                    end
                    gl.LineWidth(1)
                end)
                coroutine.yield()
            end
        end)
    end
    local function update()
        if not show then return end
        if not frozen then
            for id,s in pairs(live) do
                local stale=s.front and Spring.GetGameFrame()-s.front.frame>90 or false
                if stale~=(s.frontStale or false) then
                    local copy={};for k,v in pairs(s) do copy[k]=v end
                    copy.frontStale=stale;live[id]=copy;revision=revision+1
                end
            end
        end
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then invalidate();break end end
        local m=field.Model();if not m then return end
        if built<0 or modelSeen~=m or (not frozen and built~=revision and not job) then prepare(m) end
        if job then
            local t=Spring.GetTimer()
            repeat
                local ok,err=coroutine.resume(job)
                if not ok then Spring.Echo("[BARb strategy] "..tostring(err));job=nil;break end
                if coroutine.status(job)=="dead" then job=nil end
            until not job or Spring.DiffTimers(Spring.GetTimer(),t)>=.002
        end
    end
    local function drawWorld()
        if not show or Spring.IsGUIHidden() then return end
        -- Permission changes also invalidate frozen/display-list state.
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then clearLists();invalidate();return end end
        gl.DepthTest(false)
        for _,id in ipairs(terrainLists) do gl.CallList(id) end
        for _,s in ipairs(view) do local entry=heatCache[s.team];if entry then gl.CallList(entry.id) end end
        for _,id in ipairs(lists) do gl.CallList(id) end
        gl.LineWidth(1);gl.Color(1,1,1,1);gl.DepthTest(true)
    end
    local function inside(x,y,r) return r and x>=r[1] and x<=r[3] and y>=r[2] and y<=r[4] end
    local function drawScreen()
        if not show or Spring.IsGUIHidden() then return end
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then invalidate();return end end
        controls={}
        local sx,sy=gl.GetViewSizes();local w,h=560,520
        local scale=dialogUI.Scale(sx,sy,w,h)
        sx,sy=sx/scale,sy/scale
        local x,y=12,sy-42
        gl.PushMatrix();gl.Scale(scale,scale,1)
        -- Dock below a top-left minimap instead of drawing underneath it.
        if Spring.GetMiniMapGeometry then
            local mx,my,mw,mh=Spring.GetMiniMapGeometry()
            if mx then mx,my,mw,mh=mx/scale,my/scale,mw/scale,mh/scale end
            if mx and x<mx+mw and x+w>mx and y+30>my and y-(h-30)<my+mh then
                if my>=h+12 then y=my-42 else x=math.min(sx-w-12,mx+mw+12) end
            end
        end
        x=math.max(12,math.min(sx-w-12,x));y=math.max(h-18,math.min(sy-42,y))
        panel={x,y-(h-30),x+w,y+30};gl.Color(.025,.04,.06,.95);gl.Rect(unpack(panel));gl.Color(1,1,1,1)
        gl.Text("Battlefield overview",x+12,y+10,17,"o")
        local function button(label,bx,by,bw,action,active)
            local r={bx,by,bx+bw,by+30,action,label=label};controls[#controls+1]=r
            local mx,my
            if Spring.GetMouseState then mx,my=Spring.GetMouseState();mx,my=mx/scale,my/scale end
            local hover=mx and inside(mx,my,r)
            gl.Color(active and .16 or (hover and .15 or .075),active and .32 or (hover and .22 or .12),active and .4 or .2,1);gl.Rect(bx,by,bx+bw,by+30)
            if active then gl.Color(.55,.84,1,1);gl.Rect(bx,by,bx+bw,by+2) end
            gl.Color(1,1,1,1);gl.Text(dialogUI.Fit(label,12,bw-14),bx+7,by+9,12,"o")
        end
        button(heat and "Heatmap ON" or "Heatmap OFF",x+w-126,y,114,function()heat=not heat;invalidate()end,heat)
        local bw=(w-24)/4
        for i,label in ipairs(modes) do button(label,x+12+(i-1)*bw,y-34,bw-3,function()mode=i;invalidate()end,mode==i) end
        button(classes[cls].." >",x+12,y-70,125,function()cls=(cls+1)%7;selectedCorridor=nil;inspection=nil;invalidate()end)
        button(team<0 and "All teams >" or "Team "..team.." >",x+143,y-70,125,function()
            local ids={};for id in pairs(frozen or live) do if isPermittedTeam(id) and (side==nil or side<0 or (frozen or live)[id].ally==side) then ids[#ids+1]=id end end;table.sort(ids)
            local nextId=-1;for _,id in ipairs(ids) do if id>team then nextId=id;break end end;team=nextId;invalidate()
        end)
        button((side==nil or side<0) and "All sides >" or "Side "..tostring(side).." >",x+274,y-70,110,function()
            local set,ids={},{}
            for id,s in pairs(frozen or live) do if isPermittedTeam(id) then set[s.ally]=true end end
            for id in pairs(set) do ids[#ids+1]=id end;table.sort(ids)
            local nextId=-1;for _,id in ipairs(ids) do if id>(side or -1) then nextId=id;break end end
            side=nextId;team=-1;invalidate()
        end)
        button("Close",x+w-80,y-70,68,function()show=false;clearLists()end)
        button(frozen and "Resume live" or "Freeze",x+12,y-106,110,function()
            if frozen then frozen=nil;frozenTerritory=nil;freezeFrame=nil else frozen={};for id,s in pairs(live) do frozen[id]=s end;frozenTerritory={};for id,s in pairs(territory.Snapshot()) do frozenTerritory[id]=s end;freezeFrame=Spring.GetGameFrame() end;invalidate()
        end,frozen~=nil)
        button(inspect and "Inspect ON" or "Inspect map",x+128,y-106,120,function()inspect=not inspect end,inspect)
        button("Reset filters",x+254,y-106,115,function()team=-1;side=-1;cls=0;mode=1;selectedCorridor=nil;inspection=nil;invalidate()end)
        local now=Spring.GetGameFrame();local oldest=now
        for _,s in ipairs(view) do oldest=math.min(oldest,s.frame) end
        button("Territory: "..math.floor(territoryOpacity*100).."%",x+w-170,y-106,158,function()
            territoryOpacity=territoryOpacity>=.45 and .16 or territoryOpacity+.12;terrainKey="";invalidate()
        end)
        local function text(t) y=y-21;gl.Color(.85,.9,.94,1);gl.Text(dialogUI.Fit(t,13,w-24),x+12,y,13,"o") end
        y=y-116
        text((frozen and "FROZEN  " or (now-oldest>900 and "STALE  " or "LIVE  "))..(#view==0 and "Waiting for FRONT snapshots" or string.format("%d team(s) | oldest %.0fs old",#view,math.max(0,now-oldest)/30))..(job and " | preparing" or ""))
        local legendY=y-36;local legendW=(w-24)/4
        local labels={"Active combat","Contact","Enemy reach","Stale evidence"}
        local colours={zoneColours[3],zoneColours[2],zoneColours[4],{.55,.58,.62}}
        for i,label in ipairs(labels) do
            local bx=x+12+(i-1)*legendW;local c=colours[i]
            gl.Color(c[1],c[2],c[3],.28);gl.Rect(bx,legendY,bx+legendW-4,legendY+28)
            gl.Color(c[1],c[2],c[3],1);gl.Rect(bx,legendY,bx+3,legendY+28)
            gl.Color(1,1,1,1);gl.Text(label,bx+7,legendY+9,12,"o")
        end
        y=legendY-4
        text("Heat = assessed lane zones; colour is evidence, not enemy count.")
        text("Team-coloured areas = assigned lanes. Orange = shared assignment.")
        text(mode==2 and "Mex + = current policy owner. Pink diamond = differs from lane assignment." or "Solid = commander route. Dashed amber = proposal only. + = choke/position.")

        text("Terrain = map geometry. Threats = observed or remembered enemies.")
        local m=field.Model()
        if not m then text(field.Status())
        elseif inspection then
            local c=m.corridors[inspection.corridor]
            text(c and string.format("Corridor %d | %s | narrowest %.0f | length %.0f",c.id,classes[c.class],c.width,c.length) or "No corridor at inspected cell")
            text("Conservative clearance: "..(inspection.clearance and string.format("%.0f elmos",inspection.clearance*16/3) or "unavailable"))
        else text("Enable Inspect map, then click terrain to isolate a corridor.") end
        local s=view[1]
        if s then
            text(s.front and string.format("Assessment %.0fs old; contacts may be remembered",math.max(0,now-s.front.frame)/30) or "Front evidence unavailable")
            text(string.format("Team %d | r%d | seat %d/%d | %.0f elmos | %s",s.team,s.assignment,s.rank+1,s.count,s.progress,s.status))
            if s.native and #s.native>=10 and s.native[1]>=0 then
                local n=s.native
                text(string.format("Screens %d | bound %.0f | %s | decision %.0fs old",n[3],n[5],n[7]==1 and "return-home latch" or (n[10]==1 and "working" or "front active"),math.max(0,now-n[1])/30))
            else text("Commander front decision: not available yet (opening or inactive).") end
            text("Defense: "..(s.defense or "unavailable"))
            text(s.help[1]>=0 and ("ADVISORY: assist team "..s.help[1]..(s.help[3]==1 and " (income-loss suspect)" or " (pressure)")) or ("Proposal: "..s.proposalStatus..". Other units keep existing behavior."))
        end
        gl.PopMatrix()
        for _,r in ipairs(controls) do for i=1,4 do r[i]=r[i]*scale end end
        for i=1,4 do panel[i]=panel[i]*scale end
        gl.Color(1,1,1,1)
    end
    local function mousePress(x,y,button,blocked)
        if not show then return false end
        for _,r in ipairs(controls) do if inside(x,y,r) then if button==1 then r[5]() end;return true end end
        if inside(x,y,panel) then return true end
        if not inspect or blocked or button~=1 then return false end
        local kind,p=Spring.TraceScreenRay(x,y,true)
        local m=field.Model()
        if kind~="ground" or not p or not m then return false end
        local gx,gz=math.floor(p[1]/m.cell),math.floor(p[3]/m.cell)
        if gx<0 or gz<0 or gx>=m.gw or gz>=m.gh then return false end
        local cell=gz*m.gw+gx;local corridor=at(m.corridorRuns[cls],cell)
        inspection={corridor=corridor,clearance=at(m.clearanceRuns[cls],cell)}
        selectedCorridor=corridor and corridor>=0 and corridor or nil;invalidate();return true
    end
    return {Receive=receive,ReceiveFront=receiveFront,TerritoryChanged=function(id,payload)if lastTerritory[id]~=payload then lastTerritory[id]=payload;revision=revision+1 end end,Update=update,DrawWorld=drawWorld,DrawScreen=drawScreen,MousePress=mousePress,
        PanelRect=function()return panel end,
        ButtonRect=function(label) for _,r in ipairs(controls) do if r.label==label then return {r[1],r[2],r[3],r[4]} end end end,
        Mode=function()return show end,Set=function(v)show=v==true;invalidate();if not show then clearLists() end end,
        Shutdown=clearLists,Snapshot=function()return {teams=snapshot(),mode=mode,class=cls,side=side,frozen=frozen~=nil,preparing=job~=nil,ready=field.Model()~=nil and built>=0 and job==nil,terrainLists=#terrainLists,dynamicLists=#lists,status=field.Status()}end,
        TextCommand=function(cmd) if cmd=="barbstrategy" then show=not show;invalidate();if not show then clearLists() end;return true end return false end,
        At=at,GetConfig=function()return {show=show,class=cls,mode=mode,side=side,heat=heat,territoryOpacity=territoryOpacity}end,
        Config=function(c)if type(c)=="table" then heat=c.heat~=false;if type(c.territoryOpacity)=="number" and c.territoryOpacity==c.territoryOpacity then territoryOpacity=math.max(.12,math.min(.6,c.territoryOpacity)) end;if c.side~=nil then side=math.floor(tonumber(c.side) or -1) end;terrainKey="";show=c.show==true;cls=math.floor(math.max(0,math.min(6,tonumber(c.class) or 0)));mode=math.floor(math.max(1,math.min(4,tonumber(c.mode) or 1)));invalidate();if not show then clearLists() end end end}
end)()
