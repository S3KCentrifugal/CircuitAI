#include "control/unit/escort/EscortController.h"
#include "control/core/LeaseTask.h"
#include "control/core/Ownership.h"
#include "control/group/BattleGroupController.h"
#include "module/MilitaryManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "util/Defines.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {

namespace {
using Field = control::ConfigField<EscortConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
	return {name, [](EscortConfig& c) -> float& { return c.*M; }, lo, hi};
}
// JSON keys of an "escort" preset and the aiControllers.SetOption levers.
const control::CConfigTable<EscortConfig> kTable({
	F<&EscortConfig::arrival>("arrival", 8.f, 512.f),
	F<&EscortConfig::moveSeconds>("move_seconds", 1.f, 120.f),
	F<&EscortConfig::fireAtWill>("fire_at_will", 0.f, 1.f),
	F<&EscortConfig::log>("log", 0.f, 1.f),
	F<&EscortConfig::releaseSeconds>("release_seconds", 0.f, 600.f),
});
constexpr int DECISION_SLICE = TEAM_SLOWUPDATE_RATE;
constexpr int FIRE_AT_WILL = 2;   // engine fire state: fire at will
}

CEscortController::CEscortController(CCircuitAI* ai)
	: CUnitControllerBase<EscortConfig, EscortState>(kTable), ai(ai), writer(ai, "Escort")
{
}
CEscortController::~CEscortController() = default;

void CEscortController::OnPresetAssigned(int defId, int preset)
{
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}

void CEscortController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	states.Attach(unit->GetId()).preset = preset;
}
void CEscortController::Detach(int unitId)
{
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->EscortLeave(unitId);
	writer.Forget(unitId);
	states.Detach(unitId);
}
bool CEscortController::Owns(CCircuitUnit* unit) const
{
	return unit && !unit->IsDead() && states.Contains(unit->GetId())
		&& control::SuspensionOf(unit, ai->GetLastFrame()) == control::Suspension::NONE;
}

IUnitTask* CEscortController::MakeLease(CCircuitUnit* unit)
{
	if (unit == nullptr || !Bound(unit->GetCircuitDef()->GetId())) return nullptr;
	const CBattleGroupController* groups = ai->GetBattleGroupController();
	if (groups == nullptr || !groups->HasAirGroups()) return nullptr;  // nowhere to ride: ordinary tasks
	Attach(unit);
	return ai->GetMilitaryManager()->EnqueueLease(this, nullptr);
}
void CEscortController::Leased(CCircuitUnit* unit, IUnitTask* task)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || task == nullptr) return;
	s->lease = task; s->hasSent = false; s->group = -1; s->alone = -1;
	Bind bound(this, s->preset);
	if (cfg->fireAtWill > 0.f) writer.FireState(unit, FIRE_AT_WILL, "escort");
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->EscortJoin(unit->GetId());
}
void CEscortController::RestoreAfterLease(CCircuitUnit* unit, int /*fireState*/, int /*moveState*/)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr) return;
	s->lease = nullptr; s->hasSent = false;
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->EscortLeave(unit->GetId());
	TRY_UNIT(ai, unit,
		writer.MoveState(unit, unit->GetCircuitDef()->GetMoveState(), "lease_end");
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "lease_end");
	)
}
// An order that ended or failed is sent again on the next decision.
void CEscortController::Idle(int unitId) { if (State* s = states.Find(unitId)) s->hasSent = false; }
void CEscortController::MoveFailed(int unitId) { if (State* s = states.Find(unitId)) s->hasSent = false; }

void CEscortController::Update()
{
	if (states.Empty()) return;
	performance::Scope measured(ai, performance::ESCORT_CONTROLLER);
	const int frame = ai->GetLastFrame();
	std::size_t budget = states.Size() / DECISION_SLICE + 1;
	if (cursor >= states.Size()) cursor = 0;
	std::size_t index = 0;
	for (auto& entry : states) {
		if (index++ < cursor) continue;
		if (budget-- == 0) break;
		++cursor;
		auto* unit = ai->GetTeamUnit(entry.id);
		if (!unit || unit->IsDead()) continue;
		Bind bound(this, entry.value->preset);
		Tick(unit, *entry.value, frame);
	}
}

void CEscortController::Tick(CCircuitUnit* unit, State& s, int frame)
{
	if (s.lease == nullptr || unit->GetTask() != s.lease) return;
	if (control::SuspensionOf(unit, frame) != control::Suspension::NONE) return;
	const CBattleGroupController* groups = ai->GetBattleGroupController();
	springai::AIFloat3 slot;
	int group = -1;
	if (groups == nullptr || !groups->EscortPoint(unit->GetId(), slot, group)) {
		// No group: stand; after release_seconds alone, back to ordinary tasks.
		if (s.alone < 0) s.alone = frame;
		else if (frame - s.alone >= int(cfg->releaseSeconds * FRAMES_PER_SEC)) {
			if (cfg->log > 0.f) ai->LOG("ESCORT: release unit=%i frame=%i", unit->GetId(), frame);
			static_cast<CLeaseTask*>(s.lease)->Handover(unit);
		}
		return;
	}
	s.alone = -1;
	const float arrival = cfg->arrival;
	if (s.hasSent && s.sent.SqDistance2D(slot) < arrival * arrival) return;
	if (unit->GetPos(frame).SqDistance2D(slot) < arrival * arrival) { s.sent = slot; s.hasSent = true; return; }
	CTerrainManager::CorrectPosition(slot);
	TRY_UNIT(ai, unit, unit->CmdMoveTo(slot, 0, frame + int(cfg->moveSeconds * FRAMES_PER_SEC));)
	if (cfg->log > 0.f && group != s.group)
		ai->LOG("ESCORT: unit=%i group=%i slot=%.0f,%.0f frame=%i", unit->GetId(), group, slot.x, slot.z, frame);
	s.sent = slot; s.hasSent = true; s.group = group;
}

} // namespace circuit
