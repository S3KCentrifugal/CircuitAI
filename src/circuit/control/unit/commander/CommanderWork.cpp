#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/FactoryManager.h"
#include "task/builder/BuilderTask.h"
#include "task/builder/RepairTask.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "setup/SetupManager.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "map/ThreatMap.h"
#include "terrain/TerrainManager.h"
#include "terrain/BattleAnalysis.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include <algorithm>
#include <functional>
#include <limits>

#include "Feature.h"
#include "FeatureDef.h"

namespace circuit {
using springai::AIFloat3;
using commander::Point;
using BT=IBuilderTask::BuildType;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }
static AIFloat3 F(Point p,float y=0) { return {p.x,y,p.z}; }

// D-299: the FRONT commander's work ladder. The script (CommanderFront::Work)
// owns the order and the definitions; each kind here is one bounded,
// commander-local selection. Called only from the builder's task offer for an
// idle commander (not per frame). Costs per offer, K = units/features inside
// the work radius (the commander's LOS, ~450 elmos): repair O(K log K) plus at
// most four reach/clearance checks; reclaim O(K) feature wrappers and a fixed four-candidate shortlist; radar O(N)
// over the ally snapshot at most once a second per commander (cached); line
// O(K + T) over the defence tasks. No new recurring cadence, no orders here:
// the returned task is assigned by the builder manager like any other offer.

float CCommanderController::WorkRadius(CCircuitUnit* unit) const {
    return cfg->work.radius>0 ? cfg->work.radius : std::max(200.f,unit->GetCircuitDef()->GetLosRadius());
}

bool CCommanderController::LineWorking(CCircuitUnit* unit,const State& s,IUnitTask* current,int frame) const {
    if(!LadderActive() || current==nullptr) return false;
    // The builder offers the next task on its own update after a Handover.
    if(current->GetType()==IUnitTask::Type::IDLE) return frame<s.work.lineYield+2*FRAMES_PER_SEC;
    auto* build=dynamic_cast<IBuilderTask*>(current);
    if(build==nullptr || build->IsDead() || build->IsExternalControlled() || build->IsEnemyReclaim()
        || build->GetManager()!=ai->GetBuilderManager()) return false;
    const float slack=unit->GetCircuitDef()->GetBuildDistance()+32.f;
    // A site outside (offered earlier, moved by native placement, or a
    // perimeter that shrank when its porc died) is not line work: the
    // controller takes the commander back. INV-218 is checked by Fallback on
    // the commander's own position while it works.
    return s.fallback.boundary.Contains(P(build->GetPosition()),slack);
}

