/*
 * CommanderArtilleryT1.cpp
 *
 * D-495: when the FRONT commander group builds T1 static artillery, and where.
 * The profile's construction veto (D-142) stays on these definitions for every
 * other builder and role; this gate is the one caller allowed past it
 * (CBuilderManager::EnqueueVetoed).
 *
 * A gun goes up only for a target (control/kernel/ArtilleryT1Gate.h): an enemy
 * T1 gun within artillery_t1_counter of one of our structures, or a cluster of
 * enemy defences worth the gun that out-ranges our mobile artillery. However
 * close the target is to our structures, the gun stands where it reaches the
 * target, outside every known enemy weapon (owner, 2026-11-07); against an
 * enemy gun, only from where ours reaches at least as far back (Duel).
 *
 * Cost: one plan per artilleryT1EvalSeconds while the cheap gates pass (no T2
 * seat, a T2 lab started, under the cap): one combat snapshot query round the
 * commander O(cells + K), one friendly-unit engine query per seen enemy T1 gun,
 * and at most SITE_RINGS x SITE_ANGLES site tests of O(K) each per target.
 */

#include "control/unit/commander/CommanderController.h"
#include "control/unit/artillery/ArtilleryController.h"
#include "control/service/CombatSnapshot.h"
#include "module/BuilderManager.h"
#include "module/FactoryManager.h"
#include "terrain/TerrainManager.h"
#include "setup/SetupManager.h"
#include "task/builder/BuilderTask.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "unit/ally/AllyTeam.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>
#include <cmath>

