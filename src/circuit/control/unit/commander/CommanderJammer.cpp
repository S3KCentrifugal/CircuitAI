#include "control/unit/commander/CommanderController.h"
#include "control/kernel/CommanderFortification.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "control/core/LeaseTask.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/ally/AllyUnit.h"
#include "spring/SpringCallback.h"
#include "spring/SpringUnit.h"
#include "spring/SpringMap.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include "terrain/BattleAnalysis.h"
#include <limits>
#include "task/common/WaitTask.h"
#include "Mod.h"

namespace circuit {
using springai::AIFloat3;
using commander::Point;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }
// KI-756. The engine jams whole cells, so its coverage reaches up to about
// one cell diagonal past the nominal range; the friendly query must include it.
static constexpr float JAM_QUERY_SLACK_CELLS=1.5f;
// A held firing point stays jammed while the commander drifts up to half a
// cell from it (the most JamCells::CoversAround tests exactly).
static constexpr float JAM_FIRING_MARGIN_CELLS=.5f;
// Inward search step along the jammer-to-target ray, in cells.
static constexpr float JAM_FIRING_STEP_CELLS=.5f;
// Footprint room beyond the commander's radius for the preferred point.
static constexpr float JAM_FIRING_COMFORT=16.f;

void CCommanderController::InitJammerRadii() {
    // UnitDef radii are immutable for this AI lifetime. Cache only metadata;
    // membership/activation is deliberately fresh on damage as well as ticks.
    // One bounded spatial query, O(local allies), no whole-army sensor census.
    if(maxJammerRadius<0) {
        maxJammerRadius=0;
        // CircuitDefs stores N entries, but engine IDs are 1..N.
        jammerRadii.resize(ai->GetCircuitDefs().size()+1,0.f);
        for(auto& def:ai->GetCircuitDefs()) if(def.GetDef()) {
            const float radius=def.GetDef()->GetJammerRadius();
            jammerRadii[def.GetId()]=radius;
            maxJammerRadius=std::max(maxJammerRadius,radius);
        }
        // KI-756: the radar mip level is fixed for the game; read it once.
        springai::Mod* mod=ai->GetCallback()->GetMod();
        const int mipLevel=mod->GetRadarMipLevel();
        delete mod;
        jamCells=commander::JamCells(SQUARE_SIZE,mipLevel,int(maxJammerRadius));
    }
}

