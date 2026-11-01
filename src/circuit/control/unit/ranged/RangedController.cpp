#include "control/unit/ranged/RangedController.h"
#include "control/core/ControlledTask.h"
#include "control/core/Ownership.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/MilitaryManager.h"
#include "task/RetreatTask.h"
#include "task/fighter/RangedEngagement.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "unit/RangedPolicyParse.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Game.h"
#include "Log.h"

#include <cstdlib>
#include <utility>

namespace circuit {

namespace {
using Field = control::ConfigField<RangedConfig>;

// The script-lever table is the parser's numeric key list, so JSON and
// aiControllers.SetOption agree on names and ranges. ConfigField wants a
// captureless accessor; one per table index, generated once.
template <std::size_t I>
float& Access(RangedConfig& c) { return ranged_policy::NumericKeys()[I].access(c.policy); }
template <std::size_t... I>
std::vector<Field> BuildFields(std::index_sequence<I...>) {
	const auto& keys = ranged_policy::NumericKeys();
	std::vector<Field> fields;
	((I < keys.size() ? (void)fields.push_back({keys[I].name, &Access<I>, keys[I].low, keys[I].high}) : (void)0), ...);
	return fields;
}
const control::CConfigTable<RangedConfig>& Table() {
	static const control::CConfigTable<RangedConfig> table(BuildFields(std::make_index_sequence<64>{}));
	return table;
}
constexpr int DECISION_SLICE = TEAM_SLOWUPDATE_RATE;  // the task module's own update stagger
}

CRangedController::CRangedController(CCircuitAI* ai)
	: CUnitControllerBase<RangedConfig, RangedState>(Table()), ai(ai), writer(ai, "Ranged")
	, trace(std::getenv("CIRCUIT_RANGED_TRACE") != nullptr)
{
	writer.SetTrace(trace);
}
CRangedController::~CRangedController() = default;

int CRangedController::ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems)
{
	// The shared parser, not the base's numeric table: a ranged preset also
	// carries target_mode, avoid_categories, spam_units and the formation
	// object, and keeps the legacy rule that an out-of-range value rejects
	// the block instead of clamping it.
	RangedConfig config = presets.front().config;
	const ranged_policy::Resolver resolver{
		[this](const std::string& unitName) { CCircuitDef* d = ai->GetCircuitDef(unitName.c_str()); return d ? d->GetId() : -1; },
		[this](const std::string& names) { return ai->GetGame()->GetCategoriesFlag(names.c_str()); }};
	if (!ranged_policy::Parse(resolved, config.policy, resolver, {"type"}, problems)) return -1;
	const int existing = PresetIndex(name);
	if (existing >= 0) { presets[existing].config = config; return existing; }
	presets.push_back({name, config});
	cfg = &presets.front().config;  // the vector may have moved
	return int(presets.size()) - 1;
}

void CRangedController::Publish(int defId, int preset)
{
	// The engagement, the cohort world and the retreat task keep reading the
	// policy from the unit type (one flyweight per type, as before): the
	// preset is the source and the type carries its copy.
	CCircuitDef* def = ai->GetCircuitDefSafe(defId);
	if (def == nullptr || preset < 0 || preset >= int(presets.size())) return;
	def->SetRangedPolicy(presets[preset].config.policy);
}
void CRangedController::BindDef(int defId, int preset)
{
	CUnitControllerBase::BindDef(defId, preset);
	Publish(defId, PresetForDef(defId));
}
void CRangedController::OnPresetAssigned(int defId, int preset)
{
	Publish(defId, preset);
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}
bool CRangedController::SetOption(const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetOption(name, value);
	if (accepted) for (const auto& [defId, preset] : presetByDef) Publish(defId, preset);
	return accepted;
}
bool CRangedController::SetPresetOption(const std::string& preset, const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetPresetOption(preset, name, value);
	if (accepted) {
		const int index = PresetIndex(preset);
		for (const auto& [defId, bound] : presetByDef) if (bound == index) Publish(defId, bound);
	}
	return accepted;
}

void CRangedController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	State& s = states.Attach(unit->GetId());
	s.preset = preset;
	if (trace) ai->LOG("[Ranged] attach unit=%i preset=%s", unit->GetId(), PresetName(preset).c_str());
}
void CRangedController::Detach(int unitId)
{
	if (State* s = states.Find(unitId)) CloseEngagement(nullptr, *s, false);
	writer.Forget(unitId);
	states.Detach(unitId);
}
bool CRangedController::Owns(CCircuitUnit* unit) const
{
	return unit && !unit->IsDead() && states.Contains(unit->GetId())
		&& control::SuspensionOf(unit, ai->GetLastFrame()) == control::Suspension::NONE;
}

