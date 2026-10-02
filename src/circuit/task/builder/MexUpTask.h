/*
 * MexUpTask.h
 *
 *  Created on: Jun 21, 2021
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_BUILDER_MEXUPTASK_H_
#define SRC_CIRCUIT_TASK_BUILDER_MEXUPTASK_H_

#include "task/builder/BuilderTask.h"
#include "resource/MetalField.h"

namespace circuit {

class CBMexUpTask final: public IBuilderTask {
public:
	CBMexUpTask(ITaskModule* mgr, Priority priority,
				CCircuitDef* buildDef, int spotId, const springai::AIFloat3& position,
				SResource cost, int timeout);
	CBMexUpTask(ITaskModule* mgr);  // Load
	virtual ~CBMexUpTask();
	bool HasFieldClaim() const { return fieldKey != 0; }
	virtual void Stop(bool done) override;

protected:
	virtual void Finish() override;
	virtual void Cancel() override;

	virtual bool Execute(CCircuitUnit* unit) override;

public:
	virtual void OnUnitIdle(CCircuitUnit* unit) override;

private:
	virtual void FindBuildSite(CCircuitUnit* builder, const springai::AIFloat3& pos, float searchRadius) override;

	virtual bool Load(std::istream& is) override;
	virtual void Save(std::ostream& os) const override;

	int spotId;
	metal_field::Key fieldKey = 0;
	int fieldTargetId = -1;
	CCircuitUnit* reclaimMex;  // NOTE: never use it as unit, it's a mark (void*)
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_BUILDER_MEXUPTASK_H_
