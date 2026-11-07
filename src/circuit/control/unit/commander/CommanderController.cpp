#include "control/unit/commander/CommanderController.h"
#include "map/MapManager.h"
#include "terrain/BattleAnalysis.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/FactoryManager.h"
#include "module/MilitaryManager.h"
#include "control/core/ControlledTask.h"
#include "control/core/Ownership.h"
#include "task/RetreatTask.h"
#include "task/fighter/RangedWorld.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "setup/SetupManager.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "terrain/TerrainManager.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Damage.h"
#include "Log.h"
#include "WeaponMount.h"
#include "Sim/Units/CommandAI/Command.h"
#include <array>
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <sstream>

namespace circuit {
using springai::AIFloat3;
using commander::Point;
static Point P(const AIFloat3& p) { return {p.x,p.z}; }
static AIFloat3 F(Point p,float y=0) { return {p.x,y,p.z}; }
static const bool commanderTrace=std::getenv("CIRCUIT_COMMANDER_TRACE")!=nullptr;

namespace {
// D-388: every commander lever, once. The same table validates behaviour.json
// presets and the script's SetCommanderCombatOption; ranges are the pre-D-388
// SetOption ranges. Accessors are captureless, so they decay to function pointers.
using Field=control::ConfigField<CommanderConfig>;
template<auto M> Field Combat(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.combat.*M;},lo,hi}; }
template<auto M> Field Safety(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.safety.*M;},lo,hi}; }
template<auto M> Field Cloak(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.cloak.*M;},lo,hi}; }
template<auto M> Field Group(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.group.*M;},lo,hi}; }
template<auto M> Field Front(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.front.*M;},lo,hi}; }
template<auto M> Field T3(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.t3.*M;},lo,hi}; }
template<auto M> Field Fall(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.fallback.*M;},lo,hi}; }
template<auto M> Field Work(const char* n,float lo,float hi) { return {n,[](CommanderConfig& c)->float&{return c.work.*M;},lo,hi}; }
using CC=CommanderCombatConfig; using SC=CommanderSafetyConfig; using KC=CommanderCloakConfig;
using GC=CommanderGroupConfig; using FC=CommanderFrontConfig; using TC=CommanderT3Config;
using BC=CommanderFallbackConfig; using WC=CommanderWorkConfig;

const control::CConfigTable<CommanderConfig>& ConfigTable() {
    static const control::CConfigTable<CommanderConfig> table({
        Combat<&CC::scan>("scan",400,2000),Combat<&CC::leash>("leash",100,10000),
        Combat<&CC::step>("step",16,160),Combat<&CC::support>("support",0,10000),
        Combat<&CC::minValue>("min_value",0,20000),Combat<&CC::killReward>("kill_reward",0,1000),
        Combat<&CC::hpReserve>("hp_reserve",.1f,.85f),Combat<&CC::retreat>("retreat",.1f,.9f),
        Combat<&CC::recover>("recover",.3f,1),Combat<&CC::aggression>("aggression",0,1),
        Combat<&CC::shots>("shots",1,4),Combat<&CC::margin>("margin",0,5000),
        Combat<&CC::escapeSeconds>("escape_seconds",1,10),Combat<&CC::alignSeconds>("align_seconds",0,2),
        Combat<&CC::maxApproach>("max_approach",0,400),Combat<&CC::maxSeconds>("max_seconds",2,30),
        Combat<&CC::cloakSeconds>("cloak_seconds",0,5),Combat<&CC::donorReserve>("donor_reserve",0,50000),
        Combat<&CC::friendlyMargin>("friendly_margin",0,100),Combat<&CC::normalRange>("normal_range",.5f,1),
        Combat<&CC::detectionMargin>("detection_margin",8,200),
        Combat<&CC::moveResendSeconds>("move_resend_seconds",0,3),
        Combat<&CC::afusDefenceRadius>("afus_defence_radius",0,5000),
        Combat<&CC::sensorMemory>("sensor_memory",0,120),
        Safety<&SC::jamSafe>("jam_safe",0,1),Safety<&SC::jamHeavyCost>("jam_heavy_cost",0,100000),
        Safety<&SC::cloakEnergyRetreat>("cloak_energy_retreat",0,1),
        Safety<&SC::cloakRetreatDistance>("cloak_retreat_distance",128,2000),
        Safety<&SC::healthRetreat>("health_retreat",0,1),Safety<&SC::healthShotSeconds>("health_shot_seconds",0,5),
        Safety<&SC::decoyHealthRetreat>("decoy_health_retreat",0,1),Safety<&SC::decoyHealthRecover>("decoy_health_recover",0,1),
        Safety<&SC::decoyBait>("decoy_bait",0,1),
        // D-389 cloak posture
        Cloak<&KC::posture>("cloak_posture",0,1),Cloak<&KC::threatRadius>("threat_radius",400,4000),
        Cloak<&KC::horizon>("threat_horizon",0,15),Cloak<&KC::outrangeMargin>("outrange_margin",0,500),
        Cloak<&KC::outrangeDps>("outrange_dps",0,100000),Cloak<&KC::artilleryDps>("artillery_dps",0,100000),
        Cloak<&KC::artilleryRange>("artillery_range",200,3000),
        Cloak<&KC::retreatSeconds>("withdraw_seconds",0,60),Cloak<&KC::escapeSeconds>("escape_cloak_seconds",0,30),
        Cloak<&KC::brawlMargin>("brawl_margin",.5f,5),Cloak<&KC::dgunKills>("dgun_kills",0,10),
        Cloak<&KC::ambushSeconds>("ambush_seconds",0,120),Cloak<&KC::withdrawCloakSeconds>("withdraw_cloak_seconds",0,60),
        Cloak<&KC::memorySeconds>("threat_memory_seconds",0,600),Cloak<&KC::memoryCap>("threat_memory_cap",0,3000),
        Cloak<&KC::frontIncome>("front_cloak_income",0,1000000),
        Cloak<&KC::decoyFrontIncome>("decoy_front_cloak_income",0,1000000),
        Cloak<&KC::budget>("cloak_budget",0,1),Cloak<&KC::stillSeconds>("cloak_still_seconds",0,60),
        Cloak<&KC::period>("posture_period",3,300),Cloak<&KC::log>("cloak_log",0,1),
        Cloak<&KC::blipDps>("blip_dps",0,10000),Cloak<&KC::blipRange>("blip_range",0,3000),
        Group<&GC::combatDistance>("commander_group_combat_distance",0,4000),
        Group<&GC::combatMemory>("commander_group_combat_memory",0,120),
        Group<&GC::radius>("commander_group_radius",128,2000),
        Group<&GC::maintenance>("commander_group_maintenance",0,1),
        Group<&GC::lineReviewSeconds>("commander_group_line_review_seconds",1,60),
        Group<&GC::projectHoldSeconds>("commander_group_project_hold_seconds",0,120),
        Group<&GC::jammerEdge>("commander_group_jammer_edge",0,1000),
        Group<&GC::jammerGain>("commander_group_jammer_gain",0,1),
        Group<&GC::jammerSpacing>("commander_group_jammer_spacing",0,2),
        Group<&GC::jammerHold>("commander_group_jammer_hold",0,120),
        Group<&GC::jammerOutage>("commander_group_jammer_outage",0,600),
        Group<&GC::jammerIncome>("commander_group_jammer_income",0,100000),
        Group<&GC::sensorDefenseBand>("commander_group_sensor_defense_band",0,100),
        Group<&GC::defenceMetal>("commander_group_defence_metal",0,100000),
        Group<&GC::defenceEnergy>("commander_group_defence_energy",0,1000000),
        Group<&GC::budgetSeconds>("commander_group_budget_seconds",0,120),
        Group<&GC::budgetFraction>("commander_group_budget_fraction",0,1),
        Group<&GC::mexUpgrade>("commander_group_mex_upgrade",0,1),
        Group<&GC::mexPriority>("commander_group_mex_priority",0,100),
        Group<&GC::radarPriority>("commander_group_radar_priority",0,100),
        Group<&GC::linePriority>("commander_group_line_priority",0,100),
        Front<&FC::workers>("front_workers",1,20),Front<&FC::mexAA>("front_mex_aa",-1,100000),
        Front<&FC::radarSpacing>("front_radar_spacing",64,4000),Front<&FC::mexLos>("front_mex_los",0,1),
        Front<&FC::persistent>("front_persistent",0,1),Front<&FC::mexDefence>("front_mex_defence",0,1),
        Front<&FC::mexMinIncome>("front_mex_min_income",0,10000),Front<&FC::mexBaseRadius>("front_mex_base_radius",0,10000),
        Front<&FC::lineEnabled>("front_line_enabled",0,1),Front<&FC::lineFog>("front_line_fog",0,4000),
        Front<&FC::fortifyBank>("front_fortify_bank",0,1),Front<&FC::fortifyPriority>("front_fortify_priority",0,2),
        Front<&FC::fortifyAdvance>("front_fortify_advance",0,2000),
        Front<&FC::lineSpacing>("front_line_spacing",.5f,1.8f),Front<&FC::defenceSpacing>("front_defence_spacing",0,2),
        Front<&FC::lineDepth>("front_line_depth",400,4000),Front<&FC::mexOffset>("front_mex_offset",64,400),
        Front<&FC::workBehind>("front_work_behind",0,1000),Front<&FC::corridor>("front_corridor",-1,10000),
        Front<&FC::corridorClass>("front_corridor_class",-1,10),Front<&FC::lineDef>("front_line_def",-1,100000),
        Front<&FC::pushAhead>("front_push_ahead",0,2000),
        // D-356 screen-led push, its end, and the FRONT offer corridor margin
        Front<&FC::pushScreen>("front_push_screen",0,20),Front<&FC::pushUntilSeconds>("front_push_until_seconds",0,7200),
        Front<&FC::pushHomeRiot>("front_push_home_riot",0,100000),Front<&FC::laneMargin>("front_lane_margin",0,2000),
        // D-357 corridor mex sweep
        Front<&FC::mexReach>("front_mex_reach",0,2000),Front<&FC::mexBehind>("front_mex_behind",0,4000),
        Front<&FC::mexAhead>("front_mex_ahead",0,4000),Front<&FC::mexCaptureEnemy>("front_mex_capture_enemy",0,1),
        Front<&FC::mexTurretEvery>("front_mex_turret_every",0,20),Front<&FC::mexEnemyHome>("front_mex_enemy_home",0,4000),
        Front<&FC::distance>("front_distance",200,10000),Front<&FC::standoff>("front_standoff",200,1500),
        Front<&FC::radius>("front_radius",100,1000),Front<&FC::threat>("front_threat",0,50),
        Front<&FC::repairCombat>("front_repair_combat",0,1),
        Front<&FC::solarIncome>("front_solar_income",0,10000),Front<&FC::solarStorage>("front_solar_storage",0,1),
        Front<&FC::solarRadius>("front_solar_radius",32,600),Front<&FC::solarDef>("front_solar_def",-1,100000),
        Front<&FC::mexSeconds>("front_mex_seconds",0,30),Front<&FC::stallSeconds>("front_stall_seconds",3,60),
        Front<&FC::detourSeconds>("front_detour_seconds",0,3),
        T3<&TC::declineGate>("t3_decline_gate",0,1),
        T3<&TC::immediateShot>("t3_immediate_shot",0,1),T3<&TC::positionSeconds>("t3_position_seconds",0,3),
        T3<&TC::intercept>("t3_intercept",0,1),T3<&TC::health>("t3_health",.1f,.5f),
        T3<&TC::distance>("t3_distance",250,2000),
        T3<&TC::leash>("t3_leash",200,4000),T3<&TC::holdSeconds>("t3_hold_seconds",0,30),
        T3<&TC::dodgeSeconds>("t3_dodge_seconds",0,5),T3<&TC::huntLeash>("t3_hunt_leash",200,6000),
        T3<&TC::screen>("t3_screen",0,20000),
        T3<&TC::hunt>("t3_hunt",0,1),T3<&TC::artilleryApproach>("t3_artillery_approach",0,400),
        T3<&TC::trade>("t3_trade",0,1),T3<&TC::retrySeconds>("t3_retry_seconds",.3f,10),
        T3<&TC::cloakedVolleyRisk>("t3_cloaked_volley_risk",0,1),
        T3<&TC::baitDef>("t3_bait_def",-1,100000),T3<&TC::baitCount>("t3_bait_count",0,8),
        T3<&TC::baitMargin>("t3_bait_margin",0,1000),T3<&TC::baitDistance>("t3_bait_distance",16,400),
        T3<&TC::baitSpacing>("t3_bait_spacing",32,300),T3<&TC::baitTimeout>("t3_bait_timeout",1,20),
        Fall<&BC::goalHoldSeconds>("fallback_goal_hold_seconds",0,5),
        Fall<&BC::prepareSeconds>("fallback_prepare_seconds",0,30),
        Fall<&BC::metal>("fallback_metal",0,20000),Fall<&BC::rangeScale>("fallback_range_scale",.5f,6),
        Fall<&BC::groupRadius>("fallback_group_radius",50,2000),Fall<&BC::offset>("fallback_offset",0,600),
        Fall<&BC::search>("fallback_search",300,10000),Fall<&BC::holdSeconds>("fallback_hold_seconds",0,30),
        Fall<&BC::porcRange>("fallback_porc_range",200,5000),
        // D-299 work ladder
        Work<&WC::radius>("work_radius",0,3000),Work<&WC::clearance>("work_clearance",0,2000),
        Work<&WC::repairHealth>("repair_health",.5f,1),Work<&WC::reclaimStorage>("reclaim_storage",.1f,1),
        Work<&WC::reclaimEnergy>("reclaim_energy",0,100000),
        Work<&WC::reclaimEnergyStorage>("reclaim_energy_storage",0,1),
        Work<&WC::reclaimEnergyPerMetal>("reclaim_energy_per_metal",1,10000),
        Work<&WC::reclaimRetry>("reclaim_retry_seconds",1,30),
        Work<&WC::reclaimMetal>("reclaim_metal",0,10000),Work<&WC::lineIncome>("line_income",0,1000),
        Work<&WC::lineMin>("line_min",0,20),Work<&WC::lineMax>("line_max",0,20),
        Work<&WC::lineRadius>("line_radius",100,2000),Work<&WC::lineSpacing>("line_spacing",32,400),
        Work<&WC::lineHoldSeconds>("line_hold_seconds",0,600),Work<&WC::lineRetrySeconds>("line_retry_seconds",1,60),
        Work<&WC::timedInterval>("timed_interval",5,600),Work<&WC::timedUntil>("timed_until",0,7200),
        Work<&WC::radarCoverage>("radar_coverage",.1f,1),Work<&WC::baseRadius>("base_radius",200,5000)});
    return table;
}
}

