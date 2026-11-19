/*
 * ArtilleryController.cpp
 *
 * D-493 (refactor of D-492): static artillery fire control. See the header.
 */

#include "control/unit/artillery/ArtilleryController.h"
#include "control/core/Ownership.h"
#include "control/service/CombatSnapshot.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyTeam.h"
#include "unit/enemy/EnemyUnit.h"
#include "spring/SpringUnit.h"
#include "CircuitAI.h"
#include "AISCommands.h"
#include "util/Utils.h"
#include "util/Performance.h"
#include "Log.h"

#include <algorithm>
#include <cmath>

namespace circuit {
using springai::AIFloat3;
using artillery::Kind;

namespace {
using Field = control::ConfigField<ArtilleryConfig>;
template <auto M> Field Lever(const char* name, float low, float high)
{
	return {name, [](ArtilleryConfig& c) -> float& { return c.*M; }, low, high};
}
using AC = ArtilleryConfig;
const control::CConfigTable<ArtilleryConfig>& ArtilleryTable()
{
	static const control::CConfigTable<ArtilleryConfig> table({
		Lever<&AC::enabled>("enabled", 0, 1),
		Lever<&AC::aimPeriod>("aim_period", .25f, 10),
		Lever<&AC::reissueSeconds>("reissue_seconds", 1, 120),
		Lever<&AC::orderSeconds>("order_seconds", 5, 600),
		Lever<&AC::heavyCost>("heavy_cost", 0, 100000),
		Lever<&AC::heavyShare>("heavy_share", 0, 1),
		Lever<&AC::closeUnderFire>("close_under_fire", 0, 1),
		Lever<&AC::closeSeconds>("close_seconds", 0, 60),
		Lever<&AC::hitSeconds>("hit_seconds", .1f, 10),
		Lever<&AC::log>("log", 0, 1),
	});
	return table;
}
const char* KindName(Kind kind)
{
	return kind == Kind::Support ? "support" : kind == Kind::Heavy ? "heavy" : kind == Kind::Static ? "static" : "none";
}
}

CArtilleryController::CArtilleryController(CCircuitAI* ai)
	: CUnitControllerBase<ArtilleryConfig, control::ArtilleryState>(ArtilleryTable()), ai(ai)
{
}

void CArtilleryController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	auto& s = states.Attach(unit->GetId());
	s.preset = preset;
	// Spread the guns over the period: the first decision a fraction of a period away.
	Bind bound(this, preset);
	const int period = std::max(1, int(cfg->aimPeriod * FRAMES_PER_SEC));
	s.next = ai->GetLastFrame() + unit->GetId() % period;
}

void CArtilleryController::Detach(int unitId)
{
	states.Detach(unitId);
}

// A static gun has no task, so "no task" is not a suspension here; a player
// order, Lua control, a stun or the frame still being built are.
bool CArtilleryController::Owns(CCircuitUnit* unit) const
{
	if (unit == nullptr || unit->IsDead() || !states.Contains(unit->GetId())) return false;
	const auto suspension = control::SuspensionOf(unit, ai->GetLastFrame());
	return suspension == control::Suspension::NONE || suspension == control::Suspension::NO_TASK;
}

void CArtilleryController::OnPresetAssigned(int defId, int preset)
{
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit != nullptr && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}

artillery::DefFacts CArtilleryController::Facts(const CCircuitDef* def) const
{
	artillery::DefFacts d;
	d.mobile = def->IsMobile();
	d.assist = def->IsAbleToAssist();
	d.buildOptions = !def->GetBuildOptions().empty();
	d.resurrect = def->IsAbleToResurrect();
	d.heavyRole = def->IsRoleHeavy();
	d.costM = def->GetCostM();
	d.range = def->GetMaxRange();
	return d;
}

