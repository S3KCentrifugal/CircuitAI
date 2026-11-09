#include "task/builder/CommanderGroupFollowTask.h"
#include "task/builder/BraceTask.h"
#include "control/core/ControlledTask.h"
#include "control/core/Ownership.h"
#include "control/kernel/CommanderGroupWork.h"
#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "map/ThreatMap.h"
#include "map/MapManager.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "unit/ally/AllyTeam.h"
#include "spring/SpringCallback.h"
#include "spring/SpringUnit.h"
#include "spring/SpringMap.h"
#include "task/common/WaitTask.h"
#include "task/common/RepairTask.h"
#include "task/builder/RepairTask.h"
#include "setup/SetupManager.h"
#include "resource/EnergyManager.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdlib>
#include <limits>

namespace circuit {
using springai::AIFloat3;
using BT=IBuilderTask::BuildType;
// D-480: spots tried per seat ask before it falls through to group work.
constexpr int MAX_SEAT_MEX_ATTEMPTS=3;
// D-485: seconds the seat sweep waits after a search that found nothing.
constexpr int SEAT_MEX_IDLE_SECONDS=5;
// D-481: times a cancelled guard item is ordered again.
constexpr int GEO_GUARD_RETRIES=1;
// D-484: a finished geo within this of a swapped vent is that vent's (elmos).
constexpr float FRONT_GEO_SITE_RADIUS=64.f;


bool CCommanderController::IsGroupMember(int id) const {
    return id>=0 && (id==groupUnit || std::find(groupMembers.begin(),groupMembers.end(),id)!=groupMembers.end());
}
int CCommanderController::FrontCommanderId() const {
    for(const auto& entry:states) {
        auto* unit=ai->GetTeamUnit(entry.id);
        if(unit && unit->IsFinished() && !ActualDecoy(unit->GetCircuitDef())) return entry.id;
    }
    return -1;
}
CCircuitUnit* CCommanderController::GroupCommander() const {
    if(!role.frontDuty && supportAnchor>=0) return ai->GetTeamUnit(supportAnchor);
    if(!role.frontDuty || !role.frontReady) return nullptr;
    for(const auto& entry:states) {
        auto* unit=ai->GetTeamUnit(entry.id);
        if(unit && unit->IsFinished() && !ActualDecoy(unit->GetCircuitDef())) return unit;
    }
    // D-476: with no commander the anchor is a group builder, kept while it
    // stands. Played (Clyde, 2026-11-06): the old seat order (decoy, T2 seats,
    // constructor, radar, jammer) re-picked on every death and change, 184-257
    // anchor switches a game, some onto a radar, jammer or decoy that cannot
    // build. Five fixed seats, no scan.
    const auto usable=[this](int id) -> CCircuitUnit* {
        auto* unit=id>=0?ai->GetTeamUnit(id):nullptr;
        return (unit && unit->IsFinished() && !unit->IsDead() && unit->GetCircuitDef()->IsBuilder())?unit:nullptr;
    };
    if(IsGroupMember(groupAnchorId)) if(auto* kept=usable(groupAnchorId)) return kept;
    for(int id:{groupMembers[0],groupMembers[1],groupMembers[2],groupUnit,groupMembers[5]})
        if(auto* unit=usable(id)) return unit;
    return nullptr;
}
bool CCommanderController::GroupCanBuild(CCircuitDef* def,CCircuitUnit* anchor) const {
    if(!def || !anchor || !def->IsAvailable(ai->GetLastFrame())) return false;
    // Three stable T2 seats, no army census or capability cache to invalidate.
    for(unsigned i=0;i<3;++i) {
        auto* worker=ai->GetTeamUnit(groupMembers[i]);
        if(worker && worker->IsFinished() && worker->GetCircuitDef()->CanBuild(def)
            && worker->GetPos(ai->GetLastFrame()).SqDistance2D(anchor->GetPos(ai->GetLastFrame()))<=SQUARE(cfg->group.radius)
            && control::SuspensionOf(worker,ai->GetLastFrame())==control::Suspension::NONE
            && worker->GetTask()->GetType()!=IUnitTask::Type::RETREAT
            && !HealthRetreat(worker) && !EnergyRetreat(worker)) return true;
    }
    return false;
}
bool CCommanderController::GroupCanFund(CCircuitDef* def) const {
    if(!def) return false;
    auto* eco=ai->GetEconomyManager();
    return !eco->IsEnergyStalling() && commander::GroupBudget(
        eco->GetAvgMetalIncome(),eco->GetAvgEnergyIncome(),cfg->group.defenceMetal,cfg->group.defenceEnergy,
        eco->GetMetalCur(),eco->GetEnergyCur(),eco->GetMetalPullCor(),eco->GetEnergyPullCor(),
        def->GetCostM(),def->GetCostE(),cfg->group.budgetSeconds,cfg->group.budgetFraction);
}
IUnitTask* CCommanderController::GroupUpgradeMex(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(cfg->group.mexUpgrade<=0 || std::find(groupMembers.begin(),groupMembers.begin()+3,unit->GetId())==groupMembers.begin()+3
        || ai->GetEconomyManager()->IsEnergyStalling()) return nullptr;
    const int frame=ai->GetLastFrame();
    if(frame<groupUpgradeNext) return nullptr;
    groupUpgradeNext=frame+FRAMES_PER_SEC;
    // A local extractor may already be reserved by the economy worker. Join
    // that upgrade when it can use more build power, rather than duplicate its
    // claim or sit idle behind the shared MEXUP limit (normally two tasks).
    for(auto* task:ai->GetBuilderManager()->GetTasks(BT::MEXUP)) {
        if(GroupProjectAllowed(unit,task) && task->CanAssignTo(unit)) {
            ai->LOG("[CommanderGroup] mex_upgrade unit=%i queued=1",unit->GetId());
            return TrackGroupJob(task,false);
        }
    }
    // One local query per group/second, copied across task callbacks. Only own
    // completed extractors; ordinary MEXUP tasks retain their claim lifecycle.
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(anchor->GetPos(frame),cfg->group.radius,false);
    unsigned mexes=0,eligible=0;
    for(int id:ids) {
        auto* target=ai->GetTeamUnit(id);
        if(!target || !target->IsFinished() || target->GetCircuitDef()->GetExtractsM()<=0) continue;
        ++mexes;
        const auto at=target->GetPos(frame);
        if(!GroupSiteAllowed(unit,at) || !ai->GetBattle()->LaneWorkAllowed(at)
            || ai->GetThreatMap()->GetThreatAt(unit,at)>cfg->front.threat) continue;
        ++eligible;
        auto* task=ai->GetEconomyManager()->EnqueueMexUpgrade(unit,target);
        if(!task) continue;
        if(task->CanAssignTo(unit) && GroupProjectAllowed(unit,task)) {
            ai->LOG("[CommanderGroup] mex_upgrade unit=%i target=%i",unit->GetId(),id);
            return TrackGroupJob(task,false);
        }
        ai->GetBuilderManager()->DiscardUnusedTask(task);
    }
    if(std::getenv("CIRCUIT_COMMANDER_TRACE") && frame%(5*FRAMES_PER_SEC)<FRAMES_PER_SEC)
        ai->LOG("[CommanderGroup] upgrade_scan unit=%i mexes=%u eligible=%u queued=%u",unit->GetId(),mexes,eligible,
            unsigned(ai->GetBuilderManager()->GetTasks(BT::MEXUP).size()));
    return nullptr;
}
bool CCommanderController::GroupActive(CCircuitUnit* commander) {
    if(!commander || commander!=GroupCommander()) return false;
    const auto pos=commander->GetPos(ai->GetLastFrame());
    for(int id:{groupUnit,groupMembers[0],groupMembers[1],groupMembers[2]}) {
        auto* unit=ai->GetTeamUnit(id);
        if(unit && unit->IsFinished() && unit->GetPos(ai->GetLastFrame()).SqDistance2D(pos)<=SQUARE(cfg->group.radius)) {
            groupArrived=true;return true;
        }
    }
    return false;
}
bool CCommanderController::GroupNearCombat(CCircuitUnit* anchor) {
    return anchor && ai->GetBattle()->LaneCombatDistance(anchor->GetPos(ai->GetLastFrame()),cfg->group.combatMemory)<=cfg->group.combatDistance;
}
bool CCommanderController::GroupTaskFunded(IUnitTask* task) const {
    if(ai->GetEconomyManager()->GetAvgMetalIncome()>=cfg->group.jammerIncome) return true;
    auto* build=dynamic_cast<IBuilderTask*>(task);
    auto* def=build?build->GetBuildDef():nullptr;
    if(!def) if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
        auto* target=ai->GetTeamUnit(repair->GetTargetId());
        if(target) def=target->GetCircuitDef();
    }
    return !def || (def->GetId()!=groupJammer && def->GetId()!=groupJammer2);
}
bool CCommanderController::CanResumeFrontTask(CCircuitUnit* unit,IUnitTask* task) const {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1)); // D-388: this unit's preset
    if(!GroupTaskFunded(task)) return false;
    if(!role.frontDuty || !role.frontReady || cfg->front.persistent<=0) return true;
    if(HealthRetreat(unit) || EnergyRetreat(unit)) return false;
    if(auto* repair=dynamic_cast<CBRepairTask*>(task); repair && repair->IsStationaryCommander(unit)) {
        auto* target=ai->GetFriendlyUnit(repair->GetTargetId());
        return target && target->GetPos(ai->GetLastFrame()).SqDistance(unit->GetPos(ai->GetLastFrame()))
            <=SQUARE(unit->GetCircuitDef()->GetBuildDistance());
    }
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build) return false; // never restore a roaming guard/patrol/base queue
    auto at=build->GetPosition();
    // The local selector owns this short-lived task. Keep its in-reach work
    // through discretionary deployment; generic base reclaim is not adopted.
    // Threat/recovery still preempt it before this retention check.
    if(build->GetBuildType()==IBuilderTask::BuildType::RECLAIM && build->recoveryControlled) {
        const auto* state=states.Find(unit->GetId());
        const float reach=unit->GetCircuitDef()->GetBuildDistance();
        return state && state->work.task==task && state->work.kind==WORK_RECLAIM
            && at.SqDistance2D(unit->GetPos(ai->GetLastFrame()))<=reach*reach
            && ai->GetBattle()->LaneWorkAllowed(at)
            && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat;
    }
    auto* definition=build->GetBuildDef();
    if(!definition) {
        // Only the selected worker's unfinished support frame may invite the
        // commander into a repair task. Generic base repairs stay excluded.
        // D-476: any expansion job a worker is on (formerly the one group job).
        const bool groupProject=IsExpansionJob(task) && !task->GetAssignees().empty();
        auto* repair=dynamic_cast<IRepairTask*>(build);
        auto* target=repair?ai->GetTeamUnit(repair->GetTargetId()):nullptr;
        if(!groupProject || !target || target->IsFinished()) return false;
        definition=target->GetCircuitDef();at=target->GetPos(ai->GetLastFrame());
        const int id=definition->GetId();
        if(!IsGroupStructure(id)) return false;

    }

    if(build->GetBuildType()==IBuilderTask::BuildType::MEX)
        return LaneMexSiteAllowed(unit,at);
    const auto pos=unit->GetPos(ai->GetLastFrame());
    const auto* battle=ai->GetBattle();
    const float sight=unit->GetCircuitDef()->GetLosRadius();
    if(at.SqDistance2D(pos)>sight*sight) return false;
    // Emergency energy is intentionally local to the commander, including
    // before a corridor exists; it must not need a lane/base-layout detour.
    if(definition->GetId()==int(cfg->front.solarDef))
        return at.SqDistance2D(pos)<=SQUARE(cfg->front.solarRadius);
    if(!GroupBuildSiteAllowed(unit,definition,at)) return false;
    const bool groupProject=IsExpansionJob(task) && !task->GetAssignees().empty();
    const int defId=definition->GetId();
    // GroupSiteAllowed already confines assistance to the assigned territory.
    // Do not apply a centre-strip restriction: lateral defenses are intentional
    // and the commander works from build range, not from the structure's site.
    // Bound rearward travel while allowing that build reach at the boundary.
    if(groupProject && IsGroupStructure(defId))
        return at.SqDistance2D(pos)<=SQUARE(unit->GetCircuitDef()->GetBuildDistance())
            || battle->GetFrontLaneProgress(at)>=battle->GetFrontLaneProgress(pos)
                -cfg->front.workBehind-unit->GetCircuitDef()->GetBuildDistance();
    return battle->GetFrontLaneLength()>0
        && battle->GetFrontLaneDistance(at)<=battle->GetFrontLaneWidth()+unit->GetCircuitDef()->GetBuildDistance()
        && battle->GetFrontLaneProgress(at)>=battle->GetFrontLaneProgress(pos)-cfg->front.workBehind;
}


