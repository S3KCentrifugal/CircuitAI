#pragma once
#include "util/IdMembership.h"
// D-388: the commander controller, the first unit controller
// (unit-controller-architecture.md). Formerly CCommanderControl; behaviour is
// unchanged except the D-389 cloak posture (commander-cloak-policy.md).
//
// Every faction commander type (armcom, corcom, legcom, their evolving
// levels and decoys) is bound to a preset by the controller registry from
// behaviour.json. State and Config are grouped by ability (conceal, retreat,
// fallback, T3, front, work); CommanderRole holds the per-AI script policy.
#include "control/core/CommandWriter.h"
#include "control/core/UnitController.h"
#include "control/kernel/CommanderCombat.h"
#include "control/kernel/CommanderFortification.h"
#include "control/kernel/CommanderGroupWork.h"
#include "control/kernel/CommanderJammerPlan.h"
#include "control/kernel/CommanderPosture.h"
#include "control/kernel/DefensePlanner.h"
#include "spring/RouteCommand.h"
#include "AIFloat3.h"
#include <cmath>
#include <map>
#include <set>
#include <string>
#include <vector>

namespace circuit {
class CCircuitAI; class CCircuitUnit; class CCircuitDef; class IUnitTask; class IBuilderTask;

// Values are logged as integers; append new modes only.
enum class CommanderMode { SUPPORT,ASSESS,APPROACH,ALIGN,PENDING,ESCAPE,RECOVER,FALLBACK };

// ---- per-commander state, grouped by ability -------------------------------
struct CommanderConcealState {
    bool requested=false;   // last cloak request sent through the writer by the engagement code
    int unseenUntil=0;      // D-294: withdrawing cloaked from fire it cannot see
    // D-389 posture, re-chosen once a second and on damage.
    int posture=0;          // commander::posture::Posture as int
    bool postureCloak=false;
    bool threatNear=false;  // the posture picture sees a threat in reach now or within the horizon
    int postureNext=0;
    const char* postureReason="";
    int postureChanges=0;   // cloak decision toggles this minute (each one an order)
    bool budgetHold=false;  // over the cloak budget until spend falls to half of it
    bool known=false;       // INV-246: the request flag has been read since the last pause
    int invariantNext=0;
    // Cloak energy, per game minute and as a decaying one-minute window.
    int accountFrame=-1, minute=-1;
    float stillSeconds=0,movingSeconds=0,energy=0,window=0;
};
struct CommanderRetreatState {
    bool energy=false; int energyPlan=-10000; springai::AIFloat3 energyGoal{-1,0,-1};
    bool health=false; int healthPlan=-10000,healthShotUntil=-1; springai::AIFloat3 healthGoal{-1,0,-1};
    int lastTaskType=-1;    // D-389: detects the end of a retreat lease
};
struct CommanderFallbackState {
    // D-293 fallback: held until `until`, porc line replanned once/second.
    bool active=false;
    int until=-1,planned=-10000,porc=-1,moveUntil=-1;
    int heldPorc=-1,heldPorcUntil=-1; // KI-609: last chosen porc, kept 5 s past its last choice
    int goalSince=-10000;
    float metal=0,reach=0;
    commander::FallbackBoundary boundary;
    springai::AIFloat3 goal,threat;
};
struct CommanderT3State {
    // D-294 T3 engagement: target, resolved plan, shot accounting, juke.
    int target=-1,approach=0,commit=0,shots=0,lastShot=-1,jukeUntil=-1,jukeSide=1;
    int progress=0,ended=-1,started=-1,seen=-1,declined=-1,declinedSeen=-1,reconsider=0;
    int declineFails=0,positionUntil=0,positionTarget=-1;
    bool cornered=false,artillery=false,afus=false;
    int screens=0,screenUntil=0; // bait turrets ordered this engagement
    int screenDef=-1,screenUnit=-1,screenCheck=0;
    float screenProgress=0;
    springai::AIFloat3 screenPos;
    float closest=0,juke=0,standoff=0,minHealth=0,radius=0,splash=0,cost=0,advance=0,reach=0;
    springai::AIFloat3 anchor,lastPos,heading; // heading: last direction of travel
    std::vector<int> distant; int distantFrame=-10000; // artillery beyond scan
};
struct CommanderFrontState {
    springai::AIFloat3 point{-1,0,-1};
    int frame=-10000,yield=0,mexFrame=-10000,progressFrame=0,arrived=-1;
    int solarNext=0; // failed local placement retry, no recurring timer
    springai::AIFloat3 progressPos;
    // D-356 lane push census of the last FrontPosition: corridor combat
    // screens within scan, the furthest one's lane progress, the anchor
    // bound actually applied (INV-234 re-derives it in Deploy), and the
    // "then home" latch (never released: the meta's "then home").
    int pushScreens=0; float pushScreenProgress=-1,pushBound=-1;
    // The lane progress the recorded front was built at. INV-234 compares
    // this, not a re-projection of the point: on a folded polyline the
    // exact lane point can project onto a later segment (b06 Glacial,
    // +194 elmos), which is geometry, not a goal beyond the bound.
    float pushGoalProgress=-1;
    bool pushHome=false;
    // D-357 corridor mex sweep: distinct spots offered, the last one, and
    // whether the next lane offer is the turret that follows them.
    int laneMexCount=0; bool laneMexTurret=false;
    int expansionMexNext=0;
    springai::AIFloat3 laneMexLast{-1,0,-1};
    // Completion-owned IDs, never borrowed unit pointers. Released with the
    // commander; destroyed/transferred mexes are removed on a work offer.
    std::vector<int> unfortifiedMexes;
    struct TerritoryPlan {
        std::vector<springai::AIFloat3> sites;
        float progress=0;
        bool pending=true;
        int reviewFrame=0;
    };
    std::vector<TerritoryPlan> territoryPlans;
    float territoryProgress=-1;
    float fortifyNextProgress=0;
    int territoryCorridor=-1, territoryClass=-1, fortifyRetry=0, mexFortifyRetry=0;
    bool territoryPending=false;
};
struct CommanderWorkState : commander::WorkIdentity<IUnitTask> {
    // D-299 work ladder. lineUntil keeps the last fallback line's turret
    // quota open after the fallback ends; task is the last ladder task
    // (address compared only, never dereferenced) that Deploy must not
    // interrupt. timedNext: definition id -> next due frame.
    int lineUntil=-1,lineRetry=0,lineYield=-10000,radarFrame=-10000,lineOutside=-1;
    bool lineDone=false,radarCovered=false,held=false; // held: offered under a fallback
    springai::AIFloat3 lineAnchor{-1,0,-1},lineThreat,radarPos{-1,0,-1};
    commander::FallbackBoundary boundary; // perimeter when task was offered
    std::map<int,int> timedNext;
};
struct CommanderState : control::ControlledState {
    CommanderMode mode=CommanderMode::SUPPORT;
    int generation=0,seen=-10000,started=0,pending=-1,fired=-1,failed=0;
    int retry=0,target=-1,leaseUntil=0,next=0,lastLog=0,lastDamage=-1;
    // Throttles (owner 2026-10-19): a failed detour or a declined T3 waits
    // 1 s, +1 s per failure in a row, at most 3 s; success resets.
    int detourNext=0,detourFails=0;
    bool immediatePending=false;
    float detourDist=0.f; // distance to the front at the last detour MOVE
    // Same-goal MOVE resend backoff (owner 2026-10-19).
    int moveSent=-10000,moveResends=0;
    springai::AIFloat3 moveGoal{-1,0,-1};
    float budget=0;
    bool deployed=false,invalidated=false;
    springai::AIFloat3 exit,goal;
    float fundingBudget=0;
    int fundingUntil=-1,fundingTarget=-1;
    std::vector<routecommand::Command> route;
    CommanderConcealState conceal;
    CommanderRetreatState retreat;
    CommanderFallbackState fallback;
    CommanderT3State t3;
    CommanderFrontState front;
    CommanderWorkState work;
};

// ---- per-preset settings, grouped by ability ---------------------------------
// Defaults equal the pre-D-388 native defaults; behaviour.json presets and the
// script levers (SetCommanderCombatOption) override them through kConfigTable.
struct CommanderCombatConfig {
    float scan=1000,leash=700,step=96,support=600,minValue=180,killReward=45;
    float hpReserve=.35f,retreat=.45f,recover=.8f,aggression=.25f;
    float shots=2,margin=150,escapeSeconds=4.3f,alignSeconds=.6f;
    float maxApproach=180,maxSeconds=12,cloakSeconds=1.5f,donorReserve=1200;
    float friendlyMargin=12,normalRange=.85f;
    float detectionMargin=32;
    float moveResendSeconds=0;   // 0: a swallowed/failed MOVE is resent every tick
    float afusDefenceRadius=0;   // opt-in script policy; zero preserves ordinary combat
    float sensorMemory=10;       // seconds a lost mobile sensor still counts (D-293)
};
struct CommanderSafetyConfig {
    float healthRetreat=0,healthShotSeconds=2;
    float decoyHealthRetreat=.9f,decoyHealthRecover=.95f;
    float decoyBait=1; // reuse safety/lane work, never plan a real-commander D-gun attack
    float jamSafe=0,jamHeavyCost=900;
    float cloakEnergyRetreat=0,cloakRetreatDistance=600;
};
// D-389 cloak posture levers (commander-cloak-policy.md section 4.4).
struct CommanderCloakConfig {
    float posture=1;            // 0: never cloak preventively (no posture cloak)
    float threatRadius=1500;    // remembered and visible enemies considered
    float horizon=4;            // seconds ahead an approaching threat counts
    float outrangeMargin=50;    // elmos beyond the laser that count as outranging
    float outrangeDps=120;      // outranging dps that forces a withdrawal
    float artilleryDps=60;      // artillery dps that forces a withdrawal
    float artilleryRange=600;   // a ballistic weapon at least this long is artillery
    float retreatSeconds=6;     // time to die below which the commander withdraws
    float escapeSeconds=3;      // time to die below which it escapes cloaked
    float brawlMargin=1.5f;     // clear time x margin must stay below time to die
    float dgunKills=2;          // short-range units one D-gun line is credited with
    float ambushSeconds=20;     // ambush only when the approaching enemies would kill it this fast
    float withdrawCloakSeconds=10; // a withdrawal cloaks only below this time to die
    float memorySeconds=60;     // remembered enemies older than this are dropped...
    float memoryCap=600;        // ...and their position uncertainty is capped here
    float budget=.15f;          // cloak energy per minute as a share of income (0: no cap)
    float frontIncome=0;        // 0 disables FRONT economy cloak; enabled by active JSON
    float decoyFrontIncome=0;   // decoys are visible bait unless explicitly opted in
    float stillSeconds=10;      // bank seconds a stationary cloak must be funded for
    float period=30;            // frames between posture choices
    float log=1;                // per-minute cloak energy log line
    float blipDps=60;           // assumed dps of a radar blip of unknown type
    float blipRange=450;        // assumed range of a radar blip of unknown type
};
struct CommanderGroupConfig {
    float defenceMetal=50,defenceEnergy=1000,budgetSeconds=30,budgetFraction=.25f,mexUpgrade=1;
    float jammerEdge=0,jammerIncome=25;
    float jammerGain=.25f,jammerSpacing=.6f,jammerHold=10,jammerOutage=60;
    float mexPriority=3,radarPriority=2,linePriority=1;
    float combatDistance=1000,combatMemory=30,radius=600;
    float maintenance=1,lineReviewSeconds=5,projectHoldSeconds=30;
};
struct CommanderFrontConfig {
    float workers=2;
    float distance=1600,standoff=650,radius=500,threat=3;
    float repairCombat=0;
    float solarIncome=0,solarStorage=.2f,solarRadius=300,solarDef=-1;
    float mexSeconds=0,stallSeconds=10,detourSeconds=0; // 0: no detour backoff
    float mexAA=-1,mexLos=0,radarSpacing=500;
    float persistent=0,mexDefence=0,lineEnabled=0;
    float mexMinIncome=0,mexBaseRadius=900; // 0 income disables expansion LLT policy
    float lineFog=1000,lineSpacing=1.5f;
    float defenceSpacing=.5f;
    float lineDepth=800,mexOffset=160,workBehind=400;
    float fortifyBank=.5f,fortifyPriority=1;
    float fortifyAdvance=0; // 0: complete the line before advancing
    float corridor=-1,corridorClass=-1,lineDef=-1;
    float pushAhead=0; // 0: old screen-led anchor; positive: continuous lane advance
    // D-356: the push is screen-led (corridor combat units required before
    // the anchor leaves the commander's own progress; 0 = unscreened), ends
    // after pushUntilSeconds or once observed enemy riot metal reaches
    // pushHomeRiot ("then home"; 0 = never), and FRONT offers beyond lane
    // half-width + laneMargin are declined (0 = the commander's build distance).
    float pushScreen=0,pushUntilSeconds=0,pushHomeRiot=0,laneMargin=0;
    // D-357: corridor mex sweep. Spots within half-width + mexReach (0 = build
    // distance) of the lane, from mexBehind behind the commander to mexAhead
    // ahead of it; enemy extractors on those spots are captured when
    // mexCaptureEnemy; one line turret per mexTurretEvery corridor mexes.
    float mexReach=0,mexBehind=400,mexAhead=600,mexCaptureEnemy=0,mexTurretEvery=0;
    float mexEnemyHome=0; // spots this close to an enemy start are never swept (0 = off)
};
struct CommanderT3Config {
    float immediateShot=0,positionSeconds=0; // opt-in balanced combat policy
    float intercept=1,health=.2f,distance=1000;
    // D-294: engagement leash around the anchor, seconds a HOLD target may stop
    // closing before the commander flanks, and the post-kill dodge.
    float leash=900,holdSeconds=4,dodgeSeconds=1.2f;
    float huntLeash=1800; // artillery sits beyond the line; hunting it goes further
    float screen=300; // friendly combat metal in the T3's reach before a 3+ shot kill
    float hunt=0,artilleryApproach=180,trade=0,retrySeconds=2,declineGate=0;
    float cloakedVolleyRisk=1; // script tunes uncertain new targeting; in-flight damage stays full
    float baitDef=-1,baitCount=0,baitMargin=150,baitDistance=120,baitSpacing=80,baitTimeout=5;
};
struct CommanderFallbackConfig {
    // D-293: fall back to the backline porc line before a capable group.
    float metal=400,rangeScale=2,groupRadius=400;
    float offset=120,search=2000,holdSeconds=3,porcRange=1500;
    float prepareSeconds=4; // safe station arrival/preparation buffer; script/JSON lever
    float goalHoldSeconds=0; // 0: the fallback goal may change every replan
};
struct CommanderWorkConfig {
    // D-299 FRONT work ladder. radius 0 = the commander's own LOS.
    float radius=0,clearance=400,repairHealth=.98f,reclaimStorage=.95f,reclaimMetal=1;
    float lineIncome=20,lineMin=1,lineMax=6,lineRadius=400,lineSpacing=80,lineHoldSeconds=60,lineRetrySeconds=5;
    float timedInterval=30,timedUntil=300,radarCoverage=.8f,baseRadius=1500;
};
struct CommanderConfig {
    CommanderCombatConfig combat;
    CommanderSafetyConfig safety;
    CommanderCloakConfig cloak;
    CommanderGroupConfig group;
    CommanderFrontConfig front;
    CommanderT3Config t3;
    CommanderFallbackConfig fallback;
    CommanderWorkConfig work;
};
// Per-AI policy the role script sets (not per unit type).
struct CommanderRole {
    bool enabled=false,advance=false,decoys=false,frontDuty=false,frontReady=false;
    bool work=true; // D-299 ladder and fallback hand-over (script Global::Commander::Work)
    float peakEnergyIncome=0; // FRONT-role income high-water mark; reset when duty ends
    bool frontRecovery=false;
    bool fallback=true;
};

class CCommanderController final : public CUnitControllerBase<CommanderConfig,CommanderState> {
public:
    using State=CommanderState;
    using Mode=CommanderMode;
    explicit CCommanderController(CCircuitAI* ai);

