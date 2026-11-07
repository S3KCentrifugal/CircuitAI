/*
 * CommanderGeo.cpp
 *
 * Front-line geothermal work of the commander group (D-481, D-484): fortified geos, the swap of any T2 geo on a front vent, and the Cerberus guard. Split from CommanderGroup.cpp (D-485).
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

namespace circuit {
using springai::AIFloat3;
using BT=IBuilderTask::BuildType;

namespace {
// D-485: seconds the geo scan waits after a scan that found nothing.
constexpr int GEO_IDLE_SECONDS=5;
// D-481: a geo plant stands within this of its vent (elmos).
constexpr float GEO_VENT_RADIUS=64.f;
// D-481: build-site search around each guard structure's ideal spot (elmos).
constexpr float GEO_GUARD_SEARCH=160.f;
// D-481: lane look-ahead (elmos) for a guard geo's forward direction.
constexpr float GEO_LANE_AHEAD=256.f;
}

/*
 * D-481 (the owner's rule): a T2 group constructor upgrades our own T1 geo on
 * the front line to the fortified one (Prude, Cerberus, Rampart); backline
 * geos stay with the economy, which may still build the hazardous advanced
 * geo there. Front line is where the group places porc: inside the group lane
 * band (GroupSiteAllowed) and within group radius plus build reach of the
 * commander to start; a started job is kept while within geoFrontRadius.
 * After a guard geo (Cerberus) finishes, the group puts light lasers ahead of
 * it along the lane and a flak to each side, one structure at a time.
 * Cost: one pass over the map's geo vents (tens) at most once a second, one
 * friendly-unit query per vent in range; guard work is a few vector reads.
 */