namespace circuit {
using springai::AIFloat3;
namespace t1=artillery_t1;

namespace {
// Site candidates round the target: rings at these shares of the gun's reach,
// each at these angles (degrees) off the line from the target to the commander.
constexpr int SITE_RINGS=3;
constexpr float SITE_RING[SITE_RINGS]={1.f,.85f,.7f};
constexpr int SITE_ANGLES=7;
constexpr float SITE_ANGLE[SITE_ANGLES]={0.f,15.f,-15.f,30.f,-30.f,45.f,-45.f};
constexpr float DEGREES=3.14159265f/180.f;
// Enemy weapons up to this range are read from the snapshot round the
// commander for the cover test; longer ones come from its strategic contacts.
constexpr float COVER_QUERY_RANGE=1600.f;
const char* CaseName(t1::Case c) { return c==t1::Case::Counter?"counter":c==t1::Case::Siege?"siege":"none"; }
commander::Point P(const AIFloat3& p) { return {p.x,p.z}; }
int FacingTo(commander::Point from,commander::Point to) {
    const auto d=to-from;  // engine facing: 0 +z, 1 +x, 2 -z, 3 -x
    return std::abs(d.x)>std::abs(d.z)?(d.x>0?1:3):(d.z>0?0:2);
}
commander::Point FacingAxis(int facing) {
    return facing==1?commander::Point{1,0}:facing==3?commander::Point{-1,0}:facing==2?commander::Point{0,-1}:commander::Point{0,1};
}
}

bool CCommanderController::IsArtilleryT1Def(const CCircuitDef* def) const {
    return def && std::find(artilleryT1Defs.begin(),artilleryT1Defs.end(),def->GetId())!=artilleryT1Defs.end();
}

// The first T2 lab stands or is ordered: a T1 gun never delays it.
bool CCommanderController::T2LabStarted() const {
    auto* factory=ai->GetFactoryManager();
    if(factory->GetNoT1FacCount()>0) return true;
    for(auto* task:ai->GetBuilderManager()->GetTasks(IBuilderTask::BuildType::FACTORY))
        if(task->GetBuildDef() && !factory->IsT1Factory(task->GetBuildDef())) return true;
    return false;
}

// A site in the gun's reach of the target, outside every known enemy weapon,
// inside the group's radius of the commander and free to reserve. The open
// block of this definition is kept when it still qualifies (no churn).
bool CCommanderController::ArtilleryT1Site(CCircuitUnit* anchor,CCircuitDef* def,const t1::Contact& target,T1Plan& plan) const {
    const int frame=ai->GetLastFrame();
    const auto center=anchor->GetPos(frame);
    const auto& g=cfg->group;
    const float range=def->GetMaxRange();
    const float size=float(std::max(def->GetDef()->GetXSize(),def->GetDef()->GetZSize()))*SQUARE_SIZE;
    const float reachBuild=anchor->GetCircuitDef()->GetBuildDistance();
    const auto ok=[&](commander::Point p,float y) {
        return t1::Reaches(p,y,target,range,g.artilleryT1HeightGain,g.artilleryT1Margin)
            && !t1::Covered(p,y,t1Enemies,g.artilleryT1HeightGain,g.artilleryT1Margin,
                t1::DuelIgnore(plan.why,y,range,target,g.artilleryT1HeightGain))
            && commander::GroupJobInRange(t1::SqDist(p,P(center)),g.radius,reachBuild,false);
    };
    const auto block=tacticalBlocks.find(def->GetId());
    if(block!=tacticalBlocks.end() && block->second.group>0 && ok(P(block->second.centre),block->second.centre.y)) {
        plan.site=block->second.centre;
        plan.facing=FacingTo(P(plan.site),target.pos);
        return true;
    }
    commander::Point toUs=commander::Normal(P(center)-target.pos);
    if(commander::Length(toUs)<.1f) toUs=commander::Normal(P(ai->GetSetupManager()->GetBasePos())-target.pos);
    if(commander::Length(toUs)<.1f) toUs={0,1};
    auto* terrain=ai->GetTerrainManager();
    for(int r=0;r<SITE_RINGS;++r) {
        const float distance=std::max(0.f,range-g.artilleryT1Margin)*SITE_RING[r];
        for(int a=0;a<SITE_ANGLES;++a) {
            const float c=std::cos(SITE_ANGLE[a]*DEGREES),s=std::sin(SITE_ANGLE[a]*DEGREES);
            const commander::Point dir{toUs.x*c-toUs.z*s,toUs.x*s+toUs.z*c};
            const commander::Point p=target.pos+dir*distance;
            AIFloat3 site{p.x,0.f,p.z};
            if(!OnMap(site)) continue;
            site.y=ai->GetMap()->GetElevationAt(site.x,site.z);
            if(!ok(p,site.y)) continue;
            const int facing=FacingTo(p,target.pos);
            if(!terrain->CanReserveArea(site,facing,size*.5f,size*.5f)) continue;
            plan.site=site;
            plan.facing=facing;
            return true;
        }
    }
    return false;
}

const CCommanderController::T1Plan* CCommanderController::ArtilleryT1Plan(CCircuitUnit* unit) const {
    const int frame=ai->GetLastFrame();
    const auto& g=cfg->group;
    if(frame<t1PlanFrame+int(g.artilleryT1EvalSeconds*FRAMES_PER_SEC))
        return t1Plan.defId>=0?&t1Plan:nullptr;
    t1PlanFrame=frame;
    const T1Plan previous=t1Plan;
    t1Plan=T1Plan{};
    auto* anchor=GroupCommander();
    // Cheap gates first: a T2 seat builds T2 artillery instead, the first T2
    // lab comes before any T1 gun, and the per-AI cap.
    if(!anchor || GroupT2Count()>0 || !T2LabStarted()) return nullptr;
    int ours=0;
    for(int id:artilleryT1Defs) if(auto* d=ai->GetCircuitDefSafe(id)) ours+=d->GetCount();
    if(!t1::UnderCap(ours,int(g.artilleryT1Max))) return nullptr;
    CCircuitDef* def=nullptr;
    for(int id:artilleryT1Defs) {
        auto* d=ai->GetCircuitDefSafe(id);
        if(d && unit->GetCircuitDef()->CanBuild(d) && d->IsCapAvailable(frame)) { def=d; break; }
    }
    if(!def) return nullptr;
    const bool counterAllowed=std::find(artilleryT1CounterDefs.begin(),artilleryT1CounterDefs.end(),def->GetId())
        !=artilleryT1CounterDefs.end();
    // Known enemy structures round the commander: targets within the gun's
    // reach of a site the group can build at, and every weapon that could
    // cover such a site.
    const auto center=anchor->GetPos(frame);
    const float range=def->GetMaxRange();
    const float query=g.radius+anchor->GetCircuitDef()->GetBuildDistance()+std::max(range,COVER_QUERY_RANGE);
    const auto& snapshot=ai->GetAllyTeam()->GetCombatSnapshot();
    snapshot.Want(frame);
    const int seenSince=frame-int(g.artilleryT1VisionSeconds*FRAMES_PER_SEC);
    t1Enemies.clear();
    const auto add=[&](const CCombatSnapshot::Entry& e) {
        if(e.defId<0) return;
        const CCircuitDef* d=ai->GetCircuitDefSafe(e.defId);
        if(!d || d->IsMobile()) return;
        t1::Contact c;
        c.id=e.id; c.pos=e.pos; c.elevation=e.elevation; c.costM=d->GetCostM();
        c.range=d->IsAttacker()?d->GetMaxRange():0.f;
        c.t1Gun=IsArtilleryT1Def(d);
        c.seen=e.los || e.radar || e.lastObserved>=seenSince;
        t1Enemies.push_back(c);
    };
    snapshot.Query(P(center),query,[&](const CCombatSnapshot::Entry& e) {
        if(t1::SqDist(e.pos,P(center))<=query*query) add(e);
    });
    for(const auto& e:snapshot.StrategicContacts()) add(e);
    if(t1Enemies.empty()) return nullptr;
    auto* census=ai->GetArtilleryCensus();
    for(const auto pass:{t1::Case::Counter,t1::Case::Siege}) {
        for(const auto& c:t1Enemies) {
            bool structureNear=false;
            if(pass==t1::Case::Counter) {
                if(!c.t1Gun || !c.seen || !counterAllowed) continue;
                for(int id:ai->GetCallback()->GetFriendlyUnitIdsIn(AIFloat3(c.pos.x,c.elevation,c.pos.z),g.artilleryT1Counter,false)) {
                    const CCircuitDef* d=nullptr;
                    if(auto* own=ai->GetTeamUnit(id)) d=own->GetCircuitDef();
                    else if(auto* ally=ai->GetFriendlyUnit(id)) d=ally->GetCircuitDef();
                    if(d && !d->IsMobile()) { structureNear=true; break; }
                }
            }
            const auto why=t1::Justify(c,t1Enemies,structureNear,counterAllowed,center.y,g.artilleryT1HeightGain,
                g.artilleryT1MobileRange,def->GetCostM(),g.artilleryT1Value,g.artilleryT1Cluster);
            if(why!=pass) continue;
            // One gun per target: none of our artillery already reaches it.
            if(census && census->CountNear(AIFloat3(c.pos.x,c.elevation,c.pos.z),range)>0) continue;
            T1Plan plan;
            plan.defId=def->GetId(); plan.why=why; plan.target=c;
            if(!ArtilleryT1Site(anchor,def,c,plan)) continue;
            t1Plan=plan;
            if(previous.target.id!=plan.target.id || previous.site.SqDistance2D(plan.site)>1.f)
                ai->LOG("[CommanderGroup] artillery_t1 plan def=%s case=%s target=%i at=%.0f,%.0f site=%.0f,%.0f distance=%.0f team=%i",
                    def->GetDef()->GetName(),CaseName(why),c.id,c.pos.x,c.pos.z,plan.site.x,plan.site.z,
                    std::sqrt(t1::SqDist(P(plan.site),c.pos)),ai->GetTeamId());
            return &t1Plan;
        }
    }
    return nullptr;
}

// The planned site as a one-slot block; the slot as reserved must still reach
// the target from outside every known weapon, else nothing is reserved.
bool CCommanderController::ReserveArtilleryT1Site(CCircuitDef* def,TacticalBlock& block) {
    if(t1Plan.defId!=def->GetId()) return false;
    const auto& g=cfg->group;
    auto* terrain=ai->GetTerrainManager();
    const float size=float(std::max(def->GetDef()->GetXSize(),def->GetDef()->GetZSize()))*SQUARE_SIZE;
    const auto front=t1Plan.site+AIFloat3(FacingAxis(t1Plan.facing).x*size*.5f,0.f,FacingAxis(t1Plan.facing).z*size*.5f);
    const int group=terrain->ReserveGrid(def,front,t1Plan.facing,1,1,0);
    if(group<=0) {
        ai->LOG("[CommanderGroup] artillery_t1 site refused def=%s at=%.0f,%.0f",def->GetDef()->GetName(),t1Plan.site.x,t1Plan.site.z);
        t1PlanFrame=std::numeric_limits<int>::min()/2;  // replan at the next ask
        return false;
    }
    const int slot=terrain->NextSlotAny(group,t1Plan.site);
    AIFloat3 at=slot>=0?terrain->GetReservationPos(slot):AIFloat3(-1,0,-1);
    if(slot>=0) at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
    if(slot<0 || !t1::Reaches(P(at),at.y,t1Plan.target,def->GetMaxRange(),g.artilleryT1HeightGain,g.artilleryT1Margin)
        || t1::Covered(P(at),at.y,t1Enemies,g.artilleryT1HeightGain,g.artilleryT1Margin,
            t1::DuelIgnore(t1Plan.why,at.y,def->GetMaxRange(),t1Plan.target,g.artilleryT1HeightGain))) {
        terrain->ReleaseGroup(group);
        ai->LOG("[CommanderGroup] artillery_t1 slot out of reach def=%s at=%.0f,%.0f",def->GetDef()->GetName(),at.x,at.z);
        t1PlanFrame=std::numeric_limits<int>::min()/2;
        return false;
    }
    block.group=group;
    block.centre=at;
    block.radius=size;
    ai->LOG("[CommanderGroup] artillery_t1 site group=%i def=%s case=%s target=%i at=%.0f,%.0f distance=%.0f",
        group,def->GetDef()->GetName(),CaseName(t1Plan.why),t1Plan.target.id,at.x,at.z,
        std::sqrt(t1::SqDist(P(at),t1Plan.target.pos)));
    return true;
}

// INV-268: once the live T1 job has a frame, the frame reaches the target it
// was ordered for (the enemy structure does not move). Checked once per job.
void CCommanderController::CheckArtilleryT1Job(int frame) {
    if(!t1Job || t1Job!=tacticalJob || t1JobChecked) return;
    auto* build=dynamic_cast<IBuilderTask*>(tacticalJob);
    if(!build || !build->GetTarget()) return;
    t1JobChecked=true;
    AIFloat3 at=build->GetTarget()->GetPos(frame);
    at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
    if(!t1::Reaches(P(at),at.y,t1JobTarget,t1JobRange,cfg->group.artilleryT1HeightGain,0.f))
        ai->LOG("[INVARIANT] INV-268 T1 artillery frame %i at %.0f,%.0f does not reach its target %i at %.0f,%.0f (D-495)",
            build->GetTarget()->GetId(),at.x,at.z,t1JobTarget.id,t1JobTarget.pos.x,t1JobTarget.pos.z);
}

} // namespace circuit