commander::JammerPlan CCommanderController::GroupJammerCoverage(CCircuitUnit* unit,CCircuitDef* def,
    const AIFloat3& center,float searchRadius,const IUnitTask* ignore) {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1));
    commander::JammerPlan plan;
    if(!unit || !role.frontDuty || !role.frontReady || !def || (def->GetId()!=groupJammer && def->GetId()!=groupJammer2)
        || (!IsGroupMember(unit->GetId()) && !Handles(unit))) return plan;
    InitJammerRadii();
    plan.enabled=true;plan.radius=jammerRadii[def->GetId()];
    plan.minimumGain=cfg->group.jammerGain;plan.spacing=cfg->group.jammerSpacing;plan.inward=cfg->group.jammerEdge;
    auto* anchor=GroupCommander();
    if(!anchor) return plan;
    const int frame=ai->GetLastFrame();
    const auto anchorPos=anchor->GetPos(frame);
    // Stable demand, not the current mobile jammer location, drives construction.
    // Accepted jobs keep their commitment during movement/revalidation.
    plan.persistent=ignore || jammerDemand.Stable(P(anchorPos),frame,int(cfg->group.jammerHold*FRAMES_PER_SEC),128.f);
    auto* battle=ai->GetBattle();
    if(battle->GetFrontLaneLength()<=0) return plan;
    const float progress=battle->GetFrontLaneProgress(anchorPos);
    const float step=std::min(cfg->group.radius,plan.radius*.65f);
    const auto rear=battle->GetFrontLanePoint(progress-step);
    const auto front=battle->GetFrontLanePoint(progress+step);
    Point axis=P(front)-P(rear);
    const float length=commander::Length(axis);
    axis=length>0?axis*(1.f/length):Point{0,1};
    const Point side{-axis.z,axis.x};
    const float width=std::min(battle->GetFrontLaneWidth()*.5f,plan.radius*.35f);
    plan.probes[0]={P(anchorPos),3,true};
    plan.probes[1]={P(rear),2,true};
    plan.probes[2]={P(front),2,false};
    size_t index=3;
    for(const auto& at:{rear,anchorPos,front}) for(float sign:{-1.f,1.f})
        plan.probes[index++]={P(at)+side*(width*sign),1,false};
    // A committed local structure (or the latest defense awaiting its nano)
    // supplies an actual construction point in addition to the lane samples.
    const auto* project=dynamic_cast<const IBuilderTask*>(FirstExpansionJob());
    const auto work=project?project->GetPosition():groupNanoSite;
    if(OnMap(work) && work.SqDistance2D(anchorPos)<=SQUARE(cfg->group.radius))
        plan.probes[8]={P(work),2,true};
    // Include coverage of every probe AND candidate, not just the proposed center.
    const float radius=maxJammerRadius+searchRadius+cfg->group.radius+plan.radius;
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(center,radius,false);
    const auto* ignoredBuild=dynamic_cast<const IBuilderTask*>(ignore);
    const auto* ignoredTarget=ignoredBuild?ignoredBuild->GetTarget():nullptr;
    for(int id:ids) {
        if(ignoredTarget && ignoredTarget->GetId()==id) continue;
        const int definition=ai->GetCallback()->Unit_GetDefId(id);
        if(definition<=0 || size_t(definition)>=jammerRadii.size() || jammerRadii[definition]<=0) continue;
        auto* ally=ai->GetFriendlyUnit(id);
        if(!ally || ally->GetCircuitDef()->IsMobile()) continue;
        const bool reserved=jammerOutages[id].Reserve(ai->GetUnitAPI()->IsActiveSensor(id),
            ally->GetUnit()->IsBeingBuilt(),definition,frame,int(cfg->group.jammerOutage*FRAMES_PER_SEC));
        const commander::JammerPlan::Disc disc{P(ally->GetPos(frame)),jammerRadii[definition]};
        if(reserved) plan.infrastructure.push_back(disc);
        else plan.unavailable.push_back(disc);
    }
    for(auto it=jammerOutages.begin();it!=jammerOutages.end();)
        if(it->second.seen!=frame) it=jammerOutages.erase(it);else ++it;
    // Own claims exclude the exact retrying task. Other owners' accepted
    // claims use the existing shared spatial ledger and task lifecycle.
    for(auto* task:ai->GetBuilderManager()->GetTasks(IBuilderTask::BuildType::DEFENCE)) {
        auto* definition=task->GetBuildDef();
        if(task==ignore || task->IsDead() || !definition) continue;
        const int id=definition->GetId();
        if(id<=0 || size_t(id)>=jammerRadii.size() || jammerRadii[id]<=0
            || task->GetPosition().SqDistance2D(center)>radius*radius) continue;
        plan.infrastructure.push_back({P(task->GetPosition()),jammerRadii[id]});
    }
    ai->GetAllyTeam()->GetDefenseClaims().Nearby(center.x,center.z,radius,frame,[&](int owner,const defense::Claim& c) {
        if(owner==ai->GetTeamId() || c.def<=0 || size_t(c.def)>=jammerRadii.size() || jammerRadii[c.def]<=0) return;
        plan.infrastructure.push_back({{c.x,c.z},jammerRadii[c.def]});
    });
    plan.Prepare();
    return plan;
}

