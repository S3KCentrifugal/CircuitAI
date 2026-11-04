// Owner 2026-11-01: commander keep-out and shelling withdrawal.
//
// Sector 318C: a FRONT commander worked and reclaimed inside a human's light
// laser towers until it died; the cloak posture had judged the spot, but its
// WITHDRAW only chooses the cloak and never moves the commander. All That
// Glitters: posture=withdraw reason=artillery for 85-420 dps while the
// commander kept working on the lane.
//
// Keep-out: every scouted enemy LLT, Beamer, Twin Guard and Cacophony (the
// enemy manager keeps structure images after LOS is lost) is a disc of its
// weapon range plus tower_margin. A commander inside one walks out at once;
// commander and commander group work inside one is refused (BuilderTask and
// GroupMayBuild ask KeepOutBlocks) and the front goal is pushed out of it.
// Owner 2026-11-01: never enter a built, alive tower's disc; the lone-tower dive
// (tower_dive_chance, once per tower per tower_dive_cooldown) is off by default.
//
// Shelling: the commander's own health loss per second over shell_window,
// mostly not explained by visible weapons in reach (or the posture's own
// artillery verdict), with no radar dot closer than shell_dot_range: the
// commander steps shell_step away from the nearest radar dot (or back along
// its lane), keeps out of a shell_zone disc there for shell_zone_seconds and
// holds the withdrawal shell_hold seconds after the last such loss.
//
// Drones (owner 2026-11-02): a commander hit by a carrier or hive drone (BAR
// customparams.drone), or damaged while a visible enemy drone's weapon reaches
// it, steps drone_step back toward its rear (base, or back along its lane) and
// holds drone_hold seconds after the last hit. Not at home (BASE_RADIUS), where
// the base's AA is the cover. The only exception is the commander's top task:
// a nearby T3 it can D-gun (PriorityDGun runs first; T3Exempt releases this).
//
// Heavy groups (owner 2026-11-04): a commander never pursues a group of enemy
// T1/T2 combatants worth heavy_metal (600) or more together. RefreshKeepOut
// turns each member in radar or LOS into a keep-out disc of its weapon range
// against the commander plus heavy_margin, held heavy_hold seconds past its
// last sighting, so the same withdrawal walks the commander out, Deploy's front
// goal stays outside and work sites inside are refused (no walk back in, no
// ping-pong). A member in D-gun reach, or at most heavy_leash (50) beyond it,
// is stepped toward and shot first (PriorityDGun). A nearby T3 D-gun
// (T3Exempt) still releases the withdrawal; at home (BASE_RADIUS) heavy discs
// do not move the commander.
//
// Cost: the tower list is rebuilt once a second from the enemy manager
// (O(enemy units)); a commander tick reads O(zones) and engine reachability for
// at most eight goal candidates once a second while withdrawing.
#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "control/core/ControlledTask.h"
#include "setup/SetupManager.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "CircuitAI.h"
#include "util/math/Geometry.h"
#include "util/Utils.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <cstring>