IUnitTask* CCommanderController::LadderWork(CCircuitUnit* unit,State& s,int kind,CCircuitDef* buildDef,float radius,int frame) {
    if(!role.work) return nullptr;
    const AIFloat3 pos=unit->GetPos(frame);
    const bool holding=FallbackActive(s,frame);
    const float work=radius>0?radius:WorkRadius(unit);
    switch(kind) {
        case WORK_LINE: return LineWork(unit,s,buildDef,frame);
        case WORK_REPAIR_DEFENCE: return RepairWork(unit,s,true,work,frame);
        case WORK_REPAIR_UNITS: return RepairWork(unit,s,false,work,frame);
        case WORK_REPAIR_COMBAT: return RepairWork(unit,s,false,std::max(1.f,unit->GetCircuitDef()->GetBuildDistance()-32.f),frame,true);
        case WORK_RECLAIM: return ReclaimWork(unit,s,work,frame);
        case WORK_RADAR: return RadarWork(unit,s,buildDef,frame);
        case WORK_MEX: {
            // Any open metal spot in the work radius (LOS), wherever the
            // commander stands. EnqueueMexWithin owns spot claims, allied
            // extractors, safe reach and idempotent re-offers. Under a held
            // fallback the disc shrinks to what fits inside the perimeter, so
            // no spot outside it is ever claimed.
            float area=work;
            if(holding) {
                const float inside=s.fallback.boundary.radius+unit->GetCircuitDef()->GetBuildDistance()
                    -commander::Length(P(pos)-s.fallback.boundary.anchor);
                area=std::min(area,inside);
                if(area<=0) return nullptr;
            }
            return ai->GetEconomyManager()->EnqueueMexWithin(unit,pos,area,0,true);
        }
        case WORK_TERRITORY_LINE: return holding?nullptr:defenseSettings.enabled>0?GroupWork(unit):TerritoryLineWork(unit,s,buildDef,frame);
        case WORK_MEX_DEFENCE: {
            if(holding) return nullptr;
            if(cfg->front.mexMinIncome>0) {
                auto* task=ExpansionMexWork(unit,s,buildDef,frame);
                return task && GroupActive(unit)?TrackGroupJob(task):task;
            }
            return defenseSettings.enabled>0?GroupWork(unit):MexDefenceWork(unit,s,buildDef,frame);
        }
        case WORK_MEX_LANE: return holding?nullptr:LaneMexWork(unit,s,buildDef,frame);
        case WORK_TIMED: {
            // First timed_until seconds of the game: one of buildDef every
            // timed_interval after the commander first reaches the front.
            if(holding || buildDef==nullptr || !unit->GetCircuitDef()->CanBuild(buildDef) || s.front.arrived<0
                || frame>=int(cfg->work.timedUntil*FRAMES_PER_SEC)) return nullptr;
            const auto anchor=FrontPosition(unit,s,frame);
            if(anchor.x<0 || pos.SqDistance2D(anchor)>cfg->front.radius*cfg->front.radius*.25f
                || ai->GetThreatMap()->GetThreatAt(unit,pos)>cfg->front.threat) return nullptr;
            auto next=s.work.timedNext.try_emplace(buildDef->GetId(),s.front.arrived).first;
            if(frame<next->second || ai->GetEconomyManager()->GetMetalCur()<buildDef->GetCostM()*.5f) return nullptr;
            auto* task=ai->GetBuilderManager()->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::NORMAL,
                buildDef,anchor,128.f,true,30*FRAMES_PER_SEC));
            if(task) next->second=frame+int(cfg->work.timedInterval*FRAMES_PER_SEC);
            return task;
        }
        case WORK_FACTORY: {
            // A plant guard drifts with the plant's output, too far for the
            // fallback perimeter (INV-218, played): construction only there.
            if(holding) return nullptr;
            const auto anchor=FrontPosition(unit,s,frame);
            if(anchor.x<0 || pos.SqDistance2D(anchor)>cfg->front.radius*cfg->front.radius*.25f) return nullptr;
            return AssistWork(unit,s,anchor,std::clamp(work,64.f,cfg->front.radius),true,frame);
        }
        case WORK_BASE: {
            // "Fell back to main base": a fallback or its line hold, or no
            // reachable safe front. Assist base construction, then factories.
            const AIFloat3 base=ai->GetSetupManager()->GetBasePos();
            const bool fellBack=holding || frame<s.work.lineUntil || FrontPosition(unit,s,frame).x<0;
            if(!fellBack || pos.SqDistance2D(base)>cfg->work.baseRadius*cfg->work.baseRadius) return nullptr;
            const float area=radius>0?std::min(radius,cfg->work.baseRadius):cfg->work.baseRadius;
            IUnitTask* task=AssistWork(unit,s,base,area,false,frame);
            return task||holding?task:AssistWork(unit,s,base,area,true,frame);
        }
        default: return nullptr;
    }
}