    // IUnitController
    const char* Name() const override { return "commander"; }
    void Attach(CCircuitUnit* unit) override;
    void Detach(int id) override;
    void TeamUnitRemoved(int id) override;
    bool Owns(CCircuitUnit* unit) const override;
    void Update() override;
    void Damaged(CCircuitUnit* unit) override;
    void MoveFailed(int id) override;
    void WeaponFired(int id,int weapon) override;
    bool ReceiveMessage(const char* message) override { return ReceiveProjectiles(message); }
    bool SetOption(const std::string& name,float value) override;
    void RestoreAfterLease(CCircuitUnit* unit,int fireState,int moveState) override;
    bool CanResumeTask(CCircuitUnit* unit,IUnitTask* task) const override { return CanResumeFrontTask(unit,task); }

    bool Handles(CCircuitUnit* unit) const;
    bool Jammed(CCircuitUnit* unit);
    bool RetreatCloakFunded(CCircuitUnit* unit) const;
    bool EnergyRetreat(CCircuitUnit* unit) const;
    bool HealthRetreat(CCircuitUnit* unit) const;
    int FrontCommanderId() const;
    void TaskFinished(IUnitTask* task,bool done);
    bool OwnsGroupProject(const IUnitTask* task) const { return task && task==groupJob; }
    bool IsGroupMember(int id) const;
    bool SetDefenseRule(int slot,const std::string& key,float value);
    std::string DescribeDefense() const { return defenseReason; }
    void SyncDefenseClaim(IBuilderTask* task,int& token);
    bool PendingProtection(CCircuitDef* def,const springai::AIFloat3& at);
    bool GroupSiteAllowed(CCircuitUnit* unit,const springai::AIFloat3& site) const;
    bool GroupBuildSiteAllowed(CCircuitUnit* unit,const CCircuitDef* def,const springai::AIFloat3& site) const;
    commander::JammerPlan GroupJammerCoverage(CCircuitUnit* unit,CCircuitDef* def,
        const springai::AIFloat3& center,float searchRadius,const IUnitTask* ignore=nullptr);
    bool RetreatStation(CCircuitUnit* unit,springai::AIFloat3& goal) const;
    float GetReserve() const { return reserve; }
    float GetDeficit() const;
    int GetOperation() const { return operation; }
    // Read-only cached decision state. No callbacks, census or replanning;
    // O(log commanders), called only by the strategic snapshot publisher.
    std::string DescribeFront(int id) const;