CCommanderController::CCommanderController(CCircuitAI* ai)
    : CUnitControllerBase<CommanderConfig,CommanderState>(ConfigTable()),writer(ai,"CommanderCloak"),ai(ai) {
    writer.SetTrace(commanderTrace);
    ReadProfiles();
}

std::string CCommanderController::DescribeFront(int id) const {
    const State* found=states.Find(id);
    if(!found)return "";
    const auto& s=*found;
    return std::to_string(s.front.frame)+","+std::to_string(int(s.mode))+","+
        std::to_string(s.front.pushScreens)+","+std::to_string(s.front.pushScreenProgress)+","+
        std::to_string(s.front.pushBound)+","+std::to_string(s.front.pushGoalProgress)+","+
        std::to_string(s.front.pushHome?1:0)+","+std::to_string(s.front.point.x)+","+
        std::to_string(s.front.point.z)+","+std::to_string(s.work.task?1:0)+","+std::to_string(int(s.front.reason))+","+
        std::to_string(s.work.reclaimMetalRoom)+","+std::to_string(s.work.reclaimEnergyRoom);
}

bool CCommanderController::ActualDecoy(CCircuitDef* definition) const {
    const auto found=actualDecoys.find(definition->GetId());
    if(found!=actualDecoys.end()) return found->second;
    const std::unique_ptr<springai::UnitDef> impersonated(definition->GetDef()->GetDecoyDef());
    const bool actual=impersonated!=nullptr;
    actualDecoys.emplace(definition->GetId(),actual); return actual;
}
bool CCommanderController::Handles(CCircuitUnit* unit) const {
    return role.enabled && unit && !unit->IsDead() && !unit->IsDestroying()
        && unit->HasDGun() && unit->GetCircuitDef()->IsRoleComm()
        && (role.decoys || !ActualDecoy(unit->GetCircuitDef()));
}
bool CCommanderController::Owns(CCircuitUnit* unit) const {
    return unit && states.Contains(unit->GetId()) && Handles(unit)
        && control::SuspensionOf(unit,ai->GetLastFrame())==control::Suspension::NONE;
}
void CCommanderController::Attach(CCircuitUnit* unit) {
    if(!unit->GetCircuitDef()->IsRoleComm() || states.Contains(unit->GetId())) return;
    const int preset=PresetForDef(unit->GetCircuitDef()->GetId());
    if(preset<0) return;
    State& s=states.Attach(unit->GetId());
    s.preset=preset; s.generation=++sequence;
    if(commanderTrace) ai->LOG("[CommanderTrace] join=%i role=%i dgun=%i decoy=%i preset=%s",unit->GetId(),unit->GetCircuitDef()->IsRoleComm(),unit->HasDGun(),ActualDecoy(unit->GetCircuitDef()),PresetName(preset).c_str());
}
void CCommanderController::TeamUnitRemoved(int id) {
    // Unregister calls this before removing the owned unit. Only mex losses
    // touch obligations: avoid scanning them on every army casualty, and never
    // let an engine ID reused after death inherit an old defense obligation.
    if(id==groupUnit) { groupUnit=-1; groupArrived=false; }
    for(auto& member:groupMembers) if(member==id) member=-1;
    auto* lost=ai->GetTeamUnit(id);
    if(lost && lost->GetCircuitDef()->IsMex()) for(auto& entry:states) {
        auto& pending=entry.value->front.unfortifiedMexes;
        pending.erase(std::remove(pending.begin(),pending.end(),id),pending.end());
    }
    ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),id);
}
void CCommanderController::Detach(int id) {
    writer.Forget(id);
    if(states.Detach(id)) ++operation;
}
void CCommanderController::OnPresetAssigned(int defId,int preset) {
    for(auto& entry:states) {
        auto* unit=ai->GetTeamUnit(entry.id);
        if(unit && unit->GetCircuitDef()->GetId()==defId) entry.value->preset=preset;
    }
}
bool CCommanderController::RetreatCloakFunded(CCircuitUnit* unit) const {
    if(!Handles(unit) || !unit->GetCircuitDef()->IsAbleToCloak()) return false;
    Bind bound(this,PresetOfUnit(unit->GetId()));
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(unit->GetCircuitDef());
    return ai->GetEconomyManager()->GetEnergyCur()>=cap.cloakMoving*cfg->combat.escapeSeconds+cfg->combat.margin;
}
bool CCommanderController::EnergyRetreat(CCircuitUnit* unit) const {
    const State* s=states.Find(unit->GetId());
    return s && s->retreat.energy;
}
void CCommanderController::Damaged(CCircuitUnit* unit) {
    State* found=states.Find(unit->GetId());
    if(!Handles(unit) || !found) return;
    auto& s=*found; const int frame=ai->GetLastFrame();
    // Coalesce simultaneous weapon hits, never delay beyond the current frame.
    if(s.lastDamage==frame) return;
    performance::Scope measured(ai,performance::COMMANDER_DAMAGE);
    Bind bound(this,s.preset);
    s.lastDamage=frame; s.next=frame+3;
    s.conceal.postureNext=0; // D-389: damage re-chooses the posture now
    const float previousReserve=reserve; reserve=std::max(0.f,reserve-std::max(s.budget,s.fundingBudget));
    Tick(unit,s,frame); reserve=std::max(previousReserve,reserve+std::max(s.budget,s.fundingBudget));
}
void CCommanderController::MoveFailed(int id) {
    State* s=states.Find(id); if(!s) return;
    s->route.clear(); ++s->failed;
    // A failed detour MOVE waits out its backoff; re-ticking at once resent
    // it every 3 frames (Entrenched Plains 2026-10-19: ~500 MOVEs/min each).
    if(ai->GetLastFrame()>=s->detourNext) s->next=0;
}
void CCommanderController::WeaponFired(int id,int weapon) {
    State* found=states.Find(id); auto* unit=ai->GetTeamUnit(id);
    if(!found || !Handles(unit) || !unit->GetCircuitDef()->GetDGunDef()
        || unit->GetCircuitDef()->GetDGunDef()->GetDef()->GetWeaponDefId()!=weapon) return;
    auto& s=*found; s.fired=ai->GetLastFrame(); s.pending=-1; s.immediatePending=false; s.next=0;
    // Shot event confirms dispatch, not a kill. Every repeat uses fresh HP.
    if(dynamic_cast<CControlledTask*>(unit->GetTask()))
        Transition(unit,s,Mode::ESCAPE,s.fired);
    ai->LOG("[Commander] unit=%i shot_confirmed frame=%i target=%i",id,s.fired,s.target);
}
float CCommanderController::GetDeficit() const {
    return role.enabled?std::max(0.f,reserve-ai->GetEconomyManager()->GetEnergyCur()):0.f;
}
bool CCommanderController::SetOption(const std::string& name,float value) {
    if(!std::isfinite(value)) return false;
    if(name=="front_defence_definition") {
        if(value==-1) {frontDefenceDefs.clear();return true;}
        if(value<0 || value!=std::floor(value) || value>100000 || !ai->GetCircuitDefSafe(int(value))) return false;
        if(std::find(frontDefenceDefs.begin(),frontDefenceDefs.end(),int(value))==frontDefenceDefs.end())
            frontDefenceDefs.push_back(int(value));
        return true;
    }
    for(unsigned i=0;i<groupMembers.size();++i) if(name=="commander_group_member"+std::to_string(i)) {
        if(value < -1 || value > 100000 || value != std::floor(value)) return false;
        groupMembers[i]=int(value); return true;
    }
    if(name=="commander_group_unit") {
        if(value < -1 || value > 100000 || value != std::floor(value)) return false;
        if(groupUnit!=int(value)) { groupUnit=int(value); groupArrived=false; groupNext=0; }
        return true;
    }
    int* groupOption=name=="commander_group_def"?&groupDef:name=="commander_group_nano"?&groupNano:
        name=="commander_group_radar"?&groupRadar:name=="commander_group_jammer"?&groupJammer:name=="commander_group_aa"?&groupAA:
        name=="commander_group_def2"?&groupDef2:name=="commander_group_radar2"?&groupRadar2:
        name=="commander_group_jammer2"?&groupJammer2:name=="commander_group_aa2"?&groupAA2:nullptr;
    if(groupOption) {
        if(value < -1 || value > 100000 || value != std::floor(value)) return false;
        *groupOption=int(value); return true;
    }
    if(name=="enabled") {
        role.enabled=value>0;
        for(const auto& [id,u]:ai->GetTeamUnits()) if(!states.Contains(id)) Attach(u);
        return true;
    }
    if(name=="advance") {
        if(role.advance!=(value>0)) for(auto& entry:states) entry.value->invalidated=true;
        role.advance=value>0; return true;
    }
    if(name=="decoys") { role.decoys=value>0; return true; }
    if(name=="front_duty") {
        if(role.frontDuty!=(value>0)) for(auto& entry:states) entry.value->invalidated=true;
        role.frontDuty=value>0;
        if(!role.frontDuty) { role.peakEnergyIncome=0; groupUnit=-1; groupMembers.fill(-1); groupArrived=false; }
        return true;
    }
    if(name=="front_ready") { role.frontReady=value>0; return true; }
    if(name=="work") { role.work=value>0; return true; }
    if(name=="front_recovery") { role.frontRecovery=value>0; return true; }
    if(name=="afus_def") {
        if(value<0) afusDefs.clear();
        else if(value>100000 || value!=std::floor(value)) return false;
        else if(auto* def=ai->GetCircuitDefSafe(int(value)); def && !def->IsMobile()) afusDefs.insert(def->GetId());
        else return false;
        return true;
    }
    if(name.rfind("t3.",0)==0) return SetProfileOption(name,value);
    if(name.rfind("reset.t3.",0)==0) return SetProfileOption(name.substr(6),value,true);
    if(name=="fallback") {
        // Disabling releases through the ordinary SUPPORT/Resume path.
        if(role.fallback && value<=0) for(auto& entry:states) entry.value->fallback.until=-1;
        role.fallback=value>0; return true;
    }
    // Every other lever is a preset field; the script sets it for every preset.
    if(!CUnitControllerBase<CommanderConfig,CommanderState>::SetOption(name,value)) return false;
    // Dropping the route or disabling line policy must also release its
    // pending-coverage gate; an old plan must not prevent future advance.
    if((name=="front_corridor" && value<0) || (name=="front_line_enabled" && value<=0)) for(auto& entry:states) {
        auto& state=*entry.value;
        state.front.territoryPlans.clear();state.front.territoryPending=false;state.front.territoryProgress=-1;
        state.front.fortifyNextProgress=0;
        state.front.territoryCorridor=-1;state.front.frame=-10000;
    }
    return true;
}

