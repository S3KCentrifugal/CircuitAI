#include "task/fighter/RangedEngagement.h"
#include "task/UnitTask.h"
#include "CircuitAI.h"
#include "module/MilitaryManager.h"
#include "module/EconomyManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathSingle.h"
#include "terrain/path/QueryLineMap.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "spring/CustomCommand.h"
#include "spring/SpringUnit.h"
#include "util/Utils.h"
#include "util/Performance.h"
#include "Weapon.h"
#include "Log.h"
#include "WeaponMount.h"
#include "AISCommands.h"
#include <cmath>
#include <limits>
#include <cstdlib>
#include <cstdio>
#include <string>
#include <map>

namespace circuit {
namespace {
constexpr float POKE_DIRECTION_MIN_LENGTH_SQ = .5f;
constexpr float PRESSED_STATIC_TARGET_MULTIPLIER = 2.f;
// Owner 2026-11-07 (priority_min_tech): far above any value/HP score (those are
// ~0.01-1000 even with commander_priority 100), so the tier always wins.
constexpr float PRIORITY_TIER_OFFSET = 1.e6f;
// Owner 2026-11-15 (structures_over_slow, Wolverine/Shellshocker): structures and quickly moving
// units sit one tier above slow or parked units (commanders included) when both are in range; inside
// a tier the normal score decides. Below PRIORITY_TIER_OFFSET, above any score.
constexpr float STRUCTURE_TIER_OFFSET = 1.e5f;
// Slow = moving at most min(25% of its own top speed, cap) elmos/s (the Ambassador rule).
template<class C> bool SlowMobile(const C& c, float cap) {
    if(!c.mobile || !c.def) return false;
    const float limit=std::min(c.def->GetSpeed()*.25f,cap);
    return c.velocity.x*c.velocity.x+c.velocity.z*c.velocity.z<=limit*limit;
}
}
using springai::AIFloat3;
static ranged::Point P(const AIFloat3& p) { return {p.x,p.z}; }
static const bool trace = std::getenv("CIRCUIT_RANGED_TRACE") != nullptr;
// Owner 2026-11-02: ghost porc reach for this hull; cohorts keep observed-only.
// Owner 2026-11-07: coordinated cohorts read ghost porc only with cohort_ghost_porc.
static float GhostRange(const RangedPolicy& p) { return p.coordinated && !p.cohortGhostPorc ? 0.f : p.ghostPorcRange; }
// Owner 2026-11-04: margin against static coverage (live and ghost porc) for
// the individual controller; safety_margin unless static_margin is set.
static float StaticMargin(const RangedPolicy& p) { return (!p.coordinated && p.staticMargin>=0.f) ? p.staticMargin : p.safetyMargin; }
// DangerSign/Danger argument: -1 keeps one margin for every contact.
static float StaticDanger(const RangedPolicy& p) { return (!p.coordinated && p.staticMargin>=0.f) ? p.staticMargin : -1.f; }
// Owner 2026-11-12: static_exact_reach on for this hull's decisions/path checks.
namespace {
// Owner 2026-11-18: kite_min_tech / kite_ignore_fast_dots share the scope.
struct ExactStaticScope {
    const CRangedWorld& w; bool prev; float prevTech, prevDot; const RangedPolicy* prevSpam; const RangedPolicy* prevPorc;
    ExactStaticScope(const CRangedWorld& w,const RangedPolicy& p) : w(w),prev(w.ExactStatic()),prevTech(w.KiteMinTech()),prevDot(w.KiteDotSpeed()),prevSpam(w.SpamFilter()),prevPorc(w.PorcFilter()) {
        w.SetExactStatic(!p.coordinated && p.staticExactReach);
        w.SetKiteFilter(p.coordinated ? 0.f : p.kiteMinTech,
            (!p.coordinated && p.kiteIgnoreFastDots) ? std::max(1.f,p.spamDotSpeed) : 0.f);
        w.SetSpamFilter((!p.coordinated && p.spamNoHazard && p.HasSpam()) ? &p : nullptr);   // owner 2026-11-23
        w.SetPorcFilter((!p.coordinated && p.porcHazardList) ? &p : nullptr);                  // owner 2026-11-23
    }
    ~ExactStaticScope() { w.SetExactStatic(prev); w.SetKiteFilter(prevTech,prevDot); w.SetSpamFilter(prevSpam); w.SetPorcFilter(prevPorc); }
};
}

// Owner 2026-11-23: the heavy porc this unit's group is assaulting is no hazard during its decision.
struct PorcExemptScope {
    const CRangedWorld& w; int prev;
    PorcExemptScope(const CRangedWorld& w,int id) : w(w),prev(w.PorcExempt()) { w.SetPorcExempt(id); }
    ~PorcExemptScope() { w.SetPorcExempt(prev); }
};
CRangedEngagement::CRangedEngagement(CCircuitAI* ai,IUnitTask* owner,CCircuitUnit* unit)
    : ai(ai),owner(owner),worldOwner(ai->GetMilitaryManager()->GetRangedWorld()),world(*worldOwner),
      caps(world.CapabilitiesFor(unit->GetCircuitDef())),id(unit->GetId()),
      lastPos(unit->GetPos(ai->GetLastFrame())), destination(lastPos)
{
    lastShotFrame=lastProgressFrame=ai->GetLastFrame();
    world.Join(unit); world.Refresh();
    unit->TrySetMoveState(CCircuitDef::HOLD_POS);
    // Priority targets are explicit user targets in BAR and can fire on HOLD.
    // Automatic fire would bypass precision/splash selection while approaching
    // the firing band (the engine includes target radius in reach).
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    // Fast-reload Thugs/Maces otherwise remain silent between priority picks.
    // The individual controller retains precision HOLD behavior.
    // Keep primary reload observation across loss of a priority target. Leaving
    // firing range clears liveWeapon; treating that as ready made poke phases
    // alternate every decision while the gun was actually still reloading.
    // One wrapper per controller lifetime, one fresh callback per decision.
    if(policy.coordinated && policy.pokeIn>0.f && !caps.weapons.empty()) {
        pokeWeapon.reset(unit->GetUnit()->GetWeapon(caps.weapons.front().mount.get()));
        pokeReload=pokeWeapon->GetReloadFrame();
    }
    // Poke hulls open fire only while a peer engagement owns their movement.
    // Ordinary kite/retreat retains explicit targeting; blanket OPEN lost the
    // third Thug in the outmatched-mobile regression (D-355).
    // Owner 2026-10-28: always_fire_at_will hulls stay open for the whole
    // engagement (AI #9's Thugs and Aggravators stood on hold fire in range).
    // Merge 2026-11-01: Cent's D-383 fire_in_range / commander_focus is the
    // default for those hulls now; always_fire_at_will stays as the toggle.
    const bool open=policy.alwaysFireAtWill || (policy.coordinated && policy.fireAtWill && policy.pokeIn<=0.f);
    fireOpen=open;
    unit->TrySetFireState(open?CCircuitDef::FireType::OPEN:CCircuitDef::HOLD);
    ai->LOG("RANGED: assigned %s(%d) weapons=%u",unit->GetCircuitDef()->GetDef()->GetName(),id,unsigned(caps.weapons.size()));
    if(caps.weapons.empty()) ai->LOG("[INVARIANT] INV-147 ranged unit %d has no compatible loaded weapon",id);
    if(trace) for(const auto& w:caps.weapons) ai->LOG("RANGED: weapon unit=%d index=%d range=%.1f speed=%.3f gravity=%.3f category=%d forward=%d",id,w.index,w.range,w.speed,w.gravity,w.category,int(w.forward));
}
CRangedEngagement::~CRangedEngagement()
{
    lifetime.reset(); query.reset();
    // Stop/ForgetUnit can bypass normal reassignment. Registry entries and
    // shot reservations must not survive any of those ownership boundaries.
    if(!released) world.Leave(id);
}
void CRangedEngagement::Release(CCircuitUnit* unit,bool commands)
{
    if(released) return;
    lifetime.reset(); query.reset(); ++generation; world.Leave(id); released=true;
    if(!commands || !unit || unit->IsDead()) return;
    if(target>=0) {
        TRY_UNIT(ai,unit,
            unit->CancelTaskTarget(target);
        )
    }
    unit->TrySetMoveState(unit->GetCircuitDef()->GetMoveState());
    // 2026-11-06: a fire-at-will hull with a spam rule leaves on HOLD; outside
    // this controller CMilitaryManager::UpdateSpamFireHold opens it to its
    // default fire state only while no spam is in reach (retreat, routes).
    const auto& p=unit->GetCircuitDef()->GetRangedPolicy();
    const bool spamHold=p.fireAtWill && !p.alwaysFireAtWill && !p.coordinated && p.HasSpam();
    unit->TrySetFireState(spamHold ? CCircuitDef::HOLD : unit->GetCircuitDef()->GetFireState());
}
void CRangedEngagement::SelectTarget(CCircuitUnit* unit,int selected,int weapon,float damage,float score)
{
    const int frame=ai->GetLastFrame();
    if(selected==target && weapon==weaponIndex) {
        // BAR owns the actual priority target. A lost command must be repaired;
        // an unchanged live intent must not be resent each decision tick.
        if(selected<0 || frame-targetFrame<30 || int(unit->GetUnit()->GetRulesParamFloat("unitTargetID",-1.f))==selected) return;
    }
    // Owner 2026-10-19: a live priority target is kept for target_min_seconds;
    // each swap costs CANCEL+SET. The held target must have passed this tick's
    // candidate filters (heldScoreFrame), and a pick scoring target_switch_ratio
    // times its score (closing threats and pressed towers included) still
    // switches at once.
    const auto& holdPolicy=unit->GetCircuitDef()->GetRangedPolicy();
    const float hold=holdPolicy.targetMinSeconds;
    const float switchRatio=holdPolicy.targetSwitchRatio;
    if(target>=0 && selected>=0 && selected!=target && hold>0.f && frame-targetFrame<int(hold*FRAMES_PER_SEC)
        && heldScoreFrame==frame && score>=0.f && score<heldScore*switchRatio
        && ai->GetEnemyManager()->GetEnemyUnit(target)!=nullptr
        && int(unit->GetUnit()->GetRulesParamFloat("unitTargetID",-1.f))==target) return;
    const int avoid=unit->GetCircuitDef()->GetRangedPolicy().avoidCategory;
    if(selected>=0 && avoid!=0) {
        // INV-207: every candidate loop filters identified avoided categories
        // before this call; a blind shot at an unidentified slow dot is legal
        // and never flagged. One enemy lookup per changed intent.
        auto* enemy=ai->GetEnemyManager()->GetEnemyUnit(selected);
        if(enemy && enemy->GetCircuitDef() && (enemy->GetCircuitDef()->GetCategory()&avoid)) {
            ai->LOG("[INVARIANT] INV-207 ranged unit %d selected identified avoided-category target %d (%s); refused",
                id,selected,enemy->GetCircuitDef()->GetDef()->GetName());
            selected=-1; weapon=-1; damage=0.f;
            if(target<0) return;
        }
    }
    // Owner 2026-10-25: unit-count throttle on target changes (10 s at 2,500
    // AI units, 20 s at 3,000, 30 s at 3,500, util/LagLoad.h). A held-back change keeps the old intent.
    if((target>=0 || selected>=0) && !unit->LagAllowTarget()) return;
    if(selected!=target || weapon!=weaponIndex) world.ReleaseShot(id);
    TRY_UNIT(ai,unit,
        // Through the unit, so a D-352 commander lock keeps BAR's list.
        if(target>=0 && target!=selected) unit->CancelTaskTarget(target);
        if(selected>=0) unit->SendTaskTarget(selected);
    )
    if(weapon!=weaponIndex) {
        liveWeapon.reset(weapon>=0 ? unit->GetUnit()->GetWeapon(caps.weapons[weapon].mount.get()) : nullptr);
        lastReload=liveWeapon ? liveWeapon->GetReloadFrame() : -1;
    }
    target=selected; weaponIndex=weapon; targetFrame=frame; reservedDamage=damage;
    if(selected>=0) world.ReserveShot(id,selected,damage,frame+90);
}
bool CRangedEngagement::Spam(const RangedPolicy& p,const CRangedWorld::Contact& c)
{
    if(!c.def) {
        if(!p.spamRadarDots || c.ghost || c.airDot) return false;
        // Owner 2026-11-06: a dot we had in LOS keeps that identity for the
        // spam rule (a Hammer fading to radar stays a target). A dot never
        // seen is spam only while it moves beyond radar jiggle (owner 21:23Z):
        // a still dot stays a blind target.
        const CCircuitDef* d=c.seenDef;
        if(d==nullptr) return c.velocity.x*c.velocity.x+c.velocity.z*c.velocity.z>p.spamDotSpeed*p.spamDotSpeed;
        return d->IsMobile() && ((p.spamMaxCost>0.f && d->GetCostM()<=p.spamMaxCost) || p.spamDefs.count(d->GetId()))
            && !d->IsEnemyRoleAny(CCircuitDef::COMM);
    }
    return c.def && c.mobile && ((p.spamMaxCost>0.f && c.cost<=p.spamMaxCost) || p.spamDefs.count(c.def->GetId()))
        && !c.def->IsEnemyRoleAny(CCircuitDef::COMM);
}
void CRangedEngagement::UpdateFireState(CCircuitUnit* unit,bool open)
{
    // Holding is immediate; reopening waits a second after the last change.
    if(unit->GetCircuitDef()->GetRangedPolicy().alwaysFireAtWill) return;
    const int frame=ai->GetLastFrame();
    if(open==fireOpen || (open && frame<fireStateFrame+30)) return;
    fireOpen=open; fireStateFrame=frame;
    unit->TrySetFireState(open?CCircuitDef::FireType::OPEN:CCircuitDef::HOLD);
    if(trace) ai->LOG("RANGED: fire unit=%d open=%d",id,int(open));
}
void CRangedEngagement::Hold(CCircuitUnit* unit,bool unsafe)
{
    // Range eligibility alone cannot cancel a facing step. Safety owns an
    // immediate override; actual fire clears the commitment in Update.
    if(!unsafe && ai->GetLastFrame()<orientUntil) {
        ai->LOG("[INVARIANT] INV-164 ranged firing hold interrupted facing recovery unit=%d",id);
        return;
    }
    orientUntil=0;
    query.reset(); ++generation; marching=false;
    if(moving && !issuing) {
        moving=false; path.clear(); issuing=true;
        TRY_UNIT(ai,unit,unit->CmdStop();)
        // STOP cancels BAR's priority target. Repair it in this same decision,
        // rather than waiting for an unrelated idle or retarget event.
        targetFrame=0;
        issuing=false;
    }
}
// Owner 2026-11-21 (Daedalus arena, radar mode): a still, never-identified ground
// radar dot may be porc that outranges us. With unknown_static_reach set, a move
// may not end within that reach of one and nearer it than it began (leaving is
// allowed). The dot list is rebuilt once per frame, O(contacts), only for such hulls.
bool CRangedEngagement::UnknownStaticBlocks(CCircuitUnit* unit,const AIFloat3& from,const AIFloat3& to)
{
    const auto& p=unit->GetCircuitDef()->GetRangedPolicy();
    if(!(p.unknownStaticReach>0.f)) return false;
    const int frame=ai->GetLastFrame();
    if(frame!=unknownStillFrame) {
        unknownStillFrame=frame; unknownStill.clear();
        for(const auto& c:world.Contacts()) {
            if(c.def || c.airDot || c.seenDef || c.pos.y< -20.f) continue;
            if(c.velocity.x*c.velocity.x+c.velocity.z*c.velocity.z>p.spamDotSpeed*p.spamDotSpeed) continue;
            unknownStill.push_back(c.pos);
        }
    }
    const float r2=p.unknownStaticReach*p.unknownStaticReach;
    for(const auto& u:unknownStill) { const float db=u.SqDistance2D(to); if(db<r2 && db<u.SqDistance2D(from)) return true; }
    return false;
}
// Owner 2026-11-23 (Salt Reef replay: AI 11 Fatboys below a 200-elmo plateau).
// Our Trajectory said "clear" where the engine's line of fire hit the cliff lip,
// so a Fatboy held a target it never fired at; and the nearest plateau contact,
// with no firing site and the march halted, stayed the objective for minutes.
// Such a contact is left alone for shun_seconds; the next one is taken. O(shunned).
bool CRangedEngagement::Shunned(int contact) const
{
    if(contact<0) return false;
    const int frame=ai->GetLastFrame();
    for(const auto& s:shunned) if(s.first==contact && frame<s.second) return true;
    return false;
}
void CRangedEngagement::Shun(int contact,const char* why)
{
    if(contact<0) return;
    const int frame=ai->GetLastFrame();
    shunned.erase(std::remove_if(shunned.begin(),shunned.end(),[&](const std::pair<int,int>& s){return s.second<=frame || s.first==contact;}),shunned.end());
    const float seconds=ai->GetTeamUnit(id) ? ai->GetTeamUnit(id)->GetCircuitDef()->GetRangedPolicy().shunSeconds : 0.f;
    if(seconds<=0.f) return;
    shunned.emplace_back(contact,frame+int(seconds*FRAMES_PER_SEC));
    ai->LOG("RANGED: shun unit=%d target=%d why=%s seconds=%.0f",id,contact,why,seconds);
}
bool CRangedEngagement::SafeMove(CCircuitUnit* unit,const AIFloat3& from,const AIFloat3& to,float margin,bool escape)
{
    const auto& p=unit->GetCircuitDef()->GetRangedPolicy();
    ExactStaticScope exact(world,p);
    if(UnknownStaticBlocks(unit,from,to)) return false;
    return p.coordinated && p.engagementSeconds>0.f ? world.CohortSafe(unit,from,to,margin,escape)
        :world.Safe(from,to,margin,escape,p.pressStatic,GhostRange(p));
}
bool CRangedEngagement::LegalPath(CCircuitUnit* unit,const std::vector<AIFloat3>& route,bool escape)
{
    AIFloat3 from=unit->GetPos(ai->GetLastFrame());
    const float margin=StaticMargin(unit->GetCircuitDef()->GetRangedPolicy());
    const size_t first=(&route==&path)?pathCursor:0;
    for(size_t i=first;i<route.size();++i) {
        const auto& p=route[i];
        if(from.SqDistance2D(p)<16.f) continue;
        if(!SafeMove(unit,from,p,margin,escape)) return false;
        from=p;
    }
    return true;
}

void CRangedEngagement::Disperse(CCircuitUnit* unit)
{
    const auto pos=unit->GetPos(ai->GetLastFrame());
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    // Finishing the last target must not cancel a formation move and leave
    // explosive hulls packed together. Continue only the previously validated
    // route (Update rechecks its coverage). A rear-only idle rule was tested
    // and rejected: it reduced Starlight bait clearance from nine to two,
    // without improving closing-assault survival. See D-207's played record.
    if (query || moving) return;
    if (world.FreeSlot(id,pos,policy.spacing)) {
        world.SetSlot(id,pos,policy.spacing,unit->GetCircuitDef()->GetCostM());
        return;
    }
    for (int ring=1;ring<=3;++ring) for (int i=0;i<16;++i) {
        const float angle=(i+(id%16))*.3926990817f;
        AIFloat3 point=pos+AIFloat3(std::cos(angle),0.f,std::sin(angle))*policy.spacing*float(ring);
        CTerrainManager::CorrectPosition(point);
        point.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(point.x,point.z);
        if (world.FreeSlot(id,point,policy.spacing) && world.Safe(pos,point,StaticMargin(policy),true,policy.pressStatic,GhostRange(policy))
            && world.DangerSign(point,policy.safetyMargin,policy.pressStatic,GhostRange(policy),StaticDanger(policy))==0.f
            && ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),point)) {
            Move(unit,point,true); return;
        }
    }
}
// Owner 2026-11-16: timing per unit, kept across re-assignments (a retreat and
// back makes a new controller). Keyed by AI instance and unit id; one entry per
// ranged unit for the game.
namespace {
struct SRangedTiming { int born=-1, front=-1, engage=-1; };
std::map<std::pair<const void*,int>,SRangedTiming> rangedTimings;
const bool noMarch = std::getenv("CIRCUIT_RANGED_NO_MARCH") != nullptr;   // A/B baseline only
}
void CRangedEngagement::TimingFront(CCircuitUnit* unit,const char* reason)
{
    auto& t=rangedTimings[{ai,id}];
    if(t.born<0 || t.front>=0) return;
    const int frame=ai->GetLastFrame(); t.front=frame;
    const auto pos=unit->GetPos(frame);
    ai->LOG("RANGEDTIME: front unit=%d def=%s frame=%d after=%.1f reason=%s pos=%.0f,%.0f",id,
        unit->GetCircuitDef()->GetDef()->GetName(),frame,float(frame-t.born)/FRAMES_PER_SEC,reason,pos.x,pos.z);
}
void CRangedEngagement::TimingTick(CCircuitUnit* unit,const AIFloat3& pos,float maxRange,bool drones)
{
    const int frame=ai->GetLastFrame();
    auto& t=rangedTimings[{ai,id}];
    if(t.born<0) {
        t.born=frame;
        ai->LOG("RANGEDTIME: born unit=%d def=%s frame=%d produced=%d pos=%.0f,%.0f march=%d",id,
            unit->GetCircuitDef()->GetDef()->GetName(),frame,unit->GetProductionFrame(),pos.x,pos.z,int(!noMarch));
    }
    if(t.front<0) {
        // At the front: a ground contact (live, any identity) inside weapon reach + 500.
        const float r=maxRange+500.f;
        for(int i:nearby) {
            const auto& c=world.Contacts()[i];
            if((c.def && c.def->IsAbleToFly()) || c.airDot || c.pos.y< -20.f) continue;
            if(pos.SqDistance2D(c.pos)<=r*r) { TimingFront(unit,"contact"); break; }
        }
    }
    if(t.engage<0) {
        const int fired=unit->GetFireFrame();
        const char* how=(fired>=t.born && fired>0) ? "shot" : (drones ? "drones" : nullptr);
        if(how) {
            if(t.front<0) TimingFront(unit,how);
            t.engage=frame;
            ai->LOG("RANGEDTIME: engage unit=%d def=%s frame=%d after=%.1f sinceFront=%.1f how=%s",id,
                unit->GetCircuitDef()->GetDef()->GetName(),frame,float(frame-t.born)/FRAMES_PER_SEC,
                float(frame-t.front)/FRAMES_PER_SEC,how);
        }
    }
}
bool CRangedEngagement::MarchGoal(const AIFloat3& pos,AIFloat3& goal)
{
    float best=std::numeric_limits<float>::max();
    // 1. ghost porc: the last known defence line
    for(const auto& g:world.Ghosts()) {
        const float d=pos.SqDistance2D(g.pos);
        if(d<best) { best=d; goal=g.pos; }
    }
    if(best<std::numeric_limits<float>::max()) return true;
    // 2. any known enemy ground unit or structure, last known position
    for(const auto& kv:ai->GetEnemyInfos()) {
        const CEnemyInfo* e=kv.second;
        if(e==nullptr || e->IsHidden()) continue;
        const CCircuitDef* d=e->GetCircuitDef();
        if(d!=nullptr && d->IsAbleToFly()) continue;
        const AIFloat3& p=e->GetPos();
        if(!std::isfinite(p.x) || !std::isfinite(p.z) || p.x<0.f || p.z<0.f) continue;
        const float dist=pos.SqDistance2D(p);
        if(dist<best) { best=dist; goal=p; }
    }
    if(best<std::numeric_limits<float>::max()) return true;
    // 3. the nearest enemy start in the start script
    auto* setup=ai->GetSetupManager();
    const int starts=setup->GetScriptStartCount();
    for(int i=0;i<starts;++i) {
        if(!setup->IsScriptStartEnemy(i)) continue;
        const AIFloat3 p=setup->GetScriptStart(i);
        if(p.x<0.f || p.z<0.f) continue;
        const float dist=pos.SqDistance2D(p);
        if(dist<best) { best=dist; goal=p; }
    }
    if(best<std::numeric_limits<float>::max()) return true;
    // 4. the enemy manager's centre of enemy groups (terrain centre when blind)
    goal=ai->GetEnemyManager()->GetEnemyPos();
    return pos.SqDistance2D(goal)>1000.f*1000.f;
}
// Owner 2026-11-23: nearest enemy structure known only as a ghost (identified, last position,
// not in radar or LOS, not seen empty, not air). Any kind (labs, eco, porc): it is a target, not
// only a hazard. O(enemies), only for porc_hazards hulls with no live objective.
// Owner 2026-11-23: heavy porc group assault. The nearest heavy porc (live or ghost) whose reach we are
// at (hazard + margin + 600) is the one blocking us: join its group; once assault_min_group hulls wait on
// it (or assault_max_wait passes) the group goes in (see PorcExemptScope). O(contacts + ghosts).
void CRangedEngagement::UpdateAssault(CCircuitUnit* unit,const AIFloat3& pos,int frame)
{
    const auto& p=unit->GetCircuitDef()->GetRangedPolicy();
    int bestId=-1; float best=std::numeric_limits<float>::max(); AIFloat3 bestPos; bool bestGhost=false;
    const auto consider=[&](const CRangedWorld::Contact& c,bool ghost) {
        if(c.def==nullptr || p.heavyPorcDefs.count(c.def->GetId())==0 || (c.mobile && !ghost)) return;
        const float reach=c.hazardRadius+StaticMargin(p)+600.f;
        const float d2=pos.SqDistance2D(c.pos);
        if(d2>reach*reach || d2>=best) return;
        best=d2; bestId=c.id; bestPos=c.pos; bestGhost=ghost;
    };
    for(const auto& c:world.Contacts()) consider(c,false);
    for(const auto& c:world.Ghosts()) consider(c,true);
    if(bestId<0) {
        if(assaultPorc>=0) ai->LOG("RANGED: assault end unit=%d porc=%d (gone or out of reach)",id,assaultPorc);
        assaultPorc=-1; assaultGo=false; return;
    }
    if(bestId!=assaultPorc) { assaultPorc=bestId; assaultGo=false; assaultLogged=false; }
    assaultPos=bestPos; assaultGhostTarget=bestGhost;
    int waiting=0;
    const bool go=world.AssaultJoin(bestId,id,frame,p.assaultMinGroup,int(p.assaultMaxWait*FRAMES_PER_SEC),waiting);
    if(!assaultLogged) {
        assaultLogged=true;
        ai->LOG("RANGED: assault wait unit=%d porc=%d at=%.0f,%.0f ghost=%d waiting=%d",id,bestId,bestPos.x,bestPos.z,int(bestGhost),waiting);
    }
    if(go && !assaultGo) ai->LOG("RANGED: assault in unit=%d porc=%d waiting=%d",id,bestId,waiting);
    assaultGo=go;
}
bool CRangedEngagement::GhostStructure(const AIFloat3& pos,AIFloat3& goal) const
{
    float best=std::numeric_limits<float>::max();
    for(const auto& kv:ai->GetEnemyManager()->GetEnemyUnits()) {
        const CEnemyUnit* e=kv.second;
        if(e==nullptr || e->IsHidden() || e->IsInRadarOrLOS() || e->IsBeingBuilt()) continue;
        const CCircuitDef* d=e->GetCircuitDef();
        if(d==nullptr || d->IsMobile() || d->IsAbleToFly()) continue;
        if(e->GetData().losStatus & (SEnemyData::DEAD|SEnemyData::DYING)) continue;
        const AIFloat3& p=e->GetPos();
        if(!std::isfinite(p.x) || !std::isfinite(p.z) || p.x<0.f || p.z<0.f) continue;
        const float dist=pos.SqDistance2D(p);
        if(dist<best) { best=dist; goal=p; }
    }
    return best<std::numeric_limits<float>::max();
}
bool CRangedEngagement::March(CCircuitUnit* unit,const AIFloat3& pos,const AIFloat3* objective,float maxRange)
{
    if(noMarch) return false;
    const int frame=ai->GetLastFrame();
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    if(frame<marchRetryFrame) return marching && moving;   // halted at the front, or a failed path: wait
    AIFloat3 goal;
    if(objective) goal=*objective; else if(!MarchGoal(pos,goal)) return false;
    goal.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(goal.x,goal.z);
    const float stop=std::max(maxRange*policy.rangeFraction,float(ai->GetPathfinder()->GetSquareSize()));
    if(pos.SqDistance2D(goal)<=stop*stop) { marching=false; return false; }
    // Keep a live, still-legal march towards the same goal.
    if(marching && (moving || query) && marchGoal.SqDistance2D(goal)<256.f*256.f
        && (query || (ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,true)))) return true;
    if(policy.moveFloorSeconds>0.f && frame<lastMoveFrame+int(policy.moveFloorSeconds*FRAMES_PER_SEC)) return marching;
    marchGoal=goal; marching=true; completedMove=false;
    query.reset(); const unsigned version=++generation; lastMoveFrame=frame;
    auto* finder=ai->GetPathfinder();
    // The threat map routes round known guns; the walk is then cut where it
    // first enters live or ghost static coverage (the same Safe test as firing
    // sites) and at weapon reach of the goal (the path radius).
    query=finder->CreatePathSingleQuery(unit,ai->GetThreatMap(),pos,goal,stop);
    const std::weak_ptr<int> alive=lifetime;
    const int objectiveId=marchObjective;
    finder->RunQuery(ai->GetScheduler().get(),query,[this,alive,version,objectiveId](const IPathQuery* result) {
        if(alive.expired()) return;
        auto* unit=ai->GetTeamUnit(id);
        if(!unit || unit->GetTask()!=owner || version!=generation || result!=query.get()) return;
        query.reset();
        const int now=ai->GetLastFrame();
        const auto& p=unit->GetCircuitDef()->GetRangedPolicy();
        ExactStaticScope exact(world,p);
        PorcExemptScope exempt(world,assaultGo?assaultPorc:-1);   // owner 2026-11-23
        world.Refresh();
        const auto points=static_cast<const CQueryPathSingle*>(result)->GetPathInfo()->posPath;
        const AIFloat3 current=unit->GetPos(now);
        std::vector<AIFloat3> legal;
        AIFloat3 from=current;
        bool cut=false;
        // Headless 11-17 (live mode): the threat-map path came back as a single
        // point inside coverage, and a whole-leg test then halted the march at
        // the gantry. Walk each leg in 64-elmo samples and keep the last safe
        // one, so the march always reaches the coverage edge.
        const auto safeAt=[&](const AIFloat3& a,const AIFloat3& b) {
            return SafeMove(unit,a,b,StaticMargin(p),true)
                && world.DangerSign(b,p.safetyMargin,p.pressStatic,GhostRange(p),StaticDanger(p))<=0;
        };
        std::string why;   // trace only (2026-11-21 Daedalus idle): which check cut the leg
        for(const auto& q:points) {
            if(from.SqDistance2D(q)<16.f) continue;
            if(safeAt(from,q)) { legal.push_back(q); from=q; continue; }
            cut=true;
            const float length=std::sqrt(from.SqDistance2D(q));
            const int steps=std::max(1,int(length/64.f));
            if(trace) {
                char buf[200];
                snprintf(buf,sizeof(buf)," leg=%u len=%.0f to=%.0f,%.0f safeMove=%d danger=%d steps=%d",unsigned(legal.size()),length,q.x,q.z,
                    int(SafeMove(unit,from,q,StaticMargin(p),true)),
                    world.DangerSign(q,p.safetyMargin,p.pressStatic,GhostRange(p),StaticDanger(p)),steps);
                why=buf;
                why+=world.ExplainLeg(from,q,StaticMargin(p),p.pressStatic,GhostRange(p),StaticDanger(p));
                if(UnknownStaticBlocks(unit,from,q)) why+=" [unknown still dot within "+std::to_string(int(p.unknownStaticReach))+"]";
            }
            AIFloat3 last=from; bool any=false;
            for(int i=1;i<steps;++i) {
                AIFloat3 sample=from+(q-from)*(float(i)/steps);
                CTerrainManager::CorrectPosition(sample);
                sample.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(sample.x,sample.z);
                if(!ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),sample)) { if(trace) why+=" sample"+std::to_string(i)+"=terrain"; break; }
                if(!safeAt(last,sample)) {
                    if(trace) why+=" sample"+std::to_string(i)+"=unsafe"+world.ExplainLeg(last,sample,StaticMargin(p),p.pressStatic,GhostRange(p),StaticDanger(p));
                    break;
                }
                last=sample; any=true;
            }
            if(any) legal.push_back(last);
            break;
        }
        // Owner 2026-11-23 (porc_hazards hulls): never freeze for anything but listed porc. After 3
        // refused marches from the same spot, take the first legs anyway when no listed structure
        // (live or ghost) covers them: the refusal came from mobiles or unknown dots, not porc.
        if(p.porcHazardList && !points.empty() && legal.empty()) {
            if(current.SqDistance2D(haltPos)<200.f*200.f) ++haltStreak; else { haltStreak=1; haltPos=current; }
            size_t take=0; AIFloat3 a=current;
            for(const auto& q:points) {
                if(take>=2) break;
                if(a.SqDistance2D(q)<16.f) continue;
                if(!world.Safe(a,q,StaticMargin(p),true,p.pressStatic,GhostRange(p))) break;
                a=q; ++take;
            }
            if(haltStreak>=3 && take>0) {
                for(const auto& q:points) { if(legal.size()>=take) break; if(current.SqDistance2D(q)>=16.f || !legal.empty()) legal.push_back(q); }
                ai->LOG("RANGED: march push unit=%d at=%.0f,%.0f legs=%u after %d refusals (no listed porc on the way)",id,current.x,current.z,unsigned(legal.size()),haltStreak);
                haltStreak=0;
            }
        } else if(!legal.empty()) haltStreak=0;
        if(points.empty() || legal.empty() || current.SqDistance2D(legal.back())<128.f*128.f) {
            // Nothing safe further on: this is the front (or no path). Wait here.
            marching=false; marchRetryFrame=now+FRAMES_PER_SEC*5;
            if(points.empty()) ++failures;
            else TimingFront(unit,"halt");
            if(trace || !points.empty()) ai->LOG("RANGED: march halt unit=%d points=%u legal=%u cut=%d goal=%.0f,%.0f",
                id,unsigned(points.size()),unsigned(legal.size()),int(cut),marchGoal.x,marchGoal.z);
            if(trace) ai->LOG("RANGEDTRACE: halt unit=%d at=%.0f,%.0f%s",id,current.x,current.z,why.c_str());
            // Owner 2026-11-23 (Salt Reef): no firing site was found and the path to this
            // objective comes back as one point (no way up the plateau), again and again:
            // after 3 such halts take the next objective. Multi-point halts (the edge of
            // enemy coverage) keep their objective.
            if(objectiveId>=0 && p.shunSeconds>0.f && points.size()==1) {
                if(objectiveId==marchObjective && ++marchObjectiveHalts>=3) { marchObjectiveHalts=0; Shun(objectiveId,"march halts"); }
            }
            return;
        }
        const int cap=p.maxWaypoints;
        if(cap>=1 && legal.size()>size_t(cap)) legal.resize(cap);
        marchObjectiveHalts=0;
        path=legal; pathCursor=0; moving=true; issuing=true; destination=legal.back();
        world.SetSlot(id,destination,p.spacing,unit->GetCircuitDef()->GetCostM());
        TRY_UNIT(ai,unit,
            for(size_t i=0;i<path.size();++i) unit->CmdMoveTo(path[i],i?UNIT_COMMAND_OPTION_SHIFT_KEY:0);
        )
        issuing=false;
        if(trace) ai->LOG("RANGED: march unit=%d legs=%u cut=%d to=%.0f,%.0f goal=%.0f,%.0f",id,unsigned(path.size()),int(cut),
            destination.x,destination.z,marchGoal.x,marchGoal.z);
    });
    return true;
}
bool CRangedEngagement::Move(CCircuitUnit* unit,const AIFloat3& dest,bool escape,bool urgent)
{
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    ExactStaticScope exact(world,policy);
    const auto pos=unit->GetPos(ai->GetLastFrame());
    bool reusable=true;
    if(policy.sustainedRush && world.IsSustainedRush(id)) {
        const auto& plan=world.PlanCohort(unit);
        if(plan.sustainedRush && plan.target>=0 && (dest.x-pos.x)*(plan.focus.x-pos.x)
            +(dest.z-pos.z)*(plan.focus.z-pos.z)<-1.f) {
            ai->LOG("[INVARIANT] INV-197 sustained rush received a backward combat destination unit=%d",id);
            Hold(unit,true);
            return false;
        }
        reusable=!plan.sustainedRush || (destination.x-pos.x)*(plan.focus.x-pos.x)
            +(destination.z-pos.z)*(plan.focus.z-pos.z)>=0.f;
    }
    // Owner 2026-11-04: a hull with direct_move_radius takes steps down to 8
    // elmos; at 99% of range a 32-elmo dead zone left Barrages out of range.
    const float still=(!policy.coordinated && policy.directMoveRadius>0.f)?8.f:32.f;
    if(pos.SqDistance2D(dest)<still*still) { Hold(unit); return false; }
    const bool same=destination.SqDistance2D(dest)<policy.hysteresis*policy.hysteresis;
    if(reusable && same && query) return true;
    if(reusable && same && moving && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,escape)) return true;
    if(reusable && policy.coordinated && policy.intentGain>0.f && !urgentMove && moving
        && cohort::KeepMove(P(pos),P(destination),P(dest),policy.intentGain,policy.spacing)
        && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,escape)) return true;
    if(reusable && policy.coordinated && moving && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,escape)) {
        const AIFloat3 live=destination-pos, wanted=dest-pos;
        const float product=live.x*wanted.x+live.z*wanted.z;
        // Preserve a live move that still advances the same local intent.
        // Receding target coordinates alone should not rebuild the command
        // queue. A changed heading, shorter goal or fresh danger still wins.
        if(live.SqLength2D()>4096.f && wanted.SqLength2D()>=live.SqLength2D()
            && product>0.f && product*product>.94f*live.SqLength2D()*wanted.SqLength2D()) return true;
    }
    // Owner 2026-10-19: a live, still-legal move is replaced at most once per
    // move_min_seconds; danger, threat escapes and an idle unit go at once.
    // Kiting units were re-moved on every 8-frame decision (cortrem 2.5/s).
    // `escape` is only the path-safety test mode (most cohort and firing-site
    // moves set it), so urgency is its own flag: the caller's, or the cohort's.
    if(!urgent && !(policy.coordinated && urgentMove) && moving && policy.moveMinSeconds>0.f
        && ai->GetLastFrame()<lastMoveFrame+int(policy.moveMinSeconds*FRAMES_PER_SEC)
        && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,escape)) return true;
    // Owner 2026-10-24: move_floor_seconds is absolute. Urgent, escape and
    // idle re-moves wait too (Darkside 2026-10-23: legmed re-pathed every
    // 1.6 s with 8-19 queued waypoints, up to 33 MOVEs/s per hull). The
    // next decision tick re-asks with a fresh destination.
    if(policy.moveFloorSeconds>0.f
        && ai->GetLastFrame()<lastMoveFrame+int(policy.moveFloorSeconds*FRAMES_PER_SEC)) return true;
    if(!ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),dest) || !SafeMove(unit,pos,dest,StaticMargin(policy),escape)) return false;
    if(trace) ai->LOG("RANGED: move-replace unit=%d objective=%d mode=%d urgent=%d moving=%d pending=%d queue=%d from=%.1f,%.1f old=%.1f,%.1f new=%.1f,%.1f",
        id,moveObjective,moveMode,int(urgentMove),int(moving),int(query!=nullptr),
        ai->GetUnitAPI()->GetCMDQueueSize(id),pos.x,pos.z,destination.x,destination.z,dest.x,dest.z);
    completedMove=false; marching=false;
    destination=dest; query.reset(); const unsigned version=++generation; lastMoveFrame=ai->GetLastFrame();
    world.SetSlot(id,dest,policy.spacing,unit->GetCircuitDef()->GetCostM());
    auto* finder=ai->GetPathfinder();
    if(!policy.coordinated && policy.directMoveRadius>0.f && pos.SqDistance2D(dest)<=policy.directMoveRadius*policy.directMoveRadius) {
        // Owner 2026-11-04: a short step onto a firing site. The straight leg
        // already passed SafeMove (exact static coverage) above; check it is
        // walkable every 16 elmos and send one MOVE. Grid paths put nodes up
        // to 45 elmos off this line, inside porc reach when the site is a few
        // elmos outside it, and LegalPath then refused every such step
        // (Moonshine Run 2026-11-04: Barrages 15-115 out of Sentry range).
        const float length=std::sqrt(pos.SqDistance2D(dest));
        const int steps=std::max(1,int(length/16.f));
        bool walkable=true;
        for(int i=1;i<=steps && walkable;++i) {
            const float t=float(i)/steps;
            walkable=ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),pos+(dest-pos)*t);
        }
        if(walkable) {
            path.assign(1,dest); pathCursor=0; moving=true; issuing=true;
            TRY_UNIT(ai,unit,unit->CmdMoveTo(dest);)
            issuing=false; return true;
        }
    }
    if(policy.coordinated && pos.SqDistance2D(dest)<=1024.f*1024.f) {
        // Kiting cannot wait for a worker path and then replay its start
        // waypoint. Prove a short local segment on the movement/threat grid;
        // A bounded local formation approach can use one engine MOVE instead
        // of emitting every worker waypoint. Difficult terrain falls through
        // to the validated asynchronous path; this never skips the line test.
        auto line=std::static_pointer_cast<CQueryLineMap>(finder->CreateLineMapQuery(unit,ai->GetThreatMap(),pos));
        if(line->IsSafeLine(pos,dest)) {
            path.assign(1,dest); pathCursor=0; moving=true; issuing=true;
            TRY_UNIT(ai,unit,unit->CmdMoveTo(dest);)
            issuing=false; return true;
        }
    }
    // Single-query radii are truncated to path-grid cells. A sub-cell radius
    // becomes zero and MicroPather fails immediately; use one cell, then
    // append and validate the exact formation slot as the final short leg.
    query=finder->CreatePathSingleQuery(unit,ai->GetThreatMap(),pos,dest,float(finder->GetSquareSize()));
    const std::weak_ptr<int> alive=lifetime;
    finder->RunQuery(ai->GetScheduler().get(),query,[this,alive,version,escape,dest](const IPathQuery* result) {
        if(alive.expired()) return;
        auto* unit=ai->GetTeamUnit(id);
        if(!unit || unit->GetTask()!=owner || version!=generation || result!=query.get()) {
            if(trace) ai->LOG("RANGED: obsolete path unit=%d owner=%d generation=%d query=%d",id,
                unit && unit->GetTask()==owner,int(version==generation),int(result==query.get()));
            return;
        }
        auto points=static_cast<const CQueryPathSingle*>(result)->GetPathInfo()->posPath;
        world.Refresh();
        if(world.IsSustainedRush(id)) {
            const auto& plan=world.PlanCohort(unit);
            const auto current=unit->GetPos(ai->GetLastFrame());
            // A moving front can invalidate a forward goal while its worker
            // path is pending. Drop that result on the callback thread.
            if(plan.sustainedRush && (dest.x-current.x)*(plan.focus.x-current.x)
                +(dest.z-current.z)*(plan.focus.z-current.z)<0.f) {
                Hold(unit,true); return;
            }
        }
        const bool solved=!points.empty();
        if(trace) ai->LOG("RANGED: path completed unit=%d generation=%u points=%u",id,version,unsigned(points.size()));
        if(solved) ranged::AppendExactGoal(points,dest);
        if(unit->GetCircuitDef()->GetRangedPolicy().coordinated) ranged::CompactStraightRoute(points);
        else if (points.size() > 2) {
            // Geometry is independent of composition policy: precision guns
            // also receive long grid routes. Preserve joins/bends/reversals,
            // validate original straight legs on the current movement/threat
            // grid, then retain the existing whole-route combat safety test.
            // O(points + sampled leg length); no new decision cadence or APM
            // limit. Failed legs fence only their neighboring straight run.
            auto line = std::static_pointer_cast<CQueryLineMap>(ai->GetPathfinder()->CreateLineMapQuery(
                unit, ai->GetThreatMap(), unit->GetPos(ai->GetLastFrame())));
            ranged::CompactValidatedStraightRoute(points, [&](const AIFloat3& from, const AIFloat3& to) {
                return line->IsSafeLine(from,to);
            });
        }
        if(points.size()>1 && points.back().SqDistance2D(points[points.size()-2])<17.f*17.f)
            ai->LOG("[INVARIANT] INV-167 ranged exact endpoint would cancel its queued predecessor unit=%d",id);
        if(!solved || !LegalPath(unit,points,escape)) {
            if(trace) ai->LOG("RANGED: path rejected unit=%d points=%u",id,unsigned(points.size()));
            query.reset(); orientUntil=0; ++failures; ++rejections; return;
        }
        // Validate the actual worker path, then every continued route against
        // fresh coverage. No engine callbacks run on path worker threads.
        // Owner 2026-10-24: max_waypoints sends only the validated route's
        // first legs. A unit that runs out of them re-paths on a later tick
        // (no unvalidated shortcut leg is ever queued).
        const int cap=unit->GetCircuitDef()->GetRangedPolicy().maxWaypoints;
        if(cap>=1 && points.size()>size_t(cap)) points.resize(cap);
        path=points; pathCursor=0; query.reset(); moving=true; issuing=true;
        TRY_UNIT(ai,unit,
            for(size_t i=0;i<path.size();++i) unit->CmdMoveTo(path[i],i?UNIT_COMMAND_OPTION_SHIFT_KEY:0);
        )
        issuing=false;
    });
    return true;
}