bool CCommanderController::Jammed(CCircuitUnit* unit) {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1)); // D-388: this unit's preset
    jamZones.clear();
    if(cfg->safety.jamSafe<=0 || !Handles(unit) || EnergyRetreat(unit) || HealthRetreat(unit)) return false;
    InitJammerRadii();
    if(maxJammerRadius<=0 || !jamCells.Valid()) return false;
    const int frame=ai->GetLastFrame();
    const auto pos=unit->GetPos(frame);
    jammerIds=ai->GetCallback()->GetFriendlyUnitIdsIn(pos,
        maxJammerRadius+jamCells.CellSize()*JAM_QUERY_SLACK_CELLS,false);
    for(int id:jammerIds) {
        const int def=ai->GetCallback()->Unit_GetDefId(id);
        if(def<=0 || size_t(def)>=jammerRadii.size() || jammerRadii[def]<=0) continue;
        auto* ally=ai->GetFriendlyUnit(id);
        if(!ally || !ai->GetUnitAPI()->IsActiveSensor(id)) continue;
        // KI-756: the engine's cells, not the nominal disc, decide jamming.
        const auto center=P(ally->GetPos(frame));
        const JamZone zone{center,jammerRadii[def],jamCells.CellOf(center),
            jamCells.Radius(int(jammerRadii[def])),ally->GetCircuitDef()->IsMobile()};
        if(jamCells.Covers(zone.cell,zone.cells,zone.mobile,P(pos))) jamZones.push_back(zone);
    }
    return !jamZones.empty();
}