void CCommanderController::Observe(CCircuitUnit* unit,int frame) {
    performance::Scope measured(ai,performance::COMMANDER_OBSERVE);
    contacts.clear(); threats.clear(); seeds.clear(); attackers.clear(); submergedContact=false; protectedAfus=-1;
    auto& claims=ai->GetAllyTeam()->GetCommanderShots(); claims.Prune(frame);
    auto world=ai->GetMilitaryManager()->GetRangedWorld();
    auto* api=ai->GetUnitAPI(); auto* def=unit->GetCircuitDef();
    const auto pos=unit->GetPos(frame);
    const int armor=def->GetDef()->GetArmorType();
    // D-293: "can attack the commander" means a known weapon whose target
    // category includes this commander and deals damage to its armor class.
    const auto canHit=[&](const CRangedWorld::Capabilities& capabilities) {
        for(const auto& w:capabilities.weapons) {
            if((w.category & def->GetCategory())==0 || w.damage.empty()) continue;
            if(w.damage[std::min(size_t(std::max(0,armor)),w.damage.size()-1)]*w.alphaScale>0) return true;
        }
        return false;
    };
    const auto observeWeapons=[&](int id,const commander::Contact& c,const CRangedWorld::Capabilities& cap) {
        for(const auto& w:cap.weapons) {
            if((w.category & def->GetCategory())==0 || w.damage.empty()) continue;
            // Definition-owned noExplode metadata costs one load-time callback;
            // this O(1) crossing bound prevents treating Behemoth gauss as a
            // single 1200-damage hit. See commander_combat_test and corjugg arena.
            const float hits=w.continuous?commander::CollisionHits(def->GetRadius(),w.speed*30.f):1.f;
            const float damage=w.damage[std::min(size_t(std::max(0,armor)),w.damage.size()-1)]*w.alphaScale*hits;
            if(damage<=0) continue;
            const int reload=api->GetVisibleWeaponReload(id,w.index);
            threats.push_back({c.pos,c.velocity,w.range,damage,w.reload,
                std::max(0.f,float(reload-frame)/30.f),w.splash,w.speed*30.f,w.arc,w.heightMod,c.height,
                !w.instant && w.speed>0.f,w.guided,(w.ballistic || w.high) && !w.guided,
                w.range+def->GetRadius()*w.beamTargetBorder,w.beamMinIntensity,c.radius+def->GetRadius()});
        }
    };
    // All queries are local. No RangedWorld::Refresh/global army census here.
    // O(E*W+F), retained buffers; effective definition metadata is cached by
    // RangedWorld for this AI lifetime. Enemy reload is never read without LOS.
    const bool jammed=Jammed(unit);
    const float scan=jammed?std::max(cfg->combat.scan,2.f*maxJammerRadius+unit->GetDGunRange()):cfg->combat.scan;
    const auto& enemies=ai->GetCallback()->GetEnemyUnitIdsIn(pos,scan,false);
    if(commanderTrace && frame%30<3) ai->LOG("[CommanderTrace] query unit=%i x=%.0f z=%.0f count=%i",unit->GetId(),pos.x,pos.z,int(enemies.size()));
    for(int id:enemies) {
        auto* enemy=ai->GetEnemyInfo(id);
        if(commanderTrace && frame%30<3) ai->LOG("[CommanderTrace] contact id=%i known=%i hidden=%i los=%i neutral=%i dead=%i dying=%i",id,int(enemy!=nullptr),enemy?enemy->IsHidden():0,enemy?enemy->IsInLOS():0,enemy?enemy->GetData()->IsNeutral():0,enemy?enemy->GetData()->IsDead():0,enemy?enemy->GetData()->IsDying():0);
        if(!enemy) continue;
        const auto data=enemy->GetData()->GetData();
        if(data.losStatus & (SEnemyData::HIDDEN|SEnemyData::NEUTRAL|SEnemyData::DEAD|SEnemyData::DYING)) continue;
        // IsHidden also includes profile threat suppression (IGNORE). Match
        // RangedWorld's legal-contact filter: a zero strategic threat weight
        // must not blind local commander defence to visible T1 attackers.
        if(data.IsIgnore() && (!enemy->GetCircuitDef() || !enemy->GetCircuitDef()->IsIgnore()
            || enemy->GetUnit()->GetRulesParamFloat("ignoredByAI",0.f)>0.f)) continue;
        if(!enemy->IsInLOS()) {
            // Radar uncertainty contributes danger, never a precision aim.
            threats.push_back({P(enemy->GetPos()),{},450,250,1,0,100,0,-1,0,enemy->GetPos().y,false,false});
            // Under water and out of sight: sonar shows an amphibious threat
            // that LOS-based T3 tracking cannot see yet.
            if(enemy->GetPos().y<-20.f && enemy->GetPos().SqDistance2D(pos)<SQUARE(cfg->t3.distance)) submergedContact=true;
            // A previously identified radar contact keeps its definition; its
            // last known position is conservative for the fallback group.
            auto* known=enemy->GetCircuitDef();
            if(known && canHit(world->CapabilitiesFor(known)))
                attackers.push_back({P(enemy->GetPos()),known->GetCostM()});
            continue;
        }
        auto* ed=enemy->GetCircuitDef(); if(!ed) continue;
        // Unit_getPos leaves the buffer untouched for an id it cannot
        // resolve (e.g. given this frame); never route on stale garbage.
        float raw[3]={NAN,NAN,NAN}; api->GetPosition(id,raw); AIFloat3 ep(raw[0],raw[1],raw[2]);
        if(!OnMap(ep)) continue;
        api->GetVelocity(id,raw);
        const auto& cap=world->CapabilitiesFor(ed);
        commander::Contact c;
        c.id=id; c.pos=P(ep); c.velocity={raw[0]*30,raw[2]*30};
        c.radius=cap.radius; c.cost=ed->GetCostM(); c.health=enemy->GetUnit()->GetHealth(); c.height=ep.y;
        c.blocker=ed->IsRoleComm() && !ActualDecoy(ed);
        const auto& metadata=DefinitionFor(ed);
        c.t3=metadata.t3;
        c.combatTier=ed->IsMobile() && ed->IsAttacker() && !ed->IsAbleToFly() && !c.blocker
            ?std::clamp(int(metadata.tech),1,3):0;
        c.targetable=!ed->IsAbleToFly() && ep.y>=-c.radius*.4f
            && (ed->GetCategory() & def->GetTargetCategoryDGun())!=0;
        // Default D-gun damage is deliberately conservative for repeat-hit T3.
        // A shield makes a promised one-shot inappropriate; reobserve after fire.
        c.damage=def->GetDGunDef()->GetDamage()*(ed->GetShieldMount()?.35f:1.f);
        c.stopAfter=ed->GetShieldMount()!=nullptr;
        c.reserved=claims.Reserved(id,ai->GetTeamId(),unit->GetId())>=c.health;
        contacts.push_back(c);
        if(c.targetable && !c.blocker) seeds.push_back(int(contacts.size()-1));
        if(enemy->GetUnit()->IsBeingBuilt() || enemy->GetUnit()->IsParalyzed()
            || enemy->GetUnit()->GetRulesParamFloat("disarmed",0)>0) continue;
        if(canHit(cap)) attackers.push_back({c.pos,c.cost});
        observeWeapons(id,c,cap);
    }
    // Bounded candidate seeds, but ScoreLine still scores every local contact.
    const auto order=[this](int a,int b) {
        const auto& x=contacts[a]; const auto& y=contacts[b];
        return x.cost==y.cost?x.id<y.id:x.cost>y.cost;
    };
    std::partial_sort(seeds.begin(),seeds.begin()+std::min(size_t(12),seeds.size()),seeds.end(),order);
    if(seeds.size()>12) seeds.resize(12);
    // Friendly contacts matter only with enemies observed (line safety,
    // support, jammers, splash and screen checks) or for the once-a-second
    // advance deployment plan. Skipping the scan otherwise removes the idle
    // cost measured in the 16-commander population arena (review finding 2):
    // 4-5 engine callbacks per nearby friendly every 3 frames, discarded.
    const State* self=states.Find(unit->GetId());
    const bool deployDue=role.advance && !role.frontDuty && self && frame>=self->lastLog+30;
    const bool farT3=self && !self->t3.distant.empty();
    // ...and while a T3 engagement, a declined T3 or a fallback is active: the
    // splash checks of a cloaked scout need the friendlies a lost T3 is
    // shelling (b42 walled Behemoth: no enemy in sight, friends skipped,
    // scouted through the shelled wall).
    const bool engagedT3=self
        && (self->t3.target>=0 || self->t3.declined>=0 || self->fallback.active);
    const bool needFriends=!contacts.empty() || !threats.empty() || !attackers.empty() || deployDue || farT3 || engagedT3;
    static const std::vector<int> none;
    // D-319: share the existing combat-only friendly query. Extra-radius IDs
    // need definition/position checks, not velocity/health; they never enter
    // ordinary support/shot scoring. No idle census or cached unit lifetime.
    const bool protect=cfg->combat.afusDefenceRadius>0 && !afusDefs.empty();
    const float friendRadius=protect?std::max(scan,cfg->combat.afusDefenceRadius):scan;
    float afusDistance=SQUARE(cfg->combat.afusDefenceRadius);
    const auto& friends=needFriends?ai->GetCallback()->GetFriendlyUnitIdsIn(pos,friendRadius,false):none;
    for(int id:friends) {
        if(id==unit->GetId()) continue;
        auto* fd=ai->GetCircuitDefSafe(ai->GetCallback()->Unit_GetDefId(id));
        if(!fd) continue;
        float raw[3]={NAN,NAN,NAN}; api->GetPosition(id,raw); const float y=raw[1];
        if(!OnMap(AIFloat3(raw[0],raw[1],raw[2]))) continue;
        const float distance=AIFloat3(raw[0],raw[1],raw[2]).SqDistance2D(pos);
        if(protect && afusDefs.count(fd->GetId()) && distance<=afusDistance) {
            protectedAfus=id; afusDistance=distance;
        }
        if(distance>SQUARE(scan)) continue;
        commander::Contact c; c.id=id; c.pos={raw[0],raw[2]}; c.height=y;
        api->GetVelocity(id,raw); c.velocity={raw[0]*30,raw[2]*30};
        c.radius=fd->GetRadius(); c.friendly=true; c.blocker=fd->IsRoleComm();
        c.targetable=false;
        c.cost=fd->IsAttacker() && !fd->IsRoleComm() && !fd->IsAbleToFly()
            && api->GetCombatHealth(id)>0 ? fd->GetCostM():0;
        // High flying aircraft do not intersect a ground-hugging projectile.
        if(y>ai->GetMap()->GetElevationAt(c.pos.x,c.pos.z)+c.radius+32 && fd->IsAbleToFly()) continue;
        contacts.push_back(c);
    }
    // D-294: T3 artillery shells the line from beyond the 3-frame scan. Once a
    // second per commander, one wider query keeps only in-LOS T3 definitions
    // (O(E') ids, map lookups only); they join the contacts so Intercept can
    // hunt them. Their positions are re-read every observation.
    State* found=states.Find(unit->GetId());
    if(!found || cfg->t3.intercept<=0 || cfg->t3.huntLeash<=cfg->combat.scan) return;
    auto& st=*found;
    if(frame>=st.t3.distantFrame+FRAMES_PER_SEC) {
        st.t3.distantFrame=frame; st.t3.distant.clear();
        for(int id:ai->GetCallback()->GetEnemyUnitIdsIn(pos,cfg->t3.huntLeash,false)) {
            auto* enemy=ai->GetEnemyInfo(id);
            if(enemy && enemy->IsInLOS() && enemy->GetCircuitDef() && DefinitionFor(enemy->GetCircuitDef()).t3
                && enemy->GetPos().SqDistance2D(pos)>SQUARE(cfg->combat.scan)) st.t3.distant.push_back(id);
        }
    }
    for(int id:st.t3.distant) {
        auto* enemy=ai->GetEnemyInfo(id);
        if(!enemy || !enemy->IsInLOS() || enemy->GetData()->IsDead()) continue;
        auto* ed=enemy->GetCircuitDef(); if(!ed) continue;
        float raw[3]={NAN,NAN,NAN}; api->GetPosition(id,raw); AIFloat3 ep(raw[0],raw[1],raw[2]);
        if(!OnMap(ep) || ep.SqDistance2D(pos)<=SQUARE(cfg->combat.scan)) continue;
        api->GetVelocity(id,raw);
        const auto& cap=world->CapabilitiesFor(ed);
        commander::Contact c;
        c.id=id; c.pos=P(ep); c.velocity={raw[0]*30,raw[2]*30};
        c.radius=cap.radius; c.cost=ed->GetCostM(); c.health=enemy->GetUnit()->GetHealth(); c.height=ep.y;
        c.targetable=!ed->IsAbleToFly() && ep.y>=-c.radius*.4f && (ed->GetCategory() & def->GetTargetCategoryDGun())!=0;
        c.damage=def->GetDGunDef()->GetDamage()*(ed->GetShieldMount()?.35f:1.f);
        c.stopAfter=ed->GetShieldMount()!=nullptr;
        c.reserved=claims.Reserved(id,ai->GetTeamId(),unit->GetId())>=c.health;
        c.t3=true; // the far query keeps T3 definitions only
        c.combatTier=3;
        contacts.push_back(c);
        // Same legal LOS-only weapon observation as the near scan. The distance
        // exclusion above makes crossing the boundary count each weapon once.
        if(!enemy->GetUnit()->IsBeingBuilt() && !enemy->GetUnit()->IsParalyzed()
            && enemy->GetUnit()->GetRulesParamFloat("disarmed",0)<=0) observeWeapons(id,c,cap);
    }
}

