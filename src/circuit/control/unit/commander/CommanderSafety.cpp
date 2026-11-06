#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/FactoryManager.h"
#include "module/MilitaryManager.h"
#include "task/fighter/RangedWorld.h"
#include "unit/ally/AllyUnit.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitDef.h"
#include "spring/SpringCallback.h"
#include "AISCommands.h"
#include <cstring>
#include "control/core/ControlledTask.h"
#include "task/RetreatTask.h"
#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "setup/SetupManager.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "CircuitAI.h"
#include "util/math/Geometry.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {
using springai::AIFloat3;
using commander::Point;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }

bool CCommanderController::HealthRetreat(CCircuitUnit* unit) const {
    if(!Handles(unit)) return false;
    const State* found=states.Find(unit->GetId());
    Bind bound(this,found?found->preset:0);
    const float threshold=commander::RetreatHealth(ActualDecoy(unit->GetCircuitDef()),
        cfg->safety.healthRetreat,cfg->safety.decoyHealthRetreat);
    return commander::HealthWithdrawal(unit->GetHealthPercent(),threshold,found && found->retreat.health);
}

bool CCommanderController::T3Exempt(CCircuitUnit* unit,const State& s,int frame) const {
    // Owner 2026-11-06: under the doctrine a T3 is shot in reach (Doctrine, before
    // every withdrawal) or approached by its 2-second rule; nothing else is exempt.
    if(DoctrineOn(unit)) return false;
    if(s.t3.target>=0) return true; // an engaged T3 plan: approach, angle, shot
    if(unit->GetUnit()->GetPos().y<0.f) return false; // no submerged D-gun
    const float reach=unit->GetDGunRange()+cfg->combat.maxApproach;
    const Point here=P(unit->GetPos(frame));
    for(const auto& c:contacts)
        if(c.t3 && !c.friendly && c.targetable && commander::Length(c.pos-here)<=reach+c.radius)
            return unit->IsDGunReady(frame,ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve));
    return false;
}

