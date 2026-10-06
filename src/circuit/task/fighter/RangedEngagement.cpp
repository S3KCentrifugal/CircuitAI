#include "task/fighter/RangedEngagement.h"
#include "task/UnitTask.h"
#include "CircuitAI.h"
#include "module/MilitaryManager.h"
#include "module/EconomyManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathSingle.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyUnit.h"
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

namespace circuit {
using springai::AIFloat3;
static ranged::Point P(const AIFloat3& p) { return {p.x,p.z}; }
static const bool trace = std::getenv("CIRCUIT_RANGED_TRACE") != nullptr;

CRangedEngagement::CRangedEngagement(CCircuitAI* ai,IUnitTask* owner,CCircuitUnit* unit)
    : ai(ai),owner(owner),worldOwner(ai->GetMilitaryManager()->GetRangedWorld()),world(*worldOwner),
      caps(world.CapabilitiesFor(unit->GetCircuitDef())),id(unit->GetId())
{
    lastPos=unit->GetPos(ai->GetLastFrame()); destination=lastPos;
    lastShotFrame=lastProgressFrame=ai->GetLastFrame();
    world.Join(unit); world.Refresh();
    unit->TrySetMoveState(CCircuitDef::HOLD_POS);
    // Priority targets are explicit user targets in BAR and can fire on HOLD.
    // Automatic fire would bypass precision/splash selection while approaching
    // the firing band (the engine includes target radius in reach).
    unit->TrySetFireState(CCircuitDef::HOLD);
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
            float params[]={float(target)};
            SendCustomCommand(ai->GetSkirmishAIId(),id,CMD_UNIT_CANCEL_TARGET,params);
        )
    }
    unit->TrySetMoveState(unit->GetCircuitDef()->GetMoveState());
    unit->TrySetFireState(unit->GetCircuitDef()->GetFireState());
}
void CRangedEngagement::SelectTarget(CCircuitUnit* unit,int selected,int weapon,float damage)
{
    const int frame=ai->GetLastFrame();
    if(selected==target && weapon==weaponIndex) {
        // BAR owns the actual priority target. A lost command must be repaired;
        // an unchanged live intent must not be resent each decision tick.
        if(selected<0 || frame-targetFrame<30 || int(unit->GetUnit()->GetRulesParamFloat("unitTargetID",-1.f))==selected) return;
    }
    if(selected!=target || weapon!=weaponIndex) world.ReleaseShot(id);
    TRY_UNIT(ai,unit,
        if(target>=0 && target!=selected) {
            float params[]={float(target)};
            SendCustomCommand(ai->GetSkirmishAIId(),id,CMD_UNIT_CANCEL_TARGET,params);
        }
        if(selected>=0) {
            float params[]={float(selected)};
            SendCustomCommand(ai->GetSkirmishAIId(),id,CMD_UNIT_SET_TARGET,params);
        }
    )
    if(weapon!=weaponIndex) {
        liveWeapon.reset(weapon>=0 ? unit->GetUnit()->GetWeapon(caps.weapons[weapon].mount.get()) : nullptr);
        lastReload=liveWeapon ? liveWeapon->GetReloadFrame() : -1;
    }
    target=selected; weaponIndex=weapon; targetFrame=frame; reservedDamage=damage;
    if(selected>=0) world.ReserveShot(id,selected,damage,frame+90);
}
void CRangedEngagement::Hold(CCircuitUnit* unit)
{
    query.reset(); ++generation;
    if(moving && !issuing) {
        moving=false; path.clear(); issuing=true;
        TRY_UNIT(ai,unit,unit->CmdStop();)
        // STOP cancels BAR's priority target. Repair it in this same decision,
        // rather than waiting for an unrelated idle or retarget event.
        targetFrame=0;
        issuing=false;
    }
}
bool CRangedEngagement::LegalPath(CCircuitUnit* unit,const std::vector<AIFloat3>& route,bool escape)
{
    AIFloat3 from=unit->GetPos(ai->GetLastFrame());
    const float margin=unit->GetCircuitDef()->GetRangedPolicy().safetyMargin;
    const size_t first=(&route==&path)?pathCursor:0;
    for(size_t i=first;i<route.size();++i) {
        const auto& p=route[i];
        if(from.SqDistance2D(p)<16.f) continue;
        if(!world.Safe(from,p,margin,escape)) return false;
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
        if (world.FreeSlot(id,point,policy.spacing) && world.Safe(pos,point,policy.safetyMargin,true)
            && world.Danger(point,policy.safetyMargin)==0.f
            && ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),point)) {
            Move(unit,point,true); return;
        }
    }
}
void CRangedEngagement::Move(CCircuitUnit* unit,const AIFloat3& dest,bool escape)
{
    const auto& policy=unit->GetCircuitDef()->GetRangedPolicy();
    const auto pos=unit->GetPos(ai->GetLastFrame());
    if(pos.SqDistance2D(dest)<32.f*32.f) { Hold(unit); return; }
    const bool same=destination.SqDistance2D(dest)<policy.hysteresis*policy.hysteresis;
    if(same && query) return;
    if(same && moving && ai->GetUnitAPI()->GetCMDQueueSize(id)>0 && LegalPath(unit,path,escape)) return;
    if(!ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),dest) || !world.Safe(pos,dest,policy.safetyMargin,escape)) return;
    destination=dest; query.reset(); const unsigned version=++generation;
    world.SetSlot(id,dest,policy.spacing,unit->GetCircuitDef()->GetCostM());
    auto* finder=ai->GetPathfinder();
    // Single-query radii are truncated to path-grid cells. A sub-cell radius
    // becomes zero and MicroPather fails immediately; use one cell, then
    // append and validate the exact formation slot as the final short leg.
    query=finder->CreatePathSingleQuery(unit,ai->GetThreatMap(),pos,dest,float(finder->GetSquareSize()));
    const std::weak_ptr<int> alive=lifetime;
    finder->RunQuery(ai->GetScheduler().get(),query,[this,alive,version,escape,dest](const IPathQuery* result) {
        if(alive.expired()) return;
        auto* unit=ai->GetTeamUnit(id);
        if(!unit || unit->GetTask()!=owner || version!=generation || result!=query.get()) return;
        auto points=static_cast<const CQueryPathSingle*>(result)->GetPathInfo()->posPath;
        world.Refresh();
        const bool solved=!points.empty();
        if(solved) points.push_back(dest);
        if(!solved || !LegalPath(unit,points,escape)) {
            if(trace) ai->LOG("RANGED: path rejected unit=%d points=%u",id,unsigned(points.size()));
            query.reset(); ++failures; return;
        }
        // Validate the actual worker path, then every continued route against
        // fresh coverage. No engine callbacks run on path worker threads.
        path=points; pathCursor=0; query.reset(); moving=true; issuing=true;
        TRY_UNIT(ai,unit,
            for(size_t i=0;i<path.size();++i) unit->CmdMoveTo(path[i],i?UNIT_COMMAND_OPTION_SHIFT_KEY:0);
        )
        issuing=false;
    });
}