    bool ReceiveProjectiles(const char* message);
    IUnitTask* FrontWork(CCircuitUnit* unit,int kind,CCircuitDef* buildDef,float radius);
    bool CanStartRadar(CCircuitUnit* unit);
    void MexFinished(CCircuitUnit* commander, CCircuitUnit* mex);
    bool GroupMayBuild(CCircuitUnit* unit,CCircuitDef* def,const springai::AIFloat3& site) const;
    bool CanResumeFrontTask(CCircuitUnit* unit, IUnitTask* task) const;
    std::vector<commander::DefenceExclusion> DefenceExclusions(CCircuitUnit* unit,CCircuitDef* def,
        const springai::AIFloat3& center,float searchRadius,const IUnitTask* ignore=nullptr) const;

protected:
    void OnPresetAssigned(int defId,int preset) override;

private:
    CCommanderController(const CCommanderController&)=delete;
    CCommanderController& operator=(const CCommanderController&)=delete;
    CommanderRole role;
    CCommandWriter writer;
    std::vector<int> frontDefenceDefs;
    bool IsFrontDefence(const CCircuitDef* def) const;
    // Script owns the one-member roster and faction definitions. IDs are
    // reacquired on every ask and cleared on ownership loss, never wrappers.
    int groupUnit=-1, groupDef=-1, groupNano=-1, groupRadar=-1, groupJammer=-1,groupAA=-1;
    // Fixed roster: three T2 workers, radar, jammer, decoy. Script owns desired
    // seats; the native shell reacquires IDs and never ties lifetime to an anchor.
    std::array<int,6> groupMembers{{-1,-1,-1,-1,-1,-1}};
    int groupDef2=-1,groupRadar2=-1,groupJammer2=-1,groupAA2=-1;
    State groupState;
    IUnitTask* groupJob=nullptr; // borrowed until BuilderManager::DequeueTask callback
    springai::AIFloat3 groupNanoSite{-1,0,-1};
    bool groupNanoDue=false,groupJobNano=false,groupJobEarnsNano=true;
    unsigned groupNanoOwed=0;
    int groupNext=0,groupAnchorId=-1,groupMaintenanceNext=0,groupUpgradeNext=0,groupProjectUntil=-1;
    bool GroupCanBuild(CCircuitDef* def,CCircuitUnit* anchor) const;
    bool GroupCanFund(CCircuitDef* def) const;
    std::array<defense::Rule,defense::MAX_RULES> defenseRules;
    defense::Settings defenseSettings;
    struct DefenseFacts {
        float alpha=0,reload=1,range=0,shotEnergy=0,operatingEnergy=0,warmup=0,coverage=0,shieldRegen=0;
        float ammunitionMetal=0,ammunitionEnergy=0;
        int shieldWeapon=-1,shieldMask=0,interceptMask=0;
        bool nuclear=false,plasma=false,onOff=false;
        struct Weapon { float alphaScale=1,reload=1; };
        std::vector<Weapon> weapons;
    };
    std::map<int,DefenseFacts> defenseFacts; // immutable UnitDef facts, this AI lifetime
    defense::Demands defenseDemand;
    std::array<bool,defense::COUNT> defenseUrgent{};
    bool defenseLocalDanger=true;
    springai::AIFloat3 defenseShieldCenter{-1,0,-1};
    float defenseShieldRadius=0,defensePlasmaAlpha=0;
    std::array<springai::AIFloat3,defense::COUNT> defenseTargets;
    springai::AIFloat3 defenseStation{-1,0,-1};
    int defenseStableSince=0;
    std::array<float,defense::COUNT> defenseActive{},defensePending{};
    std::array<int,defense::MAX_RULES> defenseCounts{};
    std::array<int,defense::MAX_RULES> defensePlacementRetry{};
    IdMembership defenseRepresented;
    int defenseNext=0,defenseOfferNext=0,defenseChoice=-1;
    int defenseDecisionNext=0;
    defense::Evaluation defenseEvaluation;
    float defenseReservedMetal=0,defenseReservedEnergy=0;
    std::string defenseReason="not_assessed";
    const DefenseFacts& DefenseFactsFor(CCircuitDef* def);
    void AssessGroupDefense(CCircuitUnit* anchor,int frame);
    void AssessDefenseCoverage(CCircuitUnit* anchor,int frame);
    std::array<float,defense::COUNT> DefenseCapacity(CCircuitDef* def,const defense::Rule& rule,const springai::AIFloat3* site=nullptr);
    struct DefenseBuilder { CCircuitDef* def=nullptr; float travel=0; };
    using DefenseBuilders=std::array<DefenseBuilder,6>;
    DefenseBuilders GatherDefenseBuilders(CCircuitUnit* anchor);
    defense::Project DefenseProject(CCircuitDef* def,const DefenseFacts& facts,const DefenseBuilders& builders);
    IUnitTask* GroupPlannedDefense(CCircuitUnit* unit,CCircuitUnit* anchor,int frame);
    bool IsGroupStructure(int defId) const;
    bool GroupLaneWorkAllowed(CCircuitUnit* unit,CCircuitDef* def,const springai::AIFloat3& at) const;
    IUnitTask* GroupUpgradeMex(CCircuitUnit* unit,CCircuitUnit* anchor);
    bool GroupNearCombat(CCircuitUnit* anchor);
    IUnitTask* TrackGroupJob(IUnitTask* task,bool earnsNano=true);
    bool GroupProjectAllowed(CCircuitUnit* unit,IUnitTask* task) const;
    IUnitTask* GroupLocalMaintenance(CCircuitUnit* unit,CCircuitUnit* anchor);
    IUnitTask* GroupConstruction(CCircuitUnit* unit,CCircuitUnit* anchor,int frame);
    IUnitTask* GroupFollow(CCircuitUnit* unit,CCircuitUnit* anchor);

