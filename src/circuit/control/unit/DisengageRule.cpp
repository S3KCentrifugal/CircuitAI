#include "control/unit/DisengageRule.h"
#include "control/kernel/Disengage.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/MilitaryManager.h"
#include "task/RetreatTask.h"
#include "task/fighter/RangedEngagement.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "unit/RangedPolicy.h"
#include "util/Defines.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Unit.h"
#include "Log.h"

namespace circuit::disengage_rule {

namespace {
// A hazard recorded by a cohort decision this many frames ago still counts.
constexpr int DANGER_MEMORY_FRAMES = 2 * FRAMES_PER_SEC;
}

bool Apply(CCircuitAI* ai, CCircuitUnit* unit, const CRangedEngagement& engagement, const RangedPolicy& policy,
           Memory& memory, int frame, const char* tag)
{
	CCircuitDef* cdef = unit->GetCircuitDef();
	auto* military = ai->GetMilitaryManager();
	// The legacy floor (behaviour.json "retreat"), unchanged and beneath the rule.
	if (unit->GetHealthPercent() <= cdef->GetRetreat()) {
		military->AssignTask(unit, military->EnqueueRetreat());
		return true;
	}
	const float health = unit->GetHealthPercent();
	if (policy.retreatHealth > 0.f) {
		// One engine read per unit per second at most, on damage events only.
		if (memory.experienceFrame < 0 || frame >= memory.experienceFrame + FRAMES_PER_SEC) {
			memory.experience = unit->GetUnit()->GetExperience();
			memory.experienceFrame = frame;
		}
		const auto& danger = engagement.LastDanger();
		const bool fresh = danger.present && frame - danger.frame <= DANGER_MEMORY_FRAMES;
		const bool canEscape = disengage::CanEscape(fresh, danger.mobile, danger.speed, danger.range,
			cdef->GetSpeed(), engagement.MaxRange(), policy.reactionSeconds);
		if (disengage::ShouldRetreat(health, memory.experience, canEscape, policy.retreatHealth, policy.retreatVeteranBonus)) {
			ai->LOG("%s: retreat unit=%i health=%.2f experience=%.2f escape=%i frame=%i",
				tag, unit->GetId(), health, memory.experience, int(canEscape), frame);
			military->AssignTask(unit, military->EnqueueRetreat());
			return true;
		}
	}
	unit->ForceUpdate(frame + THREAT_UPDATE_RATE);
	if (!unit->IsDisarmed(frame)) {
		bool repair = cdef->IsRoleHeavy() && health < 0.9f;
		if (!repair && disengage::WantsRepair(health, policy.repairHealth, frame, memory.lastRepairFrame,
				int(policy.repairCooldownSeconds * FRAMES_PER_SEC))) {
			// A builder within repair_radius: one bounded scan of the worker
			// set, at most once per cooldown per unit, only under repair_health.
			const springai::AIFloat3 pos = unit->GetPos(frame);
			const float radiusSq = policy.repairRadius * policy.repairRadius;
			for (CCircuitUnit* worker : ai->GetBuilderManager()->GetWorkers()) {
				if (worker == nullptr || worker->IsDead() || worker == unit) continue;
				if (worker->GetPos(frame).SqDistance2D(pos) <= radiusSq) { repair = true; break; }
			}
			if (repair) {
				memory.lastRepairFrame = frame;
				ai->LOG("%s: repair unit=%i health=%.2f frame=%i", tag, unit->GetId(), health, frame);
			}
		}
		if (repair && !unit->IsAttrNoRepair()) {
			ai->GetBuilderManager()->Enqueue(TaskB::Repair(IBuilderTask::Priority::NOW, unit));
		}
		if (health < cdef->GetSelfDHP()) {
			TRY_UNIT(ai, unit, unit->CmdSelfD(true);)
		}
	}
	return false;
}

} // namespace circuit::disengage_rule