void CRangedEngagement::Update(CCircuitUnit* unit)
{
    const int frame=ai->GetLastFrame();
    if(released || issuing || frame<nextFrame || unit->Blocker()) return;
    performance::Scope measured(ai,performance::RANGED_DECISION);
    nextFrame=frame+8; // decision sampling, not an order/APM limit; damage/idle invalidates
    world.Refresh();
    auto* def=unit->GetCircuitDef(); const auto& policy=def->GetRangedPolicy();
    const auto pos=unit->GetPos(frame);
    if(caps.weapons.empty()) return;
    // Discard already traversed waypoints. Validating a route back to its old
    // start incorrectly rejects a successful escape as renewed exposure.
    while(pathCursor<path.size() && (pos.SqDistance2D(path[pathCursor])<4096.f
        || (pathCursor+1<path.size() && pos.SqDistance2D(path[pathCursor+1])<pos.SqDistance2D(path[pathCursor])))) ++pathCursor;
    if(moving && !LegalPath(unit,path,true)) Hold(unit);
    if(moving && ai->GetUnitAPI()->GetCMDQueueSize(id)==0) { moving=false; path.clear(); pathCursor=0; }

    if(liveWeapon) {
        const int reload=liveWeapon->GetReloadFrame();
        if(reload>lastReload && lastReload>=0) {
            lastShotFrame=frame; failures=0;
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
    float maxRange=0.f;
    for(const auto& w:caps.weapons) maxRange=std::max(maxRange,w.range);
    world.Nearby(pos,maxRange+1000.f,nearby);
    const auto& contacts=world.Contacts();
    const bool report=trace && frame>=traceFrame+150;
    if(report) { traceFrame=frame; ai->LOG("RANGED: sample unit=%d contacts=%u near=%u range=%.1f",id,unsigned(contacts.size()),unsigned(nearby.size()),maxRange); }

    const CRangedWorld::Contact* closing=nullptr;
    float urgency=0.f;
    const bool forward=std::any_of(caps.weapons.begin(),caps.weapons.end(),[](const auto& w){return w.forward;});
    const float escapeSeconds=ranged::EscapeSeconds(caps.speed,caps.turnRate,caps.acceleration,forward,policy.reactionSeconds);
    for(int i:nearby) {
        const auto& c=contacts[i]; if(c.hazardRadius<=0.f) continue;
        const float d=std::sqrt(pos.SqDistance2D(c.pos));
        const float closingSpeed=ranged::ClosingSpeed(P(pos),P(c.pos),P(c.velocity));
        const float reach=c.hazardRadius+policy.safetyMargin+closingSpeed*escapeSeconds;
        if(d<reach && reach-d>urgency) { closing=&c; urgency=reach-d; }
    }
    if(closing || frame<withdrawalUntil) {
        if(closing && !(frame<withdrawalUntil && moving)) {
            AIFloat3 away=pos-closing->pos;
            if(away.SqLength2D()<1.f) away=AIFloat3(1.f,0.f,0.f);
            away.Normalize2D();
            const float separation=std::max(160.f,urgency+policy.hysteresis);
            AIFloat3 escape=pos+away*std::min(600.f,separation);
            CTerrainManager::CorrectPosition(escape);
            escape.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(escape.x,escape.z);
            if(world.Safe(pos,escape,policy.safetyMargin,true)) {
                // Forward-arc hulls commit to their exit; unrestricted turrets
                // may retain a safe pursuer as target while MOVE remains owner.
                if(forward) { SelectTarget(unit,-1,-1,0.f); reorient=true; }
                withdrawalUntil=frame+std::max(30,int(escapeSeconds*30.f));
                Move(unit,escape,true);
            }
        }
        if(forward) return;
    }

    int best=-1,bestWeapon=-1; float bestScore=-1.f,bestDamage=0.f;
    for(int i:nearby) {
        const auto& c=contacts[i];
        if(!c.los && !policy.allowRadar) continue;
        if((c.mobile && !policy.allowMobile)||(!c.mobile && !policy.allowStatic)) continue;
        for(size_t wi=0;wi<caps.weapons.size();++wi) {
            const auto& w=caps.weapons[wi];
            if((c.def && !(w.category&c.def->GetCategory())) || c.pos.y< -20.f) continue;
            const float range=world.Range(w,pos,c.pos);
            if(pos.SqDistance2D(c.pos)>range*range || !world.Trajectory(w,pos,c.pos)) continue;
            // Destroying energy storage can kill nearby allies even when our
            // own weapon is precise. Keep clear of its loaded death blast and
            // withhold the shot until the exposed cohort can leave it.
            if(c.explosionRadius>0.f && pos.SqDistance2D(c.pos)<std::pow(c.explosionRadius+caps.radius,2.f)) continue;
            if(world.FriendlySplash(id,c.pos,std::max(w.splash,c.explosionRadius))) continue;
            if(world.FriendlyLine(w,id,pos,c.pos)) continue;
            const int armor=c.armor;
            const float damage=policy.mode==RangedPolicy::Mode::CARRIER?c.health:
                (armor>=0 && size_t(armor)<w.damage.size()?w.damage[armor]*w.alphaScale:0.f);
            if(damage<=0.f) continue;
            // A legal unidentified radar dot is a low-priority blind shot,
            // never an invented heavy identity, HP estimate or threat source.
            float value=c.def ? ranged::UsefulScore(c.cost,c.health,damage,world.Reserved(c.id,id),policy.mode==RangedPolicy::Mode::PRECISION,
                policy.preferHeavy && c.def->IsEnemyRoleAny(CCircuitDef::HEAVY|CCircuitDef::COMM),c.los,world.Progress(c.id,policy.repairedTargetPenalty)) : .01f/(1.f+world.Reserved(c.id,id));
            if(c.def && policy.mode!=RangedPolicy::Mode::PRECISION)
                value+=policy.splashWeight*std::max(0.f,world.ClusterValue(c.pos,w.splash)-c.cost);
            if(c.id==target) value*=policy.targetHysteresis;
            if(policy.mode==RangedPolicy::Mode::BOMBARDMENT && !c.mobile) value*=1.5f;
            if(closing && closing->id==c.id) value*=2.f;
            if(value>bestScore || (value==bestScore && (best<0 || c.id<contacts[best].id))) {
                best=i; bestWeapon=int(wi); bestScore=value; bestDamage=damage;
            }
        }
    }
    if(best>=0) {
        const auto& c=contacts[best];
        SelectTarget(unit,c.id,bestWeapon,bestDamage);
        if(frame<withdrawalUntil) return;
        const float spacing=policy.spacing;
        if(reorient) {
            AIFloat3 facing=c.pos-pos; facing.Normalize2D(); auto point=pos+facing*64.f;
            if(world.Safe(pos,point,policy.safetyMargin) && world.FreeSlot(id,point,spacing)) Move(unit,point,false);
            orientUntil=frame+std::max(30,int(escapeSeconds*30.f));
            reorient=false; return;
        }
        if(frame<orientUntil) return;
        // An energy-starved shot is not evidence of a blocked firing lane.
        // Repositioning cannot solve the shortage and only creates churn.
        const auto* selectedWeapon=caps.weapons[bestWeapon].def;
        const bool funded=!selectedWeapon || ai->GetEconomyManager()->GetEnergyCur()>=selectedWeapon->GetCostEShot();
        const bool stalled=funded && policy.mode!=RangedPolicy::Mode::CARRIER && frame-lastShotFrame>
            int((caps.weapons[bestWeapon].reload+8.f)*30.f);
        if(world.FreeSlot(id,pos,spacing) && !stalled) {
            Hold(unit);
            SelectTarget(unit,c.id,bestWeapon,bestDamage);
            world.SetSlot(id,pos,spacing,def->GetCostM());
            return;
        }
        if(stalled) { ++failures; lastShotFrame=frame; }
        if(frame<burstUntil) return;
    } else SelectTarget(unit,-1,-1,0.f);
    if(frame<withdrawalUntil || frame<burstUntil) return;

    // Stable target-centered firing bands. Candidate work is bounded (17 sites
    // per objective), and local formation queries avoid pairwise unit scans.
    // Borrow frame-local candidates; preserve their order/ties without a
    // heap-allocated vector copy for each unit every eight frames.
    const auto& choices=nearby.empty() ? world.Objectives() : nearby;
    float nearest=std::numeric_limits<float>::max(); int objective=-1;
    int unknownObjectives=0;
    const auto consider=[&](int i) {
        const auto& c=contacts[i];
        // A radar dot permits a blind shot, not an invented threat estimate.
        // Precision hulls can opt out of advancing before vision identifies
        // the contact; otherwise they walk into fast assault while arranging
        // a firing band around an apparently harmless unknown target.
        if(!c.def && !policy.advanceUnknownRadar) { ++unknownObjectives; return; }
        if((c.def && c.def->IsAbleToFly()) || (c.mobile?!policy.allowMobile:!policy.allowStatic)) return;
        const float dist=pos.SqDistance2D(c.pos);
        if(dist<nearest && (!c.def || (c.def->GetCategory()&def->GetTargetCategory()))) { nearest=dist; objective=i; }
    };
    if(best>=0) consider(best);
    else for(int i:choices) consider(i);
    // Nearby aircraft or incompatible contacts must not hide every distant
    // reachable ground objective. The shared shortlist is bounded to 16.
    if(objective<0) for(int i:world.Objectives()) {
        const auto& c=contacts[i];
        if(!c.def && !policy.advanceUnknownRadar) { ++unknownObjectives; continue; }
        if((c.mobile?!policy.allowMobile:!policy.allowStatic) || (c.def && !(c.def->GetCategory()&def->GetTargetCategory()))) continue;
        const float distance=pos.SqDistance2D(c.pos);
        if(distance<nearest) { nearest=distance; objective=i; }
    }
    if(report && unknownObjectives>0) ai->LOG("RANGED: unknown radar approach withheld unit=%d candidates=%d",id,unknownObjectives);
    if(objective<0) { if(report) ai->LOG("RANGED: no objective unit=%d",id); Disperse(unit); return; }
    const auto& c=contacts[objective];
    if(!c.def && !policy.advanceUnknownRadar) {
        ai->LOG("[INVARIANT] INV-149 precision movement selected an unidentified radar objective");
        return;
    }
    const float spacing=policy.spacing;
    AIFloat3 back=pos-c.pos; back.Normalize2D();
    const float baseAngle=std::atan2(back.z,back.x);
    float chosenScore=std::numeric_limits<float>::max(); AIFloat3 chosen=pos; bool found=false;
    int terrainRejected=0,slotRejected=0,coverageRejected=0,fireRejected=0;
    for(const auto& w:caps.weapons) {
        if(c.def && !(w.category&c.def->GetCategory())) continue;
        const float range=world.Range(w,pos,c.pos)*policy.rangeFraction;
        for(int k=0;k<17;++k) {
            const int slot=(k+failures)%17;
            const int side=slot==0?0:((slot%2)?(slot+1)/2:-slot/2);
            const float angle=baseAngle+side*std::max(.12f,spacing/std::max(1.f,range));
            AIFloat3 point(c.pos.x+std::cos(angle)*range,0.f,c.pos.z+std::sin(angle)*range);
            CTerrainManager::CorrectPosition(point);
            point.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(point.x,point.z);
            if(!ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(),point)) { ++terrainRejected; continue; }
            if(!world.FreeSlot(id,point,spacing)) { ++slotRejected; continue; }
            if(!world.Safe(pos,point,policy.safetyMargin,true) || world.Danger(point,policy.safetyMargin)>0.f) { ++coverageRejected; continue; }
            if(!world.Trajectory(w,point,c.pos)) { ++fireRejected; continue; }
            if(world.FriendlyLine(w,id,point,c.pos)) { ++fireRejected; continue; }
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
        const float radius = std::max(maxRange, c.hazardRadius + policy.safetyMargin) + policy.spacing;
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
                || !world.FreeSlot(id, point, spacing) || world.Danger(point, policy.safetyMargin) > 0.f
                || !world.Safe(pos, point, policy.safetyMargin, true)
                || !ai->GetTerrainManager()->CanMoveToPos(unit->GetArea(), point)) continue;
            const float score = pos.SqDistance2D(point);
            if (score < chosenScore) { chosenScore = score; chosen = point; found = true; }
        }
        if (report && found) ai->LOG("RANGED: staging unit=%d outside target=%d coverage", id, c.id);
    }
    if(found) {
        world.SetSlot(id,chosen,spacing,def->GetCostM());
        Move(unit,chosen,true);
    } else if(!moving) world.SetSlot(id,pos,spacing,def->GetCostM());
    if(report) ai->LOG("RANGED: sites unit=%d target=%d known=%d found=%d terrain=%d slots=%d coverage=%d fire=%d dest=%.0f,%.0f",id,c.id,c.def!=nullptr,int(found),terrainRejected,slotRejected,coverageRejected,fireRejected,chosen.x,chosen.z);
    if(pos.SqDistance2D(lastPos)>1024.f) { lastPos=pos; lastProgressFrame=frame; failures=0; }
    // A blocked shot/site causes a new safe-position search, never pursuit.
    if(frame-lastProgressFrame>300 && lastReload<frame && target>=0) {
        destination=AIFloat3(-1.f,0.f,-1.f); ++failures; lastProgressFrame=frame;
    }
}
}