    bool groupArrived=false;
    CCircuitUnit* GroupCommander() const;
    bool GroupActive(CCircuitUnit* commander);
    IUnitTask* GroupWork(CCircuitUnit* unit);
    IUnitTask* GroupAssist(CCircuitUnit* commander);
    IUnitTask* StartedCommanderConstruction(CCircuitUnit* unit) const;
    bool GroupTaskFunded(IUnitTask* task) const;
    IUnitTask* GroupBuild(CCircuitUnit* unit, CCircuitDef* def, const springai::AIFloat3& site, bool nano=false, int defenseSlot=-1, bool surplus=false);
    void UpdateCommanderGroup();
    struct Threat {
        commander::Point pos,velocity;
        float range=0,damage=0,reload=1,delay=0,splash=0,speed=0,arc=-1,heightMod=0,height=0;
        bool projectile=false,guided=false,ballistic=false;
        float beamRange=0,beamMinIntensity=1,beamClearance=0;
    };
    struct Projectile { commander::Point pos,velocity; float radius=0; int frame=0; };
public:
    // D-294 per-T3 strategy. Negative fields resolve automatically from the
    // target's stats; JSON commander.combat.t3_profiles and the script option
    // "t3.<unit>.<field>" override them per unit definition.
    enum T3Approach { T3_AUTO=0,T3_HOLD=1,T3_FLANK=2,T3_HUNT=3,T3_REAR=4 };
    struct T3Profile { float approach=-1,commit=-1,juke=-1,standoff=-1,health=-1,advance=-1; };
private:
    std::map<std::string,T3Profile> t3Profiles;
    std::map<std::string,T3Profile> configuredT3Profiles;
    void ReadProfiles();
    bool SetProfileOption(const std::string& name,float value,bool reset=false);
    CCircuitAI* ai;
    // IsDecoy() is the legacy *impersonated-definition* hint. Cache the actual
    // UnitDef decoy relationship separately; definitions live for this AI/game.
    mutable std::map<int,bool> actualDecoys;
    bool ActualDecoy(CCircuitDef* definition) const;
    std::vector<commander::Contact> contacts;
    std::set<int> afusDefs; // script-selected immutable definition IDs, per AI
    int protectedAfus=-1; // fresh local observation, never retained across Tick
    std::vector<Threat> threats;
    std::vector<int> seeds;
    std::vector<Projectile> projectiles;
    // Enemies whose known weapons can hit this commander; rebuilt by Observe.
    std::vector<commander::Attacker> attackers;
    bool submergedContact=false; // D-294: a sonar-only contact under water within t3_distance
    struct PorcCandidate { springai::AIFloat3 pos; float edge=0,distance=0; int id=-1; };
    std::vector<PorcCandidate> porcs;
    struct Definition {
        float radar=0,jammer=0,seismic=0,decloak=0,blastRadius=0,blastEdge=0;
        bool t3=false,stealth=false;
        float tech=1; // BAR customparams.techlevel (1, 1.5, 2, 3); D-299 repair order
        std::vector<float> blastDamage; // immutable death-weapon data for mobile attackers
    };
    std::map<int,Definition> definitions;
    const Definition& DefinitionFor(CCircuitDef* def);
    float T3Leash(const State& s) const {
        return s.t3.artillery && cfg->t3.hunt<=0 ? cfg->t3.artilleryApproach
            : s.t3.approach==T3_HUNT ? cfg->t3.huntLeash : cfg->t3.leash;
    }
    struct Sensor { commander::Point pos; float radar=0,seismic=0; };
    std::vector<Sensor> sensors;
    int sensorFrame=-10000;
    int projectileFrame=-1,sequence=0,operation=0;
    float reserve=0;
    float maxJammerRadius=-1;
    std::vector<int> jammerIds;
    std::vector<float> jammerRadii;
    void InitJammerRadii();
    commander::JammerDemandMemory jammerDemand;
    std::map<int,commander::JammerOutage> jammerOutages;
    bool HealthControl(CCircuitUnit* unit,State& s,int frame);
    struct JamZone { commander::Point center; float radius; };
    std::vector<JamZone> jamZones;
    bool JamControl(CCircuitUnit* unit,State& state,int frame);
    void Tick(CCircuitUnit* unit,State& state,int frame);
    void Observe(CCircuitUnit* unit,int frame);
    // moving: unguided ballistic shells mostly miss a moving commander (D-294).
    float Exposure(commander::Point from,commander::Point to,float seconds,float height,bool moving=false,float newVolleyRisk=1.f) const;
    bool Route(CCircuitUnit* unit,const springai::AIFloat3& from,const springai::AIFloat3& to) const;
    void Move(CCircuitUnit* unit,State& state,const springai::AIFloat3& goal,int frame,bool transit=false);
    void Conceal(CCircuitUnit* unit,State& state,bool value);
    void Transition(CCircuitUnit* unit,State& state,Mode mode,int frame);
    bool Deploy(CCircuitUnit* unit,State& state,int frame);
    springai::AIFloat3 FrontPosition(CCircuitUnit* unit,State& state,int frame);
    bool CloakSafe(CCircuitUnit* unit,commander::Point from,commander::Point to,float seconds);
    bool Intercept(CCircuitUnit* unit,State& state,int frame);
    void EndT3(CCircuitUnit* unit,State& state,int frame,const char* reason);
    void Decline(CCircuitUnit* unit,State& state,const commander::Contact& target,int frame,const char* reason);
    bool Fire(CCircuitUnit* unit,State& state,const commander::Line& line,int frame,bool acceptT3Risk=false,bool acceptJamRisk=false);
    bool FallbackActive(const State& state,int frame) const { return state.fallback.active && frame<state.fallback.until; }
    // Engine reachability indexes sectors by position without bounds checks
    // (KI register, GetClosestSector). Reject garbage/off-map points first.
    static bool OnMap(const springai::AIFloat3& p) {
        return std::isfinite(p.x) && std::isfinite(p.z) && p.x>=0 && p.z>=0
            && p.x<springai::AIFloat3::maxxpos && p.z<springai::AIFloat3::maxzpos;
    }
    void PlanFallback(CCircuitUnit* unit,State& state,int frame);
    bool Fallback(CCircuitUnit* unit,State& state,IUnitTask* current,int frame);
    void CheckPerimeter(CCircuitUnit* unit,const State& state,const springai::AIFloat3& goal,int frame,const char* source) const;
    // D-299 work ladder (CommanderWork.cpp). Kinds 5..16; see FrontWork. The
    // script names them in commander.json front_ladder (CommanderFront::Work).
    enum WorkKind { WORK_LINE=5,WORK_REPAIR_DEFENCE=6,WORK_REPAIR_UNITS=7,WORK_RECLAIM=8,
        WORK_TIMED=9,WORK_RADAR=10,WORK_FACTORY=11,WORK_BASE=12,WORK_MEX=13,WORK_ADVANCE=14,WORK_HOLD=15,
        WORK_MEX_LANE=16, WORK_TERRITORY_LINE=17, WORK_MEX_DEFENCE=18, WORK_REPAIR_COMBAT=21, WORK_SOLAR=22 };
    IUnitTask* LadderWork(CCircuitUnit* unit,State& state,int kind,CCircuitDef* buildDef,float radius,int frame);
    // D-357: the corridor mex sweep (WORK_MEX_LANE) and its dry probe (INV-235).
    IUnitTask* LaneMexWork(CCircuitUnit* unit,State& state,CCircuitDef* turretDef,int frame);
    bool LaneMexAvailable(CCircuitUnit* unit,State& state,int frame);
    bool LaneMexSiteAllowed(CCircuitUnit* unit,const springai::AIFloat3& site) const;
    float LaneMexAheadLimit(CCircuitUnit* unit,State& state,int frame,float own);
    // D-356: the "then home" latch of the lane push.
    bool PushHome(CCircuitUnit* unit,State& state,int frame);
    IUnitTask* ExpansionMexWork(CCircuitUnit* unit,State& state,CCircuitDef* def,int frame);
    IUnitTask* MexDefenceWork(CCircuitUnit* unit,State& state,CCircuitDef* def,int frame);
    IUnitTask* TerritoryLineWork(CCircuitUnit* unit,State& state,CCircuitDef* def,int frame);
    IUnitTask* FortifySite(CCircuitUnit* unit,CCircuitDef* def,const springai::AIFloat3& site,int frame,
        const springai::AIFloat3* coveragePoint=nullptr);

