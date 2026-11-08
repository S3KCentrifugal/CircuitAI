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
#include "map/ThreatMap.h"
#include "util/math/Geometry.h"
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
	droneAA.zoneRadius = std::max(0.f, cfg.get("zone_radius", 200.f).asFloat());
	droneAA.zoneTime = std::max(1, int(cfg.get("zone_seconds", 300.f).asFloat() * FRAMES_PER_SEC));
	droneAA.backStep = std::max(16.f, cfg.get("back_step", 64.f).asFloat());
	droneAA.backSteps = std::clamp(cfg.get("back_steps", 10).asInt(), 0, 40);
	droneAA.reorderTime = std::max(1, int(cfg.get("reorder_seconds", 180.f).asFloat() * FRAMES_PER_SEC));
	droneAA.droneMemory = std::max(1, int(cfg.get("drone_memory_seconds", 30.f).asFloat() * FRAMES_PER_SEC));
	droneAA.threatMargin = std::max(0.f, cfg.get("threat_margin", 150.f).asFloat());
	droneAA.threatScan = std::max(100.f, cfg.get("threat_scan", 900.f).asFloat());
	droneAA.retreatTime = std::max(FRAMES_PER_SEC, int(cfg.get("retreat_seconds", 15.f).asFloat() * FRAMES_PER_SEC));
	droneAA.anchorRadius = std::max(0.f, cfg.get("anchor_radius", 500.f).asFloat());
	droneAA.carrierScan = std::max(0.f, cfg.get("carrier_scan", 4000.f).asFloat());
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
	if (udef->IsMobile()) {
		// Owner 2026-11-08: a hit on a mobile unit near our base counts for our
		// nearest structure within anchor_radius; out in the field it does not.
		// O(friendlies in anchor_radius), one bounded query per drone hit.
		CCircuitUnit* anchor = nullptr;
		float bestSq = SQUARE(droneAA.anchorRadius);
		const AIFloat3 at = unit->GetPos(frame);
		const std::vector<int> nearIds = circuit->GetCallback()->GetFriendlyUnitIdsIn(at, droneAA.anchorRadius, false);  // copy
		for (int id : nearIds) {
			CCircuitUnit* s = circuit->GetTeamUnit(id);  // ours only; allies' structures are theirs to answer
			if ((s == nullptr) || s->IsDead() || (s->GetCircuitDef() == nullptr) || s->GetCircuitDef()->IsMobile()) continue;
			const float d = s->GetPos(frame).SqDistance2D(at);
			if (d <= bestSq) { bestSq = d; anchor = s; }
		}
		if (anchor == nullptr) return;
		unit = anchor;
		udef = anchor->GetCircuitDef();
	}
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

	auto freeBuilder = [this](CCircuitUnit* w, CCircuitDef* def) { return DroneAAFreeBuilder(w, def); };
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
		if ((edef == nullptr) || !IsCarrierDef(edef, &reach)) continue;  // static Hive or mobile Mantis (owner 2026-11-08)
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
		// Owner 2026-11-08 (White Fire AI 13): a just-started frame counts too, so
		// a second tower is not ordered beside it; counted once, by its task.
		for (const auto& kv : droneAATasks) {
			if (kv.second != tier) continue;
			const IBuilderTask* t = static_cast<const IBuilderTask*>(kv.first);
			if (t->IsDead() || (t->GetPosition().SqDistance2D(strike) > SQUARE(cover + 200.f))) continue;
			const CCircuitUnit* frameUnit = t->GetTarget();
			if ((frameUnit == nullptr)
				|| (std::find(friendlies.begin(), friendlies.end(), frameUnit->GetId()) == friendlies.end())) ++covered;
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
				if ((tier == 1) && DroneAAInZone(p)) continue;  // owner 2026-11-08: not in front of a dead T1.5
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

// ---------------------------------------------------------------------------
// Owner 2026-11-08 (White Fire Remake): a T1.5 lost to a drone attack bans a
// semicircle of zone_radius in front of its spot (toward the drones' carrier,
// sides included) for zone_seconds, and a re-order goes zone_radius behind it
// at once (further back, in back_step steps, when terrain or structures block),
// never inside gun porc. A builder on a drone AA order leaves it while a mobile
// ground enemy has it or its spot within land range + threat_margin; the order
// waits until that threat is gone. Drones do not count as that threat: they
// are what the tower answers, and they fill the surface threat map.
//
// Lifetime: zones and pending re-orders hold only positions, def ids and
// frames; builders are re-found every update; task pointers are used only
// while they are keys of droneAATasks (erased in CBuilderManager::DequeueTask
// before the task is freed), re-checked after every call that can swap tasks.
// Cost: UpdateDroneAA returns at once with nothing pending; otherwise per
// second O(live drone AA tasks x assignees) bounded enemy queries (only where
// the threat map is above THREAT_MIN), plus per pending re-order at most
// (back_steps + 1) x 5 candidate sites and one pass over the builder set.

bool CMilitaryManager::IsDroneAAHeavyDef(const CCircuitDef* def) const
{
	if (def == nullptr) return false;
	const std::string name = def->GetDef()->GetName();
	return (std::find(droneAA.longUnits.begin(), droneAA.longUnits.end(), name) != droneAA.longUnits.end())
		|| (std::find(droneAA.hardUnits.begin(), droneAA.hardUnits.end(), name) != droneAA.hardUnits.end());
}

bool CMilitaryManager::DroneAAFreeBuilder(CCircuitUnit* w, CCircuitDef* def) const
{
	if ((w == nullptr) || w->IsDead() || (def == nullptr) || (w->GetCircuitDef() == nullptr)
		|| !w->GetCircuitDef()->CanBuild(def)) return false;
	auto r = droneAARetreat.find(w->GetId());
	if ((r != droneAARetreat.end()) && (r->second > circuit->GetLastFrame())) return false;  // retreating from a ground threat
	IUnitTask* t = w->GetTask();
	if (t != nullptr) {
		if (t->GetType() == IUnitTask::Type::RETREAT) return false;
		if (droneAATasks.count(t) > 0) return false;  // already on one
		if ((t->GetType() == IUnitTask::Type::BUILDER)
			&& (static_cast<IBuilderTask*>(t)->GetPriority() == IUnitTask::Priority::NOW)) return false;
	}
	return w->GetHealthPercent() > 0.4f;
}

bool CMilitaryManager::DroneAAInZone(const AIFloat3& p) const
{
	const float rSq = SQUARE(droneAA.zoneRadius);
	for (const SDroneAAZone& z : droneAAZones) {
		const float dx = p.x - z.pos.x, dz = p.z - z.pos.z;
		if ((dx * dx + dz * dz < rSq) && (dx * z.dir.x + dz * z.dir.z >= 0.f)) return true;  // front half, sides included
	}
	return false;
}

bool CMilitaryManager::DroneAADirection(const AIFloat3& from, AIFloat3& dir)
{
	// Toward the nearest known drone carrier (static or mobile), else the
	// enemy's position estimate, else away from our base.
	AIFloat3 target = from;
	bool found = false;
	float bestSq = SQUARE(droneAA.carrierScan);
	for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		if (e == nullptr) continue;
		CCircuitDef* edef = e->GetCircuitDef();
		if ((edef == nullptr) || !IsCarrierDef(edef, nullptr)) continue;
		if (e->GetData().losStatus & (SEnemyData::DEAD | SEnemyData::DYING | SEnemyData::NEUTRAL | SEnemyData::HIDDEN)) continue;
		const float d = e->GetPos().SqDistance2D(from);
		if (d < bestSq) { bestSq = d; target = e->GetPos(); found = true; }
	}
	if (!found) {
		const AIFloat3& ep = circuit->GetEnemyManager()->GetEnemyPos();
		if (geom::is_valid(ep)) target = ep;
	}
	dir = AIFloat3(target.x - from.x, 0.f, target.z - from.z);
	float len = std::sqrt(dir.x * dir.x + dir.z * dir.z);
	if (len < 1.f) {
		const AIFloat3& base = circuit->GetSetupManager()->GetBasePos();
		dir = AIFloat3(from.x - base.x, 0.f, from.z - base.z);
		len = std::sqrt(dir.x * dir.x + dir.z * dir.z);
		if (len < 1.f) { dir = AIFloat3(1.f, 0.f, 0.f); len = 1.f; }
	}
	dir.x /= len; dir.z /= len;
	return found;
}

