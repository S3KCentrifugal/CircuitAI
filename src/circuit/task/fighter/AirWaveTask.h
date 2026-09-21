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

class CAirWaveTask final: public IFighterTask {
public:
	// Numbers are the script's contract (Task::WaveMode in task.as).
	enum class EMode: char {CARPET = 0, FLANK, PINCER, STRIKE, DEEP, FEINT};
	// PLANNED until SetPlan; DONE is terminal and the task aborts itself.
	enum class EState: char {PLANNED = 0, FORMING, HOLDING, ATTACKING, DONE};
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
	int GetState() const { return int(state_); }
	int GetMode() const { return int(mode); }
	const springai::AIFloat3& GetAim() const { return aim; }
	int GetStrikeTargetId() const { return strikeTargetId; }
	float GetBearingDeg() const { return usedBearingDeg; }
	int GetFormedCount() const { return formedCount; }

private:
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
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_AIRWAVETASK_H_