bool CCommanderController::GroupSiteAllowed(CCircuitUnit* unit,const AIFloat3& site) const {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    if(!unit || !role.frontDuty || !role.frontReady || cfg->front.persistent<=0
        || (!IsGroupMember(unit->GetId()) && !Handles(unit))) return true;
    const auto* battle=ai->GetBattle();
    if(battle->GetFrontLaneLength()<=0) return false;
    const int corridor=int(cfg->front.corridor),cls=int(cfg->front.corridorClass);
    if(corridor>=0 && cls>=0) return battle->CorridorAtPoint(cls,site)==corridor;
    return battle->GetFrontLaneDistance(site)<=battle->GetFrontLaneWidth()
        +(cfg->front.laneMargin>0?cfg->front.laneMargin:unit->GetCircuitDef()->GetBuildDistance());
}
// An expansion mex may be on the lane's start connector, outside the group's
// narrower territory polygon. LLTs, their nano support and (D-470) the group
// defence planner's rule structures inherit that local capture window, so a
// planned defence can go where the commander stands; factories/radars/other
// group work keep their boundary. Geometry only, no engine collection query;
// the rule lookup is MAX_RULES integer compares. Income gates offers, not retention.
bool CCommanderController::GroupBuildSiteAllowed(CCircuitUnit* unit,const CCircuitDef* def,const AIFloat3& site) const {
    // Engineering's anchor must not constrain TECH's unrelated home builders.
    // Fixed-size membership lookup; commander_group_work_test covers ownership.
    if(commander::SupportBoundaryApplies(role.frontDuty,supportAnchor>=0,
        unit && IsGroupMember(unit->GetId()))) {
        auto* anchor=ai->GetTeamUnit(supportAnchor);
        return anchor && site.SqDistance2D(anchor->GetPos(ai->GetLastFrame()))<=SQUARE(cfg->group.radius);
    }
    if(GroupSiteAllowed(unit,site)) return true;
    // D-475: a launcher on the tactical block (reserved behind the commander,
    // which may be outside the lane polygon) is the group's own plan.
    if(OnTacticalBlock(def,site)) return true;
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    if(!unit || !def || cfg->front.mexMinIncome<=0) return false;
    // D-470: every planned defence was refused when the commander stood
    // outside its corridor polygon; only the LLT (line turret) could go down.
    const bool planned=defenseSettings.enabled>0 && std::any_of(defenseRules.begin(),defenseRules.end(),
        [&](const defense::Rule& r){ return r.def==def->GetId() && r.priority>0; });
    if(def->GetId()!=int(cfg->front.lineDef) && def->GetId()!=groupNano && !planned) return false;
    auto* anchor=Handles(unit)?unit:GroupCommander();
    return anchor && LaneMexSiteAllowed(anchor,site);
}