bool CMilitaryManager::DroneAAGroundThreat(const AIFloat3& pos, AIFloat3* enemyPos)
{
	CThreatMap* threatMap = circuit->GetThreatMap();
	if ((threatMap != nullptr) && (threatMap->GetThreatAt(pos) <= THREAT_MIN)) return false;
	const std::vector<int> ids = circuit->GetCallback()->GetEnemyUnitIdsIn(pos, droneAA.threatScan, false);  // copy: reused buffer
	for (int id : ids) {
		CEnemyInfo* e = circuit->GetEnemyInfo(id);
		if ((e == nullptr) || (e->GetData() == nullptr)) continue;
		if (e->GetData()->GetData().losStatus & (SEnemyData::DEAD | SEnemyData::DYING | SEnemyData::NEUTRAL | SEnemyData::HIDDEN)) continue;
		CCircuitDef* edef = e->GetCircuitDef();
		// Mobile ground attackers only: porc is the porc rules' job, drones are the target.
		if ((edef == nullptr) || !edef->IsMobile() || edef->IsDrone() || IsCarrierDef(edef, nullptr)) continue;
		const float range = edef->GetMaxRange(CCircuitDef::RangeType::LAND);
		if (range <= 0.f) continue;
		const AIFloat3& ep = e->GetPos();
		if (ep.SqDistance2D(pos) <= SQUARE(range + droneAA.threatMargin)) {
			if (enemyPos != nullptr) *enemyPos = ep;
			return true;
		}
	}
	return false;
}

