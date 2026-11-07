#include "../../helpers/math/economy_cluster_math.as"

// TECH policy only. One shared snapshot per second over indexed layout slots;
// target selection is O(local projects), never an owned-army scan per turret.
// Native reservation state lookups remain O(log R). See D-438 for the complete
// snapshot/ranking bound and tests/economy_cluster_math_tests.as for policy.
namespace EconomyCluster {
    class Project {
        int id=-1,kind=-1;
        AIFloat3 position;
        float progress=0.f;
        bool usable=true,usefulConversion=false;
    }
    class Cluster {
        int zone=-1;
        AIFloat3 lower,upper;
        array<int> slots,turrets;
        array<Project@> projects;
        uint projectCount=0;
        int inFlight=0;
        float remaining=0.f,committed=0.f,nanoCommitted=0.f;
    }
    array<Cluster@> clusters;
    array<CCircuitDef@> defs;
    array<float> radii;
    array<int> scratch;
    dictionary turretClusters,freeNanoClusters;
    int snapshotFrame=-SECOND,lastTick=-SECOND,batchZone=-1;
    bool updating=false,healthy=false,conversion=false;
    float commitments=0.f;
    void Clear() {
        clusters.resize(0);turretClusters.deleteAll();freeNanoClusters.deleteAll();
        snapshotFrame=-SECOND;lastTick=-SECOND;batchZone=-1;conversion=false;
    }
    bool Enabled() {
        if(Global::AISettings::Role!=AiRole::TECH
            || !Global::RoleSettings::Tech::ClusterEconomyEnabled || TechChain::NukeRush()) return false;
        Definitions();
        // Preserve explicit expensive non-economy rush steps, including their
        // unstarted orders. No per-turret full-army search to discover a frame.
        CCircuitDef@ dear=TechChain::CurrentFrameDef();
        return dear is null || Kind(dear)>=0;
    }
    void Definitions() {
        if(defs.length()>0) return;
        const string side=Global::AISettings::Side;
        defs.insertLast(ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side)));
        defs.insertLast(ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(side)));
        defs.insertLast(ai.GetCircuitDef(UnitHelpers::GetAdvFusionNameForSide(side)));
        defs.insertLast(ai.GetCircuitDef(UnitHelpers::GetFusionNameForSide(side)));
        defs.insertLast(ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(side)));
        defs.insertLast(ai.GetCircuitDef(TechChain::DefFor("nanot2"))); // optional existing extra-unit definition
        for(uint i=0;i<defs.length();++i) radii.insertLast(defs[i] is null?0.f:defs[i].GetModelRadius());
    }
    int Kind(const CCircuitDef@ def) {
        for(uint i=0;i<defs.length();++i) if(defs[i] is def) return int(i);
        return -1;
    }
    void AddZone(int zone) {
        if(zone<=0) return;
        for(uint i=0;i<clusters.length();++i) if(clusters[i].zone==zone) return;
        Cluster c;c.zone=zone;
        c.lower=aiTerrainMgr.GetZoneCorner(zone,false);c.upper=aiTerrainMgr.GetZoneCorner(zone,true);
        clusters.insertLast(c);
    }
    bool Near(CCircuitUnit@ u,Cluster@ c) {
        const AIFloat3 p=u.GetPos(ai.frame);
        const float x=AiMax(c.lower.x,AiMin(c.upper.x,p.x));
        const float z=AiMax(c.lower.z,AiMin(c.upper.z,p.z));
        const float dx=x-p.x,dz=z-p.z,r=Global::RoleSettings::Tech::ClusterWorkerRadius;
        return dx*dx+dz*dz<=r*r;
    }
    bool Protected(CCircuitUnit@ u) {
        if(u is null || u.circuitDef is null || u.GetBuildProgress()<1.f) return true;
        IUnitTask@ t=u.task;
        IBuilderTask@ build=cast<IBuilderTask>(t);
        if(build !is null && build.GetBuildType()==int(Task::BuildType::RECLAIM)
            && (build.target is null || Lifecycle::IsRetiring(build.target))) return true;
        return t !is null && (t.IsExternalControlled() || t.IsEnemyReclaim()
            || t.GetType()==int(Task::Type::PLAYER) || t.GetType()==int(Task::Type::RETREAT));
    }
    void RecordProject(Cluster@ c,CCircuitUnit@ unit,int kind,float progress,bool usefulConversion) {
        if(c.projectCount==c.projects.length()) c.projects.insertLast(Project());
        Project@ p=c.projects[c.projectCount++];
        p.id=unit.id;p.kind=kind;p.progress=progress;p.position=unit.GetPos(ai.frame);p.usable=true;
        p.usefulConversion=usefulConversion;
    }
    void Snapshot() {
        if(ai.frame<snapshotFrame+SECOND) return;
        snapshotFrame=ai.frame;
        Definitions();
        // Zone discovery is tiny and follows layout ownership; factories and
        // frontline support groups never enter this list.
        for(int i=0;i<Layout::ZoneCount();++i) AddZone(Layout::ZoneAt(i));
        AddZone(Layout::fwdZone);
        for(uint i=0;i<Layout::overflowSupportGroups.length();++i)
            AddZone(aiTerrainMgr.GetGroupZone(Layout::overflowSupportGroups[i]));
        turretClusters.deleteAll();freeNanoClusters.deleteAll();commitments=0.f;
        healthy=EconomyClusterMath::EnergyHealthy(aiEconomyMgr.isEnergyStalling,
            aiEconomyMgr.energy.current,aiEconomyMgr.energy.storage,Global::RoleSettings::Tech::ClusterMinimumEnergyShare);
        float surplus=EconomyClusterMath::Surplus(aiEconomyMgr.energy.income,
            TeamEconomy::OwnEnergy(TeamEconomy::USAGE),ai.GetTeamRulesParam("mmUse",0.f),
            ai.GetTeamRulesParam("mmCapacity",0.f),Global::RoleSettings::Tech::EcoEnergyReserve);
        conversion=EconomyClusterMath::ConversionWanted(conversion,healthy,surplus,
            Global::RoleSettings::Tech::ClusterConversionEnter,Global::RoleSettings::Tech::ClusterConversionLeave);
        for(uint ci=0;ci<clusters.length();++ci) {
            Cluster@ c=clusters[ci];c.projectCount=0;c.turrets.resize(0);c.slots.resize(0);
            c.inFlight=0;c.remaining=0.f;c.committed=0.f;c.nanoCommitted=0.f;
            for(uint k=0;k<defs.length();++k) {
                CCircuitDef@ def=defs[k];if(def is null) continue;
                aiTerrainMgr.GetScopedReservationIds(c.zone,0,def,scratch);
                for(uint si=0;si<scratch.length();++si) {
                    const int slot=scratch[si],state=aiTerrainMgr.GetReservationState(slot);
                    const bool nano=k==0 || k>=4;
                    if(state<0 || state==4) continue;
                    CCircuitUnit@ u=aiTerrainMgr.GetReservationUnit(slot);
                    const float progress=u is null?0.f:u.GetBuildProgress();
                    if(nano) {
                        if(state==0) freeNanoClusters.set(""+slot,int(ci));
                        if(state==0 && k==0) c.slots.insertLast(slot);
                        if(state!=3) c.remaining+=EconomyClusterMath::Remaining(def.costM,progress);
                        if(state==1 || state==2) {++c.inFlight;c.nanoCommitted+=EconomyClusterMath::Remaining(def.costM,progress);}
                        if(state==3 && u !is null) {c.turrets.insertLast(u.id);turretClusters.set(""+u.id,int(ci));}
                    }
                    if(state==1 || state==2) c.committed+=EconomyClusterMath::Remaining(def.costM,progress);
                    if(u !is null && progress<1.f) {
                        // Allocate surplus once, in stable cluster/slot order.
                        // Pending converters count even before they have a frame.
                        RecordProject(c,u,int(k),progress,k==1 && conversion && surplus>0.f);
                    }
                    if(k==1 && (state==1 || state==2)) surplus-=aiEconomyMgr.GetEnergyUse(def);
                }
            }
            commitments+=c.committed;
        }
    }
    int Rank(Project@ target) {
        const int kind=target.kind;
        return EconomyClusterMath::AssistRank(kind==0 || kind>=4,
            target.usefulConversion,kind==2,kind==3,healthy,
            aiEconomyMgr.metal.current,Global::RoleSettings::Tech::ClusterAssistMetalMinimum);
    }
    CCircuitUnit@ Choose(CCircuitUnit@ turret) {
        if(!Enabled() || Protected(turret)) return null;
        Snapshot();int ci=-1;
        if(!turretClusters.get(""+turret.id,ci) || ci<0 || uint(ci)>=clusters.length()) return null;
        const AIFloat3 from=turret.GetPos(ai.frame);
        IBuilderTask@ current=cast<IBuilderTask>(turret.task);
        const int currentId=current is null || current.target is null?-1:current.target.id;
        Cluster@ c=clusters[ci];
        // Static positions/progress are shared for this second. Revalidate the
        // winner live, and tombstone finished/lost projects for other turrets.
        // This avoids O(T*P) engine callbacks while retaining O(T*P) cheap ranking.
        for(uint attempt=0;attempt<=c.projectCount;++attempt) {
            Project@ best;int rank=100;float progress=-1.f;
            for(uint i=0;i<c.projectCount;++i) {
                Project@ target=c.projects[i];if(!target.usable) continue;
                const AIFloat3 to=target.position;const float dy=from.y-to.y;
                const float reach=turret.circuitDef.GetBuildDistance()+radii[target.kind];
                if(MapHelpers::SqDist(from,to)+dy*dy>reach*reach) continue;
                const int r=Rank(target);const float p=target.progress;
                // Equal-rank work stays put; otherwise finish the most advanced
                // frame first, with stable unit-ID tie-breaking.
                if(EconomyClusterMath::Prefer(r,p,target.id,currentId,rank,progress,best is null?-1:best.id)) {
                    @best=target;rank=r;progress=p;
                }
            }
            if(best is null) return null;
            CCircuitUnit@ unit=ai.GetTeamUnit(best.id);
            if(unit !is null && unit.GetBuildProgress()<1.f) return unit;
            best.usable=false;
        }
        return null;
    }
    IUnitTask@ Assist(CCircuitUnit@ u,bool factorySide) {
        CCircuitUnit@ target=Choose(u);if(target is null) return null;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if(current !is null && !current.IsDead() && current.target is target
            && current.GetBuildType()==int(Task::BuildType::REPAIR)) return u.task;
        return RoleTech::Tech_TurretRepair(target,factorySide,Task::Priority::HIGH);
    }
    bool BatchFunded(Cluster@ c) {
        return EconomyClusterMath::Funded(healthy,aiEconomyMgr.metal.current,
            Global::RoleSettings::Tech::ClusterMetalReserve,commitments-c.nanoCommitted,c.remaining);
    }
    // Ordinary dedicated-worker orders share the same cluster ceiling. Update
    // the current snapshot on admission so simultaneous asks cannot exceed it.
    bool NanoAdmission(int slot) {
        if(!Enabled() || batchZone<=0) return true;
        Snapshot();
        int ci=-1;
        if(!freeNanoClusters.get(""+slot,ci)) {
            // Coastal support can add a slot between snapshots. Refresh only
            // on this admission miss; never let a new slot bypass the cap.
            snapshotFrame=-SECOND;Snapshot();
            if(!freeNanoClusters.get(""+slot,ci)) return true;
        }
        Cluster@ c=clusters[ci];
        return c.zone!=batchZone || c.inFlight<Global::RoleSettings::Tech::ClusterTurretParallel;
    }
    void NanoAdmitted(int slot) {
        if(!Enabled()) return;
        int ci=-1;
        if(!freeNanoClusters.get(""+slot,ci)) return;
        freeNanoClusters.delete(""+slot);
        Cluster@ c=clusters[ci];++c.inFlight;
        for(uint j=0;j<c.slots.length();++j) if(c.slots[j]==slot) {c.slots.removeAt(j);break;}
    }
    IUnitTask@ BatchWork(CCircuitUnit@ u) {
        if(!Enabled() || Protected(u) || !TechGrowth::Available(u)
            || !UnitHelpers::IsAirConstructor(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef)!=1) return null;
        Snapshot();if(defs[0] is null || !u.circuitDef.CanBuild(defs[0])) return null;
        // Never steal a builder from its own queued or started construction.
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if(current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)) return null;
        for(uint i=0;i<clusters.length();++i) {
            Cluster@ c=clusters[i];
            if(batchZone>0 && c.zone!=batchZone) continue;
            if(!Near(u,c) || !BatchFunded(c) || c.slots.length()==0
                || c.inFlight>=Global::RoleSettings::Tech::ClusterTurretParallel) continue;
            const int slot=aiTerrainMgr.NextReachableSlot(u,defs[0],c.zone,0,8);
            if(!EconomyClusterMath::CanStart(c.inFlight,Global::RoleSettings::Tech::ClusterTurretParallel,
                BatchFunded(c),slot>=0)) continue;
            IUnitTask@ task=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,
                defs[0],aiTerrainMgr.GetReservationPos(slot),0.f,true,120*SECOND));
            if(task is null) return null;
            if(!AiPinReservation(task,slot)) {aiBuilderMgr.AbortTask(task);return null;}
            batchZone=c.zone;NanoAdmitted(slot);
            GenericHelpers::LogUtil("[EcoCluster] batch zone="+c.zone+" slot="+slot+" outstanding="+c.inFlight,1);
            return task;
        }
        return null;
    }
    void Tick() {
        if(!Enabled() || updating || ai.frame<lastTick+SECOND) return;
        lastTick=ai.frame;updating=true;Snapshot();
        bool keepBatch=false,canBatch=false;
        for(uint ci=0;ci<clusters.length();++ci) {
            Cluster@ c=clusters[ci];
            if(c.zone==batchZone && BatchFunded(c) && c.remaining>0.f) keepBatch=true;
            if(BatchFunded(c) && c.slots.length()>0
                && c.inFlight<Global::RoleSettings::Tech::ClusterTurretParallel) canBatch=true;
            for(uint i=0;i<c.turrets.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(c.turrets[i]);
                IUnitTask@ work=Assist(u,false);
                if(work !is null && work !is u.task) aiBuilderMgr.AssignTask(u,work);
            }
        }
        if(!keepBatch) batchZone=-1;
        if(canBatch && defs[0] !is null) {
            array<Id>@ workers=OwnedEconomy::Workers(defs[0]);
            for(uint i=0;i<workers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);IUnitTask@ work=BatchWork(u);
                if(work !is null) aiBuilderMgr.AssignTask(u,work);
            }
        }
        updating=false;
    }
}
