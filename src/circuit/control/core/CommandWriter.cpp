#include "control/core/CommandWriter.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {

namespace {
constexpr const char* WANT_CLOAK_PARAM = "wantcloak";  // BAR unit_cloak.lua request flag
}

bool CCommandWriter::Send(CCircuitUnit* unit, bool want, const char* reason) {
	TRY_UNIT(ai, unit, unit->CmdCloak(want);)
	sent[unit->GetId()] = {want, ai->GetLastFrame()};
	++cloakOrders;
	if (trace) ai->LOG("[%s] unit=%i cloak=%i reason=%s", owner, unit->GetId(), want ? 1 : 0, reason);
	return true;
}

bool CCommandWriter::Cloak(CCircuitUnit* unit, bool want, const char* reason) {
	if (unit == nullptr || !unit->GetCircuitDef()->IsAbleToCloak()) return false;
	const bool current = unit->GetUnit()->GetRulesParamFloat(WANT_CLOAK_PARAM, 0.f) > 0.f;
	return current != want && Send(unit, want, reason);
}

bool CCommandWriter::CloakFrom(CCircuitUnit* unit, bool want, bool current, const char* reason) {
	if (unit == nullptr || current == want) return false;
	return Send(unit, want, reason);
}

bool CCommandWriter::FireState(CCircuitUnit* unit, int state, const char* reason) {
	if (unit == nullptr || unit->GetRequestedFireState() == state) return false;
	unit->TrySetFireState(static_cast<CCircuitDef::FireT>(state));
	if (trace) ai->LOG("[%s] unit=%i fire=%i reason=%s", owner, unit->GetId(), state, reason);
	return true;
}

bool CCommandWriter::MoveState(CCircuitUnit* unit, int state, const char* reason) {
	if (unit == nullptr || unit->GetRequestedMoveState() == state) return false;
	unit->TrySetMoveState(static_cast<CCircuitDef::MoveT>(state));
	if (trace) ai->LOG("[%s] unit=%i move_state=%i reason=%s", owner, unit->GetId(), state, reason);
	return true;
}

} // namespace circuit
