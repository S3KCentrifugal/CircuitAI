#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "setup/SetupManager.h"
#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "control/kernel/CommanderFortification.h"
#include "control/kernel/CommanderGroupWork.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "spring/SpringUnit.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "map/ThreatMap.h"
#include "task/builder/BuilderTask.h"
#include "task/common/WaitTask.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {
using springai::AIFloat3;
using BT=IBuilderTask::BuildType;
static commander::Point P(const AIFloat3& p) {return {p.x,p.z};}
static AIFloat3 F(commander::Point p) {return {p.x,0,p.z};}
static commander::Point Heading(const CBattleAnalysis* battle,const AIFloat3& p) {
    const float d=battle->GetFrontLaneProgress(p);
    return commander::Normal(P(battle->GetFrontLanePoint(d+64))-P(battle->GetFrontLanePoint(std::max(0.f,d-64))));
}

bool CCommanderController::IsFrontDefence(const CCircuitDef* def) const {
    return def && (def->GetId()==int(cfg->front.lineDef) || def->GetId()==groupDef || def->GetId()==groupDef2
        || std::find(frontDefenceDefs.begin(),frontDefenceDefs.end(),def->GetId())!=frontDefenceDefs.end());
}

std::vector<commander::DefenceExclusion> CCommanderController::DefenceExclusions(CCircuitUnit* unit,
    CCircuitDef* def,const AIFloat3& center,float searchRadius,const IUnitTask* ignore) const {
    Bind bound(this,PresetOfUnit(unit?unit->GetId():-1)); // D-388: this unit's preset
    std::vector<commander::DefenceExclusion> result;
    if(!role.frontDuty || cfg->front.defenceSpacing<=0 || !IsFrontDefence(def)
        || (!IsGroupMember(unit->GetId()) && !Handles(unit))) return result;
    float maxRange=def->GetMaxRange();
    for(int id:frontDefenceDefs) {
        auto* other=ai->GetCircuitDefSafe(id);
        if(other) maxRange=std::max(maxRange,other->GetMaxRange());
    }
    for(int id:{int(cfg->front.lineDef),groupDef,groupDef2}) {
        auto* other=ai->GetCircuitDefSafe(id);
        if(other) maxRange=std::max(maxRange,other->GetMaxRange());
    }
    const float radius=searchRadius+maxRange*cfg->front.defenceSpacing;
    auto add=[&](CCircuitDef* other,const AIFloat3& at) {
        if(IsFrontDefence(other) && OnMap(at) && at.SqDistance2D(center)<=radius*radius)
            result.push_back({P(at),std::max(def->GetMaxRange(),other->GetMaxRange())*cfg->front.defenceSpacing});
    };
    // Fresh per-offer snapshot: O(F*D + Q*D) for local friendlies F, queued
    // defenses Q and the small script roster D. Terrain candidates use only
    // copied discs, never callbacks. No cache survives enqueue/loss/transfer.
    // Both frames and completed allied defenses occupy space; own queued sites
    // reserve it before a frame exists. The executing task excludes itself.
    for(int id:ai->GetCallback()->GetFriendlyUnitIdsIn(center,radius,false)) {
        // Own lifecycle state includes frames created since the periodic ally
        // snapshot. Otherwise a cancelled fresh frame briefly loses its disc.
        if(auto* own=ai->GetTeamUnit(id)) {
            add(own->GetCircuitDef(),own->GetPos(ai->GetLastFrame()));
            continue;
        }
        auto* ally=ai->GetFriendlyUnit(id);
        if(ally) add(ally->GetCircuitDef(),ally->GetPos(ai->GetLastFrame()));
    }
    // BAR's fresh nanoframes are temporarily neutral and omitted by the
    // friendly query. Include allied neutral frames in the same local radius;
    // only placement offers pay this extra query, never every unit/frame.
    for(auto* neutral:ai->GetCallback()->GetNeutralUnitsIn(center,radius,false)) {
        if(neutral->GetAllyTeam()!=ai->GetAllyTeamId()) continue;
        add(ai->GetCircuitDefSafe(ai->GetCallback()->Unit_GetDefId(neutral->GetUnitId())),neutral->GetPos());
    }
    for(auto* task:ai->GetBuilderManager()->GetTasks(BT::DEFENCE)) {
        if(task==ignore || task->IsDead()) continue;
        const auto& at=task->GetBuildPos();
        add(task->GetBuildDef(),geom::is_valid(at)?at:task->GetPosition());
    }
    return result;
}

