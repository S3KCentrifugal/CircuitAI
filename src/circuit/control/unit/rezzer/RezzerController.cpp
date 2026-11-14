#include "control/unit/rezzer/RezzerController.h"
#include "control/core/LeaseTask.h"
#include "control/core/Ownership.h"
#include "control/group/BattleGroupController.h"
#include "control/kernel/RepairCrew.h"
#include "map/InfluenceMap.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "spring/SpringCallback.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "util/Defines.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

#include "Feature.h"
#include "FeatureDef.h"

#include <limits>

namespace circuit {

namespace {
using Field = control::ConfigField<RezzerConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
	return {name, [](RezzerConfig& c) -> float& { return c.*M; }, lo, hi};
}
// JSON keys of a "rezzer" preset and the aiControllers.SetOption levers.
const control::CConfigTable<RezzerConfig> kTable({
	F<&RezzerConfig::arrival>("arrival", 8.f, 512.f),
	F<&RezzerConfig::moveSeconds>("move_seconds", 1.f, 120.f),
	F<&RezzerConfig::orderSeconds>("order_seconds", 1.f, 300.f),
	F<&RezzerConfig::log>("log", 0.f, 1.f),
	F<&RezzerConfig::releaseSeconds>("release_seconds", 0.f, 600.f),
	F<&RezzerConfig::memberHealth>("member_health", 0.f, 1.f),
	F<&RezzerConfig::memberRadius>("member_radius", 0.f, 2000.f),
	F<&RezzerConfig::allyHealth>("ally_health", 0.f, 1.f),
	F<&RezzerConfig::allyRadius>("ally_radius", 0.f, 2000.f),
	F<&RezzerConfig::recoveryRadius>("recovery_radius", 0.f, 2000.f),
	F<&RezzerConfig::rezMetal>("rez_metal", 0.f, 1.f),
	F<&RezzerConfig::rezEnergy>("rez_energy", 0.f, 1.f),
	F<&RezzerConfig::scanSeconds>("scan_seconds", .5f, 30.f),
});
constexpr int DECISION_SLICE = TEAM_SLOWUPDATE_RATE;
// A feature under a native reclaim or resurrect task within this radius is that task's.
constexpr float TASK_CLAIM_RADIUS = 8.f;
// Reclaim and resurrect orders target one feature: an area this small around it.
constexpr float FEATURE_AREA = 8.f;
const char* WorkName(RezzerState::Work w) {
	switch (w) {
		case RezzerState::Work::STATION: return "station";
		case RezzerState::Work::TRIP: return "trip";
		case RezzerState::Work::MEMBER: return "member";
		case RezzerState::Work::ALLY: return "ally";
		case RezzerState::Work::RECLAIM: return "reclaim";
		case RezzerState::Work::RESURRECT: return "resurrect";
		default: return "none";
	}
}
}

CRezzerController::CRezzerController(CCircuitAI* ai)
	: CUnitControllerBase<RezzerConfig, RezzerState>(kTable), ai(ai), writer(ai, "Rezzer")
{
}
CRezzerController::~CRezzerController() = default;

void CRezzerController::OnPresetAssigned(int defId, int preset)
{
	for (auto& entry : states) {
		auto* unit = ai->GetTeamUnit(entry.id);
		if (unit && unit->GetCircuitDef()->GetId() == defId) entry.value->preset = preset;
	}
}

void CRezzerController::Attach(CCircuitUnit* unit)
{
	if (unit == nullptr || states.Contains(unit->GetId())) return;
	const int preset = PresetForDef(unit->GetCircuitDef()->GetId());
	if (preset < 0) return;
	states.Attach(unit->GetId()).preset = preset;
}
void CRezzerController::Detach(int unitId)
{
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->CrewLeave(unitId);
	if (State* s = states.Find(unitId)) Unclaim(unitId, *s);
	writer.Forget(unitId);
	states.Detach(unitId);
}
bool CRezzerController::Owns(CCircuitUnit* unit) const
{
	return unit && !unit->IsDead() && states.Contains(unit->GetId())
		&& control::SuspensionOf(unit, ai->GetLastFrame()) == control::Suspension::NONE;
}

