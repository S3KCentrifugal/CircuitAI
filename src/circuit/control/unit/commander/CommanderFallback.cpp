#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "control/core/ControlledTask.h"
#include "task/fighter/RangedWorld.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "setup/SetupManager.h"
#include "spring/SpringMap.h"
#include "terrain/TerrainManager.h"
#include "terrain/BattleAnalysis.h"
#include "map/ThreatMap.h"
#include "control/kernel/CommanderFallback.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include "util/Performance.h"
#include <algorithm>
#include <array>
#include <cmath>

namespace circuit {
using springai::AIFloat3;
using commander::Point;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }
static AIFloat3 F(Point p,float y=0) { return {p.x,y,p.z}; }

// D-293: a capable enemy group (commander::StrongestGroup) worth at least
// fallback_metal within fallback_range_scale x the commander's weapon range
// sends the commander back to the outermost allied porc behind it. While the
// fallback holds, that porc (plus the stand-off) is the commander's perimeter.
// INV-215: commander control never directs it outside that perimeter.
void CCommanderController::CheckPerimeter(CCircuitUnit* unit,const State& s,const AIFloat3& goal,int frame,const char* source) const {
    if(!FallbackActive(s,frame)) return;
    const Point home=s.fallback.boundary.anchor;
    if(!s.fallback.boundary.Contains(P(goal),32.f))
        ai->LOG("[INVARIANT] INV-215 commander fallback goal outside perimeter unit=%i source=%s goal=%.0f,%.0f perimeter=%.0f home=%.0f,%.0f station=%.0f,%.0f planned=%i mode=%i",
            unit->GetId(),source,goal.x,goal.z,s.fallback.boundary.radius,home.x,home.z,
            s.fallback.goal.x,s.fallback.goal.z,s.fallback.planned,int(s.mode));
}

