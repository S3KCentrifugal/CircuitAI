#include "control/unit/backline/BacklineController.h"
#include "control/core/ControlledTask.h"
#include "control/core/Ownership.h"
#include "control/group/LineController.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/MilitaryManager.h"
#include "task/RetreatTask.h"
#include "task/fighter/RangedEngagement.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "unit/RangedPolicyParse.h"
#include "util/Defines.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Game.h"
#include "Log.h"

#include <cmath>
#include <cstdlib>
#include <utility>

namespace circuit {

namespace {
using Field = control::ConfigField<BacklineConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
	return {name, [](BacklineConfig& c) -> float& { return c.*M; }, lo, hi};
}
// The backline's own numeric levers: JSON keys of a "backline" preset and
// aiControllers.SetOption names. The policy's numeric keys are appended.
const std::vector<Field> kOwnFields{
	F<&BacklineConfig::screenRadius>("screen_radius", 100.f, 4000.f),
	F<&BacklineConfig::staticBonus>("static_bonus", 0.f, 10.f),
	F<&BacklineConfig::beyondScreenBonus>("beyond_screen_bonus", 0.f, 10.f),
	F<&BacklineConfig::fastTargetSpeed>("fast_target_speed", 0.f, 1000.f),
	F<&BacklineConfig::fastTargetPenalty>("fast_target_penalty", 0.f, 1.f),
	F<&BacklineConfig::selfDefenceRadius>("self_defence_radius", 0.f, 2000.f),
	F<&BacklineConfig::selfDefenceBonus>("self_defence_bonus", 1.f, 100.f),
	F<&BacklineConfig::moveAfterShot>("move_after_shot", 0.f, 1.f),
	F<&BacklineConfig::aimHoldSeconds>("aim_hold_seconds", 0.f, 10.f),
	F<&BacklineConfig::leakRadius>("leak_radius", 0.f, 2000.f),
	F<&BacklineConfig::leakCorridor>("leak_corridor", 16.f, 512.f),
	F<&BacklineConfig::tuckCount>("tuck_count", 1.f, 12.f),
	F<&BacklineConfig::tuckOffset>("tuck_offset", 0.f, 512.f),
	F<&BacklineConfig::tuckSeconds>("tuck_seconds", 0.f, 60.f),
	F<&BacklineConfig::log>("log", 0.f, 1.f),
};
template <std::size_t I>
float& Access(BacklineConfig& c) { return ranged_policy::NumericKeys()[I].access(c.policy); }
template <std::size_t... I>
std::vector<Field> BuildFields(std::index_sequence<I...>) {
	const auto& keys = ranged_policy::NumericKeys();
	std::vector<Field> fields = kOwnFields;
	((I < keys.size() ? (void)fields.push_back({keys[I].name, &Access<I>, keys[I].low, keys[I].high}) : (void)0), ...);
	return fields;
}
const control::CConfigTable<BacklineConfig>& Table() {
	static const control::CConfigTable<BacklineConfig> table(BuildFields(std::make_index_sequence<64>{}));
	return table;
}
std::vector<std::string> OwnKeys() {
	std::vector<std::string> keys{"type"};
	for (const Field& f : kOwnFields) keys.push_back(f.name);
	return keys;
}
// Another job's levers: a backline preset carrying one fails to load.
const std::vector<std::string> kForbidden{
	"poke_in", "poke_in_dominant", "poke_out", "poke_ratio", "poke_health", "poke_press_health", "poke_pause_seconds",
	"sustained_rush", "sustained_rush_ratio", "sustained_rush_radius", "sustained_rush_min_front",
	"sustained_rush_remaining", "sustained_rush_cooldown", "sustained_rush_range",
	"press_static", "hold_fireline", "assist_radius", "assist_margin", "assist_screen",
	"cloak_on_reload", "stage_when_blocked", "commander_focus", "fire_in_range", "support_allies",
	"support_loss_fraction", "target_mode", "evasion_limit", "avoid_categories"};
constexpr int DECISION_SLICE = TEAM_SLOWUPDATE_RATE;
ranged::Point P(const springai::AIFloat3& p) { return {p.x, p.z}; }
}