IUnitTask* CRezzerController::MakeLease(CCircuitUnit* unit)
{
	if (unit == nullptr || !Bound(unit->GetCircuitDef()->GetId())) return nullptr;
	const CBattleGroupController* groups = ai->GetBattleGroupController();
	if (groups == nullptr || !groups->WantsCrew()) return nullptr;  // no group short of crew: builder work
	if (const State* s = states.Find(unit->GetId()); s && s->lease && unit->GetTask() == s->lease) return nullptr;
	Attach(unit);
	return ai->GetBuilderManager()->EnqueueLease(this, nullptr);
}
void CRezzerController::Leased(CCircuitUnit* unit, IUnitTask* task)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr || task == nullptr) return;
	s->lease = task; s->work = State::Work::NONE; s->target = -1; s->hasOrder = false;
	s->group = -1; s->alone = -1; s->nextScan = -1;
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->CrewJoin(unit->GetId());
}
void CRezzerController::RestoreAfterLease(CCircuitUnit* unit, int /*fireState*/, int /*moveState*/)
{
	State* s = states.Find(unit->GetId());
	if (s == nullptr) return;
	s->lease = nullptr; s->hasOrder = false; s->work = State::Work::NONE;
	Unclaim(unit->GetId(), *s);
	if (CBattleGroupController* groups = ai->GetBattleGroupController()) groups->CrewLeave(unit->GetId());
}
// An order that ended or failed: the next decision picks new work.
void CRezzerController::Idle(int unitId)
{
	if (State* s = states.Find(unitId)) { s->hasOrder = false; Unclaim(unitId, *s); }
}
void CRezzerController::MoveFailed(int unitId)
{
	if (State* s = states.Find(unitId)) { s->hasOrder = false; Unclaim(unitId, *s); }
}
void CRezzerController::Unclaim(int unitId, State& s)
{
	if (s.work != State::Work::RECLAIM && s.work != State::Work::RESURRECT) return;
	const auto it = claims.find(s.target);
	if (it != claims.end() && it->second == unitId) claims.erase(it);
}