namespace circuit {
using springai::AIFloat3;
using commander::Point;

namespace {
Point P(const AIFloat3& p) { return {p.x,p.z}; }
// Light laser and short laser/gatling towers a commander cannot outrange.
constexpr const char* TOWER_NAMES[]={"armllt","corllt","leglht","armbeamer","corhllt","legmg"};
constexpr float ZONE_EXIT=80.f;     // elmos past a zone edge a withdrawal aims for
constexpr float BASE_RADIUS=700.f;  // shelling at home leaves no keep-out disc on the base
constexpr float DIVE_SCREEN=700.f;  // no enemy combatant this close to a dived tower
}

void CCommanderController::RefreshKeepOut(CCircuitUnit* unit,int frame) {
    keepOutFrame=frame;
    keepOut.erase(std::remove_if(keepOut.begin(),keepOut.end(),
        [this,frame](const KeepOutZone& z){return z.tower || z.until<frame
            || (z.heavy && ai->GetEnemyInfo(z.id)==nullptr);}),keepOut.end());
    for(auto it=diveRolled.begin();it!=diveRolled.end();) it=it->second<frame?diveRolled.erase(it):std::next(it);
    Bind bound(this,PresetOfUnit(unit->GetId()));
    const bool towers=cfg->safety.towerKeepOut>0, porc=cfg->safety.porcKeepOut>0;
    const bool heavy=cfg->safety.heavyNoChase>0;
    if(!towers && !porc && !heavy) return;
    const int heavyUntil=frame+int(cfg->safety.heavyHold*FRAMES_PER_SEC);
    heavyScratch.clear();
    if(!towerDefsResolved) {
        towerDefsResolved=true;
        for(const char* name:TOWER_NAMES) if(auto* def=ai->GetCircuitDef(name)) towerDefs.insert(def->GetId());
    }
    for(const auto& [id,enemy]:ai->GetEnemyManager()->GetEnemyUnits()) {
        auto* def=enemy?enemy->GetCircuitDef():nullptr;
        if(!def || enemy->IsFake() || enemy->IsDead() || enemy->IsDying()) continue;
        // Owner 2026-11-04: T1/T2 ground combatants (no aircraft, commanders or
        // T3) are group candidates; their discs are made after the scan.
        if(def->IsMobile()) {
            if(!heavy || !def->IsAttacker() || def->IsAbleToFly() || def->IsRoleComm()
                || DefinitionFor(def).t3 || enemy->IsBeingBuilt() || !enemy->IsInRadarOrLOS()) continue;
            const auto& g=enemy->GetData();
            if(g.losStatus & (SEnemyData::DEAD|SEnemyData::DYING|SEnemyData::NEUTRAL|SEnemyData::HIDDEN)) continue;
            const AIFloat3& at=enemy->GetPos();
            if(!std::isfinite(at.x) || !std::isfinite(at.z)) continue;
            const auto& m=MatchupFor(def,unit->GetCircuitDef());
            heavyScratch.push_back({P(at),def->GetCostM(),m.range>cfg->safety.porcMaxRange?0.f:m.range,id});
            continue;
        }
        const bool tower=towerDefs.count(def->GetId())>0;
        bool ghost=false;
        if(tower) {
            // Owner 2026-11-01: built and alive towers; a frame last seen unfinished does not count.
            if(!towers || enemy->IsBeingBuilt()) continue;
        } else {
            // Owner 2026-11-03 (Glitters replay: a commander walked 218 inside a
            // 30%-built Pulsar): heavy and ghost porc count from the nanoframe,
            // since an assisted frame finishes in seconds.
            // Owner 2026-11-03: ghost porc of any tier and seen heavy porc.
            if(!porc || def->IsAbleToFly() || def->IsRoleSuper()) continue;
            const auto& g=enemy->GetData();
            // An image whose spot was seen empty (HIDDEN) is gone.
            if(g.losStatus & (SEnemyData::DEAD|SEnemyData::DYING|SEnemyData::NEUTRAL|SEnemyData::HIDDEN)) continue;
            ghost=!enemy->IsInRadarOrLOS();
            if(!ghost && PorcTech(def)<cfg->safety.porcHeavyTech) continue;
        }
        const auto& m=MatchupFor(def,unit->GetCircuitDef());
        if(m.range<=0.f) continue;
        if(!tower && m.range>cfg->safety.porcMaxRange) continue;
        const AIFloat3& at=enemy->GetPos();
        if(!std::isfinite(at.x) || !std::isfinite(at.z)) continue;
        KeepOutZone z; z.center=P(at); z.radius=m.range+cfg->safety.towerMargin; z.id=id; z.tower=true;
        z.porc=!tower; z.ghost=ghost;
        keepOut.push_back(z);
    }
    // Groups: each candidate sums the cost of candidates within
    // heavy_group_radius; members of a 600+ metal group get a disc of their own
    // weapon range. Once a second per AI (not per commander): an x-sorted sweep,
    // O(N log N + N*k) for k candidates in the x window, no engine calls.
    const float radius=cfg->safety.heavyGroupRadius, r2=SQUARE(radius);
    std::sort(heavyScratch.begin(),heavyScratch.end(),[](const HeavyCandidate& a,const HeavyCandidate& b){return a.pos.x<b.pos.x;});
    for(size_t i=0;i<heavyScratch.size();++i) {
        const auto& h=heavyScratch[i];
        if(h.range<=0.f) continue;
        float metal=h.cost;
        for(size_t j=i;j-->0 && h.pos.x-heavyScratch[j].pos.x<=radius;)
            if(commander::Dot(heavyScratch[j].pos-h.pos,heavyScratch[j].pos-h.pos)<=r2) metal+=heavyScratch[j].cost;
        for(size_t j=i+1;j<heavyScratch.size() && heavyScratch[j].pos.x-h.pos.x<=radius;++j)
            if(commander::Dot(heavyScratch[j].pos-h.pos,heavyScratch[j].pos-h.pos)<=r2) metal+=heavyScratch[j].cost;
        if(metal<cfg->safety.heavyMetal) continue;
        auto existing=std::find_if(keepOut.begin(),keepOut.end(),[&h](const KeepOutZone& z){return z.heavy && z.id==h.id;});
        KeepOutZone& z=existing!=keepOut.end()?*existing:keepOut.emplace_back();
        z.center=h.pos; z.radius=h.range+cfg->safety.heavyMargin; z.id=h.id; z.until=heavyUntil; z.heavy=true;
    }
}

float CCommanderController::PorcTech(CCircuitDef* def) {
    auto found=porcTech.find(def->GetId());
    if(found!=porcTech.end()) return found->second;
    float tech=1.f;
    const auto& params=def->GetDef()->GetCustomParams();
    const auto level=params.find("techlevel");
    if(level!=params.end()) tech=float(std::atof(level->second.c_str()));
    return porcTech.emplace(def->GetId(),tech).first->second;
}

const CCommanderController::KeepOutZone* CCommanderController::KeepOutAt(Point p,float margin,bool heavy) const {
    const KeepOutZone* deepest=nullptr; float depth=0;
    const int frame=ai->GetLastFrame();
    for(const auto& z:keepOut) {
        if(!z.tower && z.until<frame) continue;
        if(z.heavy && !heavy) continue;
        const float d=z.radius+margin-commander::Length(p-z.center);
        if(d>depth) { depth=d; deepest=&z; }
    }
    return deepest;
}

bool CCommanderController::KeepOutBlocks(CCircuitUnit* unit,const AIFloat3& site) const {
    if(keepOut.empty() || !unit || !geom::is_valid(site)) return false;
    if(!Handles(unit) && !IsGroupMember(unit->GetId())) return false;
    // Heavy-unit discs refuse work away from home only, like their withdrawal.
    const bool home=site.SqDistance2D(ai->GetSetupManager()->GetBasePos())<SQUARE(BASE_RADIUS);
    return KeepOutAt(P(site),0,!home)!=nullptr;
}

AIFloat3 CCommanderController::KeepOutGoal(CCircuitUnit* unit,const AIFloat3& goal) const {
    if(goal.x<0 || keepOut.empty()) return goal;
    AIFloat3 at=goal;
    // Radially out of the deepest zone, a few times for overlapping towers.
    for(int i=0;i<4;++i) {
        const auto* z=KeepOutAt(P(at));
        if(!z) return at;
        Point away=commander::Normal(P(at)-z->center);
        if(commander::Length(away)<.1f) away=commander::Normal(P(ai->GetSetupManager()->GetBasePos())-z->center);
        if(commander::Length(away)<.1f) away={0,-1};
        const Point out=z->center+away*(z->radius+ZONE_EXIT);
        at=AIFloat3(out.x,0,out.z);
        CTerrainManager::CorrectPosition(at);
        at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
    }
    // No clear spot near the goal: stay where the commander is.
    return KeepOutAt(P(at))?unit->GetPos(ai->GetLastFrame()):at;
}

AIFloat3 CCommanderController::WithdrawGoal(CCircuitUnit* unit,State& s,const AIFloat3& pos,bool shelled,int frame,bool droned) {
    const Point here=P(pos);
    auto* battle=ai->GetBattle();
    const bool lane=battle->GetFrontLaneLength()>0;
    const AIFloat3 rear=lane?battle->GetFrontLanePoint(std::max(0.f,battle->GetFrontLaneProgress(pos)-cfg->safety.shellStep))
        :ai->GetSetupManager()->GetBasePos();
    // Away from the deepest tower, else from the shelling radar dot, else rearward.
    Point away{};
    float step=cfg->safety.shellStep;
    if(const auto* z=KeepOutAt(here)) {
        away=commander::Normal(here-z->center);
        step=std::max(160.f,z->radius-commander::Length(here-z->center)+ZONE_EXIT);
    } else if(shelled && nearestDot>=0) away=commander::Normal(here-P(nearestDotPos));
    // Drones orbit their target; the rear (friendly AA, away from the carrier's
    // leash) is the useful direction, not away from one drone.
    else if(droned && !shelled) step=cfg->safety.droneStep;
    if(commander::Length(away)<.1f) away=commander::Normal(P(rear)-here);
    if(commander::Length(away)<.1f) away={0,-1};
    // Eight headings, straight away first, then turning toward the rear.
    const Point toRear=commander::Normal(P(rear)-here);
    AIFloat3 best=ai->GetSetupManager()->GetBasePos(); float bestScore=1e30f;
    for(int i=0;i<8;++i) {
        const float angle=float((i+1)/2)*.785398163f*(i%2?1.f:-1.f);
        const Point direction{away.x*std::cos(angle)-away.z*std::sin(angle),away.x*std::sin(angle)+away.z*std::cos(angle)};
        const Point end=here+direction*step;
        AIFloat3 at(end.x,0,end.z);
        if(!OnMap(at)) continue;
        at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
        if(!ai->GetTerrainManager()->CanReachAt(unit,at,64.f)) continue;
        const bool clear=KeepOutAt(end)==nullptr;
        const float score=(clear?0.f:10000.f)+float(i)*100.f-commander::Dot(direction,toRear)*50.f
            +Exposure(end,end,cfg->combat.escapeSeconds,at.y);
        if(score<bestScore) { bestScore=score; best=at; }
        if(clear && i==0) break;
    }
    (void)s; (void)frame;
    return best;
}

bool CCommanderController::TowerDive(CCircuitUnit* unit,State& s,const KeepOutZone& zone,int frame) {
    // Owner 2026-11-03: porc zones (ghost or heavy) are never dived; only light towers.
    if(zone.porc || cfg->safety.towerDiveChance<=0 || frame<nextDiveFrame) return false;
    if(diveRolled.count(zone.id)) return false;
    auto* tower=ai->GetEnemyInfo(zone.id);
    // A remembered image cannot be aimed at; a tower under construction is not worth a shot.
    if(!tower || !tower->IsInLOS() || tower->IsBeingBuilt()) return false;
    if(unit->GetHealthPercent()<cfg->safety.towerDiveHealth) return false;
    const float shot=unit->GetCircuitDef()->GetDGunDef()->GetCostE();
    if(!unit->IsDGunReady(frame,ai->GetEconomyManager()->GetEnergyCur()-std::max(0.f,reserve)-shot)) return false;
    // Alone: no other tower covers the firing point, no enemy combatant screens it.
    const float reach=unit->GetDGunRange();
    for(const auto& z:keepOut)
        if(z.tower && z.id!=zone.id && commander::Length(z.center-zone.center)<z.radius+reach) return false;
    for(const auto& c:contacts)
        if(!c.friendly && c.combatTier>0 && commander::Length(c.pos-zone.center)<DIVE_SCREEN) return false;
    // One roll per tower per cooldown; deterministic per frame, tower and team.
    diveRolled[zone.id]=frame+int(cfg->safety.towerDiveCooldown*FRAMES_PER_SEC);
    const unsigned roll=(unsigned(frame)*2654435761u)^(unsigned(zone.id)*40503u)^(unsigned(ai->GetTeamId())*97u);
    if(float(roll%1000u)>=cfg->safety.towerDiveChance*1000.f) {
        ai->LOG("[CommanderSafety] unit=%i tower=%i dive=declined_roll",unit->GetId(),zone.id);
        return false;
    }
    nextDiveFrame=frame+int(cfg->safety.towerDiveCooldown*FRAMES_PER_SEC);
    s.keep.diveTarget=zone.id; s.keep.diveStart=frame; s.keep.diveUntil=frame+8*FRAMES_PER_SEC;
    ai->LOG("[CommanderSafety] unit=%i tower=%i action=tower_dive hp=%.2f",unit->GetId(),zone.id,unit->GetHealthPercent());
    return true;
}

bool CCommanderController::SafetyWithdraw(CCircuitUnit* unit,State& s,int frame) {
    auto* current=unit->GetTask();
    auto* def=unit->GetCircuitDef();
    const auto pos=unit->GetPos(frame);
    const float hp=unit->GetUnit()->GetHealth();
    // Health loss inside the window; a gap in ticks (another owner) restarts it.
    if(s.keep.lastHp>=0 && frame-s.keep.lastHpFrame<=10 && hp<s.keep.lastHp)
        s.keep.losses.emplace_back(frame,s.keep.lastHp-hp);
    s.keep.lastHp=hp; s.keep.lastHpFrame=frame;
    const int window=int(cfg->safety.shellWindow*FRAMES_PER_SEC);
    s.keep.losses.erase(std::remove_if(s.keep.losses.begin(),s.keep.losses.end(),
        [&](const auto& l){return l.first<frame-window;}),s.keep.losses.end());

    auto* task=dynamic_cast<CControlledTask*>(current);
    // Ends a withdrawal. Resuming the controlled task ends this tick too: the
    // rest of Tick must not touch the task it read before the hand-back.
    const auto release=[&](const char* why,bool resume) {
        if(!s.keep.active && s.keep.diveTarget<0) return false;
        ai->LOG("[CommanderSafety] unit=%i action=keep_out_end reason=%s",unit->GetId(),why);
        s.keep.active=false; s.keep.diveTarget=-1; s.keep.goal={-1,0,-1};
        if(!resume || !task) return false;
        Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame); task->Resume(unit);
        return true;
    };
    if(ActualDecoy(def) || current==nullptr || current->GetType()==IUnitTask::Type::RETREAT
        || s.pending>=0 || T3Exempt(unit,s,frame)) { release("other_owner",false); return false; }

