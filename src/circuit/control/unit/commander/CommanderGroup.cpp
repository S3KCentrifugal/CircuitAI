#include "task/builder/CommanderGroupFollowTask.h"
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
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>
#include <array>
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
    if(!role.frontDuty || !role.frontReady) return nullptr;
    for(const auto& entry:states) {
        auto* unit=ai->GetTeamUnit(entry.id);
        if(unit && unit->IsFinished() && !ActualDecoy(unit->GetCircuitDef())) return unit;
    }
    // Stable seat order; loss/transfer only vacates that member, never the group.
    for(int id:{groupMembers[5],groupMembers[0],groupMembers[1],groupMembers[2],groupUnit,groupMembers[3],groupMembers[4]}) {
        auto* unit=ai->GetTeamUnit(id);
        if(unit && unit->IsFinished()) return unit;
    }
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
    auto* definition=build->GetBuildDef();
    if(!definition) {
        // Only the selected worker's unfinished support frame may invite the
        // commander into a repair task. Generic base repairs stay excluded.
        auto* worker=groupJob && !groupJob->GetAssignees().empty()?*groupJob->GetAssignees().begin():nullptr;
        auto* repair=dynamic_cast<IRepairTask*>(build);
        auto* target=repair?ai->GetTeamUnit(repair->GetTargetId()):nullptr;
        if(!worker || worker->GetTask()!=task || !target || target->IsFinished()) return false;
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
    auto* worker=groupJob && !groupJob->GetAssignees().empty()?*groupJob->GetAssignees().begin():nullptr;
    const int defId=definition->GetId();
    // GroupSiteAllowed already confines assistance to the assigned territory.
    // Do not apply a centre-strip restriction: lateral defenses are intentional
    // and the commander works from build range, not from the structure's site.
    // Bound rearward travel while allowing that build reach at the boundary.
    if(worker && worker->GetTask()==task && IsGroupStructure(defId))
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
// narrower territory polygon. Only LLTs and their nano support inherit that
// local capture window; factories/radars/other group work keep their boundary.
// Geometry only, no engine collection query. Income gates offers, not retention.
bool CCommanderController::GroupBuildSiteAllowed(CCircuitUnit* unit,const CCircuitDef* def,const AIFloat3& site) const {
    if(GroupSiteAllowed(unit,site)) return true;
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    if(!unit || !def || cfg->front.mexMinIncome<=0
        || (def->GetId()!=int(cfg->front.lineDef) && def->GetId()!=groupNano)) return false;
    auto* anchor=Handles(unit)?unit:GroupCommander();
    return anchor && LaneMexSiteAllowed(anchor,site);
}

bool CCommanderController::GroupMayBuild(CCircuitUnit* unit,CCircuitDef* def,const AIFloat3& site) const {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    if(!GroupBuildSiteAllowed(unit,def,site) || HealthRetreat(unit) || EnergyRetreat(unit)) return false;
    if(!IsGroupMember(unit->GetId())) return true;
    auto* anchor=GroupCommander();
    return anchor && def && commander::GroupJobInRange(site.SqDistance2D(anchor->GetPos(ai->GetLastFrame())),
        cfg->group.radius,unit->GetCircuitDef()->GetBuildDistance(),unit->GetTask()==groupJob);
}
IUnitTask* CCommanderController::TrackGroupJob(IUnitTask* task,bool earnsNano) {
    if(task) {
        groupJob=task;groupJobEarnsNano=earnsNano;
        groupProjectUntil=ai->GetLastFrame()+int(cfg->group.projectHoldSeconds*FRAMES_PER_SEC);
        auto* build=dynamic_cast<IBuilderTask*>(task);
        auto* def=build?build->GetBuildDef():nullptr;
        if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
            auto* target=ai->GetTeamUnit(repair->GetTargetId());
            if(target) def=target->GetCircuitDef();
        }
        groupJobNano=def && def->GetId()==groupNano;
        ai->LOG("[CommanderGroup] job_start def=%s nano=%i",def?def->GetDef()->GetName():"unknown",int(groupJobNano));
    }
    return task;
}
void CCommanderController::TaskFinished(IUnitTask* task,bool done) {
    // Every completed/cancelled builder task, not just groupJob, can be the
    // remembered solar/repair/hold job. Clear before task memory is released.
    // O(C) in controlled commanders/decoys at retirement, no per-frame scan.
    for(auto& entry:states) entry.value->work.Retire(task);
    if(task!=groupJob) return;
    groupJob=nullptr; // manager still owns task during this callback
    defenseNext=defenseOfferNext=defenseDecisionNext=0;
    ai->LOG("[CommanderGroup] job_end done=%i nano=%i",int(done),int(groupJobNano));
    if(done) if(auto* upgrade=dynamic_cast<IBuilderTask*>(task);upgrade && upgrade->GetBuildType()==BT::MEXUP
        && upgrade->GetTarget() && upgrade->GetTarget()->IsFinished())
        ai->LOG("[CommanderGroup] mex_upgrade_done target=%i",upgrade->GetTarget()->GetId());
    if(!done || !groupJobEarnsNano) return; // repairs/adoption and cancellations create no nano debt
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!build) return;
    if(groupJobNano) {
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
    CTerrainManager::TerrainPredicate admit=[&](const AIFloat3& p) {
        return coverage.Allows({p.x,p.z})
            && GroupBuildSiteAllowed(unit,def,p) && GroupLaneWorkAllowed(unit,def,p)
            && p.SqDistance2D(center)<=SQUARE(cfg->group.radius)
            && ai->GetThreatMap()->GetThreatAt(unit,p)<=cfg->front.threat
            && ai->GetTerrainManager()->CanReachAtSafe2(unit,p,unit->GetCircuitDef()->GetBuildDistance());
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
    if(!OnMap(at)) return nullptr;
    if(defenseSlot>=0) {
        const auto& rule=defenseRules[defenseSlot];
        const auto& facts=DefenseFactsFor(def);
        if(facts.coverage>0 && at.SqDistance2D(center)>SQUARE(facts.coverage)) return nullptr;
        // Check actual range/trajectory only on a returned site, not on every
        // terrain-search cell. Five proposal sites bound the expensive work.
        const auto capacity=DefenseCapacity(def,rule,&at);
        if(!surplus && defense::Marginal(defenseDemand,defenseActive,defensePending,capacity,rule,def->GetCostM())<=0) return nullptr;
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
    if(trace && groupJob && groupJob!=build && ai->GetLastFrame()%30<3) {
        auto* other=dynamic_cast<IBuilderTask*>(groupJob);
        auto* otherDef=other?other->GetBuildDef():nullptr;
        ai->LOG("[CommanderGroup] retain_started unit=%i target=%i def=%s other=%s",unit->GetId(),build->GetTarget()->GetId(),build->GetBuildDef()->GetDef()->GetName(),otherDef?otherDef->GetDef()->GetName():"repair");
    }
    return build;
}
IUnitTask* CCommanderController::GroupAssist(CCircuitUnit* unit) {
    if(auto* started=StartedCommanderConstruction(unit)) return started;
    if(!groupJob) return GroupWork(unit);
    if(HealthRetreat(unit) || EnergyRetreat(unit) || groupJob->IsDead()
        || !GroupTaskFunded(groupJob) || !CanResumeFrontTask(unit,groupJob)) return nullptr;
    if(unit->GetTask()==groupJob) return groupJob;
    auto* task=groupJob;
    if(auto* repair=dynamic_cast<IRepairTask*>(task)) {
        auto* target=ai->GetTeamUnit(repair->GetTargetId());
        if(!target) return nullptr;
        task=ai->GetBuilderManager()->EnqueueRepairFor(target,60*FRAMES_PER_SEC,unit);
    }
    if(!task) return nullptr;
    if(!task->CanAssignTo(unit)) {
        if(groupJob->GetAssignees().empty() || ai->GetLastFrame()>=groupProjectUntil) return nullptr;
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
IUnitTask* CCommanderController::GroupLocalMaintenance(CCircuitUnit* unit,CCircuitUnit* anchor) {
    // Fixed roster, anchor first; never scan unrelated builders or base queues.
    for(int id:{anchor->GetId(),groupUnit,groupMembers[0],groupMembers[1],groupMembers[2],groupMembers[5]}) {
        auto* worker=ai->GetTeamUnit(id);
        if(!worker || worker==unit) continue;
        auto* project=worker->GetTask();
        auto* build=dynamic_cast<IBuilderTask*>(project);
        if(build && build->GetBuildDef() && !project->IsExternalControlled()
            && !project->IsEnemyReclaim() && GroupProjectAllowed(unit,project) && project->CanAssignTo(unit))
        {
            ai->LOG("[CommanderGroup] assist_adopt unit=%i anchor=%i def=%s",unit->GetId(),worker->GetId(),build->GetBuildDef()->GetDef()->GetName());
            return TrackGroupJob(project,false);
        }
    }
    const int frame=ai->GetLastFrame();
    if(frame<groupMaintenanceNext) return nullptr;
    groupMaintenanceNext=frame+FRAMES_PER_SEC;
    // One bounded-area query per group/second, not per seat. Only within build
    // reach; no repair excursion or unrestricted GUARD. Wrapper IDs are local.
    const auto here=unit->GetPos(frame);
    const float reach=std::max(0.f,unit->GetCircuitDef()->GetBuildDistance()-32.f);
    // Own the small result across EnqueueRepairFor/TaskAdded callbacks, which
    // may reuse the engine wrapper's query buffer.
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(here,reach,false);
    for(int id:ids) {
        auto* target=ai->GetFriendlyUnit(id);
        if(!target || !target->GetCircuitDef()) continue;
        auto* native=target->GetUnit();
        if(!commander::UsefulGroupRepair(id==unit->GetId(),target->GetCircuitDef()->IsMobile(),
            IsGroupMember(id) || id==anchor->GetId(),native->IsBeingBuilt(),native->GetHealth(),native->GetMaxHealth())) continue;
        const auto at=target->GetPos(frame);
        if(!GroupSiteAllowed(unit,at) || !ai->GetBattle()->LaneWorkAllowed(at)
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
IUnitTask* CCommanderController::GroupWork(CCircuitUnit* unit) {
    if(!unit || !role.frontDuty || (!IsGroupMember(unit->GetId()) && !Handles(unit)) || !unit->IsFinished()) return nullptr;
    auto* current=unit->GetTask();
    if(control::SuspensionOf(unit,ai->GetLastFrame())!=control::Suspension::NONE) return current;
    if(current && (current->IsExternalControlled() || current->IsEnemyReclaim()
        || current->GetType()==IUnitTask::Type::PLAYER || current->GetType()==IUnitTask::Type::RETREAT)) return current;
    if(auto* started=StartedCommanderConstruction(unit)) return started;
    auto* anchor=GroupCommander();
    if(!anchor) return current;
    const int frame=ai->GetLastFrame();
    const auto center=anchor->GetPos(frame);
    const bool builder=unit->GetCircuitDef()->IsBuilder();
    const bool nearby=unit->GetPos(frame).SqDistance2D(center)<=SQUARE(cfg->group.radius);
    if(builder && groupJob && GroupProjectAllowed(unit,groupJob)) {
        // Retention is checked before the worker proximity gate. A constructor
        // travelling to its reserved site must not bounce back into follow.
        if(current==groupJob) return current;
        if(nearby && groupJob->CanAssignTo(unit)) return groupJob;
    }
    if(builder && nearby && !groupJob && Handles(unit)) {
        if(auto* state=states.Find(unit->GetId()))
            if(auto* task=ExpansionMexWork(unit,*state,ai->GetCircuitDefSafe(int(cfg->front.lineDef)),frame))
                return TrackGroupJob(task);
    }
    if(builder && nearby && !groupJob) {
        if(auto* task=GroupPlannedDefense(unit,anchor,frame)) return task;
        if(groupNanoDue) {
            // Obligations survive anchor/worker losses. Complete locally before
            // opening another project; a retreat may temporarily defer work.
            const auto site=groupNanoSite.SqDistance2D(center)<=SQUARE(cfg->group.radius)?groupNanoSite:center;
            if(auto* task=GroupBuild(unit,ai->GetCircuitDefSafe(groupNano),site,true)) return TrackGroupJob(task);
        } else if(GroupNearCombat(anchor)) {
            if(auto* task=GroupConstruction(unit,anchor,frame)) return task;
        }
    }
    if(builder && nearby && !groupJob && !groupNanoDue) {
        if(auto* task=GroupUpgradeMex(unit,anchor)) return task;
        if(cfg->group.maintenance>0) if(auto* task=GroupLocalMaintenance(unit,anchor)) return task;
    }
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
    if(anchor && groupJob && defenseSettings.enabled>0) {
        auto* build=dynamic_cast<IBuilderTask*>(groupJob);
        if(build && build->GetBuildDef() && (build->GetBuildDef()->GetShieldRadius()>0
            || defenseDemand[defense::PLASMA].health>0)) AssessGroupDefense(anchor,frame);
    }
    // A moving anchor can invalidate a site after its last worker yields.
    // Retire that orphan instead of letting it block the one shared job slot.
    if(anchor && groupJob && groupJob->GetAssignees().empty() && !GroupProjectAllowed(anchor,groupJob)) {
        if(std::getenv("CIRCUIT_COMMANDER_TRACE")) ai->LOG("[CommanderGroup] orphan_project_rejected");
        groupJob->GetManager()->AbortTask(groupJob); // dequeue clears borrowed identity
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