void CCommanderController::PlanFallback(CCircuitUnit* unit,State& s,int frame) {
    const bool firstPlan=s.fallback.planned<0;
    const bool heldRear=s.fallback.planned>=0 && s.fallback.porc<0;
    s.fallback.planned=frame;
    const AIFloat3 pos=unit->GetPos(frame), home=ai->GetSetupManager()->GetBasePos();
    const Point threat=P(s.fallback.threat);
    const Point axis=commander::Normal(threat-P(home));
    // Positions along base -> threat. A line holds until the group is past it.
    const float threatEdge=commander::Dot(threat-P(home),axis);
    const float commanderEdge=commander::Dot(P(pos)-P(home),axis);
    auto* battle=ai->GetBattle();
    const bool lane=battle->GetFrontLaneLength()>0.f;
    const float ownProgress=lane?battle->GetFrontLaneProgress(pos):0.f;
    const float moveSpeed=std::max(1.f,ai->GetMilitaryManager()->GetRangedWorld()
        ->CapabilitiesFor(unit->GetCircuitDef()).speed);
    const float margin=unit->GetCircuitDef()->GetRadius()+cfg->fallback.offset;
    const auto safeStation=[&](AIFloat3 at) {
        if(!OnMap(at)) return false;
        const float arrival=at.distance2D(pos)/moveSpeed;
        // Local observed/remembered weapon facts, never hidden enemy positions.
        // No construction station inside range just because a weapon is reloading.
        for(const auto& t:threats) if(!commander::FallbackClear(P(at),t.pos,t.velocity,
            t.range+t.splash,margin,arrival,cfg->fallback.prepareSeconds)) return false;
        const float rememberedReach=s.fallback.reach>0.f?s.fallback.reach
            :(threats.empty()?cfg->fallback.groupRadius:0.f);
        if(rememberedReach>0.f && !commander::FallbackClear(P(at),threat,{},rememberedReach,margin,0.f,0.f)) return false;
        // Defer engine height/reach callbacks until cheap weapon tests admit.
        at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
        return ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat
            && ai->GetTerrainManager()->CanReachAt(unit,at,64.f);
    };
    const auto safeLeg=[&](Point from,Point to) {
        for(const auto& t:threats) if(!commander::FallbackLegClear(from,to,t.pos,
            t.range+t.splash+unit->GetCircuitDef()->GetRadius())) return false;
        return true;
    };
    const auto safeLaneRoute=[&](const AIFloat3& at) {
        const float end=battle->GetFrontLaneProgress(at);
        const int steps=std::clamp(int(std::ceil(std::abs(ownProgress-end)/64.f)),1,32);
        Point previous=P(pos);
        for(int i=1;i<=steps;++i) {
            const Point next=i==steps?P(at):P(battle->GetFrontLanePoint(ownProgress+(end-ownProgress)*float(i)/steps));
            if(!safeLeg(previous,next))return false;
            previous=next;
        }
        return true;
    };
    std::optional<Point> localStation;
    if(lane) {
        // Existing 1 Hz fallback cadence; <=33 cheap station assessments, with
        // reachability only after weapon clearance. No map-wide search or new
        // collection. Retain a safe reached goal: loss of LOS cannot ratchet it
        // backwards every second. Tests: commander_fallback_test.
        if(!firstPlan && s.fallback.goal.x>=0
            && battle->GetFrontLaneDistance(s.fallback.goal)<=battle->GetFrontLaneWidth()
            && battle->GetFrontLaneProgress(s.fallback.goal)<=ownProgress+64.f
            && pos.distance2D(s.fallback.goal)<=cfg->fallback.search && safeStation(s.fallback.goal)
            && safeLaneRoute(s.fallback.goal)) {
            localStation=P(s.fallback.goal);
        } else {
            Point previous=P(pos); bool clearRoute=true;
            localStation=commander::NearestFallback(ownProgress,cfg->fallback.search,
                std::max(64.f,cfg->fallback.offset),
                [&](float progress) {return P(battle->GetFrontLanePoint(progress));},
                [&](Point p) {
                    clearRoute=clearRoute && safeLeg(previous,p);previous=p;
                    if(!clearRoute)return false;
                    return safeStation(F(p));
                });
        }
    }
    porcs.clear();
    // O(N) over the ally team's cached friendly snapshot (own and allied),
    // once per second per commander and only while a fallback is active.
    // Static positions do not move; a candidate is revalidated before use.
    if(!localStation) for(const auto& [id,ally]:ai->GetFriendlyUnits()) {
        auto* d=ally->GetCircuitDef();
        if(!d || d->IsMobile() || !d->IsAttacker() || d->GetMaxRange()>cfg->fallback.porcRange) continue;
        const AIFloat3& p=ally->GetPos(frame);
        const float distance=p.distance2D(pos);
        const bool held=id==s.fallback.heldPorc && frame<s.fallback.heldPorcUntil;
        if(distance>cfg->fallback.search && !held) continue;
        // Outer edge of allied territory: furthest along base -> threat, but
        // not overrun (the group is not past it) and not ahead of the
        // commander by more than the stand-off it keeps behind the line.
        // Comparing raw distances to the group instead dropped a line the
        // commander was holding as soon as it stood behind it (b01 arena).
        const float edge=commander::Dot(P(p)-P(home),axis);
        // +64: the stand-off point is offset away from the group, not exactly
        // along the axis, so a held line must not fall out by rounding.
        // KI-609 hysteresis: the porc already held stays a candidate while
        // the group is not past it, even when the commander's own stand-off
        // moves it out of the ahead-window; otherwise the plan flipped every
        // second between this line and the home rear station (perimeter 120).
        // A held porc also tolerates the group's centroid jitter: it is
        // overrun only once the group is a full group radius past it.
        if(held ? edge>=threatEdge+cfg->fallback.groupRadius
            : (edge>=threatEdge || edge>commanderEdge+cfg->fallback.offset+64.f)) continue;
        porcs.push_back({p,edge,distance,id});
    }
    const auto order=[](const PorcCandidate& a,const PorcCandidate& b) {
        if(a.edge!=b.edge) return a.edge>b.edge;
        if(a.distance!=b.distance) return a.distance<b.distance;
        return a.id<b.id;
    };
    const size_t tried=std::min<size_t>(4,porcs.size());
    std::partial_sort(porcs.begin(),porcs.begin()+tried,porcs.end(),order);
    int chosen=-1; AIFloat3 goal=home,line=home; float perimeter=cfg->fallback.offset;
    if(localStation) {
        goal=F(*localStation);goal.y=ai->GetMap()->GetElevationAt(goal.x,goal.z);
        line=goal;perimeter=std::max(cfg->fallback.offset,goal.distance2D(home));
    }
    for(size_t i=0;i<tried;++i) {
        auto* ally=ai->GetFriendlyUnit(porcs[i].id);
        if(!ally || ally->GetUnit()->GetHealth()<=0 || ally->GetUnit()->IsBeingBuilt()) continue;
        const AIFloat3& p=porcs[i].pos;
        // Stand behind the porc as seen from the group, inside its cover.
        const Point away=commander::Normal(P(p)-threat);
        AIFloat3 candidate=F(P(p)+away*cfg->fallback.offset);
        candidate.y=ai->GetMap()->GetElevationAt(candidate.x,candidate.z);
        if(!OnMap(candidate) || !ai->GetTerrainManager()->CanReachAt(unit,candidate,64)) continue;
        if(lane && (battle->GetFrontLaneDistance(candidate)>battle->GetFrontLaneWidth()
            || battle->GetFrontLaneProgress(candidate)>ownProgress+64.f
            || !safeStation(candidate) || !safeLaneRoute(candidate))) continue;
        chosen=porcs[i].id; goal=candidate; line=p;
        perimeter=p.distance2D(home)+cfg->fallback.offset;
        break;
    }
    if(chosen<0 && !localStation) {
        // Home is an anchor, not guaranteed cover: an incoming T3 can already
        // reach it. Without a surviving porc, take a bounded rearward station
        // instead of standing on the start point under fire. Replanned at the
        // existing 1 Hz cadence; at most four reachability checks, no new army
        // scan. The engine routes this withdrawal around obstacles, as it does
        // the ordinary porc fallback (not a straight-line combat sidestep).
        // Once the enemy crosses home, the home->threat axis reverses. A
        // retreat must still move away from the threat relative to the unit.
        // Keep the previous rear station as the origin while it remains behind
        // us; lost LOS cannot pull that station forward or restart a march.
        const Point away=commander::Normal(P(pos)-threat);
        Point origin=heldRear?P(s.fallback.goal):P(home);
        if(commander::Dot(origin-P(pos),away)<0.f) origin=P(pos);
        float clearance=heldRear?0.f:cfg->fallback.offset;
        clearance=std::max(clearance,s.fallback.reach+unit->GetCircuitDef()->GetRadius()+64.f
            -commander::Length(threat-origin));
        for(const auto& t:threats) clearance=std::max(clearance,
            t.range+t.splash+unit->GetCircuitDef()->GetRadius()+64.f-commander::Length(t.pos-origin));
        clearance=std::min(clearance,cfg->fallback.search);
        for(float scale:{1.f,.75f,.5f,.25f}) {
            AIFloat3 candidate=F(origin+away*(clearance*scale));
            candidate.y=ai->GetMap()->GetElevationAt(candidate.x,candidate.z);
            if(!OnMap(candidate) || !ai->GetTerrainManager()->CanReachAt(unit,candidate,64)) continue;
            goal=candidate;perimeter=std::max(cfg->fallback.offset,goal.distance2D(home));break;
        }
        goal.y=ai->GetMap()->GetElevationAt(goal.x,goal.z);
    }
    // Keep a firing station chosen along the same line (Fallback sidesteps
    // out of the porc's own D-gun lane); replanning must not walk it back.
    if(chosen>=0 && chosen==s.fallback.porc && s.fallback.goal.SqDistance2D(goal)<=SQUARE(2.f*cfg->combat.step+16.f)
        && s.fallback.goal.SqDistance2D(home)<=SQUARE(perimeter)) goal=s.fallback.goal;
    // Owner 2026-10-19: a goal stands for fallback_goal_hold_seconds before a
    // replan may move it (it flipped every second between a porc and the rear
    // station). The first plan, and a held goal that is no longer reachable,
    // change at once; the perimeter keeps the held goal's.
    if(cfg->fallback.goalHoldSeconds>0 && !firstPlan && goal.SqDistance2D(s.fallback.goal)>64.f*64.f
        && frame<s.fallback.goalSince+int(cfg->fallback.goalHoldSeconds*FRAMES_PER_SEC)
        && safeStation(s.fallback.goal)
        && (!lane || (battle->GetFrontLaneDistance(s.fallback.goal)<=battle->GetFrontLaneWidth()
            && battle->GetFrontLaneProgress(s.fallback.goal)<=ownProgress+64.f
            && pos.distance2D(s.fallback.goal)<=cfg->fallback.search && safeLaneRoute(s.fallback.goal)))) {
        goal=s.fallback.goal; chosen=s.fallback.porc;
        perimeter=std::max(perimeter,s.fallback.boundary.radius);
        if(chosen>=0) if(auto* held=ai->GetFriendlyUnit(chosen)) line=held->GetUnit()->GetPos();
    }
    if(firstPlan || chosen!=s.fallback.porc || goal.SqDistance2D(s.fallback.goal)>64.f*64.f) {
        s.fallback.goalSince=frame;
        ai->LOG("[CommanderFallback] unit=%i line porc=%i goal=%.0f,%.0f perimeter=%.0f candidates=%i source=%s",
            unit->GetId(),chosen,goal.x,goal.z,perimeter,int(porcs.size()),localStation?"lane":(chosen>=0?"porc":"emergency"));
        s.route.clear();
        // Do not abandon a reachable exit halfway through its journey merely
        // because spotters died. The deadline is bounded by planned travel plus
        // observation memory, and changes only with a materially new goal.
        const float speed=std::max(1.f,ai->GetMilitaryManager()->GetRangedWorld()
            ->CapabilitiesFor(unit->GetCircuitDef()).speed);
        s.fallback.moveUntil=frame+int((goal.distance2D(pos)/speed+cfg->combat.sensorMemory)*FRAMES_PER_SEC);
    }
    s.fallback.porc=chosen; s.fallback.goal=goal; s.fallback.boundary={P(home),perimeter};
    if(chosen>=0) { s.fallback.heldPorc=chosen; s.fallback.heldPorcUntil=frame+5*FRAMES_PER_SEC; }
    // D-299: the line the commander's turrets join is the porc, or the rear
    // station when no porc survives; it outlives the fallback by line_hold.
    if(chosen<0) line=goal;
    if(line.SqDistance2D(s.work.lineAnchor)>cfg->work.lineRadius*cfg->work.lineRadius) s.work.lineDone=false;
    s.work.lineAnchor=line; s.work.lineThreat=s.fallback.threat;
}