// D-484 (the owner's rule): a front-line vent gets the fortified geo whichever
// T2 constructor reaches it first. Every geo task passes CBuilderManager::Enqueue,
// which asks here; a T2 geo (BAR techlevel 2) not in the fortified list, on a
// vent inside the group lane band within geoFrontRadius of the commander,
// becomes the fortified definition of the same faction (name prefix: armageo to
// armgmm, corageo to corbhmth, legageo to legrampart). Every T2 constructor
// that builds the advanced geo also builds the fortified one (BAR buildoptions).
// Cost: per geo task created, one lane query and a list of three.
// D-485: BAR techlevel (absent: 1), read from the engine once per definition;
// GetCustomParams copies the whole parameter map on every call.
int CCommanderController::DefTier(const CCircuitDef* def) const {
    if(!def) return 1;
    const int id=def->GetId();
    if(id<0) return 1;
    if(std::size_t(id)>=defTier.size()) defTier.resize(std::size_t(id)+1,-1);
    if(defTier[id]<0) {
        const auto params=def->GetDef()->GetCustomParams();
        const auto it=params.find("techlevel");
        defTier[id]=static_cast<signed char>(std::clamp(it!=params.end()?utils::string_to_int(it->second):1,1,9));
    }
    return defTier[id];
}
CCircuitDef* CCommanderController::FrontGeoDef(CCircuitDef* def,const AIFloat3& pos) const {
    if(!def || cfg->group.geoFortify<=0 || geoDefs.empty() || !role.frontDuty || !role.frontReady) return def;
    if(std::find(geoDefs.begin(),geoDefs.end(),def->GetId())!=geoDefs.end()) return def;
    if(DefTier(def)<2) return def;  // a T1 geo stays
    auto* anchor=GroupCommander();
    if(!GeoFrontLine(anchor,pos,cfg->group.geoFrontRadius)) return def;
    const std::string name=def->GetDef()->GetName();
    for(int id:geoDefs) {
        auto* fortified=ai->GetCircuitDefSafe(id);
        if(fortified && fortified->IsBuildAllowed() && name.compare(0,3,fortified->GetDef()->GetName(),0,3)==0) {
            ai->LOG("[CommanderGroup] geo_front_swap def=%s to=%s x=%.0f z=%.0f",name.c_str(),fortified->GetDef()->GetName(),pos.x,pos.z);
            return fortified;
        }
    }
    return def;
}
bool CCommanderController::GeoFrontLine(CCircuitUnit* anchor,const AIFloat3& pos,float radius) const {
    return anchor && pos.SqDistance2D(anchor->GetPos(ai->GetLastFrame()))<=SQUARE(radius) && GroupSiteAllowed(anchor,pos);
}
bool CCommanderController::GeoJobAllowed(CCircuitUnit* unit,CCircuitUnit* anchor) const {
    auto* build=dynamic_cast<IBuilderTask*>(geoJob);
    return build && !build->IsDead() && !HealthRetreat(unit) && !EnergyRetreat(unit)
        && GeoFrontLine(anchor,build->GetBuildPos(),cfg->group.geoFrontRadius)
        && ai->GetThreatMap()->GetThreatAt(unit,build->GetBuildPos())<=cfg->front.threat;
}
IUnitTask* CCommanderController::GroupGeoWork(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(cfg->group.geoFortify<=0 || geoDefs.empty() || !unit->GetCircuitDef()->IsBuilder()) return nullptr;
    if(geoJob) return GeoJobAllowed(unit,anchor) && geoJob->CanAssignTo(unit)?geoJob:nullptr;
    const int frame=ai->GetLastFrame();
    if(frame<geoNext || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    geoNext=frame+FRAMES_PER_SEC;
    auto* eco=ai->GetEconomyManager();
    if(eco->GetAvgMetalIncome()<cfg->group.geoIncome) return nullptr;
    CCircuitDef* def=nullptr;
    for(int id:geoDefs) {
        auto* d=ai->GetCircuitDefSafe(id);
        if(d && unit->GetCircuitDef()->CanBuild(d) && d->IsBuildAllowed() && d->IsAvailable(frame)) {def=d;break;}
    }
    if(!def) return nullptr;
    auto* builder=ai->GetBuilderManager();
    auto* terrain=ai->GetTerrainManager();
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    const float start=cfg->group.radius+reach;
    const auto& vents=ai->GetEnergyManager()->GetSpots();
    const AIFloat3 from=unit->GetPos(frame);
    int chosen=-1;
    float best=std::numeric_limits<float>::max();
    for(size_t i=0;i<vents.size();++i) {
        const AIFloat3& pos=vents[i];
        if(!GeoFrontLine(anchor,pos,start) || ai->GetThreatMap()->GetThreatAt(unit,pos)>cfg->front.threat) continue;
        const float sq=from.SqDistance2D(pos);
        if(sq>=best) continue;
        bool busy=false;
        for(auto* task:builder->GetTasks(BT::GEO)) if(task->GetPosition().SqDistance2D(pos)<SQUARE(GEO_VENT_RADIUS)) {busy=true;break;}
        if(busy) continue;
        // Only our own finished plant that the fortified geo out-produces is upgraded.
        bool upgrade=false;
        for(int id:ai->GetCallback()->GetFriendlyUnitIdsIn(pos,GEO_VENT_RADIUS,false)) {
            auto* own=ai->GetTeamUnit(id);
            auto* friendly=ai->GetFriendlyUnit(id);
            if(!friendly || !friendly->GetCircuitDef()->GetDef()->IsNeedGeo()) continue;
            upgrade=own && own->IsFinished() && eco->GetEnergyMake(own->GetCircuitDef())<eco->GetEnergyMake(def);
            break;
        }
        if(!upgrade || !terrain->CanReachAtSafe(unit,pos,reach,unit->GetCircuitDef()->GetPower())) continue;
        best=sq; chosen=int(i);
    }
    if(chosen<0) { geoNext=frame+GEO_IDLE_SECONDS*FRAMES_PER_SEC; return nullptr; }
    geoJob=builder->Enqueue(TaskB::Spot(BT::GEO,IBuilderTask::Priority::HIGH,def,vents[chosen],chosen));
    if(geoJob) ai->LOG("[CommanderGroup] geo_fortify unit=%i def=%s x=%.0f z=%.0f",unit->GetId(),def->GetDef()->GetName(),
        vents[chosen].x,vents[chosen].z);
    return geoJob;
}
IUnitTask* CCommanderController::GroupGeoGuardWork(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(geoGuards.empty() || !unit->GetCircuitDef()->IsBuilder() || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    const int frame=ai->GetLastFrame();
    geoGuards.erase(std::remove_if(geoGuards.begin(),geoGuards.end(),[frame](const GeoGuard& g) {
        return g.task==nullptr && g.until<=frame; }),geoGuards.end());
    const int front=int(cfg->group.geoGuardFront);
    const int items=front+2;
    for(auto& g:geoGuards) {
        if(g.task) {
            if(unit->GetTask()==g.task) return g.task;
            if(!g.task->IsDead() && g.task->CanAssignTo(unit)
                && unit->GetPos(frame).SqDistance2D(g.pos)<=SQUARE(cfg->group.radius+unit->GetCircuitDef()->GetBuildDistance())) return g.task;
            continue;
        }
        while(g.next<items) {
            const bool light=g.next<front;
            const auto& defs=light?geoGuardFrontDefs:geoGuardSideDefs;
            CCircuitDef* def=nullptr;
            for(int id:defs) {
                auto* d=ai->GetCircuitDefSafe(id);
                if(d && d->IsBuildAllowed() && d->IsAvailable(frame)) { if(unit->GetCircuitDef()->CanBuild(d)) {def=d;break;} }
            }
            bool someone=false;  // another group builder may build this item: leave it
            if(!def) {
                for(int id:{groupUnit,groupMembers[0],groupMembers[1],groupMembers[2]}) {
                    auto* other=ai->GetTeamUnit(id);
                    if(!other || other==unit) continue;
                    for(int d:defs) if(auto* dd=ai->GetCircuitDefSafe(d); dd && other->GetCircuitDef()->CanBuild(dd)) someone=true;
                }
                if(auto* commander=ai->GetTeamUnit(groupAnchorId); commander && commander!=unit)
                    for(int d:defs) if(auto* dd=ai->GetCircuitDefSafe(d); dd && commander->GetCircuitDef()->CanBuild(dd)) someone=true;
                if(someone) break;
                ++g.next; continue;  // nobody in the group can build it
            }
            // Front: ahead along the lane, spaced across; sides: across the lane.
            const float across=light?(float(g.next)-.5f*float(front-1))*cfg->group.geoGuardSpacing
                :(g.next==front?-1.f:1.f)*cfg->group.geoGuardSideOffset;
            const float ahead=light?cfg->group.geoGuardFrontOffset:0.f;
            AIFloat3 site(g.pos.x+g.fx*ahead-g.fz*across,g.pos.y,g.pos.z+g.fz*ahead+g.fx*across);
            if(OnMap(site)) site=ai->GetTerrainManager()->FindBuildSite(def,site,GEO_GUARD_SEARCH,0);
            if(!OnMap(site)) { ++g.next; continue; }
            g.task=ai->GetBuilderManager()->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,def,site,0.f,true,
                int(cfg->group.geoGuardSeconds*FRAMES_PER_SEC)));
            ++g.next;
            if(!g.task) continue;
            ai->LOG("[CommanderGroup] geo_guard unit=%i def=%s x=%.0f z=%.0f",unit->GetId(),def->GetDef()->GetName(),site.x,site.z);
            return g.task;
        }
    }
    geoGuards.erase(std::remove_if(geoGuards.begin(),geoGuards.end(),[items](const GeoGuard& g) {
        return g.task==nullptr && g.next>=items; }),geoGuards.end());
    return nullptr;
}
// D-481: after a guard geo (Cerberus) finishes, the light lasers go ahead of it
// along the lane and a flak to each side (GroupGeoGuardWork).
void CCommanderController::PlanGeoGuard(const CCircuitDef* def,const AIFloat3& pos) {
    if(std::find(geoGuardDefs.begin(),geoGuardDefs.end(),def->GetId())==geoGuardDefs.end()) return;
    GeoGuard guard;
    guard.pos=pos;
    // Forward: along the front lane at the geo; else base -> geo.
    auto* battle=ai->GetBattle();
    commander::Point fwd{};
    if(battle->GetFrontLaneLength()>0.f) {
        const float progress=battle->GetFrontLaneProgress(guard.pos);
        const auto ahead=battle->GetFrontLanePoint(std::min(progress+GEO_LANE_AHEAD,battle->GetFrontLaneLength()));
        if(OnMap(ahead)) fwd=commander::Normal(commander::Point{ahead.x-guard.pos.x,ahead.z-guard.pos.z});
    }
    const auto base=ai->GetSetupManager()->GetBasePos();
    if(commander::Length(fwd)<.1f) fwd=commander::Normal(commander::Point{guard.pos.x-base.x,guard.pos.z-base.z});
    if(commander::Length(fwd)<.1f) fwd={0,1};
    guard.fx=fwd.x; guard.fz=fwd.z;
    guard.until=ai->GetLastFrame()+int(cfg->group.geoGuardSeconds*FRAMES_PER_SEC);
    geoGuards.push_back(guard);
    ai->LOG("[CommanderGroup] geo_guard_plan def=%s x=%.0f z=%.0f",def->GetDef()->GetName(),guard.pos.x,guard.pos.z);
}

} // namespace circuit