void CCommanderController::MexFinished(CCircuitUnit* worker,CCircuitUnit* mex) {
    Bind bound(this,PresetOfUnit(worker?worker->GetId():-1)); // D-388: this unit's preset
    if(!role.frontDuty || cfg->front.mexDefence<=0 || !Handles(worker)) return;
    State* found=states.Find(worker->GetId());
    if(!found) return;
    auto& pending=GroupActive(worker)?groupState.front.unfortifiedMexes:found->front.unfortifiedMexes;
    if(std::find(pending.begin(),pending.end(),mex->GetId())==pending.end()) pending.push_back(mex->GetId());
    ai->LOG("[CommanderFront] unit=%i completed_mex=%i",worker->GetId(),mex->GetId());
}

IUnitTask* CCommanderController::FortifySite(CCircuitUnit* unit,CCircuitDef* def,const AIFloat3& site,int frame,const AIFloat3* coveragePoint) {
    auto* builder=ai->GetBuilderManager();
    const float coverageRadius=std::max(0.f,def->GetMaxRange()*.8f-16.f);
    auto* groupCommander=IsGroupMember(unit->GetId())?GroupCommander():nullptr;
    const auto groupCenter=groupCommander?groupCommander->GetPos(frame):site;
    const float groupSight=groupCommander?cfg->group.radius:0.f;
    CTerrainManager::TerrainPredicate admit=[&](const AIFloat3& p) {
        if(!GroupBuildSiteAllowed(unit,def,p)) return false;
        // Reject before enqueueing/spending the incremental allowance. The
        // final build guard also enforces this, but an invalid offer otherwise
        // repeatedly abandons defenses after replacement (support-replace).
        if(IsGroupMember(unit->GetId()) && (!groupCommander
            || p.SqDistance2D(groupCenter)>SQUARE(std::max(0.f,groupSight-16.f)))) return false;
        if(coveragePoint && (p.SqDistance2D(*coveragePoint)>coverageRadius*coverageRadius
            || ai->GetBattle()->CorridorAtPoint(int(cfg->front.corridorClass),p)!=int(cfg->front.corridor))) return false;
        // A buildable site can lie across a cliff from the commander. Reject it
        // inside the search so the next reachable alternative is considered,
        // rather than retrying the same unreachable nearest result forever.
        return ai->GetThreatMap()->GetThreatAt(unit,p)<=cfg->front.threat
            && ai->GetTerrainManager()->CanReachAtSafe2(unit,p,unit->GetCircuitDef()->GetBuildDistance());
    };
    for(auto* task:builder->GetTasks(BT::DEFENCE)) {
        if(task->IsDead() || task->GetBuildDef()!=def || task->GetPosition().SqDistance2D(site)>64.f*64.f || !admit(task->GetPosition())) continue;
        return task->CanAssignTo(unit)?task:nullptr;
    }
    // An orphaned nanoframe is unfinished work, not a reason to wait forever.
    // Reuse the repair registry (one owner per target) and the same safe-site
    // admission. Finished turrets are accounted for by coverage; let placement
    // search around them rather than vetoing every nearby alternative.
    const auto nearbyIds=ai->GetCallback()->GetFriendlyUnitIdsIn(site,64.f,false);
    for(int id:nearbyIds) {
        if(ai->GetCallback()->Unit_GetDefId(id)!=def->GetId()) continue;
        auto* ally=ai->GetFriendlyUnit(id);
        if(!ally || !ally->GetUnit()->IsBeingBuilt() || !admit(ally->GetPos(frame))
            || builder->IsReclaimUnit(ally)) continue;
        auto* repair=builder->EnqueueRepairFor(ally,60*FRAMES_PER_SEC,unit);
        if(repair && repair->CanAssignTo(unit)) return repair;
    }
    // A mandatory job cannot depend on saving a bank that factory production
    // continuously spends. Balanced policy queues one high-priority LLT and
    // lets normal construction resource allocation fund it incrementally.
    if(!OnMap(site) || ai->GetEconomyManager()->GetMetalCur()<def->GetCostM()*cfg->front.fortifyBank) return nullptr;
    // Mex defenses keep a small enemy-facing shake. A line may bend around a
    // slope/rock: search within weapon reach, but admit only real sites whose
    // coverage fills the gap and remains in this territory. This replaces
    // repeated failed exact-slot builds on unbuildable ground (Proving Grounds).
    const float search=coveragePoint?def->GetMaxRange()*.75f:48.f;
    const auto exclusions=DefenceExclusions(unit,def,site,search);
    CTerrainManager::TerrainPredicate spaced=[&](const AIFloat3& p) {
        // New construction waits outside contact zones; existing frames and
        // repairs above retain their task lifecycle and emergency usefulness.
        return ai->GetBattle()->LaneWorkAllowed(p) && commander::DefenceSpaced(P(p),exclusions) && admit(p);
    };
    const auto at=ai->GetTerrainManager()->FindBuildSite(def,site,search,0,spaced);
    const bool found=OnMap(at);
    const bool safe=found && ai->GetThreatMap()->GetThreatAt(unit,at)<=cfg->front.threat;
    const bool reachable=safe && ai->GetTerrainManager()->CanReachAtSafe2(unit,at,unit->GetCircuitDef()->GetBuildDistance());
    if(!reachable) {
        const State* state=states.Find(unit->GetId());
        if(coveragePoint && state && frame>=state->lastLog+30*FRAMES_PER_SEC)
            ai->LOG("[CommanderFront] unit=%i fortify_rejected found=%i safe=%i reachable=%i site=%.0f,%.0f selected=%.0f,%.0f",unit->GetId(),int(found),int(safe),int(reachable),site.x,site.z,at.x,at.z);
        return nullptr;
    }
    const auto priority=static_cast<IBuilderTask::Priority>(int(cfg->front.fortifyPriority));
    auto* task=builder->Enqueue(TaskB::Common(BT::DEFENCE,priority,def,at,16.f,true,60*FRAMES_PER_SEC));
    if(task && IsGroupMember(unit->GetId())) ai->LOG("[CommanderGroup] unit=%i defence=%s nano_after=1",unit->GetId(),def->GetDef()->GetName());
    if(task) ai->LOG("[CommanderFront] unit=%i fortify_site x=%.0f z=%.0f line=%i frame=%i",unit->GetId(),at.x,at.z,int(coveragePoint!=nullptr),frame);
    return task;
}