void CArtilleryController::Update()
{
	if (states.Empty()) return;
	const int frame = ai->GetLastFrame();
	ai->GetAllyTeam()->GetCombatSnapshot().Want(frame);  // keep the side's snapshot built
	performance::Scope measured(ai, performance::ARTILLERY_UPDATE);
	for (auto& entry : states) {
		auto& s = *entry.value;
		if (frame < s.next) continue;
		Bind bound(this, s.preset);
		s.next = frame + std::max(1, int(cfg->aimPeriod * FRAMES_PER_SEC));
		CCircuitUnit* unit = ai->GetTeamUnit(entry.id);
		if (unit == nullptr || cfg->enabled <= 0.f || !Owns(unit) || !unit->IsFinished()) continue;
		Decide(unit, s, frame);
	}
}

/*
 * One gun's decision: the snapshot buckets within its range (O(contacts near
 * the gun)), classified and ranked by the kernel. INV-265 checks every aim
 * change against the kernel's own rule, so a wiring regression is seen.
 */
void CArtilleryController::Decide(CCircuitUnit* unit, control::ArtilleryState& s, int frame)
{
	performance::Scope measured(ai, performance::ARTILLERY_QUERY);
	const auto& snapshot = ai->GetAllyTeam()->GetCombatSnapshot();
	const AIFloat3 at = unit->GetPos(frame);
	const float range = unit->GetCircuitDef()->GetMaxRange();
	const float rangeSq = range * range;
	const bool popup = cfg->closeUnderFire > 0.f;
	scratch.clear(); scratchPos.clear(); scratchMobile.clear();
	bool threatInReach = false, threatOutOfReach = false;
	snapshot.Query({at.x, at.z}, std::max(range, popup ? range * 2.f : range), [&](const CCombatSnapshot::Entry& e) {
		const float dx = e.pos.x - at.x, dz = e.pos.z - at.z;
		const float distSq = dx * dx + dz * dz;
		// Who can hit this gun (pop-up rule): within its own published range of us.
		if (popup && distSq <= e.landRange * e.landRange) (distSq <= rangeSq ? threatInReach : threatOutOfReach) = true;
		if (distSq > rangeSq || e.defId < 0) return;
		const CCircuitDef* def = ai->GetCircuitDefSafe(e.defId);
		if (def == nullptr) return;
		const artillery::DefFacts facts = Facts(def);
		if (facts.mobile && !(e.los || e.radar)) return;  // a remembered mobile position is stale
		const artillery::Contact c{e.id, artillery::Classify(facts, cfg->heavyCost), facts.range, distSq};
		if (!artillery::InReach(c, range, cfg->heavyShare)) return;
		scratch.push_back(c);
		scratchPos.push_back(AIFloat3(e.pos.x, e.elevation, e.pos.z));
		scratchMobile.push_back(facts.mobile ? 1 : 0);
	});

	// Pop-up guns: under fire from something they cannot answer, a structure
	// aim is dropped and the gun closes (armoured) for close_seconds.
	const bool hit = unit->GetDamagedFrame() >= 0 && frame - unit->GetDamagedFrame() <= int(cfg->hitSeconds * FRAMES_PER_SEC);
	if (popup && hit && threatOutOfReach && artillery::CloseUnderFire(Kind(s.kind), threatInReach)) {
		if (frame >= s.closedUntil) {
			s.closedUntil = frame + int(cfg->closeSeconds * FRAMES_PER_SEC);
			if (s.target >= 0) Release(unit, s, "under fire it cannot answer: closes");
			else if (cfg->log > 0.f) ai->LOG("[Artillery] close unit=%i: under fire it cannot answer", unit->GetId());
		}
	}
	const bool closed = popup && frame < s.closedUntil;
	if (closed) {  // only what keeps a gun open: support and heavy
		for (std::size_t i = 0; i < scratch.size();) {
			if (int(scratch[i].kind) <= int(Kind::Static)) {
				scratch.erase(scratch.begin() + i); scratchPos.erase(scratchPos.begin() + i); scratchMobile.erase(scratchMobile.begin() + i);
			} else ++i;
		}
	}

	const int chosen = artillery::Choose(s.target, scratch);
	if (chosen < 0) {
		if (s.target >= 0) Release(unit, s, "none in reach: engine targeting");
		return;
	}
	const auto& c = scratch[chosen];
	if (c.id != s.target && s.target >= 0) {
		const bool previousInReach = std::any_of(scratch.begin(), scratch.end(),
			[&](const artillery::Contact& x) { return x.id == s.target; });
		if (!artillery::AimChangeAllowed(previousInReach, Kind(s.kind), c.kind))
			ai->LOG("[INVARIANT] INV-265 artillery %i left target %i (%s) in reach for %i (%s)", unit->GetId(),
				s.target, KindName(Kind(s.kind)), c.id, KindName(c.kind));
	}
	Order(unit, s, c.id, c.kind, scratchPos[chosen], scratchMobile[chosen] != 0, frame);
}