float CCommanderController::Exposure(Point from,Point to,float seconds,float height,bool moving,float newVolleyRisk) const {
    float total=0;
    for(const auto& t:threats) {
        const float distance=std::min(commander::Length(t.pos-from),commander::Length(t.pos-to));
        const float heightRange=std::max(0.f,t.height-height)*std::max(0.f,t.heightMod);
        if(distance>t.range+heightRange+t.splash+32) continue;
        // Reload is evidence of a window, not evidence that its last projectile
        // missed us. Include one in-flight salvo while inside its flight time.
        const float flight=t.projectile?distance/std::max(1.f,t.speed):0;
        // A moving commander dodges most unguided shells: ballistic arcs, and
        // straight-flying missiles with over 0.6 s of flight (corcat, b19).
        const bool dodgeable=!t.guided && (t.ballistic || (t.projectile && flight>.6f));
        const float hit=moving && dodgeable?.35f:1.f;
        // Recoil BeamLaser damage falls with beam length. Subtract both unit
        // radii as a conservative muzzle/surface bound, not a guessed rear arc.
        const float intensity=commander::BeamIntensity(distance-t.beamClearance,t.beamRange,t.beamMinIntensity);
        total+=hit*intensity*t.damage*commander::ImpactVolleys(seconds,t.reload,t.delay,flight,newVolleyRisk);
    }
    for(const auto& p:projectiles) {
        if(ai->GetLastFrame()-p.frame>6) continue;
        const Point relative=p.pos-to;
        const float v2=commander::Dot(p.velocity,p.velocity);
        const float time=v2>0?std::clamp(-commander::Dot(relative,p.velocity)/v2,0.f,seconds):0;
        if(commander::Length(relative+p.velocity*time)<p.radius+32) total+=1500;
    }
    return total;
}
bool CCommanderController::Route(CCircuitUnit* unit,const AIFloat3& from,const AIFloat3& to) const {
    auto* terrain=ai->GetTerrainManager();
    if(!OnMap(from) || !OnMap(to) || !terrain->CanReachAt(unit,to,8)) return false;
    // Small local moves, sampled across the movement footprint at 24 elmos.
    // End-point reachability alone does not prove a lateral ramp is traversable.
    const int n=std::max(1,int(std::ceil((to-from).Length2D()/24.f)));
    for(int i=1;i<=n;++i) {
        AIFloat3 p=from+(to-from)*(float(i)/n);
        if(!terrain->CanMoveToPos(unit->GetArea(),p)) return false;
    }
    return true;
}
void CCommanderController::Move(CCircuitUnit* unit,State& s,const AIFloat3& goal,int frame,bool transit) {
    // Exact destination, ownership and live queue suffix must all agree. A
    // swallowed order or move failure is reissued; a moving target is new intent.
    if(!s.route.empty() && s.goal==goal && ai->GetUnitAPI()->HasRouteIntent(unit->GetId(),s.route,frame)) return;
    // Owner 2026-10-19: the same goal is resent at most once per
    // move_resend_seconds, +1 s per resend in a row, at most 3 s. A goal the
    // engine keeps refusing was resent every tick (fallback line, All That
    // Glitters: one commander 6 MOVEs/s to the same point). A new goal
    // goes at once.
    if(cfg->combat.moveResendSeconds>0) {
        if(s.moveGoal.SqDistance2D(goal)<16.f*16.f) {
            const float wait=std::min(3.f,cfg->combat.moveResendSeconds+s.moveResends);
            if(frame<s.moveSent+int(wait*FRAMES_PER_SEC)) return;
            ++s.moveResends;
        } else s.moveResends=0;
        s.moveGoal=goal; s.moveSent=frame;
    }
    CheckPerimeter(unit,s,goal,frame,"move");
    // MobileCAI expires MOVE on its simulation thread. A 240-elmo lane
    // step takes longer than the old 3-second timeout at commander speed.
    // Give transit its travel time plus slack, bounded at 30 seconds; combat
    // and MoveFailed still preempt immediately and stalls retain their watchdog.
    const int lifetime=transit?std::clamp(int(std::sqrt(unit->GetPos(frame).SqDistance2D(goal))
        /std::max(1.f,unit->GetCircuitDef()->GetSpeed())*FRAMES_PER_SEC)+90,90,900):90;
    s.goal=goal; s.route={{CMD_MOVE,0,frame+lifetime,goal.x,goal.y,goal.z}};
    TRY_UNIT(ai,unit,unit->CmdMoveTo(goal,0,frame+lifetime);)
}
void CCommanderController::Conceal(CCircuitUnit* unit,State& s,bool value) {
    const int fire=value?CCircuitDef::FireType::HOLD:CCircuitDef::FireType::OPEN;
    writer.FireState(unit,fire,value?"conceal":"reveal");
    // D-389: an engagement's concealment combines with the posture's cloak
    // (formerly the D-380 fog cloak). The single writer sends the order.
    const bool cloak=value || s.conceal.postureCloak;
    writer.CloakFrom(unit,cloak,s.conceal.requested,value?"engagement":"posture");
    s.conceal.requested=cloak;
}
void CCommanderController::Transition(CCircuitUnit* unit,State& s,Mode mode,int frame) {
    if(s.mode==mode) return;
    s.mode=mode; s.route.clear();
    if(mode==Mode::SUPPORT) { s.budget=0; s.target=-1; s.leaseUntil=0; }
    ai->LOG("[Commander] unit=%i generation=%i state=%i frame=%i",unit->GetId(),s.generation,int(mode),frame);
}
void CCommanderController::Update() {
    performance::Scope measured(ai,performance::COMMANDER_DECISION);
    const int frame=ai->GetLastFrame(); reserve=0;
    // D-389: keep the side's combat snapshot alive while commanders read it.
    if(role.enabled && !states.Empty()) ai->GetAllyTeam()->GetCombatSnapshot().Want(frame);
    UpdateCommanderGroup();
    for(auto& entry:states) {
        const int id=entry.id; auto& s=*entry.value;
        auto* unit=ai->GetTeamUnit(id); if(!unit || unit->IsDead()) continue;
        Bind bound(this,s.preset);
        if(!Handles(unit)) {
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),id);
            if(auto* task=dynamic_cast<CControlledTask*>(unit->GetTask())) task->Resume(unit);
            s.budget=0; s.fundingBudget=0; s.pending=-1; s.mode=Mode::SUPPORT; continue;
        }
        // Fixed three-frame active/idle observation cadence independent of the
        // total action population. Immediate own-shot/move-failure invalidation.
        if(frame>=s.fundingUntil || !ai->GetEnemyInfo(s.fundingTarget)) s.fundingBudget=0;
        if(frame>=s.next) { s.next=frame+3; Tick(unit,s,frame); }
        reserve+=std::max(s.budget,s.fundingBudget);
    }
}
void CCommanderController::Tick(CCircuitUnit* unit,State& s,int frame) {
    auto* current=unit->GetTask();
    auto* task=dynamic_cast<CControlledTask*>(current);
    const bool trace=commanderTrace && frame%30<3;
    if(trace) ai->LOG("[CommanderTrace] unit=%i task=%i morph=%i stun=%i disarm=%i build=%i external=%i reclaim=%i transported=%.0f retry=%i",unit->GetId(),current?int(current->GetType()):-1,unit->IsMorphing(),unit->GetUnit()->IsParalyzed(),unit->IsDisarmed(frame),unit->GetUnit()->IsBeingBuilt(),current?current->IsExternalControlled():0,current?current->IsEnemyReclaim():0,unit->GetUnit()->GetRulesParamFloat("circuit_comm_transported",0),s.retry);
    if(s.invalidated) {
        ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        s.invalidated=false; s.budget=0; s.fundingBudget=0; s.deployed=false;
        EndT3(unit,s,frame,"invalidated");
        if(task) { ai->GetBuilderManager()->AbortTask(task); Transition(unit,s,Mode::SUPPORT,frame); return; }
    }
    AccountCloak(unit,s,frame);
    // D-388 ownership ladder: a player order, Lua control, transport, morph,
    // construction or stun holds the unit. Order nothing and leave its cloak,
    // fire and move states alone; the support sync re-asserts this
    // controller's cloak once it owns the unit again (KI-689 defect 2).
    if(control::SuspensionOf(unit,frame)!=control::Suspension::NONE) {
        s.conceal.known=false;
        s.budget=0; s.fundingBudget=0; s.pending=-1; s.leaseUntil=0;
        EndT3(unit,s,frame,"ownership");
        ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        if(task) task->Resume(unit);
        return;
    }
    // D-389: a retreat lease ended. CRetreatTask::Recovered no longer writes
    // the states of a controlled commander; restore its default fire state here.
    {
        const int taskType=int(current->GetType());
        if(s.retreat.lastTaskType==int(IUnitTask::Type::RETREAT) && taskType!=s.retreat.lastTaskType)
            writer.FireState(unit,unit->GetCircuitDef()->GetFireState(),"retreat_end");
        s.retreat.lastTaskType=taskType;
    }
    if(!task && s.mode!=Mode::SUPPORT) {
        ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
        Transition(unit,s,Mode::SUPPORT,frame); s.pending=-1;
        s.retry=frame+30; // external retreat/role takeover wins
    }
    if(!task && frame<s.retry && cfg->t3.immediateShot<=0 && !HealthRetreat(unit)) return;
    const AIFloat3 pos=unit->GetPos(frame);
    if(pos.y>ai->GetMap()->GetElevationAt(pos.x,pos.z)+unit->GetCircuitDef()->GetRadius()*2.f) {
        // The C AI interface has no transporter query. Suspended ground units
        // are not legal firing origins; the optional adapter adds exact status.
        s.budget=0; if(task) task->Resume(unit); return;
    }
    auto* def=unit->GetCircuitDef();
    const auto& cap=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
    const float speed=std::max(1.f,cap.speed);
    const float hp=unit->GetUnit()->GetHealth(),maxHp=unit->GetUnit()->GetMaxHealth();
    const float bank=ai->GetEconomyManager()->GetEnergyCur();
    const float shot=def->GetDGunDef()->GetCostE();
    const float range=unit->GetDGunRange()-12;
    Observe(unit,frame);
    if(trace) ai->LOG("[CommanderTrace] observation unit=%i contacts=%i seeds=%i threats=%i y=%.0f",unit->GetId(),int(contacts.size()),int(seeds.size()),int(threats.size()),pos.y);
    // Threat-only energy fallback precedes even jam-safe/T3 work. The latch
    // keeps a healthy commander in its retreat task until the cloak reserve
    // returns; no extra scan and no peaceful low-energy evacuation.
    const bool threatened=(s.lastDamage>=0 && frame-s.lastDamage<FRAMES_PER_SEC)
        || Exposure(P(pos),P(pos),cfg->combat.escapeSeconds,pos.y)>0.f;
    if(cfg->safety.cloakEnergyRetreat>0 && def->IsAbleToCloak()
        && !RetreatCloakFunded(unit) && (threatened || s.retreat.energy)) {
        s.conceal.postureCloak=false;
        if(!s.retreat.energy) {
            ai->LOG("[Commander] unit=%i cloak_energy_retreat frame=%i",unit->GetId(),frame);
            // Clear the cloak request once so the bank can refill, and return
            // fire while unhidden (the single writer; CRetreatTask no longer does).
            writer.Cloak(unit,false,"cloak_energy_retreat");
            writer.FireState(unit,CCircuitDef::FireType::RETURN,"cloak_energy_retreat");
        }
        s.conceal.requested=false;
        s.retreat.energy=true;s.budget=0;s.fundingBudget=0;s.pending=-1;
        EndT3(unit,s,frame,"cloak_energy");
        // A generic haven radius can include the current exposed position.
        // Publish a precise retreat station instead, at most once per second.
        // Eight reachable endpoints reuse the observed threat snapshot; keep
        // a safe goal rather than walking farther once clear of the threat.
        if(frame>=s.retreat.energyPlan+FRAMES_PER_SEC && (s.retreat.energyGoal.x<0
            || (threatened && pos.SqDistance2D(s.retreat.energyGoal)<SQUARE(64.f))
            || Exposure(P(s.retreat.energyGoal),P(s.retreat.energyGoal),cfg->combat.escapeSeconds,s.retreat.energyGoal.y)>0.f)) {
            s.retreat.energyPlan=frame;
            const auto home=ai->GetSetupManager()->GetBasePos();
            Point away=commander::Normal(P(home)-P(pos));
            float nearest=1e30f;
            for(const auto& c:contacts) if(!c.friendly) {
                const float distance=commander::Length(c.pos-P(pos));
                if(distance<nearest) {nearest=distance;away=commander::Normal(P(pos)-c.pos);}
            }
            if(commander::Length(away)<.1f) away={0,-1};
            float best=1e30f;
            for(int i=0;i<8;++i) {
                const float angle=i*.785398163f;
                const Point direction{away.x*std::cos(angle)-away.z*std::sin(angle),
                    away.x*std::sin(angle)+away.z*std::cos(angle)};
                auto at=F(P(pos)+direction*cfg->safety.cloakRetreatDistance);
                if(!OnMap(at)) continue;
                at.y=ai->GetMap()->GetElevationAt(at.x,at.z);
                if(!ai->GetTerrainManager()->CanReachAt(unit,at,64.f)) continue;
                const float risk=Exposure(P(pos),P(at),cfg->combat.escapeSeconds,pos.y)
                    +4.f*Exposure(P(at),P(at),cfg->combat.escapeSeconds,at.y);
                if(risk<best) {best=risk;s.retreat.energyGoal=at;}
            }
        }

        if(current->GetType()!=IUnitTask::Type::RETREAT)
            ai->GetBuilderManager()->AssignTask(unit,ai->GetBuilderManager()->EnqueueRetreat());
        return;
    }
    s.retreat.energy=false;s.retreat.energyGoal={-1,0,-1};
    // D-389: the cloak posture replaces the D-380 fog cloak.
    {
        const int due=s.conceal.postureNext;
        UpdatePosture(unit,s,frame,s.lastDamage==frame);
        SyncSupportCloak(unit,s,frame,s.conceal.postureNext!=due);
    }
    if(HealthControl(unit,s,frame)) {
        if(unit->GetTask() && unit->GetTask()->GetType()==IUnitTask::Type::RETREAT) RetreatConceal(unit,s,frame,threatened);
        return;
    }
    if(cfg->safety.decoyBait>0 && ActualDecoy(def)) {
        // A fake D-gun must not inherit the real commander's kill/trade plans.
        // Retain ordinary lane construction and threat-based retreat concealment.
        if(current->GetType()==IUnitTask::Type::RETREAT) RetreatConceal(unit,s,frame,threatened);
        else Deploy(unit,s,frame);
        return;
    }
    // D-294: a T3 in range is engaged from the line (concealed per-T3 plan)
    // ahead of the D-293 withdrawal, which then covers everything else.
    if(JamControl(unit,s,frame)) return;
    if(Intercept(unit,s,frame)) return;
    if(!task && frame<s.retry) return;
    if(current->GetType()==IUnitTask::Type::RETREAT && Handles(unit)) RetreatConceal(unit,s,frame,threatened);
    // Under fire from an attacker it cannot see (a submerged amphibious T3,
    // fire from beyond sight) and no known T3 owns the situation: cloak and
    // step back toward base for a few seconds (b43: a submerged Juggernaut
    // lasered an uncloaked shore commander from 3,700 to 2,641 HP). Scoped to
    // unknown attackers: a known T3 is already owned by the engagement or the
    // fallback (b44: at base, repeated withdrawals pre-empted re-engaging).
    // Shore only: on land an unseen shooter is a known kind of threat (long
    // range beyond sight) that the T3 plan and fallback handle; withdrawing
    // there broke Behemoth engagements (b50: walled and no-defence failed).
    const bool knownT3=s.t3.target>=0 || s.t3.declined>=0 || s.fallback.active;
    if(!knownT3 && frame-s.lastDamage<FRAMES_PER_SEC && seeds.empty() && threats.empty() && attackers.empty()) {
        const AIFloat3 here=unit->GetPos(frame);
        bool nearWater=false;
        // 16 samples on two rings (300, 700): a shore line usually stands a few
        // hundred elmos back from the waterline.
        for(int i=0;i<16 && !nearWater;++i) {
            const float a=float(i%8)*.7853982f,r=i<8?300.f:700.f;
            nearWater=ai->GetMap()->GetElevationAt(here.x+std::cos(a)*r,here.z+std::sin(a)*r)<0.f;
        }
        if(nearWater) s.conceal.unseenUntil=frame+3*FRAMES_PER_SEC;
    }
    if(knownT3) s.conceal.unseenUntil=0;
    if(frame<s.conceal.unseenUntil && seeds.empty() && threats.empty() && current->GetType()!=IUnitTask::Type::RETREAT) {
        auto* def=unit->GetCircuitDef();
        const auto& capU=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
        auto* t=dynamic_cast<CControlledTask*>(current);
        if(capU.cloak && ai->GetEconomyManager()->GetEnergyCur()>=def->GetDGunDef()->GetCostE()+capU.cloakMoving*cfg->combat.escapeSeconds) {
            if(!t) {
                t=ai->GetBuilderManager()->EnqueueControlled(this,current);
                ai->GetBuilderManager()->AssignTask(unit,t);
                if(unit->GetTask()!=t) { ai->GetBuilderManager()->AbortTask(t); t=nullptr; }
                else { s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation; TRY_UNIT(ai,unit,unit->CmdStop();) }
            }
            if(t) {
                Conceal(unit,s,true); Transition(unit,s,Mode::ESCAPE,frame);
                const AIFloat3 here=unit->GetPos(frame);
                AIFloat3 back=F(P(here)+commander::Normal(P(ai->GetSetupManager()->GetBasePos())-P(here))*cfg->combat.step*2.f);
                back.y=ai->GetMap()->GetElevationAt(back.x,back.z);
                if(back.y>=0 && Route(unit,here,back)) Move(unit,s,back,frame);
                if(frame>=s.lastLog+60) { s.lastLog=frame; ai->LOG("[Commander] unit=%i unseen_fire withdraw frame=%i",unit->GetId(),frame); }
                return;
            }
        }
    }
    // A submerged sonar contact approaching the shore: cloak and wait in
    // place (stationary cloak, 100 E/s) until it surfaces, when the T3 plan
    // takes over (b43: a submerged legeheatraymech beamed an uncloaked shore
    // commander for 2,000 HP before it was ever in sight).
    if(submergedContact && !s.fallback.active && current->GetType()!=IUnitTask::Type::RETREAT) {
        auto* def=unit->GetCircuitDef();
        const auto& capW=ai->GetMilitaryManager()->GetRangedWorld()->CapabilitiesFor(def);
        auto* t=dynamic_cast<CControlledTask*>(current);
        if(capW.cloak && ai->GetEconomyManager()->GetEnergyCur()>=def->GetDGunDef()->GetCostE()+capW.cloakCost*cfg->combat.escapeSeconds) {
            if(!t) {
                t=ai->GetBuilderManager()->EnqueueControlled(this,current);
                ai->GetBuilderManager()->AssignTask(unit,t);
                if(unit->GetTask()!=t) { ai->GetBuilderManager()->AbortTask(t); t=nullptr; }
                else { s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation; TRY_UNIT(ai,unit,unit->CmdStop();) }
            }
            if(t) {
                Conceal(unit,s,true); Transition(unit,s,Mode::ASSESS,frame);
                if(frame>=s.lastLog+90) { s.lastLog=frame; ai->LOG("[Commander] unit=%i submerged_contact conceal frame=%i",unit->GetId(),frame); }
                return;
            }
        }
    }
    if(Fallback(unit,s,current,frame)) return;
    if(seeds.empty() && threats.empty()) {
        s.budget=0;
        if(Deploy(unit,s,frame)) return;
        if(task) { Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame); task->Resume(unit); }
        return;
    }
    float support=0,nearest=cfg->combat.scan;
    Point supported=P(pos),toward;
    bool enemyNearby=false;
    for(const auto& c:contacts) {
        const float distance=commander::Length(c.pos-P(pos));
        if(c.friendly) {
            if(distance<450) support+=c.cost;
        } else {
            enemyNearby=true;
            if(distance<nearest) { nearest=distance; toward=commander::Normal(c.pos-P(pos)); }
        }
    }
    // A local screen supplies both a supported forward point and an exit.
    float bestSupport=-1;
    for(const auto& c:contacts) if(c.friendly && c.cost>0) {
        const float score=commander::Dot(c.pos-P(pos),toward)-commander::Length(c.pos-P(pos))*.2f;
        if(score>bestSupport) { bestSupport=score; supported=c.pos-toward*100.f; }
    }
    AIFloat3 home=ai->GetSetupManager()->GetBasePos();
    AIFloat3 safe=F(support>=cfg->combat.support?supported:P(pos)-toward*cfg->combat.step);
    if(!enemyNearby) safe=home;
    safe.y=ai->GetMap()->GetElevationAt(safe.x,safe.z);
    if(!Route(unit,pos,safe)) safe=home;
    const float exposed=Exposure(P(pos),P(safe),1.f,pos.y);
    const bool emergency=nearest<range*.85f && exposed>hp*.12f;
    if(!task && current->GetType()==IUnitTask::Type::RETREAT && !emergency) { s.budget=0; return; }
    const bool endangered=hp/maxHp<cfg->combat.retreat || !commander::Survivable(hp,maxHp,exposed,cfg->combat.hpReserve);
    const bool front=role.advance && ai->GetFactoryManager()->GetFactoryCount()>0
        && ai->GetBuilderManager()->GetWorkerCount()>cfg->front.workers;

    if(task && s.pending>=0) {
        if(unit->GetDGunReloadFrame()>frame) {
            s.fired=frame; s.pending=-1; Transition(unit,s,Mode::ESCAPE,frame);
        } else if(frame-s.pending>30) {
            ai->LOG("[Commander] unit=%i shot_timeout frame=%i",unit->GetId(),frame);
            s.pending=-1; s.leaseUntil=0; s.retry=frame+15;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
            Transition(unit,s,Mode::ESCAPE,frame);
        } else if(!endangered || emergency || (role.frontDuty && unit->GetUnit()->IsCloaked()
            && CloakSafe(unit,P(pos),P(pos),.1f))) return;
        else {
            s.pending=-1; s.leaseUntil=0;
            ai->GetAllyTeam()->GetCommanderShots().Release(ai->GetTeamId(),unit->GetId());
            Transition(unit,s,Mode::ESCAPE,frame);
        }
    }
    if(!enemyNearby && task) {
        Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame); task->Resume(unit); return;
    }

    // D-389: cloak for a D-gun approach only where it hides the commander:
    // off enemy radar, or on radar behind a friendly screen (formerly the
    // screen alone, support >= support metal).
    const bool wantCloak=cap.cloak && cfg->combat.cloakSeconds>0 && nearest>55
        && ConcealmentOf(unit,s)!=commander::posture::Concealment::NONE;
    const float cloakBudget=commander::Reserve(shot,cfg->combat.shots,cap.cloakCost,cap.cloakMoving,
        cfg->combat.alignSeconds,cfg->combat.cloakSeconds+cfg->combat.escapeSeconds,cfg->combat.margin);
    const bool fundedCloak=wantCloak && bank>=cloakBudget;
    s.budget=enemyNearby? (wantCloak?cloakBudget:shot*cfg->combat.shots+cfg->combat.margin):0;
    // Never count a transfer acknowledgement as funds: actual bank only.
    const float spendable=bank-std::max(0.f,reserve);
    const bool ready=unit->IsDGunReady(frame,spendable) && frame>=s.retry;
    commander::Line best;
    AIFloat3 bestPos=pos;
    const float projectileSpeed=std::max(1.f,def->GetDGunDef()->GetDef()->GetProjectileSpeed()*30.f);
    const float width=std::min(24.f,std::max(4.f,def->GetDGunDef()->GetAoe()*.25f));
    const float aggression=ai->GetMilitaryManager()->GetAggression();
    const float minValue=commander::MinimumValue(cfg->combat.minValue,aggression,cfg->combat.aggression);
    const float maxLoss=std::clamp(cfg->combat.hpReserve-aggression*.04f,.2f,.85f);
    // Five positions x <=12 directions, each O(E+F). No pairwise unit search.
    const Point lateral={-toward.z,toward.x};
    const std::array<Point,5> offsets={Point{},lateral*cfg->combat.step,lateral*(-cfg->combat.step),
        toward*std::min(cfg->combat.step,cfg->combat.maxApproach),toward*(-cfg->combat.step)};
    for(size_t i=0;i<offsets.size();++i) {
        if(i>0 && (endangered || support<cfg->combat.support || nearest>range+cfg->combat.maxApproach)) continue;
        AIFloat3 candidate=F(P(pos)+offsets[i]);
        candidate.y=ai->GetMap()->GetElevationAt(candidate.x,candidate.z);
        // No submerged manual fire; shore movement may still use normal torpedo.
        if(candidate.y<0 || (i>0 && !Route(unit,pos,candidate))) continue;
        if(i>0 && candidate.SqDistance2D(home)>cfg->combat.leash*cfg->combat.leash && !emergency) continue;
        if(i>0 && !emergency && ai->GetBattle()->GetFrontLaneLength()>0.f
            && ai->GetBattle()->GetFrontLaneDistance(candidate)>ai->GetBattle()->GetFrontLaneWidth())continue;
        const float travel=i==0?0.f:commander::TravelSeconds(commander::Length(offsets[i]),speed,
            cap.acceleration,cap.turnRate,i==3?0.f:1.5707963f);
        const float escape=commander::Length(P(candidate)-P(safe))/speed;
        const float risk=Exposure(P(pos),P(candidate),travel+cfg->combat.alignSeconds+1.f,pos.y)
            +Exposure(P(candidate),P(safe),std::min(cfg->combat.escapeSeconds,escape),candidate.y);
        if(i>0 && !commander::Survivable(hp,maxHp,risk,maxLoss)) continue;
        for(int index:seeds) {
            const auto& seed=contacts[index];
            Point dir=seed.pos+seed.velocity*(commander::Length(seed.pos-P(candidate))/projectileSpeed)-P(candidate);
            auto line=commander::ScoreLine(contacts,P(candidate),dir,range,projectileSpeed,width,
                cfg->combat.killReward,cfg->combat.friendlyMargin);
            // Reject impossible height intersections without treating ridges as
            // universal DGun blockers. Ground aim and subsequent fresh checks
            // handle the game's ground-hugging projectile behavior.
            if(std::abs(seed.height-std::max(0.f,candidate.y))>range*.5f) continue;
            line.value-=travel*60.f+risk*.05f;
            if(line.value>best.value) { best=line; bestPos=candidate; }
        }
        if(emergency && best.target>=0) break;
    }

    const bool opportunity=best.target>=0 && (best.value>=minValue || emergency);
    if(trace) ai->LOG("[CommanderTrace] unit=%i contacts=%i seeds=%i range=%.1f target=%i value=%.1f min=%.1f ready=%i danger=%i support=%.1f home=%.1f,%.1f",unit->GetId(),int(contacts.size()),int(seeds.size()),range,best.target,best.value,minValue,ready,endangered,support,home.x,home.z);
    // A visible unit outside useful firing range is not a reason to lock a
    // healthy front commander in combat. Deployment and role construction
    // keep their owner until a real attack/withdrawal opportunity appears.
    if(role.frontDuty && !opportunity && !endangered && s.pending<0) {
        if(Deploy(unit,s,frame)) return;
        if(task) { Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame); task->Resume(unit); }
        return;
    }
    if(!task) {
        const bool defend=endangered && enemyNearby;
        const bool attack=opportunity && (nearest<=range+32 || (support>=cfg->combat.support && front));
        // A distant observer must not reserve the only emergency shot away
        // from another owned commander that can actually engage now.
        if(!defend && !attack) { s.budget=0; Deploy(unit,s,frame); return; }
        // Enemy reclaim and explicit no-disrupt construction are protected.
        if(def->IsAttrNoDisrupt() && !defend) return;
        task=ai->GetBuilderManager()->EnqueueControlled(this,current);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return; }
        s.started=frame; s.exit=safe; s.failed=0; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
        Transition(unit,s,Mode::ASSESS,frame);
        writer.MoveState(unit,CCircuitDef::MoveType::HOLD_POS,"engage");
        // Clear construction/movement commands before taking a precision shot.
        TRY_UNIT(ai,unit,unit->CmdStop();)
    }
    // One command owner is an executable invariant, not a Blocker assumption.
    if(unit->GetDGunAct()!=nullptr || task->GetAssignees().size()!=1 || task->GetAssignees().count(unit)!=1) {
        ai->LOG("[INVARIANT] INV-214 commander combat has competing owner unit=%i",unit->GetId());
        task->Resume(unit); return;
    }
    if(opportunity && ready && bestPos.SqDistance2D(pos)<16.f*16.f
        && (!endangered || emergency)) {
        if(Fire(unit,s,best,frame)) return;
    }
    const bool expired=frame-s.started>int(cfg->combat.maxSeconds*30) || s.failed>=2;
    if(!opportunity && !endangered && s.fired>=s.started && frame-s.fired>=27) {
        // Once the firing window closes, ordinary work/weapons should handle
        // a cheap survivor. Do not oscillate ASSESS/ESCAPE every observation
        // or spend a full lease cloaked beside a safe, low-value target. Before
        // the first shot, retain the bounded alignment lease: a moving column
        // can briefly lose value while the commander reaches its firing point.
        Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame);
        s.retry=frame+15; task->Resume(unit); return;
    }
    if(endangered || expired || s.mode==Mode::ESCAPE || !opportunity) {
        Transition(unit,s,Mode::ESCAPE,frame);
        Conceal(unit,s,fundedCloak && bank>shot+cap.cloakMoving);
        AIFloat3 exit=safe;
        // Consider both reachable side exits, including projectile volumes
        // when the optional ally-LOS adapter is present. Never infer a blind
        // rear arc from a forward-facing weapon definition alone.
        float exitRisk=Exposure(P(pos),P(exit),cfg->combat.escapeSeconds,pos.y);
        for(float side:{-1.f,1.f}) {
            AIFloat3 lateralExit=F(P(pos)+lateral*(side*cfg->combat.step)-toward*(cfg->combat.step*.5f));
            lateralExit.y=ai->GetMap()->GetElevationAt(lateralExit.x,lateralExit.z);
            if(!Route(unit,pos,lateralExit)) continue;
            const float risk=Exposure(P(pos),P(lateralExit),cfg->combat.escapeSeconds,pos.y);
            if(risk<exitRisk) { exitRisk=risk; exit=lateralExit; }
        }
        if(Exposure(P(pos),P(exit),1.f,pos.y)>exposed && Route(unit,pos,s.exit)) exit=s.exit;
        if(Route(unit,pos,exit) && exit.SqDistance2D(pos)>32*32) Move(unit,s,exit,frame);
        if(expired || nearest>range+200 || hp/maxHp<cfg->combat.retreat) {
            Conceal(unit,s,false); Transition(unit,s,Mode::RECOVER,frame);
            s.retry=frame+60; s.budget=0; s.leaseUntil=0;
            bool lineRepair=false;
            if(role.frontDuty && hp/maxHp>=cfg->combat.retreat
                && commander::Survivable(hp,maxHp,Exposure(P(pos),P(pos),cfg->combat.escapeSeconds,pos.y),cfg->combat.retreat)) {
                // Existing local contacts only; no global builder scan. A real,
                // completed allied builder must be in range of the commander.
                for(const auto& c:contacts) if(c.friendly) {
                    const auto* ally=ai->GetFriendlyUnit(c.id);
                    const auto* repair=ally?ally->GetCircuitDef():nullptr;
                    if(repair && repair->IsAbleToAssist() && repair->GetWorkerTime()>0
                        && commander::Length(c.pos-P(pos))<=repair->GetBuildDistance()
                        && !ally->GetUnit()->IsBeingBuilt() && !ally->GetUnit()->IsParalyzed()) {
                        lineRepair=true; break;
                    }
                }
            }
            if(hp/maxHp<cfg->combat.recover && !lineRepair) {
                auto* retreat=ai->GetBuilderManager()->EnqueueRetreat();
                ai->GetBuilderManager()->AssignTask(unit,retreat);
            } else task->Resume(unit);
        } else if(opportunity && frame-s.fired>=27 && !endangered) Transition(unit,s,Mode::ASSESS,frame);
        return;
    }
    if(bestPos.SqDistance2D(pos)>16*16 && support>=cfg->combat.support && ready) {
        // Cloak requests do not prove concealment. Wait briefly for actual
        // cloak; never expand our risk budget on the strength of a request.
        Conceal(unit,s,fundedCloak);
        if(fundedCloak && !unit->GetUnit()->IsCloaked() && frame-s.started<30) return;
        if(frame-s.started>int((cfg->combat.alignSeconds+cfg->combat.maxApproach/speed)*30)) {
            Transition(unit,s,Mode::ESCAPE,frame); return;
        }
        Transition(unit,s,Mode::ALIGN,frame); Move(unit,s,bestPos,frame);
    } else {
        // Normal weapons keep firing while waiting for bank/reload. No pointless
        // movement loop that interrupts Legion's longer heat-ray contact.
        Conceal(unit,s,false); Transition(unit,s,Mode::ASSESS,frame);
    }
}

