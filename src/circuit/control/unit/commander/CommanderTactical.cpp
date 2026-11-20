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
#include <string>

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
// Owner 2026-11-19: block launcher sites tried before the block is abandoned, the step outward per ring of
// five sites, and how long an abandoned block's definition waits before a new block is reserved.
constexpr int BLOCK_LAUNCHER_TRIES=20;
constexpr float BLOCK_LAUNCHER_STEP=64.f;
constexpr int BLOCK_ABANDON_SECONDS=120;
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
// Launchers under the D-475 gate first, then T2 artillery, then a T1 gun only
// for a planned target (D-495, CommanderArtilleryT1.cpp). At most a dozen defs.
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
    // D-495: the T1 gun is past the profile's veto (IsCapAvailable, not
    // IsAvailable) only through its plan: a justified target and a site in reach.
    if(cfg->group.artilleryT1Income>0 && income>=cfg->group.artilleryT1Income)
        if(const auto* plan=ArtilleryT1Plan(unit))
            if(auto* def=ai->GetCircuitDefSafe(plan->defId); def && unit->GetCircuitDef()->CanBuild(def)
                && def->IsCapAvailable(frame) && ArtilleryEconomy(unit,def) && !ArtilleryCrowded(def)) return def;
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
    if(IsArtilleryT1Def(def)) return ReserveArtilleryT1Site(def,block);  // D-495: one slot at the planned site
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
    const float blockRadius=.5f*std::sqrt(across*across+along*along)+size;
    // Owner 2026-11-20: no block within reach of known enemy porc, seen or ghost (the list CON SAFETY drops
    // constructors by: EconomyManager::RefreshMexPorc, reach = weapon range + porc_margin). Played: a Persecutor
    // slot inside an enemy Persecutor's reach was ordered and dropped by CON SAFETY 145 times in one game.
    // Cost: EnemyPorcClearance is O(known enemy porc) over a list refreshed once a second; at most 15
    // candidates plus one moved-back try per tactical_retry_seconds.
    auto* economy=ai->GetEconomyManager();
    // Rejections by gate, for the log line when nothing fits.
    int offMap=0,tooFar=0,area=0,unreachable=0,grid=0,fill=0,porc=0;
    bool porcSeen=false; commander::Point porcFirst{};
    auto tryAt=[&](const commander::Point& c,float farLimit)->bool {
        AIFloat3 centre=TacticalF(c);
        if(!OnMap(centre)) {++offMap;return false;}
        centre.y=ai->GetMap()->GetElevationAt(centre.x,centre.z);
        if(centre.SqDistance2D(center)>SQUARE(farLimit)) {++tooFar;return false;}
        if(economy->EnemyPorcClearance(centre)<blockRadius) {
            ++porc;
            if(!porcSeen) { porcSeen=true; porcFirst=c; }
            return false;
        }
        if(!terrain->CanReserveArea(centre,facing,across*.5f,along*.5f)) {++area;return false;}
        if(!terrain->CanReachAtSafe(unit,centre,reach+across)) {++unreachable;return false;}
        const auto front=TacticalF(c+axis*(along*.5f));
        const int group=terrain->ReserveGrid(def,front,facing,cols,rows,0);
        if(group<=0) {++grid;return false;}
        if(terrain->GetGroupCount(group,false)<minimum) { terrain->ReleaseGroup(group); ++fill; return false; }
        block.group=group; block.centre=centre;
        block.radius=blockRadius;
        block.axisX=axis.x; block.axisZ=axis.z; block.across=across; block.along=along;
        block.launcher=0; block.launcherTries=0; block.launcherStood=false; block.launcherSite=AIFloat3(-1.f,0.f,-1.f); block.launcherTask=nullptr;
        ai->LOG("[CommanderGroup] tactical_block group=%i slots=%i def=%s at=%.0f,%.0f facing=%i",group,
            terrain->GetGroupCount(group,false),def->GetDef()->GetName(),centre.x,centre.z,facing);
        return true;
    };
    const float farLimit=cfg->group.radius+along*TACTICAL_BACK_ROWS;
    for(int i=0;i<TACTICAL_BACK_ROWS*TACTICAL_SIDE_STEPS;++i) {
        const float back=float(i/TACTICAL_SIDE_STEPS),across1=TACTICAL_SIDE[i%TACTICAL_SIDE_STEPS];
        const auto c=TacticalP(center)-axis*(cfg->group.tacticalRear+along*(.5f+back))+side*(across*across1);
        if(tryAt(c,farLimit)) return true;
    }
    // Owner 2026-11-20: every candidate in porc reach -> relocate backwards: the first one pushed straight out of
    // the porc discs (away from the deepest porc) by the block's radius, once. It may lie past the usual rows;
    // the block is released again if the commander stays out of group range of it.
    if(porcSeen) {
        AIFloat3 out;
        if(economy->PorcEscapePoint(nullptr,TacticalF(porcFirst),blockRadius,out)) {
            const commander::Point moved=TacticalP(out);
            if(tryAt(moved,farLimit+2.f*blockRadius)) {
                ai->LOG("[CommanderGroup] tactical_block moved_back def=%s from=%.0f,%.0f to=%.0f,%.0f porc=%i",
                    def->GetDef()->GetName(),TacticalF(porcFirst).x,TacticalF(porcFirst).z,out.x,out.z,porc);
                return true;
            }
        }
    }
    ai->LOG("[CommanderGroup] tactical_block none def=%s near=%.0f,%.0f facing=%i off_map=%i far=%i area=%i reach=%i grid=%i fill=%i porc=%i",
        def->GetDef()->GetName(),center.x,center.z,facing,offMap,tooFar,area,unreachable,grid,fill,porc);
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
    if(!IsGroupMember(unit->GetId())) return false;
    if(TacticalChoice(unit)==nullptr) {
        auto* commander=GroupCommander();
        if(!commander || !BlockLauncherDef(unit) || DueBlockLauncher(commander->GetPos(ai->GetLastFrame()))<0) return false;
    }
    if(live && !tacticalJob->GetAssignees().empty()) return false;  // one constructor holds the split
    auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
    return !(build && IsExpansionJob(build) && build->GetTarget());
}
IUnitTask* CCommanderController::GroupTacticalWork(CCircuitUnit* unit,CCircuitUnit* anchor,bool nearby) {
    // D-476/D-479: any group constructor, for whatever TacticalChoice allows it.
    const int id=unit->GetId();
    CheckArtilleryT1Job(ai->GetLastFrame());  // D-495: INV-268
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
    // Owner 2026-11-19: a block's due launcher first, whatever TacticalChoice would pick (headless v2: 5 blocks
    // stayed at 2 guns for 9-20 min while the group never chose that gun type again).
    if(BlockLauncherDef(unit)) {
        const int due=DueBlockLauncher(anchor->GetPos(frame));
        if(due>=0) if(CCircuitDef* heavy=ai->GetCircuitDefSafe(due))
            if(auto* launcherTask=BlockLauncherWork(unit,anchor,heavy,tacticalBlocks[due],frame)) return launcherTask;
    }
    CCircuitDef* def=TacticalChoice(unit);
    if(!def) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* terrain=ai->GetTerrainManager();
    const auto center=anchor->GetPos(frame);
    auto& block=tacticalBlocks[def->GetId()];
    // A block the commander left behind is released (its unbuilt slots only
    // matter while the group is there); a full block gives way to a new one.
    // D-495: a T1 gun's slot also gives way when its plan moved elsewhere.
    const bool t1Moved=IsArtilleryT1Def(def) && block.group>0
        && (t1Plan.defId!=def->GetId() || block.centre.SqDistance2D(t1Plan.site)>SQUARE(block.radius));
    if(block.group>0 && (t1Moved || block.centre.SqDistance2D(center)>SQUARE(cfg->group.radius+block.radius)
        || terrain->GetGroupCount(block.group,true)<=0)) {
        // An unfinished turret in the old block is finished first.
        if(auto* frameUnit=builder->FindUnfinishedNear(block.centre,block.radius,def); frameUnit && !FrameInPorc(frameUnit,frame)) {
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
    if(block.group<=0 && frame<block.abandonUntil) return nullptr;  // owner 2026-11-19: an abandoned block cools down
    if(block.group<=0 && !ReserveTacticalBlock(unit,anchor,def,frame)) return nullptr;
    // Owner 2026-11-13: two T2 artillery up -> the launcher flush beside / behind the block, then more artillery
    if(IsArtilleryDef(def) && !IsArtilleryT1Def(def) && block.launcher<2) {
        if(auto* launcherTask=BlockLauncherWork(unit,anchor,def,block,frame)) return launcherTask;
        if(block.launcher==1) return nullptr;
    }
    // Owner 2026-11-19 (Scylla, AI 15 kept filling Persecutor blocks with no Catalyst up), reworked the same
    // evening (a Paralyzer/Catalyst stood alone at the block edge with no guns): while this team has no
    // finished EMP launcher (armemp, cortron, legperdition) standing, a block gets two guns first, its own
    // launcher once those two are finished (BlockLauncherWork above), and no further gun until a launcher
    // stands. A block launcher that stood and has died is ordered again.
    // A block whose launcher could not be placed after BLOCK_LAUNCHER_TRIES sites is abandoned (BlockAbandon):
    // no more guns there, even with a launcher standing elsewhere.
    if(IsArtilleryDef(def) && !IsArtilleryT1Def(def) && block.launcher==2 && !block.launcherStood) {
        BlockAbandon(def,block,frame);
        return nullptr;
    }
    if(IsArtilleryDef(def) && !IsArtilleryT1Def(def) && !TeamEmpLauncherStanding()) {
        if(block.launcher==2 && block.launcherStood) {
            block.launcher=0; block.launcherStood=false; ++block.launcherTries;
            ai->LOG("[CommanderGroup] block_launcher lost block=%i tries=%i",block.group,block.launcherTries);
            if(auto* launcherTask=BlockLauncherWork(unit,anchor,def,block,frame)) return launcherTask;
            if(block.launcher==2 && !block.launcherStood) { BlockAbandon(def,block,frame); return nullptr; }
        }
        const int started=BlockArtilleryBuilt(block,true);
        if(started>=2) {
            // Both first guns placed but not both finished, and no job on them: finish the frame.
            if(BlockArtilleryBuilt(block)<2) {
                if(auto* frameUnit=builder->FindUnfinishedNear(block.centre,block.radius,def); frameUnit && !FrameInPorc(frameUnit,frame)) {
                    auto* repair=builder->EnqueueRepairFor(frameUnit,int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC),unit);
                    if(repair && TacticalJobAllowed(unit,repair,anchor) && (unit->GetTask()==repair || repair->CanAssignTo(unit))) {
                        tacticalJob=repair;
                        ai->LOG("[CommanderGroup] job_start queue=tactical def=%s repair=%i team=%i",def->GetDef()->GetName(),
                            frameUnit->GetId(),ai->GetTeamId());
                        return repair;
                    }
                    if(repair) builder->DiscardUnusedTask(repair);
                }
            }
            if(frame>=empGateLog+30*FRAMES_PER_SEC) {
                empGateLog=frame;
                ai->LOG("[CommanderGroup] block_gun held def=%s block=%i guns=%i launcher=%i tries=%i: no finished EMP launcher standing team=%i",
                    def->GetDef()->GetName(),block.group,started,block.launcher,block.launcherTries,ai->GetTeamId());
            }
            return nullptr;
        }
        // fewer than two guns placed: falls through to one of the block's first two guns
    }
    const int slot=terrain->NextSlotAny(block.group,unit->GetPos(frame));
    if(slot<0) return nullptr;
    // Owner 2026-11-20: a slot inside known enemy porc reach (seen or ghost) gets no order: CON SAFETY would
    // drop it on the way and the next call would order the same slot again. The block is released, so the next
    // reservation (ReserveTacticalBlock) finds one further back, outside every porc's reach.
    if(ai->GetEconomyManager()->EnemyPorcClearance(terrain->GetReservationPos(slot))<0.f) {
        const auto at=terrain->GetReservationPos(slot);
        ai->LOG("[CommanderGroup] tactical_block porc_release def=%s block=%i slot=%i at=%.0f,%.0f team=%i",
            def->GetDef()->GetName(),block.group,slot,at.x,at.z,ai->GetTeamId());
        terrain->ReleaseGroup(block.group);
        block.group=0; block.launcher=0; block.launcherTries=0; block.launcherStood=false; block.launcherTask=nullptr;
        return nullptr;
    }
    // A builder task aborts at once, silently, when the walk to its site is not
    // safe at the builder's power (IBuilderTask::UpdatePath). Played (artillery-b19,
    // the owner's game on b18): a job per seat per second was made and dropped
    // in the same frame, 37 of 45 artillery jobs. Do not start one it would drop.
    if(!terrain->CanReachAtSafe(unit,terrain->GetReservationPos(slot),unit->GetCircuitDef()->GetBuildDistance(),
        unit->GetCircuitDef()->GetPower())) return nullptr;
    const auto order=TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,def,terrain->GetReservationPos(slot),
        0.f,true,int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC));
    const bool t1=IsArtilleryT1Def(def);
    auto* task=t1?builder->EnqueueVetoed(order):builder->Enqueue(order);  // D-495: only a planned T1 gun passes the veto
    if(!task) return nullptr;
    if(!task->PinReservation(slot)) { builder->AbortTask(task); return nullptr; }
    tacticalJob=task;
    t1Job=t1?task:nullptr;
    if(t1) { t1JobTarget=t1Plan.target; t1JobRange=def->GetMaxRange(); t1JobChecked=false; }
    const auto at=terrain->GetReservationPos(slot);
    ai->LOG("[CommanderGroup] job_start queue=tactical def=%s slot=%i x=%.0f z=%.0f unit=%i team=%i",
        def->GetDef()->GetName(),slot,at.x,at.z,id,ai->GetTeamId());
    return task;
}

