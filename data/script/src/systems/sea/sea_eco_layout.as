#include "sea_economy.as"

// SEA owns policy/state; the same native zone, band and set packer serves TECH.
namespace SeaEcoLayout {
    class Block {
        int zone=0, group=0, fusion=-1;
        bool active=false, wantsFusion=false;
        AIFloat3 centre, harbor;
        float half=320.0f;
    }
    array<Block@> blocks;
    dictionary exits;
    int direction=0, cursor=0, nextSearch=0;
    bool ready=false;
    void Save(uint i) {
        Block@ b=blocks[i]; const string key="sea.eco."+i;
        aiTerrainMgr.SetLayoutInt(key+".zone",b.zone);
        aiTerrainMgr.SetLayoutInt(key+".half",int(b.half));
        aiTerrainMgr.SetLayoutInt(key+".group",b.group);
        aiTerrainMgr.SetLayoutInt(key+".fusion",b.fusion);
        aiTerrainMgr.SetLayoutInt(key+".active",b.active ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(key+".wantsFusion",b.wantsFusion ? 1 : 0);
        aiTerrainMgr.SetLayoutInt(key+".x",int(b.centre.x)); aiTerrainMgr.SetLayoutInt(key+".z",int(b.centre.z));
        aiTerrainMgr.SetLayoutInt(key+".hx",int(b.harbor.x)); aiTerrainMgr.SetLayoutInt(key+".hz",int(b.harbor.z));
        aiTerrainMgr.SetLayoutInt("sea.eco.count",int(blocks.length()));
        aiTerrainMgr.SetLayoutInt("sea.eco.facing",direction);
    }
    void Reset() { ready=false; blocks.resize(0); exits.deleteAll(); cursor=0; nextSearch=0; }
    void Init() {
        if (ready) return;
        ready=true;
        AIFloat3 enemy=LayoutHelpers::TerrainCentre();
        array<AIFloat3> starts=Lanes::EnemyStarts();
        if (starts.length()>0) {
            enemy=AIFloat3(0,0,0);
            for (uint i=0;i<starts.length();++i) enemy=enemy+starts[i];
            enemy=enemy/float(starts.length());
        }
        direction=aiTerrainMgr.GetLayoutInt("sea.eco.facing",LayoutHelpers::FacingToward(Global::Map::StartPos,enemy));
        for (int i=0;i<aiTerrainMgr.GetLayoutInt("sea.eco.count",0);++i) {
            const string key="sea.eco."+i;
            Block b; b.zone=aiTerrainMgr.GetLayoutInt(key+".zone",0); b.group=aiTerrainMgr.GetLayoutInt(key+".group",0);
            b.half=float(aiTerrainMgr.GetLayoutInt(key+".half",320));
            b.fusion=aiTerrainMgr.GetLayoutInt(key+".fusion",-1); b.active=aiTerrainMgr.GetLayoutInt(key+".active",0)!=0;
            b.wantsFusion=aiTerrainMgr.GetLayoutInt(key+".wantsFusion",0)!=0;
            b.centre=AIFloat3(float(aiTerrainMgr.GetLayoutInt(key+".x",0)),0,float(aiTerrainMgr.GetLayoutInt(key+".z",0)));
            b.harbor=AIFloat3(float(aiTerrainMgr.GetLayoutInt(key+".hx",0)),0,float(aiTerrainMgr.GetLayoutInt(key+".hz",0)));
            blocks.insertLast(b);
        }
    }
    bool Managed(const CCircuitDef@ d) {
        if (d is null) return false;
        const string name=d.GetName(), side=UnitHelpers::GetSideForUnitName(name);
        return name==UnitHelpers::GetNavalFusionNameForSide(side)
            || name==UnitHelpers::GetNavalEnergyConverterNameForSide(side)
            || name==UnitHelpers::GetAdvNavalEnergyConverterNameForSide(side);
    }
    float Along(const AIFloat3 &in p, const AIFloat3 &in origin) {
        if (direction==1) return p.x-origin.x;
        if (direction==2) return origin.z-p.z;
        if (direction==3) return origin.x-p.x;
        return p.z-origin.z;
    }
    bool Rear(Block@ b, CCircuitDef@ fusion) {
        const AIFloat3 p=aiTerrainMgr.GetReservationPos(b.fusion);
        // The footprint, not merely its centre, stays behind the harbor.
        // The reservation is rotated with direction, so its local Z dimension
        // is always the depth along the strategic axis.
        return SeaMath::RearFootprint(Along(p,b.harbor),float(fusion.GetFootprintZ())*8.0f,64.0f);
    }
    AIFloat3 Harbor() {
        for (uint i=0;i<SeaLayout::berths.length();++i)
            if (SeaLayout::berths[i].slot>=0 && !SeaLayout::berths[i].retired) return SeaLayout::berths[i].centre;
        for (uint i=0;i<SeaEconomy::productionFactories.length();++i) {
            CCircuitUnit@ factory=ai.GetTeamUnit(SeaEconomy::productionFactories[i]);
            if (factory !is null) return factory.GetPos(ai.frame);
        }
        return AIFloat3(-1,0,-1);
    }
    bool Plan() {
        Init();
        if (ai.frame<nextSearch) return false;
        nextSearch=ai.frame+SECOND;
        const AIFloat3 harbor=Harbor(); if (harbor.x<0) return false;
        const string side=Global::AISettings::Side;
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(side));
        CCircuitDef@ fusion=ai.GetCircuitDef(UnitHelpers::GetNavalFusionNameForSide(side));
        if (nano is null || fusion is null) return false;
        const int n=AiMax(2,AiMin(6,Global::RoleSettings::Sea::EconomyTurretSide));
        const float depth=float(nano.GetFootprintZ()*n)*16.0f;
        const float half=AiMax(320.0f,depth*.5f+192.0f);
        for (int k=0;k<8;++k) {
            const int c=cursor++;
            const int column=c%13, row=c/13;
            const float across=float((column+1)/2)*128.0f*(column%2==0 ? -1.0f : 1.0f);
            // The economy envelope must not consume the factory's assist disc
            // while a tight shoreline is still fitting its support bank.
            const AIFloat3 p=LayoutHelpers::Offset(harbor,direction,across,-half-nano.GetBuildDistance()-64.0f-float(row)*128.0f);
            if (MapHelpers::SqDist(p,harbor)>Global::RoleSettings::Sea::EconomyBlockRadius*Global::RoleSettings::Sea::EconomyBlockRadius) {
                if (column==0) { cursor=0; nextSearch=ai.frame+10*SECOND; break; }
                continue;
            }
            if (aiBattle.Height(p)>=0 || aiBattle.SurfThreat(p)>Global::RoleSettings::Sea::HarborMaxThreat) continue;
            Block b; b.centre=p; b.harbor=harbor; b.half=half;
            b.zone=aiTerrainMgr.ReserveZone(p,direction,half,half,false);
            if (b.zone<=0) continue;
            b.group=aiTerrainMgr.LayBand(b.zone,nano,LayoutHelpers::Offset(p,direction,0,depth*.5f),direction,n,n,0,false,true,false,0);
            if (b.group>0 && aiTerrainMgr.GetGroupCount(b.group,false)==n*n)
                b.fusion=aiTerrainMgr.PackNearGroup(b.zone,fusion,b.group,direction,
                    LayoutHelpers::Offset(p,direction,0,-half*.7f),nano.GetBuildDistance()*.8f,0,0);
            if (b.fusion<0 || !Rear(b,fusion)
                || aiTerrainMgr.CountGroupSlotsWithin(b.group,aiTerrainMgr.GetReservationPos(b.fusion),nano.GetBuildDistance())<n*n) {
                aiTerrainMgr.ReleaseZone(b.zone); continue;
            }
            blocks.insertLast(b); SeaLayout::geometryFrame=-1; Save(blocks.length()-1);
            GenericHelpers::LogUtil("[SEA][EcoBlock] planned centre="+int(p.x)+","+int(p.z)+" harbor="+int(harbor.x)+","+int(harbor.z)
                +" facing="+direction+" turrets="+(n*n)+" fusion="+b.fusion,1);
            return true;
        }
        return false;
    }
    void Tick() {
        Init();
        // Actual yards (including inherited/amphibious factories) keep their exits.
        for (uint i=0;i<SeaEconomy::productionFactories.length();++i) {
            CCircuitUnit@ factory=ai.GetTeamUnit(SeaEconomy::productionFactories[i]);
            if (factory is null || exits.exists(""+factory.id)) continue;
            const string key="sea.eco.exit."+factory.id;
            int zone=aiTerrainMgr.GetLayoutInt(key,0);
            if (zone==0) zone=aiTerrainMgr.ReserveExitCone(factory,Global::RoleSettings::Sea::ExitLength,Global::RoleSettings::Sea::ExitMargin);
            if (zone>0) { exits.set(""+factory.id,zone); aiTerrainMgr.SetLayoutInt(key,zone); }
        }
        bool any=false;
        for (uint i=0;i<blocks.length();++i) {
            Block@ b=blocks[i]; if (b.zone==0) continue;
            if (!b.active && (aiTerrainMgr.GetGroupActivationState(b.group)==1 || !aiTerrainMgr.IsReservationBuildable(b.fusion))) {
                aiTerrainMgr.ReleaseZone(b.zone); b.zone=0; Save(i); continue;
            }
            any=true;
        }
        if (!any) Plan();
    }
    IUnitTask@ Nano(CCircuitUnit@ u, Block@ b, CCircuitDef@ work, bool preparing=false) {
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(Global::AISettings::Side));
        if (nano is null || !nano.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(nano)) return null;
        float existing=float(aiTerrainMgr.GetGroupCount(b.group,false)-aiTerrainMgr.GetGroupCount(b.group,true))*nano.GetBuildSpeed();
        const float extent=float(nano.GetFootprintX()*Global::RoleSettings::Sea::EconomyTurretSide)*16.0f;
        for (uint i=0;i<SeaEconomy::projects.length();++i) {
            IBuilderTask@ pending=cast<IBuilderTask>(SeaEconomy::projects[i]);
            if (pending !is null && !pending.IsDead() && pending.target is null && pending.buildDef is nano
                && MapHelpers::SqDist(pending.GetBuildPos(),b.centre)<extent*extent) existing+=nano.GetBuildSpeed();
        }
        const float floor=float(Global::RoleSettings::Sea::FusionMinimumTurrets)*nano.GetBuildSpeed();
        const float target=preparing ? floor : AiMax(floor,SeaEconomy::UsefulPower(work,Global::RoleSettings::Sea::EconomyIncomeShare));
        if (existing>=target || !SeaEconomy::Fund(nano,u.circuitDef.GetBuildSpeed(),0,0)) return null;
        const int slot=aiTerrainMgr.NextReachableSlot(u,nano,b.zone,b.group,8);
        if (slot<0 || !aiTerrainMgr.CanReachAt(u,aiTerrainMgr.GetReservationPos(slot),u.circuitDef.GetBuildDistance())) return null;
        IUnitTask@ task=SeaLayout::Pinned(nano,slot,Task::BuildType::NANO,Task::Priority::HIGH);
        if (task !is null) { SeaEconomy::Admit(nano,true,true); b.active=true; }
        return task;
    }
    IUnitTask@ Support(CCircuitUnit@ u) {
        for (uint i=0;i<blocks.length();++i) {
            Block@ b=blocks[i]; if (b.zone==0) continue;
            CCircuitUnit@ fusion=aiTerrainMgr.GetReservationUnit(b.fusion);
            // T2 construction subs cannot build T1 naval turrets. Publish the
            // preparation demand so a T1 constructor can supply this workforce.
            const bool preparing=fusion is null && b.wantsFusion;
            if (!preparing && (fusion is null || fusion.GetBuildProgress()>=1 || ai.GetTeamUnit(fusion.id) is null)) continue;
            CCircuitDef@ work=ai.GetCircuitDef(UnitHelpers::GetNavalFusionNameForSide(Global::AISettings::Side));
            IUnitTask@ task=Nano(u,b,work,preparing);
            if (task !is null) { Save(i); return task; }
        }
        return null;
    }
    IUnitTask@ Place(CCircuitUnit@ u, CCircuitDef@ d, Task::BuildType kind) {
        if (d is null || !d.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(d)) return null;
        // Native converter tasks cancel below 55% storage; do not keep issuing
        // the same doomed order while energy is needed for production/fusions.
        if (kind==Task::BuildType::CONVERT && aiEconomyMgr.energy.current<aiEconomyMgr.energy.storage*.60f) return null;
        Tick();
        const string side=UnitHelpers::GetSideForUnitName(d.GetName());
        const bool reactor=d.GetName()==UnitHelpers::GetNavalFusionNameForSide(side);
        for (uint i=0;i<blocks.length();++i) {
            Block@ b=blocks[i]; if (b.zone==0) continue;
            int slot=-1;
            if (reactor) {
                if (aiTerrainMgr.GetReservationState(b.fusion)!=0) continue;
                if (!b.wantsFusion) { b.wantsFusion=true; Save(i); }
                IUnitTask@ power=Nano(u,b,d,true);
                if (power !is null) { Save(i); return power; }
                if (aiTerrainMgr.GetGroupCount(b.group,false)-aiTerrainMgr.GetGroupCount(b.group,true)<Global::RoleSettings::Sea::FusionMinimumTurrets) return null;
                slot=b.fusion;
                if (!Rear(b,d)) { Invariants::Violation("INV-137",d.GetName(),"SEA fusion footprint is forward of harbor"); return null; }
            } else {
                slot=aiTerrainMgr.NextReachableSlot(u,d,b.zone,0,8);
                // -2 preserves the cursor for a later ask; do not create new
                // packs simply because the candidate budget was exhausted.
                if (slot==-1) {
                    aiTerrainMgr.PackSet(b.zone,d,b.group,direction,b.centre,
                        d.GetName()==UnitHelpers::GetNavalEnergyConverterNameForSide(side) ? 4 : 2,false);
                    slot=aiTerrainMgr.NextReachableSlot(u,d,b.zone,0,8);
                }
            }
            if (slot<0) continue;
            if (!aiTerrainMgr.IsReservationBuildable(slot)
                || !aiTerrainMgr.CanReachAt(u,aiTerrainMgr.GetReservationPos(slot),u.circuitDef.GetBuildDistance())) continue;
            IUnitTask@ task=SeaLayout::Pinned(d,slot,kind,Task::Priority::NORMAL);
            if (task !is null) {
                b.active=true; Save(i);
                GenericHelpers::LogUtil("[SEA][EcoBlock] build="+d.GetName()+" slot="+slot+" group="+b.group,1);
                return task;
            }
        }
        Plan(); return null;
    }
}
