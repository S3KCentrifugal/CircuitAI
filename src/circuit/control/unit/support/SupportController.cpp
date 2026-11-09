#include "control/unit/support/SupportController.h"
#include "control/core/LeaseTask.h"
#include "control/core/Ownership.h"
#include "control/group/BattleGroupController.h"
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
using Field = control::ConfigField<SupportConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
	return {name, [](SupportConfig& c) -> float& { return c.*M; }, lo, hi};
}
// The support controller's own numeric levers: JSON keys of a "support" preset and
// aiControllers.SetOption names. The policy's numeric keys are appended.
const std::vector<Field> kOwnFields{
	F<&SupportConfig::screenRadius>("screen_radius", 100.f, 4000.f),
	F<&SupportConfig::staticBonus>("static_bonus", 0.f, 10.f),
	F<&SupportConfig::beyondScreenBonus>("beyond_screen_bonus", 0.f, 10.f),
	F<&SupportConfig::fastTargetSpeed>("fast_target_speed", 0.f, 1000.f),
	F<&SupportConfig::fastTargetPenalty>("fast_target_penalty", 0.f, 1.f),
	F<&SupportConfig::selfDefenceRadius>("self_defence_radius", 0.f, 2000.f),
	F<&SupportConfig::selfDefenceBonus>("self_defence_bonus", 1.f, 100.f),
	F<&SupportConfig::moveAfterShot>("move_after_shot", 0.f, 1.f),
	F<&SupportConfig::aimHoldSeconds>("aim_hold_seconds", 0.f, 10.f),
	F<&SupportConfig::leakRadius>("leak_radius", 0.f, 2000.f),
	F<&SupportConfig::leakCorridor>("leak_corridor", 16.f, 512.f),
	F<&SupportConfig::tuckCount>("tuck_count", 1.f, 12.f),
	F<&SupportConfig::tuckOffset>("tuck_offset", 0.f, 512.f),
	F<&SupportConfig::tuckSeconds>("tuck_seconds", 0.f, 60.f),
	F<&SupportConfig::log>("log", 0.f, 1.f),
	// D-433
	F<&SupportConfig::stationSlack>("station_slack", 0.f, 256.f),
	F<&SupportConfig::noScreen>("no_screen", 0.f, 2.f),
	F<&SupportConfig::noScreenSeconds>("no_screen_seconds", 0.f, 60.f),
	// D-499
	F<&SupportConfig::screenTargetBonus>("screen_target_bonus", 0.f, 10.f),
	F<&SupportConfig::screenShield>("screen_shield", 0.f, 1.f),
	F<&SupportConfig::siege>("siege", 0.f, 1.f),
	F<&SupportConfig::siegeMargin>("siege_margin", 0.f, 256.f),
	F<&SupportConfig::siegeSlack>("siege_slack", 0.f, 256.f),
	F<&SupportConfig::siegeSearch>("siege_search", 0.f, 2000.f),  // D-507
	F<&SupportConfig::followScreenAssault>("follow_screen_assault", 0.f, 1.f),
};
template <std::size_t I>
float& Access(SupportConfig& c) { return ranged_policy::NumericKeys()[I].access(c.policy); }
template <std::size_t... I>
std::vector<Field> BuildFields(std::index_sequence<I...>) {
	const auto& keys = ranged_policy::NumericKeys();
	std::vector<Field> fields = kOwnFields;
	((I < keys.size() ? (void)fields.push_back({keys[I].name, &Access<I>, keys[I].low, keys[I].high}) : (void)0), ...);
	return fields;
}
const control::CConfigTable<SupportConfig>& Table() {
	static const control::CConfigTable<SupportConfig> table(BuildFields(std::make_index_sequence<96>{}));
	return table;
}
std::vector<std::string> OwnKeys() {
	std::vector<std::string> keys{"type"};
	for (const Field& f : kOwnFields) keys.push_back(f.name);
	return keys;
}
// Another job's levers: a support preset carrying one fails to load.
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

CSupportController::CSupportController(CCircuitAI* ai)
	: CUnitControllerBase<SupportConfig, SupportState>(Table()), ai(ai), writer(ai, "Support")
	, trace(std::getenv("CIRCUIT_RANGED_TRACE") != nullptr)
{
	writer.SetTrace(trace);
}
CSupportController::~CSupportController() = default;