bool CCommanderController::GroupMayBuild(CCircuitUnit* unit,CCircuitDef* def,const AIFloat3& site) const {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    if(!GroupBuildSiteAllowed(unit,def,site) || HealthRetreat(unit) || EnergyRetreat(unit)) return false;
    if(!IsGroupMember(unit->GetId())) return true;
    auto* anchor=GroupCommander();
    return anchor && def && commander::GroupJobInRange(site.SqDistance2D(anchor->GetPos(ai->GetLastFrame())),
        cfg->group.radius+(IsTacticalDef(def)?TacticalBlockRadius(def):0.f),unit->GetCircuitDef()->GetBuildDistance(),
        IsExpansionJob(unit->GetTask()) || (tacticalJob && unit->GetTask()==tacticalJob));
}
int CCommanderController::ExpansionCap() const {
    return std::clamp(int(cfg->group.expansionJobs),1,MAX_EXPANSION_JOBS);
}
int CCommanderController::ExpansionJobCount() const {
    return int(std::count_if(expansionJobs.begin(),expansionJobs.end(),[](const ExpansionJob& j){return j.task!=nullptr;}));
}
int CCommanderController::NanoJobCount() const {
    return int(std::count_if(expansionJobs.begin(),expansionJobs.end(),[](const ExpansionJob& j){return j.task && j.nano;}));
}
bool CCommanderController::IsExpansionJob(const IUnitTask* task) const {
    return task && std::any_of(expansionJobs.begin(),expansionJobs.end(),[task](const ExpansionJob& j){return j.task==task;});
}
IUnitTask* CCommanderController::FirstExpansionJob() const {
    for(const auto& job:expansionJobs) if(job.task) return job.task;
    return nullptr;
}
// D-476: a constructor with no job of its own helps one with room for it.
IUnitTask* CCommanderController::JoinExpansionJob(CCircuitUnit* unit,bool nearby) {
    if(!nearby) return nullptr;
    for(const auto& job:expansionJobs)
        if(job.task && !job.task->IsDead() && GroupProjectAllowed(unit,job.task) && job.task->CanAssignTo(unit)) return job.task;
    return nullptr;
}
IUnitTask* CCommanderController::TrackGroupJob(IUnitTask* task,bool earnsNano) {
    // D-476: a job already in the queue (a second worker found the same task)
    // is not tracked twice; with no free slot the task runs untracked.
    if(task && !IsExpansionJob(task)) {
        ExpansionJob* slot=nullptr;
        for(auto& job:expansionJobs) if(!job.task) {slot=&job;break;}
        if(!slot) { ai->LOG("[CommanderGroup] job_untracked team=%i jobs=%i",ai->GetTeamId(),ExpansionJobCount()); return task; }
        slot->task=task;slot->earnsNano=earnsNano;
        slot->until=ai->GetLastFrame()+int(cfg->group.projectHoldSeconds*FRAMES_PER_SEC);
        auto* build=dynamic_cast<IBuilderTask*>(task);
        auto* def=build?build->GetBuildDef():nullptr;
        if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
            auto* target=ai->GetTeamUnit(repair->GetTargetId());
            if(target) def=target->GetCircuitDef();
        }
        slot->nano=def && def->GetId()==groupNano;
        ai->LOG("[CommanderGroup] job_start def=%s nano=%i team=%i jobs=%i",def?def->GetDef()->GetName():"unknown",int(slot->nano),
            ai->GetTeamId(),ExpansionJobCount());
    }
    return task;
}
void CCommanderController::TaskFinished(IUnitTask* task,bool done) {
    // Every completed/cancelled builder task, not just groupJob, can be the
    // remembered solar/repair/hold job. Clear before task memory is released.
    // O(C) in controlled commanders/decoys at retirement, no per-frame scan.
    for(auto& entry:states) { entry.value->work.Retire(task); entry.value->work.RetireOrigin(task); }  // D-493
    // D-481: a guard item ends; a cancelled one is ordered again (GEO_GUARD_RETRIES).
    for(auto& g:geoGuards) for(std::size_t k=0;k<g.tasks.size();++k) if(g.tasks[k]==task) {
        g.tasks[k]=nullptr; g.state[k]=done?2:0;
        if(!done && ++g.retries[k]>GEO_GUARD_RETRIES) g.state[k]=2;
    }
    // D-484: a Cerberus finished by any of our GEO tasks on the front line is
    // guarded too (played, commander-group-geo b35: the swap built it and no
    // guard followed); the group's own job is handled below.
    // The vent was front line when the swap ordered it; the commander may have
    // walked on since, so the recorded site decides, not the current window.
    // D-488: and any guard geo finished on a forward vent (ForwardGeo's own orders).
    if(done && task!=geoJob && role.frontDuty) if(auto* geoBuild=dynamic_cast<IBuilderTask*>(task);
        geoBuild && geoBuild->GetBuildType()==BT::GEO && geoBuild->GetBuildDef()) {
        const AIFloat3 at=geoBuild->GetBuildPos();
        const auto site=std::find_if(frontGeoSites.begin(),frontGeoSites.end(),
            [&at](const FrontGeoSite& p){return p.pos.SqDistance2D(at)<SQUARE(FRONT_GEO_SITE_RADIUS);});
        const bool forward=ai->GetEconomyManager()->IsGeoForward(ai->GetEconomyManager()->GeoSpotAt(at));
        if(site!=frontGeoSites.end()) frontGeoSites.erase(site);
        if(site!=frontGeoSites.end() || forward) PlanGeoGuard(geoBuild->GetBuildDef(),at);
    }
    // D-484: a swapped order that ended unbuilt counts against its vent.
    if(!done && task!=geoJob) if(auto* geoBuild=dynamic_cast<IBuilderTask*>(task); geoBuild && geoBuild->GetBuildType()==BT::GEO) {
        const AIFloat3 at=geoBuild->GetBuildPos();
        for(auto& site:frontGeoSites) if(site.pos.SqDistance2D(at)<SQUARE(FRONT_GEO_SITE_RADIUS)) {
            if(++site.fails==FRONT_GEO_FAILS)
                ai->LOG("[CommanderGroup] geo_front_keep x=%.0f z=%.0f reason=unbuilt fails=%i",site.pos.x,site.pos.z,site.fails);
            break;
        }
    }
    if(task==geoJob) {  // D-481
        geoJob=nullptr;
        auto* build=dynamic_cast<IBuilderTask*>(task);
        auto* def=build?build->GetBuildDef():nullptr;
        ai->LOG("[CommanderGroup] job_end queue=geo done=%i team=%i def=%s",int(done),ai->GetTeamId(),def?def->GetDef()->GetName():"none");
        if(done && def) PlanGeoGuard(def,build->GetBuildPos());
        return;
    }
    if(task==tacticalJob) {  // D-475: the tactical queue's slot is free again
        tacticalJob=nullptr;
        if(task==t1Job) t1Job=nullptr;  // D-495
        const auto* build=dynamic_cast<IBuilderTask*>(task);
        const auto* def=build?build->GetBuildDef():nullptr;
        ai->LOG("[CommanderGroup] job_end queue=tactical done=%i team=%i def=%s",int(done),ai->GetTeamId(),
            def?def->GetDef()->GetName():"repair");
        return;
    }
    ExpansionJob* slot=nullptr;
    for(auto& job:expansionJobs) if(job.task==task) {slot=&job;break;}
    if(!slot) return;
    const ExpansionJob finished=*slot;
    *slot=ExpansionJob{}; // manager still owns task during this callback
    defenseNext=defenseOfferNext=defenseDecisionNext=0;
    const auto* finishedBuild=dynamic_cast<IBuilderTask*>(task);
    const auto* finishedDef=finishedBuild?finishedBuild->GetBuildDef():nullptr;
    ai->LOG("[CommanderGroup] job_end done=%i nano=%i team=%i def=%s",int(done),int(finished.nano),
        ai->GetTeamId(),finishedDef?finishedDef->GetDef()->GetName():"repair");
    if(done) if(auto* upgrade=dynamic_cast<IBuilderTask*>(task);upgrade && upgrade->GetBuildType()==BT::MEXUP
        && upgrade->GetTarget() && upgrade->GetTarget()->IsFinished())
        ai->LOG("[CommanderGroup] mex_upgrade_done target=%i",upgrade->GetTarget()->GetId());
    if(!done || !finished.earnsNano) return; // repairs/adoption and cancellations create no nano debt
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build) return;
    if(finished.nano) {
        if(groupNanoOwed>0) --groupNanoOwed;
        groupNanoDue=groupNanoOwed>0;return;
    }
    // D-483 (the owner's rule): one construction turret per T1 defence and four,
    // packed around it, per T2 defence; other group jobs (radar, jammer, mex
    // upgrade) owe none in the balanced profile. The nano site search starts at
    // the defence, so the four land beside it. One custom-parameter read per
    // finished job.
    const auto* def=build->GetBuildDef();
    unsigned owed=unsigned(std::max(0.f,cfg->group.nanoOther));
    // Radars and jammers (some are DEFENCE builds) are not porc.
    const bool sensor=def && (def->GetId()==groupRadar || def->GetId()==groupRadar2
        || def->GetId()==groupJammer || def->GetId()==groupJammer2 || def->IsRadar() || def->GetDef()->GetJammerRadius()>0);
    if(def && !sensor && (build->GetBuildType()==BT::DEFENCE || build->GetBuildType()==BT::BUNKER)) {
        owed=unsigned(std::max(0.f,DefTier(def)>=2?cfg->group.nanoT2:cfg->group.nanoT1));
    }
    const auto at=build->GetPosition();
    if(owed>0 && OnMap(at)) {
        groupNanoSite=at;groupNanoOwed+=owed;groupNanoDue=true;
        ai->LOG("[CommanderGroup] nano_owed def=%s owed=%u total=%u",def?def->GetDef()->GetName():"none",owed,groupNanoOwed);
    }
}
IUnitTask* CCommanderController::GroupBuild(CCircuitUnit* unit,CCircuitDef* def,const AIFloat3& site,bool nano,int defenseSlot,bool surplus) {
    if(!def || !unit->GetCircuitDef()->CanBuild(def)) return nullptr;
    if((def->GetId()==groupJammer || def->GetId()==groupJammer2)
        && ai->GetEconomyManager()->GetAvgMetalIncome()<cfg->group.jammerIncome) return nullptr;
    auto* anchor=GroupCommander();
    if(!anchor) return nullptr;
    auto* builder=ai->GetBuilderManager();
    const int frame=ai->GetLastFrame();
    const BT type=nano?BT::NANO:(def->GetId()==groupRadar || def->GetId()==groupRadar2)?BT::RADAR:BT::DEFENCE;
    for(auto* task:builder->GetTasks(type)) {
        if(task->GetBuildDef()==def && !task->IsDead() && !task->IsExternalControlled()
            && task->GetPosition().SqDistance2D(site)<=SQUARE(160.f)
            && GroupMayBuild(unit,def,task->GetPosition()) && task->CanAssignTo(unit)) return task;
    }
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(site,160.f,false);
    for(int id:ids) {
        auto* target=ai->GetTeamUnit(id);
        if(!target || target->GetCircuitDef()!=def || !GroupMayBuild(unit,def,target->GetPos(frame))) continue;
        if(!target->IsFinished()) return builder->EnqueueRepairFor(target,60*FRAMES_PER_SEC,unit);
        if(!nano) return nullptr; // each completed defense earns its own new nano
    }
    const auto center=anchor->GetPos(frame);
    const bool jammer=def->GetId()==groupJammer || def->GetId()==groupJammer2;
    const auto coverage=GroupJammerCoverage(unit,def,site,jammer?cfg->group.radius:160.f);
    // Trace only: the first failing site gate per candidate cell, so a
    // planner `placement` skip names its cause. No cost without the variable.
    static const bool traceSites=std::getenv("CIRCUIT_COMMANDER_TRACE")!=nullptr;
    std::array<int,6> rejected{};
    CTerrainManager::TerrainPredicate admit=[&](const AIFloat3& p) {
        int gate=0;
        const bool ok=(++gate,coverage.Allows({p.x,p.z}))
            && (++gate,GroupBuildSiteAllowed(unit,def,p)) && (++gate,GroupLaneWorkAllowed(unit,def,p))
            && (++gate,p.SqDistance2D(center)<=SQUARE(cfg->group.radius))
            && (++gate,ai->GetThreatMap()->GetThreatAt(unit,p)<=cfg->front.threat)
            && (++gate,ai->GetTerrainManager()->CanReachAtSafe2(unit,p,unit->GetCircuitDef()->GetBuildDistance()));
        if(!ok && traceSites) ++rejected[gate-1];
        return ok;
    };
    const auto traceReject=[&](const char* why) -> IUnitTask* {
        if(traceSites && defenseSlot>=0)
            ai->LOG("[CommanderGroup] site_reject unit=%i def=%s why=%s coverage=%i site=%i lane=%i radius=%i threat=%i reach=%i",
                unit->GetId(),def->GetDef()->GetName(),why,rejected[0],rejected[1],rejected[2],rejected[3],rejected[4],rejected[5]);
        return nullptr;
    };
    AIFloat3 at=-RgtVector;
    if(!jammer) at=ai->GetTerrainManager()->FindBuildSite(def,site,160.f,0,admit);
    else {
        if(!coverage.persistent) return nullptr;
        // Five deterministic, bounded neighbourhoods. Rank their legal sites by
        // useful coverage and soft radius-relative spacing, not discovery order.
        const auto direction=commander::Normal(coverage.probes[2].point-coverage.probes[1].point);
        const commander::Point side{-direction.z,direction.x};
        const float offset=std::min(cfg->group.radius*.65f,coverage.radius*.6f);
        const std::array<commander::Point,5> offsets={commander::Point{},direction*offset,direction*(-offset),side*offset,side*(-offset)};
        float best=-std::numeric_limits<float>::infinity();
        for(const auto& delta:offsets) {
            AIFloat3 proposal(site.x+delta.x,site.y,site.z+delta.z);
            const auto candidate=ai->GetTerrainManager()->FindBuildSite(def,proposal,80.f,0,admit);
            if(!OnMap(candidate)) continue;
            const float score=coverage.Score({candidate.x,candidate.z});
            if(score>best) {best=score;at=candidate;}
        }
    }
    if(!OnMap(at)) return traceReject("no_site");
    if(defenseSlot>=0) {
        const auto& rule=defenseRules[defenseSlot];
        const auto& facts=DefenseFactsFor(def);
        if(facts.coverage>0 && at.SqDistance2D(center)>SQUARE(facts.coverage)) return traceReject("coverage_radius");
        // Check actual range/trajectory only on a returned site, not on every
        // terrain-search cell. Five proposal sites bound the expensive work.
        const auto capacity=DefenseCapacity(def,rule,&at);
        if(!surplus && defense::Marginal(defenseDemand,defenseActive,defensePending,capacity,rule,def->GetCostM())<=0) return traceReject("no_benefit_at_site");
    }
    ai->LOG("[CommanderGroup] unit=%i build=%s nano=%i x=%.0f z=%.0f",unit->GetId(),def->GetDef()->GetName(),int(nano),at.x,at.z);
    auto* task=builder->Enqueue(TaskB::Common(type,IBuilderTask::Priority::HIGH,def,at,0.f,true,60*FRAMES_PER_SEC));
    if(jammer && task) {
        task->ReserveDefenseIntent(); // publish before the next ally asks
        ai->LOG("[CommanderJammerPlan] unit=%i def=%s gain=%.3f critical=%i claims=%u x=%.0f z=%.0f",
            unit->GetId(),def->GetDef()->GetName(),coverage.Gain({at.x,at.z}),
            int(coverage.CriticalGap({at.x,at.z})),unsigned(coverage.infrastructure.size()),at.x,at.z);
    }
    return task;
}
IUnitTask* CCommanderController::StartedCommanderConstruction(CCircuitUnit* unit) const {
    if(!unit || !Handles(unit) || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
    if(!build || build->IsDead() || !build->GetBuildDef() || !build->GetTarget()
        || build->GetTarget()->IsFinished() || build->IsExternalControlled()) return nullptr;
    // Preserve the existing local finish-frame contract before optional group
    // handoff. No search, allocation or new orders; safety admission is unchanged.
    const float distance=build->GetPosition().SqDistance2D(unit->GetPos(ai->GetLastFrame()));
    if(!commander::GroupJobInRange(distance,cfg->front.radius,unit->GetCircuitDef()->GetBuildDistance(),true)
        || !CanResumeFrontTask(unit,build)) return nullptr;
    static const bool trace=std::getenv("CIRCUIT_COMMANDER_TRACE")!=nullptr;
    if(trace && FirstExpansionJob() && !IsExpansionJob(build) && ai->GetLastFrame()%30<3) {
        auto* other=dynamic_cast<IBuilderTask*>(FirstExpansionJob());
        auto* otherDef=other?other->GetBuildDef():nullptr;
        ai->LOG("[CommanderGroup] retain_started unit=%i target=%i def=%s other=%s",unit->GetId(),build->GetTarget()->GetId(),build->GetBuildDef()->GetDef()->GetName(),otherDef?otherDef->GetDef()->GetName():"repair");
    }
    return build;
}
IUnitTask* CCommanderController::GroupAssist(CCircuitUnit* unit) {
    if(auto* started=StartedCommanderConstruction(unit)) return started;
    if(AssistClosed(unit)) return nullptr;   // D-490: low energy, no assist
    if(ExpansionJobCount()==0) return GroupWork(unit);
    // D-476: the expansion job this unit is on, else the first it may work.
    const ExpansionJob* slot=nullptr;
    for(const auto& job:expansionJobs) if(job.task && !job.task->IsDead() && GroupProjectAllowed(unit,job.task)) {
        if(unit->GetTask()==job.task) {slot=&job;break;}
        if(!slot) slot=&job;
    }
    if(!slot) return nullptr;
    auto* groupTask=slot->task;
    if(HealthRetreat(unit) || EnergyRetreat(unit) || !GroupTaskFunded(groupTask) || !CanResumeFrontTask(unit,groupTask)) return nullptr;
    if(unit->GetTask()==groupTask) return groupTask;
    auto* task=groupTask;
    if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
        auto* target=ai->GetTeamUnit(repair->GetTargetId());
        if(!target) return nullptr;
        task=ai->GetBuilderManager()->EnqueueRepairFor(target,60*FRAMES_PER_SEC,unit);
    }
    if(!task) return nullptr;
    if(!task->CanAssignTo(unit)) {
        if(groupTask->GetAssignees().empty() || ai->GetLastFrame()>=slot->until) return nullptr;
        auto* state=states.Find(unit->GetId());
        if(!state) return nullptr;
        auto* current=unit->GetTask();
        if(current && current==state->work.task && state->work.kind==20 && !current->IsDead()
            && current->GetType()==IUnitTask::Type::WAIT) return current;
        auto* wait=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(TaskB::Wait(3*FRAMES_PER_SEC)));
        wait->SetStationary(true);task=wait;
    }
    if(auto* state=states.Find(unit->GetId())) {state->work.task=task;state->work.kind=20;}
    return task;
}
IUnitTask* CCommanderController::GroupFollow(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(!anchor) return nullptr;
    const int frame=ai->GetLastFrame();
    auto goal=anchor->GetPos(frame);
    if(unit==anchor) {
        auto* battle=ai->GetBattle();
        const float progress=battle->GetFrontLaneProgress(goal);
        const float next=battle->LimitLaneAdvance(progress,std::min(progress+256.f,
            std::min(cfg->front.distance,battle->GetFrontLaneLength()-cfg->front.standoff)));
        const auto at=battle->GetFrontLanePoint(next);
        if(OnMap(at) && GroupSiteAllowed(unit,at) && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat
            && ai->GetTerrainManager()->CanReachAtSafe2(unit,at,64.f)) goal=at;
    }
    if(auto* follow=dynamic_cast<CCommanderGroupFollowTask*>(unit->GetTask());follow && !follow->IsDead()
        && follow->Target()==anchor->GetId() && (unit!=anchor || follow->Destination().SqDistance2D(goal)<SQUARE(128.f))) return follow;
    return unit->GetManager()->EnqueueGroupFollow(anchor->GetId(),unit==anchor?64.f:cfg->group.radius*.5f,
        !unit->GetCircuitDef()->IsBuilder(),goal);
}
bool CCommanderController::GroupProjectAllowed(CCircuitUnit* unit,IUnitTask* task) const {
    if(!task || task->IsDead() || !GroupTaskFunded(task) || HealthRetreat(unit) || EnergyRetreat(unit)) return false;
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build) return false;
    auto at=build->GetPosition();
    auto* def=build->GetBuildDef();
    if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
        auto* target=ai->GetFriendlyUnit(repair->GetTargetId());
        if(!target) return false;
        def=target->GetCircuitDef();
        at=target->GetPos(ai->GetLastFrame());
        // Maintenance never pursues a mobile target beyond current build reach.
        if(target->GetCircuitDef()->IsMobile() && at.SqDistance2D(unit->GetPos(ai->GetLastFrame()))
            >SQUARE(unit->GetCircuitDef()->GetBuildDistance())) return false;
    }
    auto* anchor=GroupCommander();
    return anchor && OnMap(at) && GroupBuildSiteAllowed(unit,def,at) && GroupLaneWorkAllowed(unit,def,at)
        && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat
        && commander::GroupJobInRange(at.SqDistance2D(anchor->GetPos(ai->GetLastFrame())),
            cfg->group.radius,unit->GetCircuitDef()->GetBuildDistance(),unit->GetTask()==task);
}
IUnitTask* CCommanderController::SupportConstruction(CCircuitUnit* unit) {
    if(!unit || role.frontDuty) return nullptr;
    auto* task=unit->GetTask();
    if(!task || task->IsDead() || task->IsExternalControlled() || task->IsEnemyReclaim()) return nullptr;
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build) return nullptr;
    // Constant-time retention through both task asks and the travel tick.
    // Repair tasks also represent assistance on allied unfinished structures.
    if(build->GetBuildDef() && build->GetBuildType()<IBuilderTask::BuildType::REPAIR) return task;
    auto* repair=dynamic_cast<IRepairTask*>(task);
    // Own frames are known immediately, before the shared friendly snapshot
    // publishes them. RepairTask keeps its own live target where available.
    CAllyUnit* target=build->GetTarget();
    if(!target && repair) target=ai->GetFriendlyUnit(repair->GetTargetId());
    return target && target->GetCircuitDef() && !target->GetCircuitDef()->IsMobile()
        && target->GetUnit()->IsBeingBuilt()?task:nullptr;
}
IUnitTask* CCommanderController::GroupLocalMaintenance(CCircuitUnit* unit,CCircuitUnit* anchor) {
    // Fixed roster, anchor first; never scan unrelated builders or base queues.
    for(int id:{anchor->GetId(),groupUnit,groupMembers[0],groupMembers[1],groupMembers[2],groupMembers[5]}) {
        auto* worker=ai->GetTeamUnit(id);
        if(!worker || worker==unit) continue;
        auto* project=worker->GetTask();
        auto* build=dynamic_cast<IBuilderTask*>(project);
        // D-475: the tactical job is the other queue's; adopting it as the
        // expansion job held the one expansion slot for a whole launcher (b05).
        if(build && build->GetBuildDef() && project!=tacticalJob && !IsTacticalDef(build->GetBuildDef())
            && !project->IsExternalControlled()
            && !project->IsEnemyReclaim() && GroupProjectAllowed(unit,project) && project->CanAssignTo(unit))
        {
            ai->LOG("[CommanderGroup] assist_adopt unit=%i anchor=%i def=%s",unit->GetId(),worker->GetId(),build->GetBuildDef()->GetDef()->GetName());
            return TrackGroupJob(project,false);
        }
    }
    const int frame=ai->GetLastFrame();
    int* nextMaintenance=&groupMaintenanceNext;
    if(supportAnchor>=0 && !role.frontDuty) {
        // Separate reach discs: one fixed timer per engineer avoids the first
        // seat starving repairs only visible to another seat (including itself).
        for(size_t i=0;i<supportMaintenanceNext.size();++i)
            if(groupMembers[i]==unit->GetId()) {nextMaintenance=&supportMaintenanceNext[i];break;}
    }
    if(frame<*nextMaintenance) return nullptr;
    *nextMaintenance=frame+FRAMES_PER_SEC;
    // FRONT: one query per group/second. Engineering: at most three separate
    // in-reach queries/second. No repair excursion or unrestricted GUARD.
    const auto here=unit->GetPos(frame);
    const float reach=std::max(0.f,unit->GetCircuitDef()->GetBuildDistance()-32.f);
    // Own the small result across EnqueueRepairFor/TaskAdded callbacks, which
    // may reuse the engine wrapper's query buffer.
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(here,reach,false);
    for(int id:ids) {
        auto* target=ai->GetFriendlyUnit(id);
        if(!target || !target->GetCircuitDef()) continue;
        // D-475: an unfinished launcher is the tactical queue's (it resumes it).
        if(IsTacticalDef(target->GetCircuitDef()) && target->GetUnit()->IsBeingBuilt()) continue;
        auto* native=target->GetUnit();
        if(!commander::UsefulGroupRepair(id==unit->GetId(),target->GetCircuitDef()->IsMobile(),
            IsGroupMember(id) || id==anchor->GetId(),native->IsBeingBuilt(),native->GetHealth(),native->GetMaxHealth())) continue;
        const auto at=target->GetPos(frame);
        const bool allowed=supportAnchor>=0 && !role.frontDuty
            ? GroupBuildSiteAllowed(unit,target->GetCircuitDef(),at) && GroupLaneWorkAllowed(unit,target->GetCircuitDef(),at)
            : GroupSiteAllowed(unit,at) && ai->GetBattle()->LaneWorkAllowed(at);
        if(!allowed
            || at.SqDistance2D(anchor->GetPos(frame))>SQUARE(cfg->group.radius)
            || ai->GetThreatMap()->GetThreatAt(unit,at)>cfg->front.threat) continue;
        auto* task=ai->GetBuilderManager()->EnqueueRepairFor(target,15*FRAMES_PER_SEC,unit);
        if(task && task->CanAssignTo(unit)) {
            ai->LOG("[CommanderGroup] maintenance unit=%i target=%i unfinished=%i",unit->GetId(),id,int(native->IsBeingBuilt()));
            return TrackGroupJob(task,false);
        }
        if(task) ai->GetBuilderManager()->DiscardUnusedTask(task);
    }
    return nullptr;
}
IUnitTask* CCommanderController::GroupConstruction(CCircuitUnit* unit,CCircuitUnit* anchor,int frame) {
    const auto center=anchor->GetPos(frame);
    if(defenseSettings.enabled>0) {
        if(cfg->group.radarPriority<=0) return nullptr;
        // Structure choice belongs to the shared planner; retain the existing
        // forward sensor/jammer admission and their native coverage machinery.
        auto* battle=ai->GetBattle();
        const auto probe=battle->GetFrontLanePoint(battle->GetFrontLaneProgress(center)+cfg->group.combatDistance);
        auto* radar2=ai->GetCircuitDefSafe(groupRadar2);
        auto* jammer2=ai->GetCircuitDefSafe(groupJammer2);
        if(OnMap(probe) && !ai->GetMapManager()->IsInRadar(probe))
            if(auto* task=GroupBuild(unit,GroupCanBuild(radar2,anchor)?radar2:ai->GetCircuitDefSafe(groupRadar),center)) return TrackGroupJob(task);
        if(auto* task=GroupBuild(unit,GroupCanBuild(jammer2,anchor)?jammer2:ai->GetCircuitDefSafe(groupJammer),center)) return TrackGroupJob(task);
        return nullptr;
    }
    auto* advancedDef=ai->GetCircuitDefSafe(groupDef2);
    const bool advanced=GroupCanBuild(advancedDef,anchor) && GroupCanFund(advancedDef);
    {
        auto* radar2=ai->GetCircuitDefSafe(groupRadar2);
        auto* jammer2=ai->GetCircuitDefSafe(groupJammer2);
        auto* radar=GroupCanBuild(radar2,anchor)?radar2:ai->GetCircuitDefSafe(groupRadar);
        auto* jammer=GroupCanBuild(jammer2,anchor)?jammer2:ai->GetCircuitDefSafe(groupJammer);
        auto* defence=advanced?advancedDef:ai->GetCircuitDefSafe(groupDef);
        if(!advanced && Handles(unit) && (!defence || !unit->GetCircuitDef()->CanBuild(defence)))
            defence=ai->GetCircuitDefSafe(int(cfg->front.lineDef));
        // Reuse the ally radar map (including mobile/allied sensors),
        // sampling ahead along the lane rather than scanning all radar
        // units or confusing the commander's own short radar with front coverage.
        auto* battle=ai->GetBattle();
        const auto probe=battle->GetFrontLanePoint(battle->GetFrontLaneProgress(center)+cfg->group.combatDistance);
        const bool radarPresent=OnMap(probe) && ai->GetMapManager()->IsInRadar(probe);
        std::array<std::pair<float,int>,3> order={{{cfg->group.mexPriority,0},{cfg->group.radarPriority,1},{cfg->group.linePriority,2}}};
        std::sort(order.begin(),order.end(),[](const auto& a,const auto& b){return a.first!=b.first?a.first>b.first:a.second<b.second;});
        for(const auto& entry:order) {
            if(entry.first<=0) continue;
            IUnitTask* task=nullptr;
            if(entry.second==0) task=MexDefenceWork(unit,groupState,defence,frame);
            else if(entry.second==1) {
                if(!radarPresent) task=GroupBuild(unit,radar,center);
                if(!task) task=GroupBuild(unit,jammer,center);
            } else task=TerritoryLineWork(unit,groupState,defence,frame);
            if(dynamic_cast<IBuilderTask*>(task)) return TrackGroupJob(task);
            // A blocked line may offer a wait. It is not a structure
            // transaction and must not monopolise the group's job slot.
            if(task) ai->GetBuilderManager()->DiscardUnusedTask(task);
        }
    }
    return nullptr;
}
/*
 * D-480 (the owner's rule, played: an 8v8 on All That Glitters, the FRONT
 * group skipped two mexes): before anything else the FRONT seat's T1
 * constructor in the group (groupUnit) collects every open mex it owns in its
 * base, then every one along its lane from the base up to the commander.
 * EnqueueMexWithin applies the territory (never an ally's spot), hands back an
 * order already queued, and takes the spot nearest the builder first.
 * A spot the engine refuses (seatmex-b23 on Glitters: the mex task fell back
 * to patrol and the spot reopened every second) is cleared by an area reclaim
 * when features stand on it, otherwise skipped for seatSkipSeconds.
 * Cost: at most MAX_SEAT_MEX_ATTEMPTS spot searches and feature queries per
 * ask (once a second from the group push, plus the script's asks).
 */
