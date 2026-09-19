/*
 * FerryTask.h
 *
 * Air transport ferry: carry one allied unit to a position and come home.
 *
 * A transport owns exactly one CFerryTask for its whole life. With no cargo
 * the task is a hold at `holdPos` - which is also what keeps a transport out
 * of the army, since ROLE_TYPE(TRANS) otherwise falls through to a Defend
 * task in CMilitaryManager::DefaultMakeTask. Script sets a cargo and a drop
 * position, the task sequences pick-up, flight and drop, and the transport
 * returns to `holdPos` on its own.
 *
 * Policy stays in script (Team::Ferry, data/script/src/manager/ferry.as):
 * which unit to carry, where to, and what to do once it lands. See
 * doc/transport-ferry.md.
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_FERRYTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_FERRYTASK_H_

#include "task/fighter/FighterTask.h"

namespace circuit {

class CFerryTask final: public IFighterTask {
public:
	/*
	 * DONE and FAILED are terminal and latched: script polls GetState(),
	 * acts once, and calls Reset() to return the transport to its hold.
	 * Nothing here retries by itself - a ferry that failed is a ferry whose
	 * caller should fall back to walking the unit.
	 */
	enum class EState: char {IDLE = 0, TO_CARGO, LOADING, TO_DROP, UNLOADING, DONE, FAILED};

	CFerryTask(ITaskModule* mgr);
	virtual ~CFerryTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;

	// Script hooks
	void SetHoldPos(const springai::AIFloat3& pos);
	// Begin a run. Fails (returns false, state unchanged) when a run is
	// already in flight or the cargo id is not one of our units.
	bool SetCargo(int cargoId, const springai::AIFloat3& dropPos);
	int GetState() const { return int(state_); }
	int GetCargoId() const { return cargoId; }
	// Back to IDLE and home. Safe to call in any state; the cargo is released.
	void Reset();

private:
	CCircuitUnit* GetTransport() const;
	CCircuitUnit* GetCargo() const;
	void GoTo(CCircuitUnit* unit, const springai::AIFloat3& pos);
	void Enter(EState next);
	bool IsExpired(int frame) const;
	void Fail(const char* why);

	EState state_;
	int cargoId;
	springai::AIFloat3 dropPos;
	springai::AIFloat3 holdPos;
	int stateFrame;    // frame the current state was entered
	int loadRetries;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_FERRYTASK_H_