bool CCommanderController::JamControl(CCircuitUnit* unit,State& s,int frame) {
    // Observe refreshed these zones immediately before this call. No borrowed
    // wrappers survive callbacks; loss, movement, paralysis and toggle-off are
    // evaluated again at the ordinary combat cadence and final shot admission.
    if(jamZones.empty()) return false;
    const auto pos=unit->GetPos(frame);
    auto* task=dynamic_cast<CLeaseTask*>(unit->GetTask());
    const bool wasWithdrawing=s.fallback.active || s.mode==Mode::ESCAPE || s.mode==Mode::RECOVER
        || unit->GetTask()->GetType()==IUnitTask::Type::RETREAT;
    s.fallback.active=false;s.fallback.until=-1;s.conceal.unseenUntil=0;s.fallback.moveUntil=-1;
    if(s.pending>=0) {
        if(unit->GetDGunReloadFrame()>frame || frame-s.pending>30) {
            s.pending=-1;s.leaseUntil=0;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        } else return true;
    }
    auto* def=unit->GetCircuitDef();
    const float range=unit->GetDGunRange()-12;
    const float speed=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
    const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
    commander::Line best;
    Point goal;
    float bestDistance=std::numeric_limits<float>::max();
    // Target scan reuses legal observations. Each candidate has at most one
    // projection per covering jammer; expensive route checks run only for a
    // candidate improving the current choice. Shot geometry remains shared.
    for(const auto& c:contacts) {
        if(c.friendly || c.blocker || c.reserved || !c.targetable
            || !(c.t3 || (c.combatTier==2 && c.cost>=cfg->safety.jamHeavyCost))) continue;
        const auto lead=c.pos+c.velocity*(commander::Length(c.pos-P(pos))/speed);
        auto line=commander::ScoreLine(contacts,P(pos),lead-P(pos),range,speed,width,
            cfg->combat.killReward,cfg->combat.friendlyMargin,c.id);
        if(line.requiredHit && !line.blocked) {
            line.target=c.id; best=line;goal=P(pos);bestDistance=0;break;
        }
        for(const auto& zone:jamZones) {
            // KI-756: a point is held only where the engine's jam cells cover
            // it with half a cell to spare. Prefer room for the footprint;
            // when that loses the shot, search inward from the nominal edge.
            // Live jamming is revalidated at firing time.
            const float margin=jamCells.CellSize()*JAM_FIRING_MARGIN_CELLS;
            const float step=jamCells.CellSize()*JAM_FIRING_STEP_CELLS;
            Point candidate;
            bool found=jamCells.FiringPoint(zone.center,zone.cell,zone.cells,zone.mobile,zone.radius,
                def->GetRadius()+JAM_FIRING_COMFORT,lead,margin,step,candidate);
            if(!found || commander::Length(lead-candidate)>range+c.radius)
                found=jamCells.FiringPoint(zone.center,zone.cell,zone.cells,zone.mobile,zone.radius,
                    0.f,lead,margin,step,candidate);
            if(!found || commander::Length(lead-candidate)>range+c.radius) continue;
            const float distance=commander::Length(candidate-P(pos));
            if(distance>=bestDistance) continue;
            AIFloat3 at(candidate.x,0,candidate.z);
            if(!OnMap(at)) continue;
            at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
            if(at.y<0 || !Route(unit,pos,at)) continue;
            // Both endpoints lie in one jammer's cell circle, which is convex
            // up to a cell. Route validates the straight terrain corridor;
            // re-observation each tick catches a leg that leaves coverage.
            best.target=c.id;best.requiredHit=false;goal=candidate;bestDistance=distance;
        }
    }
    const bool heavyShot=best.target>=0;
    // Keep ordinary in-place D-gun opportunities while jammed too. Heavy
    // interception wins; ordinary groups retain the profile value threshold.
    if(!heavyShot && pos.y>=0 && unit->IsDGunReady(frame,
        ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve))) {
        const float minimum=commander::MinimumValue(cfg->combat.minValue,
            ai->GetMilitaryManager()->GetAggression(),cfg->combat.aggression);
        for(int index:seeds) {
            const auto& c=contacts[index];
            if(std::abs(c.height-pos.y)>range*.5f) continue;
            const auto lead=c.pos+c.velocity*(commander::Length(c.pos-P(pos))/speed);
            auto line=commander::ScoreLine(contacts,P(pos),lead-P(pos),range,speed,width,
                cfg->combat.killReward,cfg->combat.friendlyMargin,c.id);
            if(line.requiredHit && !line.blocked && line.value>=minimum && line.value>best.value) {
                line.target=c.id;best=line;
            }
        }
    }
    if(best.target>=0 && pos.y>=0) {
        if(!task) {
            auto* previous=unit->GetTask();
            task=ai->GetBuilderManager()->EnqueueLease(this,
                previous->GetType()==IUnitTask::Type::RETREAT?nullptr:previous);
            ai->GetBuilderManager()->AssignTask(unit,task);
            if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task);return true; }
            s.started=frame;++operation;
            writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"engage");
        }
        s.deployed=false;
        EndT3(unit,s,frame,"jam_intercept");
        s.budget=def->GetDGunDef()->GetCostE();
        if(best.requiredHit) {
            if(!unit->GetDGunAct() && Fire(unit,s,best,frame,false,heavyShot)) {
                ai->LOG("[CommanderJam] unit=%i target=%i action=fire frame=%i",unit->GetId(),best.target,frame);return true;
            }
            if(!s.route.empty()) { TRY_UNIT(ai,unit,unit->CmdStop();) s.route.clear(); }
        } else {
            AIFloat3 at(goal.x,0,goal.z);at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
            Transition(unit,s,Mode::APPROACH,frame);Move(unit,s,at,frame);
        }
        return true;
    }
    s.budget=0;
    if(wasWithdrawing || (task && !s.deployed)) {
        // Do not restore a saved retreat or leave an old escape MOVE running.
        EndT3(unit,s,frame,"jam_hold");
        Transition(unit,s,Mode::SUPPORT,frame);s.route.clear();
        if(task) task->Handover(unit);
        else if(unit->GetTask()->GetType()==IUnitTask::Type::RETREAT) {
            TRY_UNIT(ai,unit,unit->CmdStop();)
            auto* hold=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(TaskB::Wait(30)));
            hold->SetStationary(true);ai->GetBuilderManager()->AssignTask(unit,hold);
        }
        return true;
    }
    // Productive work and ordinary forward deployment continue; generic
    // withdrawal/intercept policy does not override the explicit jam-safe rule.
    Deploy(unit,s,frame);
    return true;
}
}