    // A dive owns the commander until its shot, its deadline or lost health.
    if(s.keep.diveTarget>=0) {
        auto* tower=ai->GetEnemyInfo(s.keep.diveTarget);
        const bool fired=s.fired>=s.keep.diveStart;
        if(task && tower && !fired && frame<s.keep.diveUntil && unit->GetHealthPercent()>=cfg->safety.towerDiveHealth-.25f) return true;
        ai->LOG("[CommanderSafety] unit=%i tower=%i dive_end fired=%i alive=%i hp=%.2f",
            unit->GetId(),s.keep.diveTarget,int(fired),int(tower!=nullptr),unit->GetHealthPercent());
        s.keep.diveTarget=-1;
        if(!tower) keepOut.erase(std::remove_if(keepOut.begin(),keepOut.end(),
            [&](const KeepOutZone& z){return z.tower && ai->GetEnemyInfo(z.id)==nullptr;}),keepOut.end());
    }

    // Shelling: our own health falls faster than what we can see explains.
    if(cfg->safety.shellLossRate>0 && !s.keep.losses.empty()) {
        float lost=0; for(const auto& l:s.keep.losses) lost+=l.second;
        const float rate=lost/std::max(1.f,cfg->safety.shellWindow);
        bool heavy=false;
        for(const auto& c:contacts) if(!c.friendly && c.t3) { heavy=true; break; }
        const bool verdict=std::strcmp(s.conceal.postureReason,"artillery")==0;
        const bool unexplained=visibleReachDps<rate*cfg->safety.shellUnexplained;
        const bool farDots=nearestDot<0 || nearestDot>=cfg->safety.shellDotRange;
        if(!heavy && rate>=cfg->safety.shellLossRate && ((unexplained && farDots) || verdict)) {
            if(frame>=s.keep.shelledUntil)
                ai->LOG("[CommanderSafety] unit=%i action=shelled rate=%.0f visible=%.0f dot=%.0f verdict=%i hp=%.2f",
                    unit->GetId(),rate,visibleReachDps,nearestDot,int(verdict),unit->GetHealthPercent());
            s.keep.shelledUntil=frame+int(cfg->safety.shellHold*FRAMES_PER_SEC);
            const bool home=pos.SqDistance2D(ai->GetSetupManager()->GetBasePos())<SQUARE(BASE_RADIUS);
            if(cfg->safety.shellZone>0 && !home) {
                const int until=frame+int(cfg->safety.shellZoneSeconds*FRAMES_PER_SEC);
                auto existing=std::find_if(keepOut.begin(),keepOut.end(),[&](const KeepOutZone& z){
                    return !z.tower && !z.heavy && commander::Length(z.center-P(pos))<cfg->safety.shellZone*.5f;});
                if(existing!=keepOut.end()) existing->until=until;
                else { KeepOutZone z; z.center=P(pos); z.radius=cfg->safety.shellZone; z.until=until; keepOut.push_back(z); }
            }
        }
    }

