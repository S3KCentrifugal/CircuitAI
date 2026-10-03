/*
 * AirWaveTask.h
 *
 * A script-planned bomber wave: the wave forms a line abreast at a stand-off
 * point, holds if told to, then attack-moves along parallel lanes through the
 * aim point (carpet) or dives on one chosen unit (strike). Script picks the
 * method and the numbers (AirWaves:: in manager/air_waves.as); this task owns
 * the geometry, the threat-sampled bearing, the formation check and the
 * orders. When the run is over the task aborts itself and the survivors fall
 * to the native CBombTask for the mop-up. See doc/air-wave-attacks.md.
 */
#ifndef SRC_CIRCUIT_TASK_FIGHTER_AIRWAVETASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_AIRWAVETASK_H_

#include "task/fighter/FighterTask.h"

#include <map>
#include <vector>

namespace circuit {
class CCircuitDef;

class CAirWaveTask final: public IFighterTask {
public:
	// Numbers are the script's contract (Task::WaveMode in task.as).
	enum class EMode: char {CARPET = 0, FLANK, PINCER, STRIKE, DEEP, FEINT};
	// PLANNED until SetPlan; DONE is terminal and the task aborts itself.
	enum class EState: char {PLANNED = 0, FORMING, HOLDING, ATTACKING, DONE, RETURNING};
	// bearingDeg value meaning "sample the threat map and take the quietest".
	static constexpr float SMART_BEARING = 999.f;

	CAirWaveTask(ITaskModule* mgr);
	virtual ~CAirWaveTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;
    void OnWeaponFired(CCircuitUnit* unit, int weaponDefId);
    void OnDamageDealt(CCircuitUnit* unit, int weaponDefId);

	// Script hooks
	/*
	 * mode          EMode
	 * aim           the point the lanes run through (STRIKE/DEEP: the target's position)
	 * formDistance  stand-off from the aim to the line, elmos
	 * spacing       between lanes, elmos
	 * overrun       how far past the aim the lanes run, elmos
	 * formTimeout   frames to wait for the line before going anyway
	 * holdFrames    frames to hold the formed line before attacking (FEINT)
	 * bearingDeg    approach bearing relative to base->aim; SMART_BEARING samples the threat map
	 * groups        1, or 2 for a pincer (bearings +/- bearingDeg)
	 */
	void SetPlan(int mode, const springai::AIFloat3& aim, float formDistance, float spacing, float overrun,
			int formTimeout, int holdFrames, float bearingDeg, int groups);
	/*
	 * Choose a strike target from the known hostiles and make it the aim.
	 * preference 0: highest value (cost) nearest the front; 1: deepest - the
	 * qualifying target farthest from our base. Qualifying: an immobile unit
	 * costing at least minStaticCost, or (includeHeavy) a mobile "heavy" (T3).
	 * False when nothing qualifies; the plan is untouched.
	 */
	bool PickStrikeTarget(const springai::AIFloat3& from, int preference, float minStaticCost, bool includeHeavy);
    void SetFlightPolicy(float width, float rankSpacing, float lossAbort, const springai::AIFloat3& home);
    void SetStrikePolicy(CCircuitDef* bomber, int count, float passFraction, float margin, float threatWeight, float maxThreat);
    void ConsiderStrikeAircraft(CCircuitDef* bomber);
    void SetAssemblyPolicy(float radius, float fraction, int joinFrames);
    void SetMissionPolicy(float padding, float inset, float unknown, float riskScale, float armyReserve, float localAAReserve, bool synchronize);
    void ExcludeStrikeRegion(const springai::AIFloat3& centre, float radius);
    void SetOperationPolicy(bool offensive, int preference, const springai::AIFloat3& assembly, float lead, float routeCeiling, float localRadius);
    void AllowStrikeDef(CCircuitDef* def, float priority);
    void AddSearchPoint(const springai::AIFloat3& point);
    int GetBomberCount() const;
    int GetTargetsDestroyed() const { return targetsDestroyed; }
    float GetDamageDealt() const { return operationDamage; }
    int GetRequiredBombers() const { return requiredBombers; }
	int GetState() const { return int(state_); }
	int GetMode() const { return int(mode); }
	const springai::AIFloat3& GetAim() const { return aim; }
	int GetStrikeTargetId() const { return strikeTargetId; }
	float GetBearingDeg() const { return usedBearingDeg; }
	int GetFormedCount() const { return formedCount; }

private:
    void UpdateOperation();
    void IssueOperationLeg();
    bool NextOperationTarget();
    bool IsOperationBomber(CCircuitUnit* unit) const;
    springai::AIFloat3 OperationCentre() const;
	void EnterState(EState next);
	void ComputeLines();
	float PickSmartBearingDeg(const springai::AIFloat3& baseDir) const;
	int GroupOf(int slot) const { return (groups <= 1) ? 0 : (slot % 2); }
	int LaneOf(int slot) const;
	springai::AIFloat3 SlotPos(CCircuitUnit* unit) const;
	springai::AIFloat3 EndPos(CCircuitUnit* unit) const;
	void IssueForm(CCircuitUnit* unit);
	void IssueAttack(CCircuitUnit* unit);
	bool IsPastAim(CCircuitUnit* unit, int frame) const;
    float RouteExposure(const springai::AIFloat3& from, const springai::AIFloat3& to) const;
    void ReturnHome(const char* reason);
    bool AdvanceReturn(CCircuitUnit* unit, int frame, bool force = false);
    float StrikeAlpha(CCircuitDef* bomber);
    std::vector<springai::AIFloat3> PlanIngress(const springai::AIFloat3& from, const springai::AIFloat3& target, float& risk) const;
    float RouteLength(const springai::AIFloat3& from, const springai::AIFloat3& target) const;
	CEnemyInfo* GetStrikeTarget() const;

