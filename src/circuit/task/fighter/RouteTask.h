/*
 * RouteTask.h
 *
 * A fighter task that owns a waypoint route and issues only move orders.
 * Script (Spam:: in data/script/src/manager/spam.as) creates one per factory
 * with TaskF::Route(), sets the route with SetRoute() and assigns every unit
 * that factory produces. Units follow the queued waypoints, hold at the end,
 * never retreat, and are re-issued the route whenever it changes.
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_ROUTETASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_ROUTETASK_H_

#include "task/fighter/FighterTask.h"

#include <vector>

namespace circuit {

class CRouteTask final: public IFighterTask {
public:
	CRouteTask(ITaskModule* mgr);
	virtual ~CRouteTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

	// Script hooks
	void SetRoute(std::vector<springai::AIFloat3>&& waypoints);
	int GetRouteVersion() const { return version; }
	unsigned int GetRouteSize() const { return route.size(); }
	bool IsAtEnd(CCircuitUnit* unit) const;

private:
	void IssueRoute(CCircuitUnit* unit, unsigned int fromIdx);
	// One move straight to the end of the route, lane waypoints skipped.
	void IssueDirect(CCircuitUnit* unit);
	unsigned int NearestAheadIndex(CCircuitUnit* unit) const;

	std::vector<springai::AIFloat3> route;
	int version;
	bool dirty;
	float arriveRadius;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_ROUTETASK_H_