bool CCommanderController::HealthControl(CCircuitUnit* unit,State& s,int frame) {
    const bool decoy=ActualDecoy(unit->GetCircuitDef());
    const float threshold=commander::RetreatHealth(decoy,cfg->safety.healthRetreat,cfg->safety.decoyHealthRetreat);
    // Owner 2026-11-01: retreat under health_retreat (30%) until health_recover (70%).
    const float recover=decoy?cfg->safety.decoyHealthRecover
        :cfg->safety.healthRecover>0?cfg->safety.healthRecover:cfg->combat.recover;
    if(commander::HealthRecovered(unit->GetHealthPercent(),threshold,recover)) {
        if(s.retreat.health) ai->LOG("[CommanderSafety] unit=%i action=health_recovered hp=%.3f",unit->GetId(),unit->GetHealthPercent());
        s.retreat.health=false;s.retreat.healthGoal={-1,0,-1};s.retreat.healthShotUntil=-1;return false;
    }
    if(!HealthRetreat(unit)) return false;
    // Priority 1 is a D-gun on a nearby T3 (the T3 plan and its immediate shot
    // run after this); priority 2 is this retreat, over every other owner.
    if(!decoy && T3Exempt(unit,s,frame)) {
        if(frame>=s.lastLog+60) { s.lastLog=frame; ai->LOG("[CommanderSafety] unit=%i action=low_health_t3_dgun hp=%.3f target=%i",
            unit->GetId(),unit->GetHealthPercent(),s.t3.target); }
        return false;
    }
    const auto pos=unit->GetPos(frame);
    auto* def=unit->GetCircuitDef();
    const float window=decoy?0.f:cfg->safety.healthShotSeconds;
    const bool recentDamage=s.lastDamage>=0 && frame-s.lastDamage<FRAMES_PER_SEC;
    // An actual cloak and a clear in-range T3 shot are required. Never hand a
    // low-health exception to the general jammer controller (which can chase
    // heavy T2s). One finite aiming window per retreat; no lease renewal loop.
    if(!s.retreat.health && window>0 && !recentDamage && unit->GetUnit()->IsCloaked()
        && RetreatCloakFunded(unit) && CloakSafe(unit,P(pos),P(pos),window)
        && Exposure(P(pos),P(pos),window,pos.y,true,0.f)<unit->GetUnit()->GetHealth()*.1f
        && (s.retreat.healthShotUntil<0 || frame<s.retreat.healthShotUntil)) {
        const float range=unit->GetDGunRange()-12.f;
        const float speed=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
        const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
        for(const auto& c:contacts) {
            if(!c.t3 || c.friendly || c.blocker || !c.targetable || (c.reserved && c.id!=s.target)) continue;
            const auto lead=c.pos+c.velocity*(commander::Length(c.pos-P(pos))/speed);
            auto line=commander::ScoreLine(contacts,P(pos),lead-P(pos),range,speed,width,
                cfg->combat.killReward,cfg->combat.friendlyMargin,c.id);
            if(!line.requiredHit || line.blocked || unit->GetDGunReloadFrame()>frame+int(window*FRAMES_PER_SEC)) continue;
            auto* task=dynamic_cast<CControlledTask*>(unit->GetTask());
            if(!task) {
                task=ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
                ai->GetBuilderManager()->AssignTask(unit,task);
                if(unit->GetTask()!=task) {ai->GetBuilderManager()->AbortTask(task);break;}
            }
            if(s.retreat.healthShotUntil<0) {
                s.retreat.healthShotUntil=frame+int(window*FRAMES_PER_SEC);
                TRY_UNIT(ai,unit,unit->CmdStop();)
                s.route.clear();s.deployed=false;
                ai->LOG("[CommanderSafety] unit=%i action=cloaked_t3_wait target=%i",unit->GetId(),c.id);
            }
            Conceal(unit,s,true);
            s.budget=def->GetDGunDef()->GetCostE();
            // Keep the current shot lease until it fires; every next tick still
            // checks cloak, damage and the finite deadline above.
            if(s.pending>=0 && unit->GetDGunReloadFrame()<=frame) return true;
            if(unit->IsDGunReady(frame,ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve))) {
                line.target=c.id;
                if(!Fire(unit,s,line,frame)) break; // shared blast/friendly-fire admission
            }
            return true;
        }
    }
    if(!s.retreat.health) ai->LOG("[CommanderSafety] unit=%i action=health_retreat hp=%.3f frame=%i",
        unit->GetId(),unit->GetHealthPercent(),frame);
    s.retreat.health=true;s.budget=0;s.fundingBudget=0;s.pending=-1;s.leaseUntil=0;
    s.deployed=false;s.work.task=nullptr;s.work.reach=0;s.route.clear();
    ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
    EndT3(unit,s,frame,"low_health");
    auto* battle=ai->GetBattle();
    const bool threatened=recentDamage || Exposure(P(pos),P(pos),cfg->combat.escapeSeconds,pos.y)>0;
    // At most eight endpoint/path assessments per second while escaping.
    // Prefer visible rearward lane space; never query hidden enemy positions.
    // Keep a safe reached station rather than continuously walking to base.
    // Owner 2026-11-01 (Mescaline, team 14): a calm commander no longer parks at
    // a local station at 5-38% health; with nothing shooting or in reach it walks
    // to the closest haven (factory nanos and base repairers) until recovered.
    if(!threatened && frame>=s.retreat.healthPlan+FRAMES_PER_SEC) {
        s.retreat.healthPlan=frame;
        AIFloat3 haven=ai->GetFactoryManager()->GetClosestHaven(unit);
        if(!geom::is_valid(haven)) haven=ai->GetSetupManager()->GetBasePos();
        if(s.retreat.healthGoal.SqDistance2D(haven)>SQUARE(200.f)) {
            haven.y=ai->GetMap()->GetElevationAt(haven.x,haven.z);
            s.retreat.healthGoal=haven;
            ai->LOG("[CommanderSafety] unit=%i retreat_haven=%.0f,%.0f hp=%.3f",unit->GetId(),haven.x,haven.z,unit->GetHealthPercent());
        }
    } else if(frame>=s.retreat.healthPlan+FRAMES_PER_SEC && (s.retreat.healthGoal.x<0
        || threatened
        || !battle->InLos(s.retreat.healthGoal)
        || Exposure(P(s.retreat.healthGoal),P(s.retreat.healthGoal),cfg->combat.escapeSeconds,s.retreat.healthGoal.y)>0)) {
        s.retreat.healthPlan=frame;
        const bool lane=battle->GetFrontLaneLength()>0;
        const float own=lane?battle->GetFrontLaneProgress(pos):0;
        const auto rear=lane?battle->GetFrontLanePoint(std::max(0.f,own-cfg->safety.cloakRetreatDistance))
            :ai->GetSetupManager()->GetBasePos();
        Point away=commander::Normal(P(rear)-P(pos));
        if(commander::Length(away)<.1f) away={0,-1};
        float best=1e30f;
        for(int i=0;i<8;++i) {
            const float angle=i*.785398163f;
            const Point direction{away.x*std::cos(angle)-away.z*std::sin(angle),
                away.x*std::sin(angle)+away.z*std::cos(angle)};
            const float step=std::min(cfg->safety.cloakRetreatDistance,std::max(128.f,def->GetLosRadius()*.65f));
            const Point end=P(pos)+direction*step;
            AIFloat3 at(end.x,0,end.z);
            if(!OnMap(at)) continue;
            at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
            if(!ai->GetTerrainManager()->CanReachAt(unit,at,64.f)) continue;
            const float risk=Exposure(P(pos),P(at),cfg->combat.escapeSeconds,pos.y)
                +4.f*Exposure(P(at),P(at),cfg->combat.escapeSeconds,at.y);
            int fog=0;
            for(int sample=0;sample<8;++sample) {
                const float a=sample*.785398163f;
                AIFloat3 probe(at.x+std::cos(a)*step,at.y,at.z+std::sin(a)*step);
                if(OnMap(probe) && !battle->InLos(probe)) ++fog;
            }
            // Visibility dominates equal-exposure choices; progress and lane
            // distance break ties so withdrawing does not become lane hopping.
            const float score=risk*10000.f+(battle->InLos(at)?0.f:100000.f)+fog*1000.f
                +(KeepOutAt(end)?50000.f:0.f) // never retreat into laser tower range
                +(lane?std::max(0.f,battle->GetFrontLaneProgress(at)-own)*100.f
                    +battle->GetFrontLaneDistance(at):0.f)+commander::Length(P(at)-P(rear));
            if(score<best) {best=score;s.retreat.healthGoal=at;}
        }
        if(s.retreat.healthGoal.x>=0) ai->LOG("[CommanderSafety] unit=%i retreat_goal=%.0f,%.0f visible=%i",
            unit->GetId(),s.retreat.healthGoal.x,s.retreat.healthGoal.z,int(battle->InLos(s.retreat.healthGoal)));
    }
    if(unit->GetTask()->GetType()!=IUnitTask::Type::RETREAT)
        ai->GetBuilderManager()->AssignTask(unit,ai->GetBuilderManager()->EnqueueRetreat());
    return true;
}