	EMode mode;
	EState state_;
	springai::AIFloat3 aim;
	float formDistance;
	float spacing;
	float overrun;
	int formTimeout;
	int holdFrames;
	float bearingDeg;
	float usedBearingDeg;
	int groups;
	std::vector<springai::AIFloat3> groupDir;     // direction of travel per group
	std::vector<springai::AIFloat3> groupCentre;  // middle of each group's line
	std::map<CCircuitUnit*, int> slots;           // unit -> slot index
	int dealt;
	int stateFrame;
	int strikeTargetId;
	int formedCount;
	bool linesReady;
    bool safeFlight = false;
    float maxWidth = 1320.f;
    float rankSpacing = 240.f;
    float abortFraction = .35f;
    float damageBudget = 0.f;
    float passDamage = 0.f;
    int requiredBombers = 0;
    float damageMargin = 1.f;
    float threatWeight = 0.f;
    float maxThreat = 0.f;
    int launchCount = 0;
    int expectedCount = 0;
    int joinFrames = 0;
    int assemblyTravelFrames = 0;
    float assemblyRadius = WAVE_DEFAULT_ASSEMBLY_RADIUS;
    float assemblyFraction = .8f;
    float passFraction = 0.f;
    static constexpr float WAVE_DEFAULT_ASSEMBLY_RADIUS = 400.f;
    springai::AIFloat3 returnPos;
    std::map<CCircuitUnit*, int> releasedAt;
    std::set<CCircuitUnit*> outbound;
    std::set<CCircuitUnit*> assembled;
    std::map<int, float> strikeAlpha;
    bool missionPolicy = false;
    bool synchronize = false;
    bool staticAssault = false;
    float corridorPadding = 0.f;
    float edgeInset = 480.f;
    float unknownReserve = 0.f;
    float riskScale = 0.f;
    float armyReserve = 0.f;
    float localAAReserve = 0.f;
    float bomberMetal = 1.f;
    std::vector<std::pair<springai::AIFloat3, float>> excludedStrikeRegions;
    std::vector<springai::AIFloat3> ingress;
    std::set<CCircuitUnit*> routed;
    std::map<CCircuitUnit*, int> attackAt;
    std::set<CCircuitUnit*> attackIssued;
    std::map<CCircuitUnit*, std::vector<springai::AIFloat3>> returnRoutes;
    std::map<CCircuitUnit*, size_t> returnSteps;
    int returnFrames = 0;
    bool operationPolicy = false;
    bool offensive = false;
    bool committed = false;
    int operationPreference = 5;
    int operationPhase = 0;
    int operationLeg = 0;
    int operationIssuedFrame = -1;
    int operationScanFrame = -100000;
    int targetsDestroyed = 0;
    float operationDamage = 0.f;
    float operationTargetHealth = 0.f;
    float escortLead = 480.f;
    float routeCeiling = 500.f;
    float localRadius = 1600.f;
    springai::AIFloat3 assemblyPos;
    std::map<int, float> allowedStrikeDefs;
    std::set<int> operationBomberDefs;
    std::vector<springai::AIFloat3> operationRoute;
    std::set<int> completedTargets;
    std::set<CCircuitUnit*> operationIdle;
    std::map<CCircuitUnit*, springai::AIFloat3> operationDestinations;
    std::set<CCircuitUnit*> operationArrived;
    std::vector<springai::AIFloat3> searchPoints;
    unsigned int searchIndex = 0;
    void PrepareOperationRoute();
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_AIRWAVETASK_H_
