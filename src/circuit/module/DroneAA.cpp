/*
 * DroneAA.cpp
 *
 * Owner 2026-11-04: enemy drones (a Legion Hive's, or any unit tagged
 * customparams.drone = 1) shooting our structures get an answer: the nearest
 * builders - commanders included - build up to two light AA towers next to
 * the struck structure, outside known enemy gun porc reach. A site outside the
 * drone carrier's own reach is preferred; when none is in AA cover of the
 * structure, a site inside the carrier's reach (never inside gun porc) is used,
 * because the carrier itself has no gun and the drones are what the tower is for.
 *
 * Owner 2026-11-07: when more than 6 distinct drones hit our units within 6 s
 * near the struck structure, one T1.5 AA is added (long-range Chainsaw /
 * Eradicator / Lupara when metal income >= 25 or the bank >= 900, else the
 * bomb-resistant Ferret / SAM / Rhapsis), placed by the same rules.
 *
 * Cost: event driven. Nothing runs without a drone hit on a structure; then at
 * most one evaluation per `interval` (2 s) per AI: one bounded friendly-unit
 * query (AA cover radius), one pass over the enemy structure list for carriers,
 * up to 4 x 16 candidate sites against the cached porc list, and a scan of the
 * builder set for the nearest free worker. Carrier detection is cached per def.
 */

#include "module/MilitaryManager.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "setup/SetupManager.h"
#include "task/builder/BuilderTask.h"
#include "terrain/TerrainManager.h"
#include "unit/ally/AllyUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "spring/SpringCallback.h"
#include "util/Utils.h"
#include "CircuitAI.h"
#include "Log.h"
#include "json/json.h"

#include "WeaponDef.h"
#include "WeaponMount.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <iterator>
#include <memory>