// ---------------------------------------------------------------------------
// Owner 2026-11-06 retreat doctrine. Runs right after Observe, ahead of the
// energy latch, the priority D-gun, the health retreat, the keep-out
// withdrawal, the jammer engagement and the T3 plan:
//  1. Cloak: a retreat cloaks while the bank keeps a moving cloak running for
//     doctrine_cloak_runway (5) seconds at present income; an active doctrine
//     cloak stays on down to doctrine_cloak_keep (1) s. Fire is held while
//     cloaked, so lasers never decloak it (air, spam).
//  2. Fire it cannot answer (a shooter out of LOS, a visible one beyond laser
//     reach + doctrine_ranged_margin, or aircraft): retreat cloaked, held
//     doctrine_hit_hold (3) s after the last such hit.
//  3. A visible mobile enemy of tier >= doctrine_outrange_tier (2) outranging
//     the laser, the commander inside its reach (+ doctrine_t3_margin) and the
//     enemy beyond D-gun reach + doctrine_t3_close seconds of walking: retreat.
//  4. T3: approached only when D-gun reach is at most doctrine_t3_close (2) s
//     away (its own closing speed counts; never one walking away). After a T3
//     shot the commander retreats until its cloak is back (bounded by
//     doctrine_recloak_seconds), then may take the next one. A T3 whose reach
//     covers the commander is retreated from, unless the commander stands
//     cloaked and undetected, unhit, and every such T3 is walking toward it
//     (it waits for the 2-second window instead).
//  5. Spam: from doctrine_spam_minutes (10), doctrine_spam_count (5) or more
//     spam units (anti-spam names, or T1 armed ground units costing at most
//     doctrine_spam_cost) within doctrine_spam_range (2) x laser reach: retreat
//     to the nearest active friendly jammer and stand still cloaked, fire held.
//  Every retreat D-guns any enemy that walks into D-gun reach (the shared
//  Fire/ScoreLine aim) and keeps walking after the shot (queued move).
// Cost: one pass over the local contacts (already observed) per tick, cached
// matchup/laser-range lookups; goal search (8 reachability probes, or one pass
// over friendly units for jammers in spam mode) at most once a second.
// ---------------------------------------------------------------------------
namespace {
constexpr const char* SPAM_NAMES[]={"corak","armpw","leggob","armflash","corgator","leghades","armflea","corfav","armfav"};
}