bool CCommanderController::Deploy(CCircuitUnit* unit,State& s,int frame) {
    performance::Scope measured(ai,performance::COMMANDER_DEPLOY);
    auto* task=dynamic_cast<CControlledTask*>(unit->GetTask());
    if(FallbackActive(s,frame)) return false; // the porc line bounds exploration
    if(role.frontDuty) {
        // INV-236 (D-356): front duty is a FRONT-only policy; the script sets
        // "advance" for the roles in commander.json advance_roles and front_duty
        // for FRONT alone. A commander with duty but no advance would be a
        // non-advancing role (SEA, AIR, TECH, SUPPORT) walking its lane.
        if(!role.advance) {
            if(frame>=s.lastLog+30) { s.lastLog=frame; ai->LOG("[INVARIANT] INV-236 front duty without advance role unit=%i",unit->GetId()); }
            return false;
        }
        // Let the existing idle scheduler offer construction after arrival.
        // Only deployment yields; local combat observation never pauses.
        if(frame<s.front.yield) return false;
        // Recovery is hysteresis for an actual withdrawal, not the minimum
        // health for all front work. Otherwise 40-80% commanders idle forever.
        if(!role.frontReady || (cfg->safety.healthRetreat>0?HealthRetreat(unit):unit->GetHealthPercent()<cfg->combat.recover)
            || unit->GetTask()->GetType()==IUnitTask::Type::RETREAT) return false;
        // D-299: hold the last fallback line until its turret quota stands
        // (bounded by line_hold_seconds); the ladder offers that work.
        if(frame<s.work.lineUntil && !s.work.lineDone) return false;
        const auto pos=unit->GetPos(frame),goal=FrontPosition(unit,s,frame);
        if(commanderTrace && frame%300<3) ai->LOG("[CommanderTrace] front unit=%i own=%.0f bound=%.0f goal_progress=%.0f goal=%.0f,%.0f",
            unit->GetId(),ai->GetBattle()->GetFrontLaneProgress(pos),s.front.pushBound,s.front.pushGoalProgress,goal.x,goal.z);
        if(goal.x<0 || Exposure(P(pos),P(pos),1.f,pos.y)>unit->GetUnit()->GetHealth()*.12f) return false;
        // Emergency energy precedes returning to productive front work. This
        // uses the same offer as the script, including its local retry/claim.
        if(auto* solar=FrontWork(unit,WORK_SOLAR,nullptr,0)) {
            if(unit->GetTask()!=solar) ai->GetBuilderManager()->AssignTask(unit,solar);
            return true;
        }
        // INV-234 (D-356): the push goal never passes front_distance nor the
        // screen-led bound (the furthest corridor screen plus front_push_ahead,
        // or the commander's own progress without the required screens),
        // re-derived here from the census FrontPosition recorded.
        if(cfg->front.pushAhead>0 && s.front.pushBound>=0 && s.front.pushGoalProgress>=0 && ai->GetBattle()->GetFrontLaneLength()>0.f) {
            // The recorded front's own progress, not a re-projection of the
            // point (a folded polyline projects it onto a later segment).
            const float progress=s.front.pushGoalProgress;
            // The unscreened push (front_push_screen 0) is bounded by front_distance alone.
            const float plannedBound=cfg->front.pushScreen>0?std::min(cfg->front.distance,s.front.pushBound):cfg->front.distance;
            const float bound=cfg->front.persistent>0?std::max(plannedBound,ai->GetBattle()->GetFrontLaneProgress(pos)):plannedBound;
            if(progress>bound+64.f)
                ai->LOG("[INVARIANT] INV-234 lane push goal beyond its bound unit=%i progress=%.0f bound=%.0f screens=%i",
                    unit->GetId(),progress,bound,s.front.pushScreens);
        }
        if(groupJob && StartedCommanderConstruction(unit)) return true;
        if(unit->GetTask()==s.work.task && !unit->GetTask()->IsDead()
            && (s.work.kind==WORK_MEX_DEFENCE || s.work.kind==WORK_TERRITORY_LINE || s.work.kind==WORK_REPAIR_COMBAT)
            && CanResumeFrontTask(unit,unit->GetTask())) return true;
        auto* build=dynamic_cast<IBuilderTask*>(unit->GetTask());
        // Finish a live frame/chain; planned base economy no longer prevents
        // deployment forever. Front work has its own bounded area and owner.
        // A ladder task (repair, reclaim, radar on the way) is local by
        // construction; finish it before walking on (D-299). A repair or
        // reclaim ladder task has no build definition and is still finishing
        // work (D-356: the moving anchor no longer abandons it).
        if(build && !build->IsDead() && CanResumeFrontTask(unit,build)) {
            const bool finishing=(build==s.work.task
                    || (build->GetBuildDef() && build->GetTarget() && !build->GetTarget()->IsFinished()))
                && build->GetPosition().SqDistance2D(pos)<=std::pow(cfg->front.radius+unit->GetCircuitDef()->GetBuildDistance(),2.f);
            const bool local=pos.SqDistance2D(goal)<=cfg->front.radius*cfg->front.radius*.25f
                && build->GetPosition().SqDistance2D(goal)<=cfg->front.radius*cfg->front.radius;
            if(cfg->front.pushAhead>0 ? (finishing || local)
                : (build->GetNextTask() || build->GetTarget() || build==s.work.task
                    || build->GetPosition().SqDistance2D(goal)<=cfg->front.radius*cfg->front.radius)) return true;
        }
        // Construction is a group objective. Let the selected worker establish
        // its frame before moving the anchor away; safety/fallback ran first.
        // GroupAssist bounds pre-frame holding by the project's original lease.
        if(groupJob && GroupProjectAllowed(unit,groupJob)) {
            if(auto* assist=GroupAssist(unit)) {
                if(unit->GetTask()!=assist) ai->GetBuilderManager()->AssignTask(unit,assist);
                return true;
            }
        }
        // Keep the script's bounded front hold while the anchor is still here.
        // A moving front or combat preempts it immediately; do not churn a
        // CommanderTask/STOP pair every deployment yield just to remain still.
        if(cfg->front.pushAhead>0 && !task && unit->GetTask()==s.work.task
            && unit->GetTask()->GetType()==IUnitTask::Type::WAIT
            && pos.SqDistance2D(goal)<=cfg->front.radius*cfg->front.radius*.25f) return true;
        // The deploy owner otherwise never asks the idle builder's work ladder.
        // Script opts into en-route mex work. Reuse the same local safe/ally-aware
        // selector and spot claims, at most once per configured interval. Cost:
        // outstanding mex tasks plus the metal index's local candidates, not an
        // army scan. Never interrupt a productive frame or a combat/fallback.
        if(role.work && cfg->front.mexSeconds>0
            && frame>=s.front.mexFrame+int(std::max(1.f,cfg->front.mexSeconds)*FRAMES_PER_SEC)) {
            s.front.mexFrame=frame;
            // D-357: on a published corridor the en-route spot is the corridor
            // sweep's (lane window), not the LOS disc around the commander.
            const int kind=ai->GetBattle()->GetFrontLaneLength()>0.f?WORK_MEX_LANE:WORK_MEX;
            auto* laser=cfg->front.lineDef>=0?ai->GetCircuitDefSafe(int(cfg->front.lineDef)):nullptr;
            IUnitTask* mex=cfg->front.repairCombat>0?FrontWork(unit,WORK_REPAIR_COMBAT,nullptr,0):nullptr;
            if(!mex) mex=FrontWork(unit,kind,GroupActive(unit)?nullptr:laser,0);
            if(!mex) mex=GroupAssist(unit);
            if(!mex && !GroupActive(unit)) mex=FrontWork(unit,WORK_MEX_DEFENCE,laser,0);
            if(!mex && !GroupActive(unit)) mex=FrontWork(unit,WORK_TERRITORY_LINE,laser,0);
            if(mex) {
                ai->GetBuilderManager()->AssignTask(unit,mex);
                if(unit->GetTask()==mex) {
                    s.route.clear();
                    ai->LOG("[CommanderFront] unit=%i enroute_mex frame=%i",unit->GetId(),frame);
                    return true;
                }
                // Assignment can synchronously change ownership; the old
                // deploy pointer must not be used after that hand-over.
                return true;
            }
        }
        // Arrival is admission, not a reason to create and immediately release
        // a controlled task. Preserve the existing yield for the work scheduler.
        if(!commander::ShouldStartDeployment(pos.SqDistance2D(goal),cfg->front.radius*.5f)) {
            s.front.yield=frame+60; s.detourFails=0;
            if(s.front.arrived<0)s.front.arrived=frame;
            // Preserve arrival posture/state even when no task allocation is
            // needed (notably a withdrawal returning to its safe station).
            s.deployed=true; Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame);
            if(task)task->Resume(unit);
            return task!=nullptr;
        }
        if(!task) {
            task=ai->GetBuilderManager()->EnqueueControlled(this,nullptr);
            ai->GetBuilderManager()->AssignTask(unit,task);
            if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
            s.started=frame; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
            s.front.progressFrame=frame; s.front.progressPos=pos;
            ai->LOG("[CommanderFront] unit=%i deploy x=%.0f z=%.0f",unit->GetId(),goal.x,goal.z);
        }
        s.deployed=true; Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame);
        { // Arrival was handled before task ownership changed.
            if(role.frontRecovery) {
                if(pos.SqDistance2D(s.front.progressPos)>=16.f*16.f) {
                    s.front.progressPos=pos; s.front.progressFrame=frame;
                } else if(frame>=s.front.progressFrame+int(cfg->front.stallSeconds*FRAMES_PER_SEC)) {
                    // A live MOVE can still be stuck behind dynamic blockers.
                    // Yield to local work, then retry a fresh reachable front.
                    s.front.yield=frame+2*FRAMES_PER_SEC;
                    s.front.frame=-10000; s.route.clear();
                    ai->LOG("[CommanderFront] unit=%i stalled yield frame=%i",unit->GetId(),frame);
                    task->Resume(unit);
                    if(dynamic_cast<CControlledTask*>(unit->GetTask()))
                        ai->LOG("[INVARIANT] INV-219 commander deploy failed to release after stalled movement unit=%i",unit->GetId());
                    return true;
                }
            }
            if(!s.route.empty() && s.goal.SqDistance2D(pos)>48*48
                && ai->GetUnitAPI()->HasRouteIntent(unit->GetId(),s.route,frame)) return true;
            // A detour MOVE gets its backoff to play out before the straight
            // step and reach are re-sampled (both cost terrain queries).
            if(frame<s.detourNext) return true;
            // Project the lane only when replacing movement, not on every
            // combat tick while the existing route is still owned and live.
            const Point delta=P(goal)-P(pos);
            AIFloat3 next=F(P(pos)+commander::Normal(delta)*std::min(240.f,commander::Length(delta)));
            const bool assignedLane=ai->GetBattle()->GetFrontLaneLength()>0.f;
            // Local construction can carry us beyond the front. Clamping a
            // backward step to zero repeatedly orders our present position
            // (commander-front-hold). Preserve signed progress on this lane.
            const float laneRemaining=assignedLane?ai->GetBattle()->GetFrontLaneProgress(goal)
                -ai->GetBattle()->GetFrontLaneProgress(pos):0.f;
            if(assignedLane)next=ai->GetBattle()->GetFrontLaneGoal(pos,std::clamp(laneRemaining,-240.f,240.f));
            next.y=ai->GetMap()->GetElevationAt(next.x,next.z);
            if(Route(unit,pos,next)) { s.detourFails=0; Move(unit,s,next,frame,cfg->front.pushAhead>0); }
            else if(role.frontRecovery) {
                // A blocked straight step is not an unreachable destination.
                // Let Recoil route around terrain; local combat still preempts
                // at the ordinary cadence. Recheck fresh reach before issuing.
                // Three failed detours in a row: this front is not reachable
                // in practice; take the unreachable exit and pick a new one.
                // A detour that brought the commander 64 elmos closer since the
                // last one is working, not failing: it does not spend retries.
                auto detourGoal=assignedLane?next:goal;
                bool reachable=ai->GetTerrainManager()->CanReachAt(unit,detourGoal,64);
                if(assignedLane && !reachable && (cfg->front.detourSeconds<=0 || s.detourFails<3)) {
                    // A coarse terrain cell at a bend can be unreachable for
                    // this UnitDef even when the corridor continues beyond it.
                    // Probe at most three farther lane points, only after the
                    // normal short step fails and outside the detour backoff.
                    // coverage-front-supreme exercises this at its north bend.
                    const float remaining=std::abs(laneRemaining);
                    for(float ahead:{480.f,720.f,960.f}) {
                        auto probe=ai->GetBattle()->GetFrontLaneGoal(pos,std::copysign(std::min(ahead,remaining),laneRemaining));
                        if(probe.SqDistance2D(detourGoal)<64.f*64.f)continue;
                        probe.y=ai->GetMap()->GetElevationAt(probe.x,probe.z);
                        if(ai->GetTerrainManager()->CanReachAt(unit,probe,64)) {
                            detourGoal=probe;reachable=true;break;
                        }
                    }
                }
                const float goalDist=std::sqrt(pos.SqDistance2D(detourGoal));
                if(s.detourFails>0 && goalDist<s.detourDist-64.f) s.detourFails=0;
                if((cfg->front.detourSeconds<=0 || s.detourFails<3) && reachable) {
                    ai->LOG("[CommanderFront] unit=%i detour x=%.0f z=%.0f frame=%i fails=%i",unit->GetId(),detourGoal.x,detourGoal.z,frame,s.detourFails);
                    Move(unit,s,detourGoal,frame,cfg->front.pushAhead>0); s.detourDist=goalDist;
                    if(cfg->front.detourSeconds>0) {
                        s.detourNext=frame+int(std::min(3.f,cfg->front.detourSeconds+s.detourFails)*FRAMES_PER_SEC);
                        ++s.detourFails;
                    }
                } else {
                    if(s.detourFails>=3) ai->LOG("[CommanderFront] unit=%i detour gave up after %i tries frame=%i",unit->GetId(),s.detourFails,frame);
                    s.detourFails=0;
                    s.front.yield=frame+2*FRAMES_PER_SEC;
                    s.front.point={-1,0,-1}; s.front.frame=-10000; s.route.clear();
                    task->Resume(unit);
                }
            }
        }
        return true;
    }
    if(!role.advance || unit->GetHealthPercent()<cfg->combat.recover
        || ai->GetFactoryManager()->GetFactoryCount()==0
        || ai->GetBuilderManager()->GetWorkerCount()<=cfg->front.workers
        || unit->GetTask()->GetType()==IUnitTask::Type::RETREAT) return false;
    // Strategic planning uses the existing published enemy-group snapshot once
    // a second. Local threat observation remains at three frames while deployed.
    if(frame<s.lastLog+30) return s.deployed && task;
    s.lastLog=frame;
    const auto pos=unit->GetPos(frame);
    const auto enemy=ai->GetEnemyManager()->GetNearestGroupPos(pos,cfg->combat.minValue);
    if(enemy.x<0) return false;
    const Point forward=commander::Normal(P(enemy)-P(pos));
    float support=0,best=64;
    Point anchor=P(pos);
    for(const auto& c:contacts) if(c.friendly && c.cost>0) {
        const float ahead=commander::Dot(c.pos-P(pos),forward);
        if(ahead>0 && commander::Length(c.pos-P(pos))<cfg->combat.scan) support+=c.cost;
        if(ahead>best && ahead<600) { best=ahead; anchor=c.pos-forward*120.f; }
    }
    if(support<cfg->combat.support) return false;
    const auto home=ai->GetSetupManager()->GetBasePos();
    AIFloat3 goal=F(anchor); goal.y=ai->GetMap()->GetElevationAt(goal.x,goal.z);
    if(ai->GetBattle()->GetFrontLaneLength()>0.f
        && ai->GetBattle()->GetFrontLaneDistance(goal)>ai->GetBattle()->GetFrontLaneWidth())return false;
    if(goal.SqDistance2D(home)>cfg->combat.leash*cfg->combat.leash || !Route(unit,pos,goal)) return false;
    if(!task) {
        auto* old=unit->GetTask();
        // Productive frames retain priority until completed; wait/guard/patrol
        // work can yield to supported front deployment after the opening gates.
        auto* build=dynamic_cast<IBuilderTask*>(old);
        if(build && build->GetBuildDef()!=nullptr) return false;
        task=ai->GetBuilderManager()->EnqueueControlled(this,old);
        ai->GetBuilderManager()->AssignTask(unit,task);
        if(unit->GetTask()!=task) { ai->GetBuilderManager()->AbortTask(task); return false; }
        s.started=frame; s.failed=0; s.conceal.requested=unit->GetUnit()->IsCloaked(); ++operation;
    }
    s.deployed=true; s.exit=pos;
    Conceal(unit,s,false); Transition(unit,s,Mode::SUPPORT,frame);
    if(goal.SqDistance2D(pos)>96*96) Move(unit,s,goal,frame);
    else if(s.route.empty() || !ai->GetUnitAPI()->HasRouteIntent(unit->GetId(),s.route,frame)) {
        // Native patrol performs opportunistic repair/reclaim in this supported
        // area. Combat preempts that one owner as soon as a local threat appears.
        CheckPerimeter(unit,s,goal,frame,"patrol");
        s.goal=goal; s.route={{CMD_PATROL,0,frame+300,goal.x,goal.y,goal.z}};
        TRY_UNIT(ai,unit,unit->CmdPatrolTo(goal,0,frame+300);)
    }
    return true;
}