IUnitTask* CCommanderController::RepairWork(CCircuitUnit* unit,const State& s,bool defence,float radius,int frame,bool stationary) {
    if(!unit->GetCircuitDef()->IsAbleToRepair()) return nullptr;
    auto* builder=ai->GetBuilderManager();
    const AIFloat3 pos=unit->GetPos(frame);
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    struct Candidate { CAllyUnit* ally; AIFloat3 at; float tech,distance; int id; };
    std::vector<Candidate> candidates;
    workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(pos,radius,false);
    for(int id:workIds) {
        if(id==unit->GetId()) continue;
        CAllyUnit* ally=ai->GetFriendlyUnit(id);
        CCircuitDef* def=ally?ally->GetCircuitDef():nullptr;
        if(def==nullptr || (stationary && !def->IsAttacker()) || (def->IsAbleToFly() && !stationary) || (!stationary && (!def->IsMobile() && def->IsAttacker())!=defence)) continue;
        auto* u=ally->GetUnit();
        const float health=u->GetHealth(),maxHealth=u->GetMaxHealth();
        // Nanoframes are construction (assist), not repair.
        if(u->IsBeingBuilt() || health<=0 || health>=maxHealth*(stationary?1.f:cfg->work.repairHealth) || builder->IsReclaimUnit(ally)) continue;
        const AIFloat3 at=ally->GetPos(frame);
        if(stationary && pos.SqDistance(at)>radius*radius) continue;
        if(!InsideLine(s,at,frame,reach)) continue;
        candidates.push_back({ally,at,defence?0.f:DefinitionFor(def).tech,pos.distance2D(at),id});
    }
    // Static defences nearest first; other units T3, then T2, then T1.
    std::sort(candidates.begin(),candidates.end(),[](const Candidate& a,const Candidate& b) {
        if(a.tech!=b.tech) return a.tech>b.tech;
        if(a.distance!=b.distance) return a.distance<b.distance;
        return a.id<b.id;
    });
    ai->GetThreatMap()->SetThreatType(unit);
    const size_t tried=std::min<size_t>(4,candidates.size());
    for(size_t i=0;i<tried;++i) {
        const auto& c=candidates[i];
        if(cfg->work.clearance>0 && !ai->GetCallback()->GetEnemyUnitIdsIn(c.at,cfg->work.clearance,false).empty()) continue;
        if(!ai->GetTerrainManager()->CanReachAtSafe2(unit,c.at,reach)) continue;
        IBuilderTask* task=builder->EnqueueRepairFor(c.ally,FRAMES_PER_SEC*60,unit);
        if(stationary) if(auto* repair=dynamic_cast<CBRepairTask*>(task)) repair->InviteStationaryCommander(unit->GetId());
        if(task && task->CanAssignTo(unit)) {
            return task;
        }
    }
    return nullptr;
}

IUnitTask* CCommanderController::ReclaimWork(CCircuitUnit* unit,State& s,float radius,int frame) {
    auto* economy=ai->GetEconomyManager();
    s.work.reclaimMetalRoom=commander::ReclaimHeadroom(economy->GetMetalCur(),economy->GetMetalStore(),cfg->work.reclaimStorage);
    s.work.reclaimEnergyRoom=commander::ReclaimHeadroom(economy->GetEnergyCur(),economy->GetEnergyStore(),cfg->work.reclaimEnergyStorage);
    if(!unit->GetCircuitDef()->IsAbleToReclaim() || frame<s.work.reclaimNext
        || (s.work.reclaimMetalRoom<=0 && s.work.reclaimEnergyRoom<=0))return nullptr;
    auto* builder=ai->GetBuilderManager();
    const AIFloat3 pos=unit->GetPos(frame);
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    // Idle work stays inside current build reach. It must not initiate a walk
    // through a contested front to harvest a higher-valued feature.
    radius=std::min(radius,std::max(0.f,reach-32.f));
    commander::LocalReclaimCandidates candidates;
    s.work.reclaimReason="no_features";
    auto features=ai->GetCallback()->GetFeaturesIn(pos,radius,false);
    for(springai::Feature* f:features) {
        auto* def=f->GetDef();
        const bool reclaimable=def && def->IsReclaimable();
        const float left=f->GetReclaimLeft();
        const float metal=reclaimable?def->GetContainedResource(economy->GetMetalRes())*left:0.f;
        const float energy=reclaimable?def->GetContainedResource(economy->GetEnergyRes())*left:0.f;
        delete def;
        const AIFloat3 at=f->GetPosition();
        // The engine query is cylindrical; a cliff-top feature can be close
        // on the minimap but outside build reach in 3D. Never walk to it.
        if(pos.SqDistance(at)>radius*radius)continue;
        const float distance=pos.distance2D(at);
        const auto value=commander::ResourceReclaimValue(metal,energy,s.work.reclaimMetalRoom,s.work.reclaimEnergyRoom,
            cfg->work.reclaimMetal,cfg->work.reclaimEnergy,cfg->work.reclaimEnergyPerMetal,distance);
        if(value.score<=0){s.work.reclaimReason="no_resource_demand";continue;}
        if(!InsideLine(s,at,frame,reach)){s.work.reclaimReason="fallback_boundary";continue;}
        if(builder->IsResurrect(at,8.f)){s.work.reclaimReason="resurrection_claim";continue;}
        // Structure ownership polygons can exclude the start connector and
        // adjacent vegetation already in reach. Harvest uses the existing
        // lane work window below, not the narrower new-building partition.
        // commander-idle-reclaim exercises this connector boundary.
        if(!ai->GetBattle()->LaneWorkAllowed(at)){s.work.reclaimReason="combat_zone";continue;}
        // Apply the same work window before claiming, not after enqueueing.
        auto* battle=ai->GetBattle();
        if(!FallbackActive(s,frame) && battle->GetFrontLaneLength()>0
            && (battle->GetFrontLaneDistance(at)>battle->GetFrontLaneWidth()+(cfg->front.laneMargin>0?cfg->front.laneMargin:reach)
                || (cfg->front.persistent>0 && battle->GetFrontLaneProgress(at)<battle->GetFrontLaneProgress(pos)-cfg->front.workBehind)))continue;
        s.work.reclaimReason="candidates";
        candidates.Add({at.x,at.y,at.z,value.score,distance,value.value,f->GetFeatureId(),value.metal});
    }
    utils::free_clear(features);
    ai->GetThreatMap()->SetThreatType(unit);
    for(size_t i=0;i<candidates.count;++i) {
        const auto& c=candidates.items[i];const AIFloat3 at(c.x,c.y,c.z);
        if(IBuilderTask* claim=builder->GetReclaimFeatureTask(at,8.f)) {
            if(!claim->IsDead() && claim->recoveryControlled && claim->CanAssignTo(unit))return claim;
            continue;
        }
        if(cfg->work.clearance>0 && !ai->GetCallback()->GetEnemyUnitIdsIn(at,cfg->work.clearance,false).empty())continue;
        if(!ai->GetTerrainManager()->CanReachAtSafe2(unit,at,reach))continue;
        auto* task=builder->Enqueue(TaskB::Reclaim(IBuilderTask::Priority::NORMAL,at,c.value,15*FRAMES_PER_SEC,8.f,c.metal));
        // Keep the selected local feature fixed: generic metal reclaim may
        // retarget an enemy or another feature 500 elmos away on reevaluation.
        // As with the original explicit commander offer and SEA recovery,
        // this selector owns initial assignment. Generic pool CanAssignTo
        // also requires cluster escorts, which would veto stationary work.
        if(task) {task->recoveryControlled=true;s.work.reclaimReason="assigned";return task;}
        s.work.reclaimReason="enqueue_failed";
    }
    // Failed optional work only; never throttle threat observation or defense.
    s.work.reclaimNext=frame+int(cfg->work.reclaimRetry*FRAMES_PER_SEC);
    return nullptr;
}