// Owner 2026-11-07: a hit from a shooter this AI cannot see (no attacker in
// the enemy manager). Estimate its origin as UnitDamaged does for the threat
// map (dir towards the shooter x that weapon's range) and leave a blind
// hazard there; the next decision kites out of it. Opt-in, coordinated only.
void CRangedEngagement::BlindHit(CCircuitUnit* unit)
{
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    if(!policy.coordinated || !(policy.blindHitSeconds>0.f) || world.IsSustainedRush(id)) return;
    // Friendly fire (our own or an ally's splash) is never a blind hit.
    if(ai->GetDamageAttackerId()>=0 && ai->GetFriendlyUnit(ai->GetDamageAttackerId())!=nullptr) return;
    const int weaponId=ai->GetDamageWeaponId();
    const AIFloat3 dir=ai->GetDamageDir();
    auto* wd=ai->GetWeaponDefSafe(weaponId);
    if(wd==nullptr || dir.SqLength2D()<1e-4f) return;
    float range=wd->GetRange();
    if(!(range>0.f) || range>ranged_policy_defaults::GHOST_PORC_MAX_RANGE) return;
    const int frame=ai->GetLastFrame();
    AIFloat3 flat(dir.x,0.f,dir.z); flat.Normalize2D();
    const AIFloat3 pos=unit->GetPos(frame);
    AIFloat3 origin=pos+flat*range; CTerrainManager::CorrectPosition(origin);
    world.AddBlindHit(origin,range+unit->GetCircuitDef()->GetRadius(),frame+int(policy.blindHitSeconds*FRAMES_PER_SEC));
    if(frame>=blindLogFrame+90) {
        blindLogFrame=frame;
        ai->LOG("RANGED: blind hit unit=%d weapon=%d range=%.0f origin=%.0f,%.0f",id,weaponId,range,origin.x,origin.z);
    }
    nextFrame=0;
}
void CRangedEngagement::UpdateCohort(CCircuitUnit* unit)
{
    const int frame=ai->GetLastFrame();
    const auto pos=unit->GetPos(frame);
    auto* def=unit->GetCircuitDef(); const auto& policy=def->GetRangedPolicy();
    ExactStaticScope exact(world,policy);
    // Preserve the per-dark-period budget even through a long retreat or live-target fight.
    if (policy.ghostVolleys > 0) ai->GetMilitaryManager()->GetArtySnipeState(id,frame).lastCall = frame;
    const auto& group=world.PlanCohort(unit);
    const auto member=std::find(group.members.begin(),group.members.end(),id);
    if(member==group.members.end() || group.members.size()>size_t(policy.cohortSize)) {
        ai->LOG("[INVARIANT] INV-166 coordinated unit has invalid cohort membership unit=%d",id); return;
    }
    // Owner 2026-11-07 (Sector 318C replay): 7 Thugs + 5 Aggravators idled ~35 s
    // at a no-target HOLD 490-610 from a radar-only HLT until all 12 died; the
    // HOLD branches returned before any danger test. Opted-in cohorts standing
    // in static coverage (live, ghost or blind) skip them and kite out below.
    float blindDepth=0.f;
    const bool staticExposed=policy.cohortGhostPorc && group.target<0 && group.mode==cohort::Mode::HOLD
        && (!world.Safe(pos,pos,policy.safetyMargin,false,0.f,GhostRange(policy))
            || (policy.blindHitSeconds>0.f && world.BlindDanger(pos,policy.safetyMargin,blindDepth)!=nullptr));
    if(group.target<0 && group.mode==cohort::Mode::HOLD && !policy.fireInRange && !policy.commanderFocus && !staticExposed) {
        if(policy.fireAtWill && !policy.alwaysFireAtWill && policy.pokeIn>0.f && unit->GetRequestedFireState()!=CCircuitDef::HOLD)
            unit->TrySetFireState(CCircuitDef::HOLD);
        // Cancel the old approach when a protected contact leaves vision.
        // Otherwise Disperse deliberately preserves that in-flight move.
        if(policy.engagementSeconds>0.f && group.protectedTarget>=0) {
            Hold(unit,true); SelectTarget(unit,-1,-1,0.f);
            world.SetSlot(id,pos,policy.spacing,def->GetCostM());
            return;
        }
        // Preserve the completed firing line. Fresh observed objectives are
        // still considered by PlanCohort on every decision; this is not a timer
        // or an aggression cap. Existing movement can finish and hulls disperse.
        SelectTarget(unit,-1,-1,0.f);
        Disperse(unit);
        return;
    }
    const int rank=int(member-group.members.begin());
    float maxRange=0.f; for(const auto& w:caps.weapons) maxRange=std::max(maxRange,w.range);
    world.Nearby(pos,maxRange+600.f,nearby);
    const auto& contacts=world.Contacts();
    const bool assessed=policy.engagementSeconds>0.f;
    float rawVelocity[3]={};
    if(assessed) ai->GetUnitAPI()->GetVelocity(id,rawVelocity);
    const AIFloat3 velocity(rawVelocity[0]*FRAMES_PER_SEC,0.f,rawVelocity[2]*FRAMES_PER_SEC);
    int best=-1,weapon=-1; float score=-1.f,damage=0.f;
    bool bestCommander=false;
    const CRangedWorld::Contact* danger=nullptr; float penetration=0.f;
    const CRangedWorld::Contact* incoming=nullptr;
    const CRangedWorld::Contact* objective=nullptr;
    // Owner 2026-10-17: poke cadence. Any assessed, targeted front cohort pokes
    // the closest similar-range mobile, whatever the local metal balance; the
    // band is deeper when our side clearly outweighs the opposition. Sustained
    // rushes, rush fallback, regrouping and the rear line keep their movement.
    // Owner 2026-10-19: the local metal ratio picks the regime. PRESS holds
    // the deep band to win; EVEN trades once per reload; OUTMATCHED trades
    // only intermittently. EVEN and OUTMATCHED hulls pop out at poke_health.
    const bool poking=assessed && policy.pokeIn>0.f && group.target>=0
        && !group.sustainedRush && !group.rushFallback && !group.formationRear
        && group.mode!=cohort::Mode::REGROUP;
    // Owner 2026-11-02: restored. Every assessed cohort with a target pokes,
    // whatever AssessCohort's reason (D-355 had limited it to FAVORABLE and
    // OUTMATCHED, so TRAVEL/UNKNOWN/UNREACHABLE/STATIC cohorts stopped poking).
    // The local metal regime below, not the reason, decides how hard.
    const cohort::Poke regime=poking?cohort::PokeRegime(group.ownValue,group.hostileValue,policy.pokeRatio):cohort::Poke::EVEN;
    const bool dominant=poking && regime==cohort::Poke::PRESS;
    const float pokeIn=dominant?policy.pokeInDominant:policy.pokeIn;
    const auto pokeable=[&](const CRangedWorld::Contact& c) {
        return poking && c.def && c.mobile && c.armed && !c.def->IsEnemyRoleAny(CCircuitDef::COMM)
            && !c.def->IsAbleToReclaim()
            && cohort::Pokeable(c.groundRange,c.hazardRadius+policy.safetyMargin,maxRange,pokeIn,policy.pokeOut);
    };
    const CRangedWorld::Contact* closest=nullptr; float closestDistance=std::numeric_limits<float>::max();
    for(int i:nearby) {
        const auto& c=contacts[i];
        if(c.id==group.target) objective=&c;
        if(!c.def || c.def->IsAbleToFly() || c.pos.y< -20.f) continue;
        const bool poked=pokeable(c);
        if(poked && pos.SqDistance2D(c.pos)<closestDistance) { closestDistance=pos.SqDistance2D(c.pos); closest=&c; }
        // The local escape decision remains individual: a centroid must not
        // hide a flank being overrun. Mobile exposure is allowed only during
        // an approved rush; sustained commitment deliberately spends against
        // both mobile and static exposure after local force admission.
        const float distance=std::sqrt(pos.SqDistance2D(c.pos));
        const float enemyClosing=ranged::ClosingSpeed(P(pos),P(c.pos),P(c.velocity));
        const float relativeClosing=assessed?cohort::RelativeClosing(P(pos),P(velocity),P(c.pos),P(c.velocity)):enemyClosing;
        // Brake before our own advance consumes the range advantage. An
        // unfavorable fight retains the conservative escape prediction once
        // withdrawing; a committed favorable kite uses actual separation.
        const bool narrowKite=assessed && c.mobile && c.groundRange<maxRange
            && !cohort::ShortKite(maxRange,c.groundRange,def->GetSpeed(),policy.reactionSeconds);
        const float closing=narrowKite?enemyClosing:
            assessed && group.committed?relativeClosing:std::max(enemyClosing,relativeClosing);
        if(c.armed && c.mobile && c.groundRange<maxRange && closing>1.f
            && distance<maxRange+64.f+(narrowKite?0.f:std::max(0.f,closing-enemyClosing)*policy.reactionSeconds)) incoming=&c;
        // Rear elements anticipate closing threats earlier, without forcing
        // their screen to wait. SET_TARGET remains active during this movement,
        // so a ready rocket can fire and its reload is useful escape time.
        const float anticipation=policy.reactionSeconds
            +(group.formationRear ? policy.withdrawalLeadSeconds : 0.f);
        float reach=c.hazardRadius+policy.safetyMargin+closing*anticipation;
        // Predict relative to the screen's band. Without its depth, the rear's
        // extra second merely consumes part of its range advantage and can
        // still start withdrawing AFTER the screen. Stationary threats do not
        // gain this buffer: that would prevent a safe rocket siege.
        if(group.formationRear && c.mobile && enemyClosing>0.f)
            reach+=group.formationScreenOffset;
        const float reclaim=assessed && c.def->IsAbleToReclaim()?c.def->GetBuildDistance()+c.radius+policy.safetyMargin:0.f;
        reach=std::max(reach,reclaim);
        const bool approvedStatic=assessed && group.committed
            && std::find(group.assault.begin(),group.assault.end(),c.id)!=group.assault.end();
        // Owner 2026-11-03: a commander is shot, not fled, by commander_no_retreat
        // hulls; its death blast (explosionRadius) still counts below.
        const bool approvedCommander=policy.commanderNoRetreat && c.mobile
            && c.def->IsEnemyRoleAny(CCircuitDef::COMM)
            && distance>c.explosionRadius+policy.safetyMargin;
        const bool approvedMobile=c.mobile && !c.def->IsEnemyRoleAny(CCircuitDef::COMM)
            && group.mode==cohort::Mode::RUSH && (!assessed || c.groundRange>=maxRange
                || (policy.supportAllies && group.supporting
                    && distance>c.groundRange+policy.safetyMargin));
        // A poker accepts the reach of a similar-range mobile; its cadence,
        // not the escape, takes it back out while the weapon reloads.
        if((c.hazardRadius>0.f || reclaim>0.f) && distance<reach && reach-distance>penetration
            && (distance<reclaim || !(approvedStatic || approvedMobile || approvedCommander || poked))) {
            danger=&c; penetration=reach-distance;
        }
        // Target permissions never suppress the hazard above. Coordinated
        // movement is opt-in, but still honors existing JSON target controls.
        if(c.mobile?!policy.allowMobile:!policy.allowStatic) continue;
        if(policy.avoidCategory & c.def->GetCategory()) continue; // D-294
        const bool focusCommander=policy.commanderFocus && world.PeerSeesCommander(c,def,pos,policy.cohortRadius);
        for(size_t wi=0;wi<caps.weapons.size();++wi) {
            const auto& w=caps.weapons[wi];
            if(!(w.category&c.def->GetCategory()) || (!c.los && !policy.allowRadar)) continue;
            const float range=world.Range(w,pos,c.pos);
            // A commander kill is explicitly preferred even inside its death
            // blast. Otherwise nearby Thugs veto every focused shot against
            // this short-range target. Our own splash/line safety still applies.
            const float splash=focusCommander?w.splash:std::max(w.splash,c.explosionRadius);
            if(distance>range || !world.Trajectory(w,pos,c.pos)
                || world.FriendlySplash(id,c.pos,splash)
                || world.FriendlyLine(w,id,pos,c.pos)) continue;
            const float hit=c.armor>=0 && size_t(c.armor)<w.damage.size()?w.damage[c.armor]*w.alphaScale:0.f;
            if(hit<=0.f) continue;
            // Value per remaining HP favors killable repair support in range.
            // It never licenses movement past the firing line to chase it.
            float s=(1.f+c.cost)/std::max(hit,c.health)*world.Progress(c.id,policy.repairedTargetPenalty);
            if(c.def->IsBuilder()) s*=2.f;
            if(c.id==target) s*=policy.targetHysteresis;
            if(world.Reserved(c.id,id)>=c.health) s*=.2f;
            if(c.def->IsEnemyRoleAny(CCircuitDef::COMM)) s*=policy.commanderPriority;
            if(def->IsPriorityTarget(c.def)) s+=PRIORITY_TIER_OFFSET;  // owner 2026-11-07, see Update
            if(policy.structuresOverSlow>0.f && !SlowMobile(c,policy.structuresOverSlow)) s+=STRUCTURE_TIER_OFFSET;  // owner 2026-11-15
            if(c.id==target && (heldScoreFrame!=frame || s>heldScore)) { heldScore=s; heldScoreFrame=frame; }
            // Commander focus is a tier, not a multiplier defeated by low HP
            // repairers or existing shot reservations. Geometry still vetoes.
            if((focusCommander && !bestCommander) || (focusCommander==bestCommander && s>score)) {
                score=s; best=i; weapon=int(wi); damage=hit;bestCommander=focusCommander;
            }
        }
    }
    // Owner 2026-11-07 (Sector 318C): ghost porc and blind hazards are static
    // danger for opted-in cohorts, unless the committed cohort already
    // approved that ghost as its assault target. Same reach as live porc.
    if(policy.cohortGhostPorc && GhostRange(policy)>0.f) {
        world.NearbyGhosts(pos,policy.safetyMargin,GhostRange(policy),0.f,ghostNearby);
        const auto& ghosts=world.Ghosts();
        for(int gi:ghostNearby) {
            const auto& c=ghosts[gi];
            if(assessed && group.committed && std::find(group.assault.begin(),group.assault.end(),c.id)!=group.assault.end()) continue;
            const float depth=c.hazardRadius+policy.safetyMargin-std::sqrt(pos.SqDistance2D(c.pos));
            if(depth>penetration) { danger=&c; penetration=depth; }
        }
    }
    if(policy.blindHitSeconds>0.f) {
        float depth=0.f;
        const auto* blind=world.BlindDanger(pos,policy.safetyMargin,depth);
        if(blind && depth>penetration) { danger=blind; penetration=depth; }
    }
    if(policy.fireInRange) {
        // Open only once the existing shot geometry admits an in-range target.
        // Engine auto-acquisition includes target radius and can fire earlier,
        // disturbing the established poke/withdrawal band. Threatened hulls
        // still open immediately on this decision; danger does not veto fire.
        const int fire=best>=0?CCircuitDef::FireType::OPEN:CCircuitDef::FireType::HOLD;
        if(unit->GetRequestedFireState()!=fire) unit->TrySetFireState(fire);
    }
    if(group.target<0 && group.mode==cohort::Mode::HOLD && !(staticExposed && danger && !danger->mobile)) {
        // Keep the old idle dispersion/movement; only permit defensive fire
        // and priority selection that the former early return skipped.
        if(policy.engagementSeconds>0.f && group.protectedTarget>=0) {
            Hold(unit,true);
            world.SetSlot(id,pos,policy.spacing,def->GetCostM());
        } else Disperse(unit);
        SelectTarget(unit,best>=0?contacts[best].id:-1,weapon,damage,score);
        return;
    }
    auto point=group.focus;
    if(group.target>=0) {
        const auto arc=cohort::Arc(P(group.focus),P(group.back),group.radius,rank,int(group.members.size()),policy.spacing);
        point.x=arc.x; point.z=arc.z;
        if(group.formationRear) {
            point.x-=group.back.z*policy.spacing*.5f;
            point.z+=group.back.x*policy.spacing*.5f;
        }
    } else {
        // Keep separate lanes during travel as well as at the firing band.
        // Keep a rounding margin between adjacent straight-line reservations,
        // just as Arc does for chord distance. Exact float spacing can round
        // below FreeSlot's strict boundary and churn between lateral slots.
        const float offset=(rank-(group.members.size()-1)*.5f)*(policy.spacing+1.f);
        point+=AIFloat3(-group.back.z,0,group.back.x)*offset;
    }
    // In to the band while the weapon is ready, out to poke_out while it
    // reloads: roughly one step in per reload cycle, straight along the line
    // to the closest pokeable enemy so each step is as short as possible.
    // The regime (above) decides whether reload, health or a pause apply.
    const bool poke=closest!=nullptr;
    // One owner, no polling watchdog or periodic resends. Phase (reload) changes
    // do not toggle fire state; only entering/leaving a peer engagement does.
    if(!policy.fireInRange && policy.fireAtWill && !policy.alwaysFireAtWill && policy.pokeIn>0.f) {
        const int fire=poke && !danger?CCircuitDef::FireType::OPEN:CCircuitDef::FireType::HOLD;
        if(unit->GetRequestedFireState()!=fire) unit->TrySetFireState(fire);
    }
    int phase=-1;
    if(poke) {
        const bool reloading=pokeReload>frame;
        const float health=unit->GetUnit()->GetHealth()/std::max(1.f,def->GetHealth());
        const bool paused=regime==cohort::Poke::OUTMATCHED
            && frame<pokeShotFrame+int(policy.pokePauseSeconds*FRAMES_PER_SEC);
        const float fraction=cohort::PokeFraction(regime,reloading,health,paused,
            policy.pokeIn,policy.pokeInDominant,policy.pokeOut,policy.pokeHealth,policy.pokePressHealth);
        phase=fraction<1.f?1:0;
        AIFloat3 away=pos-closest->pos; away.Normalize2D();
        if(away.SqLength2D()<POKE_DIRECTION_MIN_LENGTH_SQ) away=group.back;
        // Owner 2026-11-15: reach measured from the poke point's ground, not ours.
        const float reach=world.StandoffRange(caps.weapons.front(),closest->pos,away,fraction);
        point=closest->pos+away*reach;
    }
    if(group.sustainedRush) { danger=nullptr; incoming=nullptr; withdrawalUntil=0; }
    // Owner 2026-11-03: the danger kite had no leash, so a pursuing enemy walked
    // Thugs straight past their own base. At home (inside home_hold_radius of the
    // base) or already behind it (on the far side from the threat), hold and
    // fight instead. A reclaimer in reach still counts: it would take the hull.
    if(danger && policy.homeHoldRadius>0.f
        && !(danger->def && danger->def->IsAbleToReclaim() && std::sqrt(pos.SqDistance2D(danger->pos))<danger->def->GetBuildDistance()+danger->radius+policy.safetyMargin)) {
        const AIFloat3& base=ai->GetSetupManager()->GetBasePos();
        AIFloat3 threat=danger->pos-base; threat.y=0.f;
        const bool home=pos.SqDistance2D(base)<policy.homeHoldRadius*policy.homeHoldRadius;
        const bool behind=(pos.x-base.x)*threat.x+(pos.z-base.z)*threat.z<0.f;
        if(home || behind) {
            if(trace && frame>=homeHoldLogFrame+150) {
                homeHoldLogFrame=frame;
                ai->LOG("RANGED: home hold unit=%d danger=%d home=%d behind=%d",id,danger->id,int(home),int(behind));
            }
            danger=nullptr; withdrawalUntil=0;
        }
    }
    if(danger) {
        AIFloat3 away=pos-danger->pos; away.Normalize2D();
        if(away.SqLength2D()<POKE_DIRECTION_MIN_LENGTH_SQ) away=group.back;
        const bool disengage=!group.committed || group.mode==cohort::Mode::WITHDRAW || !danger->mobile
            || (danger->def && (danger->def->IsEnemyRoleAny(CCircuitDef::COMM) || danger->def->IsAbleToReclaim()))
            || (!(policy.supportAllies && group.supporting)
                && !cohort::ShortKite(maxRange,danger->groundRange,def->GetSpeed(),policy.reactionSeconds));
        // The engine accepts arrival short of the exact endpoint. A 32-elmo
        // escape can therefore complete before the hull actually gets clear.
        // Leave one movement cell of usable travel beyond that tolerance.
        point=pos+away*(assessed?std::max(96.f,cohort::KiteStep(penetration,policy.hysteresis,disengage))
            :std::max(192.f,penetration+policy.hysteresis));
        withdrawalUntil=assessed && !disengage?frame+15:frame+30;
    } else if(frame<withdrawalUntil && moving) {
        SelectTarget(unit,best>=0?contacts[best].id:-1,weapon,damage,score);
        return;
    } else if(incoming && !poke && !(policy.supportAllies && group.supporting && group.committed)
        && point.SqDistance2D(incoming->pos)<pos.SqDistance2D(incoming->pos)) {
        // Hold the line when a shorter-ranged enemy is already approaching.
        // Advancing into it doubles closure and spends the entire range
        // advantage turning around. Let it enter our fire before pulling back.
        point=pos;
    } else if(best>=0 && !poke && !group.sustainedRush && !group.rushFallback && !group.formationRear && (assessed || group.mode!=cohort::Mode::REGROUP)
        && world.FreeSlot(id,pos,policy.spacing)
        && !(policy.supportAllies && group.supporting && group.committed
            && (pos.x-group.focus.x)*group.back.x+(pos.z-group.focus.z)*group.back.z>group.screenDepth+policy.spacing)) {
        // A safe, spaced shooter already contributes to the firing line.
        // Do not chase the ideal arc coordinate while it has a legal shot:
        // that spends movement orders and firing time without adding damage.
        // Danger/regrouping above override immediately; blocked rear members
        // still advance to their shared slots until they too can contribute.
        point=pos;
    }
    // A stepping-in poker takes the same last step onto its closest enemy;
    // a reloading poker never steps forward.
    const CRangedWorld::Contact* step=poke?(phase==1?closest:nullptr):objective;
    if(!danger && best<0 && step && pos.SqDistance2D(point)<4096.f
        && (phase==1 || group.mode==cohort::Mode::ADVANCE || group.mode==cohort::Mode::RUSH)) {
        const float distance=std::sqrt(pos.SqDistance2D(step->pos));
        const float reach=world.Range(caps.weapons.front(),pos,step->pos);
        if(distance>reach && distance-reach<64.f) {
            // Engine arrival can stop 32 elmos before a firing slot. A unit
            // just outside range must take the remaining step, not consider
            // itself settled forever. The next legal shot holds it immediately;
            // mobile danger and static/terrain validation still take precedence.
            point=pos+(step->pos-pos)*((distance-reach+32.f)/distance);
        }
    }
    CTerrainManager::CorrectPosition(point);
    // Advancing enemies can move the ideal firing arc behind a committed
    // shooter. Hold and fire in that case instead of backing out to the arc.
    // This is a combat-goal constraint, not a change to terrain pathfinding.
    if(group.sustainedRush && (point.x-pos.x)*(group.focus.x-pos.x)
        +(point.z-pos.z)*(group.focus.z-pos.z)<0.f) point=pos;
    point.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(point.x,point.z);
    bool safe=SafeMove(unit,pos,point,policy.safetyMargin,true);
    if(!safe && !danger) {
        // Bounded staging search along the same approach: stop before static
        // coverage instead of remaining at the distant spawn or diving at bait.
        const AIFloat3 delta=point-pos;
        for(int k=3;k>=1;--k) {
            AIFloat3 stage=pos+delta*(k*.25f);
            if(pos.SqDistance2D(stage)>4096.f && SafeMove(unit,pos,stage,policy.safetyMargin,false)) {
                point=stage; safe=true; break;
            }
        }
    }
    // Move considers a point within 32 elmos reached. Use the same tolerance
    // here: otherwise its successful HOLD looks like a failed placement and
    // the next lateral candidate immediately orders another MOVE.
    const float arrival=std::max(group.target<0?64.f:32.f,policy.hysteresis);
    // A formation deliberately staged outside an immobile battery has no
    // legal shot. Requiring one here makes adjacent cohorts repeatedly trade
    // lateral slots. Retain only a reached, still-safe nearby reservation for
    // the SAME objective/mode; danger and fresh movement admission win above.
    const bool formationStaging=policy.formationPosition!=RangedPolicy::FormationPosition::NONE
        && group.mode==cohort::Mode::WITHDRAW && objective && !objective->mobile
        && moveObjective==group.target && moveMode==int(group.mode);
    // Recoil may finish a MOVE before its exact endpoint. The route walker
    // already accepts its final waypoint within 64 elmos; repeatedly sending
    // that completed command buys no progress. Adopt the reached position only
    // for safe static staging, using the existing route/slot tolerances. This
    // is not an arrival relaxation for attacks, retreats or failed commands:
    // fresh danger, objective/mode changes and spacing all invalidate reuse.
    const bool completedStage=formationStaging && completedMove && !danger && best<0
        && cohort::CompletedStage(P(pos),P(destination),P(point),policy.spacing)
        && world.FreeSlot(id,pos,policy.spacing)
        && SafeMove(unit,pos,pos,policy.safetyMargin,false);
    if(completedStage) point=pos;
    if(!completedStage && !danger && !poke && group.mode!=cohort::Mode::REGROUP
        && destination.SqDistance2D(point)<4.f*policy.spacing*policy.spacing
        && pos.SqDistance2D(destination)<arrival*arrival
        && ((!group.sustainedRush && !group.rushFallback && best>=0) || group.target<0 || (formationStaging
            && SafeMove(unit,pos,destination,policy.safetyMargin,false)))
        && world.FreeSlot(id,destination,policy.spacing)) point=destination;
    urgentMove=danger || moveObjective!=group.target || moveMode!=int(group.mode) || phase!=pokePhase;
    pokePhase=phase;
    moveObjective=group.target; moveMode=int(group.mode);
    const bool settled=pos.SqDistance2D(point)<arrival*arrival;
    if(safe && !settled) {
        // Formation slots may overlap another cohort's arc. Try a few lateral
        // alternatives; bound work and retain static-path checks in Move.
        bool placed=false;
        for(int k=0;k<5;++k) {
            const int side=k==0?0:(k%2?(k+1)/2:-k/2);
            AIFloat3 candidate=point+AIFloat3(-group.back.z,0,group.back.x)*(side*(policy.spacing+1.f));
            CTerrainManager::CorrectPosition(candidate);
            if(group.sustainedRush && (candidate.x-pos.x)*(group.focus.x-pos.x)
                +(candidate.z-pos.z)*(group.focus.z-pos.z)<0.f) continue;
            candidate.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(candidate.x,candidate.z);
            if(world.FreeSlot(id,candidate,policy.spacing) && Move(unit,candidate,true,danger!=nullptr)) { placed=true; break; }
        }
        // Spacing is subordinate to survival. A reserved retreat slot must not
        // leave the previous forward MOVE running into a closing assault.
        // Keep terrain/static validation, but allow a temporary crowded escape.
        if(!placed && danger) {
            placed=Move(unit,point,true,true);
            if(!placed) Hold(unit,true);
        }
        // Commitment disables retreat, not physical firing lanes. Forcing an
        // occupied rush goal crowds friendly splash weapons into each other.
        // Keep firing and retry the bounded forward slots next decision.
        if(!placed && group.sustainedRush) Hold(unit,true);
        if(!placed && !moving) world.SetSlot(id,pos,policy.spacing,def->GetCostM());
    } else if(settled || !safe) {
        Hold(unit,true); world.SetSlot(id,settled?point:pos,policy.spacing,def->GetCostM());
    }
    // MOVE plus BAR SET_TARGET permits firing while kiting without an ATTACK
    // order overriding the shared line. STOP above clears BAR priority target,
    // so repair it in the same decision after applying movement.
    SelectTarget(unit,best>=0?contacts[best].id:-1,weapon,damage,score);
    if(trace && frame>=traceFrame+150) {
        traceFrame=frame;
        ai->LOG("COHORT: unit=%d members=%u mode=%d target=%d radius=%.0f dest=%.0f,%.0f danger=%d reason=%d loss=%.3f advantage=%.3f committed=%d supporting=%d screen=%.0f poke=%d regime=%d own=%.0f hostile=%.0f closest=%d",
            id,unsigned(group.members.size()),int(group.mode),group.target,group.radius,point.x,point.z,danger?danger->id:-1,
            int(group.reason),group.loss,group.advantage,int(group.committed),int(group.supporting),group.screenDepth,
            phase,int(regime),group.ownValue,group.hostileValue,closest?closest->id:-1);
    }
}

