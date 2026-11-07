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
#include "task/common/WaitTask.h"
#include "task/common/RepairTask.h"
#include "task/builder/RepairTask.h"
#include "setup/SetupManager.h"
#include "spring/SpringMap.h"
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
    if(tacticalGroup>0 && IsTacticalDef(def) && site.SqDistance2D(tacticalCentre)<=SQUARE(tacticalRadius)) return true;
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
        cfg->group.radius+(IsTacticalDef(def)?tacticalRadius:0.f),unit->GetCircuitDef()->GetBuildDistance(),
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
    for(auto& entry:states) entry.value->work.Retire(task);
    if(task==tacticalJob) {  // D-475: the tactical queue's slot is free again
        tacticalJob=nullptr;
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
    const auto at=build->GetPosition();
    if(OnMap(at)) {groupNanoSite=at;++groupNanoOwed;groupNanoDue=true;}
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
 * D-475/D-476: the commander group's second queue (tactical). The expansion
 * queue (expansionJobs) is everything GroupWork did before and comes first;
 * the tactical queue builds launchers (EMP, tactical missile, napalm) in a
 * tight reserved block behind the commander to start hitting enemy statics:
 * one constructor above tactical_metal (TacticalSplit), any constructor with
 * no expansion work below it. Cost: one block search per tacticalRetrySeconds
 * while none is open (at most fifteen rectangles), one slot lookup per job.
 */
namespace {
// Candidate block centres, in blocks: rows 0..2 behind the commander, each
// row straight back, then 1 and 2 blocks to either side (15 rectangles; the
// first six failed in a base crowded with the opening's economy, b06).
constexpr int TACTICAL_BACK_ROWS=3;
constexpr int TACTICAL_SIDE_STEPS=5;
constexpr float TACTICAL_SIDE[TACTICAL_SIDE_STEPS]={0.f,-1.f,1.f,-2.f,2.f};
// Lane look-ahead (elmos) that gives the forward direction.
constexpr float TACTICAL_LANE_AHEAD=256.f;
commander::Point TacticalP(const AIFloat3& p) { return {p.x,p.z}; }
AIFloat3 TacticalF(commander::Point p) { return {p.x,0.f,p.z}; }
}
bool CCommanderController::IsTacticalDef(const CCircuitDef* def) const {
    return def && std::find(tacticalDefs.begin(),tacticalDefs.end(),def->GetId())!=tacticalDefs.end();
}
int CCommanderController::GroupT2Count() const {
    // The three T2 seats only (radar, jammer and decoy seats are not workers).
    int count=0;
    for(unsigned i=0;i<3;++i) {
        auto* worker=ai->GetTeamUnit(groupMembers[i]);
        if(worker && worker->IsFinished() && !worker->IsDead()) ++count;
    }
    return count;
}
bool CCommanderController::TacticalEconomy() const {
    // "Energy not low": no stall and the bank above tacticalEnergy of storage.
    auto* eco=ai->GetEconomyManager();
    return eco->GetMetalCur()>cfg->group.tacticalMetal && !eco->IsEnergyStalling()
        && eco->GetEnergyCur()>=cfg->group.tacticalEnergy*eco->GetEnergyStore();
}
bool CCommanderController::TacticalJobAllowed(CCircuitUnit* unit,IUnitTask* task,CCircuitUnit* anchor) const {
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build || task->IsDead() || HealthRetreat(unit) || EnergyRetreat(unit)) return false;
    auto at=build->GetPosition();
    if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
        auto* target=ai->GetFriendlyUnit(repair->GetTargetId());
        if(!target) return false;
        at=target->GetPos(ai->GetLastFrame());
    }
    return OnMap(at) && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat
        && commander::GroupJobInRange(at.SqDistance2D(anchor->GetPos(ai->GetLastFrame())),
            cfg->group.radius,unit->GetCircuitDef()->GetBuildDistance(),unit->GetTask()==task);
}
bool CCommanderController::ReserveTacticalBlock(CCircuitUnit* unit,CCircuitUnit* anchor,CCircuitDef* def,int frame) {
    if(frame<tacticalNext) return false;
    tacticalNext=frame+int(cfg->group.tacticalRetrySeconds*FRAMES_PER_SEC);
    auto* terrain=ai->GetTerrainManager();
    const auto center=anchor->GetPos(frame);
    // Forward: along the front lane at the commander; else base -> commander.
    commander::Point fwd{};
    auto* battle=ai->GetBattle();
    if(battle->GetFrontLaneLength()>0.f) {
        const float progress=battle->GetFrontLaneProgress(center);
        const auto ahead=battle->GetFrontLanePoint(std::min(progress+TACTICAL_LANE_AHEAD,battle->GetFrontLaneLength()));
        if(OnMap(ahead)) fwd=commander::Normal(TacticalP(ahead)-TacticalP(center));
    }
    if(commander::Length(fwd)<.1f) fwd=commander::Normal(TacticalP(center)-TacticalP(ai->GetSetupManager()->GetBasePos()));
    if(commander::Length(fwd)<.1f) fwd={0,1};
    // Engine facing: 0 +z, 1 +x, 2 -z, 3 -x; the dominant axis of forward.
    const int facing=std::abs(fwd.x)>std::abs(fwd.z)?(fwd.x>0?1:3):(fwd.z>0?0:2);
    const commander::Point axis=facing==1?commander::Point{1,0}:facing==3?commander::Point{-1,0}
        :facing==2?commander::Point{0,-1}:commander::Point{0,1};
    const commander::Point side{-axis.z,axis.x};
    const int cols=int(cfg->group.tacticalCols),rows=int(cfg->group.tacticalRows);
    // Footprint squares are SQUARE_SIZE elmos; gap 0 packs the block tight.
    const float size=float(std::max(def->GetDef()->GetXSize(),def->GetDef()->GetZSize()))*SQUARE_SIZE;
    const float across=float(cols)*size,along=float(rows)*size;
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    const int minimum=std::max(1,int(std::ceil(cfg->group.tacticalMinFill*float(cols*rows))));
    // Rejections by gate, for the log line when nothing fits.
    int offMap=0,tooFar=0,area=0,unreachable=0,grid=0,fill=0;
    for(int i=0;i<TACTICAL_BACK_ROWS*TACTICAL_SIDE_STEPS;++i) {
        const float back=float(i/TACTICAL_SIDE_STEPS),across1=TACTICAL_SIDE[i%TACTICAL_SIDE_STEPS];
        const auto c=TacticalP(center)-axis*(cfg->group.tacticalRear+along*(.5f+back))+side*(across*across1);
        AIFloat3 centre=TacticalF(c);
        if(!OnMap(centre)) {++offMap;continue;}
        centre.y=ai->GetMap()->GetElevationAt(centre.x,centre.z);
        if(centre.SqDistance2D(center)>SQUARE(cfg->group.radius+along*TACTICAL_BACK_ROWS)) {++tooFar;continue;}
        if(!terrain->CanReserveArea(centre,facing,across*.5f,along*.5f)) {++area;continue;}
        if(!terrain->CanReachAtSafe(unit,centre,reach+across)) {++unreachable;continue;}
        const auto front=TacticalF(c+axis*(along*.5f));
        const int group=terrain->ReserveGrid(def,front,facing,cols,rows,0);
        if(group<=0) {++grid;continue;}
        if(terrain->GetGroupCount(group,false)<minimum) { terrain->ReleaseGroup(group); ++fill; continue; }
        tacticalGroup=group; tacticalCentre=centre;
        tacticalRadius=.5f*std::sqrt(across*across+along*along)+size;
        ai->LOG("[CommanderGroup] tactical_block group=%i slots=%i def=%s at=%.0f,%.0f facing=%i",group,
            terrain->GetGroupCount(group,false),def->GetDef()->GetName(),centre.x,centre.z,facing);
        return true;
    }
    ai->LOG("[CommanderGroup] tactical_block none def=%s near=%.0f,%.0f facing=%i off_map=%i far=%i area=%i reach=%i grid=%i fill=%i",
        def->GetDef()->GetName(),center.x,center.z,facing,offMap,tooFar,area,unreachable,grid,fill);
    return false;
}
// D-476 (the owner's rule): expansion jobs come first for every group
// constructor, except that above tactical_metal one constructor that can build
// a launcher works the tactical queue while the rest keep porcing ("split").
// A constructor on a started expansion frame is not taken off it; the next
// free one is. Below tactical_metal tactical work is overflow only (GroupWork's
// last step). Seven seats at most, no scan.
bool CCommanderController::CanBuildTactical(CCircuitUnit* unit) const {
    const int frame=ai->GetLastFrame();
    for(int defId:tacticalDefs) {
        auto* def=ai->GetCircuitDefSafe(defId);
        if(def && unit->GetCircuitDef()->CanBuild(def) && def->IsAvailable(frame)) return true;
    }
    return false;
}
bool CCommanderController::TacticalSplit(CCircuitUnit* unit) const {
    // A constructor on the live tactical job finishes it, whatever the seat
    // count or the bank does meanwhile (played, factory-b12: a T2 seat died, the
    // count fell under tactical_t2 and the half-built launcher was abandoned).
    const bool live=tacticalJob && !tacticalJob->IsDead();
    if(live && unit->GetTask()==tacticalJob && IsGroupMember(unit->GetId())) return true;
    if(!IsGroupMember(unit->GetId()) || cfg->group.tacticalT2<=0 || tacticalDefs.empty()
        || GroupT2Count()<int(cfg->group.tacticalT2)) return false;
    if(!TacticalEconomy() || !CanBuildTactical(unit)) return false;
    if(live && !tacticalJob->GetAssignees().empty()) return false;  // one constructor holds the split
    auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
    return !(build && IsExpansionJob(build) && build->GetTarget());
}
IUnitTask* CCommanderController::GroupTacticalWork(CCircuitUnit* unit,CCircuitUnit* anchor,bool nearby) {
    // D-476: any group constructor that can build a launcher, once the group
    // has tactical_t2 T2 seats (formerly the T2 seats only).
    const int id=unit->GetId();
    // Its own live job first: finished regardless of the opening gates below.
    if(tacticalJob && !tacticalJob->IsDead() && unit->GetTask()==tacticalJob && IsGroupMember(id))
        return TacticalJobAllowed(unit,tacticalJob,anchor)?tacticalJob:nullptr;
    if(!IsGroupMember(id) || cfg->group.tacticalT2<=0 || tacticalDefs.empty() || !unit->GetCircuitDef()->IsBuilder()
        || GroupT2Count()<int(cfg->group.tacticalT2) || !CanBuildTactical(unit)) return nullptr;
    const int frame=ai->GetLastFrame();
    if(tacticalJob && !tacticalJob->IsDead()) {
        if(unit->GetTask()==tacticalJob) return TacticalJobAllowed(unit,tacticalJob,anchor)?tacticalJob:nullptr;
        if(nearby && TacticalJobAllowed(unit,tacticalJob,anchor) && tacticalJob->CanAssignTo(unit)) return tacticalJob;
        return nullptr;
    }
    if(!nearby || HealthRetreat(unit) || EnergyRetreat(unit) || !TacticalEconomy()) return nullptr;
    CCircuitDef* def=nullptr;
    for(int defId:tacticalDefs) {
        auto* candidate=ai->GetCircuitDefSafe(defId);
        if(candidate && unit->GetCircuitDef()->CanBuild(candidate) && candidate->IsAvailable(frame)) {def=candidate;break;}
    }
    if(!def) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* terrain=ai->GetTerrainManager();
    const auto center=anchor->GetPos(frame);
    // A block the commander left behind is released (its unbuilt slots only
    // matter while the group is there); a full block gives way to a new one.
    if(tacticalGroup>0 && (tacticalCentre.SqDistance2D(center)>SQUARE(cfg->group.radius+tacticalRadius)
        || terrain->GetGroupCount(tacticalGroup,true)<=0)) {
        // An unfinished launcher in the old block is finished first.
        if(auto* frameUnit=builder->FindUnfinishedNear(tacticalCentre,tacticalRadius,def)) {
            auto* repair=builder->EnqueueRepairFor(frameUnit,int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC),unit);
            if(repair && TacticalJobAllowed(unit,repair,anchor) && (unit->GetTask()==repair || repair->CanAssignTo(unit))) {
                tacticalJob=repair;
                ai->LOG("[CommanderGroup] job_start queue=tactical def=%s repair=%i team=%i",def->GetDef()->GetName(),frameUnit->GetId(),ai->GetTeamId());
                return repair;
            }
            if(repair) builder->DiscardUnusedTask(repair);
        }
        terrain->ReleaseGroup(tacticalGroup);
        tacticalGroup=0;
    }
    if(tacticalGroup<=0 && !ReserveTacticalBlock(unit,anchor,def,frame)) return nullptr;
    const int slot=terrain->NextSlotAny(tacticalGroup,unit->GetPos(frame));
    if(slot<0) return nullptr;
    auto* task=builder->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,def,terrain->GetReservationPos(slot),
        0.f,true,int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC)));
    if(!task) return nullptr;
    if(!task->PinReservation(slot)) { builder->AbortTask(task); return nullptr; }
    tacticalJob=task;
    const auto at=terrain->GetReservationPos(slot);
    ai->LOG("[CommanderGroup] job_start queue=tactical def=%s slot=%i x=%.0f z=%.0f unit=%i team=%i",
        def->GetDef()->GetName(),slot,at.x,at.z,id,ai->GetTeamId());
    return task;
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
    auto* anchor=GroupCommander();
    if(!anchor) return current;
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
            if(std::getenv("CIRCUIT_COMMANDER_TRACE")) ai->LOG("[CommanderGroup] orphan_project_rejected");
            orphan->GetManager()->AbortTask(orphan); // dequeue clears borrowed identity
        }
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