void CArtilleryController::Order(CCircuitUnit* unit, control::ArtilleryState& s, int targetId, Kind kind,
	const AIFloat3& pos, bool mobile, int frame)
{
	if (targetId == s.target && frame < s.issued + int(cfg->reissueSeconds * FRAMES_PER_SEC)) return;
	const int timeout = frame + int(cfg->orderSeconds * FRAMES_PER_SEC);
	CEnemyInfo* enemy = ai->GetEnemyInfo(targetId);
	// A structure by its location (ghosts included); a mobile unit by unit while seen.
	if (mobile && enemy != nullptr && enemy->IsInRadarOrLOS()) {
		TRY_UNIT(ai, unit, unit->GetUnit()->Attack(enemy->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);)
	} else {
		TRY_UNIT(ai, unit, unit->CmdAttackGround(pos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);)
	}
	if (targetId != s.target && cfg->log > 0.f) {
		const CCircuitDef* def = enemy != nullptr ? enemy->GetCircuitDef() : nullptr;
		ai->LOG("[Artillery] aim unit=%i target=%i def=%s kind=%s at=%.0f,%.0f preset=%s", unit->GetId(), targetId,
			def != nullptr ? def->GetDef()->GetName() : "?", KindName(kind), pos.x, pos.z, PresetName(s.preset).c_str());
	}
	s.target = targetId; s.kind = int(kind); s.issued = frame;
}

void CArtilleryController::Release(CCircuitUnit* unit, control::ArtilleryState& s, const char* why)
{
	TRY_UNIT(ai, unit, unit->CmdStop();)
	if (cfg->log > 0.f) ai->LOG("[Artillery] release unit=%i target=%i: %s", unit->GetId(), s.target, why);
	s.target = -1; s.kind = 0; s.issued = 0;
}

int CArtilleryController::CountNear(const AIFloat3& site, float radius) const
{
	const int frame = ai->GetLastFrame();
	int count = 0;
	for (const auto& entry : states) {
		// Finished guns only: a frame being built is the caller's job in flight.
		CCircuitUnit* unit = ai->GetTeamUnit(entry.id);
		if (unit != nullptr && !unit->IsDead() && unit->IsFinished() && unit->GetPos(frame).SqDistance2D(site) <= radius * radius) ++count;
	}
	return count;
}

int CArtilleryController::EnemyStaticsNear(const AIFloat3& site, float radius) const
{
	int count = 0;
	ai->GetAllyTeam()->GetCombatSnapshot().Query({site.x, site.z}, radius, [&](const CCombatSnapshot::Entry& e) {
		const float dx = e.pos.x - site.x, dz = e.pos.z - site.z;
		if (dx * dx + dz * dz > radius * radius || e.defId < 0) return;
		const CCircuitDef* def = ai->GetCircuitDefSafe(e.defId);
		if (def != nullptr && !def->IsMobile()) ++count;
	});
	return count;
}

} // namespace circuit