void CRangedEngagement::Update(CCircuitUnit* unit)
{
    const int frame=ai->GetLastFrame();
    if(released || issuing || frame<nextFrame || unit->Blocker()) return;
    performance::Scope measured(ai,performance::RANGED_DECISION);
    nextFrame=frame+8; // decision sampling, not an order/APM limit; damage/idle invalidates
    world.Refresh();
    auto* def=unit->GetCircuitDef(); const auto& policy=def->GetRangedPolicy();
    ExactStaticScope exact(world,policy);
    // Preserve the per-dark-period budget even through a long retreat or live-target fight.
    if (policy.ghostVolleys > 0) ai->GetMilitaryManager()->GetArtySnipeState(id,frame).lastCall = frame;
    const auto pos=unit->GetPos(frame);
    if(caps.weapons.empty()) return;
    if(policy.porcHazardList && !policy.heavyPorcDefs.empty()) UpdateAssault(unit,pos,frame);
    PorcExemptScope exempt(world,assaultGo?assaultPorc:-1);
    // Discard already traversed waypoints. Validating a route back to its old
    // start incorrectly rejects a successful escape as renewed exposure.
    while(pathCursor<path.size() && (pos.SqDistance2D(path[pathCursor])<4096.f
        || (pathCursor+1<path.size() && pos.SqDistance2D(path[pathCursor+1])<pos.SqDistance2D(path[pathCursor])))) ++pathCursor;
    if(moving && !LegalPath(unit,path,true)) { Hold(unit,true); assistCheckFrame=-1; }
    if(moving && ai->GetUnitAPI()->GetCMDQueueSize(id)==0) {
        completedMove=!path.empty() && pathCursor==path.size()
            && pos.SqDistance2D(destination)<4096.f;
        moving=false; path.clear(); pathCursor=0;
    }
    if(assistCheckFrame>=0) {
        // INV-206: an accepted assist Move leaves the unit moving or with a
        // pending worker query by its next decision. A rejected worker path or
        // MoveFailed counts a failure; a fresh danger hold clears the check.
        // The engine may also finish or drop a MOVE within one decision (an
        // engine refusal this controller cannot tell from a lost command), so
        // only three consecutive accepted moves that each left the unit idle
        // are reported (8v8 20261014T015406Z: 30 single-decision hits).
        if(!moving && !query && rejections==assistCheckRejections
            && pos.SqDistance2D(destination)>128.f*128.f) {
            if(++assistIdleStreak>=3 && !assistInvariantLogged) {
                ai->LOG("[INVARIANT] INV-206 ranged assist moves accepted but unit %d stays neither moving nor querying",id);
                assistInvariantLogged=true;
            }
        } else assistIdleStreak=0;
        assistCheckFrame=-1;
    }

    if(pokeWeapon) {
        const int reload=pokeWeapon->GetReloadFrame();
        if(reload>pokeReload && reload>frame) pokeShotFrame=frame;
        pokeReload=reload;
    }
    if(liveWeapon) {
        const int reload=pokeWeapon && weaponIndex==0?pokeReload:liveWeapon->GetReloadFrame();
        if(reload>lastReload && lastReload>=0) {
            lastShotFrame=frame; failures=0; refusedCount=0;
            orientUntil=0; // Actual fire completes facing recovery immediately.
            burstUntil=frame+int(caps.weapons[weaponIndex].burst*30.f)+3;
            world.ReserveShot(id,target,reservedDamage,std::min(reload,frame+90));
        }
        lastReload=reload;
    }
    if(caps.cloak && policy.cloakOnReload) {
        const float energy=ai->GetEconomyManager()->GetEnergyCur();
        const float shot=weaponIndex>=0 && caps.weapons[weaponIndex].def ? caps.weapons[weaponIndex].def->GetCostEShot() : 500.f;
        const bool wanted=energy>shot+(moving?caps.cloakMoving:caps.cloakCost)*policy.cloakReserve;
        if(wanted!=cloakWanted) { TRY_UNIT(ai,unit,unit->CmdCloak(wanted);) cloakWanted=wanted; }
    }
    if(policy.coordinated) { UpdateCohort(unit); return; }
    float maxRange=0.f;
    for(const auto& w:caps.weapons) maxRange=std::max(maxRange,w.range);
    world.Nearby(pos,maxRange+1000.f,nearby);
    const auto& contacts=world.Contacts();
    TimingTick(unit,pos,maxRange,false);   // owner 2026-11-16: RANGEDTIME
    const bool report=trace && frame>=traceFrame+150;
    if(report) { traceFrame=frame; ai->LOG("RANGED: sample unit=%d contacts=%u near=%u range=%.1f",id,unsigned(contacts.size()),unsigned(nearby.size()),maxRange); }
    if(report && world.SpamFilter()!=nullptr) {
        int ignored=0; for(int i:nearby) if(world.SpamHazardIgnored(contacts[i])) ++ignored;
        if(ignored>0) ai->LOG("RANGEDTRACE: spam no hazard unit=%d ignored=%d",id,ignored);
    }

    // Individual fire_at_will: which contacts are in weapon reach. Scanned
    // before the withdrawal branch (2026-11-06), so a forward-mount hull
    // backing off a closing contact also holds while spam is in reach.
    bool spamInRange=false, otherInRange=false;
    if(policy.fireAtWill) for(int i:nearby) {
        const auto& c=contacts[i];
        // Unidentified dots enter only as spam (spam_radar_dots); an air dot
        // or a dot without that flag never opens or holds fire.
        if(c.pos.y< -20.f || (c.def ? c.def->IsAbleToFly() : !Spam(policy,c))) continue;
        // Engine reach includes the target's radius. Spam is held 200 elmos
        // early: a volley fired just before it walks in still lands on it.
        const bool spam=Spam(policy,c);
        const float reach=maxRange+c.radius+(spam?200.f:64.f);
        // Owner 2026-10-27: a low_trajectory hull's non-spam contact opens
        // fire only if its shell clears the terrain; an unreachable commander
        // behind a ridge otherwise opened fire and engine autofire took spam.
        // One terrain walk (distance/32 samples) per such contact in reach.
        if(pos.SqDistance2D(c.pos)<=reach*reach && (spam || !policy.lowTrajectory
            || std::any_of(caps.weapons.begin(),caps.weapons.end(),[&](const auto& w){return world.Trajectory(w,pos,c.pos);})))
            (spam?spamInRange:otherInRange)=true;
    }
    const CRangedWorld::Contact* closing=nullptr;
    float urgency=0.f;
    const bool forward=std::any_of(caps.weapons.begin(),caps.weapons.end(),[](const auto& w){return w.forward;});
    const float escapeSeconds=ranged::EscapeSeconds(caps.speed,caps.turnRate,caps.acceleration,forward,policy.reactionSeconds);
    for(int i:nearby) {
        // Owner 2026-10-19: a pressed static defence is fought, not escaped;
        // only its death blast still pushes the hull back.
        const auto& c=contacts[i]; const float hazard=world.Hz(c,policy.pressStatic);
        if(hazard<=0.f) continue;
        // D-294: escaping a much faster avoided contact (Tick) is futile and
        // only spends MOVEs. It remains a hazard for Safe/DangerSign below.
        if(c.def && (c.def->GetCategory()&policy.avoidCategory)) continue;
        const float d=std::sqrt(pos.SqDistance2D(c.pos));
        const float closingSpeed=ranged::ClosingSpeed(P(pos),P(c.pos),P(c.velocity));
        const float reach=hazard+(c.mobile?policy.safetyMargin:StaticMargin(policy))+closingSpeed*escapeSeconds;
        if(d<reach && reach-d>urgency) { closing=&c; urgency=reach-d; }
    }
    // Owner 2026-11-02: inside a ghost porc's reach, leave it like observed
    // coverage (stationary, so no closing term). Ghosts are never targets, so
    // the hull then waits outside until radar or LOS shows the structure.
    world.NearbyGhosts(pos,StaticMargin(policy),GhostRange(policy),policy.pressStatic,ghostNearby);
    for(int i:ghostNearby) {
        const auto& c=world.Ghosts()[i];
        const float reach=world.Hz(c,policy.pressStatic)+StaticMargin(policy);
        const float d=std::sqrt(pos.SqDistance2D(c.pos));
        if(d<reach && reach-d>urgency) { closing=&c; urgency=reach-d; }
    }
    if(report && !ghostNearby.empty()) ai->LOG("RANGED: ghost porc reach unit=%d ghosts=%u",id,unsigned(ghostNearby.size()));
    if (policy.ghostVolleys > 0 && (closing || frame < withdrawalUntil) && ghostFire.target >= 0) {
        GhostFireStep(ai,unit,pos,frame,ghostFire,ghostSupport,policy.ghostVolleys,false,policy.ghostVolleysHeavy);
    }
    if(!policy.holdFireline && (closing || frame<withdrawalUntil)) {
        if(closing && !(frame<withdrawalUntil && moving)) {
            AIFloat3 away=pos-closing->pos;
            if(away.SqLength2D()<1.f) away=AIFloat3(1.f,0.f,0.f);
            away.Normalize2D();
            // Owner 2026-11-04: with static_margin set, drifting into porc
            // reach is answered by a step just past it (the firing ring is
            // outside), not a 160+ retreat out of our own range. Mobiles keep
            // the full escape.
            const bool staticStep=policy.staticMargin>=0.f && (!closing->mobile || closing->ghost);
            const float separation=staticStep?urgency+16.f:std::max(160.f,urgency+policy.hysteresis);
            AIFloat3 escape=pos+away*std::min(600.f,separation);
            CTerrainManager::CorrectPosition(escape);
            escape.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(escape.x,escape.z);
            if(world.Safe(pos,escape,StaticMargin(policy),true,policy.pressStatic,GhostRange(policy))) {
                // Forward-arc hulls commit to their exit; unrestricted turrets
                // may retain a safe pursuer as target while MOVE remains owner.
                if(forward) { SelectTarget(unit,-1,-1,0.f); reorient=true; }
                orientUntil=0; // A newly closing threat preempts facing recovery.
                withdrawalUntil=frame+std::max(30,int(escapeSeconds*30.f));
                if(trace) ai->LOG("RANGED: escape unit=%d from=%d def=%s tech=%.0f mobile=%d urgency=%.0f",id,closing->id,
                    closing->def?closing->def->GetDef()->GetName():"dot",closing->tech,int(closing->mobile),urgency);
                Move(unit,escape,true,true);
            }
        }
        if(forward) {
            // 2026-11-06: this early return skipped the hold below, so engine
            // autofire could take spam while the hull backed off.
            if(policy.fireAtWill) UpdateFireState(unit,!spamInRange && otherInRange);
            return;
        }
    }

    if (policy.holdFireline && closing) {
        Hold(unit,true);
        withdrawalUntil=0;
    }
    int best=-1,bestWeapon=-1; float bestScore=-1.f,bestDamage=0.f;
    // trace only (2026-11-21 Daedalus idle): why ground contacts within max range were not picked
    int skSpam=0,skLos=0,skKind=0,skReach=0,skTraj=0,skFriend=0,skDamage=0,inReach=0;
    const auto inMax=[&](const CRangedWorld::Contact& c){ return report && !(c.def && c.def->IsAbleToFly()) && !c.airDot && pos.SqDistance2D(c.pos)<=SQUARE(maxRange+c.radius); };
    for(int i:nearby) {
        const auto& c=contacts[i];
        const bool counted=inMax(c); if(counted) ++inReach;
        if(Spam(policy,c)) { if(counted) ++skSpam; continue; } // owner 2026-10-19: never a priority target
        if(!shunned.empty() && Shunned(c.id)) continue;         // owner 2026-11-23: refused shot / no firing site
        if(!c.los && !policy.allowRadar) { if(counted) ++skLos; continue; }
        if((c.mobile && !policy.allowMobile)||(!c.mobile && !policy.allowStatic)) { if(counted) ++skKind; continue; }
        // D-294 (owner correction): artillery and radar are a pairing, so a
        // blind shot at a slow or stationary dot stays valid. Identified avoided
        // categories are excluded here; an unidentified dot too fast for the
        // shell is excluded below by the same evasion arithmetic.
        if(c.def && (c.def->GetCategory()&policy.avoidCategory)) continue; // O(1)
        for(size_t wi=0;wi<caps.weapons.size();++wi) {
            const auto& w=caps.weapons[wi];
            if((c.def && !(w.category&c.def->GetCategory())) || c.pos.y< -20.f) continue;
            const float range=world.Range(w,pos,c.pos);
            if(pos.SqDistance2D(c.pos)>range*range) { if(inMax(c)) ++skReach; continue; }
            if(!world.Trajectory(w,pos,c.pos)) { if(inMax(c)) ++skTraj; continue; }
            // Destroying energy storage can kill nearby allies even when our
            // own weapon is precise. Keep clear of its loaded death blast and
            // withhold the shot until the exposed cohort can leave it.
            if(c.explosionRadius>0.f && pos.SqDistance2D(c.pos)<std::pow(c.explosionRadius+caps.radius,2.f)) continue;
            if(world.FriendlySplash(id,c.pos,std::max(w.splash,c.explosionRadius))) { if(inMax(c)) ++skFriend; continue; }
            if(world.FriendlyLine(w,id,pos,c.pos)) { if(inMax(c)) ++skFriend; continue; }
            const int armor=c.armor;
            const float damage=policy.mode==RangedPolicy::Mode::CARRIER?c.health:
                (armor>=0 && size_t(armor)<w.damage.size()?w.damage[armor]*w.alphaScale:0.f);
            if(damage<=0.f) { if(inMax(c)) ++skDamage; continue; }
            // A legal unidentified radar dot is a low-priority blind shot,
            // never an invented heavy identity, HP estimate or threat source.
            float value=c.def ? ranged::UsefulScore(c.cost,c.health,damage,world.Reserved(c.id,id),policy.mode==RangedPolicy::Mode::PRECISION,
                policy.preferHeavy && c.def->IsEnemyRoleAny(CCircuitDef::HEAVY|CCircuitDef::COMM),c.los,world.Progress(c.id,policy.repairedTargetPenalty)) : .01f/(1.f+world.Reserved(c.id,id));
            if(c.def && policy.mode!=RangedPolicy::Mode::PRECISION)
                value+=policy.splashWeight*std::max(0.f,world.ClusterValue(c.pos,w.splash)-c.cost);
            // D-294: opt-in hit-likelihood test for slow shells against fast
            // targets. Identified: a 0.05 penalty (with nothing better the shot
            // is still taken). Unidentified dot for an avoid-category shooter:
            // excluded, since a dot that fast cannot be told from a scout and
            // the played run spent 7-second shells on running Ticks. A dot's
            // velocity comes from the radar track; one sample reads as
            // stationary. O(1) per candidate mount.
            const bool evasive=policy.evasionLimit>0.f && c.mobile && ranged::Evasive(std::sqrt(pos.SqDistance2D(c.pos)),w.speed,
                std::sqrt(c.velocity.x*c.velocity.x+c.velocity.z*c.velocity.z),w.splash,c.radius,policy.evasionLimit);
            if(evasive && !c.def && policy.avoidCategory!=0) continue;
            if(evasive) value*=.05f;
            if(c.id==target) value*=policy.targetHysteresis;
            if(policy.mode==RangedPolicy::Mode::BOMBARDMENT && !c.mobile) value*=1.5f;
            if(closing && closing->id==c.id) value*=2.f;
            // Owner 2026-10-19: the tower shooting at a pressing hull comes first.
            if(CRangedWorld::Pressed(c,policy.pressStatic)) value*=PRESSED_STATIC_TARGET_MULTIPLIER;
            if(c.def && c.def->IsEnemyRoleAny(CCircuitDef::COMM)) value*=policy.commanderPriority;
            // Owner 2026-11-07: priority_min_tech. A tier, not a weight: the offset
            // puts every structure / commander / T2+ contact above any T1 mobile
            // or dot, and lets SelectTarget's switch ratio leave a held T1 at once.
            if(def->IsPriorityTarget(c.def)) value+=PRIORITY_TIER_OFFSET;
            // Owner 2026-11-15: structures_over_slow (see STRUCTURE_TIER_OFFSET); unidentified dots stay below.
            if(c.def && policy.structuresOverSlow>0.f && !SlowMobile(c,policy.structuresOverSlow)) value+=STRUCTURE_TIER_OFFSET;
            if(c.id==target && (heldScoreFrame!=frame || value>heldScore)) { heldScore=value; heldScoreFrame=frame; }
            if(value>bestScore || (value==bestScore && (best<0 || c.id<contacts[best].id))) {
                best=i; bestWeapon=int(wi); bestScore=value; bestDamage=damage;
            }
        }
    }
    // Idle ghost fire borrows the rocket-artillery accounting and wreck checks.
    // Live LOS/radar contacts and the existing withdrawal branch always preempt it.
    // The enemy scan runs only for opted-in idle units; no new per-frame index.
    if (policy.ghostVolleys > 0) {
        if (best >= 0 || otherInRange || spamInRange || closing || frame < withdrawalUntil) {
            if (ghostFire.target >= 0) {
                GhostFireStep(ai,unit,pos,frame,ghostFire,ghostSupport,policy.ghostVolleys,false,policy.ghostVolleysHeavy);
            }
        } else if (GhostFireStep(ai,unit,pos,frame,ghostFire,ghostSupport,policy.ghostVolleys,true,policy.ghostVolleysHeavy)) {
            query.reset(); ++generation; moving=false; path.clear(); pathCursor=0;
            return;
        }
    }
    // Owner 2026-11-15 (Kolmogorov replay: AI 15's Myrmidons sat on HOLD in all 136
    // samples, drones docked, scouted targets 1,100-1,300 away): a carrier hull with no
    // gun target takes the nearest scouted non-spam ground contact inside its drone
    // weapon's reach that no gun can reach from here. The set target is the drone
    // weapon's target, so BAR's carrier gadget launches the drones; the guns, out of
    // reach of it, stay silent, and with spam in reach the hull stays on HOLD, so the
    // plasma still never autofires at spam. O(nearby) only for carrier hulls.
    int droneTarget=-1;
    if(best<0 && caps.droneRange>0.f) {
        float nearestDrone=std::numeric_limits<float>::max();
        for(int i:nearby) {
            const auto& c=contacts[i];
            if(!c.def || !c.los || Spam(policy,c) || c.def->IsAbleToFly() || c.pos.y< -20.f) continue;
            if(c.def->GetCategory()&policy.avoidCategory) continue;
            const float d2=pos.SqDistance2D(c.pos);
            if(d2>SQUARE(caps.droneRange+c.radius) || d2>=nearestDrone) continue;
            bool gunReach=false;
            for(const auto& w:caps.weapons) {
                if(!(w.category&c.def->GetCategory())) continue;
                const float r=world.Range(w,pos,c.pos);
                if(d2<=SQUARE(r+c.radius)) { gunReach=true; break; }
            }
            if(gunReach) continue;   // filtered gun shot (splash, line, trajectory): never forced
            nearestDrone=d2; droneTarget=i;
        }
    }
    // A priority target still fires on HOLD, so spam in reach always holds:
    // an unreachable priority target would otherwise hand the volley to spam.
    if(report) ai->LOG("RANGEDTRACE: pick unit=%d at=%.0f,%.0f best=%d def=%s spamIn=%d otherIn=%d closing=%d moving=%d marching=%d inReach=%d skip spam=%d los=%d kind=%d reach=%d traj=%d friend=%d damage=%d",
        id,pos.x,pos.z,best>=0?contacts[best].id:-1,best>=0&&contacts[best].def?contacts[best].def->GetDef()->GetName():"-",int(spamInRange),int(otherInRange),
        closing?closing->id:-1,int(moving),int(marching),inReach,skSpam,skLos,skKind,skReach,skTraj,skFriend,skDamage);
    // Owner 2026-11-21: spam_fire_idle_seconds. Busy = a target, a drone target, a
    // closing threat, a withdrawal, a move or a march. Only spam in reach for that
    // long while idle: open fire and let engine autofire take it.
    if(best>=0 || droneTarget>=0 || closing || frame<withdrawalUntil || moving || marching || query || !spamInRange) spamIdleSince=frame;
    const bool spamIdleFire=policy.spamFireIdleSeconds>0.f && spamInRange && !otherInRange
        && frame-spamIdleSince>=int(policy.spamFireIdleSeconds*FRAMES_PER_SEC);
    if(spamIdleFire && !spamIdleLogged) { ai->LOG("RANGED: spam idle fire unit=%d after=%.0fs",id,policy.spamFireIdleSeconds); spamIdleLogged=true; }
    if(!spamIdleFire) spamIdleLogged=false;
    if(policy.fireAtWill) UpdateFireState(unit,spamIdleFire || (!spamInRange && (best>=0 || otherInRange || droneTarget>=0)));
    if(best<0 && droneTarget>=0) {
        const auto& c=contacts[droneTarget];
        if(report) ai->LOG("RANGED: drone target unit=%d target=%d dist=%.0f spam=%d",id,c.id,std::sqrt(pos.SqDistance2D(c.pos)),int(spamInRange));
        SelectTarget(unit,c.id,-1,0.f,0.f);
        TimingTick(unit,pos,maxRange,true);
    }
    if(best>=0) {
        const auto& c=contacts[best];
        SelectTarget(unit,c.id,bestWeapon,bestDamage,bestScore);
        if(frame<withdrawalUntil) return;
        const float spacing=policy.spacing;
        if(frame<orientUntil) return;
        // An energy-starved shot is not evidence of a blocked firing lane.
        // Repositioning cannot solve the shortage and only creates churn.
        const auto* selectedWeapon=caps.weapons[bestWeapon].def;
        const bool funded=!selectedWeapon || ai->GetEconomyManager()->GetEnergyCur()>=selectedWeapon->GetCostEShot();
        const bool stalled=funded && policy.mode!=RangedPolicy::Mode::CARRIER && frame-lastShotFrame>
            int((caps.weapons[bestWeapon].reload+8.f)*30.f);
        if(reorient || (forward && stalled)) {
            // D-226: SET_TARGET selects a weapon target, not hull facing. An
            // in-range target behind a forward mount can therefore remain
            // passive forever. Moving back to the outer firing band faces
            // away again; the next decision also used to STOP that move.
            // Reuse withdrawal's short, safety-checked facing step and let it
            // finish. Real fire, new danger and the bounded deadline still
            // interrupt it. This is one local candidate, not another scan.
            AIFloat3 facing=c.pos-pos; facing.Normalize2D(); auto point=pos+facing*64.f;
            if(world.Safe(pos,point,StaticMargin(policy),false,policy.pressStatic,GhostRange(policy)) && world.FreeSlot(id,point,spacing)
                && Move(unit,point,false)) {
                orientUntil=frame+std::max(30,int(escapeSeconds*30.f));
                lastShotFrame=frame;
                reorient=false;
                if(trace) ai->LOG("RANGED: face unit=%d target=%d until=%d",id,c.id,orientUntil);
                return;
            }
            reorient=false;
        }
        if(world.FreeSlot(id,pos,spacing) && !stalled) {
            Hold(unit);
            SelectTarget(unit,c.id,bestWeapon,bestDamage,bestScore);
            world.SetSlot(id,pos,spacing,def->GetCostM());
            return;
        }
        if(stalled) {
            ++failures; lastShotFrame=frame;
            // Owner 2026-11-23 (Salt Reef): the engine never fired at it although our
            // range and trajectory tests pass (cliff lip). After shun_refusals stalls
            // on the same target, leave it and take the next target or objective.
            if(policy.shunSeconds>0.f) {
                if(refusedTarget!=c.id) { refusedTarget=c.id; refusedCount=0; }
                if(++refusedCount>=policy.shunRefusals) {
                    const int refused=c.id;
                    refusedTarget=-1; refusedCount=0;
                    Shun(refused,"no shot");
                    SelectTarget(unit,-1,-1,0.f);
                    return;
                }
            }
        }
        if(frame<burstUntil) return;
    } else if(droneTarget<0) SelectTarget(unit,-1,-1,0.f);
    if (policy.holdFireline && closing) {
        world.SetSlot(id,pos,policy.spacing,def->GetCostM());
        return; // A facing gun remains useful; turning away cannot create fire.
    }
    if(frame<withdrawalUntil || frame<burstUntil) return;

    // Stable target-centered firing bands. Candidate work is bounded (17 sites
    // per objective), and local formation queries avoid pairwise unit scans.
    // Borrow frame-local candidates; preserve their order/ties without a
    // heap-allocated vector copy for each unit every eight frames.
    const auto& choices=nearby.empty() ? world.Objectives() : nearby;
    float nearest=std::numeric_limits<float>::max(); int objective=-1;
    int unknownObjectives=0;
    // Owner 2026-11-18 (Astraeus): kite_min_tech / kite_ignore_fast_dots. A
    // kite-ignored contact (T1 mobile, fast unknown dot) is an objective only
    // when no other is: a firing band at max range around a T1 walking at us
    // lies behind us, so that objective walked the hull backwards.
    const bool kiteFilter=world.KiteMinTech()>0.f || world.KiteDotSpeed()>0.f;
    float nearestIgnored=std::numeric_limits<float>::max(); int ignoredObjective=-1;
    const auto consider=[&](int i) {
        const auto& c=contacts[i];
        if (policy.holdFireline && !c.los) return;
        // A radar dot permits a blind shot, not an invented threat estimate.
        // Precision hulls can opt out of advancing before vision identifies
        // the contact; otherwise they walk into fast assault while arranging
        // a firing band around an apparently harmless unknown target.
        if(!c.def && !policy.advanceUnknownRadar) { ++unknownObjectives; return; }
        if((c.def && c.def->IsAbleToFly()) || (c.mobile?!policy.allowMobile:!policy.allowStatic)) return;
        // Owner 2026-11-21 (Swirly Rock Daedalus idle): spam is never our target, so it is
        // never the objective either. A Peewee as nearest objective parked the hull on a
        // firing site round it (already in reach: stand), fire held, for minutes.
        if((policy.fireAtWill || policy.alwaysFireAtWill) && Spam(policy,c)) return;
        if(!shunned.empty() && Shunned(c.id)) return;   // owner 2026-11-23: refused shot / no firing site
        // D-294: never approach an identified avoided contact. Unidentified
        // dots stay approachable (advance_unknown_radar owns that): approach
        // is the only way to identify them; the blind SHOT is what is refused.
        if(c.def && (c.def->GetCategory()&policy.avoidCategory)) return;
        const float dist=pos.SqDistance2D(c.pos);
        if(c.def && !(c.def->GetCategory()&def->GetTargetCategory())) return;
        if(kiteFilter && world.KiteIgnored(c)) { if(dist<nearestIgnored) { nearestIgnored=dist; ignoredObjective=i; } return; }
        if(dist<nearest) { nearest=dist; objective=i; }
    };
    // D-295: with no legal shot, prefer the nearest visible contact an allied
    // screen is already fighting (precedence: shot > danger/closing > assist >
    // nearest objective). O(K) over contacts within assistRadius, reusing
    // assistNearby; Engaged is memoised per contact per frame and evaluated
    // only for a candidate nearer than the current best.
    bool assisting=false; int assistAlly=-1;
    if(best<0 && policy.assistRadius>0.f && !closing) {
        performance::Scope assistPhase(ai,performance::RANGED_ASSIST);
        world.Nearby(pos,policy.assistRadius,assistNearby);
        for(int i:assistNearby) {
            const auto& c=contacts[i];
            if(!c.def || !c.los || c.def->IsAbleToFly()) continue;
            if((c.mobile?!policy.allowMobile:!policy.allowStatic) || !(c.def->GetCategory()&def->GetTargetCategory())
                || (c.def->GetCategory()&policy.avoidCategory)) continue;
            // Target hysteresis: a moving fight re-ranks "nearest" every few
            // seconds; without it (8v8 20261014T015406Z) a Starlight changed
            // assist target 19-23 times in three minutes with destinations
            // jumping 500-2000 elmos. Keep the current target unless another
            // engaged contact is at least ~1.7x nearer (0.33 on squared distance).
            const float distance=pos.SqDistance2D(c.pos)*(c.id==assistTarget?.33f:1.f);
            if(distance>=nearest) continue;
            int ally=-1;
            if(!world.Engaged(i,policy.assistMargin,&ally)) continue;
            nearest=distance; objective=i; assistAlly=ally;
        }
        assisting=objective>=0;
    }
    if(!assisting) {
        assistTarget=-1;
        if(best>=0) consider(best);
        else for(int i:choices) consider(i);
    }
    // Nearby aircraft or incompatible contacts must not hide every distant
    // reachable ground objective. The shared shortlist is bounded to 16.
    if(objective<0) for(int i:world.Objectives()) {
        const auto& c=contacts[i];
        if (policy.holdFireline && !c.los) continue;
        if(!c.def && !policy.advanceUnknownRadar) { ++unknownObjectives; continue; }
        if((policy.fireAtWill || policy.alwaysFireAtWill) && Spam(policy,c)) continue;   // owner 2026-11-21: spam is never an objective
        if(!shunned.empty() && Shunned(c.id)) continue;   // owner 2026-11-23
        if((c.mobile?!policy.allowMobile:!policy.allowStatic) || (c.def && !(c.def->GetCategory()&def->GetTargetCategory()))) continue;
        if(c.def && (c.def->GetCategory()&policy.avoidCategory)) continue; // D-294 (unknown dots approachable, see above)
        const float distance=pos.SqDistance2D(c.pos);
        if(kiteFilter && world.KiteIgnored(c)) { if(distance<nearestIgnored) { nearestIgnored=distance; ignoredObjective=i; } continue; }
        if(distance<nearest) { nearest=distance; objective=i; }
    }
    // Owner 2026-11-23: the group's live heavy porc assault target is the objective.
    if(assaultGo && !assaultGhostTarget && assaultPorc>=0) {
        for(size_t i=0;i<contacts.size();++i) if(contacts[i].id==assaultPorc) { objective=int(i); break; }
    }
    const bool ignoredOnly=objective<0 && ignoredObjective>=0;
    if(ignoredOnly) objective=ignoredObjective;
    if(report && unknownObjectives>0) ai->LOG("RANGED: unknown radar approach withheld unit=%d candidates=%d",id,unknownObjectives);
    if(objective<0) {
        if(report) ai->LOG("RANGED: no objective unit=%d",id);
        // Owner 2026-11-23 (porc_hazards hulls: Daedalus, Myrmidon): a structure we know only as a
        // ghost (last seen, out of radar and LOS, spot not seen empty) is an objective too: walk to
        // 98% of our range of it and fire on its image (attack ground), at most once per 3 s.
        if (!policy.holdFireline && policy.porcHazardList && !closing && frame>=withdrawalUntil && droneTarget<0) {
            AIFloat3 ghostPos;
            const bool assaultGhost=assaultGo && assaultGhostTarget;
            if (assaultGhost) ghostPos=assaultPos;
            if (assaultGhost || GhostStructure(pos,ghostPos)) {
                const float reach=maxRange*policy.rangeFraction;
                const float d=std::sqrt(pos.SqDistance2D(ghostPos));
                if (d<=reach+16.f) {
                    if (frame>=ghostShotFrame) {
                        ghostShotFrame=frame+FRAMES_PER_SEC*3;
                        if(moving || query) Hold(unit,true);
                        TRY_UNIT(ai,unit, unit->CmdAttackGround(ghostPos,0,frame+FRAMES_PER_SEC*4); )
                        if(report || ghostShotLog!=int(ghostPos.x)*100000+int(ghostPos.z)) {
                            ghostShotLog=int(ghostPos.x)*100000+int(ghostPos.z);
                            ai->LOG("RANGED: ghost fire unit=%d at=%.0f,%.0f dist=%.0f",id,ghostPos.x,ghostPos.z,d);
                        }
                    }
                    return;
                }
                if (March(unit,pos,&ghostPos,maxRange)) return;
            }
        }
        if (policy.holdFireline) Hold(unit,true);
        else if (closing || frame<withdrawalUntil || droneTarget>=0 || (SetMarchObjective(-1),!March(unit,pos,nullptr,maxRange))) Disperse(unit);
        return;
    }
    const auto& c=contacts[objective];
    if(!c.def && !policy.advanceUnknownRadar) {
        ai->LOG("[INVARIANT] INV-149 precision movement selected an unidentified radar objective");
        return;
    }
    const float spacing=policy.spacing;
    // Owner 2026-11-18: only kite-ignored contacts around. Inside our reach of
    // it already: stay and fire (engine autofire), never step back to the
    // band. Out of reach: the site loop below takes forward/lateral sites only.
    if(ignoredOnly) {
        const bool inReach=std::any_of(caps.weapons.begin(),caps.weapons.end(),[&](const auto& w){
            const float r=world.Range(w,pos,c.pos)*policy.rangeFraction; return pos.SqDistance2D(c.pos)<=r*r; });
        if(inReach) {
            if(report) ai->LOG("RANGED: kite-ignored objective in reach, holding unit=%d target=%d",id,c.id);
            if(moving) Hold(unit,true);
            world.SetSlot(id,pos,spacing,def->GetCostM());
            return;
        }
    }
    AIFloat3 back=pos-c.pos; back.Normalize2D();
    const float baseAngle=std::atan2(back.z,back.x);
    float chosenScore=std::numeric_limits<float>::max(); AIFloat3 chosen=pos; bool found=false;
    int terrainRejected=0,slotRejected=0,coverageRejected=0,fireRejected=0,lineRejected=0,sitesTried=0;
    for(const auto& w:caps.weapons) {
        if(c.def && !(w.category&c.def->GetCategory())) continue;
        // Owner 2026-11-15: the ring radius is the reach from each stand point's own
        // ground (WeaponReach), not from where the hull stands now: a valley stand
        // firing uphill is pulled in, a hilltop stand keeps its longer reach.
        const float flatRange=w.range*policy.rangeFraction;   // angle spacing only
        for(int k=0;k<17;++k) {
            ++sitesTried;
            const int slot=(k+failures)%17;
            const int side=slot==0?0:((slot%2)?(slot+1)/2:-slot/2);
            const float angle=baseAngle+side*std::max(.12f,spacing/std::max(1.f,flatRange));
            const AIFloat3 dir(std::cos(angle),0.f,std::sin(angle));
            const float range=world.StandoffRange(w,c.pos,dir,policy.rangeFraction);
            if(range<=0.f) { ++fireRejected; continue; }
            AIFloat3 point(c.pos.x+dir.x*range,0.f,c.pos.z+dir.z*range);
            CTerrainManager::CorrectPosition(point);
            point.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(point.x,point.z);
            if(!ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),point)) { ++terrainRejected; continue; }
            if(!world.FreeSlot(id,point,spacing)) { ++slotRejected; continue; }
            if(UnknownStaticBlocks(unit,pos,point)) { ++coverageRejected; continue; }   // owner 2026-11-21
            if(!world.Safe(pos,point,StaticMargin(policy),true,policy.pressStatic,GhostRange(policy))
                || world.DangerSign(point,policy.safetyMargin,policy.pressStatic,GhostRange(policy),StaticDanger(policy))>0.f) {
                if(report && k==0) {
                    world.Nearby(point,900.f,coverageProbe);
                    for(int ci:coverageProbe) {
                        const auto& q=contacts[ci];
                        ai->LOG("RANGED: coverage unit=%d site=%.0f,%.0f ring=%.1f contact=%d def=%s mobile=%d ghost=%d hz=%.1f hazard=%.1f dist=%.1f exact=%d",
                            id,point.x,point.z,range,q.id,q.def?q.def->GetDef()->GetName():"-",int(q.mobile),int(q.ghost),
                            world.Hz(q,policy.pressStatic),q.hazardRadius,std::sqrt(point.SqDistance2D(q.pos)),int(world.ExactStatic()));
                    }
                }
                ++coverageRejected; continue;
            }
            // D-295: an assist standoff stays behind the allied screen.
            if(assisting && policy.assistScreen && !world.HasScreen(id,point,c.pos)) { ++coverageRejected; continue; }
            if(!world.Trajectory(w,point,c.pos)) { ++fireRejected; continue; }
            if(world.FriendlyLine(w,id,point,c.pos)) { ++fireRejected; ++lineRejected; continue; }
            // Forward-fire policy chooses safe advancing/lateral firing sites,
            // never a rearward range correction. O(1) within the existing
            // bounded site loop; independent of other ranged units' kiting.
            if ((policy.holdFireline || ignoredOnly) && ((point.x-pos.x)*(c.pos.x-pos.x)+(point.z-pos.z)*(c.pos.z-pos.z))<0.f) continue;
            const float move=pos.SqDistance2D(point);
            const float stable=destination.SqDistance2D(point)<policy.hysteresis*policy.hysteresis?.8f:1.f;
            const float screen=policy.preferScreen && !world.HasScreen(id,point,c.pos)?1.15f:1.f;
            const float score=move*stable*screen;
            if(failures>0 && move<4096.f) continue;
            if(score<chosenScore) { chosenScore=score; chosen=point; found=true; }
        }
    }
    if (!found && policy.stageWhenBlocked && c.def) {
        // D-216: a mid-range support hull must not wait at its spawn merely
        // because the observed static line outranges it. Stage on our side of
        // that line, outside every known weapon/death-blast disc. This does not
        // invent a safe firing solution or relax path/splash/retreat checks.
        // Bounded 3x9 sites, only after the normal 17-site search fails.
        const float radius = std::max(maxRange, world.Hz(c, policy.pressStatic) + (c.mobile ? policy.safetyMargin : StaticMargin(policy))) + policy.spacing;
        for (int ring = 0; ring < 3; ++ring) for (int k = 0; k < 9; ++k) {
            const int side = k == 0 ? 0 : ((k % 2) ? (k + 1) / 2 : -k / 2);
            const float angle = baseAngle + side * .16f;
            const float band = radius + ring * policy.spacing;
            AIFloat3 point(c.pos.x + std::cos(angle) * band, 0.f, c.pos.z + std::sin(angle) * band);
            CTerrainManager::CorrectPosition(point);
            point.y = ai->GetTerrainManager()->GetAreaData()->GetElevationAt(point.x, point.z);
            // Advance, never replace an already closer position with rearward
            // staging. Slot reservations preserve spacing between the hulls.
            if (point.SqDistance2D(c.pos) >= pos.SqDistance2D(c.pos)
                || !world.FreeSlot(id, point, spacing) || world.DangerSign(point, policy.safetyMargin, policy.pressStatic, GhostRange(policy), StaticDanger(policy)) > 0.f
                || !world.Safe(pos, point, StaticMargin(policy), true, policy.pressStatic, GhostRange(policy))
                || UnknownStaticBlocks(unit, pos, point)
                || !ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(), point)) continue;
            const float score = pos.SqDistance2D(point);
            if (score < chosenScore) { chosenScore = score; chosen = point; found = true; }
        }
        if (report && found) ai->LOG("RANGED: staging unit=%d outside target=%d coverage", id, c.id);
    }
    if(found && assisting) {
        // INV-205: the selected assist site is outside known static coverage
        // on its path and carries no danger sign. Same predicates as the
        // site loop; fires only on a regression. Two O(local) queries.
        if(!world.Safe(pos,chosen,StaticMargin(policy),true,policy.pressStatic,GhostRange(policy)) || world.DangerSign(chosen,policy.safetyMargin,policy.pressStatic,GhostRange(policy),StaticDanger(policy))>0)
            ai->LOG("[INVARIANT] INV-205 ranged assist destination is covered unit=%d target=%d dest=%.0f,%.0f",id,c.id,chosen.x,chosen.z);
        if(c.id!=assistTarget) {
            assistTarget=c.id; assistInvariantLogged=false; assistIdleStreak=0;
            ai->LOG("RANGED: assist unit=%d target=%d ally=%d dest=%.0f,%.0f",id,c.id,assistAlly,chosen.x,chosen.z);
        }
    }
    // D-295 hysteresis: a moving assist follows a moving fight. Keep a live,
    // still-legal route (or a pending query) whose goal is within one spacing
    // of the new site instead of re-pathing every 8-frame decision.
    const bool keepAssist=found && assisting && destination.SqDistance2D(chosen)<spacing*spacing
        && (query || (moving && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,true)));
    if(keepAssist) {
        world.SetSlot(id,destination,spacing,def->GetCostM());
    } else if(found) {
        world.SetSlot(id,chosen,spacing,def->GetCostM());
        if(Move(unit,chosen,true) && assisting) { assistCheckFrame=frame; assistCheckRejections=rejections; }
    } else if(!found && best<0 && droneTarget<0 && !closing && !policy.holdFireline && policy.shunSeconds>0.f
        && sitesTried>0 && terrainRejected+fireRejected==sitesTried && lineRejected==0) {
        // Owner 2026-11-23 (Salt Reef): every firing site round it is unwalkable or
        // has no shot (plateau 200+ up: the shell cannot climb it from the foot).
        // No position exists from our ground: leave it and take the next objective.
        Shun(c.id,"no firing site");
    } else if(!found && best<0 && droneTarget<0 && !closing && !policy.holdFireline
        && (SetMarchObjective(c.id),March(unit,pos,&c.pos,maxRange))) {
        // Owner 2026-11-16: no firing site passes from here (the straight walk
        // from the gantry crosses enemy coverage): walk up to that coverage.
        if(report) ai->LOG("RANGED: march to objective unit=%d target=%d",id,c.id);
    } else if(!moving) world.SetSlot(id,pos,spacing,def->GetCostM());
    if(report) ai->LOG("RANGED: sites unit=%d target=%d known=%d found=%d terrain=%d slots=%d coverage=%d fire=%d dest=%.0f,%.0f moving=%d query=%d queryid=%d generation=%u",id,c.id,c.def!=nullptr,int(found),terrainRejected,slotRejected,coverageRejected,fireRejected,chosen.x,chosen.z,int(moving),query?int(query->GetState()):-1,query?query->GetId():-1,generation);
    if(pos.SqDistance2D(lastPos)>1024.f) { lastPos=pos; lastProgressFrame=frame; failures=0; }
    // A blocked shot/site causes a new safe-position search, never pursuit.
    if(frame-lastProgressFrame>300 && lastReload<frame && target>=0) {
        destination=AIFloat3(-1.f,0.f,-1.f); ++failures; lastProgressFrame=frame;
    }
}
}