bool CMilitaryManager::DroneAASiteOk(CCircuitDef* def, const AIFloat3& p)
{
	if ((def == nullptr) || DroneAAInZone(p)) return false;
	auto skipCarrier = [this](CCircuitDef* d) { return IsCarrierDef(d, nullptr); };
	if (circuit->GetEconomyManager()->EnemyPorcClearance(p, skipCarrier) < 0.f) return false;  // never inside gun porc
	return circuit->GetBuilderManager()->IsBuildPositionAllowed(def, p)
		&& circuit->GetTerrainManager()->CanBeBuiltAtSafe(def, p);
}

void CMilitaryManager::DroneAARetreat(CCircuitUnit* unit, const AIFloat3& enemyPos, int frame)
{
	if ((unit == nullptr) || unit->IsDead()) return;
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	const AIFloat3 pos = unit->GetPos(frame);
	AIFloat3 away(pos.x - enemyPos.x, 0.f, pos.z - enemyPos.z);
	float len = std::sqrt(away.x * away.x + away.z * away.z);
	if (len < 1.f) {
		const AIFloat3& base = circuit->GetSetupManager()->GetBasePos();
		away = AIFloat3(base.x - pos.x, 0.f, base.z - pos.z);
		len = std::max(1.f, std::sqrt(away.x * away.x + away.z * away.z));
	}
	AIFloat3 to(pos.x + away.x / len * 400.f, pos.y, pos.z + away.z / len * 400.f);
	CTerrainManager::CorrectPosition(to);
	// A NOW patrol: drone AA tasks give their builder up only to NOW work (KeepsAssignee).
	IUnitTask* retreat = builderMgr->Enqueue(TaskB::Patrol(IBuilderTask::Priority::NOW, to, droneAA.retreatTime));
	if (retreat == nullptr) return;
	const int id = unit->GetId();
	builderMgr->AssignTask(unit, retreat);
	CCircuitUnit* again = circuit->GetTeamUnit(id);
	if ((again == nullptr) || again->IsDead() || (again->GetTask() != retreat)) {
		if (!retreat->IsDead() && retreat->GetAssignees().empty()) builderMgr->AbortTask(retreat);
		return;
	}
	droneAARetreat[id] = frame + droneAA.retreatTime;
	circuit->LOG("[DroneAA] retreat %s %i at (%.0f,%.0f) from ground enemy at (%.0f,%.0f) to (%.0f,%.0f)",
		again->GetCircuitDef()->GetDef()->GetName(), id, pos.x, pos.z, enemyPos.x, enemyPos.z, to.x, to.z);
}