IUnitTask* CCommanderController::LineWork(CCircuitUnit* unit,State& s,CCircuitDef* buildDef,int frame) {
    if(buildDef==nullptr || !unit->GetCircuitDef()->CanBuild(buildDef) || s.work.lineAnchor.x<0
        || (!FallbackActive(s,frame) && frame>=s.work.lineUntil)) return nullptr;
    // The planned line can flip between a porc and a distant rear station
    // from one second to the next; build only at a line the commander holds.
    if(unit->GetPos(frame).SqDistance2D(s.work.lineAnchor)>4.f*cfg->work.lineRadius*cfg->work.lineRadius) return nullptr;
    auto* builder=ai->GetBuilderManager();
    // One line = every turret of buildDef within line_radius of the line's
    // porc (or rear station). Counting what stands there, rather than what
    // this commander ordered, is what stops repeat fallbacks from stacking.
    const float income=ai->GetEconomyManager()->GetAvgMetalIncome();
    int quota=cfg->work.lineIncome>0?int(income/cfg->work.lineIncome):int(cfg->work.lineMax);
    quota=std::min(std::max(quota,int(cfg->work.lineMin)),int(cfg->work.lineMax));
    int count=0;
    workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(s.work.lineAnchor,cfg->work.lineRadius,false);
    for(int id:workIds) if(ai->GetCallback()->Unit_GetDefId(id)==buildDef->GetId()) ++count;
    IBuilderTask* open=nullptr;
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    for(IBuilderTask* task:builder->GetTasks(BT::DEFENCE)) {
        // A planned turret outside a held perimeter is not part of the line.
        if(task->IsDead() || task->GetBuildDef()!=buildDef
            || task->GetPosition().SqDistance2D(s.work.lineAnchor)>cfg->work.lineRadius*cfg->work.lineRadius
            || !InsideLine(s,task->GetPosition(),frame,reach)) continue;
        if(task->GetTarget()==nullptr) ++count; // not yet a nanoframe
        if(open==nullptr && task->CanAssignTo(unit)) open=task;
    }
    if(open) return open; // finish a planned line turret before another
    if(count>=quota) {
        if(!s.work.lineDone) ai->LOG("[CommanderWork] unit=%i line complete count=%i quota=%i income=%.1f",unit->GetId(),count,quota,income);
        s.work.lineDone=true; return nullptr;
    }
    s.work.lineDone=false;
    // Spread along the line (perpendicular to the threat), half a spacing
    // behind the anchor: 0, +1, -1, +2, -2, ... slots by the current count.
    Point toThreat=commander::Normal(P(s.work.lineThreat)-P(s.work.lineAnchor));
    if(commander::Length(toThreat)<.5f) toThreat=commander::Normal(P(s.work.lineAnchor)-P(ai->GetSetupManager()->GetBasePos()));
    const auto site=commander::LineBuildSite(P(s.work.lineAnchor),toThreat,cfg->work.lineSpacing,count,[&](Point p) {
        const AIFloat3 at=F(p);
        return OnMap(at) && InsideLine(s,at,frame,0.f);
    });
    if(!site) return nullptr;
    AIFloat3 at=F(*site);
    at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
    auto* task=builder->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::HIGH,buildDef,at,32.f,true,30*FRAMES_PER_SEC));
    if(task) ai->LOG("[CommanderWork] unit=%i line turret %i/%i x=%.0f z=%.0f income=%.1f",
        unit->GetId(),count+1,quota,at.x,at.z,income);
    return task;
}