void CRezzerController::Update()
{
	if (states.Empty()) return;
	performance::Scope measured(ai, performance::REZZER_CONTROLLER);
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

void CRezzerController::Tick(CCircuitUnit* unit, State& s, int frame)
{
	if (s.lease == nullptr || unit->GetTask() != s.lease) return;
	if (control::SuspensionOf(unit, frame) != control::Suspension::NONE) return;
	const CBattleGroupController* groups = ai->GetBattleGroupController();
	springai::AIFloat3 station;
	int group = -1;
	if (groups == nullptr || !groups->CrewPoint(unit->GetId(), station, group)) {
		// No group: stand; after release_seconds alone, back to builder work.
		if (s.alone < 0) s.alone = frame;
		else if (frame - s.alone >= int(cfg->releaseSeconds * FRAMES_PER_SEC)) {
			if (cfg->log > 0.f) ai->LOG("REZZER: release unit=%i frame=%i", unit->GetId(), frame);
			Unclaim(unit->GetId(), s);
			static_cast<CLeaseTask*>(s.lease)->Handover(unit);
		}
		return;
	}
	s.alone = -1;
	if (group != s.group && cfg->log > 0.f)
		ai->LOG("REZZER: unit=%i group=%i station=%.0f,%.0f frame=%i", unit->GetId(), group, station.x, station.z, frame);
	s.group = group;
	// 1. The member on its repair trip.
	const int trip = groups->CrewTrip(group);
	if (trip >= 0) {
		CCircuitUnit* patient = ai->GetTeamUnit(trip);
		if (patient != nullptr && !patient->IsDead()) { Repair(unit, s, trip, State::Work::TRIP, frame); return; }
	}
	// 2. The most damaged member near the station, from the group's health
	// snapshot (read once a second by the group: no engine read here).
	if (const auto* patients = groups->CrewPatients(group)) {
		int best = -1; float lowest = cfg->memberHealth;
		const float radiusSq = cfg->memberRadius * cfg->memberRadius;
		for (const auto& m : *patients) {
			if (m.health >= lowest) continue;
			CCircuitUnit* patient = ai->GetTeamUnit(m.id);
			if (patient == nullptr || patient->IsDead() || patient->GetPos(frame).SqDistance2D(station) > radiusSq) continue;
			best = m.id; lowest = m.health;
		}
		if (best >= 0) { Repair(unit, s, best, State::Work::MEMBER, frame); return; }
	}
	// 3 and 4 run to the end of their order unless the group moved away, or
	// (wrecks only) enemies came near the group.
	if (s.hasOrder && (s.work == State::Work::ALLY || s.work == State::Work::RECLAIM || s.work == State::Work::RESURRECT)) {
		const float leash = cfg->recoveryRadius + cfg->memberRadius;
		const bool wreck = s.work != State::Work::ALLY;
		if (unit->GetPos(frame).SqDistance2D(station) <= leash * leash && !(wreck && groups->CrewUnderFire(group))) return;
		Unclaim(unit->GetId(), s);
		s.hasOrder = false;
	}
	if (frame >= s.nextScan) {
		s.nextScan = frame + int(cfg->scanSeconds * FRAMES_PER_SEC);
		const int ally = FindAlly(unit, station);
		if (ally >= 0) { Repair(unit, s, ally, State::Work::ALLY, frame); return; }
		// Wrecks wait for a quiet moment: b27 arena, a bot walking to a wreck in
		// the raider fight died there.
		if (!groups->CrewUnderFire(group) && Recover(unit, s, station, frame)) return;
	}
	ToStation(unit, s, station, frame);
}

void CRezzerController::Repair(CCircuitUnit* unit, State& s, int targetId, State::Work work, int frame)
{
	if (s.hasOrder && s.target == targetId && (s.work == work || s.work == State::Work::TRIP || s.work == State::Work::MEMBER)) {
		s.work = work;
		return;
	}
	// Our own unit from the team table (always current), an ally's from the ally team's.
	CAllyUnit* target = ai->GetTeamUnit(targetId);
	if (target == nullptr) target = ai->GetFriendlyUnit(targetId);
	if (target == nullptr) return;
	Unclaim(unit->GetId(), s);
	TRY_UNIT(ai, unit, unit->CmdRepair(target, 0, frame + int(cfg->orderSeconds * FRAMES_PER_SEC));)
	if (cfg->log > 0.f) ai->LOG("REZZER: %s unit=%i target=%i frame=%i", WorkName(work), unit->GetId(), targetId, frame);
	s.work = work; s.target = targetId; s.hasOrder = true;
}

// The most damaged friendly unit under ally_health within ally_radius of the
// station: one engine query, one health read per unit found. O(K).
int CRezzerController::FindAlly(CCircuitUnit* unit, const springai::AIFloat3& station) const
{
	if (cfg->allyRadius <= 0.f) return -1;
	const auto& ids = ai->GetCallback()->GetFriendlyUnitIdsIn(station, cfg->allyRadius, false);
	int best = -1; float lowest = cfg->allyHealth;
	for (int id : ids) {
		if (id == unit->GetId()) continue;
		CAllyUnit* ally = ai->GetTeamUnit(id);
		if (ally == nullptr) ally = ai->GetFriendlyUnit(id);
		if (ally == nullptr || ally->GetCircuitDef() == nullptr || ally->GetCircuitDef()->IsAbleToFly()) continue;
		springai::Unit* u = ally->GetUnit();
		if (u == nullptr || u->IsBeingBuilt()) continue;
		const float maxHealth = u->GetMaxHealth();
		if (maxHealth <= 0.f) continue;
		const float health = u->GetHealth() / maxHealth;
		if (health < lowest) { best = id; lowest = health; }
	}
	return best;
}

// The nearest wreck within recovery_radius of the station for the economy's
// mode (repair_crew::Mode), not claimed by another bot or a native task and
// not on enemy ground. One feature query; O(F) for F features in the radius.
bool CRezzerController::Recover(CCircuitUnit* unit, State& s, const springai::AIFloat3& station, int frame)
{
	if (cfg->recoveryRadius <= 0.f || !unit->GetCircuitDef()->IsAbleToResurrect()) return false;
	CEconomyManager* economy = ai->GetEconomyManager();
	const repair_crew::Recovery mode = repair_crew::Mode(
		repair_crew::Fraction(economy->GetMetalCur(), economy->GetMetalStore()),
		repair_crew::Fraction(economy->GetEnergyCur(), economy->GetEnergyStore()), cfg->rezMetal, cfg->rezEnergy);
	if (mode == repair_crew::Recovery::NONE) return false;
	COOAICallback* clb = ai->GetCallback();
	CBuilderManager* builder = ai->GetBuilderManager();
	CInfluenceMap* influence = ai->GetInflMap();
	const springai::AIFloat3 pos = unit->GetPos(frame);
	auto features = clb->GetFeaturesIn(station, cfg->recoveryRadius, false);
	int chosen = -1; springai::AIFloat3 chosenPos; float bestSq = std::numeric_limits<float>::max();
	for (springai::Feature* f : features) {
		const int id = f->GetFeatureId();
		const auto claim = claims.find(id);
		if (claim != claims.end() && claim->second != unit->GetId()) continue;
		const springai::AIFloat3 at = f->GetPosition();
		const float d = pos.SqDistance2D(at);
		if (d >= bestSq) continue;
		if (mode == repair_crew::Recovery::RESURRECT) {
			if (clb->Feature_ResurrectDef(id) <= 0) continue;
		} else {
			springai::FeatureDef* def = f->GetDef();
			const float metal = (def != nullptr && def->IsReclaimable()) ? def->GetContainedResource(economy->GetMetalRes()) * f->GetReclaimLeft() : 0.f;
			delete def;
			if (metal <= 0.f) continue;
		}
		if (builder->IsReclaimFeature(at, TASK_CLAIM_RADIUS) || builder->IsResurrect(at, TASK_CLAIM_RADIUS)) continue;
		if (influence->GetInfluenceAt(at) < -INFL_EPS) continue;
		chosen = id; chosenPos = at; bestSq = d;
	}
	utils::free_clear(features);
	if (chosen < 0 || !ai->GetTerrainManager()->CanReachAtSafe2(unit, chosenPos, unit->GetCircuitDef()->GetBuildDistance())) return false;
	const bool rez = mode == repair_crew::Recovery::RESURRECT;
	if (s.hasOrder && s.target == chosen && s.work == (rez ? State::Work::RESURRECT : State::Work::RECLAIM)) return true;
	Unclaim(unit->GetId(), s);
	const int timeout = frame + int(cfg->orderSeconds * FRAMES_PER_SEC);
	TRY_UNIT(ai, unit,
		if (rez) unit->CmdResurrectInArea(chosenPos, FEATURE_AREA, 0, timeout);
		else unit->CmdReclaimInArea(chosenPos, FEATURE_AREA, 0, timeout);
	)
	if (cfg->log > 0.f) ai->LOG("REZZER: %s unit=%i feature=%i at=%.0f,%.0f frame=%i",
		rez ? "resurrect" : "reclaim", unit->GetId(), chosen, chosenPos.x, chosenPos.z, frame);
	s.work = rez ? State::Work::RESURRECT : State::Work::RECLAIM;
	s.target = chosen; s.hasOrder = true;
	claims[chosen] = unit->GetId();
	return true;
}

void CRezzerController::ToStation(CCircuitUnit* unit, State& s, const springai::AIFloat3& station, int frame)
{
	const float arrivalSq = cfg->arrival * cfg->arrival;
	if (s.work == State::Work::STATION && s.hasOrder && s.sent.SqDistance2D(station) < arrivalSq) return;
	Unclaim(unit->GetId(), s);
	s.work = State::Work::STATION; s.target = -1;
	if (unit->GetPos(frame).SqDistance2D(station) < arrivalSq) { s.sent = station; s.hasOrder = true; return; }
	springai::AIFloat3 to = station;
	CTerrainManager::CorrectPosition(to);
	TRY_UNIT(ai, unit, unit->CmdMoveTo(to, 0, frame + int(cfg->moveSeconds * FRAMES_PER_SEC));)
	s.sent = station; s.hasOrder = true;
}

} // namespace circuit
