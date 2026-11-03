/*
 * CaptureAction.h
 *
 *  Created on: Oct 31, 2021
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_UNIT_ACTION_CAPTUREACTION_H_
#define SRC_CIRCUIT_UNIT_ACTION_CAPTUREACTION_H_

#include "unit/action/UnitAction.h"

namespace springai {
	class Unit;
}

namespace circuit {

class CCaptureAction final: public IUnitAction {
public:
	CCaptureAction(CCircuitUnit* owner, float range);
	virtual ~CCaptureAction();

	virtual void Update(CCircuitAI* circuit) override;

private:
	// Owner 2026-11-03: enemy dragon's teeth / walls are reclaimed, not
	// captured. The reclaim is an order on the target id; a neutral (objectified)
	// wall and an enemy unit share the engine id space.
	bool ReclaimWall(CCircuitAI* circuit, CCircuitUnit* unit, springai::Unit* wall, int wallId);

	float range;
	unsigned int updCount;
	int lastWallId = -1;  // the last wall a reclaim was ordered for
	int lastWallOrder = -1000000;
};

} // namespace circuit

#endif // SRC_CIRCUIT_UNIT_ACTION_CAPTUREACTION_H_
