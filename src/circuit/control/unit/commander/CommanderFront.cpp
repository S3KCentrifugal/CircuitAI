#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "control/core/ControlledTask.h"
#include "task/common/WaitTask.h"
#include "unit/CircuitUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "setup/SetupManager.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "map/ThreatMap.h"
#include "terrain/TerrainManager.h"
#include "terrain/BattleAnalysis.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

#include <algorithm>
#include <limits>

namespace circuit {
using springai::AIFloat3;
using BT=IBuilderTask::BuildType;

AIFloat3 CCommanderController::FrontPosition(CCircuitUnit* unit,State& s,int frame) {
    // At most one bounded friendly query per commander/second, reused by the
    // role's task offers. No full friendly army census or per-frame path solve.
    // Positions expire after one second; combat still observes every 3 frames.
    if(frame<s.front.frame+30) return s.front.point;
    s.front.frame=frame;
    s.front.reason=commander::AdvanceReason::ADVANCE;
    auto* battle=ai->GetBattle();
    if(battle->GetFrontLaneLength()>0.f) {
        // D-356: the meta's "com forward until the first riot units appear,
        // then home". Once home, the lane has no front for this commander:
        // the ladder's base rungs (assist, plants) keep it busy at home.
        if(PushHome(unit,s,frame)) { s.front.reason=commander::AdvanceReason::HOME; s.front.pushBound=-1; s.front.pushGoalProgress=-1; return s.front.point={-1,0,-1}; }
        const float length=battle->GetFrontLaneLength();
        const float limit=std::max(0.f,length-cfg->front.standoff);
        const float own=battle->GetFrontLaneProgress(unit->GetPos(frame));
        float advance=std::min(limit,std::min(cfg->front.distance,length*.5f));
        // One existing bounded friendly query; only screens in our assigned
        // corridor advance this commander. Neighbouring lanes cannot pull it.
        // Legacy anchor: any mobile builder or attacker ahead pulls it forward.
        // Push anchor: combat units only are a screen (D-356); builders are not.
        int screens=0; float furthestScreen=-1,furthestAny=-1;
        const auto& ids=ai->GetCallback()->GetFriendlyUnitIdsIn(unit->GetPos(frame),cfg->combat.scan,false);
        for(int id:ids) {
            if(id==unit->GetId())continue;
            auto* def=ai->GetCircuitDefSafe(ai->GetCallback()->Unit_GetDefId(id));
            if(!def || !def->IsMobile() || def->IsAbleToFly() || def->IsRoleComm()
                || (!def->IsBuilder() && !def->IsAttacker()))continue;
            float raw[3]={NAN,NAN,NAN};ai->GetUnitAPI()->GetPosition(id,raw);
            const AIFloat3 p(raw[0],raw[1],raw[2]);
            if(!std::isfinite(p.x) || !std::isfinite(p.z) || battle->GetFrontLaneDistance(p)>battle->GetFrontLaneWidth())continue;
            const float progress=battle->GetFrontLaneProgress(p);
            furthestAny=std::max(furthestAny,progress);
            if(def->IsAttacker()) { ++screens; furthestScreen=std::max(furthestScreen,progress); }
        }
        if(cfg->front.pushAhead>0) {
            const auto push=commander::LanePushAnchor(own,furthestScreen,screens,int(cfg->front.pushScreen),
                cfg->front.pushAhead,cfg->front.distance,limit);
            advance=push.progress;
            s.front.pushScreens=screens; s.front.pushScreenProgress=furthestScreen; s.front.pushBound=push.bound;
        } else if(furthestAny>=0) {
            advance=std::max(advance,std::min(limit,furthestAny-100.f));
            s.front.pushBound=-1;
        }
        // Unscreened pushes may bridge an unreachable coarse sector up to
        // front_distance; screened pushes retain the screen-derived bound.
        float reachableBound=cfg->front.pushAhead>0
            ?std::min(limit,cfg->front.pushScreen>0?std::min(cfg->front.distance,s.front.pushBound):cfg->front.distance)
            :advance;
        // Cached observed enemy groups, not hidden enemy positions. An edge
        // threat within this corridor arrests its own commander's advance.
        for(const auto& group:ai->GetEnemyManager()->GetEnemyGroups())
            if(battle->GetFrontLaneDistance(group.pos)<=battle->GetFrontLaneWidth()) {
                const float boundary=std::max(0.f,battle->GetFrontLaneProgress(group.pos)-cfg->front.standoff);
                if(boundary<advance)s.front.reason=commander::AdvanceReason::CONTACT;
                advance=std::min(advance,boundary);reachableBound=std::min(reachableBound,boundary);
            }
        // Enemy groups behind the commander may stop a push, but must not
        // turn ordinary deployment into a trip home. Combat owns withdrawals.
        if(cfg->front.persistent>0) { advance=std::max(own,advance);reachableBound=std::max(own,reachableBound); }
        // Lane assessment is an additional bound; local combat still owns
        // withdrawal and existing screen/reach limits remain authoritative.
        bool stale=false;
        const float limited=battle->AssessLaneAdvance(own,advance,&stale);
        if(stale)s.front.reason=commander::AdvanceReason::STALE;
        else if(limited<advance)s.front.reason=commander::AdvanceReason::LANE_BOUND;
        advance=limited;
        reachableBound=std::min(reachableBound,battle->LimitLaneAdvance(own,reachableBound));
        auto anchor=battle->GetFrontLanePoint(advance);
        anchor.y=ai->GetMap()->GetElevationAt(anchor.x,anchor.z);
        // A corridor point can fall in a coarse terrain sector this commander
        // cannot enter. Keeping an already-arrived old anchor then stalls every
        // future deployment. Probe three earlier and three later points inside
        // the SAME safety bound;
        // this is endpoint admission, not a path solve or permission to pass a
        // threat/screen boundary. At most six extra queries per second, only
        // on an unreachable endpoint (commander-support-cortex regression).
        bool reachable=OnMap(anchor) && ai->GetTerrainManager()->CanReachAt(unit,anchor,64);
        if(cfg->front.persistent>0 && OnMap(anchor) && !reachable) {
            for(float back:{128.f,256.f,384.f}) {
                const float progress=advance-back;
                if(progress<=own+cfg->front.radius*.5f) break;
                auto probe=battle->GetFrontLanePoint(progress);
                probe.y=ai->GetMap()->GetElevationAt(probe.x,probe.z);
                if(OnMap(probe) && ai->GetTerrainManager()->CanReachAt(unit,probe,64)
                    && ai->GetThreatMap()->GetThreatAt(unit,probe)<=cfg->front.threat) {
                    advance=progress;anchor=probe;reachable=true;break;
                }
            }
            if(!reachable) for(float ahead:{128.f,256.f,384.f}) {
                const float progress=std::min(reachableBound,advance+ahead);
                if(progress<=advance+64.f) break;
                auto probe=battle->GetFrontLanePoint(progress);
                probe.y=ai->GetMap()->GetElevationAt(probe.x,probe.z);
                if(OnMap(probe) && ai->GetTerrainManager()->CanReachAt(unit,probe,64)
                    && ai->GetThreatMap()->GetThreatAt(unit,probe)<=cfg->front.threat) {
                    advance=progress;anchor=probe;reachable=true;break;
                }
            }
        }
        if(!reachable
            || ai->GetThreatMap()->GetThreatAt(unit,anchor)>cfg->front.threat) {
            s.front.reason=reachable?commander::AdvanceReason::THREAT:commander::AdvanceReason::NO_ROUTE;
            // A retained deployment anchor must obey newly observed contact
            // too. Otherwise the legacy unreachable-site fallback can revive
            // a goal beyond the new bound after the front has moved back.
            if(s.front.point.x>=0) {
                const float previous=battle->GetFrontLaneProgress(s.front.point);
                if(battle->LimitLaneAdvance(own,previous)<previous) {
                    s.route.clear();s.front.pushGoalProgress=own;
                    return s.front.point=unit->GetPos(frame);
                }
            }
            // Legacy: keep the last safe front. Push (D-356): the last front
            // may lie beyond the bound the screens now give (they fell back
            // while the fresh anchor is exposed); it is then no longer a legal
            // goal (INV-234 fired 160 times in the b03 Supreme natural game),
            // so the commander holds where it stands until the anchor clears.
            // The unscreened push (front_push_screen 0) keeps the legacy rule:
            // its only bound is front_distance, and a commander that fell back
            // in combat walks to its last safe front again.
            if(cfg->front.pushAhead>0 && cfg->front.pushScreen>0 && s.front.point.x>=0
                && battle->GetFrontLaneProgress(s.front.point)>std::min(cfg->front.distance,s.front.pushBound)) {
                s.route.clear();
                // Standing beyond the bound itself (the screens fell back past
                // the commander) leaves no legal front: local work and combat
                // own the commander until the anchor clears (b04 Glacial:
                // holding in place at 1178 against a bound of 962 fired INV-234).
                if(own>std::min(cfg->front.distance,s.front.pushBound)) { s.front.pushGoalProgress=-1; return s.front.point={-1,0,-1}; }
                auto hold=battle->GetFrontLanePoint(std::min(own,limit));
                hold.y=ai->GetMap()->GetElevationAt(hold.x,hold.z);
                s.front.pushGoalProgress=std::min(own,limit);
                return s.front.point=hold;
            }
            return battle->GetFrontLaneDistance(s.front.point)<=battle->GetFrontLaneWidth()?s.front.point:AIFloat3(-1,0,-1);
        }
        // A moving forward anchor is not a changed short-step intent. Keep the
        // owned queue; only a newly retreating boundary invalidates its goal.
        if(anchor.SqDistance2D(s.front.point)>64.f*64.f && (cfg->front.pushAhead<=0
            || battle->GetFrontLaneProgress(s.goal)>advance))s.route.clear();
        s.front.pushGoalProgress=advance;
        s.front.point=anchor;return anchor;
    }
    const auto home=ai->GetSetupManager()->GetStartPos();
    auto enemy=ai->GetEnemyManager()->GetNearestGroupPos(unit->GetPos(frame),cfg->combat.minValue);
    if(enemy.x<0) enemy=ai->GetEnemyManager()->GetEnemyPos();
    if(enemy.x<0 || home.SqDistance2D(enemy)<1) {s.front.reason=commander::AdvanceReason::NO_GOAL;return s.front.point={-1,0,-1};}
    const auto delta=enemy-home;
    const float distance=delta.Length2D();
    const auto direction=delta/distance;
    // Secure the middle ground before contacts; a moving friendly screen or
    // constructor can pull this anchor forward, bounded by contact stand-off.
    const float limit=std::min(cfg->combat.leash,std::max(0.f,distance-cfg->front.standoff));
    float advance=std::min(limit,std::min(cfg->front.distance,distance*.5f));
    AIFloat3 anchor=home+direction*advance;
    const auto& ids=ai->GetCallback()->GetFriendlyUnitIdsIn(anchor,cfg->combat.scan,false);
    for(int id:ids) {
        if(id==unit->GetId()) continue;
        auto* def=ai->GetCircuitDefSafe(ai->GetCallback()->Unit_GetDefId(id));
        if(!def || !def->IsMobile() || def->IsAbleToFly() || def->IsRoleComm()
            || (!def->IsBuilder() && !def->IsAttacker())) continue;
        float raw[3]={NAN,NAN,NAN}; ai->GetUnitAPI()->GetPosition(id,raw);
        const AIFloat3 p(raw[0],raw[1],raw[2]);
        const float projection=(p.x-home.x)*direction.x+(p.z-home.z)*direction.z-100.f;
        if(projection>advance && projection<=limit) { advance=projection; anchor=p-direction*100.f; }
    }
    anchor.y=ai->GetMap()->GetElevationAt(anchor.x,anchor.z);
    const bool reachable=OnMap(anchor) && ai->GetTerrainManager()->CanReachAt(unit,anchor,64);
    if(!reachable || ai->GetThreatMap()->GetThreatAt(unit,anchor)>cfg->front.threat) {
        s.front.reason=reachable?commander::AdvanceReason::THREAT:commander::AdvanceReason::NO_ROUTE;
        // Keep the last safe front; local combat can withdraw from it. Never
        // treat an unreachable/exposed destination as permission to idle home.
        return s.front.point;
    }
    if(anchor.SqDistance2D(s.front.point)>64.f*64.f) s.route.clear();
    s.front.point=anchor; return anchor;
}

// pending-all (owner 2026-10-28): the ghost radar's site lies up to GhostTravel off the
// front anchor. Unadopted, Deploy took the walking commander back to its
// front every yield (2 s) and GhostKeep handed the order back: 2026-10-28,
// 55 orders, 39 died with no frame. Declined under a fallback (INV-218).
bool CCommanderController::AdoptFrontWork(CCircuitUnit* unit,IUnitTask* task,float reach) {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1)); // D-388: this unit's preset
    if(!task || task->IsDead() || !Handles(unit) || !role.frontDuty) return false;
    State* found=states.Find(unit->GetId()); if(!found) return false;
    auto& s=*found; const int frame=ai->GetLastFrame();
    if(FallbackActive(s,frame)) return false;
    if(task->GetType()==IUnitTask::Type::BUILDER) {
        if(const auto* z=KeepOutOnWalk(unit,static_cast<IBuilderTask*>(task)->GetPosition())) {
            ai->LOG("[CommanderWork] unit=%i adopt refused: keep-out %s %i on the site or walk",unit->GetId(),
                z->heavy?"heavy_unit":z->porc?(z->ghost?"porc_ghost":"porc"):z->tower?"tower":"shell_zone",z->id);
            return false;
        }
    }
    s.work.task=task; s.work.kind=WORK_ADOPTED; s.work.reach=std::max(0.f,reach); s.work.held=false; s.work.boundary=s.fallback.boundary;
    ai->LOG("[CommanderWork] unit=%i adopt task=%i reach=%.0f",unit->GetId(),
        task->GetType()==IUnitTask::Type::BUILDER?int(static_cast<IBuilderTask*>(task)->GetBuildType()):-1,s.work.reach);
    return true;
}