namespace circuit {

using namespace springai;

void CMilitaryManager::ReadDroneAAConfig()
{
	const Json::Value& root = circuit->GetSetupManager()->GetConfig();
	const Json::Value& cfg = root["drone_aa"];
	droneAA.enabled = cfg.get("enabled", true).asBool();
	droneAA.count = std::max(0, cfg.get("count", 2).asInt());
	droneAA.interval = std::max(1, int(cfg.get("interval", 2.f).asFloat() * FRAMES_PER_SEC));
	droneAA.pullRadius = std::max(0.f, cfg.get("pull_radius", 1600.f).asFloat());
	droneAA.coverMargin = std::max(0.f, cfg.get("cover_margin", 150.f).asFloat());
	droneAA.carrierMargin = std::max(0.f, cfg.get("carrier_margin", 96.f).asFloat());
	droneAA.timeout = std::max(10, int(cfg.get("timeout", 90.f).asFloat() * FRAMES_PER_SEC));
	droneAA.swarmCount = std::max(0, cfg.get("swarm_count", 6).asInt());
	droneAA.swarmWindow = std::max(1, int(cfg.get("swarm_seconds", 6.f).asFloat() * FRAMES_PER_SEC));
	droneAA.swarmRadius = std::max(0.f, cfg.get("swarm_radius", 1500.f).asFloat());
	droneAA.heavyCount = std::max(0, cfg.get("heavy_count", 1).asInt());
	droneAA.heavyMinRange = std::max(0.f, cfg.get("heavy_min_range", 900.f).asFloat());
	droneAA.longIncome = std::max(0.f, cfg.get("long_income", 25.f).asFloat());
	droneAA.longBank = std::max(0.f, cfg.get("long_bank", 900.f).asFloat());
	auto readList = [&cfg](const char* key, std::vector<std::string>& out, std::vector<std::string> fallback) {
		out.clear();
		const Json::Value& list = cfg[key];
		if (list.isArray()) {
			for (const Json::Value& name : list) if (name.isString()) out.push_back(name.asString());
		} else out = std::move(fallback);
	};
	readList("long_units", droneAA.longUnits, {"armcir", "corerad", "leglupara"});  // Chainsaw, Eradicator, Lupara
	readList("hard_units", droneAA.hardUnits, {"armferret", "cormadsam", "legrhapsis"});  // Ferret, SAM, Rhapsis
	droneAA.units.clear();
	const Json::Value& units = cfg["units"];
	if (units.isArray()) {
		for (const Json::Value& name : units) {
			if (name.isString()) droneAA.units.push_back(name.asString());
		}
	} else {
		droneAA.units = {"armrl", "corrl", "legrl"};  // Nettle, Thistle, Legion light AA
	}
}

bool CMilitaryManager::IsCarrierDef(CCircuitDef* cdef, float* reach)
{
	if (cdef == nullptr) return false;
	auto it = carrierReach.find(cdef->GetId());
	if (it == carrierReach.end()) {
		float found = -1.f;
		for (WeaponMount* mount : cdef->GetDef()->GetWeaponMounts()) {
			std::unique_ptr<WeaponMount> ownedMount(mount);
			std::unique_ptr<WeaponDef> wd(mount->GetWeaponDef());
			if (!wd) continue;
			const auto& params = wd->GetCustomParams();
			if (params.find("carried_unit") == params.end()) continue;
			float r = wd->GetRange();
			auto er = params.find("engagementrange");
			if (er != params.end()) r = std::max(r, utils::string_to_float(er->second));
			found = std::max(found, r);
		}
		it = carrierReach.emplace(cdef->GetId(), found).first;
	}
	if (reach != nullptr) *reach = it->second;
	return it->second > 0.f;
}

void CMilitaryManager::DroneAAStrike(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (!droneAA.enabled || (attacker == nullptr) || (unit == nullptr)) return;
	CCircuitDef* udef = unit->GetCircuitDef();
	CCircuitDef* adef = attacker->GetCircuitDef();
	if ((udef == nullptr) || (adef == nullptr) || !adef->IsDrone()) return;
	const int frame = circuit->GetLastFrame();
	// Swarm memory (owner 2026-11-07): every drone hit on any of our units,
	// one entry per drone (bounded by the live drone count), pruned below.
	droneAAHits[attacker->GetId()] = {frame, unit->GetPos(frame)};
	if (droneAAHits.size() > 256) {  // drones die and respawn with new ids: keep the memory bounded
		for (auto it = droneAAHits.begin(); it != droneAAHits.end();) {
			it = (frame - it->second.first > droneAA.swarmWindow) ? droneAAHits.erase(it) : std::next(it);
		}
	}
	if (udef->IsMobile()) return;  // towers answer hits on structures only
	if (frame < droneAANext) return;
	droneAANext = frame + droneAA.interval;

	const AIFloat3 strike = unit->GetPos(frame);
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	CEconomyManager* economyMgr = circuit->GetEconomyManager();
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();

	// Drones attacking at the same time: distinct drones that hit our units
	// within swarm_seconds, near this structure.
	int swarm = 0;
	for (auto it = droneAAHits.begin(); it != droneAAHits.end();) {
		if (frame - it->second.first > droneAA.swarmWindow) { it = droneAAHits.erase(it); continue; }
		if (it->second.second.SqDistance2D(strike) <= SQUARE(droneAA.swarmRadius)) ++swarm;
		++it;
	}

	auto logLine = [&](const char* fmt, auto... args) {
		if (frame - droneAALogFrame < FRAMES_PER_SEC * 5) return;
		droneAALogFrame = frame;
		circuit->LOG(fmt, args...);
	};

	auto freeBuilder = [&](CCircuitUnit* w, CCircuitDef* def) {
		if ((w == nullptr) || w->IsDead() || !w->GetCircuitDef()->CanBuild(def)) return false;
		IUnitTask* t = w->GetTask();
		if (t != nullptr) {
			if (t->GetType() == IUnitTask::Type::RETREAT) return false;
			if (droneAATasks.count(t) > 0) return false;  // already on one
			if ((t->GetType() == IUnitTask::Type::BUILDER)
				&& (static_cast<IBuilderTask*>(t)->GetPriority() == IUnitTask::Priority::NOW)) return false;
		}
		return w->GetHealthPercent() > 0.4f;
	};
	std::vector<std::pair<float, CCircuitUnit*>> nearby;  // squared distance, builder
	const float pullSq = SQUARE(droneAA.pullRadius);
	for (CCircuitUnit* w : builderMgr->GetWorkers()) {
		if ((w == nullptr) || w->IsDead()) continue;
		const float d = w->GetPos(frame).SqDistance2D(strike);
		if (d <= pullSq) nearby.emplace_back(d, w);
	}
	std::sort(nearby.begin(), nearby.end(), [](const auto& a, const auto& b) { return a.first < b.first; });
	std::vector<bool> taken(nearby.size(), false);

	// Carriers in sight or remembered (ghosts): their drone reach is a soft limit.
	struct SCarrier { AIFloat3 pos; float reach; };
	std::vector<SCarrier> carriers;
	for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		if (e == nullptr) continue;
		CCircuitDef* edef = e->GetCircuitDef();
		float reach = 0.f;
		if ((edef == nullptr) || edef->IsMobile() || !IsCarrierDef(edef, &reach)) continue;
		const auto& g = e->GetData();
		if (g.losStatus & (SEnemyData::DEAD | SEnemyData::DYING | SEnemyData::NEUTRAL | SEnemyData::HIDDEN)) continue;
		carriers.push_back({e->GetPos(), reach + droneAA.carrierMargin});
	}
	auto carrierClear = [&](const AIFloat3& p) {
		float best = std::numeric_limits<float>::infinity();
		for (const SCarrier& c : carriers) best = std::min(best, std::sqrt(c.pos.SqDistance2D(p)) - c.reach);
		return best;
	};
	auto skipCarrier = [this](CCircuitDef* d) { return IsCarrierDef(d, nullptr); };
	COOAICallback* clb = circuit->GetCallback();