bool CCommanderController::CanStartRadar(CCircuitUnit* unit) {
    // Ordinary defence-queue jobs must obey the same script-selected FRONT
    // coverage policy as the ladder. Other roles/openings keep their policy.
    if(!role.work || !role.frontDuty || !role.frontReady || !Handles(unit)) return true;
    State* found=states.Find(unit->GetId());
    if(!found) return true;
    Bind bound(this,found->preset);
    return !RadarCovered(unit,*found,ai->GetLastFrame());
}

bool CCommanderController::RadarCovered(CCircuitUnit* unit,State& s,int frame) {
    const AIFloat3 pos=unit->GetPos(frame);
    if(frame>=s.work.radarFrame+FRAMES_PER_SEC || pos.SqDistance2D(s.work.radarPos)>200.f*200.f) {
        // Coverage by any friendly radar except commanders (its own radar
        // does not count). O(N) over the ally snapshot, cached for a second
        // and 200 elmos; radius per definition from the cached Definition.
        bool covered=false;
        for(const auto& [id,ally]:ai->GetFriendlyUnits()) {
            CCircuitDef* def=ally->GetCircuitDef();
            if(def==nullptr || def->IsRoleComm()) continue;
            const float radar=DefinitionFor(def).radar*cfg->work.radarCoverage;
            // Ally snapshots recreate wrappers with an unset last position.
            // Only radar candidates need a live, frame-cached position read;
            // do not populate positions for the entire allied army (D-310).
            if(radar>0 && ally->GetPos(frame).SqDistance2D(pos)<radar*radar) { covered=true; break; }
        }
        s.work.radarCovered=covered; s.work.radarFrame=frame; s.work.radarPos=pos;
    }
    return s.work.radarCovered;
}

