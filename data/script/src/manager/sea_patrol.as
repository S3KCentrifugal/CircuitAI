// D-202: SEA owns scout/AA movement separately from surface attack cohorts.
// Stable unit IDs, sector leases and per-boat routes prevent native AA merging.
// Contact census is O(A*B); boat selection O(U*A). The bounded water grid is
// built once; O(P) patrol selection occurs on assignment/expiry, never per frame.
// Naval danger costs O(K*E) for distinct candidate cells K, sea contacts E;
// at most 49 candidates/boat, with cached overlapping formation candidates.
namespace SeaPatrol {
    class Sector { AIFloat3 pos; int body=-1, owner=-1, visited=-100000; }
    class Boat {
        int id=-1, body=-1, sector=-1, until=0, seen=0, slot=-1, retry=0;
        int mode=-1, target=-1;
        AIFloat3 goal;
        CRouteTask@ route;
    }
    class Raid {
        int body=-1, target=-1, seen=-100000, candidate=-1, nextSlot=0;
        AIFloat3 pos, velocity, centre, direction;
        float range=100000, speed=100000, distance=100000;
        bool present=false;
    }
    array<Sector@> sectors;
    array<Boat@> boats;
    array<Raid@> raids;
    array<int> contactBodies;
    dictionary boatIndex;
    dictionary navalSafety;
    float cell=640;
    bool gridReady=false;
    int seaContacts=0;
    bool Scout(const CCircuitDef@ d) {
        const string name=d.GetName();
        return name=="armpt" || name=="corpt" || name=="coresupp" || name=="legnavyscout";
    }
    bool AA(const CCircuitDef@ d) {
        // A broad target mask is not an AA role: Legion's scout gun can hit
        // aircraft for tiny damage. Including it would shrink the entire
        // screen to that gun's short range and sacrifice the scouting fleet.
        const string name=d.GetName();
        // JSON role[1..] describes enemy response categories, not this hull's
        // own roles (FactoryManager::ReadConfig). Iapetus is scout-first there.
        return d.HasSurfToAir() && (name=="armpt" || name=="corpt" || name=="armaas" || name=="corarch"
            || name=="legnavyaaship" || name=="leganavyaaship" || d.IsRoleAny(Unit::Role::AA.mask));
    }
    bool Handles(const CCircuitDef@ d) {
        if (!Global::RoleSettings::Sea::FleetOperations) return false;
        bool naval=false;
        for (uint i=0;i<SeaCombat::roster.length();++i)
            if (SeaCombat::roster[i].def is d) { naval=true; break; }
        return naval && (Scout(d) || AA(d));
    }
    bool Available(CCircuitUnit@ u) {
        if (u is null || u.GetBuildProgress()<1 || !Handles(u.circuitDef)
            || u.GetRulesParam("carrier_host_unit_id",-1)>=0) return false;
        if (u.task is null) return true;
        return u.task.GetType()!=int(Task::Type::PLAYER) && u.task.GetType()!=int(Task::Type::RETREAT)
            && !u.task.IsExternalControlled();
    }
    void Release(Boat@ b) {
        if (b.sector>=0 && sectors[b.sector].owner==b.id) sectors[b.sector].owner=-1;
        b.sector=-1;
        if (b.route !is null && !b.route.IsDead()) { b.route.SetSeaTarget(-1); b.route.Abort(); }
        @b.route=null;
    }
    void Leave() {
        for (uint i=0;i<boats.length();++i) Release(boats[i]);
        boats.resize(0); boatIndex.deleteAll(); raids.resize(0);
    }
    void Grid() {
        if (gridReady) return;
        gridReady=true;
        // At most 32*32 terrain samples even on very large maps. Positions are
        // hypotheses, not enemy knowledge. Threat tests remain live at admission.
        cell=AiMax(Global::RoleSettings::Sea::ScoutPatrolCell,float(AiMax(AiTerrainWidth(),AiTerrainHeight()))/32.0f);
        for (float z=cell*.5f;z<AiTerrainHeight();z+=cell) for (float x=cell*.5f;x<AiTerrainWidth();x+=cell) {
            AIFloat3 p(x,0,z); const int body=aiBattle.WaterBody(p,false);
            if (body<0 || aiBattle.Height(p)>-20) continue;
            Sector@ s=Sector(); s.pos=p; s.body=body; sectors.insertLast(s);
        }
    }
    Raid@ Basin(int body) {
        for (uint i=0;i<raids.length();++i) if (raids[i].body==body) return raids[i];
        Raid@ r=Raid(); r.body=body; raids.insertLast(r); return r;
    }
    bool Safe(CCircuitUnit@ u,const AIFloat3 &in p,int body) {
        return aiBattle.WaterBody(p,false)==body && aiTerrainMgr.CanMoveTo(u,p)
            && aiBattle.SurfThreat(p)<=.1f && aiBattle.AmphThreat(p)<=.1f;
    }
    bool InterceptionSite(CCircuitUnit@ u,const AIFloat3 &in p,int body,const string &in cellKey) {
        if (aiBattle.WaterBody(p,false)!=body || !aiTerrainMgr.CanMoveTo(u,p)) return false;
        bool safe=false;
        if (navalSafety.get(cellKey,safe)) return safe;
        // The ordinary threat map includes aircraft damage. An AA screen must
        // deliberately engage that layer, while retaining naval/sub avoidance.
        // Cache same-grid candidates within this census only: live contacts,
        // formation origin and orientation invalidate every answer next tick.
        safe=true;
        for (int i=0;i<seaContacts;++i) {
            const int flags=aiBattle.GetSeaForceFlags(i);
            if ((flags&1)!=0 || aiBattle.GetSeaForceBody(i)!=body) continue;
            const int defId=aiBattle.GetSeaForceDefId(i);
            const CCircuitDef@ d=defId>=0 ? ai.GetCircuitDef(defId) : null;
            float radius=Global::RoleSettings::Sea::FleetScreenRadius; // unidentified sonar contact
            if (d !is null) {
                if (!d.HasSurfToLand() && !d.HasSurfToWater() && !d.HasSubToLand() && !d.HasSubToWater()) continue;
                radius=AiMax(d.GetMaxRange(1),d.GetMaxRange(2))+128;
            } else if ((flags&16)==0) continue;
            if (MapHelpers::SqDist(p,aiBattle.GetSeaForcePos(i))<radius*radius) { safe=false; break; }
        }
        navalSafety.set(cellKey,safe); return safe;
    }
    int NearbyBody(const AIFloat3 &in p) {
        int body=aiBattle.WaterBody(p,false);
        if (body>=0) return body;
        // Shore transits can already be in naval AA range while over a beach.
        for (int i=0;i<8;++i) {
            const float a=float(i)*.785398f;
            body=aiBattle.WaterBody(AIFloat3(p.x+cos(a)*384,0,p.z+sin(a)*384),false);
            if (body>=0) return body;
        }
        return -1;
    }
    void Contacts() {
        for (uint i=0;i<raids.length();++i) { raids[i].present=false; raids[i].candidate=-1; raids[i].range=100000; raids[i].speed=100000; raids[i].distance=100000; }
        const int count=aiBattle.GetAirContactCount();
        contactBodies.resize(count);
        for (int i=0;i<count;++i) {
            const AIFloat3 p=aiBattle.GetAirContactPos(i);
            const int body=NearbyBody(p); contactBodies[i]=body; if (body<0) continue;
            Raid@ r=Basin(body);
            // Respond to scouts/transports too. Prefer the contact nearest our
            // protected coast. Commit once after selection so iteration order
            // cannot corrupt the previous observation used for velocity.
            const float score=MapHelpers::SqDist(p,Global::Map::StartPos);
            if (r.candidate>=0 && score>=MapHelpers::SqDist(aiBattle.GetAirContactPos(r.candidate),Global::Map::StartPos)) continue;
            r.candidate=i;
        }
        for (uint i=0;i<raids.length();++i) {
            Raid@ r=raids[i]; if (r.candidate<0) continue;
            const int id=aiBattle.GetAirContactId(r.candidate);
            const AIFloat3 p=aiBattle.GetAirContactPos(r.candidate);
            const float dt=float(ai.frame-r.seen)/float(SECOND);
            r.velocity=(id==r.target && dt>0 && dt<=2) ? AIFloat3((p.x-r.pos.x)/dt,0,(p.z-r.pos.z)/dt) : AIFloat3(0,0,0);
            r.pos=p; r.present=true; r.target=id; r.seen=ai.frame;
        }
    }
    int FireTarget(Boat@ b,CCircuitUnit@ u) {
        const AIFloat3 p=u.GetPos(ai.frame);
        const float range=u.circuitDef.GetMaxRange(0);
        float best=range*range; int target=-1;
        for (uint i=0;i<contactBodies.length();++i) {
            if (contactBodies[i]!=b.body) continue;
            const int id=aiBattle.GetAirContactId(i);
            const float distance=MapHelpers::SqDist(p,aiBattle.GetAirContactPos(i));
            if (id==b.target && distance<=range*range) return id;
            if (distance<best) { best=distance; target=id; }
        }
        // Out of weapon range keep moving to the screen, with autonomous fire
        // available. Never pin every ship to one far plane over a nearer one.
        return target;
    }
    bool Order(Boat@ b,CCircuitUnit@ u,const array<AIFloat3>@ points,bool patrol) {
        if (b.route is null || b.route.IsDead()) {
            @b.route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            if (b.route is null) return false;
            b.route.SetSeaControl(true); b.route.SetHoldPosition(true);
        }
        b.route.SetTraversal(true,48,false); b.route.SetPatrol(patrol); b.route.SetRoute(points);
        if (u.task !is b.route && !aiMilitaryMgr.TransferUnit(u,b.route)) {
            Invariants::Violation("INV-146",""+u.id,"SEA scout/AA route handover failed"); return false;
        }
        return true;
    }
    void Patrol(Boat@ b,CCircuitUnit@ u) {
        if (ai.frame<b.retry) return;
        if (b.mode==0 && b.route !is null && !b.route.IsDead() && ai.frame<b.until && Safe(u,b.goal,b.body)) return;
        if (b.sector>=0 && sectors[b.sector].owner==b.id) sectors[b.sector].owner=-1;
        b.sector=-1;
        const AIFloat3 here=u.GetPos(ai.frame);
        // Lease distinct sectors; oldest first with travel cost as tie-breaker.
        // Search cost is bounded by Grid, and no index survives a unit transfer.
        int best=-1; float score=1e30f;
        for (uint i=0;i<sectors.length();++i) {
            Sector@ s=sectors[i];
            if (s.body!=b.body || (s.owner>=0 && s.owner!=b.id)) continue;
            // Dedicated AA covers the friendly coast; expendable T1 scouts
            // alone explore the whole connected sea.
            if (!Scout(u.circuitDef) && MapHelpers::SqDist(s.pos,Global::Map::StartPos)>2400*2400) continue;
            const float rank=float(s.visited)+sqrt(MapHelpers::SqDist(here,s.pos))*2;
            if (rank>=score || !Safe(u,s.pos,b.body)) continue;
            score=rank; best=int(i);
        }
        if (best<0) { b.retry=ai.frame+5*SECOND; return; }
        Sector@ s=sectors[best]; s.owner=b.id; s.visited=ai.frame; b.sector=best; b.goal=s.pos;
        // MOVE to the sector before queuing its patrol. Including the current
        // base position in that loop would make every scout revisit the yard.
        array<AIFloat3> points;
        for (int i=0;i<3;++i) {
            const float a=float(i)*2.094395f;
            AIFloat3 p(s.pos.x+cos(a)*cell*.3f,0,s.pos.z+sin(a)*cell*.3f);
            if (Safe(u,p,b.body)) points.insertLast(p);
        }
        if (points.length()<2) { points.resize(0); points.insertLast(here); points.insertLast(s.pos); }
        if (Order(b,u,points,true)) {
            b.route.SetSeaTarget(-1); b.mode=0; b.target=-1;
            b.until=ai.frame+Global::RoleSettings::Sea::ScoutPatrolSeconds*SECOND;
            GenericHelpers::LogUtil("[SEA][Patrol] id="+b.id+" sector="+best+" goal="+int(b.goal.x)+","+int(b.goal.z),1);
        }
    }
    void Tick() {
        if (!Global::RoleSettings::Sea::FleetOperations) { Leave(); return; }
        Grid(); Contacts(); navalSafety.deleteAll(); seaContacts=aiBattle.GetSeaForceCount();
        // Build occupancy once; monotonically scan free slots per basin.
        // Birth bursts are O(U), not one full boat scan per new hull.
        dictionary usedSlots;
        for (uint i=0;i<raids.length();++i) raids[i].nextSlot=0;
        for (uint i=0;i<boats.length();++i) if (boats[i].slot>=0) usedSlots.set(""+boats[i].body+":"+boats[i].slot,true);
        for (uint i=0;i<SeaCombat::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaCombat::owned[i]); if (!Available(u)) continue;
            const int body=aiBattle.WaterBody(u.GetPos(ai.frame),false); if (body<0) continue;
            int index=-1;
            if (!boatIndex.get(""+u.id,index)) {
                index=int(boats.length()); Boat@ fresh=Boat(); fresh.id=u.id; fresh.body=body;
                // Lowest free slot preserves survivors' spacing after losses.
                if (AA(u.circuitDef)) {
                    Raid@ basin=Basin(body);
                    while (usedSlots.exists(""+body+":"+basin.nextSlot)) ++basin.nextSlot;
                    fresh.slot=basin.nextSlot++;
                    usedSlots.set(""+body+":"+fresh.slot,true);
                }
                boats.insertLast(fresh); boatIndex.set(""+u.id,index);
            }
            Boat@ b=boats[index]; b.seen=ai.frame; b.body=body;
            Raid@ r=Basin(body);
            if (AA(u.circuitDef)) {
                r.range=AiMin(r.range,u.circuitDef.GetMaxRange(0)); // AIR layer, not surface missile range
                r.speed=AiMin(r.speed,u.circuitDef.speed);
                r.distance=AiMin(r.distance,sqrt(MapHelpers::SqDist(u.GetPos(ai.frame),r.pos)));
            }
        }
        uint live=0;
        for (uint i=0;i<boats.length();++i) {
            Boat@ b=boats[i];
            if (b.seen!=ai.frame) { Release(b); continue; }
            @boats[live++]=b;
        }
        boats.resize(live); boatIndex.deleteAll();
        for (uint i=0;i<boats.length();++i) boatIndex.set(""+boats[i].id,int(i));
        for (uint i=0;i<raids.length();++i) {
            Raid@ r=raids[i]; if (!r.present) continue;
            // Use the nearest screen member, not the commander's start. A
            // plane already in AA reach needs fire now, not a far-ahead chase.
            const float lead=SeaMath::InterceptLead(r.distance,r.speed,r.range,Global::RoleSettings::Sea::NavalAAInterceptSeconds);
            AIFloat3 predicted=Spam::_Clamp(AIFloat3(r.pos.x+r.velocity.x*lead,0,r.pos.z+r.velocity.z*lead));
            if (r.centre.x<=0 || MapHelpers::SqDist(r.centre,predicted)>r.range*r.range*.16f) {
                r.centre=predicted;
                float dx=r.velocity.x,dz=r.velocity.z;
                if (dx*dx+dz*dz<1) { dx=Global::Map::StartPos.x-r.pos.x; dz=Global::Map::StartPos.z-r.pos.z; }
                const float length=AiMax(1.0f,sqrt(dx*dx+dz*dz));
                r.direction=AIFloat3(dx/length,0,dz/length);
            }
        }
        dictionary claimed;
        for (uint i=0;i<boats.length();++i) {
            Boat@ b=boats[i]; CCircuitUnit@ u=ai.GetTeamUnit(b.id); if (!Available(u)) continue;
            Raid@ r=Basin(b.body);
            const bool alarm=Global::RoleSettings::Sea::HybridScoutAirResponse && AA(u.circuitDef)
                && ai.frame-r.seen<Global::RoleSettings::Sea::NavalAAContactMemorySeconds*SECOND;
            if (!alarm) { Patrol(b,u); continue; }
            const float spacing=AiMax(96.0f,SeaMath::AASpacing(Global::RoleSettings::Sea::NavalAAFormationSpacing,r.range));
            const float dx=r.direction.x,dz=r.direction.z;
            const int columns=Global::RoleSettings::Sea::NavalAAColumns;
            AIFloat3 goal=u.GetPos(ai.frame); float best=1e30f; string bestKey;
            // Fixed candidate budget; never collapse invalid coastal slots to
            // one shared centre. All candidates use the SAME rotated integer
            // grid: distinct keys therefore guarantee at least spacing elmos
            // between assigned destinations, unlike rounded world coordinates.
            for (int j=0;j<49;++j) {
                const int col=SeaMath::AAColumn(b.slot,columns)+j%7-3;
                const int row=SeaMath::AARow(b.slot,columns)+j/7-3;
                const float ox=float(j%7-3)*spacing, oz=float(j/7-3)*spacing;
                AIFloat3 p(r.centre.x-dz*col*spacing+dx*row*spacing,0,r.centre.z+dx*col*spacing+dz*row*spacing);
                const string key=""+b.body+":"+col+":"+row;
                const float dist=ox*ox+oz*oz;
                if (dist>=best || claimed.exists(key) || !InterceptionSite(u,p,b.body,key)) continue;
                best=dist; goal=p; bestKey=key;
            }
            if (bestKey.length()==0) {
                // An unreachable coast/hostile fleet must not pin reinforcements
                // in their factory-exit ball. Keep individual safe coverage,
                // with immediate AA fire, until a screen position is available.
                Patrol(b,u); b.target=FireTarget(b,u);
                if (b.route !is null && !b.route.IsDead()) b.route.SetSeaTarget(b.target);
                continue;
            }
            claimed.set(bestKey,true);
            if (b.sector>=0 && sectors[b.sector].owner==b.id) sectors[b.sector].owner=-1;
            b.sector=-1;
            if (b.mode!=1 || MapHelpers::SqDist(goal,b.goal)>96*96 || b.route is null || b.route.IsDead()) {
                array<AIFloat3> points={u.GetPos(ai.frame),goal};
                if (Order(b,u,points,false)) {
                    b.mode=1; b.goal=goal;
                    GenericHelpers::LogUtil("[SEA][AAFormation] id="+b.id+" body="+b.body+" slot="+b.slot+" target="+r.target+" goal="+int(goal.x)+","+int(goal.z)+" unit="+u.circuitDef.GetName(),1);
                }
            }
            b.target=FireTarget(b,u);
            if (b.route !is null && !b.route.IsDead()) b.route.SetSeaTarget(b.target);
        }
    }
}
