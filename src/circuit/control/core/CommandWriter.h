#pragma once
// D-388: the single writer of a controlled unit's cloak, fire and move states.
// Every such order for a unit its controller owns goes through here; tasks and
// other modules that used to set them for commanders (retreat, the controlled
// task's restore) now ask the owning controller instead. That makes the
// KI-689 class of defect (two owners toggling cloak) unwriteable.
//
// Two ways to compare before sending a cloak order:
//  - Cloak(): reads BAR's own request flag (`wantcloak`, one rules-param read),
//    so a request changed by anyone else is corrected, never trusted. Used by
//    the once-a-second posture sync.
//  - CloakFrom(): the caller passes what it last requested (a state field), as
//    the engagement code always did. No engine read; used every combat tick.
// Fire and move states use CCircuitUnit's requested-state cache, as before.

#include <unordered_map>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;

class CCommandWriter {
public:
	CCommandWriter(CCircuitAI* ai, const char* owner) : ai(ai), owner(owner) {}

	bool Cloak(CCircuitUnit* unit, bool want, const char* reason);
	bool CloakFrom(CCircuitUnit* unit, bool want, bool current, const char* reason);
	bool FireState(CCircuitUnit* unit, int state, const char* reason);
	bool MoveState(CCircuitUnit* unit, int state, const char* reason);

	// The last cloak order this writer sent for a unit, and its frame (INV-246).
	struct Sent { bool cloak = false; int frame = -1; };
	const Sent* LastSent(int unitId) const {
		const auto it = sent.find(unitId);
		return it == sent.end() ? nullptr : &it->second;
	}
	void Forget(int unitId) { sent.erase(unitId); }
	int CloakOrders() const { return cloakOrders; }
	void SetTrace(bool value) { trace = value; }

private:
	bool Send(CCircuitUnit* unit, bool want, const char* reason);
	CCircuitAI* ai;
	const char* owner;
	std::unordered_map<int, Sent> sent;
	int cloakOrders = 0;
	bool trace = false;
};

} // namespace circuit