IUnitTask* CCommanderController::RadarWork(CCircuitUnit* unit,State& s,CCircuitDef* buildDef,int frame) {
    if(buildDef==nullptr || !unit->GetCircuitDef()->CanBuild(buildDef)) return nullptr;
    const AIFloat3 pos=unit->GetPos(frame);
    const bool holding=FallbackActive(s,frame);
    if(!InsideLine(s,pos,frame,0.f)) return nullptr;
    const float range=DefinitionFor(buildDef).radar*cfg->work.radarCoverage;
    if(range<=0 || RadarCovered(unit,s,frame)) return nullptr;
    auto* builder=ai->GetBuilderManager();
    // A planned radar that will cover us suppresses a second one; join it only
    // when it lies inside a held perimeter (INV-218: never walk out to it).
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    for(IBuilderTask* task:builder->GetTasks(BT::RADAR))
        if(!task->IsDead() && task->GetBuildDef()==buildDef && task->GetPosition().SqDistance2D(pos)<=range*range)
            return task->CanAssignTo(unit) && InsideLine(s,task->GetPosition(),frame,reach)?task:nullptr;
    if((!holding && ai->GetThreatMap()->GetThreatAt(unit,pos)>cfg->front.threat)
        || ai->GetEconomyManager()->GetMetalCur()<buildDef->GetCostM()*.5f) return nullptr;
    auto* task=builder->Enqueue(TaskB::Common(BT::RADAR,IBuilderTask::Priority::NORMAL,buildDef,pos,96.f,true,30*FRAMES_PER_SEC));
    if(task) {
        s.work.radarFrame=-10000; // the new frame covers us on the next check
        // INV-220 (D-304): no new commander radar where an existing friendly
        // radar at least as strong already covers. Independent of the
        // snapshot: one engine area query per radar enqueue (rare). Restored
        // after the 0bcf08e4 merge dropped it.
        auto* clb=ai->GetCallback();
        for(int id:clb->GetFriendlyUnitIdsIn(pos,range,false)) {
            const int defId=clb->Unit_GetDefId(id);
            CCircuitDef* def=defId>0?ai->GetCircuitDefSafe(defId):nullptr;
            if(def && !def->IsRoleComm() && !def->IsMobile() && DefinitionFor(def).radar*cfg->work.radarCoverage>=range) {
                ai->LOG("[INVARIANT] INV-220 commander radar inside existing coverage unit=%i radar=%i x=%.0f z=%.0f",
                    unit->GetId(),id,pos.x,pos.z);
                break;
            }
        }
    }
    return task;
}

IUnitTask* CCommanderController::AssistWork(CCircuitUnit* unit,const State& s,const AIFloat3& center,float radius,bool factories,int frame) {
    if(factories && !unit->GetCircuitDef()->IsAbleToAssist()) return nullptr;
    const AIFloat3 pos=unit->GetPos(frame);
    const float reach=unit->GetCircuitDef()->GetBuildDistance();
    IUnitTask* best=nullptr; CCircuitUnit* plant=nullptr;
    float bestDistance=std::numeric_limits<float>::max();
    workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(center,radius,false);
    for(int id:workIds) {
        CCircuitUnit* worker=ai->GetTeamUnit(id);
        if(!worker || worker==unit || !worker->IsFinished()) continue;
        CCircuitDef* def=worker->GetCircuitDef();
        AIFloat3 at;
        IBuilderTask* task=nullptr;
        if(!factories) {
            // Join a constructor's actual build (frame or planned building).
            if(!def->IsMobile() || !def->IsBuilder()) continue;
            task=dynamic_cast<IBuilderTask*>(worker->GetTask());
            if(!task || !task->GetBuildDef() || task->IsDead() || task->IsExternalControlled()
                || task->IsEnemyReclaim() || !task->CanAssignTo(unit)) continue;
            at=task->GetPosition();
        } else {
            // A plant producing a unit (recruit task), not a nano turret.
            if(def->IsMobile() || !def->IsBuilder() || def->IsAssist() || def->GetBuildOptions().empty()
                || !worker->GetTask() || worker->GetTask()->GetType()!=IUnitTask::Type::FACTORY) continue;
            at=worker->GetPos(frame);
        }
        if(!InsideLine(s,at,frame,reach)) continue;
        const float distance=pos.SqDistance2D(at);
        if(distance<bestDistance) { bestDistance=distance; best=task; plant=factories?worker:nullptr; }
    }
    if(plant) return ai->GetBuilderManager()->EnqueueB(TaskB::Guard(IBuilderTask::Priority::NORMAL,plant,false,FRAMES_PER_SEC*20));
    return best;
}