IUnitTask* CCommanderController::FrontWork(CCircuitUnit* unit,int kind,CCircuitDef* buildDef,float radius) {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1)); // D-388: this unit's preset
    if(kind==19) return HandedGroup(unit,GroupWork(unit));
    if(HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    if(kind==WORK_SOLAR) {
        if(!Handles(unit) || !role.frontDuty || cfg->front.solarIncome<=0 || !unit->IsFinished()) return nullptr;
        State* found=states.Find(unit->GetId());
        if(!found) return nullptr;
        auto& state=*found;
        auto* current=unit->GetTask();
        if(!current || current->IsExternalControlled() || current->IsEnemyReclaim()
            || current->GetType()==IUnitTask::Type::PLAYER || current->GetType()==IUnitTask::Type::RETREAT) return nullptr;
        // Owner 2026-11-20: once a fusion of ours is finished no front solar is
        // ordered or continued; the commander reclaims the front solars instead.
        if(cfg->front.solarFusionStop>0 && FrontSolarFusionStands(ai->GetLastFrame())) {
            if(state.work.kind==WORK_SOLAR && current==state.work.task && !current->IsDead()) {
                auto* build=dynamic_cast<IBuilderTask*>(current);
                if(build && build->GetBuildType()==BT::RECLAIM) return current;
            }
            if(state.work.kind==WORK_REPAIR_COMBAT && current==state.work.task && !current->IsDead()) return current;
            if(cfg->front.solarReclaim<=0 || (cfg->front.keepOwnBuild>0 && IsOwnConstruction(unit,current))) return nullptr;
            auto* reclaim=FrontSolarReclaim(unit,ai->GetLastFrame());
            if(!reclaim) return nullptr;
            state.work.task=reclaim;state.work.kind=WORK_SOLAR;state.work.reach=0;
            state.work.NoteOrigin(reclaim,commander::TaskOrigin::Solar);
            return reclaim;
        }
        if((state.work.kind==WORK_SOLAR || state.work.kind==WORK_REPAIR_COMBAT)
            && current==state.work.task && !current->IsDead()) return current;
        // D-490: the commander's own construction (a mex, a turret) is finished first.
        if(cfg->front.keepOwnBuild>0 && IsOwnConstruction(unit,current)) return nullptr;
        auto* eco=ai->GetEconomyManager();
        // D-493: the shared energy state; D-490: front_solar_stall also offers it
        // while energy stalls above front_solar_income.
        const economy::EnergyState energy=eco->GetEnergyState();
        if(!economy::EmergencySolarAllowed(energy,cfg->front.solarIncome,
            cfg->front.solarMaxIncome,cfg->front.solarStall>0,cfg->front.solarStorage)) return nullptr;
        // Priority-two repairs retain precedence over emergency economy. Only
        // ask the existing bounded repair selector when a solar is eligible;
        // ordinary deployment does not gain another friendly-unit query.
        if(cfg->front.repairCombat>0) {
            if(auto* repair=FrontWork(unit,WORK_REPAIR_COMBAT,nullptr,0)) return repair;
        }
        const int frame=ai->GetLastFrame();
        if(frame<state.front.solarNext) return nullptr;
        auto* def=buildDef?buildDef:ai->GetCircuitDefSafe(int(cfg->front.solarDef));
        if(!def || !unit->GetCircuitDef()->CanBuild(def)) return nullptr;
        const auto pos=unit->GetPos(frame);
        const float reach=unit->GetCircuitDef()->GetBuildDistance();
        const float radius=cfg->front.solarRadius;
        auto* terrain=ai->GetTerrainManager();
        auto* builder=ai->GetBuilderManager();
        CTerrainManager::TerrainPredicate allowed=[&](const AIFloat3& at) {
            return at.SqDistance2D(pos)<=radius*radius && InsideLine(state,at,frame,reach)
                && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat
                && terrain->CanReachAtSafe2(unit,at,reach);
        };
        // Task-offer work only: reuse a local energy claim before a bounded
        // nearest-site search. Failed placement retries after three seconds;
        // no map/army scan, no independent timer, and no base-layout detour.
        IBuilderTask* task=nullptr;
        for(auto* queued:builder->GetTasks(BT::ENERGY)) {
            if(!queued->IsDead() && queued->GetBuildDef()==def && allowed(queued->GetPosition())
                && queued->CanAssignTo(unit)) { task=queued;break; }
        }
        if(!task) {
            const auto site=terrain->FindBuildSite(def,pos,std::min(radius,std::max(32.f,reach-32.f)),0,allowed);
            const auto at=OnMap(site)?site:terrain->FindBuildSite(def,pos,radius,0,allowed);
            if(OnMap(at)) task=builder->Enqueue(TaskB::Common(BT::ENERGY,IBuilderTask::Priority::HIGH,def,at,0.f,true,60*FRAMES_PER_SEC));
        }
        if(!task) { state.front.solarNext=frame+3*FRAMES_PER_SEC;return nullptr; }
        state.work.task=task;state.work.kind=WORK_SOLAR;state.work.reach=0;
        NoteFrontSolarSite(task->GetPosition(),def->GetId());
        state.work.NoteOrigin(task,commander::TaskOrigin::Solar);  // D-493
        if(cfg->front.solarMaxIncome>0 && energy.income>=cfg->front.solarMaxIncome)
            ai->LOG("[INVARIANT] INV-275 new commander solar offered above hard income ceiling unit=%i",unit->GetId());
        ai->LOG("[CommanderWork] unit=%i work=22 solar=%s income=%.1f storage=%.3f",unit->GetId(),def->GetDef()->GetName(),
            eco->GetAvgEnergyIncome(),eco->GetEnergyCur()/eco->GetEnergyStore());
        return task;
    }
    if(kind==20) return Handed(unit,GroupAssist(unit),commander::TaskOrigin::Assist);
    // Every normal defensive offer shares tier selection and the following
    // nano obligation, even while the assigned T2 worker is still en route.
    if(role.frontDuty && ((kind==WORK_MEX_DEFENCE && cfg->front.mexMinIncome<=0) || kind==WORK_TERRITORY_LINE
        || kind==WORK_LINE || kind==WORK_TIMED || kind==WORK_RADAR || kind==2 || kind==3))
        return HandedGroup(unit,GroupWork(unit));
    if(GroupActive(unit) && kind==WORK_MEX_LANE) buildDef=nullptr;
    if(!Handles(unit) || !role.frontDuty || !role.frontReady || !unit->IsFinished()
        || (kind!=WORK_HOLD && cfg->safety.healthRetreat<=0
            && unit->GetHealthPercent()<cfg->combat.recover && !Jammed(unit))) return nullptr;
    State* found=states.Find(unit->GetId()); if(!found) return nullptr;
    auto& s=*found; const int frame=ai->GetLastFrame();
    const auto record=[&](IUnitTask* task) {
        // Lane mexes already passed their own LOS/reach/territory window before
        // claiming a spot. Reapplying the narrower generic-work window here
        // strands the claim and can alternate idle holds with deployment.
        // D-356: an offer whose site lies beyond the corridor (lane half-width
        // plus front_lane_margin, or the build distance) is declined, never
        // aborted: assist/repair/base rungs hand back tasks the shared queue
        // created for other builders, which keep them.
        if(auto* build=dynamic_cast<IBuilderTask*>(task);build && !FallbackActive(s,frame)
            && kind!=WORK_MEX_DEFENCE && kind!=WORK_TERRITORY_LINE && kind!=WORK_REPAIR_COMBAT && kind!=WORK_MEX_LANE
            && ai->GetBattle()->GetFrontLaneLength()>0.f
            && ai->GetBattle()->GetFrontLaneDistance(build->GetPosition())>ai->GetBattle()->GetFrontLaneWidth()
                +(cfg->front.laneMargin>0?cfg->front.laneMargin:unit->GetCircuitDef()->GetBuildDistance())) {
            task=nullptr;
        }
        if(auto* build=dynamic_cast<IBuilderTask*>(task); build && cfg->front.persistent>0
            && !FallbackActive(s,frame) && ai->GetBattle()->GetFrontLaneLength()>0.f
            && kind!=WORK_MEX_DEFENCE && kind!=WORK_TERRITORY_LINE && kind!=WORK_REPAIR_COMBAT && kind!=WORK_MEX_LANE
            && ai->GetBattle()->GetFrontLaneProgress(build->GetPosition())
                <ai->GetBattle()->GetFrontLaneProgress(unit->GetPos(frame))-cfg->front.workBehind)
            task=nullptr; // decline shared work; never abort another builder's task
        // Native placement may move a site (shake, blocked cells). While a
        // fallback holds, an offer that ends outside the perimeter is dropped
        // here, and aborted when no one else took it (INV-218 at the source).
        if(auto* build=dynamic_cast<IBuilderTask*>(task); build && FallbackActive(s,frame)
            && !s.fallback.boundary.Contains({build->GetPosition().x,build->GetPosition().z},unit->GetCircuitDef()->GetBuildDistance()+32.f)) {
            if(build->GetAssignees().empty()) ai->GetBuilderManager()->AbortTask(build);
            task=nullptr;
        }
        if(task && (kind==WORK_MEX_DEFENCE || kind==WORK_TERRITORY_LINE)
            && task->GetType()==IUnitTask::Type::BUILDER && cfg->front.fortifyAdvance>0)
            s.front.fortifyNextProgress=ai->GetBattle()->GetFrontLaneProgress(unit->GetPos(frame))+cfg->front.fortifyAdvance;
        s.work.task=task; s.work.kind=kind; s.work.reach=0; s.work.held=FallbackActive(s,frame); s.work.boundary=s.fallback.boundary;
        // D-493: the assist rungs (assist, factory, base) hand out assists; every other rung, own work.
        s.work.NoteOrigin(task,(kind==WORK_ASSIST || kind==WORK_FACTORY || kind==WORK_BASE)
            ?commander::TaskOrigin::Assist:commander::TaskOrigin::Ladder);
        if(task) ai->LOG("[CommanderWork] unit=%i work=%i task=%i",unit->GetId(),kind,
            task->GetType()==IUnitTask::Type::BUILDER?int(static_cast<IBuilderTask*>(task)->GetBuildType()):-1);
        return task;
    };
    // The script offers kind 14 before local work. One cached lane lookup,
    // no extra army scan. Fallback and unfinished nearby structures retain
    // ownership; repairs/guard/base queues cannot monopolise a FRONT builder.
    if(kind==WORK_ADVANCE) {
        if(cfg->front.pushAhead<=0 || FallbackActive(s,frame)
            || (frame<s.work.lineUntil && !s.work.lineDone)
            || (s.front.territoryPending && cfg->front.fortifyAdvance<=0)) return nullptr;
        const auto anchor=FrontPosition(unit,s,frame),pos=unit->GetPos(frame);
        if(anchor.x<0 || !commander::ShouldStartDeployment(pos.SqDistance2D(anchor),cfg->front.radius*.5f)) return nullptr;
        auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
        if(build && !build->IsDead() && build->GetBuildDef() && CanResumeFrontTask(unit,build)
            && ((build->GetTarget() && !build->GetTarget()->IsFinished()) || build==s.work.task)
            && build->GetPosition().SqDistance2D(pos)<=std::pow((build==s.work.task?std::max(cfg->front.radius,s.work.reach)
                :cfg->front.radius)+unit->GetCircuitDef()->GetBuildDistance(),2.f)) return build;
        if(dynamic_cast<CControlledTask*>(unit->GetTask())) return unit->GetTask();
        // INV-235 (D-357): the commander advances by taking the next corridor
        // mex. The script ladder offers mex_lane before advance; if an admitted
        // corridor spot still exists here, the ladder order or the admission
        // disagrees, and the walk is refused so the next ask offers the spot.
        if(LaneMexAvailable(unit,s,frame)) {
            ai->LOG("[INVARIANT] INV-235 lane advance offered with an open corridor mex unit=%i x=%.0f z=%.0f",
                unit->GetId(),pos.x,pos.z);
            return nullptr;
        }
        s.front.progressFrame=frame; s.front.progressPos=pos;
        return ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
    }
    // Script offers a bounded hold after productive front work. Engine PATROL
    // can acquire repair/reclaim work beyond its endpoint and out of the lane.
    // Cancel the old queue only when this task starts, never while offering it.
    if(kind==WORK_HOLD) {
        if(cfg->front.pushAhead<=0 || radius<=0 || (cfg->front.persistent<=0 && FallbackActive(s,frame))) return nullptr;
        const auto anchor=FrontPosition(unit,s,frame);
        if(cfg->front.persistent<=0 && (anchor.x<0 || unit->GetPos(frame).SqDistance2D(anchor)>
            cfg->front.radius*cfg->front.radius*.25f)) return nullptr;
        if(s.front.reason==commander::AdvanceReason::ADVANCE)
            s.front.reason=commander::AdvanceReason::ARRIVED;
        const int reason=int(s.front.reason);
        if(reason!=s.work.idleReason || frame>=s.work.idleLogNext) {
            s.work.idleReason=reason;s.work.idleLogNext=frame+30*FRAMES_PER_SEC;
            ai->LOG("[CommanderIdle] unit=%i reason=%i posture=%s defense=%s metal_room=%.0f energy_room=%.0f group_job=%i reclaim=%s",
                unit->GetId(),reason,s.conceal.postureReason,defenseReason.c_str(),
                s.work.reclaimMetalRoom,s.work.reclaimEnergyRoom,ExpansionJobCount(),s.work.reclaimReason);
        }
        auto* hold=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(
            TaskB::Wait(int(std::clamp(radius,1.f,30.f)*FRAMES_PER_SEC))));
        hold->SetStationary(true);
        return record(hold);
    }
    // Native Start can re-ask policy synchronously; keep a live ladder task.
    if(auto* current=unit->GetTask(); current && current==s.work.task && !current->IsDead()
        && CanResumeFrontTask(unit,current)) return current;
    // D-299 ladder kinds: commander-local, filtered to the perimeter while a
    // fallback holds. The script orders them (CommanderFront::Work).
    if(kind>=WORK_LINE) return record(LadderWork(unit,s,kind,buildDef,radius,frame));
    // D-293: no front work beyond the porc line while a fallback holds; D-299
    // assists construction inside it.
    if(FallbackActive(s,frame))
        return kind==0?record(AssistWork(unit,s,unit->GetPos(frame),WorkRadius(unit),false,frame)):nullptr;
    const auto anchor=FrontPosition(unit,s,frame),pos=unit->GetPos(frame);
    if(anchor.x<0) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* current=dynamic_cast<IBuilderTask*>(unit->GetTask());
    if(current && !current->IsDead() && current->GetBuildDef() && current->GetManager()==builder
        && !current->IsExternalControlled() && !current->IsEnemyReclaim()
        && current->GetPosition().SqDistance2D(anchor)<=cfg->front.radius*cfg->front.radius) {
        // Native Start synchronously re-asks role policy before the frame exists.
        // Keep the travelling front claim, not just an already-built target.
        // Otherwise mex/radar offers can swap recursively in the same frame.
        return current;
    }
    if(pos.SqDistance2D(anchor)>cfg->front.radius*cfg->front.radius*.25f) {
        // Not while the last fallback line still wants turrets (D-299).
        if(kind!=4 || (frame<s.work.lineUntil && !s.work.lineDone)) return nullptr;
        s.front.progressFrame=frame; s.front.progressPos=pos;
        return builder->EnqueueControlled(this,nullptr);
    }
    if(s.front.arrived<0) s.front.arrived=frame; // D-299 timed defence clock
    if(ai->GetThreatMap()->GetThreatAt(unit,pos)>cfg->front.threat) return nullptr;
    radius=std::clamp(radius,64.f,cfg->front.radius);
    IUnitTask* result=nullptr;
    if(kind==0) {
        // Join the constructor's actual build task, rather than permanently
        // guarding it back to base. Local query order breaks equal-distance ties.
        const auto& ids=ai->GetCallback()->GetFriendlyUnitIdsIn(anchor,radius,false);
        float best=radius*radius;
        for(int id:ids) {
            auto* worker=ai->GetTeamUnit(id);
            if(!worker || worker==unit || !worker->IsFinished()
                || !worker->GetCircuitDef()->IsMobile() || !worker->GetCircuitDef()->IsBuilder()) continue;
            auto* task=dynamic_cast<IBuilderTask*>(worker->GetTask());
            if(!task || !task->GetBuildDef() || task->IsDead() || task->IsExternalControlled()
                || task->IsEnemyReclaim() || !task->CanAssignTo(unit)) continue;
            const float square=task->GetPosition().SqDistance2D(anchor);
            if(square<best) { best=square; result=task; }
        }
    } else if(kind==1) {
        result=ai->GetEconomyManager()->EnqueueMexWithin(unit,anchor,radius,0,true);
    } else if((kind==2 || kind==3) && buildDef && unit->GetCircuitDef()->CanBuild(buildDef)) {
        const BT type=kind==2?BT::RADAR:BT::DEFENCE;
        const auto& ids=ai->GetCallback()->GetFriendlyUnitIdsIn(anchor,radius,false);
        for(int id:ids) if(ai->GetCallback()->Unit_GetDefId(id)==buildDef->GetId()) return nullptr;
        for(auto* task:builder->GetTasks(type)) {
            if(task->GetBuildDef()==buildDef && task->GetPosition().SqDistance2D(anchor)<radius*radius)
                return !task->IsDead() && task->CanAssignTo(unit)?task:nullptr;
        }
        // Policy chooses the definition, priority order and spacing; native
        // placement/claims and build chains remain the sole structure owners.
        if(ai->GetBattle()->LaneWorkAllowed(anchor)
            && ai->GetEconomyManager()->GetMetalCur()>=buildDef->GetCostM()*.5f)
            result=builder->Enqueue(TaskB::Common(type,IBuilderTask::Priority::NORMAL,buildDef,anchor,96.f,true,30*30));
    } else if(kind==4) {
        result=builder->Enqueue(TaskB::Patrol(IBuilderTask::Priority::NORMAL,anchor,10*30));
    }
    if(result) ai->LOG("[CommanderFront] unit=%i work=%i x=%.0f z=%.0f",unit->GetId(),kind,anchor.x,anchor.z);
    return result;
}