bool CCommanderController::DoctrineOn(CCircuitUnit* unit) const {
    return cfg->doctrine.doctrine>0 && unit && !ActualDecoy(unit->GetCircuitDef());
}

float CCommanderController::LaserRange(CCircuitDef* def) {
    auto found=laserRanges.find(def->GetId());
    if(found!=laserRanges.end()) return found->second;
    float range=0;
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    for(const auto& w:cap.weapons) if(w.def!=def->GetDGunDef() && !w.damage.empty()) range=std::max(range,w.range);
    if(range<=0) range=def->GetMaxRange(CCircuitDef::RangeType::LAND);
    return laserRanges.emplace(def->GetId(),range).first->second;
}

bool CCommanderController::IsSpam(CCircuitDef* def,const commander::Contact& c) {
    if(!spamResolved) {
        spamResolved=true;
        for(const char* name:SPAM_NAMES) if(auto* d=ai->GetCircuitDef(name)) spamDefs.insert(d->GetId());
    }
    if(c.friendly || c.blocker || !def->IsMobile() || def->IsAbleToFly() || def->IsRoleComm()) return false;
    if(spamDefs.count(def->GetId())) return true;
    return c.combatTier==1 && def->GetCostM()<=cfg->doctrine.spamCost;
}

float CCommanderController::CloakRunway(CCircuitUnit* unit,bool moving) const {
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(unit->GetCircuitDef());
    if(!cap.cloak) return 0.f;
    auto* economy=ai->GetEconomyManager();
    const float bank=economy->GetEnergyCur();
    // Income left after everything else the team pulls; the cloak spends on top.
    const float surplus=economy->GetAvgEnergyIncome()-economy->GetEnergyPull();
    const float drain=(moving?cap.cloakMoving:cap.cloakCost)-surplus;
    return drain<=1.f?1e9f:bank/drain;
}

bool CCommanderController::DoctrineCloak(CCircuitUnit* unit,State& s,bool moving) {
    auto& d=s.doctrine;
    const float runway=unit->GetCircuitDef()->IsAbleToCloak()?CloakRunway(unit,moving):0.f;
    const bool want=runway>=(d.cloak?cfg->doctrine.cloakKeep:cfg->doctrine.cloakRunway);
    if(want!=d.cloak)
        ai->LOG("[CommanderDoctrine] unit=%i cloak=%i runway=%.1fs moving=%i bank=%.0f",
            unit->GetId(),int(want),std::min(runway,999.f),int(moving),ai->GetEconomyManager()->GetEnergyCur());
    d.cloak=want;
    writer.CloakFrom(unit,want,s.conceal.requested,want?"doctrine":"doctrine_unfunded");
    s.conceal.requested=want;
    return want;
}