	// One answer: `want` towers of tier (0 light, 1 T1.5) from `names`,
	// the nearest free builder's faction deciding the definition.
	auto respond = [&](int tier, const std::vector<std::string>& names, int want, const char* label) {
		CCircuitDef* aaDef = nullptr;
		for (size_t i = 0; (i < nearby.size()) && (aaDef == nullptr); ++i) {
			if (taken[i]) continue;
			for (const std::string& name : names) {
				CCircuitDef* def = circuit->GetCircuitDef(name.c_str());
				if ((def != nullptr) && def->IsAvailable(frame) && freeBuilder(nearby[i].second, def)) { aaDef = def; break; }
			}
		}
		if (aaDef == nullptr) {
			logLine("[DroneAA] %s drone hit %s %i at (%.0f,%.0f) swarm=%i: no free builder within %.0f can build %s AA",
				adef->GetDef()->GetName(), udef->GetDef()->GetName(), unit->GetId(), strike.x, strike.z, swarm,
				droneAA.pullRadius, label);
			return;
		}
		const float aaRange = aaDef->GetMaxRange(CCircuitDef::RangeType::AIR);
		const float cover = std::max(160.f, aaRange - droneAA.coverMargin);

		// Already answered? Static AA (ours or allied, built or under
		// construction; for T1.5 only air range >= heavy_min_range) covering
		// the struck structure, plus our unstarted drone AA tasks of the tier.
		int covered = 0;
		const std::vector<int> friendlies = clb->GetFriendlyUnitIdsIn(strike, cover, false);  // copy: the callback reuses its buffer
		for (int id : friendlies) {
			CCircuitDef* fdef = circuit->GetCircuitDefSafe(clb->Unit_GetDefId(id));
			if ((fdef == nullptr) || fdef->IsMobile() || !fdef->HasSurfToAir()) continue;
			if ((tier == 1) && (fdef->GetMaxRange(CCircuitDef::RangeType::AIR) < droneAA.heavyMinRange)) {
				// A listed T1.5 counts whatever its parsed air range (Lupara's AA is a VTOL-only cannon).
				const std::string fname = fdef->GetDef()->GetName();
				auto listed = [&fname](const std::vector<std::string>& v) { return std::find(v.begin(), v.end(), fname) != v.end(); };
				if (!listed(droneAA.longUnits) && !listed(droneAA.hardUnits)) continue;
			}
			++covered;
		}
		// Entries leave droneAATasks in CBuilderManager::DequeueTask, before the task is freed.
		for (const auto& kv : droneAATasks) {
			if (kv.second != tier) continue;
			const IBuilderTask* t = static_cast<const IBuilderTask*>(kv.first);
			if (!t->IsDead() && (t->GetTarget() == nullptr)
				&& (t->GetPosition().SqDistance2D(strike) <= SQUARE(cover + 200.f))) ++covered;
		}
		const int need = want - covered;
		if (need <= 0) {
			logLine("[DroneAA] %s drone hit %s %i at (%.0f,%.0f) swarm=%i: %i %s AA already cover it",
				adef->GetDef()->GetName(), udef->GetDef()->GetName(), unit->GetId(), strike.x, strike.z, swarm, covered, label);
			return;
		}

		// Candidate sites: 4 rings x 16 bearings inside AA cover of the structure.
		struct SSite { AIFloat3 pos; float score; bool inCarrier; float gunClear; };
		std::vector<SSite> sites;
		const float rings[4] = {0.25f, 0.45f, 0.65f, 0.85f};
		for (int ri = 0; ri < 4; ++ri) {
			const float r = std::max(96.f, cover * rings[ri]);
			for (int i = 0; i < 16; ++i) {
				const float a = (i + ((ri % 2) ? 0.5f : 0.f)) * 0.39269908f;
				AIFloat3 p(strike.x + std::cos(a) * r, strike.y, strike.z + std::sin(a) * r);
				CTerrainManager::CorrectPosition(p);
				if (p.SqDistance2D(strike) > SQUARE(cover)) continue;
				const float gunClear = economyMgr->EnemyPorcClearance(p, skipCarrier);
				if (gunClear < 0.f) continue;  // never inside enemy gun porc reach
				if (!builderMgr->IsBuildPositionAllowed(aaDef, p) || !terrainMgr->CanBeBuiltAtSafe(aaDef, p)) continue;
				const bool inCarrier = carrierClear(p) < 0.f;
				sites.push_back({p, std::sqrt(p.SqDistance2D(strike)), inCarrier, gunClear});
			}
		}
		// Outside the carrier's reach first, then closest to the structure.
		std::sort(sites.begin(), sites.end(), [](const SSite& a, const SSite& b) {
			if (a.inCarrier != b.inCarrier) return !a.inCarrier;
			return a.score < b.score;
		});
		std::vector<const SSite*> chosen;
		for (const SSite& st : sites) {
			if ((int)chosen.size() >= need) break;
			bool spaced = true;
			for (const SSite* c : chosen) spaced = spaced && (c->pos.SqDistance2D(st.pos) >= SQUARE(192.f));
			// Away from our other open drone AA sites too (light and T1.5 apart).
			for (const auto& kv : droneAATasks) {
				spaced = spaced && (static_cast<const IBuilderTask*>(kv.first)->GetPosition().SqDistance2D(st.pos) >= SQUARE(128.f));
			}
			if (spaced) chosen.push_back(&st);
		}
		if (chosen.empty()) {
			logLine("[DroneAA] %s drone hit %s %i at (%.0f,%.0f) swarm=%i: no %s site within %.0f outside enemy porc reach",
				adef->GetDef()->GetName(), udef->GetDef()->GetName(), unit->GetId(), strike.x, strike.z, swarm,
				aaDef->GetDef()->GetName(), cover);
			return;
		}

		for (const SSite* st : chosen) {
			IBuilderTask* task = builderMgr->Enqueue(TaskB::Common(IBuilderTask::BuildType::DEFENCE,
					IBuilderTask::Priority::HIGH, aaDef, st->pos, SQUARE_SIZE * 2, true, droneAA.timeout));
			if (task == nullptr) continue;
			droneAATasks[task] = tier;
			// Hand it to the nearest free builder now; the rest of the queue
			// (another builder, or this one after its first tower) is native.
			CCircuitUnit* worker = nullptr;
			for (size_t i = 0; i < nearby.size(); ++i) {
				if (taken[i]) continue;
				CCircuitUnit* w = nearby[i].second;
				if (freeBuilder(w, aaDef) && task->CanAssignTo(w) && !task->IsPorcBlocked(w)
					&& terrainMgr->CanReachAt(w, st->pos, w->GetCircuitDef()->GetBuildDistance()))
				{
					worker = w;
					taken[i] = true;
					break;
				}
			}
			if (worker != nullptr) builderMgr->AssignTask(worker, task);
			circuit->LOG("[DroneAA] %s drone hit %s %i at (%.0f,%.0f) swarm=%i: %s %s at (%.0f,%.0f) gun_clear=%.0f carrier=%s builder=%s %i (need %i, covered %i)",
				adef->GetDef()->GetName(), udef->GetDef()->GetName(), unit->GetId(), strike.x, strike.z, swarm,
				label, aaDef->GetDef()->GetName(), st->pos.x, st->pos.z, std::isfinite(st->gunClear) ? st->gunClear : -1.f,
				st->inCarrier ? "inside" : "outside",
				(worker != nullptr) ? worker->GetCircuitDef()->GetDef()->GetName() : "queue",
				(worker != nullptr) ? worker->GetId() : -1, need, covered);
		}
	};

	if (droneAA.count > 0) respond(0, droneAA.units, droneAA.count, "light");

	// Owner 2026-11-07: more than swarm_count drones attacking at once adds a
	// T1.5 AA. Long-range (Chainsaw / Eradicator / Lupara) when the economy
	// carries it - its 1100-1200 range also sits farther from the drones and
	// the carrier - else bomb-resistant (Ferret / SAM / Rhapsis).
	if ((droneAA.heavyCount > 0) && (swarm > droneAA.swarmCount)) {
		const bool rich = (economyMgr->GetAvgMetalIncome() >= droneAA.longIncome)
			|| (economyMgr->GetMetalCur() >= droneAA.longBank);
		respond(1, rich ? droneAA.longUnits : droneAA.hardUnits, droneAA.heavyCount, rich ? "T1.5 long-range" : "T1.5 bomb-resistant");
	}
}

} // namespace circuit