// D-356 "then home": the push ends after front_push_until_seconds of game
// time, or once the enemy's observed riot metal (the enemy manager's role
// census, no scan here) reaches front_push_home_riot. The latch never
// releases: the meta's rule is "com forward until the first riot units
// appear, then home" (53-expansion-and-territory.md). Zero disables a gate.
bool CCommanderController::PushHome(CCircuitUnit* unit,State& s,int frame) {
    if(cfg->front.persistent>0) { s.front.pushHome=false; return false; }
    if(s.front.pushHome || cfg->front.pushAhead<=0) return s.front.pushHome;
    const char* reason=nullptr;
    if(cfg->front.pushUntilSeconds>0 && frame>=int(cfg->front.pushUntilSeconds*FRAMES_PER_SEC)) reason="time";
    const float riot=cfg->front.pushHomeRiot>0?ai->GetEnemyManager()->GetEnemyCost(ROLE_TYPE(RIOT)):0.f;
    if(!reason && cfg->front.pushHomeRiot>0 && riot>=cfg->front.pushHomeRiot) reason="riot";
    if(!reason) return false;
    s.front.pushHome=true; s.route.clear();
    ai->LOG("[CommanderFront] unit=%i home reason=%s frame=%i riot_metal=%.0f",unit->GetId(),reason,frame,riot);
    return true;
}
// Owner 2026-11-20: once the AI has a finished fusion, the commander orders no
// more solars at the front and reclaims the front solars it ordered. Any of our
// finished fusions counts (land, naval or advanced; never the decoy fusion).
// Latched: once one has stood the rung stays closed for the rest of the game,
// even if that fusion dies (headless 2026-11-20: a lost fusion reopened it at
// 1,400 E/s income). Checked at most once a second until it latches.
bool CCommanderController::FrontSolarFusionStands(int frame) {
    if(frontSolarFusion || frame-frontSolarFusionCheck<FRAMES_PER_SEC) return frontSolarFusion;
    frontSolarFusionCheck=frame;
    static const char* const fusions[]={"armfus","corfus","legfus","armckfus","armuwfus","coruwfus",
        "leganavalfusion","armafus","corafus","legafus"};
    auto* builder=ai->GetBuilderManager();
    bool stands=false;
    for(const char* name:fusions) {
        CCircuitDef* def=ai->GetCircuitDef(name);
        if(!def) continue;
        const int unfinished=builder?builder->GetUnfinishedCount(def):0;
        if(def->GetCount()-unfinished>0) { stands=true;break; }
    }
    if(stands!=frontSolarFusion)
        ai->LOG("[CommanderWork] front_solar fusion=%i sites=%i",int(stands),int(frontSolarSites.size()));
    frontSolarFusion=stands;
    return stands;
}