bool CCommanderController::DoctrineShot(CCircuitUnit* unit,State& s,int frame,bool t3Only,const AIFloat3* after) {
    const AIFloat3 pos=unit->GetPos(frame);
    if(pos.y<0.f) return false; // BAR D-guns do not fire submerged
    auto* def=unit->GetCircuitDef();
    const float bank=ai->GetEconomyManager()->GetEnergyCur();
    if(!unit->IsDGunReady(frame,bank)) return false; // actual bank: the shot outranks reserves
    const float range=unit->GetDGunRange()-12;
    const float speed=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
    const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
    commander::Line best; const commander::Contact* target=nullptr;
    float bestScore=-1e30f;
    for(const auto& c:contacts) {
        if(c.friendly || c.blocker || !c.targetable || c.reserved) continue;
        if(t3Only && !c.t3) continue;
        auto* enemy=ai->GetEnemyInfo(c.id);
        auto* ed=enemy?enemy->GetCircuitDef():nullptr;
        if(!ed || !ed->IsMobile()) continue; // pursuers, not structures
        const float distance=commander::Length(c.pos-P(pos));
        if(distance>range+c.radius*.5f || std::abs(c.height-std::max(0.f,pos.y))>range*.5f) continue;
        const Point lead=c.pos+c.velocity*(distance/speed);
        if(commander::Length(lead-P(pos))<.5f) continue;
        auto line=commander::ScoreLine(contacts,P(pos),lead-P(pos),range,speed,width,
            cfg->combat.killReward,cfg->combat.friendlyMargin,c.id);
        // A T3 is worth friendly losses in the lane (the priority D-gun rule);
        // anything else is not.
        if(!line.requiredHit || (line.blocked && !c.t3)) continue;
        bool commanderInLane=false;
        for(const auto& f:contacts) {
            if(!f.friendly || !f.blocker) continue;
            const float along=commander::Dot(f.pos-P(pos),line.direction);
            const Point dd=f.pos+f.velocity*(std::max(0.f,along)/speed)-P(pos);
            if(commander::Dot(dd,line.direction)>=0 && commander::Intersects(dd,line.direction,range,f.radius+width+cfg->combat.friendlyMargin)) {
                commanderInLane=true; break;
            }
        }
        if(commanderInLane) continue;
        // T3 first, then the most metal the lane kills, then the nearest.
        const float score=(c.t3?1e6f:0.f)+line.value+c.cost*.1f-distance*.01f;
        if(score>bestScore) { bestScore=score; best=line; best.target=c.id; best.requiredHit=true; target=&c; }
    }
    if(!target) return false;
    auto* task=dynamic_cast<CControlledTask*>(unit->GetTask());
    if(!task) {
        task=ai->GetBuilderManager()->EnqueueControlled(this,unit->GetTask());
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
        s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); s.failed=0; ++operation;
        writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"doctrine");
    }
    if(task->GetAssignees().size()!=1 || !task->GetAssignees().count(unit) || unit->GetDGunAct()) return false;
    const bool t3=target->t3; const int id=target->id; const float cost=target->cost;
    if(!Fire(unit,s,best,frame,false,false,true)) return false;
    auto& d=s.doctrine;
    d.shot=frame; d.shotTarget=id;
    if(t3) d.recloakUntil=frame+int(cfg->doctrine.recloakSeconds*FRAMES_PER_SEC);
    // Keep walking once the shot is away: the move waits behind the D-gun order.
    if(after && OnMap(*after) && after->SqDistance2D(pos)>SQUARE(32.f)) {
        TRY_UNIT(ai,unit,unit->CmdMoveTo(*after,UNIT_COMMAND_OPTION_SHIFT_KEY,frame+20*FRAMES_PER_SEC);)
    }
    ai->LOG("[CommanderDoctrine] unit=%i action=dgun target=%i t3=%i cost=%.0f retreating=%i reason=%s frame=%i",
        unit->GetId(),id,int(t3),cost,int(after!=nullptr),d.active?d.reason:"none",frame);
    return true;
}

