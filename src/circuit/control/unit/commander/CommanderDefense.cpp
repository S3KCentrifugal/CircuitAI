#include "control/unit/commander/CommanderController.h"
#include "control/service/CombatSnapshot.h"
#include "control/core/Ownership.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/MilitaryManager.h"
#include "task/fighter/RangedWorld.h"
#include "task/builder/BuilderTask.h"
#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "unit/ally/AllyTeam.h"
#include "unit/ally/AllyUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "spring/SpringCallback.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"
#include "Shield.h"
#include "Weapon.h"
#include "WeaponMount.h"
#include <cstdlib>

namespace circuit {
using springai::AIFloat3;
namespace dp=defense;

bool CCommanderController::SetDefenseRule(int slot,const std::string& key,float value) {
    if(!std::isfinite(value) || value<0 || value>1000000) return false;
    if(slot==-1) {
        if(key=="nuclear_warning") {
            ai->GetAllyTeam()->NuclearWarning(ai->GetLastFrame());
            defenseNext=defenseDecisionNext=0;
            return true;
        }
        float* field=key=="enabled"?&defenseSettings.enabled:key=="radius"?&defenseSettings.radius:
            key=="surplus_metal"?&defenseSettings.surplusMetal:key=="surplus_energy_margin"?&defenseSettings.surplusEnergyMargin:
            key=="surplus_fire_seconds"?&defenseSettings.surplusFireSeconds:key=="surplus_limit"?&defenseSettings.surplusLimit:
            key=="memory"?&defenseSettings.memory:key=="strategic_memory"?&defenseSettings.strategicMemory:
            key=="heavy_metal"?&defenseSettings.heavyMetal:key=="heavy_health"?&defenseSettings.heavyHealth:
            key=="baseline_health"?&defenseSettings.baselineHealth:key=="stable_seconds"?&defenseSettings.stableSeconds:
            key=="stable_distance"?&defenseSettings.stableDistance:key=="urgent_band"?&defenseSettings.urgentBand:
            key=="shield_in_plasma_zone"?&defenseSettings.shieldInPlasmaZone:key=="shield_safe_seconds"?&defenseSettings.shieldSafeSeconds:nullptr;
        if(!field) return false;
        *field=value;
    } else {
        if(slot<0 || slot>=dp::MAX_RULES) return false;
        auto& r=defenseRules[slot];
        int* integer=key=="def"?&r.def:key=="band"?&r.band:key=="limit"?&r.limit:nullptr;
        if(integer) {
            if(value!=std::floor(value) || (key=="def" && !ai->GetCircuitDefSafe(int(value)))) return false;
            *integer=int(value);
        } else {
            float* field=key=="metal"?&r.minMetal:key=="energy"?&r.minEnergy:key=="seconds"?&r.seconds:
                key=="window"?&r.window:key=="efficiency"?&r.efficiency:key=="value_ratio"?&r.valueRatio:
                key=="surplus_priority"?&r.surplusPriority:key=="priority"?&r.priority:key=="reserve"?&r.reserve:nullptr;
            const std::array<const char*,dp::COUNT> names={{"light","heavy","air","static","nuclear","plasma"}};
            for(int k=0;k<dp::COUNT;++k) if(key==names[k]) field=&r.weights[k];
            if(!field || (key=="reserve" && value>=1) || (key=="efficiency" && value>1)) return false;
            *field=value;
        }
    }
    defenseNext=defenseOfferNext=defenseDecisionNext=0; // policy changes take effect without clearing immutable facts
    return true;
}

const CCommanderController::DefenseFacts& CCommanderController::DefenseFactsFor(CCircuitDef* def) {
    const auto found=defenseFacts.find(def->GetId());
    if(found!=defenseFacts.end()) return found->second;
    DefenseFacts f;
    f.onOff=def->GetDef()->IsOnOffable();
    auto* battle=ai->GetBattle();
    f.range=battle->MainRange(def);
    f.coverage=battle->InterceptorCoverage(def);
    std::unique_ptr<springai::WeaponDef> stock(def->GetDef()->GetStockpileDef());
    if(stock) {
        f.nuclear=stock->GetInterceptor()==0 && stock->GetTargetable()==1;
        if(stock->GetInterceptor()!=0) {
            f.warmup=stock->GetStockpileTime()/FRAMES_PER_SEC;
            f.ammunitionMetal=stock->GetCost(ai->GetEconomyManager()->GetMetalRes());
            f.ammunitionEnergy=stock->GetCost(ai->GetEconomyManager()->GetEnergyRes());
        }
    }
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    float dps=0;
    for(const auto& w:cap.weapons) {
        if(!w.def) { f.weapons.push_back({}); continue; }
        float sweep=0;
        const auto& custom=w.def->GetDef()->GetCustomParams();
        const auto timing=custom.find("sweepfire_firetime");
        if(timing!=custom.end()) sweep=std::max(0.f,utils::string_to_float(timing->second));
        const float scale=dp::SweepScale(sweep,w.def->GetDef()->GetBeamTime());
        const float cycle=std::max(.1f,w.reload)+sweep;
        f.weapons.push_back({scale,cycle});
        if(w.fake || !w.def || w.def->IsParalyzer()) continue;
        auto* weapon=w.def->GetDef();
        if(weapon->GetInterceptor()!=0) {
            f.warmup=std::max(f.warmup,weapon->GetStockpileTime()/FRAMES_PER_SEC);
            continue;
        }
        f.interceptMask|=weapon->GetInterceptedByShieldType();
        f.plasma=f.plasma || ((weapon->GetInterceptedByShieldType()&1)!=0 && w.ballistic);
        const float alpha=w.def->GetAlpha()*scale;
        const float reload=cycle;
        dps+=alpha/reload;
        if(alpha>f.alpha) { f.alpha=alpha; f.reload=reload; }
        f.shotEnergy=std::max(f.shotEnergy,w.def->GetCostEShot()*scale);
        f.operatingEnergy+=w.def->GetCostEShot()*scale/reload;
    }
    // Multiple independent weapons keep their damage rate without pretending
    // the largest alpha can be fired every subweapon reload.
    if(dps>0) f.reload=f.alpha/dps;
    std::unique_ptr<springai::WeaponDef> shieldDef(def->GetDef()->GetShieldDef());
    if(shieldDef) {
        std::unique_ptr<springai::Shield> shield(shieldDef->GetShield());
        f.coverage=shield->GetRadius(); f.shieldMask=shield->GetInterceptType();
        f.shieldRegen=shield->GetPowerRegen();
        f.operatingEnergy=std::max(f.operatingEnergy,shield->GetPowerRegenResource(ai->GetEconomyManager()->GetEnergyRes()));
        f.warmup=std::max(0.f,shield->GetPower()-shield->GetStartingPower())/std::max(1.f,shield->GetPowerRegen());
        if(def->GetShieldMount()) f.shieldWeapon=def->GetShieldMount()->GetWeaponMountId();
    }
    return defenseFacts.emplace(def->GetId(),f).first->second;
}

std::array<float,dp::COUNT> CCommanderController::DefenseCapacity(CCircuitDef* def,const dp::Rule& rule,const AIFloat3* site) {
    std::array<float,dp::COUNT> result{};
    const auto& facts=DefenseFactsFor(def);
    // Allocate each weapon's firing time once across its eligible demands.
    // A multi-purpose defense is not credited with full DPS in every channel.
    const auto world=ai->GetMilitaryManager()->GetRangedWorld();
    const auto& weapons=world->CapabilitiesFor(def).weapons;
    for(size_t i=0;i<weapons.size();++i) {
        const auto& w=weapons[i];
        float total=0;
        std::array<float,dp::NUCLEAR> shares{};
        for(int k=0;k<dp::NUCLEAR;++k) {
            if((w.category & defenseDemand[k].category)==0 || w.damage.empty()) continue;
            // Zero contribution cannot affect allocation; avoid its terrain ray.
            if(rule.weights[k]*defenseDemand[k].health==0.f) continue;
            if(site && (site->SqDistance2D(defenseTargets[k])>SQUARE(world->Range(w,*site,defenseTargets[k]))
                || !world->Trajectory(w,*site,defenseTargets[k]))) continue;
            shares[k]=rule.weights[k]*defenseDemand[k].health;total+=shares[k];
        }
        if(total<=0) continue;
        for(int k=0;k<dp::NUCLEAR;++k) {
            const auto& demand=defenseDemand[k];
            if(shares[k]<=0 || demand.units<=0) continue;
            const float hits=w.continuous?commander::CollisionHits(demand.radius,w.speed*FRAMES_PER_SEC):1.f;
            const float alpha=w.damage[std::min(size_t(std::max(0,demand.armor)),w.damage.size()-1)]*w.alphaScale*facts.weapons[i].alphaScale*hits;
            result[k]+=dp::FireCapacity(alpha,facts.weapons[i].reload,rule.window,demand.health/demand.units,rule.efficiency)*shares[k]/total;
        }
    }
    if(rule.weights[dp::NUCLEAR]>0 && facts.coverage>0 && facts.shieldWeapon<0) result[dp::NUCLEAR]=1;
    if(rule.weights[dp::PLASMA]>0 && (facts.shieldMask&1)!=0) result[dp::PLASMA]=def->GetMaxShield()+facts.shieldRegen*rule.window;
    return result;
}

void CCommanderController::AssessGroupDefense(CCircuitUnit* anchor,int frame) {
    if(frame<defenseNext) return;
    defenseNext=frame+FRAMES_PER_SEC;
    defenseDemand={}; defenseUrgent={}; defenseActive={}; defensePending={}; defenseCounts={};
    defenseLocalDanger=false;
    defensePlasmaAlpha=0;
    defenseReservedMetal=defenseReservedEnergy=0;
    const auto center=anchor->GetPos(frame);
    defenseTargets.fill(center);
    if(!OnMap(defenseStation) || center.SqDistance2D(defenseStation)>SQUARE(defenseSettings.stableDistance)) {
        defenseStation=center; defenseStableSince=frame;
    }
    const auto& snapshot=ai->GetAllyTeam()->GetCombatSnapshot();
    snapshot.Want(frame);
    const auto add=[&](const CCombatSnapshot::Entry& e,bool strategic) {
        auto* def=ai->GetCircuitDefSafe(e.defId);
        if(!def) {
            // Unknown contacts cannot unlock a counter, but must not certify a
            // safe construction area for the long-range-plasma exception.
            if(center.SqDistance2D(AIFloat3(e.pos.x,0,e.pos.z))<=SQUARE(defenseSettings.radius)) defenseLocalDanger=true;
            return;
        }
        const float age=std::max(0,frame-e.lastObserved)/float(FRAMES_PER_SEC);
        const float confidence=dp::Confidence(age,strategic?defenseSettings.strategicMemory:defenseSettings.memory);
        if(confidence<=0) return;
        const AIFloat3 at(e.pos.x,e.elevation,e.pos.z);
        const float distance=std::sqrt(center.SqDistance2D(at));
        const auto& facts=DefenseFactsFor(def);
        if(strategic) {
            if(facts.nuclear) {
                auto& demand=defenseDemand[dp::NUCLEAR]; demand.health+=confidence; demand.value+=def->GetCostM()*confidence;
            } else if(facts.plasma && distance<=ai->GetBattle()->EffectiveRange(def,at,center)) {
                defensePlasmaAlpha=std::max(defensePlasmaAlpha,facts.alpha);
                auto& demand=defenseDemand[dp::PLASMA];
                demand.health+=facts.alpha*std::ceil(30.f/std::max(.1f,facts.reload))*confidence; demand.value+=def->GetCostM()*confidence;
                defenseTargets[dp::PLASMA]=at;
            }
        }
        if(distance>defenseSettings.radius || (!def->IsAbleToFly() && !GroupSiteAllowed(anchor,at))) return;
        if(facts.alpha<=0) return;
        defenseLocalDanger=true;
        const int k=def->IsAbleToFly()?dp::AIR:!def->IsMobile()?dp::STATIC:
            (def->GetCostM()>=defenseSettings.heavyMetal || def->GetHealth()>=defenseSettings.heavyHealth)?dp::HEAVY:dp::LIGHT;
        auto& demand=defenseDemand[k];
        if(e.los && distance<=facts.range+anchor->GetCircuitDef()->GetRadius()) defenseUrgent[k]=true;
        demand.health+=def->GetHealth()*confidence; demand.value+=def->GetCostM()*confidence; demand.units+=confidence;
        if(def->GetHealth()>demand.largest) {
            demand.largest=def->GetHealth(); demand.armor=def->GetDef()->GetArmorType();
            demand.category=def->GetCategory();demand.radius=def->GetRadius();defenseTargets[k]=at;
        }
    };
    snapshot.Query({center.x,center.z},defenseSettings.radius,[&](const auto& e) {
        // Strategic entries are also local contacts; visit them only once below.
        auto* def=ai->GetCircuitDefSafe(e.defId);
        if(def && !def->IsMobile() && (def->GetMaxRange()>=3000 || (def->IsRoleSuper() && def->IsAttrStock()))) return;
        add(e,false);
    });
    for(const auto& e:snapshot.StrategicContacts()) add(e,true);
    if(frame-ai->GetAllyTeam()->LastNuclearWarning()<defenseSettings.strategicMemory*FRAMES_PER_SEC)
        defenseDemand[dp::NUCLEAR].health=std::max(1.f,defenseDemand[dp::NUCLEAR].health);
    if(GroupNearCombat(anchor) && defenseDemand[dp::LIGHT].health<defenseSettings.baselineHealth) {
        defenseDemand[dp::LIGHT].health=defenseSettings.baselineHealth;
        defenseDemand[dp::LIGHT].units=std::max(1.f,defenseDemand[dp::LIGHT].units);
    }
    AssessDefenseCoverage(anchor,frame);
}

void CCommanderController::AssessDefenseCoverage(CCircuitUnit* anchor,int frame) {
    const auto center=anchor->GetPos(frame);
    defenseShieldRadius=0;
    // One local friendly query per group publication, not per rule or worker.
    // Radius includes the largest configured protective footprint. Arrays are
    // reused; immutable catalog data is lazy per definition, policy always live.
    float radius=defenseSettings.radius;
    for(const auto& rule:defenseRules) if(auto* def=ai->GetCircuitDefSafe(rule.def))
        radius=std::max(radius,DefenseFactsFor(def).coverage);
    auto ids=ai->GetCallback()->GetFriendlyUnitIdsIn(center,radius,false);
    const auto add=[&](int id,CCircuitDef* def,springai::Unit* native,const AIFloat3& at) {
        if(!def || def->IsMobile() || (!def->HasSurfToLand() && !def->HasSurfToAir()
            && def->GetShieldRadius()<=0 && !def->IsAttrStock())) return;
        dp::Rule fallback;fallback.weights[dp::LIGHT]=fallback.weights[dp::HEAVY]=fallback.weights[dp::AIR]=fallback.weights[dp::STATIC]=1;
        const dp::Rule* rule=&fallback;
        for(int i=0;i<dp::MAX_RULES;++i) if(defenseRules[i].def==def->GetId()) {
            rule=&defenseRules[i];
            if(at.SqDistance2D(center)<=SQUARE(cfg->group.radius)) ++defenseCounts[i];
            break;
        }
        const auto& facts=DefenseFactsFor(def);
        if(facts.coverage>0) fallback.weights[facts.shieldWeapon>=0?dp::PLASMA:dp::NUCLEAR]=1;
        auto capacity=DefenseCapacity(def,*rule,&at);
        const bool building=native->IsBeingBuilt();
        // Guns/interceptors without an on/off switch are operational even
        // when Unit_isActivated is false. Sensor activation is not a gun gate.
        const bool active=!building && !native->IsParalyzed() && (!facts.onOff || native->IsActivated());
        float shieldPower=0;
        if(active && def->GetShieldMount()) {
            std::unique_ptr<springai::Weapon> shield(native->GetWeapon(def->GetShieldMount()));
            if(shield && shield->IsShieldEnabled()) shieldPower=shield->GetShieldPower();
        }
        for(int k=0;k<dp::COUNT;++k) {
            if(capacity[k]<=0) continue;
            const bool covers=k>=dp::NUCLEAR?at.SqDistance2D(center)<=SQUARE(facts.coverage):
                at.SqDistance2D(defenseTargets[k])<=SQUARE(facts.range);
            if(!covers) continue;
            if(k==dp::PLASMA && active && shieldPower>=std::min(def->GetMaxShield(),defensePlasmaAlpha)
                && shieldPower>0 && facts.coverage>defenseShieldRadius) {
                defenseShieldCenter=at;defenseShieldRadius=facts.coverage;
            }
            if(building) {
                if(k==dp::PLASMA) defensePending[k]=std::max(defensePending[k],capacity[k]);
                else defensePending[k]+=capacity[k];
            } else if(active) {
                if(k==dp::NUCLEAR) {
                    capacity[k]=std::max(0,native->GetStockpile());
                    // Only the next queued interceptor is near-term capacity;
                    // a queue of twenty is not twenty ready defensive missiles.
                    if(native->GetStockpileQueued()>0) defensePending[k]+=1;
                }
                if(k==dp::PLASMA) {
                    const bool funded=ai->GetTeamUnit(id)?!ai->GetEconomyManager()->IsEnergyStalling():
                        native->GetResourceUse(ai->GetEconomyManager()->GetEnergyRes())>=facts.operatingEnergy*.5f;
                    const float regeneration=funded?facts.shieldRegen*rule->window:0;
                    defensePending[k]=std::max(defensePending[k],funded?capacity[k]:shieldPower);
                    capacity[k]=shieldPower+regeneration;
                    defenseActive[k]=std::max(defenseActive[k],capacity[k]);
                } else defenseActive[k]+=capacity[k];
            }
        }
    };
    for(int id:ids) {
        auto* own=ai->GetTeamUnit(id);
        auto* friendly=own?static_cast<CAllyUnit*>(own):ai->GetFriendlyUnit(id);
        if(friendly) add(id,friendly->GetCircuitDef(),friendly->GetUnit(),friendly->GetPos(frame));
    }
    // Fresh allied nanoframes are neutral until BAR's 5% threshold. Copy IDs
    // before further callback queries; count their pending capacity exactly once.
    for(auto* neutral:ai->GetCallback()->GetNeutralUnitsIn(center,radius,false)) {
        if(neutral->GetAllyTeam()!=ai->GetAllyTeamId()) continue;
        const int id=neutral->GetUnitId();
        // Recoil's friendly query excludes neutral units, so these sets are disjoint.
        ids.push_back(id);
        add(id,ai->GetCircuitDefSafe(ai->GetCallback()->Unit_GetDefId(id)),neutral,neutral->GetPos());
    }
    defenseRepresented.Clear();
    for(int id:ids) defenseRepresented.Add(id);
    ai->GetAllyTeam()->GetDefenseClaims().Nearby(center.x,center.z,radius,frame,[&](int owner,const dp::Claim& c) {
        if(owner==ai->GetTeamId() && c.frameId<0) { defenseReservedMetal+=c.metal; defenseReservedEnergy+=c.energy; }
        // Frames were counted above. A neutral fresh frame remains represented
        // by its claim until the friendly callback can see it.
        if(c.frameId>=0 && defenseRepresented.Contains(c.frameId)) return;
        auto* def=ai->GetCircuitDefSafe(c.def); if(!def) return;
        const auto& facts=DefenseFactsFor(def);
        dp::Rule fallback;fallback.weights[dp::LIGHT]=fallback.weights[dp::HEAVY]=fallback.weights[dp::AIR]=fallback.weights[dp::STATIC]=1;
        if(facts.coverage>0) fallback.weights[facts.shieldWeapon>=0?dp::PLASMA:dp::NUCLEAR]=1;
        const dp::Rule* rule=&fallback;
        // Claims carry planar geometry. Use the cached terrain grid, not an
        // engine callback per claim; zero height would reject elevated lanes.
        const AIFloat3 at(c.x,ai->GetTerrainManager()->GetAreaData()->GetElevationAt(c.x,c.z),c.z);
        for(int i=0;i<dp::MAX_RULES;++i) if(defenseRules[i].def==c.def) {
            rule=&defenseRules[i];
            if(at.SqDistance2D(center)<=SQUARE(cfg->group.radius)) ++defenseCounts[i];
            break;
        }
        // Foreign-faction guns count even when this group's build catalog does
        // not contain them. Claims use the same real-site trajectory as frames.
        const auto cap=DefenseCapacity(def,*rule,&at);
        for(int k=0;k<dp::COUNT;++k) if(at.SqDistance2D(k>=dp::NUCLEAR?center:defenseTargets[k])<=SQUARE(k>=dp::NUCLEAR?facts.coverage:facts.range)) {
            if(k==dp::PLASMA) defensePending[k]=std::max(defensePending[k],cap[k]);
            else defensePending[k]+=cap[k];
        }
    });
    defensePending[dp::PLASMA]=std::max(0.f,defensePending[dp::PLASMA]-defenseActive[dp::PLASMA]);
}

CCommanderController::DefenseBuilders CCommanderController::GatherDefenseBuilders(CCircuitUnit* anchor) {
    DefenseBuilders result{};
    const int frame=ai->GetLastFrame(); const auto center=anchor->GetPos(frame);
    const std::array<int,6> roster={{anchor->GetId(),groupUnit,groupMembers[0],groupMembers[1],groupMembers[2],groupMembers[5]}};
    for(size_t seat=0;seat<roster.size();++seat) {
        const int id=roster[seat];
        // A replacement anchor also occupies its original constructor seat.
        if(std::find(roster.begin(),roster.begin()+seat,id)!=roster.begin()+seat) continue;
        auto* worker=ai->GetTeamUnit(id);
        if(!worker || !worker->IsFinished() || !worker->GetCircuitDef()->IsBuilder()
            || control::SuspensionOf(worker,frame)!=control::Suspension::NONE || HealthRetreat(worker) || EnergyRetreat(worker)
            || (worker->GetTask() && worker->GetTask()->GetType()==IUnitTask::Type::RETREAT)) continue;
        const float distance=std::sqrt(worker->GetPos(frame).SqDistance2D(center));
        if(distance>cfg->group.radius) continue;
        auto* current=dynamic_cast<IBuilderTask*>(worker->GetTask());
        if(current && current->GetTarget() && !current->GetTarget()->IsFinished()) continue;
        const float travel=std::max(0.f,distance-worker->GetCircuitDef()->GetBuildDistance())/std::max(1.f,worker->GetCircuitDef()->GetSpeed());
        result[seat]={worker->GetCircuitDef(),travel};
    }
    return result;
}

dp::Project CCommanderController::DefenseProject(CCircuitDef* def,const DefenseFacts& facts,const DefenseBuilders& builders) {
    dp::Project p; p.metal=def->GetCostM()+facts.ammunitionMetal; p.energy=def->GetCostE()+facts.ammunitionEnergy; p.buildTime=def->GetBuildTime();
    p.operatingEnergy=facts.operatingEnergy; p.shotEnergy=facts.shotEnergy; p.warmup=facts.warmup;
    bool initiator=false;
    for(const auto& worker:builders) {
        if(!worker.def) continue;
        const bool builds=worker.def->CanBuild(def);
        initiator=initiator || builds;
        if(builds || worker.def->IsAbleToAssist()) {
            // WorkerTime is real build power. GetBuildSpeed is the tuned
            // resource-pull estimate and cannot predict construction seconds.
            p.buildPower+=worker.def->GetWorkerTime();
            p.travel=std::max(p.travel,worker.travel);
        }
    }
    if(!initiator) p.buildPower=0;
    return p;
}

IUnitTask* CCommanderController::GroupPlannedDefense(CCircuitUnit* unit,CCircuitUnit* anchor,int frame,int minimumBand) {
    if(defenseSettings.enabled<=0) return nullptr;
    AssessGroupDefense(anchor,frame);
    auto* eco=ai->GetEconomyManager();
    const dp::Economy economy{std::max(0.f,eco->GetMetalCur()-defenseReservedMetal),std::max(0.f,eco->GetEnergyCur()-defenseReservedEnergy),eco->GetAvgMetalIncome(),eco->GetAvgEnergyIncome(),eco->GetMetalPullCor(),eco->GetEnergyPullCor()};
    dp::Evaluation best=defenseEvaluation; int selected=defenseChoice;
    if(frame>=defenseDecisionNext) {
    defenseDecisionNext=frame+FRAMES_PER_SEC;best={};selected=-1;
    // Observe six seats once per decision, not once per rule. The immutable
    // definition pointers remain local to this callback; no worker cache ages.
    const auto builders=GatherDefenseBuilders(anchor);
    std::string blocked="no_demand";int blockedBand=-1;
    for(int i=0;i<dp::MAX_RULES;++i) {
        const auto& rule=defenseRules[i];
        auto* def=ai->GetCircuitDefSafe(rule.def);
        if(!def || rule.priority<=0 || !def->IsAvailable(frame) || frame<defensePlacementRetry[i]) continue;
        if(rule.weights[dp::STATIC]>0 && frame-defenseStableSince<defenseSettings.stableSeconds*FRAMES_PER_SEC) continue;
        const auto& facts=DefenseFactsFor(def);
        auto capacity=DefenseCapacity(def,rule);
        if(rule.weights[dp::STATIC]>0 && anchor->GetPos(frame).SqDistance2D(defenseTargets[dp::STATIC])>SQUARE(facts.range)) capacity[dp::STATIC]=0;
        const float benefit=dp::Marginal(defenseDemand,defenseActive,defensePending,capacity,rule,def->GetCostM());
        const auto project=DefenseProject(def,facts,builders);
        auto result=dp::Evaluate(rule,project,economy,benefit,defenseCounts[i]);
        bool immediate=false;
        for(int k=0;k<dp::STATIC;++k) immediate=immediate || (defenseUrgent[k] && rule.weights[k]>0 && capacity[k]>0
            && dp::Residual(defenseDemand[k].health,defenseActive[k],defensePending[k])>0
            && defenseDemand[k].value>=def->GetCostM()*rule.valueRatio);
        result.band=dp::UrgencyBand(rule.band,int(defenseSettings.urgentBand),immediate,benefit);
        const auto surplus=dp::EvaluateSurplus(defenseSettings,rule,project,economy,defenseCounts[i]);
        if(dp::Better(surplus,result)) result=surplus;
        if(benefit>0 && result.reason!=dp::Reason::READY && rule.band>blockedBand) {
            blocked=def->GetDef()->GetName()+std::string(" ")+dp::Name(result.reason);blockedBand=rule.band;
        }
        if(std::getenv("CIRCUIT_COMMANDER_TRACE") && frame%(5*FRAMES_PER_SEC)<FRAMES_PER_SEC)
            ai->LOG("[DefensePlanner] assess def=%s demand=%.0f/%.0f/%.0f benefit=%.3f reason=%s ready=%.1f count=%i",
                def->GetDef()->GetName(),defenseDemand[dp::LIGHT].health,defenseDemand[dp::HEAVY].health,
                defenseDemand[dp::NUCLEAR].health,benefit,dp::Name(result.reason),result.ready,defenseCounts[i]);
        if(dp::Better(result,best)) { best=result; selected=i; }
    }
    defenseChoice=selected;
    defenseEvaluation=best;
    defenseReason=selected<0?blocked:ai->GetCircuitDefSafe(defenseRules[selected].def)->GetDef()->GetName();
    }
    // The priority probe and ordinary fallback reuse the same cached assessment
    // and winner. Reject below-band offers before capability/site/claim work.
    if(selected<0 || best.band<minimumBand || frame<defenseOfferNext) return nullptr;
    if(groupNanoDue && best.band<3) return nullptr; // strategic urgency may defer, never erase, the nano obligation
    auto* def=ai->GetCircuitDefSafe(defenseRules[selected].def);
    if(!unit->GetCircuitDef()->CanBuild(def)) return nullptr; // preserve choice for the capable seat
    const auto project=DefenseProject(def,DefenseFactsFor(def),GatherDefenseBuilders(anchor));
    const auto admission=best.surplus
        ?dp::EvaluateSurplus(defenseSettings,defenseRules[selected],project,economy,defenseCounts[selected])
        :dp::Evaluate(defenseRules[selected],project,economy,1,defenseCounts[selected]);
    if(admission.reason!=dp::Reason::READY) { defenseDecisionNext=0; return nullptr; }
    defenseOfferNext=frame+FRAMES_PER_SEC;
    const auto center=anchor->GetPos(frame);
    // Snapshot scoring is shared for one second, but a neighboring AI may
    // reserve protection earlier in this very frame. Revalidate that small
    // ledger at the transaction boundary, before any expensive placement.
    if(PendingProtection(def,center)) { defenseReason="allied_protection_committed";defenseNext=defenseDecisionNext=0;return nullptr; }
    // Fixed bounded sites, expensive placement only for the winning proposal.
    // Existing task placement owns reachability, lane, threat and layout claims.
    const std::array<AIFloat3,5> offsets={AIFloat3(0,0,0),AIFloat3(192,0,0),AIFloat3(-192,0,0),AIFloat3(0,0,192),AIFloat3(0,0,-192)};
    for(const auto& offset:offsets) if(auto* task=GroupBuild(unit,def,center+offset,false,selected,best.surplus)) {
        ai->LOG("[DefensePlanner] choice=%s band=%i ready=%.1f score=%.5f surplus=%i",def->GetDef()->GetName(),best.band,best.ready,best.score,int(best.surplus));
        TrackGroupJob(task); defenseNext=defenseDecisionNext=0;
        return task;
    }
    defenseReason+=" placement_blocked";
    // Give the next shared decision an opportunity to choose an alternative.
    // No live project is cancelled and retry remains at the existing cadence.
    defensePlacementRetry[selected]=frame+2*FRAMES_PER_SEC;
    defenseDecisionNext=0;
    return nullptr;
}

bool CCommanderController::IsGroupStructure(int id) const {
    if(id==groupNano || id==groupDef || id==groupRadar || id==groupJammer || id==groupAA
        || id==groupDef2 || id==groupRadar2 || id==groupJammer2 || id==groupAA2) return true;
    if(defenseSettings.enabled>0) for(const auto& r:defenseRules) if(r.def==id && r.priority>0) return true;
    return false;
}

bool CCommanderController::GroupLaneWorkAllowed(CCircuitUnit* unit,CCircuitDef* def,const AIFloat3& at) const {
    const int frame=ai->GetLastFrame();
    // A known LRPC can mark the entire rear lane ENEMY. It must not prohibit
    // its own shield counter forever. Reuse this second's local assessment;
    // ordinary threat, reachability, health and corridor checks still apply.
    const bool protectedStructure=def && IsGroupStructure(def->GetId()) && defenseShieldRadius>0
        && at.SqDistance2D(defenseShieldCenter)<=SQUARE(defenseShieldRadius);
    return dp::AllowProtectedWork(ai->GetBattle()->LaneWorkAllowed(at),
        defenseSettings.enabled>0 && defenseSettings.shieldInPlasmaZone>0 && frame<defenseNext,
        (def && def->GetShieldRadius()>0) || protectedStructure,defenseDemand[dp::PLASMA].health>0,defenseLocalDanger,
        frame-unit->GetDamagedFrame()<defenseSettings.shieldSafeSeconds*FRAMES_PER_SEC);
}

bool CCommanderController::PendingProtection(CCircuitDef* def,const AIFloat3& center) {
    if(!def || !OnMap(center)) return false;
    const auto& selected=DefenseFactsFor(def);
    if(selected.coverage<=0) return false;
    bool found=false;
    ai->GetAllyTeam()->GetDefenseClaims().Nearby(center.x,center.z,0,ai->GetLastFrame(),[&](int,const dp::Claim& c) {
        auto* other=ai->GetCircuitDefSafe(c.def);if(!other) return;
        const auto& facts=DefenseFactsFor(other);
        if(std::hypot(c.x-center.x,c.z-center.z)>facts.coverage) return;
        if((selected.shieldWeapon>=0 && facts.shieldWeapon>=0)
            || (selected.shieldWeapon<0 && facts.shieldWeapon<0 && facts.coverage>0)) {
            found=true;
            if(std::getenv("CIRCUIT_COMMANDER_TRACE") && ai->GetLastFrame()%(5*FRAMES_PER_SEC)<FRAMES_PER_SEC)
                ai->LOG("[DefensePlanner] protection_claim def=%s frame=%i x=%.0f z=%.0f",other->GetDef()->GetName(),c.frameId,c.x,c.z);
        }
    });
    return found;
}

void CCommanderController::SyncDefenseClaim(IBuilderTask* build,int& token) {
    auto& claims=ai->GetAllyTeam()->GetDefenseClaims();
    auto* def=build?build->GetBuildDef():nullptr;
    InitJammerRadii();
    const float jamRadius=def && size_t(def->GetId())<jammerRadii.size()?jammerRadii[def->GetId()]:0;
    if(!def || build->IsDead() || def->IsMobile() || !OnMap(build->GetPosition())
        || (!def->HasSurfToLand() && !def->HasSurfToAir() && def->GetShieldRadius()<=0 && !def->IsAttrStock() && jamRadius<=0)) {
        if(token) claims.Erase(ai->GetTeamId(),token);
        token=0;return;
    }
    const auto at=build->GetPosition();
    const auto& facts=DefenseFactsFor(def);
    claims.Upsert(ai->GetTeamId(),token,{def->GetId(),build->GetTarget()?build->GetTarget()->GetId():-1,
        std::numeric_limits<int>::max(),at.x,at.z,std::max({facts.range,facts.coverage,jamRadius}),def->GetCostM(),def->GetCostE()});
}
}