int CSupportController::ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems)
{
	SupportConfig config = presets.front().config;
	// The support controller's own keys through the numeric table (clamped, reported),
	// the policy through the shared parser (rejected, never clamped), which
	// skips the own keys and refuses another job's.
	std::vector<std::string> policyKeys;
	for (const auto& key : ranged_policy::NumericKeys()) policyKeys.push_back(key.name);
	std::vector<std::string> skipForTable = policyKeys;
	for (const char* k : {"type", "coordinated", "fire_at_will", "prefer_heavy", "prefer_screen", "allow_mobile", "allow_static",
	                      "allow_radar", "advance_unknown_radar", "low_trajectory", "formation", "spam_units", "overkill_skip"}) skipForTable.push_back(k);
	Table().Apply(config, resolved, skipForTable, problems);
	const ranged_policy::Resolver resolver{
		[this](const std::string& unitName) { CCircuitDef* d = ai->GetCircuitDef(unitName.c_str()); return d ? d->GetId() : -1; },
		[this](const std::string& names) { return ai->GetGame()->GetCategoriesFlag(names.c_str()); }};
	if (!ranged_policy::Parse(resolved, config.policy, resolver, OwnKeys(), kForbidden, problems)) return -1;
	if (config.policy.formationPosition != RangedPolicy::FormationPosition::REAR) {
		problems.push_back("a support preset needs formation position rear");
		return -1;
	}
	const int existing = PresetIndex(name);
	if (existing >= 0) { presets[existing].config = config; return existing; }
	presets.push_back({name, config});
	cfg = &presets.front().config;
	return int(presets.size()) - 1;
}

void CSupportController::Publish(int defId, int preset)
{
	CCircuitDef* def = ai->GetCircuitDefSafe(defId);
	if (def == nullptr || preset < 0 || preset >= int(presets.size())) return;
	def->SetRangedPolicy(presets[preset].config.policy);
}
void CSupportController::BindDef(int defId, int preset)
{
	CUnitControllerBase::BindDef(defId, preset);
	Publish(defId, PresetForDef(defId));
}
void CSupportController::OnPresetAssigned(int defId, int preset)
{
	Publish(defId, preset);
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}
bool CSupportController::SetOption(const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetOption(name, value);
	if (accepted) for (const auto& [defId, preset] : presetByDef) Publish(defId, preset);
	return accepted;
}
bool CSupportController::SetPresetOption(const std::string& preset, const std::string& name, float value)
{
	const bool accepted = CUnitControllerBase::SetPresetOption(preset, name, value);
	if (accepted) {
		const int index = PresetIndex(preset);
		for (const auto& [defId, bound] : presetByDef) if (bound == index) Publish(defId, bound);
	}
	return accepted;
}

void CSupportController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	State& s = states.Attach(unit->GetId());
	s.preset = preset;
	if (trace) ai->LOG("[Support] attach unit=%i preset=%s", unit->GetId(), PresetName(preset).c_str());
}
void CSupportController::Detach(int unitId)
{
	if (State* s = states.Find(unitId)) CloseEngagement(nullptr, *s, false);
	writer.Forget(unitId);
	states.Detach(unitId);
}
bool CSupportController::Owns(CCircuitUnit* unit) const
{
	return unit && !unit->IsDead() && states.Contains(unit->GetId())
		&& control::SuspensionOf(unit, ai->GetLastFrame()) == control::Suspension::NONE;
}
const support::Directive* CSupportController::DirectiveFor(int unitId) const
{
	const State* s = states.Find(unitId);
	return (s && s->engagement && s->directive.active) ? &s->directive : nullptr;
}

