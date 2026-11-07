/*
 * CommanderGeo.cpp
 *
 * Front-line geothermal work of the commander group (D-481, D-484, D-488): fortified geos on forward vents, the swap of any T2 geo there, and the Cerberus guard. Split from CommanderGroup.cpp (D-485).
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
// D-481: times a cancelled guard item is ordered again.
constexpr int GEO_GUARD_RETRIES=1;
// D-481: seconds a refused vent is not ordered again.
constexpr int GEO_REFUSED_SECONDS=30;
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
// D-488 (the owner's rule): front line is now a forward vent, one whose fortified
// geo reaches mid map or beyond (script ForwardGeo sets the flags, FRONT and AIR);
// the group still only works vents within its window of the commander.
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
CCircuitDef* CCommanderController::FrontGeoDef(CCircuitDef* def,AIFloat3& pos,int& facing) const {
    if(!def || cfg->group.geoFortify<=0 || geoDefs.empty()) return def;
    // D-488: forward vents (script ForwardGeo, FRONT and AIR) replace the D-484
    // commander window: a fortified geo there reaches mid map or beyond.
    auto* eco=ai->GetEconomyManager();
    const int spot=eco->GeoSpotAt(pos);
    if(!eco->IsGeoForward(spot)) return def;
    const auto fortifiedDef=[this](const CCircuitDef* d) {
        return d && std::find(geoDefs.begin(),geoDefs.end(),d->GetId())!=geoDefs.end();
    };
    // A fortified geo already stands: nothing else is ordered there. The economy
    // would stack an advanced geo (more energy) on it, and the swap below would
    // turn that into a second fortified geo.
    const AIFloat3& vent=ai->GetEnergyManager()->GetSpots()[spot];
    for(int id:ai->GetCallback()->GetFriendlyUnitIdsIn(vent,GEO_VENT_RADIUS,false))
        if(auto* plant=ai->GetFriendlyUnit(id); plant && fortifiedDef(plant->GetCircuitDef())) return nullptr;
    if(fortifiedDef(def)) return def;
    if(DefTier(def)<2) return def;  // a T1 geo may stand until ForwardGeo replaces it
    // A vent where swapped orders kept ending unbuilt keeps the asked geo
    // (Forge, b41: one Armada vent swapped 41 times, every Prude order lost).
    for(const auto& site:frontGeoSites)
        if(site.pos.SqDistance2D(vent)<SQUARE(GEO_VENT_RADIUS) && site.fails>=FRONT_GEO_FAILS) return def;
    const std::string name=def->GetDef()->GetName();
    for(int id:geoDefs) {
        auto* fortified=ai->GetCircuitDefSafe(id);
        if(!fortified || !fortified->IsBuildAllowed() || name.compare(0,3,fortified->GetDef()->GetName(),0,3)!=0) continue;
        // D-488: stacking needs the yardmaps aligned, so the standing plant's own
        // position is tried before the vent (FindGeoSite); the order moves there.
        AIFloat3 site;
        int fits=UNIT_NO_FACING;
        if(!eco->FindGeoSite(fortified,spot,site,fits)) {
            // No advanced geo on a forward vent: ForwardGeo reclaims the plant
            // below and builds the fortified one instead.
            ai->LOG("[CommanderGroup] geo_front_hold def=%s x=%.0f z=%.0f",name.c_str(),vent.x,vent.z);
            return nullptr;
        }
        pos=site;
        facing=fits;
        ai->LOG("[CommanderGroup] geo_front_swap def=%s to=%s x=%.0f z=%.0f",name.c_str(),fortified->GetDef()->GetName(),site.x,site.z);
        if(std::none_of(frontGeoSites.begin(),frontGeoSites.end(),[&vent](const FrontGeoSite& p){return p.pos.SqDistance2D(vent)<SQUARE(GEO_VENT_RADIUS);}))
            frontGeoSites.push_back({vent,0});  // vents: tens at most
        return fortified;
    }
    return def;
}
bool CCommanderController::GeoFrontLine(CCircuitUnit* anchor,const AIFloat3& pos,float radius) const {
    return anchor && pos.SqDistance2D(anchor->GetPos(ai->GetLastFrame()))<=SQUARE(radius) && GroupSiteAllowed(anchor,pos);
}
bool CCommanderController::GeoJobAllowed(CCircuitUnit* unit,CCircuitUnit* anchor) const {
    return geoJob && !geoJob->IsDead() && !HealthRetreat(unit) && !EnergyRetreat(unit)
        && GeoFrontLine(anchor,geoJobPos,cfg->group.geoFrontRadius)
        && ai->GetThreatMap()->GetThreatAt(unit,geoJobPos)<=cfg->front.threat;
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
    const float start=cfg->group.radius+unit->GetCircuitDef()->GetBuildDistance();
    const auto& vents=ai->GetEnergyManager()->GetSpots();
    if(geoVentSkip.size()!=vents.size()) geoVentSkip.assign(vents.size(),0);
    const AIFloat3 from=unit->GetPos(frame);
    // D-488: forward vents only (script ForwardGeo). An empty vent, our T1 or
    // advanced geo: the fortified geo goes on top where it stacks, else the plant
    // is reclaimed first (geoReclaim) when the economy can spare its energy.
    int chosen=-1,chosenFacing=UNIT_NO_FACING;
    AIFloat3 chosenSite;
    CCircuitUnit* chosenPlant=nullptr;
    float best=std::numeric_limits<float>::max();
    for(size_t i=0;i<vents.size();++i) {
        const AIFloat3& pos=vents[i];
        if(!eco->IsGeoForward(int(i)) || frame<geoVentSkip[i] || !GeoFrontLine(anchor,pos,start)) continue;
        const float sq=from.SqDistance2D(pos);
        if(sq>=best) continue;
        AIFloat3 site;
        int fits=UNIT_NO_FACING;
        const auto state=eco->CheckGeoFortify(unit,def,int(i),cfg->front.threat,site,fits);
        CCircuitUnit* plant=nullptr;
        if(state==CEconomyManager::GeoFortify::REFUSED_PLANT && cfg->group.geoReclaim>0) {
            plant=eco->OwnGeoAt(int(i));
            if(plant && !eco->CanSpareGeo(plant)) plant=nullptr;
        }
        if(state!=CEconomyManager::GeoFortify::READY && !plant) {
            if(state==CEconomyManager::GeoFortify::REFUSED || state==CEconomyManager::GeoFortify::REFUSED_PLANT) {
                geoVentSkip[i]=frame+GEO_REFUSED_SECONDS*FRAMES_PER_SEC;
                ai->LOG("[CommanderGroup] geo_refused def=%s x=%.0f z=%.0f plant=%i",def->GetDef()->GetName(),pos.x,pos.z,
                    int(state==CEconomyManager::GeoFortify::REFUSED_PLANT));
            }
            continue;
        }
        best=sq; chosen=int(i); chosenSite=site; chosenFacing=fits; chosenPlant=plant;
    }
    if(chosen<0) { geoNext=frame+GEO_IDLE_SECONDS*FRAMES_PER_SEC; return nullptr; }
    geoJobPos=vents[chosen];
    if(chosenPlant) {
        geoJob=builder->Enqueue(TaskB::Reclaim(IBuilderTask::Priority::HIGH,chosenPlant,int(cfg->group.geoGuardSeconds*FRAMES_PER_SEC)));
        if(geoJob) ai->LOG("[CommanderGroup] geo_reclaim unit=%i plant=%s x=%.0f z=%.0f",unit->GetId(),
            chosenPlant->GetCircuitDef()->GetDef()->GetName(),geoJobPos.x,geoJobPos.z);
        return geoJob;
    }
    auto* geoTask=builder->Enqueue(TaskB::Spot(BT::GEO,IBuilderTask::Priority::HIGH,def,chosenSite,chosen));
    if(geoTask) geoTask->SetFacing(chosenFacing);
    geoJob=geoTask;
    if(geoJob) ai->LOG("[CommanderGroup] geo_fortify unit=%i def=%s x=%.0f z=%.0f",unit->GetId(),def->GetDef()->GetName(),
        chosenSite.x,chosenSite.z);
    return geoJob;
}
IUnitTask* CCommanderController::GroupGeoGuardWork(CCircuitUnit* unit,CCircuitUnit* anchor) {
    if(geoGuards.empty() || !unit->GetCircuitDef()->IsBuilder() || HealthRetreat(unit) || EnergyRetreat(unit)) return nullptr;
    const int frame=ai->GetLastFrame();
    const int front=std::clamp(int(cfg->group.geoGuardFront),0,MAX_GEO_GUARD_ITEMS-2);
    const int items=front+2;
    const auto live=[](const GeoGuard& g) {
        return std::any_of(g.tasks.begin(),g.tasks.end(),[](const IUnitTask* t){return t!=nullptr;});
    };
    // A plan ends when every item is done or given up, or at its deadline with no live task.
    geoGuards.erase(std::remove_if(geoGuards.begin(),geoGuards.end(),[&](const GeoGuard& g) {
        if(live(g)) return false;
        if(g.until<=frame) return true;
        for(int k=0;k<items;++k) if(g.state[k]!=2) return false;
        return true; }),geoGuards.end());
    const float reach=cfg->group.radius+unit->GetCircuitDef()->GetBuildDistance();
    // The group builders that may take an item this unit cannot build.
    const auto groupCanBuild=[&](const std::vector<int>& defs) {
        for(int id:{groupAnchorId,groupUnit,groupMembers[0],groupMembers[1],groupMembers[2]}) {
            auto* other=id>=0?ai->GetTeamUnit(id):nullptr;
            if(!other || other==unit) continue;
            for(int d:defs) if(auto* def=ai->GetCircuitDefSafe(d); def && other->GetCircuitDef()->CanBuild(def)) return true;
        }
        return false;
    };
    for(auto& g:geoGuards) {
        const bool inReach=unit->GetPos(frame).SqDistance2D(g.pos)<=SQUARE(reach);
        for(int k=0;k<items;++k) {
            if(g.state[k]==1) {
                auto* task=g.tasks[k];
                if(!task) continue;
                if(unit->GetTask()==task) return task;
                if(inReach && !task->IsDead() && task->CanAssignTo(unit)) return task;
                continue;
            }
            if(g.state[k]!=0) continue;
            const bool light=k<front;
            const auto& defs=light?geoGuardFrontDefs:geoGuardSideDefs;
            CCircuitDef* def=nullptr;
            for(int id:defs) {
                auto* d=ai->GetCircuitDefSafe(id);
                if(d && d->IsBuildAllowed() && d->IsAvailable(frame) && unit->GetCircuitDef()->CanBuild(d)) {def=d;break;}
            }
            if(!def) {
                if(!groupCanBuild(defs)) g.state[k]=2;  // nobody in the group can build it
                continue;                                 // another builder will
            }
            // Started from anywhere: the group may have followed the commander away from
            // the geo by the time it finishes (commander-group-geo, b39); joining needs reach.
            // Front: ahead along the lane, spaced across; sides: across the lane.
            const float across=light?(float(k)-.5f*float(front-1))*cfg->group.geoGuardSpacing
                :(k==front?-1.f:1.f)*cfg->group.geoGuardSideOffset;
            const float ahead=light?cfg->group.geoGuardFrontOffset:0.f;
            AIFloat3 site(g.pos.x+g.fx*ahead-g.fz*across,g.pos.y,g.pos.z+g.fz*ahead+g.fx*across);
            if(OnMap(site)) site=ai->GetTerrainManager()->FindBuildSite(def,site,GEO_GUARD_SEARCH,0);
            if(!OnMap(site)) { g.state[k]=2; continue; }
            auto* task=ai->GetBuilderManager()->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,def,site,0.f,true,
                int(cfg->group.geoGuardSeconds*FRAMES_PER_SEC)));
            if(!task) { g.state[k]=2; continue; }
            g.tasks[k]=task; g.state[k]=1;
            ai->LOG("[CommanderGroup] geo_guard unit=%i def=%s item=%i x=%.0f z=%.0f",unit->GetId(),def->GetDef()->GetName(),k,site.x,site.z);
            return task;
        }
    }
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
