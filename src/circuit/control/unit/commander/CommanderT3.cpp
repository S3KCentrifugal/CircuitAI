#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "control/core/ControlledTask.h"
#include "task/fighter/RangedWorld.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyUnit.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/BattleAnalysis.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "util/Performance.h"
#include "task/builder/BuilderTask.h"
#include "json/json.h"
#include "Log.h"
#include "Sim/Units/CommandAI/Command.h"
#include <algorithm>
#include <array>
#include <cmath>
#include <cstdlib>
#include <limits>
#include <string_view>

namespace circuit {
using springai::AIFloat3;
using commander::Point;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }
static AIFloat3 F(Point p,float y=0) { return {p.x,y,p.z}; }

// D-294: a commander holding a line kills an approaching T3 instead of
// abandoning the line. Concealed (actual cloak, no known detection) it holds,
// flanks or hunts according to a per-definition plan, fires when a clear lane
// guarantees the hit, commits to visible follow-up shots only while the
// expected exposure is survivable, sidesteps after every shot and after the
// kill (heavy shells are still in flight), and never fires submerged.
// Runs every commander observation (3 frames) while a T3 is in range:
// O(T) target scan over the local contacts, then at most 5 stations x one
// ScoreLine O(E+F); no new engine queries beyond the existing observation.

static const char* ApproachName(int a) {
    return a==CCommanderController::T3_HOLD?"hold":a==CCommanderController::T3_FLANK?"flank":a==CCommanderController::T3_HUNT?"hunt"
        :a==CCommanderController::T3_REAR?"rear":"auto";
}

void CCommanderController::ReadProfiles() {
    // Profile JSON is read once at AI construction, before CloseConfig.
    const Json::Value& profiles=ai->GetSetupManager()->GetConfig()["commander"]["combat"]["t3_profiles"];
    if(!profiles.isObject()) return;
    for(const std::string& name:profiles.getMemberNames()) {
        const Json::Value& p=profiles[name];
        if(!p.isObject()) continue;
        T3Profile profile;
        const std::string approach=p.get("approach","auto").asString();
        profile.approach=approach=="hold"?T3_HOLD:approach=="flank"?T3_FLANK:approach=="hunt"?T3_HUNT
            :approach=="rear"?T3_REAR:T3_AUTO;
        profile.commit=p.get("commit",-1).asFloat();
        profile.juke=p.get("juke",-1).asFloat();
        profile.standoff=p.get("standoff",-1).asFloat();
        profile.health=p.get("health",-1).asFloat();
        profile.advance=p.get("advance",-1).asFloat();
        t3Profiles[name]=profile;
    }
    configuredT3Profiles=t3Profiles;
}

bool CCommanderController::SetProfileOption(const std::string& name,float value,bool reset) {
    // "t3.<unit>.<field>": per-AI script override of one profile field.
    const size_t dot=name.rfind('.');
    if(dot==std::string::npos || dot<=3) return false;
    const std::string unit=name.substr(3,dot-3),field=name.substr(dot+1);
    struct Field { const char* name; float T3Profile::*member; float high; };
    const Field fields[]={{"approach",&T3Profile::approach,4},{"commit",&T3Profile::commit,12},
        {"juke",&T3Profile::juke,300},{"standoff",&T3Profile::standoff,400},
        {"health",&T3Profile::health,.9f},{"advance",&T3Profile::advance,800}};
    for(const auto& f:fields) if(field==f.name) {
        const auto base=configuredT3Profiles.find(unit);
        const T3Profile configured=base==configuredT3Profiles.end()?T3Profile{}:base->second;
        // Live engagements keep their resolved plan; changes apply on the next
        // engagement, including resetting a field to its automatic (-1) value.
        t3Profiles[unit].*(f.member)=reset ? configured.*(f.member)
            : std::clamp(field=="approach"?std::round(value):value,field=="approach"?0.f:-1.f,f.high);
        return true;
    }
    return false;
}

void CCommanderController::Decline(CCircuitUnit* unit,State& s,const commander::Contact& target,int frame,const char* reason) {
    // A declined T3 is still walking at the line: withdraw now (D-293
    // fallback, with its funded cloaked travel) instead of waiting for it to
    // enter 2x the commander's own range, which a 590-reach T3 already covers.
    EndT3(unit,s,frame,reason);
    s.t3.declined=target.id; s.t3.declinedSeen=frame;
    // Backoff: t3_retry_seconds, +1 s per decline in a row, at most 3 s (owner
    // 2026-10-19); the first shot of an engagement resets it.
    s.t3.reconsider=frame+int((cfg->t3.declineGate>0?std::min(3.f,cfg->t3.retrySeconds+s.t3.declineFails):cfg->t3.retrySeconds)*FRAMES_PER_SEC);
    if(cfg->t3.declineGate>0) ++s.t3.declineFails;
    if(std::string_view(reason)=="funding") {
        s.fundingBudget=s.budget; s.fundingTarget=target.id;
        s.fundingUntil=frame+int((cfg->t3.retrySeconds+3.f)*FRAMES_PER_SEC);
    } else s.fundingBudget=0;
    if(!role.fallback) return;
    s.fallback.until=frame+int(cfg->fallback.holdSeconds*FRAMES_PER_SEC);
    s.fallback.metal=target.cost; s.fallback.threat=F(target.pos);
    // Last legally observed weapon reach plus movement uncertainty during the
    // same memory window. Losing spotters must not shrink a no-cover exit to
    // the generic radar threat's range. This snapshot belongs to the fallback
    // episode and is cleared on release; no hidden weapon callback is used.
    s.fallback.reach=s.t3.reach+commander::Length(target.velocity)*cfg->combat.sensorMemory;
    if(!s.fallback.active) {
        s.fallback.active=true; s.fallback.planned=-10000; s.fallback.porc=-1;
        ai->LOG("[CommanderFallback] unit=%i on metal=%.0f group=%.0f,%.0f reason=t3_%s frame=%i",
            unit->GetId(),target.cost,target.pos.x,target.pos.z,reason,frame);
    }
}

void CCommanderController::EndT3(CCircuitUnit* unit,State& s,int frame,const char* reason) {
    s.t3.positionUntil=0; s.t3.positionTarget=-1;
    if(s.t3.screenDef>=0) {
        if(dynamic_cast<CControlledTask*>(unit->GetTask())) { TRY_UNIT(ai,unit,unit->CmdStop();) }
        s.t3.screenDef=-1; s.t3.screenUnit=-1;
    }
    if(s.t3.target<0) return;
    s.fundingBudget=0;
    ai->LOG("[CommanderT3] unit=%i target=%i action=done reason=%s shots=%i frame=%i",
        unit->GetId(),s.t3.target,reason,s.t3.shots,frame);
    s.t3.target=-1; s.t3.shots=0; s.t3.jukeUntil=-1; s.t3.started=-1; s.t3.afus=false;
}