IUnitTask* CRangedController::MakeLease(CCircuitUnit* unit)
{
	if (unit == nullptr || !Bound(unit->GetCircuitDef()->GetId())) return nullptr;
	Attach(unit);  // a gifted or loaded unit may not have come through UnitAdded
	return ai->GetMilitaryManager()->EnqueueControlled(this, nullptr);
}
void CRangedController::Leased(CCircuitUnit* unit, IUnitTask* task)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || task == nullptr) return;
	CloseEngagement(unit, *s, false);  // a lease replaced without a restore
	// Exactly CArtilleryTask::AssignTo's ranged branch: join the world, set
	// hold position and the opening fire state, log the assignment.
	s->engagement = std::make_unique<CRangedEngagement>(ai, task, unit);
	s->lease = task;
	++s->leases; ++leasesOpened;
}
void CRangedController::CloseEngagement(CCircuitUnit* unit, State& s, bool commands)
{
	if (!s.engagement) return;
	s.engagement->Release(unit, commands && unit != nullptr);
	s.engagement.reset();
	s.lease = nullptr;
}
void CRangedController::RestoreAfterLease(CCircuitUnit* unit, int /*fireState*/, int /*moveState*/)
{
	// The engagement restores the type's own default fire and move states, as
	// CArtilleryTask::RemoveAssignee did; the lease's remembered states are
	// those same defaults for a ranged unit, so they are not applied twice.
	State* s = states.Find(unit->GetId());
	if (s == nullptr) return;
	TRY_UNIT(ai, unit,
		CloseEngagement(unit, *s, true);
		writer.MoveState(unit, unit->GetCircuitDef()->GetMoveState(), "lease_end");
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "lease_end");
	)
}

void CRangedController::Update()
{
	if (states.Empty()) return;
	performance::Scope measured(ai, performance::RANGED_CONTROLLER);
	const int frame = ai->GetLastFrame();
	// The same stagger ITaskModule::Update gave the artillery tasks: about
	// n/30+1 units a frame, round robin, each engagement then self-samples
	// every eight frames. Damage, idle and move failures re-decide at once.
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
void CRangedController::Tick(CCircuitUnit* unit, State& s, int frame)
{
	IUnitTask* current = unit->GetTask();
	const int taskType = current ? int(current->GetType()) : -1;
	// A retreat lease ended: CRetreatTask::Recovered no longer writes the fire
	// state of a controlled unit; restore the type's default here.
	if (s.lastTaskType == int(IUnitTask::Type::RETREAT) && taskType != s.lastTaskType && current != nullptr)
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "retreat_end");
	s.lastTaskType = taskType;
	if (!s.engagement) return;
	if (current != s.lease) {
		// The lease was replaced without RemoveAssignee (a forced task swap):
		// the engagement must not keep ordering a unit another task owns.
		ai->LOG("[INVARIANT] INV-247 ranged engagement outlived its lease unit=%i task=%i", unit->GetId(), taskType);
		CloseEngagement(unit, s, false);
		return;
	}
	if (control::SuspensionOf(unit, frame) != control::Suspension::NONE) return;
	s.engagement->Update(unit);
}
void CRangedController::Damaged(CCircuitUnit* unit)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || !s->engagement || unit->IsDead()) return;
	Bind bound(this, s->preset);
	s->engagement->Idle();
	// CArtilleryTask::OnUnitDamaged, then the IFighterTask part that applied to
	// a ranged hull above its retreat health. Forward-only firing-line hulls
	// and a sustained rush keep their weapon owner even at low HP.
	CCircuitDef* cdef = unit->GetCircuitDef();
	if (cdef->GetRangedPolicy().holdFireline || s->engagement->IsSustainedRush()) return;
	if (unit->GetHealthPercent() <= cdef->GetRetreat()) {
		auto* military = ai->GetMilitaryManager();
		military->AssignTask(unit, military->EnqueueRetreat());
		return;
	}
	const int frame = ai->GetLastFrame();
	unit->ForceUpdate(frame + THREAT_UPDATE_RATE);
	const float healthPerc = unit->GetHealthPercent();
	if (!unit->IsDisarmed(frame)) {
		if (cdef->IsRoleHeavy() && (healthPerc < 0.9f) && !unit->IsAttrNoRepair()) {
			ai->GetBuilderManager()->Enqueue(TaskB::Repair(IBuilderTask::Priority::NOW, unit));
		}
		if (healthPerc < cdef->GetSelfDHP()) {
			TRY_UNIT(ai, unit, unit->CmdSelfD(true);)
		}
	}
}
void CRangedController::MoveFailed(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->MoveFailed();
}
void CRangedController::Idle(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->Idle();
}

} // namespace circuit
