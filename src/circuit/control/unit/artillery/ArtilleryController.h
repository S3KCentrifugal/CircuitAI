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
	// Keep-open pulse (owner 2026-11-18, Esker): a pop-up gun whose close sinks
	// its muzzle below ground (Eviscerator) can never reopen: the engine finds no
	// line of fire from the buried muzzle, so it never aims, and only an aim opens
	// it. After keep_open_seconds without a shot or an aim of ours, a short
	// attack-ground order (keep_open_order_seconds, turned keep_open_turn degrees
	// off the facing, alternating sides) starts an aim, which restarts the gun's
	// 10 s close timer; it usually expires before the turret finishes turning.
	float keepOpenSeconds = 0.f;       // 0: off
	float keepOpenOrderSeconds = 1.f;
	float keepOpenTurn = 70.f;         // degrees off the building facing
	float keepOpenReach = .6f;         // share of the gun's range for the pulse point
};

namespace control {
struct ArtilleryState : ControlledState {
	int next = 0;           // next decision frame
	int target = -1;        // aimed enemy id, -1 engine targeting
	int kind = 0;           // artillery::Kind of the aim
	int issued = 0;         // frame of the last order
	int closedUntil = 0;    // pop-up: no structure aim before this frame
	int reload = -1;        // last sampled main-weapon reload frame
	int shot = -1;          // frame a shot was last seen (rising reload frame)
	int pulse = -1;         // frame of the last keep-open pulse
	int side = 1;           // the next pulse's side of the facing
	int pulses = 0;
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
	void KeepOpen(CCircuitUnit* unit, control::ArtilleryState& s, int frame);
	artillery::DefFacts Facts(const CCircuitDef* def) const;

	CCircuitAI* ai;
	std::vector<artillery::Contact> scratch;  // reused per decision
	std::vector<springai::AIFloat3> scratchPos;
	std::vector<char> scratchMobile;
};

} // namespace circuit