    // Drone fire: a known drone hit us within the last second, or we took
    // damage within the last second with a visible drone's weapon in reach.
    if(cfg->safety.droneRetreat>0) {
        const bool recentDamage=s.lastDamage>=0 && frame-s.lastDamage<FRAMES_PER_SEC;
        const bool hitByDrone=frame-s.keep.droneHit<FRAMES_PER_SEC;
        const bool home=pos.SqDistance2D(ai->GetSetupManager()->GetBasePos())<SQUARE(BASE_RADIUS);
        if(!home && (hitByDrone || (recentDamage && dronesInReach>0))) {
            if(frame>=s.keep.droneUntil)
                ai->LOG("[CommanderSafety] unit=%i action=drone_fire hit=%i drones=%i hp=%.2f",
                    unit->GetId(),int(hitByDrone),dronesInReach,unit->GetHealthPercent());
            s.keep.droneUntil=frame+int(cfg->safety.droneHold*FRAMES_PER_SEC);
        }
    } else s.keep.droneUntil=-1;

    // Heavy-unit discs do not move a commander at home, where the base is the cover.
    const bool atHome=pos.SqDistance2D(ai->GetSetupManager()->GetBasePos())<SQUARE(BASE_RADIUS);
    const auto* zone=KeepOutAt(P(pos),0,!atHome);
    const bool shelled=frame<s.keep.shelledUntil;
    const bool droned=frame<s.keep.droneUntil;
    if(!zone && !shelled && !droned) return release("clear",true);
    if(zone && zone->tower && !shelled && !droned && !s.keep.active && TowerDive(unit,s,*zone,frame)) {
        // The dive is held under a controlled task like any engagement.
        if(!task) {
            task=ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
            ai->GetBuilderManager()->AssignTask(unit,task);
            if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); s.keep.diveTarget=-1; return false; }
            s.started=frame; ++operation;
        }
        Transition(unit,s,Mode::PENDING,frame);
        TRY_UNIT(ai,unit,unit->ManualFire(ai->GetEnemyInfo(zone->id),s.keep.diveUntil);)
        return true;
    }
    if(!task) {
        // Drop the work that walked us in; the ladder offers new work outside.
        task=ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
        s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
        TRY_UNIT(ai,unit,unit->CmdStop();)
    }
    const char* reason=zone && zone->heavy?"heavy_unit":zone && zone->porc?(zone->ghost?"porc_ghost":"porc_heavy")
        :zone && zone->tower?"tower":shelled?"shelled":droned?"drones":"shell_zone";
    if(!s.keep.active || std::strcmp(s.keep.reason,reason)!=0)
        ai->LOG("[CommanderSafety] unit=%i action=keep_out reason=%s tower=%i hp=%.2f x=%.0f z=%.0f",
            unit->GetId(),reason,zone && (zone->tower || zone->heavy)?zone->id:-1,unit->GetHealthPercent(),pos.x,pos.z);
    if(!s.keep.active) { s.route.clear(); s.keep.goal={-1,0,-1}; }
    s.keep.active=true; s.keep.reason=reason;
    s.budget=0; s.deployed=false;
    Transition(unit,s,Mode::ESCAPE,frame);
    if(frame>=s.keep.goalPlan+FRAMES_PER_SEC || s.keep.goal.x<0 || pos.SqDistance2D(s.keep.goal)<SQUARE(48.f)
        || KeepOutAt(P(s.keep.goal))) {
        s.keep.goalPlan=frame;
        s.keep.goal=WithdrawGoal(unit,s,pos,shelled,frame,droned);
    }
    if(s.keep.goal.SqDistance2D(pos)>SQUARE(32.f)) Move(unit,s,s.keep.goal,frame,true);
    return true;
}

} // namespace circuit