IUnitTask* CCommanderController::GroupSeatMexWork(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(cfg->group.seatMex<=0 || groupUnit<0 || unit->GetId()!=groupUnit || !unit->GetCircuitDef()->IsBuilder()
        || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    auto* current=unit->GetTask();
    // A mex order in hand, its clearing reclaim, or any frame already started, is finished first.
    if(auto* build=dynamic_cast<IBuilderTask*>(current); build && !build->IsDead()) {
        if(build->GetBuildType()==BT::MEX || (build->GetBuildType()==BT::RECLAIM && build->recoveryControlled)) return current;
        if(build->GetTarget()!=nullptr) return nullptr;
    }
    auto* eco=ai->GetEconomyManager();
    auto* builder=ai->GetBuilderManager();
    const int frame=ai->GetLastFrame();
    // D-485: once the base and the approach are taken this search finds
    // nothing on every ask; wait SEAT_MEX_IDLE_SECONDS before the next one.
    if(frame<seatMexNext) return nullptr;
    seatMexSkip.erase(std::remove_if(seatMexSkip.begin(),seatMexSkip.end(),
        [frame](const auto& s) { return s.second<=frame; }),seatMexSkip.end());
    auto& skipped=mexSkipScratch;  // D-485: reused, no allocation per ask
    skipped.clear();
    for(const auto& s:seatMexSkip) skipped.push_back(s.first);
    const float threat=cfg->front.threat;
    const auto safe=[this,unit,threat](const AIFloat3& p) { return ai->GetThreatMap()->GetThreatAt(unit,p)<=threat; };
    auto* battle=ai->GetBattle();
    const auto find=[&](const char*& phase) -> IBuilderTask* {
        phase="base";
        IBuilderTask* task=nullptr;
        if(cfg->group.seatBaseRadius>0)
            task=eco->EnqueueMexWithin(unit,ai->GetSetupManager()->GetBasePos(),cfg->group.seatBaseRadius,0,true,skipped,safe);
        if(task || !anchor || battle->GetFrontLaneLength()<=0.f) return task;
        phase="approach";
        const AIFloat3 at=unit->GetPos(frame);
        const float width=battle->GetFrontLaneWidth()+unit->GetCircuitDef()->GetBuildDistance();
        const float limit=battle->GetFrontLaneProgress(anchor->GetPos(frame))+cfg->group.seatApproachAhead;
        const auto approach=[battle,width,limit,&safe](const AIFloat3& p) {
            return battle->GetFrontLaneDistance(p)<=width && battle->GetFrontLaneProgress(p)<=limit && safe(p);
        };
        // The whole route from the base to the commander lies within this disc.
        const float radius=std::sqrt(at.SqDistance2D(anchor->GetPos(frame)))
            +std::sqrt(at.SqDistance2D(ai->GetSetupManager()->GetBasePos()))+width;
        return eco->EnqueueMexWithin(unit,at,radius,0,true,skipped,approach);
    };
    // Bounded: each refused spot joins the skip list, so the search ends.
    for(int attempt=0;attempt<MAX_SEAT_MEX_ATTEMPTS;++attempt) {
        const char* phase="";
        IBuilderTask* task=find(phase);
        if(!task) { seatMexNext=frame+SEAT_MEX_IDLE_SECONDS*FRAMES_PER_SEC; return nullptr; }
        const AIFloat3 pos=task->GetBuildPos();
        if(!task->GetBuildDef() || task->GetTarget()
            || ai->GetMap()->IsPossibleToBuildAt(task->GetBuildDef()->GetDef(),pos,task->GetFacing())) {
            if(task!=current) ai->LOG("[CommanderGroup] seat_mex unit=%i phase=%s x=%.0f z=%.0f",unit->GetId(),phase,pos.x,pos.z);
            return task;
        }
        const float clear=cfg->group.seatClearRadius;
        if(clear>0 && unit->GetCircuitDef()->IsAbleToReclaim() && ai->GetCallback()->IsFeaturesIn(pos,clear)) {
            if(IBuilderTask* claim=builder->GetReclaimFeatureTask(pos,clear); claim && !claim->IsDead()) {
                if(claim->recoveryControlled && claim->GetAssignees().empty()) return claim;
            } else if(auto* reclaim=builder->Enqueue(TaskB::Reclaim(IBuilderTask::Priority::HIGH,pos,0.f,
                    int(cfg->group.seatSkipSeconds*FRAMES_PER_SEC),clear,false))) {
                // The seat owns this clearing: never retargeted to another feature.
                reclaim->recoveryControlled=true;
                ai->LOG("[CommanderGroup] seat_mex_clear unit=%i phase=%s x=%.0f z=%.0f",unit->GetId(),phase,pos.x,pos.z);
                return reclaim;
            }
        }
        ai->LOG("[CommanderGroup] seat_mex_skip unit=%i phase=%s x=%.0f z=%.0f",unit->GetId(),phase,pos.x,pos.z);
        seatMexSkip.emplace_back(pos,frame+int(cfg->group.seatSkipSeconds*FRAMES_PER_SEC));
        skipped.push_back(pos);
    }
    return nullptr;
}
IUnitTask* CCommanderController::GroupWork(CCircuitUnit* unit) {
    if(!unit || !role.frontDuty || (!IsGroupMember(unit->GetId()) && !Handles(unit)) || !unit->IsFinished()) return nullptr;
    auto* current=unit->GetTask();
    if(control::SuspensionOf(unit,ai->GetLastFrame())!=control::Suspension::NONE) return current;
    if(current && (current->IsExternalControlled() || current->IsEnemyReclaim()
        || current->GetType()==IUnitTask::Type::PLAYER || current->GetType()==IUnitTask::Type::RETREAT)) return current;
    // D-474: a live brace (step back, defence toward the threat) is kept; the
    // once-a-second group push would otherwise replace it within a second.
    if(current && !current->IsDead() && dynamic_cast<CBBraceTask*>(current)) return current;
    if(auto* started=StartedCommanderConstruction(unit)) return started;
    // D-490: the commander's own construction is never swapped for another
    // build task, started or still walking to its site.
    if(Handles(unit) && cfg->front.keepOwnBuild>0 && IsOwnConstruction(unit,current)) return current;
    // D-490: low energy: the commander takes no assist (joins, adopted projects)
    // and starts no group construction; the ladder's energy and mex rungs act.
    if(AssistClosed(unit)) return nullptr;
    auto* anchor=GroupCommander();
    if(!anchor) return current;
    // D-480: the seat's T1 constructor collects base, then approach, mexes first.
    if(auto* mex=GroupSeatMexWork(unit,anchor)) return mex;
    // D-481: front-line geo fortification, then the guard geo's turrets.
    if(unit->GetCircuitDef()->IsBuilder()) {
        if(geoJob && current==geoJob && GeoJobAllowed(unit,anchor)) return current;
        if(auto* guard=GroupGeoGuardWork(unit,anchor)) return guard;
        if(!geoJob) if(auto* geo=GroupGeoWork(unit,anchor)) return geo;
    }
    const int frame=ai->GetLastFrame();
    const auto center=anchor->GetPos(frame);
    const bool builder=unit->GetCircuitDef()->IsBuilder();
    const bool nearby=unit->GetPos(frame).SqDistance2D(center)<=SQUARE(cfg->group.radius);
    // D-476: the split constructor above tactical_metal works the tactical queue.
    if(builder && TacticalSplit(unit)) if(auto* task=GroupTacticalWork(unit,anchor,nearby)) return task;
    // Retention is checked before the worker proximity gate. A constructor
    // travelling to its reserved site must not bounce back into follow.
    if(builder && IsExpansionJob(current) && GroupProjectAllowed(unit,current)) return current;
    // D-476: one expansion job per constructor, up to commander_group_expansion_jobs;
    // with the queue full a constructor helps a job with room (the legacy
    // single job when the cap is 1: join first, start only when none exists).
    const bool room=ExpansionJobCount()<ExpansionCap();
    if(builder && !room) if(auto* job=JoinExpansionJob(unit,nearby)) return job;
    if(builder && nearby && room && Handles(unit)) {
        if(auto* state=states.Find(unit->GetId()))
            if(auto* task=ExpansionMexWork(unit,*state,ai->GetCircuitDefSafe(int(cfg->front.lineDef)),frame))
                return TrackGroupJob(task);
    }
    if(builder && nearby && room) {
        // Routine weapons must not starve missing radar/jammer coverage. Only
        // the configured urgent bands precede it; accepted jobs are untouched.
        using Phase=commander::ConstructionPhase;
        if(auto* task=commander::SelectGroupConstruction(NanoUnassigned(),
            [&]{return GroupNearCombat(anchor);},[&](Phase phase)->IUnitTask* {
                switch(phase) {
                    case Phase::URGENT: return GroupPlannedDefense(unit,anchor,frame,int(cfg->group.sensorDefenseBand));
                    case Phase::NANO: {
                        const auto site=groupNanoSite.SqDistance2D(center)<=SQUARE(cfg->group.radius)?groupNanoSite:center;
                        return TrackGroupJob(GroupBuild(unit,ai->GetCircuitDefSafe(groupNano),site,true));
                    }
                    case Phase::SENSORS: return GroupConstruction(unit,anchor,frame);
                    // D-476: demand only here; surplus waits for mex upgrades and maintenance.
                    case Phase::DEFENSE: return GroupPlannedDefense(unit,anchor,frame,0,false);
                }
                return nullptr;
            })) return task;
    }
    if(builder && nearby && room && !NanoUnassigned()) {
        if(auto* task=GroupUpgradeMex(unit,anchor)) return task;
        if(cfg->group.maintenance>0) if(auto* task=GroupLocalMaintenance(unit,anchor)) return task;
        // D-476: surplus porc (bank or spare income) after the economy work.
        if(auto* task=GroupPlannedDefense(unit,anchor,frame)) return task;
    }
    // D-476: nothing new to start: help an expansion job with room, then
    // tactical work as overflow (any constructor), then follow.
    if(builder && room) if(auto* job=JoinExpansionJob(unit,nearby)) return job;
    if(builder && geoJob) if(auto* geo=GroupGeoWork(unit,anchor)) return geo;  // D-481: help the geo
    if(builder) if(auto* task=GroupTacticalWork(unit,anchor,nearby)) return task;
    return IsGroupMember(unit->GetId())?GroupFollow(unit,anchor):nullptr;
}
void CCommanderController::UpdateCommanderGroup() {
    const int frame=ai->GetLastFrame();
    if(frame<groupNext || !role.frontDuty) return;
    groupNext=frame+FRAMES_PER_SEC;
    auto* anchor=GroupCommander();
    const int anchorId=anchor?anchor->GetId():-1;
    // Only shields can use the remote-plasma lane exception. Refresh its
    // safety evidence while constructing, not only when proposing idle work.
    if(anchor && defenseSettings.enabled>0) for(const auto& job:expansionJobs) {
        auto* build=dynamic_cast<IBuilderTask*>(job.task);
        if(build && build->GetBuildDef() && (build->GetBuildDef()->GetShieldRadius()>0
            || defenseDemand[defense::PLASMA].health>0)) { AssessGroupDefense(anchor,frame); break; }
    }
    // A moving anchor can invalidate a site after its last worker yields.
    // Retire that orphan instead of letting it block the one shared job slot.
    if(anchor) for(auto& job:expansionJobs) {
        auto* orphan=job.task;
        if(orphan && orphan->GetAssignees().empty() && !GroupProjectAllowed(anchor,orphan)) {
            static const bool trace=std::getenv("CIRCUIT_COMMANDER_TRACE")!=nullptr;
            if(trace) ai->LOG("[CommanderGroup] orphan_project_rejected");
            orphan->GetManager()->AbortTask(orphan); // dequeue clears borrowed identity
        }
    }
    if(anchor && geoJob && geoJob->GetAssignees().empty()) {  // D-481
        if(!GeoFrontLine(anchor,geoJobPos,cfg->group.geoFrontRadius)) geoJob->GetManager()->AbortTask(geoJob);
    }
    if(anchorId!=groupAnchorId) {
        groupAnchorId=anchorId;
        ai->LOG("[CommanderGroup] anchor=%i def=%s",anchorId,anchor?anchor->GetCircuitDef()->GetDef()->GetName():"none");
    }
    // Seven seats, no army scan. Shared job and plans live at group scope;
    // existing lane publication is reused. At most one new job per second.
    for(int id:{groupUnit,groupMembers[0],groupMembers[1],groupMembers[2],groupMembers[3],groupMembers[4],groupMembers[5]}) {
        auto* unit=ai->GetTeamUnit(id);
        if(!unit) continue;
        if(auto* task=GroupWork(unit);task && task!=unit->GetTask()) unit->GetManager()->AssignTask(unit,task);
    }
}
}