    IUnitTask* RepairWork(CCircuitUnit* unit,const State& state,bool defence,float radius,int frame,bool stationary=false);
    IUnitTask* ReclaimWork(CCircuitUnit* unit,const State& state,float radius,int frame);
    IUnitTask* LineWork(CCircuitUnit* unit,State& state,CCircuitDef* buildDef,int frame);
    IUnitTask* RadarWork(CCircuitUnit* unit,State& state,CCircuitDef* buildDef,int frame);
    bool RadarCovered(CCircuitUnit* unit,State& state,int frame);
    IUnitTask* AssistWork(CCircuitUnit* unit,const State& state,const springai::AIFloat3& center,float radius,bool factories,int frame);
    float WorkRadius(CCircuitUnit* unit) const;
    // A ladder target is legal while a fallback holds only inside its perimeter.
    bool InsideLine(const State& state,const springai::AIFloat3& p,int frame,float slack) const {
        return !FallbackActive(state,frame) || state.fallback.boundary.Contains({p.x,p.z},slack);
    }
    bool LineWorking(CCircuitUnit* unit,const State& state,IUnitTask* current,int frame) const;
    // The hand-over exists only where the script ladder will offer work.
    bool LadderActive() const { return role.work && role.frontDuty && role.frontReady; }
    std::vector<int> workIds; // copy of a shared callback buffer; reused

    // ---- D-389 cloak posture (CommanderPosture.cpp) ----
    using Matchup = commander::posture::WeaponMatchup;
    // Own definition also determines category and collision radius, not just armour.
    std::map<std::pair<int,int>,Matchup> matchups; // (enemy type, own type), immutable weapon facts
    const Matchup& MatchupFor(CCircuitDef* enemy,CCircuitDef* self);
    std::vector<commander::posture::ThreatEntry> postureThreats; // reused buffer
    commander::posture::Concealment ConcealmentOf(CCircuitUnit* unit,const State& state);
    // Re-chooses the posture when due (or forced, after damage).
    void UpdatePosture(CCircuitUnit* unit,State& state,int frame,bool force);
    void AccountCloak(CCircuitUnit* unit,State& state,int frame);
    // The cloak this commander should hold when no engagement owns it.
    bool SupportCloak(CCircuitUnit* unit,const State& state) const;
    // verify: compare with BAR's request flag (once a second) and check INV-246.
    void SyncSupportCloak(CCircuitUnit* unit,State& state,int frame,bool verify);
    // A retreat's fire state and cloak: hidden only when it conceals from a threat.
    void RetreatConceal(CCircuitUnit* unit,State& state,int frame,bool threatened);
};
}