// D-357: the corridor window a FRONT commander sweeps for metal. A spot
// qualifies when it lies within the lane's half-width plus reach of the
// corridor (O(1) grid read) and its lane progress is between behind and
// ahead of the commander's own. Without capture, a spot with any enemy unit
// on it is skipped; with capture, an enemy extractor there is a target (the
// mex task reclaims it before building, MexTask.cpp) unless the threat map
// says the spot is hot. One bounded engine area query per candidate spot
// (spots inside the window, typically under twenty), per offer, not per frame.
static std::function<bool(const AIFloat3&)> LaneMexAccept(CCircuitAI* ai,CCircuitUnit* unit,const CBattleAnalysis* battle,
        float width,float lo,float hi,bool capture,float frontThreat,float enemyHome,bool losOnly) {
    return [=](const AIFloat3& p) {
        if(battle->GetFrontLaneDistance(p)>width) return false;
        if(losOnly && p.SqDistance2D(unit->GetPos(ai->GetLastFrame()))>SQUARE(unit->GetCircuitDef()->GetLosRadius())) return false;
        // The enemy's home spots (front_mex_enemy_home of an enemy start) are a
        // commander rush, not a lane sweep (hold arena, b02: taking and fortifying
        // the spot 630 elmos from the enemy start drew its commander into a fight).
        if(enemyHome>0 && battle->EnemyEndDistance(p)<enemyHome) return false;
        const float progress=battle->GetFrontLaneProgress(p);
        if(progress<lo || progress>hi) return false;
        const bool enemyOnSpot=!ai->GetCallback()->GetEnemyUnitIdsIn(p,64.f,false).empty();
        if(!enemyOnSpot) return true;
        return capture && ai->GetThreatMap()->GetThreatAt(unit,p)<=frontThreat;
    };
}

// The lane progress the sweep may reach ahead of the commander: its push
// anchor (one cached FrontPosition per second), or its own progress when the
// lane has no front for it (home latch, unreachable or exposed anchor).
float CCommanderController::LaneMexAheadLimit(CCircuitUnit* unit,State& s,int frame,float own) {
    const AIFloat3 anchor=FrontPosition(unit,s,frame);
    return anchor.x<0?own:std::max(own,ai->GetBattle()->GetFrontLaneProgress(anchor));
}

// Use the same local window for selection and resumption. Generic front work
// has a smaller margin/behind allowance and must not reject an already claimed
// lane mex. Geometry only: no new census, callback or retained cache.
bool CCommanderController::LaneMexSiteAllowed(CCircuitUnit* unit,const AIFloat3& site) const {
    const auto* battle=ai->GetBattle();
    // The lane includes the approach from our start to the shared corridor.
    // Group building territory need not include that approach. Mex ownership
    // is already enforced by EconomyManager, before the spot is claimed.
    if(battle->GetFrontLaneLength()<=0) return false;
    const auto pos=unit->GetPos(ai->GetLastFrame());
    const float reach=cfg->front.mexReach>0?cfg->front.mexReach:unit->GetCircuitDef()->GetBuildDistance();
    const float behind=cfg->front.mexLos>0?unit->GetCircuitDef()->GetLosRadius():cfg->front.mexBehind;
    return battle->GetFrontLaneDistance(site)<=battle->GetFrontLaneWidth()+reach
        && (cfg->front.mexLos<=0 || site.SqDistance2D(pos)<=behind*behind)
        && battle->GetFrontLaneProgress(site)>=battle->GetFrontLaneProgress(pos)-behind;
}