CBacklineController::CBacklineController(CCircuitAI* ai)
	: CUnitControllerBase<BacklineConfig, BacklineState>(Table()), ai(ai), writer(ai, "Backline")
	, trace(std::getenv("CIRCUIT_RANGED_TRACE") != nullptr)
{
	writer.SetTrace(trace);
}
CBacklineController::~CBacklineController() = default;

int CBacklineController::ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems)
{
	BacklineConfig config = presets.front().config;
	// The backline's own keys through the numeric table (clamped, reported),
	// the policy through the shared parser (rejected, never clamped), which
	// skips the own keys and refuses another job's.
	std::vector<std::string> policyKeys;
	for (const auto& key : ranged_policy::NumericKeys()) policyKeys.push_back(key.name);
	std::vector<std::string> skipForTable = policyKeys;
	for (const char* k : {"type", "coordinated", "fire_at_will", "prefer_heavy", "prefer_screen", "allow_mobile", "allow_static",
	                      "allow_radar", "advance_unknown_radar", "low_trajectory", "formation", "spam_units"}) skipForTable.push_back(k);
	Table().Apply(config, resolved, skipForTable, problems);
	const ranged_policy::Resolver resolver{
		[this](const std::string& unitName) { CCircuitDef* d = ai->GetCircuitDef(unitName.c_str()); return d ? d->GetId() : -1; },
		[this](const std::string& names) { return ai->GetGame()->GetCategoriesFlag(names.c_str()); }};
	if (!ranged_policy::Parse(resolved, config.policy, resolver, OwnKeys(), kForbidden, problems)) return -1;
	if (config.policy.formationPosition != RangedPolicy::FormationPosition::REAR) {
		problems.push_back("a backline preset needs formation position rear");
		return -1;
	}
	const int existing = PresetIndex(name);
	if (existing >= 0) { presets[existing].config = config; return existing; }
	presets.push_back({name, config});
	cfg = &presets.front().config;
	return int(presets.size()) - 1;
}

void CBacklineController::Publish(int defId, int preset)
{
	CCircuitDef* def = ai->GetCircuitDefSafe(defId);
	if (def == nullptr || preset < 0 || preset >= int(presets.size())) return;
	def->SetRangedPolicy(presets[preset].config.policy);
}
void CBacklineController::BindDef(int defId, int preset)
{
	CUnitControllerBase::BindDef(defId, preset);
	Publish(defId, PresetForDef(defId));
}
void CBacklineController::OnPresetAssigned(int defId, int preset)
{
	Publish(defId, preset);
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}
bool CBacklineController::SetOption(const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetOption(name, value);
	if (accepted) for (const auto& [defId, preset] : presetByDef) Publish(defId, preset);
	return accepted;
}
bool CBacklineController::SetPresetOption(const std::string& preset, const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetPresetOption(preset, name, value);
	if (accepted) {
		const int index = PresetIndex(preset);
		for (const auto& [defId, bound] : presetByDef) if (bound == index) Publish(defId, bound);
	}
	return accepted;
}

void CBacklineController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	State& s = states.Attach(unit->GetId());
	s.preset = preset;
	if (trace) ai->LOG("[Backline] attach unit=%i preset=%s", unit->GetId(), PresetName(preset).c_str());
}
void CBacklineController::Detach(int unitId)
{
	if (State* s = states.Find(unitId)) CloseEngagement(nullptr, *s, false);
	writer.Forget(unitId);
	states.Detach(unitId);
}
bool CBacklineController::Owns(CCircuitUnit* unit) const
{
	return unit && !unit->IsDead() && states.Contains(unit->GetId())
		&& control::SuspensionOf(unit, ai->GetLastFrame()) == control::Suspension::NONE;
}
const backline::Directive* CBacklineController::DirectiveFor(int unitId) const
{
	const State* s = states.Find(unitId);
	return (s && s->engagement && s->directive.active) ? &s->directive : nullptr;
}

