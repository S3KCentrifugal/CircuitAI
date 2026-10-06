// SEA policy owns objectives; native routes own path traversal and formations.
// O(U + G*E + S*G) policy work per second (hulls U, cohorts G, contacts E,
// utility cohorts S); native snapshot sorting and path searches are separate.
// Expensive path searches occur only on objective changes/expiry. No borrowed
// unit handles survive a callback, and no orders are issued by the census.
namespace SeaOperations {
    class Cohort {
        string key;
        int defId=-1, body=-1, created=0, ordered=-100000, target=-999, nativeUntil=0;
        int search=0, retry=0;
        array<int> ids;
        AIFloat3 centre, goal;
        CRouteTask@ route;
    }
    array<Cohort@> groups;
    dictionary byKey;
    bool Escort(const CCircuitDef@ d) {
        // Builders (including naval engineers/recovery subs) retain economy
        // ownership. This is the finite ordinary naval sensor/ABM roster.
        const string name=d.GetName();
        return name=="armsjam" || name=="corsjam" || name=="leganavyradjamship"
            || name=="armantiship" || name=="corantiship" || name=="leganavyantinukecarrier";
    }
    bool Siege(const CCircuitDef@ d) {
        for (uint i=0;i<SeaCombat::roster.length();++i)
            if (SeaCombat::roster[i].def is d) return SeaCombat::roster[i].siege || d.IsRoleAny(Unit::Role::ARTY.mask);
        return false;
    }
    bool Eligible(CCircuitUnit@ u) {
        if (u is null || u.GetBuildProgress()<1 || !u.circuitDef.IsMobile()
            || u.circuitDef.IsAbleToFly() || u.circuitDef.GetBuildSpeed()>0
            || u.GetRulesParam("carrier_host_unit_id",-1)>=0) return false;
        const CCircuitDef@ d=u.circuitDef;
        if (SeaPatrol::Handles(d)) return false;
        // Explicit roster membership excludes amphibious land. Siege hulls
        // participate only in emergency screening, then regain native artillery.
        bool member=false;
        for (uint i=0;i<SeaCombat::roster.length();++i)
            if (SeaCombat::roster[i].def is d) { member=true; break; }
        if (!Escort(d) && (!member
            || (!d.HasSurfToLand() && !d.HasSubToLand() && !d.HasSurfToWater() && !d.HasSubToWater()))) return false;
        if (u.task is null) return true;
        if (u.task.GetType()==int(Task::Type::PLAYER) || u.task.GetType()==int(Task::Type::RETREAT) || u.task.IsExternalControlled()) return false;
        IFighterTask@ f=cast<IFighterTask>(u.task);
        if (f !is null && f.GetFightType()==int(Task::FightType::AA)) return false;
        return f !is null;
    }
    void Leave() {
        // Abort returns members through normal manager task selection after
        // role change; do not retain a route or borrowed native unit handle.
        for (uint i=0;i<groups.length();++i)
            if (groups[i].route !is null && !groups[i].route.IsDead()) groups[i].route.Abort();
        groups.resize(0); byKey.deleteAll();
    }
    void Census() {
        for (uint i=0;i<groups.length();++i) { groups[i].ids.resize(0); groups[i].centre=AIFloat3(0,0,0); }
        for (uint i=0;i<SeaCombat::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaCombat::owned[i]);
            if (!Eligible(u)) continue;
            const AIFloat3 p=u.GetPos(ai.frame);
            const int body=aiBattle.WaterBody(p,false);
            if (body<0) continue;
            const bool scout=u.circuitDef.IsRoleAny(Unit::Role::SCOUT.mask);
            const string key=""+body+":"+u.circuitDef.id+(scout ? ":"+u.id : "");
            int index=-1;
            if (!byKey.get(key,index)) {
                index=int(groups.length()); byKey.set(key,index);
                Cohort@ g=Cohort(); g.key=key; g.defId=u.circuitDef.id; g.body=body; g.created=ai.frame;
                groups.insertLast(g);
            }
            Cohort@ g=groups[index]; g.ids.insertLast(u.id);
            g.centre.x+=p.x; g.centre.z+=p.z;
        }
        // Preserve reverse teardown/callback order, but compact survivors in
        // one stable O(G) pass. Repeated removeAt on interleaved dead scouts
        // shifts the live suffix repeatedly and can make cleanup O(G^2).
        for (int i=int(groups.length())-1;i>=0;--i) {
            Cohort@ g=groups[i];
            if (g.ids.length()==0 && g.route !is null && !g.route.IsDead()) g.route.Abort();
        }
        uint live=0;
        for (uint i=0;i<groups.length();++i) {
            Cohort@ g=groups[i];
            if (g.ids.length()==0) continue;
            g.centre.x/=float(g.ids.length()); g.centre.z/=float(g.ids.length());
            @groups[live++]=g;
        }
        groups.resize(live);
        // Rebuild after compaction: dead scout IDs must not accumulate for an
        // entire match, nor leave shifted array indexes in the dictionary.
        byKey.deleteAll();
        for (uint i=0;i<groups.length();++i) byKey.set(groups[i].key,int(i));
    }
    AIFloat3 Search(Cohort@ g) {
        // Different scouts sweep different bearings. Destinations are advisory
        // known start geometry, not omniscient enemy unit positions.
        array<AIFloat3>@ starts=Spam::EnemyStartSpots();
        AIFloat3 anchor=Spam::_MirrorOfStart();
        const AIFloat3 home=Global::Map::StartPos;
        float fx=anchor.x-home.x, fz=anchor.z-home.z;
        const float bearing=atan2(fz,fx);
        float best=1e30f;
        for (uint i=0;i<starts.length();++i) {
            // Unoccupied configured starts can still be on our half of the
            // map (especially small fixtures). Scout forward, not the nearest
            // unused allied-side spawn, while treating starts as hypotheses.
            if ((starts[i].x-home.x)*fx+(starts[i].z-home.z)*fz<=0) continue;
            const float dist=MapHelpers::SqDist(g.centre,starts[i]);
            if (dist<best) { best=dist; anchor=starts[i]; }
        }
        const float angle=bearing+float((g.ids[0]+g.search)%5-2)*.3f;
        const float ring=384.0f+float((g.search/8)%3)*384.0f;
        AIFloat3 p(anchor.x+cos(angle)*ring,0,anchor.z+sin(angle)*ring);
        p=Spam::_Clamp(p);
        if (aiBattle.WaterBody(p,false)==g.body) return p;
        // A land start does not justify a ship climbing a beach. Explore local
        // water in increasing rings when the enemy start is not navigable.
        p=Spam::_Clamp(AIFloat3(g.centre.x+cos(angle)*1200,0,g.centre.z+sin(angle)*1200));
        return aiBattle.WaterBody(p,false)==g.body ? p : g.centre;
    }
    bool Route(Cohort@ g, const AIFloat3 &in goal, bool withdrawing, bool scout, bool hold=false) {
        CCircuitUnit@ lead=ai.GetTeamUnit(g.ids[0]); if (lead is null) return false;
        // GetUnitTerrainRoute is explicitly a ground/amphibious MoveDef API.
        // The naval lane graph supplies water waypoints; the engine executes
        // each segment with the ship's actual MoveDef and native offsets are
        // checked against its movement area. Do not route ships via AMPH.
        array<AIFloat3>@ points=aiBattle.GetTerrainRoute(g.centre,goal,5,10,1,3,1000000);
        if (points.length()<2) {
            if (!withdrawing) return false;
            // Failed escape must still cancel the old advance. A zero-length
            // MOVE at the current legal position is a hold, not a fabricated
            // path through terrain. The next threat census can choose again.
            points.resize(0); points.insertLast(g.centre);
        }
        if (g.route is null || g.route.IsDead()) {
            @g.route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            if (g.route is null) return false;
            g.route.SetSeaControl(true);
            g.route.SetLanes(AiMin(7,int(g.ids.length())),Global::RoleSettings::Sea::FleetLaneSpacing,1.0f);
        }
        // MOVE for scouting/withdrawal prevents engine FIGHT from chasing a
        // contact into the very sub field that caused the withdrawal.
        // A previous invasion screen may have requested HOLD. Other goals
        // retain their original movement state when that screen is interrupted.
        g.route.SetHoldPosition(hold);
        g.route.SetTraversal(true,96,!withdrawing && !scout);
        g.route.SetRoute(points);
        for (uint i=0;i<g.ids.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(g.ids[i]); if (!Eligible(u) || u.task is g.route) continue;
            if (!aiMilitaryMgr.TransferUnit(u,g.route))
                Invariants::Violation("INV-145",""+u.id,"SEA route handover failed");
        }
        g.goal=goal; g.ordered=ai.frame;
        return true;
    }
    void Tick() {
        if (!SeaCombat::Active() || !Global::RoleSettings::Sea::FleetOperations) return;
        Census();
        const int contacts=aiBattle.GetSeaForceCount(); // legal SEA extension; AIR snapshot unchanged
        for (uint k=0;k<groups.length();++k) {
            Cohort@ g=groups[k]; if (g.ids.length()==0) continue;
            CCircuitDef@ def=ai.GetCircuitDef(g.defId);
            const bool scout=def.IsRoleAny(Unit::Role::SCOUT.mask);
            const bool siege=Siege(def);
            const bool subWeapon=def.HasSurfToWater() || def.HasSubToWater();
            float nearest=1e30f, enemySubs=0, cover=0;
            bool scoutExposed=false;
            int target=-1; bool targetSub=false;
            AIFloat3 goal=g.centre;
            const float radius=Global::RoleSettings::Sea::FleetScreenRadius;
            for (int i=0;i<contacts;++i) {
                if (aiBattle.GetSeaForceBody(i)!=g.body) continue;
                const int flags=aiBattle.GetSeaForceFlags(i);
                const AIFloat3 p=aiBattle.GetSeaForcePos(i);
                const float dist=MapHelpers::SqDist(g.centre,p);
                if ((flags&1)!=0) {
                    if ((flags&4)!=0 && (flags&8)==0 && dist<radius*radius) {
                        // Mixed surface armament is not all anti-sub power.
                        CCircuitDef@ allyDef=ai.GetCircuitDef(aiBattle.GetSeaForceDefId(i));
                        const bool dedicated=(flags&2)!=0 || (allyDef !is null && !allyDef.HasSurfToLand());
                        cover+=aiBattle.GetSeaForceCost(i)*(dedicated ? 1.0f : Global::RoleSettings::Sea::HybridSubCoverWeight);
                    }
                    continue;
                }
                if ((flags&2)!=0 && (flags&8)==0 && dist<radius*radius) enemySubs+=(flags&16)!=0 ? Global::RoleSettings::Sea::UnknownSubContactMetal : aiBattle.GetSeaForceCost(i);
                if (scout) {
                    const int enemyDefId=aiBattle.GetSeaForceDefId(i);
                    const CCircuitDef@ enemy=enemyDefId>=0 ? ai.GetCircuitDef(enemyDefId) : null;
                    if (enemy !is null && (enemy.HasSurfToLand() || enemy.HasSubToLand())) {
                        const float safeRange=enemy.GetMaxRange(1)+128.0f;
                        if (dist<safeRange*safeRange) scoutExposed=true;
                    }
                }
                if ((flags&2)!=0 && !subWeapon) continue;
                if ((flags&2)==0 && !def.HasSurfToLand() && !def.HasSubToLand()) continue;
                if (dist<nearest) { nearest=dist; target=aiBattle.GetSeaForceId(i); goal=p; targetSub=(flags&2)!=0; }
            }
            const bool danger=SeaMath::NeedsScreen(enemySubs,cover,Global::RoleSettings::Sea::FleetScreenRatio);
            if ((danger && !subWeapon) || scoutExposed) {
                // Retain the selected escape leg while travelling. Rebuilding
                // a goal 600 elmos behind a moving centroid every second
                // needlessly replaces every member's queue and overshoots home.
                if (g.target==-2 && g.route !is null && !g.route.IsDead()
                    && !g.route.IsAtEnd(ai.GetTeamUnit(g.ids[0]))) continue;
                AIFloat3 home=Global::Map::StartPos;
                // Start may be dry: walk toward it only as far as navigable.
                float dx=home.x-g.centre.x, dz=home.z-g.centre.z;
                const float length=sqrt(dx*dx+dz*dz);
                if (length>1) { dx/=length; dz/=length; }
                const float step=AiMin(600.0f,length);
                goal=AIFloat3(g.centre.x+dx*step,0,g.centre.z+dz*step);
                if (aiBattle.WaterBody(goal,false)!=g.body) goal=g.centre;
                if (SeaMath::NewObjective(g.target,-2,MapHelpers::SqDist(goal,g.goal),ai.frame-g.ordered,10*SECOND)) {
                    if (Route(g,goal,true,scout)) {
                        g.target=-2; GenericHelpers::LogUtil("[SEA][Screen] hold "+def.GetName()+" subs="+enemySubs+" cover="+cover,1);
                    }
                }
                continue;
            }
            if (siege) {
                // Missile ships and flagships already have working native
                // artillery behavior. Only override it for immediate screening;
                // once safe, restore that owner rather than turning them into
                // short-range assault cohorts.
                if (g.target==-2 && g.route !is null && !g.route.IsDead()) {
                    for (uint j=0;j<g.ids.length();++j) {
                        CCircuitUnit@ u=ai.GetTeamUnit(g.ids[j]);
                        if (!Eligible(u) || u.task !is g.route) continue;
                        IUnitTask@ native=aiMilitaryMgr.DefaultMakeTask(u);
                        if (native !is null && !aiMilitaryMgr.TransferUnit(u,native)) native.Abort();
                    }
                    g.route.Abort(); @g.route=null; g.target=-999;
                }
                continue;
            }
            if (Escort(def)) {
                // Native SupportTask selects ATTACK/DEFEND squads only; it
                // cannot follow a fleet while that fleet owns a route. Follow
                // a same-water combat cohort behind its line without changing
                // shared support behavior. One O(G) pass per utility cohort.
                Cohort@ anchor=null; float best=0;
                for (uint j=0;j<groups.length();++j) {
                    Cohort@ candidate=groups[j];
                    if (candidate is g || candidate.body!=g.body || candidate.ids.length()==0) continue;
                    const CCircuitDef@ hull=ai.GetCircuitDef(candidate.defId);
                    if (Escort(hull) || hull.IsRoleAny(Unit::Role::SCOUT.mask)) continue;
                    const float value=hull.costM*float(candidate.ids.length())/(1.0f+sqrt(MapHelpers::SqDist(g.centre,candidate.centre))/1600.0f);
                    if (value>best) { best=value; @anchor=candidate; }
                }
                if (anchor !is null) {
                    const AIFloat3 home=Global::Map::StartPos;
                    float dx=home.x-anchor.centre.x, dz=home.z-anchor.centre.z;
                    const float length=sqrt(dx*dx+dz*dz);
                    if (length>1) { dx/=length; dz/=length; }
                    goal=AIFloat3(anchor.centre.x+dx*256,0,anchor.centre.z+dz*256);
                    if (aiBattle.WaterBody(goal,false)!=g.body) goal=anchor.centre;
                    if (SeaMath::NewObjective(g.target,-3,MapHelpers::SqDist(goal,g.goal),ai.frame-g.ordered,45*SECOND)
                        && Route(g,goal,false,true)) {
                        g.target=-3; GenericHelpers::LogUtil("[SEA][Escort] "+def.GetName()+" follows "+anchor.key,1);
                    }
                }
                continue;
            }
            if (ai.frame<g.nativeUntil) continue;
            if (ai.frame<g.retry) continue;
            if (!scout && !SeaMath::ReleaseFleet(int(g.ids.length()),ai.frame-g.created,
                Global::RoleSettings::Sea::FleetReleaseCount,Global::RoleSettings::Sea::FleetReleaseSeconds*SECOND)) continue;
            if (target>=0 && !scout) {
                const float range=def.GetMaxRange(targetSub ? 2 : 1);
                if (nearest<range*range) {
                    // Reuse proven native contact formations and repair logic;
                    // the director owns approach/recovery, not every shot.
                    IUnitTask@ attack;
                    for (uint j=0;j<g.ids.length();++j) {
                        CCircuitUnit@ u=ai.GetTeamUnit(g.ids[j]);
                        IFighterTask@ current=u is null ? null : cast<IFighterTask>(u.task);
                        if (current !is null && current.GetFightType()==int(Task::FightType::ATTACK)) { @attack=u.task; break; }
                    }
                    if (attack is null) @attack=aiMilitaryMgr.Enqueue(TaskF::Common(Task::FightType::ATTACK));
                    if (attack !is null) {
                        for (uint j=0;j<g.ids.length();++j) {
                            CCircuitUnit@ u=ai.GetTeamUnit(g.ids[j]);
                            // Retain an already-correct native owner. The
                            // contact deadline is an observation cadence, not
                            // permission to reassign the same fleet repeatedly.
                            if (Eligible(u) && u.task !is attack) aiMilitaryMgr.TransferUnit(u,attack);
                        }
                        g.nativeUntil=ai.frame+Global::RoleSettings::Sea::FleetContactSeconds*SECOND;
                    }
                    continue;
                }
                // Approach at the selected layer's range, never max(surface,
                // underwater). The centre path and lane offsets are validated.
                const float dist=sqrt(nearest);
                const float slack=AiMax(80.0f,range*.8f);
                goal=AIFloat3(goal.x+(g.centre.x-goal.x)*slack/dist,0,goal.z+(g.centre.z-goal.z)*slack/dist);
            } else {
                AIFloat3 screen;
                if (!scout && SeaInvasion::Screen(g.body,g.defId,screen)) {
                    // A blocked untouched factory can move its reservation.
                    // Escort follows the new site once, not an obsolete anchor.
                    if (g.target!=-4 || g.route is null || g.route.IsDead() || MapHelpers::SqDist(g.goal,screen)>SQUARE_SIZE*SQUARE_SIZE) {
                        if (Route(g,screen,false,true,true)) g.target=-4;
                        else g.retry=ai.frame+10*SECOND;
                    }
                    if (g.route !is null && !g.route.IsDead()) for (uint member=0;member<g.ids.length();++member) {
                        CCircuitUnit@ reinforcement=ai.GetTeamUnit(g.ids[member]);
                        if (Eligible(reinforcement) && reinforcement.task !is g.route) aiMilitaryMgr.TransferUnit(reinforcement,g.route);
                    }
                    continue;
                }
                target=-1;
                if (ai.frame-g.ordered<Global::RoleSettings::Sea::FleetSearchSeconds*SECOND
                    && g.route !is null && !g.route.IsDead() && !g.route.IsAtEnd(ai.GetTeamUnit(g.ids[0]))) continue;
                ++g.search; goal=Search(g);
            }
            if (!SeaMath::NewObjective(g.target,target,MapHelpers::SqDist(goal,g.goal),ai.frame-g.ordered,
                Global::RoleSettings::Sea::FleetSearchSeconds*SECOND)) continue;
            if (Route(g,goal,false,scout)) {
                g.target=target;
                GenericHelpers::LogUtil("[SEA][Fleet] "+def.GetName()+" n="+g.ids.length()+" target="+target+" goal="+int(goal.x)+","+int(goal.z),1);
            } else {
                g.ordered=ai.frame; g.retry=ai.frame+10*SECOND; ++g.search;
                GenericHelpers::LogUtil("[SEA][Fleet] route unavailable "+def.GetName()+"; select another water objective",3);
            }
        }
    }
}