void CMilitaryManager::DroneAAUnitDestroyed(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (!droneAA.enabled || (droneAA.heavyCount <= 0) || (unit == nullptr)) return;
	CCircuitDef* def = unit->GetCircuitDef();
	if (!IsDroneAAHeavyDef(def)) return;
	const int frame = circuit->GetLastFrame();
	const AIFloat3 pos = unit->GetPos(frame);
	// A drone attack: the killer is a drone, or drones hit us nearby lately.
	bool drones = (attacker != nullptr) && (attacker->GetCircuitDef() != nullptr) && attacker->GetCircuitDef()->IsDrone();
	for (auto it = droneAAHits.begin(); !drones && (it != droneAAHits.end()); ++it) {
		drones = (frame - it->second.first <= droneAA.droneMemory)
			&& (it->second.second.SqDistance2D(pos) <= SQUARE(droneAA.swarmRadius));
	}
	if (!drones) return;
	AIFloat3 dir;
	const bool toCarrier = DroneAADirection(pos, dir);
	droneAAZones.push_back({pos, dir, frame});
	if (droneAAZones.size() > 32) droneAAZones.erase(droneAAZones.begin());
	bool merged = false;
	for (SDroneAAPending& pd : droneAAPending) {  // the same spot again: the newest death decides
		if (pd.pos.SqDistance2D(pos) < SQUARE(droneAA.zoneRadius)) {
			pd = {pos, dir, def->GetId(), true, frame + droneAA.reorderTime, frame, frame};
			merged = true;
			break;
		}
	}
	if (!merged && (droneAAPending.size() < 16)) {
		droneAAPending.push_back({pos, dir, def->GetId(), true, frame + droneAA.reorderTime, frame, frame});
	}
	circuit->LOG("[DroneAA] zone %s %i lost at (%.0f,%.0f): no T1.5 within %.0f in front (toward %s, dir %.2f,%.2f); re-order behind",
		def->GetDef()->GetName(), unit->GetId(), pos.x, pos.z, droneAA.zoneRadius,
		toCarrier ? "carrier" : "enemy estimate", dir.x, dir.z);
}