IUnitTask* CBacklineController::MakeLease(CCircuitUnit* unit)
{
	if (unit == nullptr || !Bound(unit->GetCircuitDef()->GetId())) return nullptr;
	Attach(unit);
	return ai->GetMilitaryManager()->EnqueueControlled(this, nullptr);
}
void CBacklineController::Leased(CCircuitUnit* unit, IUnitTask* task)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || task == nullptr) return;
	CloseEngagement(unit, *s, false);
	s->engagement = std::make_unique<CRangedEngagement>(ai, task, unit);
	s->lease = task;
	s->directive = backline::Directive{};
	s->tuckUntil = -1; s->tuckThreat = -1; s->loggedStation = false;
	++s->leases; ++leasesOpened;
}
void CBacklineController::CloseEngagement(CCircuitUnit* unit, State& s, bool commands)
{
	if (!s.engagement) return;
	s.engagement->Release(unit, commands && unit != nullptr);
	s.engagement.reset();
	s.lease = nullptr;
	s.directive.active = false;
}
void CBacklineController::RestoreAfterLease(CCircuitUnit* unit, int /*fireState*/, int /*moveState*/)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr) return;
	TRY_UNIT(ai, unit,
		CloseEngagement(unit, *s, true);
		writer.MoveState(unit, unit->GetCircuitDef()->GetMoveState(), "lease_end");
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "lease_end");
	)
}

void CBacklineController::Update()
{
	if (states.Empty()) return;
	performance::Scope measured(ai, performance::BACKLINE_CONTROLLER);
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
void CBacklineController::Tick(CCircuitUnit* unit, State& s, int frame)
{
	IUnitTask* current = unit->GetTask();
	const int taskType = current ? int(current->GetType()) : -1;
	if (s.lastTaskType == int(IUnitTask::Type::RETREAT) && taskType != s.lastTaskType && current != nullptr)
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "retreat_end");
	s.lastTaskType = taskType;
	if (!s.engagement) return;
	if (current != s.lease) {
		ai->LOG("[INVARIANT] INV-247 ranged engagement outlived its lease unit=%i task=%i", unit->GetId(), taskType);
		CloseEngagement(unit, s, false);
		return;
	}
	if (control::SuspensionOf(unit, frame) != control::Suspension::NONE) return;
	Decide(unit, s, frame);
	s.engagement->Update(unit);
}