AIFloat3 CCommanderController::DoctrineGoal(CCircuitUnit* unit,State& s,const AIFloat3& pos,Point threat,bool spam,int frame) {
    const Point here=P(pos);
    const AIFloat3 home=ai->GetSetupManager()->GetBasePos();
    auto* battle=ai->GetBattle();
    const bool lane=battle->GetFrontLaneLength()>0;
    const AIFloat3 rear=lane?battle->GetFrontLanePoint(std::max(0.f,battle->GetFrontLaneProgress(pos)-cfg->doctrine.step)):home;
    Point away=threat.x>=0?commander::Normal(here-threat):Point{};
    if(commander::Length(away)<.1f) away=commander::Normal(P(rear)-here);
    if(commander::Length(away)<.1f) away=commander::Normal(P(home)-here);
    if(commander::Length(away)<.1f) away={0,-1};
    if(spam && cfg->doctrine.jammerSearch>0) {
        // The nearest live friendly jammer, not one on the spam's side of us.
        InitJammerRadii();
        float bestScore=1e30f; AIFloat3 best{-1,0,-1};
        for(const auto& [id,ally]:ai->GetFriendlyUnits()) {
            auto* fd=ally?ally->GetCircuitDef():nullptr;
            if(!fd || size_t(fd->GetId())>=jammerRadii.size() || jammerRadii[fd->GetId()]<=0) continue;
            if(ally->GetUnit()->IsBeingBuilt() || !ai->GetUnitAPI()->IsActiveSensor(id)) continue;
            const AIFloat3 at=ally->GetPos(frame);
            if(!OnMap(at)) continue;
            const float distance=commander::Length(P(at)-here);
            if(distance>cfg->doctrine.jammerSearch) continue;
            const float toward=threat.x>=0?commander::Dot(P(at)-here,commander::Normal(threat-here)):0.f;
            const float score=distance+2.f*std::max(0.f,toward);
            if(score<bestScore) {
                // Stand inside the disc, on the home side of the jammer.
                Point inside=P(at)+commander::Normal(P(home)-P(at))*std::min(100.f,jammerRadii[fd->GetId()]*.3f);
                AIFloat3 goal(inside.x,0,inside.z);
                CTerrainManager::CorrectPosition(goal);
                goal.y=ai->GetMap()->GetElevationAt(goal.x,goal.z);
                if(!ai->GetTerrainManager()->CanReachAt(unit,goal,64.f)) continue;
                bestScore=score; best=goal;
            }
        }
        if(best.x>=0) return best;
    }
    const Point toRear=commander::Normal(P(rear)-here);
    AIFloat3 best=home; float bestScore=1e30f;
    for(int i=0;i<8;++i) {
        const float angle=float((i+1)/2)*.785398163f*(i%2?1.f:-1.f);
        const Point direction{away.x*std::cos(angle)-away.z*std::sin(angle),away.x*std::sin(angle)+away.z*std::cos(angle)};
        const Point end=here+direction*cfg->doctrine.step;
        AIFloat3 at(end.x,0,end.z);
        if(!OnMap(at)) continue;
        at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
        if(!ai->GetTerrainManager()->CanReachAt(unit,at,64.f)) continue;
        // Away from the threat first, then toward the rear; never into a keep-out disc.
        const float score=(KeepOutAt(end)?10000.f:0.f)+float(i)*100.f-commander::Dot(direction,toRear)*80.f
            +Exposure(end,end,cfg->combat.escapeSeconds,at.y);
        if(score<bestScore) { bestScore=score; best=at; }
    }
    (void)s;
    return best;
}