/*
 * Owner 2026-11-13: "drop that faction's tactical missile launcher flush adjacent to the block (to side or
 * behind) after 2 t2 eviscerators (etc) are built and before more are built in that block." Armada Paralyzer,
 * Cortex Catalyst, Legion Perdition (the builder's own faction first, else any it can build). Sites, in order:
 * the block's left side, right side, back (each centred, the launcher's edge on the block's edge), then the
 * same 32 elmos further out. An order that ends with no launcher there tries the next site; after four the
 * block is left to its artillery. Cost: two friendly-unit radius queries per call while the launcher is due.
 */
int CCommanderController::BlockArtilleryBuilt(const TacticalBlock& block,bool frames) const {
    auto* clb=ai->GetCallback();
    const int team=ai->GetTeamId();
    int built=0;
    auto& units=clb->GetFriendlyUnitsIn(block.centre,block.radius);
    for(springai::Unit* u:units) {
        if(u && u->GetTeam()==team && (frames || !u->IsBeingBuilt())) {
            const CCircuitDef* d=ai->GetCircuitDefSafe(clb->Unit_GetDefId(u->GetUnitId()));
            if(d && IsArtilleryDef(d) && !IsArtilleryT1Def(d)) ++built;
        }
        delete u;
    }
    return built;
}
bool CCommanderController::BlockLauncherNear(const AIFloat3& site,const CCircuitDef* def) const {
    auto* clb=ai->GetCallback();
    const int team=ai->GetTeamId();
    bool found=false;
    auto& units=clb->GetFriendlyUnitsIn(site,128.f);  // 64 missed launchers the engine placed a step off the site
    for(springai::Unit* u:units) {
        if(u && !found && u->GetTeam()==team && def && !u->IsBeingBuilt() && clb->Unit_GetDefId(u->GetUnitId())==def->GetId()) found=true;  // finished only (owner 2026-11-19)
        delete u;
    }
    return found;
}
void CCommanderController::BlockAbandon(CCircuitDef* def,TacticalBlock& block,int frame) {
    ai->LOG("[CommanderGroup] block_abandoned def=%s block=%i guns=%i tries=%i team=%i: no launcher placed",
        def->GetDef()->GetName(),block.group,BlockArtilleryBuilt(block,true),block.launcherTries,ai->GetTeamId());
    ai->GetTerrainManager()->ReleaseGroup(block.group);
    block.group=0; block.launcher=0; block.launcherTries=0; block.launcherStood=false; block.launcherTask=nullptr;
    block.abandonUntil=frame+BLOCK_ABANDON_SECONDS*FRAMES_PER_SEC;
}
// Owner 2026-11-20: an unfinished gun frame inside known enemy porc reach is not repaired (CON SAFETY drops it).
bool CCommanderController::FrameInPorc(CCircuitUnit* frameUnit,int frame) const {
    return ai->GetEconomyManager()->EnemyPorcClearance(frameUnit->GetPos(frame))<0.f;
}
int CCommanderController::DueBlockLauncher(const AIFloat3& pos) const {
    for(const auto& kv:tacticalBlocks) {
        const TacticalBlock& b=kv.second;
        if(b.group<=0 || b.launcher!=0) continue;
        const CCircuitDef* d=ai->GetCircuitDefSafe(kv.first);
        if(!d || !IsArtilleryDef(d) || IsArtilleryT1Def(d)) continue;
        if(b.centre.SqDistance2D(pos)>SQUARE(cfg->group.radius+b.radius)) continue;
        if(BlockArtilleryBuilt(b)>=2) return kv.first;
    }
    return -1;
}
bool CCommanderController::TeamEmpLauncherStanding() const {
    const int frame=ai->GetLastFrame();
    if(frame==empStandFrame) return empStand;
    empStandFrame=frame; empStand=false;
    static const char* names[3]={"armemp","cortron","legperdition"};
    int ids[3]={-1,-1,-1};
    for(int i=0;i<3;++i) if(CCircuitDef* d=ai->GetCircuitDef(names[i])) ids[i]=d->GetId();
    for(const auto& kv:ai->GetTeamUnits()) {
        const CCircuitUnit* u=kv.second;
        if(!u || u->IsDead() || !u->IsFinished()) continue;
        const int id=u->GetCircuitDef()->GetId();
        if(id==ids[0] || id==ids[1] || id==ids[2]) { empStand=true; break; }
    }
    return empStand;
}
CCircuitDef* CCommanderController::BlockLauncherDef(CCircuitUnit* unit) const {
    static const char* names[3]={"armemp","cortron","legperdition"};
    const int frame=ai->GetLastFrame();
    const std::string own=std::string(unit->GetCircuitDef()->GetDef()->GetName()).substr(0,3);
    CCircuitDef* other=nullptr;
    for(const char* name:names) {
        CCircuitDef* d=ai->GetCircuitDef(name);
        if(!d || !unit->GetCircuitDef()->CanBuild(d) || !d->IsAvailable(frame)) continue;
        if(std::string(name).substr(0,3)==own) return d;
        if(!other) other=d;
    }
    return other;
}
IUnitTask* CCommanderController::BlockLauncherWork(CCircuitUnit* unit,CCircuitUnit* anchor,CCircuitDef* def,TacticalBlock& block,int frame,bool first) {
    if(block.launcher>=2) return nullptr;
    CCircuitDef* ldef=BlockLauncherDef(unit);
    if(block.launcher==1) {
        if(ldef && BlockLauncherNear(block.launcherSite,ldef)) {
            block.launcher=2; block.launcherStood=true;
            ai->LOG("[CommanderGroup] block_launcher standing def=%s at=%.0f,%.0f block=%i",ldef->GetDef()->GetName(),
                block.launcherSite.x,block.launcherSite.z,block.group);
            return nullptr;
        }
        if(tacticalJob && !tacticalJob->IsDead()) return nullptr;
        block.launcher=0;
        if(++block.launcherTries>=BLOCK_LAUNCHER_TRIES) {
            block.launcher=2;
            ai->LOG("[CommanderGroup] block_launcher given_up block=%i tries=%i",block.group,block.launcherTries);
            return nullptr;
        }
    }
    if(!first && BlockArtilleryBuilt(block)<2) return nullptr;
    if(!ldef) {
        // A launcher of this team standing elsewhere (the unit cap makes none buildable) covers the block.
        // With none standing, this builder (a seat that cannot make the launcher, or the cap) only waits:
        // another group constructor may build it (headless 11-19: two blocks were abandoned at once here).
        const bool covered=TeamEmpLauncherStanding();
        if(covered) { block.launcher=2; block.launcherStood=true; }
        if(frame>=empGateLog+30*FRAMES_PER_SEC) {
            empGateLog=frame;
            ai->LOG("[CommanderGroup] block_launcher none_buildable block=%i covered=%i unit=%s",block.group,int(covered),
                unit->GetCircuitDef()->GetDef()->GetName());
        }
        return nullptr;
    }
    auto* terrain=ai->GetTerrainManager();
    auto* builder=ai->GetBuilderManager();
    const float ls=float(std::max(ldef->GetDef()->GetXSize(),ldef->GetDef()->GetZSize()))*SQUARE_SIZE;
    const float ax=block.axisX,az=block.axisZ,sx=-az,sz=ax;   // side = (-axis.z, axis.x)
    const float sideOff=.5f*block.across+.5f*ls,backOff=.5f*block.along+.5f*ls;
    // Owner 2026-11-19: sites go round left, right, back, back-left, back-right of the block, each ring
    // BLOCK_LAUNCHER_STEP elmos further out than the last, so failed orders keep moving the launcher away.
    const float dirs[5][2]={{sx,sz},{-sx,-sz},{-ax,-az},{sx-ax,sz-az},{-sx-ax,-sz-az}};
    const float offs[5]={sideOff,sideOff,backOff,std::max(sideOff,backOff),std::max(sideOff,backOff)};
    for(int k=block.launcherTries;k<BLOCK_LAUNCHER_TRIES;++k) {
        const int d=k%5;
        const float ring=float(k/5)*BLOCK_LAUNCHER_STEP;
        const float len=(d>=3)?std::sqrt(2.f):1.f;
        const float off=offs[d]+ring;
        AIFloat3 site(block.centre.x+dirs[d][0]/len*off,0.f,block.centre.z+dirs[d][1]/len*off);
        if(!OnMap(site)) continue;
        site.y=ai->GetMap()->GetElevationAt(site.x,site.z);
        if(ai->GetEconomyManager()->EnemyPorcClearance(site)<.5f*ls) continue;  // owner 2026-11-20: not in porc reach
        if(!terrain->CanBeBuiltAt(ldef,site) || !terrain->CanReachAtSafe(unit,site,unit->GetCircuitDef()->GetBuildDistance(),
            unit->GetCircuitDef()->GetPower())) continue;
        auto* task=builder->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,ldef,site,0.f,true,
            int(cfg->group.tacticalOrderSeconds*FRAMES_PER_SEC)));
        if(!task) continue;
        tacticalJob=task;
        block.launcher=1; block.launcherSite=site; block.launcherTries=k; block.launcherTask=task;
        ai->LOG("[CommanderGroup] block_launcher order def=%s at=%.0f,%.0f side=%s try=%i block=%i artillery=%s unit=%i team=%i",
            ldef->GetDef()->GetName(),site.x,site.z,d==2?"back":d==0?"left":d==1?"right":d==3?"back_left":"back_right",k,block.group,def->GetDef()->GetName(),
            unit->GetId(),ai->GetTeamId());
        return task;
    }
    block.launcher=2;
    ai->LOG("[CommanderGroup] block_launcher no_site def=%s block=%i at=%.0f,%.0f",ldef->GetDef()->GetName(),block.group,
        block.centre.x,block.centre.z);
    return nullptr;
}

} // namespace circuit