// Local reconciliation, not completion debt: covers allied/constructor-built
// mexes and retries after turret loss. No whole-map scan or retained unit pointers.
// Per eligible offer O(K + M*(F+Q)) for local units K, mexes M, nearby defenses F
// and queued defenses Q. Three placement alternatives; existing task cadence.
IUnitTask* CCommanderController::ExpansionMexWork(CCircuitUnit* unit,State& s,CCircuitDef* def,int frame) {
    static const bool trace=std::getenv("CIRCUIT_COMMANDER_TRACE")!=nullptr;
    if(cfg->front.mexMinIncome<=0 || cfg->front.mexDefence<=0 || !Handles(unit)
        || !role.frontReady || !def || !unit->GetCircuitDef()->CanBuild(def)
        || HealthRetreat(unit) || EnergyRetreat(unit) || FallbackActive(s,frame)
        || groupJob || groupNanoDue || frame<s.front.expansionMexNext) return nullptr;
    const float income=ai->GetEconomyManager()->GetAvgMetalIncome();
    if(income<=cfg->front.mexMinIncome) return nullptr;
    // Preserve the existing three-second fortification retry interval. Do not
    // cache coverage: the next offer sees deaths, transfers and new frames.
    s.front.expansionMexNext=frame+3*FRAMES_PER_SEC;
    const auto origin=ai->GetSetupManager()->GetStartPos();
    const auto center=unit->GetPos(frame);
    const auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(center,cfg->front.radius,false);
    const float range=def->GetMaxRange()*.8f;
    for(int id:ids) {
        CAllyUnit* mex=ai->GetTeamUnit(id);
        if(!mex) mex=ai->GetFriendlyUnit(id);
        if(!mex || !mex->GetCircuitDef()->IsMex() || mex->GetUnit()->IsBeingBuilt()) continue;
        const auto pos=mex->GetPos(frame);
        if(trace) ai->LOG("[ExpansionMex] mex=%i income=%.1f distance=%.0f base=%.0f lane=%i",id,income,std::sqrt(pos.SqDistance2D(origin)),cfg->front.mexBaseRadius,int(GroupBuildSiteAllowed(unit,def,pos)));
        if(!commander::ExpansionMexEligible(income,cfg->front.mexMinIncome,pos.SqDistance2D(origin),cfg->front.mexBaseRadius)
            || !GroupBuildSiteAllowed(unit,def,pos)) continue;
        const auto offered=[&](IUnitTask* task) {
            ai->LOG("[CommanderFront] unit=%i expansion_mex=%i income=%.1f base_distance=%.0f",unit->GetId(),id,income,std::sqrt(pos.SqDistance2D(origin)));
            return task;
        };
        bool covered=false;
        for(int other:ai->GetCallback()->GetFriendlyUnitIdsIn(pos,range,false)) {
            CAllyUnit* turret=ai->GetTeamUnit(other);
            if(!turret) turret=ai->GetFriendlyUnit(other);
            // Allied snapshots can carry a different AI's definition pointer.
            if(!turret || turret->GetCircuitDef()->GetId()!=def->GetId()) continue;
            if(turret->GetUnit()->IsBeingBuilt()) {
                if(!GroupBuildSiteAllowed(unit,def,turret->GetPos(frame))
                    || ai->GetThreatMap()->GetThreatAt(unit,turret->GetPos(frame))>cfg->front.threat) continue;
                if(auto* repair=ai->GetBuilderManager()->EnqueueRepairFor(turret,60*FRAMES_PER_SEC,unit))
                    if(repair->CanAssignTo(unit)) return offered(repair);
            }
            covered=true;break;
        }
        if(covered) continue;
        // Join queued work anywhere in coverage, before trying a different site.
        for(auto* task:ai->GetBuilderManager()->GetTasks(BT::DEFENCE)) {
            if(task->IsDead() || task->GetBuildDef()!=def || task->GetPosition().SqDistance2D(pos)>range*range) continue;
            if(task->CanAssignTo(unit)) return offered(task);
            covered=true;break;
        }
        if(covered) continue;
        const auto forward=Heading(ai->GetBattle(),pos);
        const commander::Point side{-forward.z,forward.x};
        for(float lateral:{0.f,64.f,-64.f}) {
            auto at=F(P(pos)+forward*std::min(cfg->front.mexOffset,range*.6f)+side*lateral);
            if(!OnMap(at)) continue;
            at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
            if(auto* task=FortifySite(unit,def,at,frame)) {
                return offered(task);
            }
        }
    }
    return nullptr;
}