void CCommanderController::NoteFrontSolarSite(const AIFloat3& pos,int defId) {
    if(defId<0 || !OnMap(pos)) return;
    for(auto& site:frontSolarSites) if(site.pos.SqDistance2D(pos)<SQUARE(32.f)) { site.defId=defId;return; }
    if(int(frontSolarSites.size())>=FRONT_SOLAR_SITES_MAX) frontSolarSites.erase(frontSolarSites.begin());
    frontSolarSites.push_back({pos,defId});
}

// The commander takes the nearest front solar within front_solar_reclaim_radius
// that is reachable and under front_threat. Solars out of its radius get a plain
// reclaim job any builder may take (at most FRONT_SOLAR_RECLAIMS_MAX at once,
// under no threat). A site with no solar of ours left is forgotten. One
// friendly-unit query per remembered site, at most every two seconds.
IUnitTask* CCommanderController::FrontSolarReclaim(CCircuitUnit* unit,int frame) {
    if(!unit || !unit->GetCircuitDef() || !unit->GetCircuitDef()->IsAbleToReclaim()) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* callback=ai->GetCallback();
    auto* threat=ai->GetThreatMap();
    auto* terrain=ai->GetTerrainManager();
    if(!builder || !callback || !threat || !terrain) return nullptr;
    // Jobs whose task has ended were cleared by TaskFinished; drop dead targets too.
    frontSolarReclaims.erase(std::remove_if(frontSolarReclaims.begin(),frontSolarReclaims.end(),
        [&](const FrontSolarReclaimJob& j){return !j.task || j.task->IsDead() || !ai->GetTeamUnit(j.target);}),
        frontSolarReclaims.end());
    const auto pos=unit->GetPos(frame);
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    const float radius=cfg->front.solarReclaimRadius;
    // The commander's choice first: an open job for a solar in its radius.
    IUnitTask* mine=nullptr; float best=std::numeric_limits<float>::max();
    for(auto& job:frontSolarReclaims) {
        CCircuitUnit* target=ai->GetTeamUnit(job.target);
        if(!target || !job.task || job.task->IsDead()) continue;
        const auto at=target->GetPos(frame);
        const float sq=at.SqDistance2D(pos);
        if(sq>SQUARE(radius) || sq>=best || threat->GetThreatAt(unit,at)>cfg->front.threat
            || !job.task->CanAssignTo(unit) || !terrain->CanReachAtSafe2(unit,at,reach)) continue;
        mine=job.task; best=sq;
    }
    if(mine) return mine;
    if(frame<frontSolarScanNext || frontSolarSites.empty()) return nullptr;
    frontSolarScanNext=frame+2*FRAMES_PER_SEC;
    const auto queued=[&](CCircuitUnit* u) {
        for(auto& job:frontSolarReclaims) if(job.target==u->GetId()) return true;
        for(auto* task:builder->GetTasks(BT::RECLAIM))
            if(task && !task->IsDead() && task->GetTarget()==u) return true;
        return false;
    };
    // An unfinished frame a live energy job is still building is left to it.
    const auto building=[&](CCircuitUnit* u) {
        if(u->IsFinished()) return false;
        for(auto* task:builder->GetTasks(BT::ENERGY))
            if(task && !task->IsDead() && task->GetTarget()==u && !task->GetAssignees().empty()) return true;
        return false;
    };
    CCircuitUnit* chosen=nullptr; best=std::numeric_limits<float>::max();
    std::vector<CCircuitUnit*> farTargets;
    // Neighbouring sites can see the same solar: each one is weighed once.
    std::vector<int> seen;
    // A solar ordered within FRONT_SOLAR_RETRY_SECONDS waits (an order that
    // ended unfinished is not re-made every scan).
    frontSolarRetry.erase(std::remove_if(frontSolarRetry.begin(),frontSolarRetry.end(),
        [&](const std::pair<int,int>& r){return r.second<=frame;}),frontSolarRetry.end());
    const auto waiting=[&](int id) {
        for(const auto& r:frontSolarRetry) if(r.first==id) return true;
        return false;
    };
    // Orders made per solar: after FRONT_SOLAR_COMMANDER_TRIES the commander
    // leaves it to other builders; after FRONT_SOLAR_MAX_TRIES it is left standing.
    const auto tries=[&](int id) {
        for(const auto& t:frontSolarTries) if(t.first==id) return t.second;
        return 0;
    };
    for(auto it=frontSolarSites.begin();it!=frontSolarSites.end();) {
        bool found=false;
        for(int id:callback->GetFriendlyUnitIdsIn(it->pos,48.f,false)) {
            CCircuitUnit* u=ai->GetTeamUnit(id);
            if(!u || u==unit || !u->GetCircuitDef() || u->GetCircuitDef()->GetId()!=it->defId) continue;
            found=true;
            if(std::find(seen.begin(),seen.end(),id)!=seen.end()) continue;
            seen.push_back(id);
            const int tried=tries(id);
            if(tried>=FRONT_SOLAR_MAX_TRIES || waiting(id) || building(u) || queued(u)) continue;
            const auto at=u->GetPos(frame);
            if(!OnMap(at)) continue;
            const float sq=at.SqDistance2D(pos);
            const bool commanderCan=tried<FRONT_SOLAR_COMMANDER_TRIES && sq<=SQUARE(radius) && threat->GetThreatAt(unit,at)<=cfg->front.threat
                && terrain->CanReachAtSafe2(unit,at,reach);
            if(commanderCan) { if(sq<best) { chosen=u; best=sq; } }
            else if(threat->GetThreatAt(at)<=0.f) farTargets.push_back(u);
        }
        // A live energy job at the site keeps it remembered (its solar may still come).
        if(!found) {
            bool pending=false;
            for(auto* task:builder->GetTasks(BT::ENERGY))
                if(task && !task->IsDead() && task->GetPosition().SqDistance2D(it->pos)<SQUARE(32.f)) { pending=true;break; }
            if(!pending) { it=frontSolarSites.erase(it);continue; }
        }
        ++it;
    }
    const auto order=[&](CCircuitUnit* target)->IBuilderTask* {
        if(!target || !target->GetCircuitDef() || !target->GetCircuitDef()->GetDef()) return nullptr;
        auto* task=builder->Enqueue(TaskB::Reclaim(IBuilderTask::Priority::NORMAL,target,120*FRAMES_PER_SEC));
        if(!task) return nullptr;
        frontSolarReclaims.push_back({target->GetId(),task});
        frontSolarRetry.emplace_back(target->GetId(),frame+FRONT_SOLAR_RETRY_SECONDS*FRAMES_PER_SEC);
        bool counted=false;
        for(auto& t:frontSolarTries) if(t.first==target->GetId()) { ++t.second;counted=true;break; }
        if(!counted) {
            if(frontSolarTries.size()>=size_t(4*FRONT_SOLAR_SITES_MAX)) frontSolarTries.erase(frontSolarTries.begin());
            frontSolarTries.emplace_back(target->GetId(),1);
        }
        const auto at=target->GetPos(frame);
        ai->LOG("[CommanderWork] unit=%i front_solar_reclaim %s id=%i x=%.0f z=%.0f by=%s",unit->GetId(),
            target->GetCircuitDef()->GetDef()->GetName(),target->GetId(),at.x,at.z,target==chosen?"commander":"any_builder");
        return task;
    };
    IBuilderTask* own=chosen?order(chosen):nullptr;
    for(auto* u:farTargets) {
        if(int(frontSolarReclaims.size())>=FRONT_SOLAR_RECLAIMS_MAX) break;
        order(u);
    }
    if(own && !own->CanAssignTo(unit)) own=nullptr;
    return own;
}
}
