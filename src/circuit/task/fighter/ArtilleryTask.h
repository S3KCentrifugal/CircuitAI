/*
 * ArtilleryTask.h
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_

#include "task/fighter/FighterTask.h"

#include <unordered_map>

namespace circuit {
class CCircuitAI;
class CCircuitDef;
class CRangedEngagement;
class CEnemyInfo;

// Owner 2026-11-02: ghost porc fire (SArtyCommInfo::ghostDefs), shared by
// the native artillery task and specialist routes (FRONT squads). Last shot is
// read off the main weapon's reload frame, sampled on every call. True while
// a ghost volley order is issued or in flight (the caller leaves the unit be).
struct SGhostFire { int reload = -1, shot = -1, orderUntil = -1, target = -1, orderFrame = -1; bool counted = false; };  // target: the ghost being fired on
bool GhostFireStep(CCircuitAI* circuit, CCircuitUnit* unit, const springai::AIFloat3& pos, int frame,
		SGhostFire& track, std::unordered_map<int, bool>& ghostSupport, int volleyLimit = 0, bool allowFire = true);

// Owner 2026-11-03: sequenced snipe of outranging artillery structures
// (SArtySnipeInfo). True while it owns the unit; state lives in the military
// manager so a task change keeps the sequence.
bool MissileTargetAllowed(const CCircuitDef* launcher, const CEnemyInfo* enemy);
bool ArtyT1Exempt(const CCircuitDef* launcher, const CEnemyInfo* enemy);
// 2026-11-06: spam retreat (artillery_snipe spam_retreat*): Ambassador, Negotiator and
// Boreas hit by spam (T1/T2 mobiles, unknown attackers) back off; true while retreating.
void ArtySpamRetreatDamaged(CCircuitAI* circuit, CCircuitUnit* unit, CEnemyInfo* attacker);
bool ArtySpamRetreatStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame);
// The FRONT squad range micro target: dropped (logged) when it becomes identified T1.
void ArtyRangeTargetCheck(CCircuitAI* circuit, CCircuitUnit* unit, CEnemyInfo* nearest);
bool ArtySnipeStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame);
// Owner 2026-11-04: true while an artillery snipe sequence owns the unit (route
// tasks hold their orders for it, the squad keeps it).
bool ArtySnipeOwns(CCircuitAI* circuit, const CCircuitUnit* unit);
// Owner 2026-11-04 16:58Z: artillery target lock (native task and route range micro).
CEnemyInfo* ArtyLockGet(CCircuitAI* circuit, CCircuitUnit* unit, int frame, float& dist);
void ArtyLockSet(CCircuitAI* circuit, CCircuitUnit* unit, int frame, CEnemyInfo* e);
bool ArtyLockDrive(CCircuitAI* circuit, CCircuitUnit* unit, int frame, CEnemyInfo* e, float dist);
void ArtyLockHeld(CCircuitAI* circuit, CCircuitUnit* unit, int frame);
bool ArtyRadarDotStep(CCircuitAI* circuit, CCircuitUnit* unit, int frame, const springai::AIFloat3& pos);

class CArtilleryTask final: public IFighterTask {
public:
	CArtilleryTask(ITaskModule* mgr);
	virtual ~CArtilleryTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;
	virtual bool ForgetUnit(CCircuitUnit* unit) override;
	virtual void Stop(bool done) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitMoveFailed(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

private:
	std::unique_ptr<CRangedEngagement> ranged;
	void Execute(CCircuitUnit* unit);
	CEnemyInfo* FindTarget(CCircuitUnit* unit, const springai::AIFloat3& pos);
	void ApplyTargetPath(const CQueryPathMulti* query);
	void FallbackSafePos(CCircuitUnit* unit);
	void ApplySafePos(const CQueryPathMulti* query);
	void Fallback(CCircuitUnit* unit, bool proceed);
	std::unordered_map<int, SGhostFire> ghostFire;  // see GhostFireStep
	// Unit def id -> radar/jammer/shield structure (owner: counts as porc).
	std::unordered_map<int, bool> ghostSupport;
	bool FireAtGhost(CCircuitUnit* unit, const springai::AIFloat3& pos, int frame);
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_
