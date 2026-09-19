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

#include <map>
#include <vector>

namespace circuit {

class CRouteTask final: public IFighterTask {
public:
	CRouteTask(ITaskModule* mgr);
	virtual ~CRouteTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

	// Script hooks
	void SetRoute(std::vector<springai::AIFloat3>&& waypoints);
	/*
	 * Per-unit lane spread. The route is one line; each unit assigned to the
	 * task is dealt a lane - 0, +1, -1, +2, -2 ... - and follows the line
	 * offset sideways by `spacing` per lane, so a stream of spam units crosses
	 * the map as a band rather than a single file that one shell erases and
	 * that sees only what one unit sees. `endSpread` scales the offset at the
	 * last waypoint (0 = every lane converges on the same endpoint, 1 = the
	 * band stays full width to the end); the point of the run is the same
	 * backline, so this is kept small. `count` 1 disables the spread.
	 */
	void SetLanes(int count, float spacing, float endSpread);
	int GetRouteVersion() const { return version; }
	unsigned int GetRouteSize() const { return route.size(); }
	bool IsAtEnd(CCircuitUnit* unit) const;

private:
	void IssueRoute(CCircuitUnit* unit, unsigned int fromIdx);
	// One move straight to the end of the route, lane waypoints skipped.
	void IssueDirect(CCircuitUnit* unit);
	unsigned int NearestAheadIndex(CCircuitUnit* unit) const;
	// The route point `idx` as seen from `unit`'s lane.
	springai::AIFloat3 LanePoint(CCircuitUnit* unit, unsigned int idx) const;
	int LaneOf(CCircuitUnit* unit) const;

	std::vector<springai::AIFloat3> route;
	std::map<CCircuitUnit*, int> lanes;   // unit -> signed lane index
	int laneCount;
	float laneSpacing;
	float laneEndSpread;
	unsigned int laneDealt;               // round-robin counter
	int version;
	bool dirty;
	float arriveRadius;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_ROUTETASK_H_