bool CCommanderController::ReceiveProjectiles(const char* message) {
    // Optional synced BAR adapter. No hidden identities, only ally-LOS
    // projectile volumes. Reject stale/future/unbounded packets atomically.
    if(!message || std::strncmp(message,"comm_projectiles|",17)!=0) return false;
    if(std::strlen(message)>16384) return true;
    std::istringstream input(message+17); int frame,count; char sep;
    if(!(input>>frame>>sep>>count) || sep!='|' || frame<=projectileFrame || frame>ai->GetLastFrame()
        || frame<ai->GetLastFrame()-3 || count<0 || count>128) return true;
    std::vector<Projectile> parsed; parsed.reserve(count);
    for(int i=0;i<count;++i) {
        Projectile p; p.frame=frame;
        if(!(input>>sep) || sep!='|' || !(input>>p.pos.x>>p.pos.z>>p.velocity.x>>p.velocity.z>>p.radius)
            || !std::isfinite(p.pos.x) || !std::isfinite(p.pos.z) || !std::isfinite(p.velocity.x)
            || !std::isfinite(p.velocity.z) || !(p.radius>=0 && p.radius<=1000)) return true;
        parsed.push_back(p);
    }
    input>>std::ws; if(!input.eof()) return true;
    projectiles=std::move(parsed); projectileFrame=frame; return true;
}
}