// The directive for this decision: station behind the paired screen, the
// job's weights, the step window, and tuck when a hostile has leaked. Cost
// per decision: one cohort plan read (cached per frame by the world), one
// bounded nearby query (leak_radius), at most cohort_size screen positions.
void CBacklineController::Decide(CCircuitUnit* unit, State& s, int frame)
{
	backline::Directive& d = s.directive;
	const BacklineConfig& c = *cfg;
	CRangedWorld& world = s.engagement->World();
	const RangedPolicy& policy = unit->GetCircuitDef()->GetRangedPolicy();
	const springai::AIFloat3 pos = unit->GetPos(frame);
	d.active = true;
	d.stationSet = false; d.screenReach = 0.f;
	d.moveAfterShot = c.moveAfterShot > 0.f;
	d.aimHoldFrames = int(c.aimHoldSeconds * FRAMES_PER_SEC);
	d.weights = {c.staticBonus, c.beyondScreenBonus, c.fastTargetSpeed, c.fastTargetPenalty, c.selfDefenceRadius, c.selfDefenceBonus};
	const auto& plan = world.PlanCohort(unit);
	screenPoints.clear();
	float ownReach = 0.f;
	for (const auto& w : s.engagement->Caps().weapons) ownReach = std::max(ownReach, w.range);
	if (plan.formationRear && plan.formationPartner >= 0) {
		const auto partner = world.Cohorts().find(plan.formationPartner);
		if (partner != world.Cohorts().end() && !partner->second.members.empty()
			&& pos.SqDistance2D(partner->second.center) <= c.screenRadius * c.screenRadius) {
			for (int id : partner->second.members) {
				CCircuitUnit* member = ai->GetTeamUnit(id);
				if (member == nullptr || member->IsDead()) continue;
				if (d.screenReach <= 0.f) {
					const auto& caps = world.CapabilitiesFor(member->GetCircuitDef());
					for (const auto& w : caps.weapons) d.screenReach = std::max(d.screenReach, w.range);
				}
				screenPoints.push_back(P(member->GetPos(frame)));
			}
			if (!screenPoints.empty()) {
				const line::Directive* lineDirective = ai->GetLineController() ? ai->GetLineController()->DirectiveFor(unit->GetId()) : nullptr;
				ranged::Point back = P(plan.back);
				if (lineDirective && lineDirective->facingSet) back = lineDirective->facing;
				const float separation = backline::Separation(ownReach, d.screenReach, policy.safetyMargin,
					policy.formationSeparationMinimum, policy.formationSeparationMaximum);
				d.screenCentre = P(partner->second.center);
				d.station = backline::Station(d.screenCentre, back, separation);
				d.stationSet = true;
			}
		}
	}
	// Leak: the nearest short-range armed mobile hostile in leak_radius with
	// no screen member between it and this hull.
	int leaked = -1; float leakedDistanceSq = 0.f; ranged::Point leakedAt{0.f, 0.f};
	if (c.leakRadius > 0.f && !screenPoints.empty()) {
		world.Nearby(pos, c.leakRadius, nearby);
		const auto& contacts = world.Contacts();
		for (int i : nearby) {
			const auto& contact = contacts[i];
			if (!contact.def || !contact.mobile || !contact.armed || !contact.los || contact.def->IsAbleToFly()) continue;
			if (contact.groundRange >= ownReach) continue;
			const float distanceSq = pos.SqDistance2D(contact.pos);
			if (leaked >= 0 && distanceSq >= leakedDistanceSq) continue;
			if (!backline::Leaked(P(pos), P(contact.pos), screenPoints, c.leakCorridor)) continue;
			leaked = contact.id; leakedDistanceSq = distanceSq; leakedAt = P(contact.pos);
		}
	}
	if (leaked >= 0) {
		if (!d.tuck || s.tuckThreat != leaked) {
			++tucksStarted;
			if (c.log > 0.f) ai->LOG("BACKLINE: tuck unit=%i threat=%i distance=%.0f screen=%u frame=%i",
				unit->GetId(), leaked, std::sqrt(leakedDistanceSq), unsigned(screenPoints.size()), frame);
		}
		d.tuck = true; s.tuckThreat = leaked;
		s.tuckUntil = frame + int(c.tuckSeconds * FRAMES_PER_SEC);
		d.tuckPoint = backline::Tuck(P(pos), leakedAt, screenPoints, int(c.tuckCount), c.tuckOffset);
	} else if (d.tuck && (frame >= s.tuckUntil || screenPoints.empty())) {
		if (c.log > 0.f) ai->LOG("BACKLINE: tuck_end unit=%i threat=%i frame=%i", unit->GetId(), s.tuckThreat, frame);
		d.tuck = false; s.tuckThreat = -1;
	}
	if (c.log > 0.f && d.stationSet && !s.loggedStation) {
		s.loggedStation = true;
		ai->LOG("BACKLINE: station unit=%i screen=%i reach=%.0f/%.0f separation=%.0f at=%.0f,%.0f frame=%i",
			unit->GetId(), plan.formationPartner, ownReach, d.screenReach,
			std::sqrt(ranged::DistanceSq(d.station, d.screenCentre)), d.station.x, d.station.z, frame);
	}
	if (trace && frame >= s.lastLogFrame + 150) {
		s.lastLogFrame = frame;
		ai->LOG("BACKLINE: unit=%i station=%i tuck=%i screen=%u reach=%.0f frame=%i", unit->GetId(), int(d.stationSet), int(d.tuck),
			unsigned(screenPoints.size()), d.screenReach, frame);
	}
}

void CBacklineController::Damaged(CCircuitUnit* unit)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || !s->engagement || unit->IsDead()) return;
	Bind bound(this, s->preset);
	s->engagement->Idle();
	CCircuitDef* cdef = unit->GetCircuitDef();
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
void CBacklineController::MoveFailed(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->MoveFailed();
}
void CBacklineController::Idle(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->Idle();
}

} // namespace circuit
