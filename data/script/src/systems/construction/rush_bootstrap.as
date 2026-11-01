#include "../../helpers/math/rush_bootstrap_math.as"

// One TECH rush worker lease. Site intent is not a reservation claim. All
// mutable callbacks run on the normal AI thread. No scans while travelling.
namespace RushBootstrap {
    int worker=-1, slot=-1, nextRecruit=0, nextTick=0, progressFrame=0, waypoint=0, issued=-1;
    bool requested=false;
    int diagnosticFrame=-900;
    void Diagnostic(CCircuitUnit@ u,const string& in reason) {
        if(ai.frame<diagnosticFrame+30*SECOND) return;
        diagnosticFrame=ai.frame;
        IBuilderTask@ b=u is null?null:cast<IBuilderTask>(u.task);
        GenericHelpers::LogUtil("[TECH][Bootstrap] rejected reason="+reason+" worker="+(u is null?-1:u.id)
            +" task="+(u is null || u.task is null?-1:u.task.GetType())+" build="+(b is null?-1:b.GetBuildType())
            +" box="+Layout::HasBox()+" group="+Layout::nanoGroup,1);
    }
    float bestDistance=0.f;
    int progressWaypoint=-1;
    IUnitTask@ travel;
    array<AIFloat3> route;
    array<int> candidates;
    array<float> scores;
    array<bool> idleScores;
    bool Enabled() {
        return Global::AISettings::Role==AiRole::TECH && TechChain::NukeRush()
            && Global::RoleSettings::Tech::RushBootstrapEnabled;
    }
    bool Needed() {
        if(!Enabled() || Layout::nano is null) return false;
        CCircuitDef@ def=Layout::nano;
        const int unfinished=aiBuilderMgr.GetUnfinishedCount(def);
        return RushBootstrapMath::Needed(def.count-unfinished,
            aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::NANO),def),unfinished,
            Global::RoleSettings::Tech::NukeRushTurrets);
    }
    bool Eligible(CCircuitUnit@ u) {
        if(!TechGrowth::Available(u) || UnitHelpers::GetConstructorTier(u.circuitDef)!=1
            || Layout::nano is null || !u.circuitDef.CanBuild(Layout::nano)) return false;
        IUnitTask@ task=u.task;
        if(task is null || task is travel) return true;
        // Even an unframed build, mex upgrade, or reclaim is committed work.
        IBuilderTask@ build=cast<IBuilderTask>(task);
        if(build !is null && build.GetBuildType()!=int(Task::BuildType::REPAIR)
            && build.GetBuildType()!=int(Task::BuildType::GUARD)
            && build.GetBuildType()!=int(Task::BuildType::WAIT)) return false;
        return task.GetType()==int(Task::Type::IDLE) || task.GetType()==int(Task::Type::WAIT) || build !is null;
    }
    AIFloat3 Anchor() {
        if(Layout::spineFusionSlot>=0) return aiTerrainMgr.GetReservationPos(Layout::spineFusionSlot);
        return Layout::TurretSeed();
    }
    int FindSite(CCircuitUnit@ u) {
        int result=Layout::nanoGroup>0?aiTerrainMgr.NextSupportSlot(u,Layout::nano,Layout::nanoGroup,Anchor(),8):-1;
        if(CompactEco::Active()) for(uint i=0;result<0 && i<CompactEco::groups.length();++i)
            result=aiTerrainMgr.NextSupportSlot(u,Layout::nano,CompactEco::groups[i],Anchor(),8);
        return result;
    }
    bool SafeSegment(const AIFloat3& in from,const AIFloat3& in to,bool air=false) {
        if(air) return aiBattle.AirThreatAlong(from,to,64.f)<=Global::RoleSettings::Tech::RushBootstrapMaxThreat;
        const int count=AiMax(1,int(ceil(from.distance2D(to)/32.f)));
        for(int i=0;i<=count;++i) {
            const float t=float(i)/float(count);
            const AIFloat3 p(from.x+(to.x-from.x)*t,0,from.z+(to.z-from.z)*t);
            if(aiBattle.SurfThreat(p)>Global::RoleSettings::Tech::RushBootstrapMaxThreat) return false;
        }
        return true;
    }
    bool PlanRoute(CCircuitUnit@ u,const AIFloat3& in destination) {
        const bool air=UnitHelpers::IsAirConstructor(u.circuitDef);
        array<AIFloat3>@ path;
        // Air constructors need no terrain solve. Refuse a threatened direct
        // corridor; the next bounded recruitment can select another worker.
        if(air) { @path=array<AIFloat3>();path.insertLast(destination); }
        else @path=aiBattle.GetUnitTerrainRoute(u.circuitDef,u.GetPos(ai.frame),destination,
            true,1.f,1.f,10000.f,0.f,u.circuitDef.GetBuildDistance());
        if(path.length()==0) return false;
        AIFloat3 previous=u.GetPos(ai.frame);
        for(uint i=0;i<path.length();++i) {
            if(!SafeSegment(previous,path[i],air)) return false;
            previous=path[i];
        }
        route=path;waypoint=0;issued=-1;
        return true;
    }
    void Clear(bool stop=true) {
        CCircuitUnit@ u=ai.GetTeamUnit(worker);
        // Never stop a replacement owner or the building task after handover.
        if(stop && u !is null && u.task is travel && travel !is null && !travel.IsDead()) {
            u.CmdStop();
            aiBuilderMgr.AssignTask(u,aiBuilderMgr.Enqueue(TaskB::Wait(SECOND)));
        }
        worker=-1;slot=-1;@travel=null;route.resize(0);requested=false;
    }
    IUnitTask@ TravelTask(CCircuitUnit@ u) {
        if(u is null || u.id!=worker || !Eligible(u)) return null;
        if(!Needed()) {Clear();return null;}
        return travel !is null && !travel.IsDead() && u.task is travel ? travel : null;
    }
    IUnitTask@ Work(CCircuitUnit@ u) {
        if(!Enabled()) return Layout::NanoTask(u,Task::Priority::HIGH,2);
        if(!Eligible(u)) {Diagnostic(u,"worker");return null;}
        if(CompactEco::Active() && CompactEco::LocalWorker(u.GetPos(ai.frame),Global::RoleSettings::Tech::RushBootstrapLocalRadius))
            return Layout::NanoTask(u,Task::Priority::HIGH,2);
        const int site=FindSite(u);
        if(site<0) {Diagnostic(u,"site");return null;}
        const AIFloat3 position=aiTerrainMgr.GetReservationPos(site);
        const float radius=Global::RoleSettings::Tech::RushBootstrapLocalRadius;
        if(MapHelpers::SqDist(u.GetPos(ai.frame),position)<=radius*radius) {
            IUnitTask@ task=Layout::NanoTask(u,Task::Priority::HIGH,2,site);
            if(task !is null) {Clear(u.id!=worker);return task;}
        }
        if(Needed()) requested=true;
        return TravelTask(u);
    }
    void RankWorkers() {
        candidates.resize(0);scores.resize(0);idleScores.resize(0);
        const AIFloat3 anchor=Anchor();
        array<Id>@ ids=OwnedEconomy::Workers(Layout::nano);
        // O(B) candidate scan only on recruitment; keep best four without
        // sorting/allocating the owned army. At most four bounded site/routes.
        for(uint i=0;i<ids.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);if(!Eligible(u)) continue;
            const float score=MapHelpers::SqDist(u.GetPos(ai.frame),anchor);
            const bool idle=u.task is null || u.task.GetType()==int(Task::Type::IDLE) || u.task.GetType()==int(Task::Type::WAIT);
            uint at=0;while(at<scores.length() && !RushBootstrapMath::Prefer(score,idle,scores[at],idleScores[at],
                Global::RoleSettings::Tech::RushBootstrapLocalRadius)) ++at;
            if(at>=4) continue;
            candidates.insertAt(at,u.id);scores.insertAt(at,score);idleScores.insertAt(at,idle);
            if(candidates.length()>4) {candidates.resize(4);scores.resize(4);idleScores.resize(4);}
        }
    }
    void Recruit() {
        nextRecruit=ai.frame+Global::RoleSettings::Tech::RushBootstrapRetrySeconds*SECOND;
        RankWorkers();
        for(uint i=0;i<candidates.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(candidates[i]);
            const int site=FindSite(u);if(site<0) continue;
            const AIFloat3 position=aiTerrainMgr.GetReservationPos(site);
            if(!PlanRoute(u,position)) continue;
            worker=u.id;slot=site;progressFrame=ai.frame;
            bestDistance=u.GetPos(ai.frame).distance2D(position);progressWaypoint=-1;
            @travel=aiBuilderMgr.Enqueue(TaskB::Wait(300*SECOND));
            aiBuilderMgr.AssignTask(u,travel);
            GenericHelpers::LogUtil("[TECH][Bootstrap] recruit worker="+worker+" slot="+slot+" distance="+int(bestDistance),1);
            return;
        }
    }
    void Tick() {
        if(ai.frame<nextTick) return;
        nextTick=ai.frame+SECOND;
        if(!Needed()) {if(worker>=0) Clear();requested=false;return;}
        if(worker<0) {if(requested && ai.frame>=nextRecruit) Recruit();return;}
        CCircuitUnit@ u=ai.GetTeamUnit(worker);
        if(!Eligible(u) || travel is null || travel.IsDead() || u.task !is travel) {Clear(false);return;}
        if(aiTerrainMgr.GetReservationState(slot)!=0 || !aiTerrainMgr.IsReservationBuildable(slot)) {Clear();return;}
        const AIFloat3 position=aiTerrainMgr.GetReservationPos(slot);
        const AIFloat3 here=u.GetPos(ai.frame);
        const float distance=here.distance2D(position);
        if(RushBootstrapMath::Stalled(ai.frame,progressFrame,Global::RoleSettings::Tech::RushBootstrapStallSeconds*SECOND)) {
            GenericHelpers::LogUtil("[TECH][Bootstrap] recover worker="+worker+" reason=no-progress",1);Clear();return;
        }
        // The native task owns the final approach. Keep completed-support and
        // parallel-project admission intact, and claim only after arrival.
        if(distance<=u.circuitDef.GetBuildDistance()+64.f) {
            IUnitTask@ task=Layout::NanoTask(u,Task::Priority::HIGH,2,slot);
            if(task !is null) {
                GenericHelpers::LogUtil("[TECH][Bootstrap] build worker="+worker+" slot="+slot,1);
                Clear(false);aiBuilderMgr.AssignTask(u,task);
            }
            return;
        }
        while(waypoint<int(route.length()) && here.distance2D(route[waypoint])<=64.f) ++waypoint;
        if(waypoint>=int(route.length())) {Clear();return;}
        const float legDistance=here.distance2D(route[waypoint]);
        if(progressWaypoint!=waypoint || legDistance+16.f<bestDistance) {
            progressWaypoint=waypoint;bestDistance=legDistance;progressFrame=ai.frame;
        }
        if(!SafeSegment(here,route[waypoint],UnitHelpers::IsAirConstructor(u.circuitDef))) {Clear();return;}
        if(issued!=waypoint) {u.CmdMoveTo(route[waypoint]);issued=waypoint;}
    }
}
