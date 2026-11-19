#pragma once
// D-493 (refactor of D-492): the artillery controller. One per AI, controlling
// every static artillery turret of ours whose type behaviour.json binds to an
// artillery preset ("controller": "artillery_battery" | "artillery_popup" |
// "artillery_fortified"). The registry attaches each unit when it is added,
// built by anyone, given by an ally or restored after a load.
//
// Once per aim_period per gun (staggered by id), it reads the side's combat
// snapshot (shared by allies, rebuilt once a second) around the gun and asks
// the kernel (control/kernel/ArtilleryTargeting.h) what to fire at. Orders only
// on a change or every reissue_seconds. Design: d489-d492-refactor-proposal.md.

#include "control/core/UnitController.h"
#include "control/kernel/ArtilleryTargeting.h"
#include "AIFloat3.h"

namespace circuit {

class CCircuitAI;
class CCircuitDef;

// What the commander group's tactical queue may ask about our artillery
// (crowding): a count of finished guns, and of known enemy structures, near a site.
class IArtilleryCensus {
public:
	virtual ~IArtilleryCensus() = default;
	virtual int CountNear(const springai::AIFloat3& site, float radius) const = 0;
	virtual int EnemyStaticsNear(const springai::AIFloat3& site, float radius) const = 0;
};

struct ArtilleryConfig {
	float enabled = 1.f;          // 0: the controller orders nothing
	float aimPeriod = 1.f;        // seconds between a gun's decisions
	float reissueSeconds = 15.f;  // an unchanged aim is ordered again after this
	float orderSeconds = 60.f;    // an attack order's engine timeout
	float heavyCost = 0.f;        // a mobile enemy at this metal cost is heavy (0: the heavy role only)
	float heavyShare = .5f;       // heavies count within this share of the gun's range
	float closeUnderFire = 0.f;   // pop-up guns: drop a structure aim under fire it cannot answer
	float closeSeconds = 6.f;     // ... and stay closed this long
	float hitSeconds = 2.f;       // "under fire": hit within this many seconds
	float log = 1.f;              // aim, release and close lines
};

namespace control {
struct ArtilleryState : ControlledState {
	int next = 0;           // next decision frame
	int target = -1;        // aimed enemy id, -1 engine targeting
	int kind = 0;           // artillery::Kind of the aim
	int issued = 0;         // frame of the last order
	int closedUntil = 0;    // pop-up: no structure aim before this frame
};
}

class CArtilleryController final
	: public CUnitControllerBase<ArtilleryConfig, control::ArtilleryState>
	, public IArtilleryCensus {
public:
	explicit CArtilleryController(CCircuitAI* ai);
	const char* Name() const override { return "artillery"; }

	void Attach(CCircuitUnit* unit) override;
	void Detach(int unitId) override;
	bool Owns(CCircuitUnit* unit) const override;
	void Update() override;
	void RestoreAfterLease(CCircuitUnit*, int, int) override {}

	int CountNear(const springai::AIFloat3& site, float radius) const override;
	int EnemyStaticsNear(const springai::AIFloat3& site, float radius) const override;

protected:
	void OnPresetAssigned(int defId, int preset) override;

private:
	void Decide(CCircuitUnit* unit, control::ArtilleryState& s, int frame);
	void Order(CCircuitUnit* unit, control::ArtilleryState& s, int targetId, artillery::Kind kind,
		const springai::AIFloat3& pos, bool mobile, int frame);
	void Release(CCircuitUnit* unit, control::ArtilleryState& s, const char* why);
	artillery::DefFacts Facts(const CCircuitDef* def) const;

	CCircuitAI* ai;
	std::vector<artillery::Contact> scratch;  // reused per decision
	std::vector<springai::AIFloat3> scratchPos;
	std::vector<char> scratchMobile;
};

} // namespace circuit