IUnitTask* CSupportController::MakeLease(CCircuitUnit* unit)
{
	if (unit == nullptr || !Bound(unit->GetCircuitDef()->GetId())) return nullptr;
	Attach(unit);
	return ai->GetMilitaryManager()->EnqueueLease(this, nullptr);
}
void CSupportController::Leased(CCircuitUnit* unit, IUnitTask* task)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || task == nullptr) return;
	CloseEngagement(unit, *s, false);
	s->engagement = std::make_unique<CRangedEngagement>(ai, task, unit);
	s->lease = task;
	s->directive = support::Directive{};
	s->tuckUntil = -1; s->tuckThreat = -1; s->loggedStation = false;
	s->lastScreenFrame = -1; s->lastStationSet = false; s->noScreenActive = false;
	++s->leases; ++leasesOpened;
}
void CSupportController::CloseEngagement(CCircuitUnit* unit, State& s, bool commands)
{
	if (!s.engagement) return;
	s.engagement->Release(unit, commands && unit != nullptr);
	s.engagement.reset();
	s.lease = nullptr;
	s.directive.active = false;
}
void CSupportController::RestoreAfterLease(CCircuitUnit* unit, int /*fireState*/, int /*moveState*/)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr) return;
	TRY_UNIT(ai, unit,
		CloseEngagement(unit, *s, true);
		writer.MoveState(unit, unit->GetCircuitDef()->GetMoveState(), "lease_end");
		writer.FireState(unit, unit->GetCircuitDef()->GetFireState(), "lease_end");
	)
}