void CMilitaryManager::UpdateDroneAA()
{
	if (droneAAZones.empty() && droneAAPending.empty() && droneAATasks.empty() && droneAARetreat.empty()) return;
	const int frame = circuit->GetLastFrame();
	droneAAZones.erase(std::remove_if(droneAAZones.begin(), droneAAZones.end(),
		[&](const SDroneAAZone& z) { return frame - z.frame > droneAA.zoneTime; }), droneAAZones.end());
	for (auto it = droneAARetreat.begin(); it != droneAARetreat.end();) {
		it = (it->second <= frame) ? droneAARetreat.erase(it) : std::next(it);
	}
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();

	// 1. A builder on a drone AA order leaves it under a mobile ground threat.
	if (!droneAATasks.empty()) {
		std::vector<const IUnitTask*> snapshot;
		snapshot.reserve(droneAATasks.size());
		for (const auto& kv : droneAATasks) snapshot.push_back(kv.first);
		for (const IUnitTask* key : snapshot) {
			auto it = droneAATasks.find(key);
			if (it == droneAATasks.end()) continue;  // dequeued meanwhile: the pointer may be freed
			const int tier = it->second;
			IBuilderTask* task = static_cast<IBuilderTask*>(const_cast<IUnitTask*>(key));
			if (task->IsDead()) continue;
			const AIFloat3 site = task->GetPosition();
			const int defId = (task->GetBuildDef() != nullptr) ? task->GetBuildDef()->GetId() : -1;
			std::vector<int> ids;
			for (CCircuitUnit* u : task->GetAssignees()) if (u != nullptr) ids.push_back(u->GetId());
			bool left = false;
			for (int id : ids) {
				if (droneAATasks.find(key) == droneAATasks.end()) break;  // gone during a swap
				CCircuitUnit* u = circuit->GetTeamUnit(id);
				if ((u == nullptr) || u->IsDead() || (u->GetTask() != task)) continue;
				AIFloat3 enemyPos;
				if (DroneAAGroundThreat(u->GetPos(frame), &enemyPos) || DroneAAGroundThreat(site, &enemyPos)) {
					DroneAARetreat(u, enemyPos, frame);
					left = true;
				}
			}
			if (!left || (tier != 1) || (defId < 0) || (droneAATasks.find(key) == droneAATasks.end())) continue;
			if (task->IsDead() || !task->GetAssignees().empty() || (task->GetTarget() != nullptr)) continue;
			// Unstarted T1.5 order with nobody left: drop it, re-order once the threat is gone.
			if (droneAAPending.size() < 16) {
				droneAAPending.push_back({site, AIFloat3(1.f, 0.f, 0.f), defId, false, frame + droneAA.reorderTime, frame + FRAMES_PER_SEC * 2, frame});
			}
			circuit->LOG("[DroneAA] wait threat: T1.5 order at (%.0f,%.0f) dropped, its builder retreated; re-order when clear", site.x, site.z);
			builderMgr->AbortTask(task);  // DequeueTask erases it from droneAATasks
		}
	}

	// 2. Pending T1.5 re-orders.
	if (droneAAPending.empty()) return;
	std::vector<SDroneAAPending> work;
	work.swap(droneAAPending);  // entries added during this pass (a death) land in droneAAPending and are kept
	std::vector<SDroneAAPending> keep;
	COOAICallback* clb = circuit->GetCallback();
	for (SDroneAAPending& pd : work) {
		if (frame > pd.expire) {
			circuit->LOG("[DroneAA] reorder gave up at (%.0f,%.0f)", pd.pos.x, pd.pos.z);
			continue;
		}
		if (frame < pd.nextTry) { keep.push_back(pd); continue; }
		pd.nextTry = frame + FRAMES_PER_SEC * 2;
		const bool logNow = (frame >= pd.nextLog);
		CCircuitDef* def = circuit->GetCircuitDef(pd.defId);
		if ((def == nullptr) || !def->IsAvailable(frame)) continue;
		// The nearest free builder within pull_radius of `at` that is not under a ground threat.
		auto findWorker = [&](const AIFloat3& at) {
			CCircuitUnit* best = nullptr;
			float bestSq = SQUARE(droneAA.pullRadius);
			for (CCircuitUnit* w : builderMgr->GetWorkers()) {
				if (!DroneAAFreeBuilder(w, def)) continue;
				const AIFloat3 wp = w->GetPos(frame);
				const float d = wp.SqDistance2D(at);
				if ((d > bestSq) || DroneAAGroundThreat(wp, nullptr)
					|| !terrainMgr->CanReachAt(w, at, w->GetCircuitDef()->GetBuildDistance())) continue;
				bestSq = d;
				best = w;
			}
			return best;
		};
		// Done once a T1.5 stands (built or frame) near the lost spot.
		bool built = false;
		const std::vector<int> friendlies = clb->GetFriendlyUnitIdsIn(pd.pos, droneAA.zoneRadius * 3.f, false);  // copy
		for (int id : friendlies) {
			if (IsDroneAAHeavyDef(circuit->GetCircuitDefSafe(clb->Unit_GetDefId(id)))) { built = true; break; }
		}
		if (built) continue;
		// An open T1.5 order nearby (ours, or the hit-driven one): keep watching it,
		// and give it a builder when its own died or left (first Cortex/Legion fixture
		// 11-08: the re-order's constructor died 1-4 s later and nobody took it).
		IBuilderTask* open = nullptr;
		for (const auto& kv : droneAATasks) {
			const IBuilderTask* t = static_cast<const IBuilderTask*>(kv.first);
			if ((kv.second == 1) && !t->IsDead() && (t->GetPosition().SqDistance2D(pd.pos) < SQUARE(droneAA.zoneRadius * 3.f))) {
				open = const_cast<IBuilderTask*>(t);
				break;
			}
		}
		if (open != nullptr) {
			if (open->GetAssignees().empty() && (open->GetTarget() == nullptr) && !DroneAAGroundThreat(open->GetPosition(), nullptr)) {
				CCircuitUnit* w = findWorker(open->GetPosition());
				if ((w != nullptr) && open->CanAssignTo(w) && !open->IsPorcBlocked(w)) {
					const int wid = w->GetId();
					const char* wname = w->GetCircuitDef()->GetDef()->GetName();
					const AIFloat3 at = open->GetPosition();  // copied before the assignment can change the task
					builderMgr->AssignTask(w, open);
					circuit->LOG("[DroneAA] reorder: builder %s %i takes the open %s order at (%.0f,%.0f)",
						wname, wid, def->GetDef()->GetName(), at.x, at.z);
				}
			}
			keep.push_back(pd);
			continue;
		}
		// The site: zone_radius behind the dead spot (away from the drones),
		// then further back, a little to either side; for an order dropped
		// under a ground threat, its old spot while that is still allowed.
		AIFloat3 site = pd.pos;
		bool found = false;
		if (!pd.behind) found = DroneAASiteOk(def, site);
		const float perpX = -pd.dir.z, perpZ = pd.dir.x;
		const float lats[5] = {0.f, 64.f, -64.f, 128.f, -128.f};
		for (int k = 0; pd.behind && !found && (k <= droneAA.backSteps); ++k) {
			const float back = droneAA.zoneRadius + k * droneAA.backStep;
			for (float lat : lats) {
				AIFloat3 p(pd.pos.x - pd.dir.x * back + perpX * lat, pd.pos.y, pd.pos.z - pd.dir.z * back + perpZ * lat);
				CTerrainManager::CorrectPosition(p);
				if (DroneAASiteOk(def, p)) { site = p; found = true; break; }
			}
		}
		if (!found) {
			if (logNow) {
				pd.nextLog = frame + FRAMES_PER_SEC * 10;
				circuit->LOG("[DroneAA] reorder: no %s site behind (%.0f,%.0f) yet", def->GetDef()->GetName(), pd.pos.x, pd.pos.z);
			}
			keep.push_back(pd);
			continue;
		}
		AIFloat3 enemyPos;
		if (DroneAAGroundThreat(site, &enemyPos)) {
			if (logNow) {
				pd.nextLog = frame + FRAMES_PER_SEC * 10;
				circuit->LOG("[DroneAA] wait threat: %s site (%.0f,%.0f), ground enemy at (%.0f,%.0f)",
					def->GetDef()->GetName(), site.x, site.z, enemyPos.x, enemyPos.z);
			}
			keep.push_back(pd);
			continue;
		}
		CCircuitUnit* worker = findWorker(site);
		if (worker == nullptr) {
			if (logNow) {
				pd.nextLog = frame + FRAMES_PER_SEC * 10;
				circuit->LOG("[DroneAA] reorder: no free builder for %s at (%.0f,%.0f)", def->GetDef()->GetName(), site.x, site.z);
			}
			keep.push_back(pd);
			continue;
		}
		IBuilderTask* task = builderMgr->Enqueue(TaskB::Common(IBuilderTask::BuildType::DEFENCE,
				IBuilderTask::Priority::HIGH, def, site, SQUARE_SIZE * 2, true, droneAA.timeout));
		if (task == nullptr) { keep.push_back(pd); continue; }
		droneAATasks[task] = 1;
		const int wid = worker->GetId();
		const char* wname = worker->GetCircuitDef()->GetDef()->GetName();
		if (task->CanAssignTo(worker) && !task->IsPorcBlocked(worker)) builderMgr->AssignTask(worker, task);
		circuit->LOG("[DroneAA] reorder %s at (%.0f,%.0f), %.0f from the lost one at (%.0f,%.0f), builder %s %i",
			def->GetDef()->GetName(), site.x, site.z, std::sqrt(site.SqDistance2D(pd.pos)), pd.pos.x, pd.pos.z, wname, wid);
		keep.push_back(pd);  // watched until a T1.5 stands there or reorder_seconds pass
	}
	droneAAPending.insert(droneAAPending.end(), keep.begin(), keep.end());
	if (droneAAPending.size() > 16) droneAAPending.erase(droneAAPending.begin(), droneAAPending.begin() + (droneAAPending.size() - 16));
}

} // namespace circuit