IUnitTask* CCommanderController::LaneMexWork(CCircuitUnit* unit,State& s,CCircuitDef* turretDef,int frame) {
    const auto* battle=ai->GetBattle();
    if(battle->GetFrontLaneLength()<=0.f) return nullptr;
    const AIFloat3 pos=unit->GetPos(frame);
    auto* builder=ai->GetBuilderManager();
    auto* clb=ai->GetCallback();
    // The turret that follows every front_mex_turret_every corridor mexes:
    // the script's line turret definition, at the last mex taken ("mex plus
    // LLT at the cluster"), once, unless one already stands or is planned there.
    if(cfg->front.mexDefence<=0 && s.front.laneMexTurret && turretDef && cfg->front.mexTurretEvery>0 && s.front.laneMexLast.x>=0
        && unit->GetCircuitDef()->CanBuild(turretDef)) {
        const float near2=4.f*cfg->work.lineSpacing*cfg->work.lineSpacing;
        bool standing=false;
        workIds=clb->GetFriendlyUnitIdsIn(s.front.laneMexLast,2.f*cfg->work.lineSpacing,false);
        for(int id:workIds) if(clb->Unit_GetDefId(id)==turretDef->GetId()) { standing=true; break; }
        for(IBuilderTask* task:builder->GetTasks(BT::DEFENCE)) {
            if(task->IsDead() || task->GetBuildDef()!=turretDef || task->GetPosition().SqDistance2D(s.front.laneMexLast)>near2) continue;
            s.front.laneMexTurret=false;
            return task->CanAssignTo(unit)?task:nullptr;
        }
        if(standing) s.front.laneMexTurret=false;
        else if(ai->GetEconomyManager()->GetMetalCur()>=turretDef->GetCostM()*.5f
            && ai->GetThreatMap()->GetThreatAt(unit,s.front.laneMexLast)<=cfg->front.threat) {
            auto* task=builder->Enqueue(TaskB::Common(BT::DEFENCE,IBuilderTask::Priority::NORMAL,turretDef,s.front.laneMexLast,128.f,true,30*FRAMES_PER_SEC));
            if(task) {
                s.front.laneMexTurret=false;
                ai->LOG("[CommanderFront] unit=%i lane_turret x=%.0f z=%.0f after=%i",unit->GetId(),s.front.laneMexLast.x,s.front.laneMexLast.z,s.front.laneMexCount);
                return task;
            }
        }
    }
    const float reach=cfg->front.mexReach>0?cfg->front.mexReach:unit->GetCircuitDef()->GetBuildDistance();
    const float width=battle->GetFrontLaneWidth()+reach;
    const float own=battle->GetFrontLaneProgress(pos);
    const float radius=cfg->front.mexLos>0?unit->GetCircuitDef()->GetLosRadius():std::max(cfg->front.mexBehind,cfg->front.mexAhead)+width;
    // The sweep never leads the front: spots ahead are taken only up to the
    // push anchor (screen rule, front_distance, lane limit, enemy-group
    // stand-off, threat), so the commander does not creep mex by mex into an
    // enemy it would not walk toward (hold arena, b01: both commanders met).
    const auto accept=LaneMexAccept(ai,unit,battle,width,own-(cfg->front.mexLos>0?radius:cfg->front.mexBehind),
        std::min(own+(cfg->front.mexLos>0?radius:cfg->front.mexAhead),LaneMexAheadLimit(unit,s,frame,own)),
        cfg->front.mexCaptureEnemy>0,cfg->front.threat,cfg->front.mexEnemyHome,cfg->front.mexLos>0);
    IBuilderTask* task=ai->GetEconomyManager()->EnqueueMexWithin(unit,pos,radius,0,true,{},accept);
    if(task) {
        const AIFloat3 at=task->GetPosition();
        if(at.SqDistance2D(s.front.laneMexLast)>64.f*64.f) {
            s.front.laneMexLast=at; ++s.front.laneMexCount;
            if(cfg->front.mexTurretEvery>0 && s.front.laneMexCount%int(cfg->front.mexTurretEvery)==0) s.front.laneMexTurret=true;
            ai->LOG("[CommanderFront] unit=%i lane_mex x=%.0f z=%.0f progress=%.0f own=%.0f count=%i",
                unit->GetId(),at.x,at.z,battle->GetFrontLaneProgress(at),own,s.front.laneMexCount);
        }
    }
    return task;
}

// The dry form of LaneMexWork's admission (the same window and the same
// economy admission, with no claim made), for INV-235 at the advance rung.
bool CCommanderController::LaneMexAvailable(CCircuitUnit* unit,State& s,int frame) {
    const auto* battle=ai->GetBattle();
    if(FallbackActive(s,frame) || battle->GetFrontLaneLength()<=0.f) return false;
    const AIFloat3 pos=unit->GetPos(frame);
    const float reach=cfg->front.mexReach>0?cfg->front.mexReach:unit->GetCircuitDef()->GetBuildDistance();
    const float width=battle->GetFrontLaneWidth()+reach;
    const float own=battle->GetFrontLaneProgress(pos);
    const float radius=cfg->front.mexLos>0?unit->GetCircuitDef()->GetLosRadius():std::max(cfg->front.mexBehind,cfg->front.mexAhead)+width;
    const auto accept=LaneMexAccept(ai,unit,battle,width,own-(cfg->front.mexLos>0?radius:cfg->front.mexBehind),
        std::min(own+(cfg->front.mexLos>0?radius:cfg->front.mexAhead),LaneMexAheadLimit(unit,s,frame,own)),
        cfg->front.mexCaptureEnemy>0,cfg->front.threat,cfg->front.mexEnemyHome,cfg->front.mexLos>0);
    return ai->GetEconomyManager()->CountOpenMexWithin(unit,pos,radius,true,accept)>0;
}
}