bool CCommanderController::RetreatStation(CCircuitUnit* unit,AIFloat3& goal) const {
    if(!Handles(unit)) return false;
    const State* found=states.Find(unit->GetId());
    if(!found) return false;
    Bind bound(this,found->preset);
    const auto& s=*found;
    if(s.retreat.energy && s.retreat.energyGoal.x>=0) {goal=s.retreat.energyGoal;return true;}
    if(s.retreat.health && s.retreat.healthGoal.x>=0) {goal=s.retreat.healthGoal;return true;}
    const int frame=ai->GetLastFrame();
    // Borrow only a freshly planned, reachable fallback point. The controller
    // owns/invalidate it; RetreatTask keeps its task and repairer ownership.
    // O(log C) state lookup, no extra threat or friendly-unit scan.
    if(!FallbackActive(s,frame) || s.fallback.planned<0 || frame-s.fallback.planned>2*FRAMES_PER_SEC) return false;
    goal=s.fallback.goal;return true;
}

bool CCommanderController::Fallback(CCircuitUnit* unit,State& s,IUnitTask* current,int frame) {
    performance::Scope measured(ai,performance::COMMANDER_FALLBACK);
    auto* task=dynamic_cast<CControlledTask*>(current);
    const AIFloat3 pos=unit->GetPos(frame);
    auto* def=unit->GetCircuitDef();
    if(role.fallback) {
        const float range=std::max(unit->GetDGunRange(),def->GetMaxRange(CCircuitDef::RangeType::LAND));
        const auto group=commander::StrongestGroup(attackers,P(pos),range*cfg->fallback.rangeScale,cfg->fallback.groupRadius);
        // T3 groups reach here only when the D-294 engagement declined them
        // (no cloak, detected, unfunded or low health): then withdraw.
        const bool threatened=group.metal>=cfg->fallback.metal;
        if(threatened) {
            s.fallback.until=frame+int(cfg->fallback.holdSeconds*FRAMES_PER_SEC);
            s.fallback.metal=group.metal; s.fallback.threat=F(group.centre);
            if(!s.fallback.active) {
                s.fallback.active=true; s.fallback.planned=-10000; s.fallback.porc=-1; s.fallback.reach=0;
                ai->LOG("[CommanderFallback] unit=%i on metal=%.0f group=%.0f,%.0f reach=%.0f frame=%i",
                    unit->GetId(),group.metal,group.centre.x,group.centre.z,range*cfg->fallback.rangeScale,frame);
            }
        }
    }
    // Lost spotters do not make an ongoing withdrawal safe: a remembered
    // artillery threat can still be landing shells between reloads. Retain the
    // existing fallback owner/goal for the configured observation-memory
    // window after actual damage. O(1), using the damage callback timestamp;
    // no hidden target query or additional observation cadence (corves arena).
    // Explicit policy disable wins over remembered damage and travel. The
    // setter expires the lease; renewing it here would silently defer release
    // until arrival (commander-fallback-disable arena). No new cadence/work.
    if(role.fallback && s.fallback.active) s.fallback.until=std::max(s.fallback.until,
        s.lastDamage+int(cfg->combat.sensorMemory*FRAMES_PER_SEC));
    if(role.fallback && s.fallback.active && frame<s.fallback.moveUntil && pos.SqDistance2D(s.fallback.goal)>64.f*64.f)
        s.fallback.until=std::max(s.fallback.until,frame+int(cfg->fallback.holdSeconds*FRAMES_PER_SEC));
    // Intercept also extends remembered T3 fallback leases before this call;
    // disabling policy must release regardless of which path renewed one.
    if(s.fallback.active && (!role.fallback || frame>=s.fallback.until)) {
        s.fallback.active=false; s.fallback.porc=-1; s.fallback.reach=0; s.fallback.moveUntil=-1;
        if(LadderActive()) s.work.lineUntil=frame+int(cfg->work.lineHoldSeconds*FRAMES_PER_SEC);
        ai->LOG("[CommanderFallback] unit=%i off frame=%i",unit->GetId(),frame);
        if(task && s.mode==Mode::FALLBACK) {
            Transition(unit,s,Mode::SUPPORT,frame);
            s.retry=frame+15; task->Resume(unit); return true;
        }
        return false;
    }
    if(!s.fallback.active) return false;
    if(!role.fallback)
        ai->LOG("[INVARIANT] INV-217 disabled commander fallback retained unit=%i frame=%i",unit->GetId(),frame);
    if(frame>=s.fallback.planned+FRAMES_PER_SEC) PlanFallback(unit,s,frame);
    // Native retreat retains ownership, but uses this exact withdrawal point
    // rather than stopping at its broad repair radius under the declined T3.
    if(!task && current->GetType()==IUnitTask::Type::RETREAT) return false;
    if(task && s.pending>=0) {
        // Let an issued shot resolve (bounded at one second) before moving.
        if(unit->GetDGunReloadFrame()>frame) { s.fired=frame; s.pending=-1; }
        else if(frame-s.pending>30) {
            s.pending=-1; s.leaseUntil=0;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        } else return true;
    }
    // D-299: on the line with no shot, the work ladder (line turrets, repair,
    // reclaim, radar, assist) runs under its builder task, filtered to the
    // perimeter. Combat ownership returns the moment a shot is worth taking.
    const bool working=!task && LineWorking(unit,s,current,frame);
    const auto seize=[&]() {
        // A safety withdrawal, like a defensive shot, may interrupt
        // no-disrupt construction; enemy reclaim was excluded by Tick.
        task=ai->GetBuilderManager()->EnqueueControlled(this,current);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); task=nullptr; return false; }
        s.started=frame; s.exit=s.fallback.goal; s.failed=0; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
        writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"engage");
        TRY_UNIT(ai,unit,unit->CmdStop();)
        return true;
    };
    if(!task && !working && !seize()) return true;
    if(task && (unit->GetDGunAct()!=nullptr || task->GetAssignees().size()!=1 || task->GetAssignees().count(unit)!=1)) {
        ai->LOG("[INVARIANT] INV-214 commander fallback has competing owner unit=%i",unit->GetId());
        task->Resume(unit); return true;
    }
    const bool inside=s.fallback.boundary.Contains(P(pos),64.f);
    if(task) {
        s.budget=0; s.deployed=false;
        Transition(unit,s,Mode::FALLBACK,frame);
        // Disengage cloaked when it is funded: while travelling to the line,
        // and on the line while the threat outranges the commander's own
        // weapon (lasers achieve nothing there and only reveal it). The
        // D-gun shot itself decloaks. Otherwise fire is open on the line.
        const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
        const float ownRange=def->GetMaxRange(CCircuitDef::RangeType::LAND);
        float enemyRange=0;
        for(const auto& t:threats)
            if(commander::Length(t.pos-P(pos))<=t.range+t.splash+64.f) enemyRange=std::max(enemyRange,t.range);
        const bool travelling=s.fallback.goal.SqDistance2D(pos)>64.f*64.f;
        const bool funded=ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve)
            >=def->GetDGunDef()->GetCostE()+cap.cloakMoving*cfg->combat.escapeSeconds;
        const bool canHide=cap.cloak && funded && unit->GetUnit()->GetRulesParamFloat("cannotcloak",0)<=0;
        Conceal(unit,s,canHide && (travelling || enemyRange>ownRange+50.f));
    }
    if(!seeds.empty()) {
        // D-gun from the line, never forward of it. The stand-off point sits
        // directly behind a porc, so that porc vetoes its own lane; sidestep
        // along the line (perpendicular to the threat, inside the perimeter)
        // to a clear lane. Five stations x <=12 seeds, each O(E+F), as Tick.
        const float range=unit->GetDGunRange()-12;
        const float speed=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
        const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
        const float moveSpeed=std::max(1.f,ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def).speed);
        const Point toThreat=commander::Normal(P(s.fallback.threat)-P(pos));
        const Point lateral{-toThreat.z,toThreat.x};
        const std::array<float,5> sides={0.f,1.f,-1.f,2.f,-2.f};
        commander::Line best; AIFloat3 bestPos=pos;
        for(float side:sides) {
            // Outside the perimeter (still walking back) only a standing shot
            // is legal: never turn away from a target already in D-gun range.
            if(!inside && side!=0.f) continue;
            AIFloat3 station=F(P(pos)+lateral*(side*cfg->combat.step));
            station.y=ai->GetMap()->GetElevationAt(station.x,station.z);
            // The D-gun cannot fire submerged (firesubmersed=false), standing
            // spot included.
            if(station.y<0 || (side!=0.f && (!s.fallback.boundary.Contains(P(station))
                || !Route(unit,pos,station)))) continue;
            const float travel=std::abs(side)*cfg->combat.step/moveSpeed;
            for(int index:seeds) {
                const auto& seed=contacts[index];
                if(std::abs(seed.height-std::max(0.f,station.y))>range*.5f) continue;
                const Point dir=seed.pos+seed.velocity*(commander::Length(seed.pos-P(station))/speed)-P(station);
                auto line=commander::ScoreLine(contacts,P(station),dir,range,speed,width,
                    cfg->combat.killReward,cfg->combat.friendlyMargin);
                line.value-=travel*60.f;
                if(line.value>best.value) { best=line; bestPos=station; }
            }
        }
        const float minValue=commander::MinimumValue(cfg->combat.minValue,
            ai->GetMilitaryManager()->GetAggression(),cfg->combat.aggression);
        if(best.target>=0 && best.value>=minValue) {
            if(!task) {
                if(!seize()) return true;
                s.budget=0; s.deployed=false; Transition(unit,s,Mode::FALLBACK,frame);
            }
            const float spendable=ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve);
            if(bestPos.SqDistance2D(pos)<16.f*16.f) {
                if(unit->IsDGunReady(frame,spendable) && frame>=s.retry && Fire(unit,s,best,frame)) return true;
            } else {
                // Hold the clear lane between shots; PlanFallback keeps it.
                s.fallback.goal=bestPos; Move(unit,s,bestPos,frame); return true;
            }
        }
    }
    if(working) {
        // INV-218: line work never keeps the commander outside the perimeter.
        // Walking back in after the perimeter shrank is allowed 10 s.
        if(s.fallback.boundary.Contains(P(pos),std::max(400.f,def->GetBuildDistance()+96.f))) s.work.lineOutside=-1; // guard/assist drift
        else if(s.work.lineOutside<0) s.work.lineOutside=frame;
        else if(frame-s.work.lineOutside>10*FRAMES_PER_SEC) {
            ai->LOG("[INVARIANT] INV-218 commander line work outside fallback perimeter unit=%i x=%.0f z=%.0f perimeter=%.0f",
                unit->GetId(),pos.x,pos.z,s.fallback.boundary.radius);
            s.work.lineOutside=frame;
        }
        return true;
    }
    if(s.fallback.goal.SqDistance2D(pos)>64.f*64.f) { Move(unit,s,s.fallback.goal,frame); return true; }
    if(LadderActive() && inside && s.pending<0 && frame>=s.work.lineRetry) {
        // Bounded hand-over: if the ladder offers nothing inside the
        // perimeter the next tick seizes back, and the next yield waits
        // line_retry_seconds (at most two orders per retry window).
        s.work.lineRetry=frame+int(cfg->work.lineRetrySeconds*FRAMES_PER_SEC); s.work.lineYield=frame;
        Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame);
        ai->LOG("[CommanderWork] unit=%i line yield porc=%i x=%.0f z=%.0f",unit->GetId(),s.fallback.porc,pos.x,pos.z);
        task->Handover(unit);
    }
    return true;
}
}