void CSupportController::Update()
{
	if (states.Empty()) return;
	performance::Scope measured(ai, performance::SUPPORT_CONTROLLER);
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
void CSupportController::Tick(CCircuitUnit* unit, State& s, int frame)
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
void CSupportController::Decide(CCircuitUnit* unit, State& s, int frame)
{
	support::Directive& d = s.directive;
	const SupportConfig& c = *cfg;
	CRangedWorld& world = s.engagement->World();
	const RangedPolicy& policy = unit->GetCircuitDef()->GetRangedPolicy();
	const springai::AIFloat3 pos = unit->GetPos(frame);
	d.active = true;
	d.stationSet = false; d.screenReach = 0.f;
	d.moveAfterShot = c.moveAfterShot > 0.f;
	d.aimHoldFrames = int(c.aimHoldSeconds * FRAMES_PER_SEC);
	d.weights = {c.staticBonus, c.beyondScreenBonus, c.fastTargetSpeed, c.fastTargetPenalty, c.selfDefenceRadius, c.selfDefenceBonus,
		c.screenTargetBonus};
	const int previousSiege = d.siegeTarget;
	// D-499: rebuilt every decision like the rest of the directive
	d.screenTarget = -1; d.shield = false; d.shieldCorridor = c.leakCorridor; d.screen.clear();
	d.siege = false; d.siegeTarget = -1; d.screenAssault.clear(); d.joining = false;
	const auto& plan = world.PlanCohort(unit);
	screenPoints.clear();
	float ownReach = 0.f, screenFraction = 1.f;
	const battle_group::Directive* groupDirective = ai->GetBattleGroupController() ? ai->GetBattleGroupController()->DirectiveFor(unit->GetId()) : nullptr;
	ranged::Point back = P(plan.back);
	if (groupDirective && groupDirective->facingSet) back = groupDirective->facing;
	for (const auto& w : s.engagement->Caps().weapons) ownReach = std::max(ownReach, w.range);
	if (plan.formationRear && plan.formationPartner >= 0) {
		const auto partner = world.Cohorts().find(plan.formationPartner);
		// D-499: with pair_seek_radius a screen beyond screen_radius is walked
		// to (joining): the station leads there, but nothing is tucked behind
		// or shielded by members that far away.
		const bool screenNear = partner != world.Cohorts().end()
			&& pos.SqDistance2D(partner->second.center) <= c.screenRadius * c.screenRadius;
		if (partner != world.Cohorts().end() && !partner->second.members.empty()
			&& (screenNear || policy.pairSeekRadius > 0.f)) {
			for (int id : partner->second.members) {
				CCircuitUnit* member = ai->GetTeamUnit(id);
				if (member == nullptr || member->IsDead()) continue;
				if (d.screenReach <= 0.f) {
					const auto& caps = world.CapabilitiesFor(member->GetCircuitDef());
					for (const auto& w : caps.weapons) d.screenReach = std::max(d.screenReach, w.range);
					const CCircuitDef* mdef = member->GetCircuitDef();
					screenFraction = mdef->HasEngagementPolicy() ? mdef->GetRangedPolicy().rangeFraction : 1.f;
				}
				screenPoints.push_back(P(member->GetPos(frame)));
			}
			d.joining = !screenNear;
			d.screenTarget = partner->second.target;
			if (c.followScreenAssault > 0.f && partner->second.committed) d.screenAssault = partner->second.assault;
			if (screenNear && c.screenShield > 0.f) { d.shield = true; d.screen = screenPoints; }
			if (!screenNear) screenPoints.clear();   // nothing to tuck behind on the way
			if (d.screenReach > 0.f) {
				// D-433: from the bands, not the reaches, less station_slack: the
				// hull stands inside its own band and fires at everything the screen
				// fights (D-432 stood 9 elmos beyond its band and stepped in and out).
				const float separation = support::Separation(ownReach * policy.rangeFraction, d.screenReach * screenFraction, c.stationSlack,
					policy.formationSeparationMinimum, policy.formationSeparationMaximum);
				d.screenCentre = P(partner->second.center);
				d.station = support::Station(d.screenCentre, back, separation);
				d.stationSet = true;
			}
		}
	}
	// D-499: siege. With a screen beside it, a rear hull besieges the nearest
	// armed static it outranges: its station is just inside its weapon reach from the tower
	// (SiegeDistance), on the screen's side, unless another armed static
	// would reach that point. Towers that outrange the rockets are left to the
	// screen's commitment (static_support_loss_fraction, follow_screen_assault).
	// Cost: one bounded nearby query (own reach + margin + siege_search) and an
	// O(T^2) cover test over its T statics (a handful) per decision.
	if (c.siege > 0.f && d.stationSet && !d.joining) {
		world.Nearby(pos, ownReach + c.siegeMargin + c.siegeSearch, siegeNearby);
		const auto& contacts = world.Contacts();
		float bestSq = 0.f;
		for (int index : siegeNearby) {
			const auto& t = contacts[index];
			if (t.mobile || !t.armed || t.def == nullptr || t.groundRange <= 0.f) continue;
			const float distance = support::SiegeDistance(ownReach, t.groundRange + policy.safetyMargin, c.siegeMargin, c.siegeSlack);
			if (distance < 0.f) continue;
			ranged::Point from{d.station.x - t.pos.x, d.station.z - t.pos.z};
			const float length = std::sqrt(from.x * from.x + from.z * from.z);
			if (length < 1.f) from = back; else { from.x /= length; from.z /= length; }
			const ranged::Point spot{t.pos.x + from.x * distance, t.pos.z + from.z * distance};
			bool covered = false;
			for (int other : siegeNearby) {
				const auto& o = contacts[other];
				// D-507: by weapon reach plus margins (as the besieging hull
				// moves); the hazard radius adds the tower's body and made
				// every spot in a cluster of towers 150 apart look covered.
				if (other == index || o.mobile || !o.armed || o.groundRange <= 0.f) continue;
				const float reach = o.groundRange + policy.safetyMargin + c.siegeMargin;
				if (ranged::DistanceSq(spot, P(o.pos)) < reach * reach) { covered = true; break; }
			}
			if (covered) continue;
			const float sq = pos.SqDistance2D(t.pos);
			if (d.siegeTarget < 0 || sq < bestSq) { bestSq = sq; d.siegeTarget = t.id; d.station = spot; }
		}
		d.siege = d.siegeTarget >= 0;
		if (c.log > 0.f && d.siege && d.siegeTarget != previousSiege)
			ai->LOG("SUPPORT: siege unit=%i tower=%i at=%.0f,%.0f frame=%i", unit->GetId(), d.siegeTarget, d.station.x, d.station.z, frame);
	}
	// D-433: the no-screen fallback. A paired screen refreshes the memory;
	// without one the last station holds for no_screen_seconds, then the
	// station moves to the nearest allied static that outranges the nearest
	// hostile (one bounded friend query) or to the cohort's rally point.
	if (d.stationSet) {
		s.lastScreenFrame = frame; s.lastStation = d.station; s.lastStationSet = true;
		if (s.noScreenActive) {
			s.noScreenActive = false;
			if (c.log > 0.f) ai->LOG("SUPPORT: no_screen_end unit=%i frame=%i", unit->GetId(), frame);
		}
	} else if (s.lastStationSet && !s.noScreenActive && frame < s.lastScreenFrame + int(c.noScreenSeconds * FRAMES_PER_SEC)) {
		d.station = s.lastStation; d.stationSet = true;
	} else if (c.noScreen >= 1.f) {
		float hostileRange = 0.f, hostileSq = 0.f; ranged::Point hostileAt = P(pos); bool hostileFound = false;
		world.Nearby(pos, c.screenRadius, nearby);
		for (int i : nearby) {
			const auto& contact = world.Contacts()[i];
			if (!contact.def || !contact.armed || contact.def->IsAbleToFly()) continue;
			const float distanceSq = pos.SqDistance2D(contact.pos);
			if (!hostileFound || distanceSq < hostileSq) { hostileFound = true; hostileSq = distanceSq; hostileRange = contact.groundRange; hostileAt = P(contact.pos); }
		}
		bool set = false; ranged::Point station{0.f, 0.f};
		if (c.noScreen < 1.5f) {
			world.Statics(pos, c.screenRadius, statics);
			posts.clear();
			for (const auto& post : statics) posts.push_back({P(post.pos), post.range});
			const int pick = support::NearestOutranging(P(pos), hostileAt, posts, hostileRange);
			if (pick >= 0) { station = support::Station(posts[pick].pos, back, policy.formationSeparationMinimum); set = true; }
		} else if (plan.strategic.SqLength2D() > 0.f) {
			station = P(plan.strategic); set = true;
		}
		if (set) {
			d.station = station; d.stationSet = true; d.noScreen = true;
			if (!s.noScreenActive) {
				s.noScreenActive = true; d.noScreenFrame = frame; ++noScreensTaken;
				if (c.log > 0.f) ai->LOG("SUPPORT: no_screen unit=%i mode=%i hostile_range=%.0f at=%.0f,%.0f frame=%i",
					unit->GetId(), int(c.noScreen), hostileRange, station.x, station.z, frame);
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
			if (!support::Leaked(P(pos), P(contact.pos), screenPoints, c.leakCorridor)) continue;
			leaked = contact.id; leakedDistanceSq = distanceSq; leakedAt = P(contact.pos);
		}
	}
	if (leaked >= 0) {
		if (!d.tuck || s.tuckThreat != leaked) {
			++tucksStarted;
			if (c.log > 0.f) ai->LOG("SUPPORT: tuck unit=%i threat=%i distance=%.0f screen=%u frame=%i",
				unit->GetId(), leaked, std::sqrt(leakedDistanceSq), unsigned(screenPoints.size()), frame);
		}
		d.tuck = true; s.tuckThreat = leaked;
		s.tuckUntil = frame + int(c.tuckSeconds * FRAMES_PER_SEC);
		d.tuckPoint = support::Tuck(P(pos), leakedAt, screenPoints, int(c.tuckCount), c.tuckOffset);
	} else if (d.tuck && (frame >= s.tuckUntil || screenPoints.empty())) {
		if (c.log > 0.f) ai->LOG("SUPPORT: tuck_end unit=%i threat=%i frame=%i", unit->GetId(), s.tuckThreat, frame);
		d.tuck = false; s.tuckThreat = -1;
	}
	if (c.log > 0.f && d.stationSet && !s.loggedStation) {
		s.loggedStation = true;
		ai->LOG("SUPPORT: station unit=%i screen=%i reach=%.0f/%.0f band=%.0f/%.0f separation=%.0f at=%.0f,%.0f frame=%i",
			unit->GetId(), plan.formationPartner, ownReach, d.screenReach, ownReach * policy.rangeFraction, d.screenReach * screenFraction,
			std::sqrt(ranged::DistanceSq(d.station, d.screenCentre)), d.station.x, d.station.z, frame);
	}
	if (trace && frame >= s.lastLogFrame + 150) {
		s.lastLogFrame = frame;
		ai->LOG("SUPPORT: unit=%i station=%i tuck=%i screen=%u reach=%.0f frame=%i", unit->GetId(), int(d.stationSet), int(d.tuck),
			unsigned(screenPoints.size()), d.screenReach, frame);
	}
}

void CSupportController::Damaged(CCircuitUnit* unit)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || !s->engagement || unit->IsDead()) return;
	Bind bound(this, s->preset);
	s->engagement->Idle();
	// D-433: the floor, the retreat rule, the repair rotation, self-destruct.
	disengage_rule::Apply(ai, unit, *s->engagement, unit->GetCircuitDef()->GetRangedPolicy(), s->disengage, ai->GetLastFrame(), "SUPPORT");
}
void CSupportController::MoveFailed(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->MoveFailed();
}
void CSupportController::Idle(int unitId)
{
	State* s = states.Find(unitId);
	if (s && s->engagement) s->engagement->Idle();
}

} // namespace circuit