IUnitTask* CCommanderController::MexDefenceWork(CCircuitUnit* unit,State& s,CCircuitDef* def,int frame) {
    if(cfg->front.mexDefence<=0 || !def || !unit->GetCircuitDef()->CanBuild(def)
        || ai->GetBattle()->GetFrontLaneLength()<=0) return nullptr;
    auto* battle=ai->GetBattle();
    // Only actual completed mexes involving this commander are retained. A
    // cancelled offer creates no debt. Drop dead/transferred IDs before use.
    const bool incremental=cfg->front.fortifyAdvance>0;
    const float own=battle->GetFrontLaneProgress(unit->GetPos(frame));
    const float next=std::min(s.front.fortifyNextProgress,
        std::min(cfg->front.distance,battle->GetFrontLaneLength()-cfg->front.standoff)-64.f);
    for(size_t i=0;i<s.front.unfortifiedMexes.size();) {
        auto* mex=ai->GetTeamUnit(s.front.unfortifiedMexes[i]);
        if(!mex || !mex->GetCircuitDef()->IsMex()) {s.front.unfortifiedMexes.erase(s.front.unfortifiedMexes.begin()+i);continue;}
        const auto pos=mex->GetPos(frame);
        // Retain distant obligations without walking backwards to service them.
        // Only local debts need fresh engine coverage queries (commander-owned
        // IDs, not a scan of the team's mex population).
        if(incremental && (battle->GetFrontLaneProgress(pos)<own-cfg->front.workBehind
            || pos.SqDistance2D(unit->GetPos(frame))>cfg->front.radius*cfg->front.radius)) {++i;continue;}
        const auto forward=Heading(battle,pos);
        float range=def->GetMaxRange()*.8f;
        auto* jobDef=def;
        bool aaPending=false;
        bool covered=false;
        workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(pos,range,false);
        for(int id:workIds) {
            auto* ally=ai->GetFriendlyUnit(id);
            if(ally && ally->GetCircuitDef()==def && !ally->GetUnit()->IsBeingBuilt()
                && commander::EnemySideCover(P(pos),P(ally->GetPos(frame)),forward,range)) {covered=true;break;}
        }
        if(covered && cfg->front.mexAA>=0) {
            auto* aa=ai->GetCircuitDefSafe(int(cfg->front.mexAA));
            if(IsGroupMember(unit->GetId())) {
                auto* advancedAA=ai->GetCircuitDefSafe(groupAA2);
                aa=GroupCanBuild(advancedAA,GroupCommander()) && GroupCanFund(advancedAA)
                    ?advancedAA:ai->GetCircuitDefSafe(groupAA);
            }
            if(!aa || !unit->GetCircuitDef()->CanBuild(aa)) {++i;continue;}
            covered=false;
            for(int id:ai->GetCallback()->GetFriendlyUnitIdsIn(pos,cfg->front.mexOffset+64.f,false)) {
                auto* ally=ai->GetFriendlyUnit(id);
                if(ally && ally->GetCircuitDef()==aa && !ally->GetUnit()->IsBeingBuilt()) {covered=true;break;}
            }
            if(!covered) {jobDef=aa;range=aa->GetMaxRange()*.8f;aaPending=true;}
        }
        if(covered) {
            ai->LOG("[CommanderFront] unit=%i mex_defended=%i",unit->GetId(),mex->GetId());
            s.front.unfortifiedMexes.erase(s.front.unfortifiedMexes.begin()+i);continue;
        }
        const commander::Point side{-forward.z,forward.x};
        // Three bounded placement alternatives keep every site on the enemy
        // side and within LLT range. Retry later, never silently clear a debt.
        if(frame>=s.front.mexFortifyRetry && (!incremental || aaPending || own>=next)) {
            s.front.mexFortifyRetry=frame+3*FRAMES_PER_SEC;
            for(float lateral:{0.f,64.f,-64.f}) {
                auto at=F(P(pos)+forward*std::min(cfg->front.mexOffset,range*.6f)+side*lateral);
                if(!OnMap(at)) continue;
                at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
                if(auto* task=FortifySite(unit,jobDef,at,frame)) {
                    ai->LOG("[CommanderFront] unit=%i mex_defence=%i aa=%i x=%.0f z=%.0f",unit->GetId(),mex->GetId(),int(aaPending),at.x,at.z);
                    return task;
                }
            }
            if(incremental) {
                // Rotate a blocked local debt so it cannot starve another mex.
                const int id=s.front.unfortifiedMexes[i];
                s.front.unfortifiedMexes.erase(s.front.unfortifiedMexes.begin()+i);
                s.front.unfortifiedMexes.push_back(id);
                return nullptr;
            }
        }
        // An unavailable site must not monopolise the role ladder. Keep the
        // debt and offer lane movement; subsequent asks can try other debts.
        if(incremental) {++i;continue;}
        // Explicit blocking mode retains the original bounded wait.
        auto* wait=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(TaskB::Wait(3*FRAMES_PER_SEC)));
        wait->SetStationary(true);return wait;
    }
    return nullptr;
}

