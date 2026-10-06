#include "../helpers/layout_helpers.as"
#include "lifecycle.as"

namespace SeaLayout {
    class Berth {
        string key, name;
        int slot = -1, exitZone = 0, facing = 0, unit = -1;
        int cursor = 0, nextSearch = 0, oldUnit = -1, supportSince = -1;
        bool active = false, exited = false, retired = false;
        AIFloat3 centre, anchor;
    }
    class Patch {
        string name;
        int facing = 0, zone = 0;
        bool active = false;
        AIFloat3 centre;
        array<int> slots;
    }
    array<Berth@> berths;
    array<Patch@> patches;
    bool enabled = false;
    int facing = 0, tickFrame = -1;
    int geometryFrame = -1;
    float economyFront = 0;
    bool hadFactory = false;
    dictionary patchCursor, patchRetry;
    bool Enabled() { return enabled && Global::AISettings::Role == AiRole::SEA; }
    bool Active() { return Enabled() && Global::RoleSettings::Sea::ExperimentalBuild; }
    void Save(Berth@ b) {
        aiTerrainMgr.SetLayoutInt(b.key + ".slot", b.slot);
        aiTerrainMgr.SetLayoutInt(b.key + ".exit", b.exitZone);
        aiTerrainMgr.SetLayoutInt(b.key + ".active", b.active ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(b.key + ".unit", b.unit);
        aiTerrainMgr.SetLayoutInt(b.key + ".old", b.oldUnit);
        aiTerrainMgr.SetLayoutInt(b.key + ".exited", b.exited ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(b.key + ".retired", b.retired ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(b.key + ".ax", int(b.anchor.x));
        aiTerrainMgr.SetLayoutInt(b.key + ".az", int(b.anchor.z));
        aiTerrainMgr.SetLayoutInt(b.key + ".tier", UnitHelpers::IsT2Shipyard(b.name) ? 2 : 1);
        CCircuitDef@ definition=ai.GetCircuitDef(b.name);
        aiTerrainMgr.SetLayoutInt(b.key + ".def", definition is null ? -1 : int(definition.id));
        aiTerrainMgr.SetLayoutInt("sea.berths", int(berths.length()));
    }
    void SavePatch(uint i) {
        Patch@ p = patches[i];
        const string key = "sea.patch." + i;
        CCircuitDef@ d = ai.GetCircuitDef(p.name);
        aiTerrainMgr.SetLayoutInt(key + ".def", d is null ? -1 : int(d.id));
        aiTerrainMgr.SetLayoutInt(key + ".facing", p.facing);
        aiTerrainMgr.SetLayoutInt(key + ".zone", p.zone);
        aiTerrainMgr.SetLayoutInt(key + ".active", p.active ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(key + ".x", int(p.centre.x)); aiTerrainMgr.SetLayoutInt(key + ".z", int(p.centre.z));
        aiTerrainMgr.SetLayoutInt(key + ".n", int(p.slots.length()));
        for (uint j=0; j<p.slots.length(); ++j) aiTerrainMgr.SetLayoutInt(key + ".slot." + j, p.slots[j]);
        aiTerrainMgr.SetLayoutInt("sea.patches", int(patches.length()));
    }
    void Init(const string &in side) {
        enabled = (Global::RoleSettings::Sea::ExperimentalBuild || Global::RoleSettings::Sea::CompactEconomy)
            && aiTerrainMgr.SetLayoutEnabled(true);
        if (!enabled) return;
        aiBattle.PrepareWater();
        AIFloat3 enemy=LayoutHelpers::TerrainCentre();
        array<AIFloat3> enemyStarts=Lanes::EnemyStarts();
        if (enemyStarts.length()>0) {
            enemy=AIFloat3(0,0,0);
            for (uint i=0;i<enemyStarts.length();++i) enemy=enemy+enemyStarts[i];
            enemy=enemy/float(enemyStarts.length());
        }
        facing=LayoutHelpers::FacingToward(Global::Map::StartPos,enemy);
        hadFactory=aiTerrainMgr.GetLayoutInt("sea.hadFactory",0)!=0;
        geometryFrame=-1;
        if (aiTerrainMgr.GetLayoutInt("sea.captured",0)==0) {
            aiTerrainMgr.SetLayoutInt("sea.nanoPrior",aiEconomyMgr.assistNanoEnabled ? 1 : 0);
            aiTerrainMgr.SetLayoutInt("sea.buildPrior",aiBuilderMgr.experimentalBuild ? 1 : 0);
            aiTerrainMgr.SetLayoutInt("sea.captured",1);
        }
        if (aiTerrainMgr.GetLayoutInt("sea.convertCaptured",0)==0) {
            aiTerrainMgr.SetLayoutInt("sea.convertPrior",int(aiEconomyMgr.reclConvertEff*1000000.0f));
            aiTerrainMgr.SetLayoutInt("sea.convertCaptured",1);
        }
        aiEconomyMgr.assistNanoEnabled = false;
        // Cheap naval T1 converters retain useful conversion capacity. Their
        // reserved rows do not need to be reclaimed when T2 becomes available.
        aiEconomyMgr.reclConvertEff = 0;
        if (Active()) aiBuilderMgr.experimentalBuild = true;
        berths.resize(0); patches.resize(0); patchCursor.deleteAll(); patchRetry.deleteAll();
        for (int i=0; i<aiTerrainMgr.GetLayoutInt("sea.berths",0); ++i) {
            Berth b; b.key="sea.berth."+i;
            b.name=aiTerrainMgr.GetLayoutInt(b.key+".tier",1)==2 ? UnitHelpers::GetT2ShipyardForSide(side) : UnitHelpers::GetT1ShipyardForSide(side);
            const int defId=aiTerrainMgr.GetLayoutInt(b.key+".def",-1);
            CCircuitDef@ saved=defId<0 ? null : ai.GetCircuitDef(defId);
            if (saved !is null) b.name=saved.GetName(); // old named state retains tier fallback
            b.slot=aiTerrainMgr.GetLayoutInt(b.key+".slot",-1); b.exitZone=aiTerrainMgr.GetLayoutInt(b.key+".exit",0);
            b.facing=aiTerrainMgr.GetLayoutInt(b.key+".facing",facing);
            b.centre=AIFloat3(float(aiTerrainMgr.GetLayoutInt(b.key+".x",0)),0,float(aiTerrainMgr.GetLayoutInt(b.key+".z",0)));
            b.anchor=AIFloat3(float(aiTerrainMgr.GetLayoutInt(b.key+".ax",int(b.centre.x))),0,float(aiTerrainMgr.GetLayoutInt(b.key+".az",int(b.centre.z))));
            b.active=aiTerrainMgr.GetLayoutInt(b.key+".active",0)!=0;
            b.unit=aiTerrainMgr.GetLayoutInt(b.key+".unit",-1); b.oldUnit=aiTerrainMgr.GetLayoutInt(b.key+".old",-1);
            b.exited=aiTerrainMgr.GetLayoutInt(b.key+".exited",0)!=0; berths.insertLast(b);
            b.retired=aiTerrainMgr.GetLayoutInt(b.key+".retired",0)!=0;
        }
        for (int i=0; i<aiTerrainMgr.GetLayoutInt("sea.patches",0); ++i) {
            const string key="sea.patch."+i;
            const int defId=aiTerrainMgr.GetLayoutInt(key+".def",-1);
            if (defId<=0) continue;
            CCircuitDef@ d=ai.GetCircuitDef(defId);
            if (d is null) continue;
            Patch p; p.name=d.GetName(); p.zone=aiTerrainMgr.GetLayoutInt(key+".zone",0);
            p.facing=aiTerrainMgr.GetLayoutInt(key+".facing",facing); p.active=aiTerrainMgr.GetLayoutInt(key+".active",0)!=0;
            p.centre=AIFloat3(float(aiTerrainMgr.GetLayoutInt(key+".x",0)),0,float(aiTerrainMgr.GetLayoutInt(key+".z",0)));
            for (int j=0; j<aiTerrainMgr.GetLayoutInt(key+".n",0); ++j) p.slots.insertLast(aiTerrainMgr.GetLayoutInt(key+".slot."+j,-1));
            patches.insertLast(p);
        }
        GenericHelpers::LogUtil("[SEA][Layout] enabled; adopted berths="+berths.length()+" patches="+patches.length(),1);
    }
    void Leave() {
        if (!enabled) return;
        aiEconomyMgr.assistNanoEnabled=aiTerrainMgr.GetLayoutInt("sea.nanoPrior",1)!=0;
        aiBuilderMgr.experimentalBuild=aiTerrainMgr.GetLayoutInt("sea.buildPrior",0)!=0;
        aiEconomyMgr.reclConvertEff=float(aiTerrainMgr.GetLayoutInt("sea.convertPrior",2000000))/1000000.0f;
        aiTerrainMgr.ResetLayout(); aiTerrainMgr.SetLayoutEnabled(false);
        enabled=false; berths.resize(0); patches.resize(0);
    }
    float Along(const AIFloat3 &in p) {
        if (facing==1) return p.x-Global::Map::StartPos.x;
        if (facing==2) return Global::Map::StartPos.z-p.z;
        if (facing==3) return Global::Map::StartPos.x-p.x;
        return p.z-Global::Map::StartPos.z;
    }
    bool EconomyDef(const CCircuitDef@ d) {
        if (d is null) return false;
        const string name=d.GetName(), side=UnitHelpers::GetSideForUnitName(name);
        return name==UnitHelpers::GetTidalNameForSide(side) || name==UnitHelpers::GetNavalFusionNameForSide(side)
            || name==UnitHelpers::GetNavalEnergyConverterNameForSide(side) || name==UnitHelpers::GetAdvNavalEnergyConverterNameForSide(side);
    }
    void RefreshGeometry() {
        if (ai.frame-geometryFrame<SECOND && geometryFrame>=0) return;
        geometryFrame=ai.frame; economyFront=-100000.0f;
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaEconomy::owned[i]); if (u is null) continue;
            if (SeaEconomy::Yard(u.circuitDef)) hadFactory=true;
            if (!EconomyDef(u.circuitDef)) continue;
            const int f=aiTerrainMgr.GetBuildingFacing(u);
            const float half=float(((f-facing)%2==0) ? u.circuitDef.GetFootprintZ() : u.circuitDef.GetFootprintX())*8.0f;
            economyFront=AiMax(economyFront,Along(u.GetPos(ai.frame))+half);
        }
        for (uint i=0;i<patches.length();++i) {
            Patch@ patch=patches[i]; CCircuitDef@ d=ai.GetCircuitDef(patch.name);
            if (!EconomyDef(d)) continue;
            const float half=float(((patch.facing-facing)%2==0) ? d.GetFootprintZ() : d.GetFootprintX())*8.0f;
            for (uint j=0;j<patch.slots.length();++j)
                if (aiTerrainMgr.GetReservationState(patch.slots[j])>=0)
                    economyFront=AiMax(economyFront,Along(aiTerrainMgr.GetReservationPos(patch.slots[j]))+half);
        }
        for (uint i=0;i<SeaEcoLayout::blocks.length();++i) {
            SeaEcoLayout::Block@ b=SeaEcoLayout::blocks[i];
            if (b.zone>0) economyFront=AiMax(economyFront,Along(b.centre)+b.half);
        }
        if (hadFactory) aiTerrainMgr.SetLayoutInt("sea.hadFactory",1);
    }
    bool Opening(Berth@ b) {
        return SeaMath::OpeningFactory(!hadFactory,UnitHelpers::IsT1Shipyard(b.name),b.oldUnit<0,b.key=="sea.berth.0");
    }
    bool ForwardSite(CCircuitDef@ d, const AIFloat3 &in p, int f) {
        return f==facing && SeaMath::ForwardFootprint(Along(p),float(d.GetFootprintZ())*8.0f,economyFront,
            Global::RoleSettings::Sea::FactoryEconomyClearance);
    }
    bool RearEconomy(const AIFloat3 &in p, float halfDepth) {
        const AIFloat3 harbor=SeaEcoLayout::Harbor();
        return harbor.x<0 || Along(p)+halfDepth<=Along(harbor)-Global::RoleSettings::Sea::FactoryEconomyClearance;
    }
    AIFloat3 Candidate(const AIFloat3 &in anchor, int cursor, float step) {
        if (cursor==0) return anchor;
        const int ring=1+(cursor-1)/16;
        const float a=float((cursor-1)%16)*6.2831853f/16.0f;
        return AIFloat3(anchor.x+cos(a)*float(ring)*step,0,anchor.z+sin(a)*float(ring)*step);
    }
    Berth@ Add(const string &in name, const AIFloat3 &in anchor, int oldUnit=-1) {
        Berth b; b.key="sea.berth."+berths.length(); b.name=name; b.anchor=anchor; b.oldUnit=oldUnit;
        berths.insertLast(b); Save(b); return b;
    }
    bool Search(Berth@ b) {
        if (b.retired) return false;
        if (b.slot>=0 || ai.frame<b.nextSearch) return b.slot>=0;
        b.nextSearch=ai.frame+SECOND;
        CCircuitDef@ d=ai.GetCircuitDef(b.name);
        if (d is null) return false;
        RefreshGeometry();
        const bool opening=Opening(b);
        const float searchRadius=opening ? Global::RoleSettings::Sea::HarborSearchRadius
            : Global::RoleSettings::Sea::ForwardHarborSearchRadius;
        int geometryQueries=0;
        for (int k=0; k<32 && geometryQueries<8; ++k) {
            const int c=b.cursor++;
            const AIFloat3 p=Candidate(b.anchor,c/4,96.0f);
            if (MapHelpers::SqDist(p,b.anchor)>searchRadius*searchRadius) { b.cursor=0; b.nextSearch=ai.frame+10*SECOND; break; }
            const int f=opening ? (facing+c%4)%4 : facing;
            if (!opening && (c%4!=0 || !ForwardSite(d,p,f))) continue;
            // Coastal starts are often on land. Skip its other facings without
            // spending a full hull/route query or delaying the first factory.
            if (aiBattle.Height(p)>=0) { b.cursor=(c/4+1)*4; continue; }
            if (aiBattle.SurfThreat(p)>Global::RoleSettings::Sea::HarborMaxThreat || aiBattle.AirThreat(p)>Global::RoleSettings::Sea::HarborMaxThreat) continue;
            if (b.oldUnit>=0 && !SeaFactories::Safe(p)) continue;
            ++geometryQueries;
            if (UnitHelpers::IsSeaplanePlatform(b.name)) {
                // Flying products do not require a deep-water ship corridor.
                // The common reservation still protects allies and yard exits.
                b.slot=aiTerrainMgr.ReservePersistentBuilding(d,p,f); b.exitZone=0;
                if (b.slot<0) continue;
                aiTerrainMgr.SetLayoutInt(b.key+".facing",f);
                const AIFloat3 snapped=aiTerrainMgr.GetReservationPos(b.slot);
                aiTerrainMgr.SetLayoutInt(b.key+".x",int(snapped.x)); aiTerrainMgr.SetLayoutInt(b.key+".z",int(snapped.z));
            } else {
                if (!aiTerrainMgr.PlanNavalBerth(b.key,d,p,f,Global::RoleSettings::Sea::ExitLength,Global::RoleSettings::Sea::ExitMargin)) continue;
                b.slot=aiTerrainMgr.GetLayoutInt(b.key+".slot",-1); b.exitZone=aiTerrainMgr.GetLayoutInt(b.key+".exit",0);
            }
            b.facing=f; b.centre=aiTerrainMgr.GetReservationPos(b.slot);
            if (!opening && !ForwardSite(d,b.centre,f)) {
                aiTerrainMgr.ReleasePersistentBuilding(b.slot); aiTerrainMgr.ReleaseZone(b.exitZone);
                b.slot=-1; b.exitZone=0; continue;
            }
            Save(b);
            GenericHelpers::LogUtil("[SEA][Layout] berth "+b.key+" "+b.name+" at="+int(b.centre.x)+","+int(b.centre.z)+" facing="+f,1);
            return true;
        }
        return false;
    }
    IUnitTask@ Pinned(CCircuitDef@ d, int slot, Task::BuildType kind, Task::Priority priority) {
        if (d is null || slot<0 || aiTerrainMgr.GetReservationState(slot)!=0) return null;
        const AIFloat3 p=aiTerrainMgr.GetReservationPos(slot);
        IUnitTask@ t=kind==Task::BuildType::FACTORY
            ? aiBuilderMgr.Enqueue(TaskB::Factory(priority,d,p,null,0.0f,false,true,600*SECOND))
            : aiBuilderMgr.Enqueue(TaskB::Common(kind,priority,d,p,0.0f,true,300*SECOND));
        if (t !is null && AiPinReservation(t,slot)) { SeaEconomy::Added(t); return t; }
        if (t !is null) aiBuilderMgr.AbortTask(t);
        return null;
    }
    void Validate(Berth@ b) {
        if (b.retired) {
            if (b.slot>=0 && ai.GetTeamUnit(b.unit) is null) {
                aiTerrainMgr.ReleasePersistentBuilding(b.slot); aiTerrainMgr.ReleaseZone(b.exitZone);
                b.slot=-1; b.exitZone=0; Save(b);
            }
            return;
        }
        if (SeaMath::RetryBerth(b.active,b.unit>=0 && ai.GetTeamUnit(b.unit) !is null,aiTerrainMgr.GetReservationState(b.slot))) {
            b.active=false; b.unit=-1; b.exited=false; Save(b);
        }
        if (b.active || b.slot<0) return;
        const int state=aiTerrainMgr.GetReservationState(b.slot);
        if (state>=1 && state<=3) { b.active=true; Save(b); return; }
        if (aiTerrainMgr.IsReservationBuildable(b.slot) && (b.exitZone==0 || aiTerrainMgr.IsZoneClear(b.exitZone))) return;
        aiTerrainMgr.ReleasePersistentBuilding(b.slot); aiTerrainMgr.ReleaseZone(b.exitZone);
        b.slot=-1; b.exitZone=0; Save(b);
        GenericHelpers::LogUtil("[SEA][Layout] replan unused berth "+b.key,1);
    }
    IUnitTask@ Factory(CCircuitUnit@ u, const string &in name, int oldUnit=-1, const AIFloat3 &in anchor=AIFloat3(-1,0,-1)) {
        CCircuitDef@ d=ai.GetCircuitDef(name);
        if (d is null || !d.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(d)) return null;
        if (!SeaFactories::FactoryAllowed(d)) return null;
        Berth@ b=null;
        for (uint i=0; i<berths.length(); ++i) if (berths[i].name==name && !berths[i].active && !berths[i].retired && berths[i].oldUnit==oldUnit) { @b=berths[i]; break; }
        if (b is null) {
            const AIFloat3 harbor=SeaEcoLayout::Harbor();
            @b=Add(name,anchor.x>=0 ? anchor : harbor.x>=0 ? harbor : Global::Map::StartPos,oldUnit);
        }
        Validate(b); RefreshGeometry();
        if (!Opening(b) && b.slot>=0 && aiTerrainMgr.GetReservationState(b.slot)==0 && !ForwardSite(d,b.centre,b.facing)) {
            aiTerrainMgr.ReleasePersistentBuilding(b.slot); aiTerrainMgr.ReleaseZone(b.exitZone);
            b.slot=-1; b.exitZone=0; b.cursor=0; Save(b);
        }
        if (!Search(b) || !aiTerrainMgr.CanReachAt(u,b.centre,u.circuitDef.GetBuildDistance())) return null;
        if (UnitHelpers::IsSeaplanePlatform(name)) {
            CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(UnitHelpers::GetSideForUnitName(name)));
            const int required=AiMax(1,AiMin(Global::RoleSettings::Sea::MaxSupportPerBerth,Global::RoleSettings::Sea::ReservedSupportPerFactory));
            SeaBuild::ReserveSupport(nano,b.centre,b.facing);
            if (SeaBuild::SupportFootprint(nano,b.centre,required)<required) {
                if (b.supportSince<0) b.supportSince=ai.frame;
                // A footprint-only fit is insufficient. Continue the bounded
                // candidate search if the support bank cannot fit; never move
                // a committed/active platform or release another factory's pad.
                if (ai.frame-b.supportSince>=10*SECOND && aiTerrainMgr.GetReservationState(b.slot)==0) {
                    aiTerrainMgr.ReleasePersistentBuilding(b.slot);
                    b.slot=-1; b.supportSince=-1; Save(b);
                }
                return null;
            }
            b.supportSince=-1;
            if (Global::RoleSettings::Sea::SeaplanesAfterT2 && !SeaFactories::T2Finished(UnitHelpers::GetSideForUnitName(name))) {
                Invariants::Violation("INV-151",b.key,"SEA seaplane admitted before completed T2 shipyard"); return null;
            }
        }
        if (!Opening(b) && !ForwardSite(d,b.centre,b.facing)) {
            Invariants::Violation("INV-138",b.key,"later shipyard is behind economy or faces away from enemy"); return null;
        }
        return Pinned(d,b.slot,Task::BuildType::FACTORY,Task::Priority::HIGH);
    }
    void Discard(Patch@ p) {
        for (uint j=0; j<p.slots.length(); ++j) aiTerrainMgr.ReleasePersistentBuilding(p.slots[j]);
        aiTerrainMgr.ReleaseZone(p.zone); p.slots.resize(0); p.zone=0;
    }
    bool PlanPatch(CCircuitDef@ d, const AIFloat3 &in anchor, int count, float maxRadius, const AIFloat3 &in assist=AIFloat3(-1,0,-1)) {
        const string key=d.GetName(); int64 cursor=0, retry=0;
        // Different harbors must not consume each other's search attempts.
        const string searchKey=key+":"+int(anchor.x/8)+":"+int(anchor.z/8)+":"+count;
        if (patchRetry.get(searchKey,retry) && ai.frame<retry) return false;
        patchCursor.get(searchKey,cursor); patchRetry.set(searchKey,int64(ai.frame+SECOND));
        if (count<=0) return false;
        const bool tidal=d.GetName()==UnitHelpers::GetTidalNameForSide(UnitHelpers::GetSideForUnitName(d.GetName()));
        if (tidal) count=AiMax(6,Global::RoleSettings::Sea::TidalClusterSites);
        const int cols=tidal ? 6 : count<=2 ? count : count>6 ? 5 : 3;
        const int rows=(count+cols-1)/cols;
        // Small T1/converter patches are edge-to-edge. Keep the existing fusion
        // clearance; factory exits have their own independent reservations.
        const bool fusion=d.GetName()==UnitHelpers::GetNavalFusionNameForSide(UnitHelpers::GetSideForUnitName(d.GetName()));
        const float gap=fusion ? 16.0f : 0.0f;
        const float width=float(d.GetFootprintX())*16.0f+gap, depth=float(d.GetFootprintZ())*16.0f+gap;
        array<AIFloat3> extensions;
        if (gap==0 && count<=6 && assist.x<0) {
            // Grow economical strips sideways, flush with the preceding patch.
            // Two rows remain serviceable from the outside even as the strip
            // length grows. Bounded candidates preserve the existing search cap.
            for (int i=int(patches.length())-1; i>=0 && extensions.length()<4; --i) {
                Patch@ prior=patches[uint(i)];
                if (prior.name!=key || int(prior.slots.length())!=count || prior.facing!=facing) continue;
                extensions.insertLast(LayoutHelpers::Offset(prior.centre,facing,float(cols)*width,0));
                extensions.insertLast(LayoutHelpers::Offset(prior.centre,facing,-float(cols)*width,0));
            }
        }
        for (int k=0; k<8; ++k) {
            const bool extension=k<int(extensions.length());
            const AIFloat3 p=extension ? extensions[uint(k)] : Candidate(anchor,int(cursor++),96.0f);
            if (MapHelpers::SqDist(p,anchor)>maxRadius*maxRadius) { if (extension) continue; cursor=0; break; }
            if (aiBattle.SurfThreat(p)>Global::RoleSettings::Sea::HarborMaxThreat) continue;
            if (assist.x<0 && !RearEconomy(p,depth*float(rows)*.5f)) continue;
            Patch plan; plan.name=key; plan.facing=facing; plan.centre=p;
            bool ok=true;
            for (int j=0; j<count; ++j) {
                const AIFloat3 site=LayoutHelpers::Offset(p,facing,(float(j%cols)-float(cols-1)*.5f)*width,
                    (float(j/cols)-float(rows-1)*.5f)*depth);
                if (assist.x>=0 && MapHelpers::SqDist(site,assist)>d.GetBuildDistance()*d.GetBuildDistance()) { ok=false; break; }
                const int slot=aiTerrainMgr.ReservePersistentBuilding(d,site,facing);
                if (slot<0) { ok=false; break; }
                plan.slots.insertLast(slot);
            }
            if (ok) ok=LayoutHelpers::CheckGrid(plan.slots,0,cols,facing,width,depth);
            if (ok && gap>0) {
                plan.zone=aiTerrainMgr.ReserveZone(p,facing,width*float(cols)*.5f,depth*float(rows)*.5f,false);
                ok=plan.zone>0;
            }
            // Dense patches are already entirely owned by their slot zones.
            // ReserveZone correctly returns 0 for an empty extra envelope.
            if (!ok) { Discard(plan); continue; }
            patches.insertLast(plan); geometryFrame=-1; SavePatch(patches.length()-1); patchCursor.set(searchKey,cursor);
            return true;
        }
        patchCursor.set(searchKey,cursor); return false;
    }
    IUnitTask@ Place(CCircuitUnit@ u, CCircuitDef@ d, Task::BuildType kind, const AIFloat3 &in anchor, int count=6, float radius=1200.0f, const AIFloat3 &in assist=AIFloat3(-1,0,-1)) {
        if (d is null || !d.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(d)) return null;
        for (int pass=0; pass<2; ++pass) {
            for (uint i=0; i<patches.length(); ++i) {
                Patch@ p=patches[i];
                if (p.name!=d.GetName() || MapHelpers::SqDist(p.centre,anchor)>radius*radius) continue;
                if (!p.active) {
                    const int state=LayoutHelpers::ActivationState(p.slots);
                    if (state==1) { Discard(p); SavePatch(i); continue; }
                    if (state==2) { p.active=true; SavePatch(i); }
                }
                for (uint j=0; j<p.slots.length(); ++j) {
                    const int slot=p.slots[j];
                    if (aiTerrainMgr.GetReservationState(slot)!=0 || !aiTerrainMgr.IsReservationBuildable(slot)) continue;
                    const AIFloat3 pos=aiTerrainMgr.GetReservationPos(slot);
                    if (assist.x>=0 && MapHelpers::SqDist(pos,assist)>d.GetBuildDistance()*d.GetBuildDistance()) continue;
                    if (!aiTerrainMgr.CanReachAt(u,pos,u.circuitDef.GetBuildDistance())) continue;
                    IUnitTask@ t=Pinned(d,slot,kind,Task::Priority::NORMAL);
                    if (t !is null) { p.active=true; SavePatch(i); return t; }
                }
            }
            if (pass==0 && !PlanPatch(d,anchor,count,radius,assist)) break;
        }
        return null;
    }
}