bool CCommanderController::Doctrine(CCircuitUnit* unit,State& s,int frame) {
    auto& d=s.doctrine;
    auto* current=unit->GetTask();
    auto* task=dynamic_cast<CControlledTask*>(current);
    const auto release=[&](const char* why,bool resume) {
        if(!d.active) return false;
        ai->LOG("[CommanderDoctrine] unit=%i action=end reason=%s was=%s frame=%i",unit->GetId(),why,d.reason,frame);
        d.active=false; d.holding=false; d.goal={-1,0,-1}; d.reason="";
        if(!resume || !task) return false;
        d.cloak=false;
        Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame); task->Resume(unit);
        return true;
    };
    if(!DoctrineOn(unit) || current==nullptr) return release("off",false);
    // Another owner's pending D-gun (priority, T3, ordinary): never cancel it.
    if(s.pending>=0 && d.shot<0) return false;
    // Our pending shot: WeaponFired clears pending on dispatch.
    if(d.shot>=0) {
        if(s.pending<0 || unit->GetDGunReloadFrame()>frame) {
            if(s.pending>=0) { s.fired=frame; s.pending=-1; }
            d.shot=-1;
        } else if(frame-s.pending>30) {
            ai->LOG("[CommanderDoctrine] unit=%i action=dgun_timeout target=%i frame=%i",unit->GetId(),d.shotTarget,frame);
            s.pending=-1; s.leaseUntil=0; d.shot=-1;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        } else return true;
    }
    auto* def=unit->GetCircuitDef();
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    const AIFloat3 pos=unit->GetPos(frame);
    const Point here=P(pos);
    const bool dry=pos.y>=0.f;
    const float range=unit->GetDGunRange()-12;
    const float speed=std::max(1.f,cap.speed);
    const float laser=LaserRange(def);
    const int hold=int(cfg->doctrine.hitHold*FRAMES_PER_SEC);
    const bool unseen=frame-d.unseenHit<hold;
    const bool ranged=frame-d.rangedHit<hold;
    const bool air=frame-d.airHit<hold;
    const bool spamOn=frame>=int(cfg->doctrine.spamMinutes*60.f*FRAMES_PER_SEC);
    // Hysteresis: an active retreat ends this much farther out than it starts.
    const float exitSlack=d.active?300.f:0.f;
    const float spamReach=cfg->doctrine.spamRange*laser;
    Point threatSum{}; float threatWeight=0;
    const auto addThreat=[&](Point p,float w) { threatSum=threatSum+p*w; threatWeight+=w; };
    int spam=0; bool spamClose=false; bool outranged=false;
    bool t3Danger=false,t3Receding=false;
    const commander::Contact* approach=nullptr; float approachTime=1e9f;
    for(const auto& c:contacts) {
        if(c.friendly) continue;
        auto* enemy=ai->GetEnemyInfo(c.id);
        auto* ed=enemy?enemy->GetCircuitDef():nullptr;
        if(!ed) continue;
        const float distance=commander::Length(c.pos-here);
        if(spamOn && distance<=spamReach && IsSpam(ed,c)) {
            ++spam; addThreat(c.pos,1.f);
            if(distance<=range+c.radius+100.f) spamClose=true;
        }
        if(!ed->IsMobile() || ed->IsAbleToFly() || c.blocker) continue;
        const auto& m=MatchupFor(ed,def);
        if(c.t3) {
            const Point toward=commander::Normal(here-c.pos);
            const float closing=commander::Dot(c.velocity,toward);
            const float gap=distance-(range+c.radius*.5f);
            if(gap>0 && c.targetable && dry && closing>=-5.f) {
                const float t=gap/(speed+std::max(0.f,closing));
                if(t<=cfg->doctrine.t3Close && t<approachTime) { approach=&c; approachTime=t; }
            }
            if(m.range>0 && distance<=m.range+def->GetRadius()+cfg->doctrine.t3Margin+exitSlack) {
                t3Danger=true; addThreat(c.pos,4.f);
                if(closing<5.f) t3Receding=true; // stopped or walking away: no ambush to wait for
            }
        } else if(c.combatTier>=int(cfg->doctrine.outrangeTier) && m.range>laser+cfg->doctrine.rangedMargin
            && distance<=m.range+def->GetRadius()+cfg->doctrine.t3Margin+exitSlack
            && distance>range+c.radius*.5f+speed*cfg->doctrine.t3Close) {
            outranged=true; addThreat(c.pos,2.f);
        }
    }
    if(spam>=int(cfg->doctrine.spamCount)) d.spamUntil=frame+int(cfg->doctrine.spamHold*FRAMES_PER_SEC);
    const bool spamActive=spamOn && frame<d.spamUntil;
    if((unseen || ranged || air) && d.hitFrom.x>=0) addThreat(P(d.hitFrom),2.f);
    const bool cloaked=unit->GetUnit()->IsCloaked();
    const bool afterT3Shot=frame<d.recloakUntil && !cloaked;
    const bool health=HealthRetreat(unit);
    const char* reason=spamActive?"spam":unseen?"unseen_fire":ranged?"ranged_fire":air?"air_fire"
        :outranged?"outranged":afterT3Shot?"t3_recloak":t3Danger?"t3_reach":nullptr;
    const AIFloat3* after=d.goal.x>=0?&d.goal:health && s.retreat.healthGoal.x>=0?&s.retreat.healthGoal:nullptr;
    // 1. Any enemy in D-gun reach while retreating (or at low health); a T3 in
    //    reach always. The walk resumes behind the shot.
    if(dry && DoctrineShot(unit,s,frame,!(reason || health),reason?after:health?after:nullptr)) return true;
    // A low-health commander keeps its own retreat (HealthControl), now cloaked.
    if(health) return release("health_retreat",false);
    // 2. The T3 two-second rule: close only when reach is that near, never on
    //    unseen or air fire, spam, or before the cloak is back after a T3 shot.
    if(approach && !spamActive && !unseen && !air && !afterT3Shot
        && unit->IsDGunReady(frame,ai->GetEconomyManager()->GetEnergyCur())) {
        const Point lead=approach->pos+approach->velocity*approachTime;
        AIFloat3 goal(lead.x,0,lead.z);
        const Point station=lead+commander::Normal(here-lead)*std::max(0.f,range-40.f);
        goal=AIFloat3(station.x,0,station.z);
        goal.y=ai->GetMap()->GetElevationAt(goal.x,goal.z);
        if(goal.y>=0 && OnMap(goal) && ai->GetTerrainManager()->CanReachAt(unit,goal,64)) {
            if(!task) {
                task=ai->GetBuilderManager()->EnqueueControlled(this,current);
                ai->GetBuilderManager()->AssignTask(unit,task);
                if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
                s.started=frame; s.conceal.requested=cloaked; s.failed=0; ++operation;
                writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"doctrine");
                TRY_UNIT(ai,unit,unit->CmdStop();)
            }
            if(!d.active || std::strcmp(d.reason,"t3_approach")!=0)
                ai->LOG("[CommanderDoctrine] unit=%i action=t3_approach target=%i seconds=%.1f distance=%.0f frame=%i",
                    unit->GetId(),approach->id,approachTime,commander::Length(approach->pos-here),frame);
            d.active=true; d.reason="t3_approach"; d.holding=false; d.goal={-1,0,-1};
            EndT3(unit,s,frame,"doctrine");
            const bool cloak=DoctrineCloak(unit,s,true);
            writer.FireState(unit,CCircuitDef::FireType::HOLD,"doctrine_t3");
            (void)cloak;
            Transition(unit,s,Mode::APPROACH,frame);
            Move(unit,s,goal,frame);
            return true;
        }
    }
    if(!reason) return release("clear",true);
    // 3. Retreat (or stand still cloaked).
    if(!task) {
        // Drop the work that held us here; the ladder offers new work later.
        task=ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
        s.started=frame; s.conceal.requested=cloaked; ++operation;
        TRY_UNIT(ai,unit,unit->CmdStop();)
        s.route.clear();
    }
    if(!d.active || std::strcmp(d.reason,reason)!=0) {
        ai->LOG("[CommanderDoctrine] unit=%i action=retreat reason=%s spam=%i hp=%.2f x=%.0f z=%.0f frame=%i",
            unit->GetId(),reason,spam,unit->GetHealthPercent(),pos.x,pos.z,frame);
        if(!d.active) d.goal={-1,0,-1};
        d.goalPlan=-10000;
    }
    d.active=true; d.reason=reason;
    s.budget=0; s.fundingBudget=0; s.deployed=false;
    EndT3(unit,s,frame,"doctrine");
    const bool damaged=s.lastDamage>=0 && frame-s.lastDamage<FRAMES_PER_SEC;
    const Point threat=threatWeight>0?threatSum*(1.f/threatWeight):Point{-1,-1};
    // Stand still cloaked: spam inside jammer cover (until one closes to D-gun
    // reach), or an undetected cloaked ambush of a T3 walking in.
    bool still=false;
    if(spamActive && !spamClose && d.goal.x>=0 && pos.SqDistance2D(d.goal)<SQUARE(96.f)) still=true;
    if(std::strcmp(reason,"t3_reach")==0 && cloaked && !damaged && !t3Receding
        && CloakSafe(unit,here,here,1.f)) still=true;
    const bool cloak=DoctrineCloak(unit,s,!still);
    // Fire held while cloaked (no decloak), and always against spam and aircraft.
    writer.FireState(unit,cloak || spamActive || air?CCircuitDef::FireType::HOLD:CCircuitDef::FireType::RETURN,"doctrine");
    if(still) {
        Transition(unit,s,Mode::ASSESS,frame);
        if(!d.holding) {
            d.holding=true; s.route.clear();
            TRY_UNIT(ai,unit,unit->CmdStop();)
            ai->LOG("[CommanderDoctrine] unit=%i action=hold reason=%s cloak=%i frame=%i",unit->GetId(),reason,int(cloak),frame);
        }
        return true;
    }
    d.holding=false;
    Transition(unit,s,Mode::ESCAPE,frame);
    // Spam close to D-gun reach at the jammer: step away instead of waiting.
    const bool toJammer=spamActive && !spamClose;
    if(frame>=d.goalPlan+FRAMES_PER_SEC && (d.goal.x<0 || (!toJammer && pos.SqDistance2D(d.goal)<SQUARE(64.f))
        || KeepOutAt(P(d.goal)) || (spamClose && pos.SqDistance2D(d.goal)<SQUARE(96.f)))) {
        d.goalPlan=frame;
        d.goal=DoctrineGoal(unit,s,pos,threat,toJammer,frame);
    }
    if(d.goal.SqDistance2D(pos)>SQUARE(32.f)) Move(unit,s,d.goal,frame,true);
    return true;
}
}