bool CCommanderController::Intercept(CCircuitUnit* unit,State& s,int frame) {
    performance::Scope measured(ai,performance::COMMANDER_T3);
    auto* def=unit->GetCircuitDef();
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    const AIFloat3 pos=unit->GetPos(frame);
    auto* task=dynamic_cast<CControlledTask*>(unit->GetTask());
    const auto acceptIntercept=[&]() {
        // A reconsidered, now-safe T3 plan takes ownership from fallback.
        // Its own leash governs movement; retaining the old porc perimeter
        // contradicts that handover (INV-215, detection/retry arena).
        if(s.fallback.active) {
            ai->LOG("[CommanderFallback] unit=%i off reason=t3_intercept frame=%i",unit->GetId(),frame);
            s.fallback.active=false;s.fallback.until=-1;s.fallback.porc=-1;s.route.clear();
            s.fallback.reach=0;s.fallback.moveUntil=-1;
        }
        s.t3.declined=-1;
    };
    // Friendly units are what the T3 is shooting at: a cloaked commander next
    // to them still takes the splash (b26: scouting beside a shelled wall).
    const auto shelled=[&](Point p) {
        // Only friendlies the T3 can currently reach are being shelled; others
        // are just a line to walk through (b35: forward ambush blocked).
        const float keep=s.t3.splash+40.f;
        const Point t3=P(s.t3.lastPos);
        for(const auto& c:contacts)
            if(c.friendly && !c.blocker && commander::Dot(c.pos-p,c.pos-p)<SQUARE(keep+c.radius)
                && commander::Dot(c.pos-t3,c.pos-t3)<=SQUARE(s.t3.reach+50.f)) return true;
        return false;
    };
    // ...along the whole move, sampled every ~48 elmos (b27: shelled en route).
    const auto shelledPath=[&](Point from,Point to) {
        const int n=std::max(1,int(commander::Length(to-from)/48.f));
        for(int i=1;i<=n;++i) if(shelled(from+(to-from)*(float(i)/n))) return true;
        return false;
    };
    // Account own shots (WeaponFired clears pending before this tick runs).
    if(s.t3.target>=0 && s.fired>s.t3.lastShot) {
        s.t3.lastShot=s.fired; ++s.t3.shots; s.t3.jukeSide=-s.t3.jukeSide; s.t3.declineFails=0;
        s.t3.jukeUntil=s.fired+int(s.t3.juke>0?FRAMES_PER_SEC*.8f:0);
    }
    if(s.pending<0) s.immediatePending=false;
    if(s.pending>=0 && (s.t3.target>=0 || s.immediatePending)) {
        if(unit->GetDGunReloadFrame()>frame) { s.fired=frame; s.pending=-1; }
        else if(frame-s.pending>30) {
            s.pending=-1; s.leaseUntil=0;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        } else return true;
        s.immediatePending=false;
    }
    // Owner 2026-10-23: an available T3 shot wins over concealment, approach,
    // retreat and predicted death. Only this explicit policy accepts that risk;
    // the shared line geometry, weapon readiness and exclusive owner still apply.
    // This precedes retry/decline gates so a target walking into reach is not
    // delayed by a previously rejected approach. No extra observation is made.
    if(cfg->t3.immediateShot>0 && pos.y>=0.f && !unit->GetDGunAct()
        && unit->IsDGunReady(frame,ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve))) {
        const float projectile=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
        const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
        const auto line=commander::ImmediateT3Line(contacts,P(pos),unit->GetDGunRange()-12,
            projectile,width,cfg->combat.killReward,cfg->combat.friendlyMargin);
        if(line.target>=0) {
            if(!task) {
                task=ai->GetBuilderManager()->EnqueueControlled(this,unit->GetTask());
                ai->GetBuilderManager()->AssignTask(unit,task);
                if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return true; }
                s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
                writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"engage");
            }
            if(task->GetAssignees().size()!=1 || !task->GetAssignees().count(unit)) return true;
            EndT3(unit,s,frame,"immediate_shot");
            s.t3.afus=false;
            acceptIntercept();
            s.t3.declineFails=0;
            const bool immediateConcealed=unit->GetUnit()->IsCloaked();
            if(Fire(unit,s,line,frame,true)) {
                s.immediatePending=true;
                ai->LOG("[CommanderT3] unit=%i target=%i action=fire immediate=1 concealed=%i frame=%i",unit->GetId(),line.target,int(immediateConcealed),frame);
                if(protectedAfus>=0) ai->LOG("[CommanderBase] unit=%i afus=%i target=%i tier=3 action=fire concealed=%i frame=%i",
                    unit->GetId(),protectedAfus,line.target,int(unit->GetUnit()->IsCloaked()),frame);
                return true;
            }
        }
    }
    if(!task && frame<s.retry) return false;
    if(cfg->t3.intercept<=0 || !cap.cloak) { s.fundingBudget=0; EndT3(unit,s,frame,"disabled"); return false; }

    const bool baseDefence=protectedAfus>=0;
    // Strategic pursuit stays in the published FRONT corridor. This is an
    // O(1) grid read; immediate shots above and escape/juke moves stay reactive.
    const auto inLane=[&](const AIFloat3& point) {
        return ai->GetBattle()->GetFrontLaneLength()<=0.f
            || ai->GetBattle()->GetFrontLaneDistance(point)<=ai->GetBattle()->GetFrontLaneWidth();
    };
    if(s.t3.afus && !baseDefence) {
        // Fresh observation handles AFUS destruction, transfer and leaving its
        // radius. Do not let lost-contact memory pursue a T1/T2 outside scope.
        EndT3(unit,s,frame,"afus_scope");
        ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        if(task && ai->GetUnitAPI()->HasQueuedCommand(unit->GetId(),CMD_MOVE)) {
            TRY_UNIT(ai,unit,unit->CmdStop();)
            s.route.clear();
        }
    }
    if(!baseDefence && s.t3.declined>=0) {
        auto* declined=ai->GetEnemyInfo(s.t3.declined);
        if(declined && declined->GetCircuitDef() && !DefinitionFor(declined->GetCircuitDef()).t3)
            s.t3.declined=-1;
    }

    // Target: keep the engaged T3 while it is observed, else the nearest one.
    const commander::Contact* target=nullptr;
    const commander::Contact* standoffThreat=nullptr;
    float standoffDistance=std::numeric_limits<float>::max();
    float standoffReach=0;
    const float engage=std::min(cfg->combat.scan,cfg->t3.distance);
    float nearest=std::numeric_limits<float>::max();
    for(const auto& c:contacts) {
        if(c.friendly || c.blocker || (!c.t3 && !(baseDefence && c.combatTier>0 && c.targetable))) continue;
        auto* enemy=ai->GetEnemyInfo(c.id);
        if(!enemy || !enemy->GetCircuitDef()) continue;
        // A surface-only D-gun cannot hit aircraft or a definition outside
        // its target categories; a submerged T3 is still tracked (shore wait).
        const bool submerged=c.height<-c.radius*.4f;
        if(!c.targetable && !submerged) continue;
        const float distance=commander::Length(c.pos-P(pos));
        // No-disrupt work yields only to an imminent local threat. An already
        // owned combat task is not interrupted construction.
        if(!task && def->IsAttrNoDisrupt() && distance>def->GetMaxRange(CCircuitDef::RangeType::LAND)+c.radius) continue;
        if(c.id==s.t3.target && !baseDefence) { target=&c; nearest=distance; break; }
        // Artillery that outranges the commander's distance is hunted out to
        // t3_hunt_leash; everything else is engaged within t3_distance.
        float limit=engage;
        float reach=0; bool ballistic=false;
        for(const auto& w:ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(enemy->GetCircuitDef()).weapons) {
            reach=std::max(reach,w.range); ballistic|=w.ballistic && w.range>=1000.f;
        }
        const auto profile=t3Profiles.find(enemy->GetCircuitDef()->GetDef()->GetName());
        const bool artillery=ballistic || reach>=1200.f
            || (profile!=t3Profiles.end() && int(profile->second.approach)==T3_HUNT);
        if(artillery && cfg->t3.hunt<=0) {
            limit=std::min(engage,unit->GetDGunRange()+c.radius+cfg->t3.artilleryApproach);
        } else if(distance>=engage) {
            if((ballistic || reach>=1200.f) && reach>=distance) limit=std::min(cfg->t3.huntLeash,reach);
            // A profile can name a hunt target whose reach is indirect (drone
            // carriers): engage it out to the hunt leash as well.
            if(profile!=t3Profiles.end() && (int(profile->second.approach)==T3_HUNT || profile->second.advance>0)) limit=cfg->t3.huntLeash;
        }
        // Refusing a long artillery pursuit must still preserve withdrawal
        // while its observed weapons reach us. Otherwise the short ordinary
        // fallback expires and decloaks in range (corves roster regression).
        // Reuse this contact/weapon pass: O(E*W), no additional engine query.
        const bool inReach=distance<=reach+c.radius;
        if(c.id==s.t3.declined && (distance<limit || inReach)) s.t3.declinedSeen=frame;
        // Every new plan waits out the decline backoff, not only the last
        // declined id: two T3s in view alternated plan/decline every tick
        // (Entrenched Plains 2026-10-19, ~300 plans/min per commander).
        if(cfg->t3.declineGate>0) { if(frame<s.t3.reconsider && c.id!=s.t3.target) continue; }
        else if(c.id==s.t3.declined && frame<s.t3.reconsider) continue;
        if(artillery && cfg->t3.hunt<=0 && distance>=limit && inReach && distance<standoffDistance) {
            standoffThreat=&c;standoffDistance=distance;standoffReach=reach;
        }
        const bool preferred=baseDefence
            ?(!target || commander::PreferDefenceTarget(c.combatTier,c.id,distance,
                target->combatTier,target->id,nearest,s.t3.target))
            :distance<nearest;
        if(!c.reserved && distance<limit && preferred) { nearest=distance; target=&c; }
    }
    if(!target && standoffThreat) {
        s.t3.reach=standoffReach;
        Decline(unit,s,*standoffThreat,frame,"artillery_standoff");
        return false;
    }
    if(!target && s.t3.declined>=0 && role.fallback) {
        // A declined T3 out of sight is still walking at the line: keep the
        // withdrawal alive for sensor_memory instead of releasing after the
        // fallback hold (b25: released, then one volley on arrival).
        if(frame-s.t3.declinedSeen<int(cfg->combat.sensorMemory*FRAMES_PER_SEC) && ai->GetEnemyInfo(s.t3.declined))
            s.fallback.until=std::max(s.fallback.until,frame+int(cfg->fallback.holdSeconds*FRAMES_PER_SEC));
        else s.t3.declined=-1;
    }
    if(target && target->id==s.t3.declined) s.t3.declinedSeen=frame;
    if(!target) {
        // Post-kill dodge: shells fired before the T3 died are still in flight.
        if(s.t3.target>=0 && task && frame-s.t3.lastShot<FRAMES_PER_SEC*2) {
            s.t3.ended=frame+int(cfg->t3.dodgeSeconds*FRAMES_PER_SEC);
            const Point away=commander::Normal(P(pos)-P(s.t3.lastPos));
            AIFloat3 dodge=F(P(pos)+Point{-away.z,away.x}*(float(s.t3.jukeSide)*120.f)+away*60.f);
            dodge.y=ai->GetMap()->GetElevationAt(dodge.x,dodge.z);
            if(Route(unit,pos,dodge)) Move(unit,s,dodge,frame);
            EndT3(unit,s,frame,"target_gone");
            return true;
        }
        // Sight of an outranging T3 flickers as spotters die. Keep the plan
        // and the cloak for a short grace instead of revealing the commander.
        // Same window as a lost enemy sensor (sensor_memory). A T3 that killed
        // our spotters is usually standing still, shelling the line: scout it
        // cloaked. Close on a flank point off its last known position; the
        // commander's own sight reacquires it at D-gun stand-off.
        if(s.t3.target>=0 && task && frame-s.t3.seen<int(cfg->combat.sensorMemory*FRAMES_PER_SEC)) {
            Conceal(unit,s,true); Transition(unit,s,Mode::APPROACH,frame);
            if(unit->GetUnit()->IsCloaked() && pos.y>=0.f) {
                const Point last=P(s.t3.lastPos);
                const Point from=commander::Normal(P(pos)-last),across{-from.z,from.x};
                const float off=s.t3.radius+s.t3.standoff;
                AIFloat3 best=pos; float bestSeconds=1e9f;
                for(float sideSign:{1.f,-1.f}) {
                    AIFloat3 station=F(last+(from*.5f+across*(sideSign*.87f))*off);
                    station.y=ai->GetMap()->GetElevationAt(station.x,station.z);
                    const float seconds=(station-pos).Length2D()/std::max(1.f,cap.speed)+.3f;
                    if(station.y<0 || !OnMap(station) || !inLane(station) || station.SqDistance2D(s.t3.anchor)>SQUARE(T3Leash(s))
                        || shelledPath(P(pos),P(station)) || !ai->GetTerrainManager()->CanReachAt(unit,station,64)
                        || !CloakSafe(unit,P(pos),P(station),seconds)) continue;
                    if(seconds<bestSeconds) { bestSeconds=seconds; best=station; }
                }
                if(best.SqDistance2D(pos)>24.f*24.f) Move(unit,s,best,frame);
                else if(ai->GetUnitAPI()->HasQueuedCommand(unit->GetId(),CMD_MOVE)) {
                    // Lost-contact motion is valid only while its full path
                    // remains safe. New sensor evidence can invalidate it.
                    TRY_UNIT(ai,unit,unit->CmdStop();)
                    s.route.clear();
                }
                if(frame>=s.lastLog+60) {
                    s.lastLog=frame;
                    ai->LOG("[CommanderT3] unit=%i target=%i action=scout last=%.0f,%.0f lost=%.1fs",
                        unit->GetId(),s.t3.target,s.t3.lastPos.x,s.t3.lastPos.z,float(frame-s.t3.seen)/FRAMES_PER_SEC);
                }
            }
            return true;
        }
        // Lost and still alive (b29: uncloaked beside a T3 just out of sight):
        // withdraw as for a decline, from its last known position.
        const int lost=s.t3.target;
        if(lost>=0 && ai->GetEnemyInfo(lost)) {
            commander::Contact last; last.id=lost; last.pos=P(s.t3.lastPos); last.cost=s.t3.cost;
            Decline(unit,s,last,frame,"lost");
            return false;
        }
        EndT3(unit,s,frame,"target_gone");
        if(task && frame<s.t3.ended) return true; // finish the dodge
        return false;
    }
    auto* enemy=ai->GetEnemyInfo(target->id);
    auto* targetDef=enemy->GetCircuitDef();
    const bool submerged=target->height<-target->radius*.4f;
    const float range=unit->GetDGunRange()-12;

    // Resolve the plan once per engagement (profile, else target stats).
    if(s.t3.target!=target->id || s.t3.afus!=baseDefence) {
        if(baseDefence && s.t3.target>=0 && s.t3.target!=target->id) {
            EndT3(unit,s,frame,"base_target");
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        }
        const auto& tcap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(targetDef);
        float reach=0; bool artillery=false;
        for(const auto& w:tcap.weapons) {
            reach=std::max(reach,w.range);
            artillery|=w.ballistic && w.range>=1000.f;
        }
        const auto found=t3Profiles.find(targetDef->GetDef()->GetName());
        const T3Profile profile=found!=t3Profiles.end()?found->second:T3Profile{};
        const int shots=std::max(1,int(std::ceil(target->health/std::max(1.f,target->damage))));
        s.t3.approach=profile.approach>0?int(profile.approach)
            :(artillery || reach>=1200.f)?T3_HUNT:targetDef->GetSpeed()>=70.f?T3_HOLD:T3_FLANK;
        if(baseDefence && !target->t3) s.t3.approach=T3_FLANK;
        s.t3.artillery=artillery || reach>=1200.f || s.t3.approach==T3_HUNT;
        if(s.t3.artillery && cfg->t3.hunt<=0) s.t3.approach=T3_HOLD;
        s.t3.commit=profile.commit>=0?int(profile.commit):shots;
        s.t3.juke=profile.juke>=0?profile.juke:90.f;
        // Leave room for both 24-elmo penetration and the eight-elmo arrival
        // tolerance. Otherwise a safe stationary rear goal stops just outside
        // its own firing admission boundary (detector/retry arena).
        s.t3.standoff=profile.standoff>0?std::min(profile.standoff,range-36.f):range-40.f;
        s.t3.minHealth=profile.health>=0?profile.health:cfg->t3.health;
        s.t3.advance=std::max(0.f,profile.advance);
        // Cornered: no friendly static defence within fallback_search to fall
        // back behind. The T3 is walking into the base; a withdrawal only
        // delays its volley, so the screen rule below does not apply.
        // O(N) over the cached friendly snapshot, once per engagement.
        s.t3.cornered=true;
        for(const auto& [fid,ally]:ai->GetFriendlyUnits()) {
            auto* d=ally->GetCircuitDef();
            if(d && !d->IsMobile() && d->IsAttacker() && d->GetMaxRange()<=cfg->fallback.porcRange
                && ally->GetLastPos().SqDistance2D(pos)<=SQUARE(cfg->fallback.search)) { s.t3.cornered=false; break; }
        }
        s.t3.splash=0;
        for(const auto& w:tcap.weapons) s.t3.splash=std::max(s.t3.splash,w.splash);
        s.t3.reach=reach;
        // Until movement supplies a heading, approach relative to the line it
        // threatens. This is an inferred approach bearing, never turret state.
        s.t3.heading=F(commander::Normal(P(pos)-target->pos)); s.t3.cost=target->cost; s.t3.screens=0; s.t3.screenUntil=0;
        s.t3.target=target->id; s.t3.shots=0; s.t3.lastShot=s.fired; s.t3.started=frame;
        s.t3.closest=nearest; s.t3.progress=frame; s.t3.anchor=pos;
        s.t3.afus=baseDefence;
        if(baseDefence) ai->LOG("[CommanderBase] unit=%i afus=%i target=%i tier=%i action=plan frame=%i",
            unit->GetId(),protectedAfus,target->id,target->combatTier,frame);
        ai->LOG("[CommanderT3] unit=%i target=%i def=%s plan approach=%s shots=%i commit=%i juke=%.0f standoff=%.0f distance=%.0f",
            unit->GetId(),target->id,targetDef->GetDef()->GetName(),ApproachName(s.t3.approach),shots,s.t3.commit,s.t3.juke,s.t3.standoff,nearest);
    }
    s.t3.lastPos=F(target->pos); s.t3.seen=frame; s.t3.radius=target->radius;
    const float hp=unit->GetUnit()->GetHealth(),maxHp=unit->GetUnit()->GetMaxHealth();
    const bool engaged=s.t3.shots>0;
    if(s.t3.screenDef>=0) {
        const bool danger=nearest<=s.t3.reach+cfg->t3.baitMargin;
        // One exclusive combat-owned build; inspect its real frame/progress at
        // 2 Hz, but cancel on danger every combat tick. No timer-only busy wait.
        if(!danger && frame<s.t3.screenCheck) return true;
        s.t3.screenCheck=frame+15;
        if(s.t3.screenUnit<0) for(const auto& c:contacts) if(c.friendly
            && commander::Length(c.pos-P(s.t3.screenPos))<32.f) {
            auto* frameUnit=ai->GetTeamUnit(c.id);
            if(frameUnit && frameUnit->GetCircuitDef()->GetId()==s.t3.screenDef) { s.t3.screenUnit=c.id; break; }
        }
        auto* building=ai->GetTeamUnit(s.t3.screenUnit);
        const float progress=building?building->GetUnit()->GetBuildProgress():0.f;
        if(progress>s.t3.screenProgress+.001f) {
            s.t3.screenProgress=progress;
            s.t3.screenUntil=frame+int(cfg->t3.baitTimeout*FRAMES_PER_SEC);
        }
        const bool queued=ai->GetUnitAPI()->HasQueuedCommand(unit->GetId(),-s.t3.screenDef);
        if(!danger && progress<1.f && frame<s.t3.screenUntil && queued
            && (s.t3.screenUnit<0 || building)) return true;
        ai->LOG("[CommanderT3] unit=%i target=%i action=screen_done status=%s progress=%.3f",
            unit->GetId(),target->id,danger?"danger":progress>=1.f?"complete":"failed",progress);
        if(task && queued) { TRY_UNIT(ai,unit,unit->CmdStop();) }
        s.t3.screenDef=-1; s.t3.screenUnit=-1;
        if(danger) { Decline(unit,s,*target,frame,"screen_danger"); return false; }
    }
    if(s.t3.artillery && cfg->t3.hunt<=0 && !engaged
        && frame-s.t3.started>int(cfg->combat.maxSeconds*FRAMES_PER_SEC)) {
        Decline(unit,s,*target,frame,"artillery_timeout"); return false;
    }
    if(!engaged && hp<maxHp*s.t3.minHealth) { Decline(unit,s,*target,frame,"health"); return false; }
    const bool cloaked=unit->GetUnit()->IsCloaked();
    const bool safeHere=CloakSafe(unit,P(pos),P(pos),.1f);
    // A 3+ shot kill keeps the commander revealed for seconds; one heavy volley
    // outweighs its health. Start it only while friendly combat units inside
    // the T3's reach can soak its guns (b23: an unscreened Behemoth's last
    // volley, already in flight, killed the commander after the kill).
    if(!engaged && !(cloaked && safeHere) && std::ceil(target->health/std::max(1.f,target->damage))>=3.f && cfg->t3.screen>0) {
        float reachT=0;
        for(const auto& w:ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(targetDef).weapons) reachT=std::max(reachT,w.range);
        float screen=0;
        // Measured around the commander: the line it holds is where the
        // fight happens, not where the T3 stands now.
        for(const auto& c:contacts)
            if(c.friendly && c.cost>0 && commander::Length(c.pos-P(pos))<=reachT+c.radius) screen+=c.cost;
        if(screen<cfg->t3.screen) {
            // Cornered and unscreened (no line to soak its guns): a commander
            // is a builder. While the T3 is still outside its reach, raise bait
            // turrets (side default porc) between it and the commander, then
            // strike. Commanders are the win condition (official Cortex
            // Commander page), so a trade is the last resort, not the plan.
            if(s.t3.cornered) {
                auto* porc=ai->GetCircuitDefSafe(int(cfg->t3.baitDef));
                // Building the ordered turret: the commander task owns the unit
                // and the build order is issued directly (as its moves are), so
                // no builder task competes for ownership (b40: an assigned
                // DEFENCE task was replaced within the same frame).
                const bool time=nearest-reachT>cfg->t3.baitMargin;
                if(porc && time && s.t3.screens<int(cfg->t3.baitCount) && unit->GetCircuitDef()->CanBuild(porc)
                    && ai->GetEconomyManager()->GetMetalCur()>=porc->GetCostM()) {
                    const Point toward=commander::Normal(target->pos-P(pos)),across{-toward.z,toward.x};
                    AIFloat3 spot=F(P(pos)+toward*cfg->t3.baitDistance+across*(float((s.t3.screens%2)*2-1)
                        *cfg->t3.baitSpacing*(1.f+.5f*float(s.t3.screens/2))));
                    spot.y=ai->GetMap()->GetElevationAt(spot.x,spot.z);
                    auto* task=dynamic_cast<CControlledTask*>(unit->GetTask());
                    if(!task && spot.y>=0 && OnMap(spot)) {
                        task=ai->GetBuilderManager()->EnqueueControlled(this,unit->GetTask());
                        ai->GetBuilderManager()->AssignTask(unit,task);
                        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); task=nullptr; }
                        else { s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation; }
                    }
                    if(task && spot.y>=0 && OnMap(spot) && ai->GetTerrainManager()->CanReachAt(unit,spot,64)
                        && ai->GetMap()->IsPossibleToBuildAt(porc->GetDef(),spot,0)) {
                        acceptIntercept();
                        Conceal(unit,s,false); // building decloaks anyway
                        Transition(unit,s,Mode::SUPPORT,frame);
                        TRY_UNIT(ai,unit,unit->CmdBuild(porc,spot,0,0,frame+30*FRAMES_PER_SEC);)
                        s.route.clear();
                        // Arrival allowance, then a bounded no-progress deadline;
                        // only actual frame progress extends it.
                        const float walk=spot.distance2D(pos)/std::max(1.f,cap.speed);
                        s.t3.screenUntil=frame+int((walk+cfg->t3.baitTimeout)*FRAMES_PER_SEC);
                        s.t3.screenDef=porc->GetId(); s.t3.screenUnit=-1; s.t3.screenProgress=0;
                        s.t3.screenPos=spot; s.t3.screenCheck=frame+15;
                        ++s.t3.screens;
                        ai->LOG("[CommanderT3] unit=%i target=%i action=screen n=%i def=%s x=%.0f z=%.0f screen=%.0f eta=%.1fs",
                            unit->GetId(),target->id,s.t3.screens,porc->GetDef()->GetName(),spot.x,spot.z,screen,walk+cfg->t3.baitTimeout);
                        return true;
                    }
                }
            }
            Decline(unit,s,*target,frame,"unscreened"); return false;
        }
    }

    // Energy: cloak upkeep for the approach plus every planned shot.
    const float shot=def->GetDGunDef()->GetCostE(),bank=ai->GetEconomyManager()->GetEnergyCur();
    const float moveSeconds=std::max(0.f,nearest-s.t3.standoff)/std::max(1.f,cap.speed);
    s.budget=commander::Reserve(shot,float(std::max(1,s.t3.commit)),cap.cloakCost,cap.cloakMoving,
        cfg->combat.cloakSeconds,moveSeconds+cfg->combat.escapeSeconds,cfg->combat.margin);
    const float spendable=bank-std::max(0.f,reserve);
    const bool lockout=unit->GetUnit()->GetRulesParamFloat("cannotcloak",0)>0;
    // Before the first shot the plan needs concealment it can afford; known
    // detection hands the commander back to the fallback (it is visible).
    if(!engaged && spendable<shot+cap.cloakMoving*cfg->combat.escapeSeconds) { Decline(unit,s,*target,frame,"funding"); return false; }
    s.fundingBudget=0;
    // Revealed (radar, proximity, a hidden camera): press on only when the
    // remaining run-in in the open is survivable by the exposure model;
    // artillery up close usually is, a brawler T3 usually is not.
    const bool revealed=!safeHere;
    if(!engaged && revealed) {
        const float closing=std::max(0.f,nearest-(target->radius+range))/std::max(1.f,cap.speed);
        if(!s.t3.artillery && closing>.1f) { Decline(unit,s,*target,frame,"detected"); return false; }
        // A shorter run-in is not sufficient: expected exposure must still
        // leave the configured health reserve unless a trade was opted into.
        if(cfg->t3.trade<=0 && !commander::Survivable(hp,maxHp,Exposure(P(pos),target->pos,closing+1.4f,pos.y,true),s.t3.minHealth)) {
            Decline(unit,s,*target,frame,"detected"); return false;
        }
    }

    if(!task) {
        auto* current=unit->GetTask();
        if(current->GetType()==IUnitTask::Type::RETREAT && !engaged) { EndT3(unit,s,frame,"retreat"); return false; }
        task=ai->GetBuilderManager()->EnqueueControlled(this,current);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return true; }
        s.started=frame; s.conceal.requested=cloaked; s.failed=0; ++operation;
        writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"engage");
        TRY_UNIT(ai,unit,unit->CmdStop();)
    }
    if(task->GetAssignees().size()!=1 || !task->GetAssignees().count(unit) || unit->GetDGunAct()) {
        ai->LOG("[INVARIANT] INV-214 commander T3 engagement has competing owner unit=%i",unit->GetId());
        task->Resume(unit); return true;
    }
    acceptIntercept();
    // Hold fire throughout: lasers achieve nothing against T3 HP and would
    // keep restarting the cloak lockout. The D-gun shot itself decloaks.
    Conceal(unit,s,true);

    const float projectile=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
    const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
    const auto lineFrom=[&](Point from) {
        const Point lead=target->pos+target->velocity*(commander::Length(target->pos-from)/projectile);
        return commander::ScoreLine(contacts,from,lead-from,range,projectile,width,
            cfg->combat.killReward,cfg->combat.friendlyMargin,target->id);
    };
    const bool dry=pos.y>=0.f;
    const bool ready=unit->IsDGunReady(frame,spendable) && frame>=s.retry;
    // Once visible, finishing the kill and running are both exposure. Commit
    // when the remaining shots end sooner than escape: the cloak lockout
    // (about 4.3 s) or leaving the target's reach, whichever comes first.
    float reload=.9f;
    for(const auto& w:cap.weapons) if(w.def==def->GetDGunDef()) reload=std::max(.1f,w.reload);
    float targetReach=0;
    for(const auto& w:ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(targetDef).weapons) targetReach=std::max(targetReach,w.range);
    const int remaining=std::max(1,int(std::ceil(target->health/std::max(1.f,target->damage))));
    // Concealed aiming does not expose the commander. Include flight and the
    // post-impact tail; a revealed aiming lease adds a full second of risk.
    const bool hiddenAim=cloaked && safeHere;
    const float targetSpeed=commander::Length(target->velocity);
    if(targetSpeed>5.f) s.t3.heading=F(target->velocity*(1.f/targetSpeed));
    const float front=commander::Dot(commander::Normal(P(pos)-target->pos),P(s.t3.heading));
    // Lower-tier base defence needs concealment, not a heavy's rear/flank
    // bearing. A safe direct lane can already be in reach when the lateral
    // station exceeds the engagement leash (commander-afus-owned arena).
    const bool surpriseStation=(baseDefence && !target->t3)
        || (s.t3.approach==T3_REAR?front<=-.5f:s.t3.approach==T3_FLANK?front<=.5f:true);
    const bool penetrates=nearest<=range+target->radius-24.f;
    const float shotSeconds=range/projectile+.3f+(hiddenAim?0.f:1.f);
    const float commitSeconds=float(remaining-1)*reload+shotSeconds;
    const float escapeSeconds=std::min(4.3f-std::max(0.f,float(frame-s.t3.lastShot)/FRAMES_PER_SEC),
        std::max(0.f,targetReach+50.f-nearest)/std::max(1.f,cap.speed));
    const auto& explosion=DefinitionFor(targetDef);
    const int armor=def->GetDef()->GetArmorType();
    const float blast=explosion.blastDamage.empty()?0.f:commander::BlastDamage(
        explosion.blastDamage[std::min(size_t(std::max(0,armor)),explosion.blastDamage.size()-1)],
        explosion.blastRadius,explosion.blastEdge,nearest-cap.radius);
    // D-gun volumetric hits can kill earlier than the conservative shot count.
    // Include the death explosion on every shot, not just the predicted last.
    // Concealment makes acquisition of a new target uncertain, not shells
    // already in flight or the death blast. Script controls that risk estimate;
    // 1 restores the full ready-volley bound. This never discounts a visible
    // follow-up. ImpactVolleys tests retain all previously launched salvos.
    const float shotExposure=Exposure(P(pos),P(pos),shotSeconds,pos.y,hiddenAim,
        hiddenAim?cfg->t3.cloakedVolleyRisk:1.f);
    const bool shotSafe=cfg->t3.trade>0 || commander::Survivable(hp,maxHp,
        shotExposure+blast,s.t3.minHealth);
    const bool commit=engaged && remaining<=s.t3.commit && commitSeconds<=escapeSeconds+.5f
        && (cfg->t3.trade>0 || commander::Survivable(hp,maxHp,
            Exposure(P(pos),P(pos),commitSeconds,pos.y)+blast,s.t3.minHealth));

    // Shoot now when the lane guarantees the hit. Visible follow-ups only while
    // the remaining shots fit the commit and the exposure leaves HP reserve.
    if(dry && !submerged && ready) {
        const auto line=lineFrom(P(pos));
        // No low-percentage shots: a miss reveals the commander. The lead is
        // straight-line; error grows with the target's speed across the lane
        // times flight time. Wait until it is closer or moving along the lane
        // (b14: a crossing legeshotgunmech at 72 elmo/s dodged the first shot).
        const Point lane=line.direction;
        const float across=std::abs(target->velocity.x*lane.z-target->velocity.z*lane.x);
        const float flight=commander::Length(target->pos-P(pos))/projectile;
        // Pass through the body, not its edge (volumetric damage, see above).
        const bool confident=across*flight*.5f<=target->radius*.5f;
        // pressing: revealed before the first shot but cleared to press on.
        // A plan to attack from the rear must not shoot on the way around the
        // front. Also require body penetration: a geometric edge hit can expire
        // or hit the ground before delivering the volumetric D-gun damage.
        if(line.requiredHit && confident && penetrates && shotSafe && (!hiddenAim || surpriseStation)
            && (cloaked || commit || (revealed && !engaged))) {
            ai->LOG("[CommanderT3] unit=%i target=%i action=fire shot=%i remaining=%i concealed=%i commit=%.1fs escape=%.1fs",
                unit->GetId(),target->id,s.t3.shots+1,remaining,int(cloaked),commitSeconds,escapeSeconds);
            if(Fire(unit,s,line,frame)) {
                if(s.t3.afus) ai->LOG("[CommanderBase] unit=%i afus=%i target=%i tier=%i action=fire concealed=%i frame=%i",
                    unit->GetId(),protectedAfus,target->id,target->combatTier,int(cloaked),frame);
                return true;
            }
            Decline(unit,s,*target,frame,"shot_safety"); return false;
        }
    }

    const Point toTarget=commander::Normal(target->pos-P(pos)),side{-toTarget.z,toTarget.x};
    // After a shot, sidestep across the target's line of fire during reload.
    if(engaged && frame<s.t3.jukeUntil && s.t3.juke>0) {
        Transition(unit,s,Mode::ESCAPE,frame);
        AIFloat3 juke=F(P(pos)+side*(float(s.t3.jukeSide)*s.t3.juke));
        juke.y=ai->GetMap()->GetElevationAt(juke.x,juke.z);
        if(juke.y>=0 && juke.SqDistance2D(s.t3.anchor)<=SQUARE(T3Leash(s)) && Route(unit,pos,juke)) {
            Move(unit,s,juke,frame); return true;
        }
    }
    // Visible and not committed: break contact until the cloak lockout ends.
    // An unsafe *firing* window does not invalidate a concealed approach.
    // Keep a reachable hidden station while the enemy reloads; withdrawing
    // before reaching D-gun range made every new reload window unreachable.
    // Detection and exposure still reject revealed approaches above, and both
    // firing paths retain the final health/death-blast admission check.
    if((!shotSafe && !(cloaked && safeHere && !engaged)) || (engaged && !cloaked)) {
        if(commit) {
            // Committed: stay inside D-gun reach of the target between shots.
            Transition(unit,s,Mode::ALIGN,frame);
            if(nearest>range-16.f) {
                AIFloat3 close=F(target->pos-toTarget*(target->radius+s.t3.standoff));
                close.y=ai->GetMap()->GetElevationAt(close.x,close.z);
                if(close.y>=0 && OnMap(close) && inLane(close) && ai->GetTerrainManager()->CanReachAt(unit,close,64)) Move(unit,s,close,frame);
            }
            return true;
        }
        {
            Transition(unit,s,Mode::ESCAPE,frame);
            AIFloat3 exit=F(P(pos)-toTarget*cfg->combat.step+side*(float(s.t3.jukeSide)*cfg->combat.step*.5f));
            exit.y=ai->GetMap()->GetElevationAt(exit.x,exit.z);
            if(exit.y>=0 && Route(unit,pos,exit)) Move(unit,s,exit,frame);
            if(frame>=s.lastLog+30) {
                s.lastLog=frame;
                ai->LOG("[CommanderT3] unit=%i target=%i action=disengage remaining=%i lockout=%i hp=%.0f blast=%.0f exposure=%.0f",unit->GetId(),target->id,remaining,int(lockout),hp,blast,Exposure(P(pos),P(pos),shotSeconds,pos.y,hiddenAim));
            }
            return true;
        }
    }

    // Station selection. HOLD waits on the line until the target stops
    // closing for t3_hold_seconds, then flanks. Never stand in water; a
    // submerged target is awaited at the shore nearest its course.
    if(nearest<s.t3.closest-16.f) {
        s.t3.closest=nearest;
        // Only the target advancing renews an ambush wait. Counting our own
        // approach caused 16-elmo steps followed by repeated four-second waits
        // against a stationary target (commander-t3-funding regression).
        if(targetSpeed>5.f && commander::Dot(target->velocity,P(pos)-target->pos)>0.f) s.t3.progress=frame;
    }
    int approach=s.t3.approach;
    if(approach==T3_HOLD && !(s.t3.artillery && cfg->t3.hunt<=0)
        && frame-s.t3.progress>int(cfg->t3.holdSeconds*FRAMES_PER_SEC)) approach=T3_FLANK;
    Transition(unit,s,submerged || approach==T3_HOLD?Mode::ASSESS:Mode::APPROACH,frame);
    // Retain only this engagement's live approach queue, for a bounded interval.
    // Danger, shot readiness and ownership were rechecked above; invalid paths,
    // new targets, failures, arrival and expiry replan immediately. This avoids
    // rotating stations on every observation without limiting combat reactions.
    if(cfg->t3.positionSeconds>0 && frame<s.t3.positionUntil && s.t3.positionTarget==target->id
        && !s.route.empty() && s.goal.SqDistance2D(pos)>64.f
        && s.goal.y>=0 && inLane(s.goal) && s.goal.SqDistance2D(s.t3.anchor)<=SQUARE(T3Leash(s))
        && !shelledPath(P(pos),P(s.goal))
        && (revealed || CloakSafe(unit,P(pos),P(s.goal),pos.distance2D(s.goal)/std::max(1.f,cap.speed)+.3f))
        && ai->GetUnitAPI()->HasRouteIntent(unit->GetId(),s.route,frame)) return true;
    AIFloat3 goal=pos; float bestScore=-std::numeric_limits<float>::max(); bool found=false;
    int rejected[4]={0,0,0,0}; // water/leash, unreachable, detected, no lane
    {
        // Candidate stations, all on dry, reachable, undetected ground within
        // t3_leash of the engagement anchor. off = target radius + stand-off
        // from its edge (the D-gun reaches range+radius; a centre stand-off put
        // every station of a large T3 inside its decloak radius, b09 arena).
        const float off=target->radius+s.t3.standoff;
        const float tspeed=targetSpeed;
        // Remember its direction of travel: a T3 stopped at a wall still faces
        // the way it walked (b28: a stopped Behemoth was approached from the front).
        std::array<Point,8> stations; std::array<float,8> deadline,bonus; int count=0;
        const auto add=[&](Point station,float latest,float preferred=0.f) {
            if(count<8) { stations[count]=station; deadline[count]=latest; bonus[count++]=preferred; }
        };
        if(tspeed>5.f) {
            const Point u=target->velocity*(1.f/tspeed),normal{-u.z,u.x};
            const Point rel=P(pos)-target->pos;
            const float along=commander::Dot(rel,u),lateral=commander::Dot(rel,normal);
            const float nearSide=lateral>=0?1.f:-1.f;
            if(approach==T3_REAR) {
                // REAR (slow, many-shot T3): get behind it. Its guns face the
                // line, and a lane along its retreating motion keeps the
                // volumetric fireball inside it for more frames per hit.
                for(float sideSign:{1.f,-1.f})
                    add(target->pos+commander::Normal(u*-1.f+normal*(sideSign*nearSide*.35f))*off,1e9f);
                // A direct segment to the rear crosses the decloak disc. Take
                // a side station first; once alongside, only rear goals remain.
                // Still within the eight-candidate/path/sensor checks below.
                if(front>.1f) for(float sideSign:{1.f,-1.f})
                    add(target->pos+normal*(sideSign*nearSide*off),1e9f);
                if(front>.1f && std::abs(lateral)<off-16.f) for(float sideSign:{1.f,-1.f})
                    add(target->pos+u*std::max(off,along)+normal*(sideSign*nearSide*off),1e9f);
            } else if(along>off) {
                // Approaching: wait just off its path, ahead of it, reached
                // before it arrives. BAR's D-gun is volumetric (an explosion per
                // frame of flight, unit_dgun_behaviour.lua): a lane along the
                // target's motion passes through its body, a crossing lane
                // grazes it (b21 Demon: 11,387 vs 28,093 damage). So stand only
                // just outside decloak range (radius + 110) and let it walk in
                // at a shallow angle; its guns are busy with the line.
                const float aside=target->radius+110.f;
                const bool onPath=std::abs(lateral)<aside-20.f;
                if(s.t3.advance>0) {
                    // Forward ambush (profile advance): fast raiders reach a
                    // turret line before D-gun reach; wait ahead of the line,
                    // off their path, so the commander strikes first.
                    const Point ahead=P(s.t3.anchor)+commander::Normal(target->pos-P(s.t3.anchor))*s.t3.advance;
                    const float k=std::max(off,commander::Dot(ahead-target->pos,u));
                    const Point c=target->pos+u*k;
                    // Preferred over nearer line spots: the profile asked for it.
                    add(c+normal*(nearSide*aside),k/tspeed,600.f);
                    add(c-normal*(nearSide*aside),k/tspeed,600.f);
                }
                if(approach!=T3_HOLD || onPath) for(float back:{0.f,150.f}) {
                    const float k=std::max(off,along-back);
                    const Point c=target->pos+u*k;
                    add(c+normal*(nearSide*aside),k/tspeed);
                    add(c-normal*(nearSide*aside),k/tspeed);
                }
            } else if(approach!=T3_HOLD) {
                // Past us or moving away: rear quarter, behind its facing.
                const Point lead=target->pos+target->velocity*1.5f;
                add(lead+(u*-.5f+normal*(nearSide*.87f))*off,1e9f);
                add(lead+(u*-.5f-normal*(nearSide*.87f))*off,1e9f);
            }
        } else if(approach==T3_REAR && (s.t3.heading.x!=0.f || s.t3.heading.z!=0.f)) {
            const Point u=P(s.t3.heading),normal{-u.z,u.x};
            for(float sideSign:{1.f,-1.f}) add(target->pos+commander::Normal(u*-1.f+normal*(sideSign*.35f))*off,1e9f);
            if(front>.1f) for(float sideSign:{1.f,-1.f}) add(target->pos+normal*(sideSign*off),1e9f);
            const float along=commander::Dot(P(pos)-target->pos,u);
            if(front>.1f && std::abs(commander::Dot(P(pos)-target->pos,normal))<off-16.f)
                for(float sideSign:{1.f,-1.f}) add(target->pos+u*std::max(off,along)+normal*(sideSign*off),1e9f);
        } else if(approach!=T3_HOLD) {
            // Stationary (sieging from range): close in about 60 degrees off
            // the bearing; HUNT also tries straight in.
            const Point from=commander::Normal(P(pos)-target->pos),across{-from.z,from.x};
            // Keep a legal firing station while waiting for a reload window.
            // Rebuilding only +/-60-degree candidates from our moving bearing
            // otherwise makes a concealed commander orbit a stationary target.
            if(penetrates && surpriseStation && lineFrom(P(pos)).requiredHit) add(P(pos),1e9f);
            add(target->pos+(from*.5f+across*.87f)*off,1e9f);
            add(target->pos+(from*.5f-across*.87f)*off,1e9f);
            if(approach==T3_HUNT) add(target->pos+from*off,1e9f);
        }
        if(submerged) {
            // Await a submerged T3 at the shore nearest its course: the same
            // stations, but only dry ones survive the filter below.
        }
        for(int i=0;i<count;++i) {
            AIFloat3 station=F(stations[i]);
            station.y=ai->GetMap()->GetElevationAt(station.x,station.z);
            const float seconds=(station-pos).Length2D()/std::max(1.f,cap.speed)+.3f;
            // The engine paths around our own line; straight-line sampling
            // (Route) is for short local steps and rejects every gap.
            if(station.y<0 || !OnMap(station) || !inLane(station) || station.SqDistance2D(s.t3.anchor)>SQUARE(T3Leash(s))
                || seconds+1.5f>deadline[i]
                // A hunt is the run out through the line artillery is shelling:
                // check only where it ends (b30 legelrpcmech never left the line).
                || (approach==T3_HUNT?shelled(P(station)):shelledPath(P(pos),P(station)))) { ++rejected[0]; continue; }
            if(!ai->GetTerrainManager()->CanReachAt(unit,station,64)) { ++rejected[1]; continue; }
            if(!revealed && !CloakSafe(unit,P(pos),P(station),seconds)) { ++rejected[2]; continue; }
            const float score=bonus[i]-seconds*60.f-Exposure(P(pos),P(station),seconds,pos.y)*.05f-float(i&1)*30.f;
            if(score>bestScore) { bestScore=score; goal=station; found=true; }
        }
    }
    if(!dry && !found) {
        // Submerged commander: the D-gun cannot fire; climb out toward base.
        AIFloat3 shore=F(P(pos)+commander::Normal(P(ai->GetSetupManager()->GetBasePos())-P(pos))*cfg->combat.step);
        shore.y=ai->GetMap()->GetElevationAt(shore.x,shore.z);
        if(Route(unit,pos,shore)) Move(unit,s,shore,frame);
        return true;
    }
    if(!found && !engaged && dry && !CloakSafe(unit,P(pos),P(pos),cfg->combat.escapeSeconds)) {
        // A safe present position is not a safe wait while the enemy closes.
        // Rejected rear paths must yield back to withdrawal before proximity
        // reveals the commander; never clear fallback and then wait to be hit.
        Decline(unit,s,*target,frame,"no_hidden_station"); return false;
    }
    if(!found && !engaged && dry && shelled(P(pos))) {
        // Waiting beside a shelled friendly: step back, away from the T3.
        const Point away=commander::Normal(P(pos)-target->pos);
        AIFloat3 clear=F(P(pos)+away*(s.t3.splash+60.f));
        clear.y=ai->GetMap()->GetElevationAt(clear.x,clear.z);
        if(clear.y>=0 && OnMap(clear) && !shelled(P(clear))) { goal=clear; found=true; }
    }
    if(found && goal.SqDistance2D(pos)>8.f*8.f && (cloaked || engaged || revealed)) {
        Move(unit,s,goal,frame);
        s.t3.positionUntil=frame+int(cfg->t3.positionSeconds*FRAMES_PER_SEC);
        s.t3.positionTarget=target->id;
    }
    else if(ai->GetUnitAPI()->HasQueuedCommand(unit->GetId(),CMD_MOVE)) {
        // A previous scout/approach order may outlive its legal station after
        // reacquisition or detector movement. This task owns the queue; cancel
        // only live movement (never the pending shot handled above). One
        // bounded queue query per active T3 decision; no repeated stop orders.
        TRY_UNIT(ai,unit,unit->CmdStop();)
        s.route.clear();
    }
    if(frame>=s.lastLog+60) {
        s.lastLog=frame;
        ai->LOG("[CommanderT3] unit=%i target=%i action=%s approach=%s distance=%.0f cloaked=%i submerged=%i station=%i rejected=%i/%i/%i/%i shotSafe=%i exposure=%.0f blast=%.0f hp=%.0f floor=%.0f",
            unit->GetId(),target->id,submerged?"shore":"position",ApproachName(approach),nearest,int(cloaked),int(submerged),int(found),
            rejected[0],rejected[1],rejected[2],rejected[3],int(shotSafe),shotExposure,blast,hp,maxHp*s.t3.minHealth);
    }
    return true;
}
}
