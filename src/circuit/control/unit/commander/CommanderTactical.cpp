/*
 * CommanderTactical.cpp
 *
 * The commander group's tactical queue (D-475, D-476, D-479): launchers and static artillery in a reserved block behind the commander. Split from CommanderGroup.cpp (D-485).
 */

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
    if(!def) return false;
    const int id=def->GetId();
    for(const auto* defs:{&tacticalDefs,&artilleryT2Defs,&artilleryT1Defs})
        if(std::find(defs->begin(),defs->end(),id)!=defs->end()) return true;
    return false;
}
float CCommanderController::TacticalBlockRadius(const CCircuitDef* def) const {
    if(!def) return 0.f;
    const auto it=tacticalBlocks.find(def->GetId());
    return (it!=tacticalBlocks.end() && it->second.group>0)?it->second.radius:0.f;
}
bool CCommanderController::OnTacticalBlock(const CCircuitDef* def,const AIFloat3& site) const {
    if(!def || !IsTacticalDef(def)) return false;
    const auto it=tacticalBlocks.find(def->GetId());
    return it!=tacticalBlocks.end() && it->second.group>0 && site.SqDistance2D(it->second.centre)<=SQUARE(it->second.radius);
}
// D-479: static artillery may start when the metal is floating and the energy
// carries it. The draw is this builder's own rate on the turret: energy cost
// over (build time / its build power).
bool CCommanderController::ArtilleryEconomy(CCircuitUnit* unit,CCircuitDef* def) const {
    auto* eco=ai->GetEconomyManager();
    const float spare=eco->GetAvgMetalIncome()-eco->GetMetalPullCor();
    const float store=std::max(1.f,eco->GetMetalStore());
    const bool floating=eco->GetMetalCur()>=cfg->group.artilleryBank*store || spare>=cfg->group.artillerySpare;
    if(!floating || eco->IsEnergyStalling() || eco->GetEnergyCur()<cfg->group.artilleryEnergy*eco->GetEnergyStore()) return false;
    if(cfg->group.artilleryEnergyCover>0) {
        const float seconds=def->GetBuildTime()/std::max(1.f,unit->GetWorkerTime());
        const float draw=def->GetCostE()/std::max(1.f,seconds);
        if(eco->GetAvgEnergyIncome()-eco->GetEnergyPullCor()<draw) return false;
    }
    return true;
}
// D-479: what this constructor would build on the tactical queue now, or null.
// Launchers under the D-475 gate first, then T2 artillery, then the T1 fallback
// (below the T2 income, or no T2 seat in the group). At most a dozen defs.
CCircuitDef* CCommanderController::TacticalChoice(CCircuitUnit* unit) const {
    const int frame=ai->GetLastFrame();
    const auto buildable=[&](int id) -> CCircuitDef* {
        auto* def=ai->GetCircuitDefSafe(id);
        return (def && unit->GetCircuitDef()->CanBuild(def) && def->IsAvailable(frame))?def:nullptr;
    };
    if(cfg->group.tacticalT2>0 && GroupT2Count()>=int(cfg->group.tacticalT2) && TacticalEconomy())
        for(int id:tacticalDefs) if(auto* def=buildable(id)) return def;
    const float income=ai->GetEconomyManager()->GetAvgMetalIncome();
    if(cfg->group.artilleryT2Income>0 && income>=cfg->group.artilleryT2Income)
        for(int id:artilleryT2Defs) if(auto* def=buildable(id)) { if(ArtilleryEconomy(unit,def) && !ArtilleryCrowded(def)) return def; break; }
    if(cfg->group.artilleryT1Income>0 && income>=cfg->group.artilleryT1Income
        && (income<cfg->group.artilleryT2Income || cfg->group.artilleryT2Income<=0 || GroupT2Count()==0))
        for(int id:artilleryT1Defs) if(auto* def=buildable(id)) { if(ArtilleryEconomy(unit,def) && !ArtilleryCrowded(def)) return def; break; }
    return nullptr;
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
    auto& block=tacticalBlocks[def->GetId()];
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
        block.group=group; block.centre=centre;
        block.radius=.5f*std::sqrt(across*across+along*along)+size;
        ai->LOG("[CommanderGroup] tactical_block group=%i slots=%i def=%s at=%.0f,%.0f facing=%i",group,
            terrain->GetGroupCount(group,false),def->GetDef()->GetName(),centre.x,centre.z,facing);
        return true;
    }
    ai->LOG("[CommanderGroup] tactical_block none def=%s near=%.0f,%.0f facing=%i off_map=%i far=%i area=%i reach=%i grid=%i fill=%i",
        def->GetDef()->GetName(),center.x,center.z,facing,offMap,tooFar,area,unreachable,grid,fill);
    return false;
}
// D-476 (the owner's rule): expansion jobs come first for every group
// constructor, except that one constructor with tactical work it can start
// (TacticalChoice: launchers above tactical_metal, D-479 artillery when the
// metal floats) works the tactical queue while the rest keep porcing
// ("split"). A constructor on a started expansion frame is not taken off it;
// the next free one is. Otherwise tactical work is overflow only (GroupWork's
// last step). Seven seats at most, no scan.
bool CCommanderController::TacticalSplit(CCircuitUnit* unit) const {
    // A constructor on the live tactical job finishes it, whatever the seat
    // count or the bank does meanwhile (played, factory-b12: a T2 seat died, the
    // count fell under tactical_t2 and the half-built launcher was abandoned).
    const bool live=tacticalJob && !tacticalJob->IsDead();
    if(live && unit->GetTask()==tacticalJob && IsGroupMember(unit->GetId())) return true;
    if(!IsGroupMember(unit->GetId()) || TacticalChoice(unit)==nullptr) return false;
    if(live && !tacticalJob->GetAssignees().empty()) return false;  // one constructor holds the split
    auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
    return !(build && IsExpansionJob(build) && build->GetTarget());
}
IUnitTask* CCommanderController::GroupTacticalWork(CCircuitUnit* unit,CCircuitUnit* anchor,bool nearby) {
    // D-476/D-479: any group constructor, for whatever TacticalChoice allows it.
    const int id=unit->GetId();
    // Its own live job first: finished regardless of the opening gates below.
    if(tacticalJob && !tacticalJob->IsDead() && unit->GetTask()==tacticalJob && IsGroupMember(id))
        return TacticalJobAllowed(unit,tacticalJob,anchor)?tacticalJob:nullptr;
    if(!IsGroupMember(id) || !unit->GetCircuitDef()->IsBuilder()) return nullptr;
    const int frame=ai->GetLastFrame();
    if(tacticalJob && !tacticalJob->IsDead()) {
        if(nearby && TacticalJobAllowed(unit,tacticalJob,anchor) && tacticalJob->CanAssignTo(unit)) return tacticalJob;
        return nullptr;
    }
    if(!nearby || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    CCircuitDef* def=TacticalChoice(unit);
    if(!def) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* terrain=ai->GetTerrainManager();
    const auto center=anchor->GetPos(frame);
    auto& block=tacticalBlocks[def->GetId()];
    // A block the commander left behind is released (its unbuilt slots only
    // matter while the group is there); a full block gives way to a new one.
    if(block.group>0 && (block.centre.SqDistance2D(center)>SQUARE(cfg->group.radius+block.radius)
        || terrain->GetGroupCount(block.group,true)<=0)) {
        // An unfinished turret in the old block is finished first.
        if(auto* frameUnit=builder->FindUnfinishedNear(block.centre,block.radius,def)) {
            auto* repair=builder->EnqueueRepairFor(frameUnit,int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC),unit);
            if(repair && TacticalJobAllowed(unit,repair,anchor) && (unit->GetTask()==repair || repair->CanAssignTo(unit))) {
                tacticalJob=repair;
                ai->LOG("[CommanderGroup] job_start queue=tactical def=%s repair=%i team=%i",def->GetDef()->GetName(),frameUnit->GetId(),ai->GetTeamId());
                return repair;
            }
            if(repair) builder->DiscardUnusedTask(repair);
        }
        terrain->ReleaseGroup(block.group);
        block.group=0;
    }
    if(block.group<=0 && !ReserveTacticalBlock(unit,anchor,def,frame)) return nullptr;
    const int slot=terrain->NextSlotAny(block.group,unit->GetPos(frame));
    if(slot<0) return nullptr;
    // A builder task aborts at once, silently, when the walk to its site is not
    // safe at the builder's power (IBuilderTask::UpdatePath). Played (artillery-b19,
    // the owner's game on b18): a job per seat per second was made and dropped
    // in the same frame, 37 of 45 artillery jobs. Do not start one it would drop.
    if(!terrain->CanReachAtSafe(unit,terrain->GetReservationPos(slot),unit->GetCircuitDef()->GetBuildDistance(),
        unit->GetCircuitDef()->GetPower())) return nullptr;
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

} // namespace circuit