IUnitTask* CCommanderController::TerritoryLineWork(CCircuitUnit* unit,State& s,CCircuitDef* def,int frame) {
    if(cfg->front.lineEnabled<=0 || !def || !unit->GetCircuitDef()->CanBuild(def)) return nullptr;
    auto* battle=ai->GetBattle();
    const int corridor=int(cfg->front.corridor),cls=int(cfg->front.corridorClass);
    const float length=battle->GetFrontLaneLength();
    if(length<=0 || corridor<0 || cls<0) {s.front.territoryPending=false;return nullptr;}
    const auto pos=unit->GetPos(frame);
    const float own=battle->GetFrontLaneProgress(pos);
    if(s.front.territoryCorridor!=corridor || s.front.territoryClass!=cls) {
        s.front.territoryPlans.clear();s.front.territoryProgress=-1;s.front.fortifyNextProgress=0;
        s.front.territoryCorridor=corridor;s.front.territoryClass=cls;
    }
    const bool incremental=cfg->front.fortifyAdvance>0;
    // Plans are retained by corridor generation. Their count is bounded by
    // lane length / line depth; only the selected local plan queries units.
    // Forward progress creates new plans even when old flanks remain unfinished.
    if(s.front.territoryProgress<0 || ((incremental || !s.front.territoryPending)
        && own>=s.front.territoryProgress+cfg->front.lineDepth)) {
        if(GroupNearCombat(unit)) {
            const auto center=battle->GetFrontLanePoint(own);
            const auto sites=commander::TerritoryLine(P(center),Heading(battle,center),
                std::max(96.f,def->GetMaxRange()*cfg->front.lineSpacing),[&](commander::Point p) {
                    return OnMap(F(p)) && battle->CorridorAtPoint(cls,F(p))==corridor;
                },int(std::ceil(std::hypot(AIFloat3::maxxpos,AIFloat3::maxzpos)/64.f)));
            CommanderFrontState::TerritoryPlan plan;
            plan.progress=own;
            for(auto p:sites) {auto at=F(p);at.y=ai->GetMap()->GetElevationAt(at.x,at.z);plan.sites.push_back(at);}
            s.front.territoryProgress=own;
            if(!plan.sites.empty()) s.front.territoryPlans.push_back(std::move(plan));
            ai->LOG("[CommanderFront] unit=%i territory_line corridor=%i progress=%.0f sites=%u retained=%u",unit->GetId(),corridor,own,unsigned(sites.size()),unsigned(s.front.territoryPlans.size()));
        }
    }
    CommanderFrontState::TerritoryPlan* selected=nullptr;
    float closest=std::numeric_limits<float>::max();
    s.front.territoryPending=false;
    for(auto& plan:s.front.territoryPlans) {
        if(!commander::ReviewLine(plan.pending,frame,plan.reviewFrame,std::abs(plan.progress-own),cfg->front.radius)) continue;
        s.front.territoryPending=true;
        if(incremental && plan.progress<own-cfg->front.workBehind) continue;
        const float distance=std::abs(plan.progress-own);
        if(distance<closest) {closest=distance;selected=&plan;}
    }
    const float next=std::min(s.front.fortifyNextProgress,
        std::min(cfg->front.distance,length-cfg->front.standoff)-64.f);
    if(!selected || (incremental && !IsGroupMember(unit->GetId()) && own<next)) return nullptr;
    auto& plan=*selected;
    plan.reviewFrame=frame+int(cfg->group.lineReviewSeconds*FRAMES_PER_SEC);
    const auto center=battle->GetFrontLanePoint(plan.progress);
    const auto forward=Heading(battle,center);
    const commander::Point side{-forward.z,forward.x};
    float left=0,right=0;
    for(const auto& at:plan.sites) {
        const float across=commander::Dot(P(at)-P(center),side);
        left=std::min(left,across);right=std::max(right,across);
    }
    // One bounded spatial query per offer, then O(L log L) interval union for
    // L nearby finished LLTs. Avoid one engine query per planned slot, and
    // recognize continuous coverage from the commander's mex defenses too.
    const float cover=def->GetMaxRange()*.8f;
    workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(center,std::max(-left,right)+cover,false);
    std::vector<commander::CoverageSpan> spans;
    spans.reserve(16);
    for(int id:workIds) {
        auto* ally=ai->GetFriendlyUnit(id);
        if(!ally || ally->GetCircuitDef()!=def || ally->GetUnit()->IsBeingBuilt()) continue;
        commander::CoverageSpan span;
        if(commander::TurretCoverage(P(ally->GetPos(frame)),P(center),side,cover,span)) spans.push_back(span);
    }
    // A one-point narrow territory still requires coverage of that point.
    const float gap=commander::FirstCoverageGap(spans,left,right+1.f);
    if(gap>=right+1.f) {
        if(plan.pending) ai->LOG("[CommanderFront] unit=%i territory_complete corridor=%i sites=%u",unit->GetId(),corridor,unsigned(plan.sites.size()));
        plan.pending=false;
        s.front.territoryPending=std::any_of(s.front.territoryPlans.begin(),s.front.territoryPlans.end(),[](const auto& p){return p.pending;});
        return nullptr;
    }
    plan.pending=true;
    s.front.territoryPending=true;
    if(frame>=s.front.fortifyRetry) {
        s.front.fortifyRetry=frame+3*FRAMES_PER_SEC;
        const float local=commander::NearestCoverageGap(spans,left,right+1.f,
            commander::Dot(P(pos)-P(center),side));
        const float across=incremental?local:commander::GapBuildOffset(spans,gap,right,
            std::min(cover*.9f,def->GetMaxRange()*cfg->front.lineSpacing*.5f));
        auto at=F(P(center)+side*across);
        const auto required=F(P(center)+side*(incremental?local:gap));
        if(incremental && at.SqDistance2D(pos)>cfg->front.radius*cfg->front.radius) return nullptr;
        if(OnMap(at)) {
            at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
            if(auto* task=FortifySite(unit,def,at,frame,&required)) return task;
        }
        if(frame>=s.lastLog+30*FRAMES_PER_SEC) {
            s.lastLog=frame;
            ai->LOG("[CommanderFront] unit=%i line_blocked corridor=%i gap=%.0f across=%.0f bounds=%.0f,%.0f center=%.0f,%.0f coverage=%u",
                unit->GetId(),corridor,gap,across,left,right,center.x,center.z,unsigned(spans.size()));
        }
    }
    if(incremental) return nullptr;
    auto* wait=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(TaskB::Wait(3*FRAMES_PER_SEC)));
    wait->SetStationary(true);return wait;
}
}
