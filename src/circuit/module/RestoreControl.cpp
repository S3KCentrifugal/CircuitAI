/*
 * RestoreControl.cpp
 *
 * Terrain restore (owner 2026-10-31), see RestoreControl.h.
 */

#include "module/RestoreControl.h"
#include "module/BuilderManager.h"
#include "setup/SetupManager.h"
#include "task/builder/RestoreTask.h"
#include "terrain/TerrainManager.h"
#include "terrain/TerrainData.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "unit/ally/AllyUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "json/json.h"

#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"

#include "Game.h"
#include "Log.h"
#include "UnitDef.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <limits>

namespace circuit {

using namespace springai;

// The engine caps a restore's half side here (BuilderCAI::ExecuteRestore).
static constexpr float RESTORE_MAX_RADIUS = 200.f;
static constexpr float RESTORE_MIN_RADIUS = 32.f;
static constexpr unsigned CLASS_COMMANDER = 1, CLASS_T1 = 2, CLASS_T2 = 4, CLASS_REZ = 8;

static const char* ReasonName(int reason)
{
	switch (reason) {
		case CRestoreControl::BASE:   return "base";
		case CRestoreControl::SITE:   return "site";
		case CRestoreControl::LAVA:   return "lava";
		case CRestoreControl::SCRIPT: return "script";
		default: return "?";
	}
}

CRestoreControl::CRestoreControl(CCircuitAI* circuit)
		: circuit(circuit)
{
}

CRestoreControl::~CRestoreControl()
{
}

void CRestoreControl::ReadConfig(const Json::Value& root)
{
	const Json::Value& cfg = root["restore"];
	enabled = cfg.get("enable", false).asBool();
	allowMask = CLASS_COMMANDER | CLASS_T1 | CLASS_REZ;
	const Json::Value& units = cfg["units"];
	if (units.isArray()) {
		allowMask = 0;
		for (const Json::Value& name : units) {
			const std::string s = name.asString();
			if (s == "commander") {
				allowMask |= CLASS_COMMANDER;
			} else if (s == "t1") {
				allowMask |= CLASS_T1;
			} else if (s == "t2") {
				allowMask |= CLASS_T2;
			} else if (s == "rez") {
				allowMask |= CLASS_REZ;
			} else {
				circuit->LOG("RESTORE: unknown unit class '%s' (commander, t1, t2, rez)", s.c_str());
			}
		}
	}
	threshold = std::max(2.f, cfg.get("damage", threshold).asFloat());
	minCells = std::max(1, cfg.get("min_cells", minCells).asInt());
	baseRadius = std::max(0.f, cfg.get("base_radius", baseRadius).asFloat());
	maxActive = std::max(0, cfg.get("max_active", maxActive).asInt());
	reach = std::max(0.f, cfg.get("reach", reach).asFloat());
	lava = cfg.get("lava", lava).asBool();
	lavaMargin = std::max(0.f, cfg.get("lava_margin", lavaMargin).asFloat());
	interval = std::max(1, cfg.get("interval", interval).asInt());
	maxSeconds = std::max(10, cfg.get("max_seconds", maxSeconds).asInt());
	cooldownSeconds = std::max(interval, cfg.get("cooldown", cooldownSeconds).asInt());
	busyPenalty = std::max(0.f, cfg.get("busy_penalty", busyPenalty).asFloat());
	unitClass.clear();
	circuit->LOG("RESTORE: %s units=%s%s%s%s damage=%.0f min_cells=%i base_radius=%.0f max_active=%i lava=%i",
			enabled ? "on" : "off",
			(allowMask & CLASS_COMMANDER) ? "commander " : "", (allowMask & CLASS_T1) ? "t1 " : "",
			(allowMask & CLASS_T2) ? "t2 " : "", (allowMask & CLASS_REZ) ? "rez " : "",
			threshold, minCells, baseRadius, maxActive, int(lava));
}

int CRestoreControl::GetScanInterval() const
{
	return FRAMES_PER_SEC * interval;
}

float CRestoreControl::GetLavaLevel() const
{
	if (!lava) {
		return -1e9f;
	}
	// map_lava.lua publishes -99999 until its first frame, and nothing on a
	// map without lava: both read as no lava.
	const float level = circuit->GetGame()->GetRulesParamFloat("lavaLevel", -1e9f);
	return (level < -9e4f) ? -1e9f : level;
}

int CRestoreControl::UnitClass(const CCircuitDef* cdef) const
{
	auto it = unitClass.find(cdef->GetId());
	if (it != unitClass.end()) {
		return it->second;
	}
	int cls = 0;
	if (cdef->IsMobile() && cdef->IsAbleToRestore()) {
		if (cdef->IsRoleComm()) {
			cls = CLASS_COMMANDER;
		} else if (cdef->IsBuilder()) {
			// BAR customparams.techlevel (alldefs_post sets 1 when absent)
			const std::map<std::string, std::string>& params = cdef->GetDef()->GetCustomParams();
			auto tl = params.find("techlevel");
			const float tech = (tl != params.end()) ? utils::string_to_float(tl->second) : 1.f;
			cls = (tech >= 2.f) ? CLASS_T2 : CLASS_T1;
		} else if (cdef->IsAbleToResurrect()) {
			cls = CLASS_REZ;
		}
	}
	unitClass[cdef->GetId()] = cls;
	return cls;
}

bool CRestoreControl::IsEligible(CCircuitUnit* unit) const
{
	return enabled && ((UnitClass(unit->GetCircuitDef()) & allowMask) != 0);
}

bool CRestoreControl::RequestSite(const AIFloat3& pos, float radius, int reason)
{
	if (!enabled || !geom::is_valid(pos)) {
		return false;
	}
	// Validated on the next scan against the heightmap (BuildPatch); a site
	// that is not damaged costs one patch check and a cooldown.
	const int frame = circuit->GetLastFrame();
	if (IsCoolingDown(circuit->GetTerrainManager()->GetSectorIndex(pos), frame) || IsCovered(pos)) {
		return false;
	}
	for (const SRequest& r : requests) {
		if (r.pos.SqDistance2D(pos) < SQUARE(64.f)) {
			return true;
		}
	}
	if (requests.size() >= 16) {
		return false;
	}
	requests.push_back({pos, std::min(radius, RESTORE_MAX_RADIUS), reason, frame});
	return true;
}

bool CRestoreControl::IsCovered(const AIFloat3& pos) const
{
	for (const SActive& a : active) {
		if (a.pos.SqDistance2D(pos) < SQUARE(a.radius + 32.f)) {
			return true;
		}
	}
	return false;
}

bool CRestoreControl::IsCoolingDown(int sector, int frame) const
{
	auto it = cooldown.find(sector);
	return (it != cooldown.end()) && (it->second > frame);
}

void CRestoreControl::CoolDown(const AIFloat3& pos, float radius, int frames)
{
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	const int size = terrainMgr->GetConvertStoP();
	const int until = circuit->GetLastFrame() + frames;
	const float reachSq = SQUARE(radius + size * 0.5f);
	const int sx1 = std::max(0, int((pos.x - radius) / size));
	const int sx2 = std::min(terrainMgr->GetSectorXSize() - 1, int((pos.x + radius) / size));
	const int sz1 = std::max(0, int((pos.z - radius) / size));
	const int sz2 = std::min(terrainMgr->GetSectorZSize() - 1, int((pos.z + radius) / size));
	for (int z = sz1; z <= sz2; ++z) {
		for (int x = sx1; x <= sx2; ++x) {
			const int i = z * terrainMgr->GetSectorXSize() + x;
			if (terrainMgr->GetSectorCenter(i).SqDistance2D(pos) <= reachSq) {
				cooldown[i] = until;
			}
		}
	}
	cooldown[terrainMgr->GetSectorIndex(pos)] = until;
}

bool CRestoreControl::BuildPatch(const AIFloat3& near, SPatch& patch)
{
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	const int frame = circuit->GetLastFrame();

	// Structures keep their levelled pads: those cells are never damage. A
	// footprint is taken as the circle around its larger side.
	// Footprints are rasterised once into the window's cell grid (51x51 for
	// the 200 radius), so the cell scan costs one lookup per cell.
	const int x0 = int((near.x - RESTORE_MAX_RADIUS) / SQUARE_SIZE);
	const int z0 = int((near.z - RESTORE_MAX_RADIUS) / SQUARE_SIZE);
	const int side = int(2 * RESTORE_MAX_RADIUS / SQUARE_SIZE) + 2;
	std::vector<char> blocked;
	circuit->UpdateFriendlyUnits();
	const std::vector<int> ids = circuit->GetCallback()->GetFriendlyUnitIdsIn(near, RESTORE_MAX_RADIUS * 1.5f, false);
	for (int id : ids) {
		CAllyUnit* au = circuit->GetFriendlyUnit(id);
		if ((au == nullptr) || (au->GetCircuitDef() == nullptr) || au->GetCircuitDef()->IsMobile()) {
			continue;
		}
		if (blocked.empty()) {
			blocked.assign(side * side, 0);
		}
		UnitDef* def = au->GetCircuitDef()->GetDef();
		const float half = std::max(def->GetXSize(), def->GetZSize()) * SQUARE_SIZE * 0.71f + SQUARE_SIZE;
		const AIFloat3& p = au->GetPos(frame);
		const int cx1 = std::max(0, int((p.x - half) / SQUARE_SIZE) - x0);
		const int cx2 = std::min(side - 1, int((p.x + half) / SQUARE_SIZE) - x0);
		const int cz1 = std::max(0, int((p.z - half) / SQUARE_SIZE) - z0);
		const int cz2 = std::min(side - 1, int((p.z + half) / SQUARE_SIZE) - z0);
		for (int cz = cz1; cz <= cz2; ++cz) {
			for (int cx = cx1; cx <= cx2; ++cx) {
				blocked[cz * side + cx] = 1;
			}
		}
	}

	CTerrainManager::SDamageQuery query;
	query.threshold = threshold;
	query.lavaLevel = GetLavaLevel();
	query.lavaMargin = lavaMargin;
	if (!blocked.empty()) {
		query.skip = [&blocked, x0, z0, side](float x, float z) {
			const int cx = int(x / SQUARE_SIZE) - x0;
			const int cz = int(z / SQUARE_SIZE) - z0;
			return (cx >= 0) && (cz >= 0) && (cx < side) && (cz < side) && (blocked[cz * side + cx] != 0);
		};
	}
	const CTerrainManager::STerrainDamage damage = terrainMgr->GetTerrainDamage(near, RESTORE_MAX_RADIUS, query);
	if (damage.cells < minCells) {
		return false;
	}
	// The damaged cells' box inside the 400x400 window, plus a cell's margin
	// for the engine's border smoothing. A larger crater gets further patches
	// on later scans.
	patch.center = AIFloat3((damage.minX + damage.maxX) * 0.5f, 0.f, (damage.minZ + damage.maxZ) * 0.5f);
	patch.center.y = circuit->GetMap()->GetElevationAt(patch.center.x, patch.center.z);
	const float half = std::max(damage.maxX - damage.minX, damage.maxZ - damage.minZ) * 0.5f + SQUARE_SIZE * 2;
	patch.radius = std::clamp(half, RESTORE_MIN_RADIUS, RESTORE_MAX_RADIUS);
	patch.cells = damage.cells;
	patch.lavaCells = damage.lavaCells;
	patch.depth = std::max(damage.dug, damage.raised);
	return true;
}

CCircuitUnit* CRestoreControl::PickUnit(const AIFloat3& pos, float radius)
{
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	const int frame = circuit->GetLastFrame();
	CCircuitUnit* best = nullptr;
	float bestScore = std::numeric_limits<float>::max();
	for (CCircuitUnit* unit : builderMgr->GetWorkers()) {
		if (unit->IsDead() || unit->IsDestroying() || !IsEligible(unit) || (unit->GetCommanderTarget() >= 0)) {
			continue;
		}
		IUnitTask* task = unit->GetTask();
		if (task == nullptr) {
			continue;
		}
		// Idle units and builder tasks only: retreat, combat, transport holds
		// and the commander's fight belong to their own owners.
		bool busy = false;
		if (task->GetType() == IUnitTask::Type::BUILDER) {
			const IBuilderTask::BuildType bt = static_cast<IBuilderTask*>(task)->GetBuildType();
			if ((bt == IBuilderTask::BuildType::TERRAFORM) || (bt == IBuilderTask::BuildType::COMBAT)) {
				continue;
			}
			busy = (bt < IBuilderTask::BuildType::REPAIR);
			if (busy && (static_cast<IBuilderTask*>(task)->GetTarget() != nullptr)) {
				continue;  // a frame is up: never walk off a construction in progress
			}
		} else if (task->GetType() != IUnitTask::Type::IDLE) {
			continue;
		}
		const float dist = std::sqrt(unit->GetPos(frame).SqDistance2D(pos));
		if (dist > reach) {
			continue;
		}
		const float score = dist + (busy ? busyPenalty : 0.f);
		if (score >= bestScore) {
			continue;
		}
		// The engine stops within build range + 0.7 radius of the centre.
		if (!terrainMgr->CanReachAtSafe(unit, pos, unit->GetCircuitDef()->GetBuildDistance() + radius * 0.7f)) {
			continue;
		}
		best = unit;
		bestScore = score;
	}
	return best;
}

void CRestoreControl::Scan()
{
	if (!enabled || (maxActive <= 0)) {
		return;
	}
	const int frame = circuit->GetLastFrame();
	for (auto it = cooldown.begin(); it != cooldown.end();) {
		it = (it->second <= frame) ? cooldown.erase(it) : std::next(it);
	}
	if (int(active.size()) >= maxActive) {
		return;
	}

	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	const float lavaLevel = GetLavaLevel();
	const AIFloat3& basePos = circuit->GetSetupManager()->GetBasePos();
	struct SCandidate {
		AIFloat3 pos;
		int reason;
		float order;  // lower first
	};
	std::vector<SCandidate> candidates;

	// 1. Crater lava under our own ground units.
	if (lavaLevel > -1e8f) {
		for (const auto& kv : circuit->GetTeamUnits()) {
			CCircuitUnit* unit = kv.second;
			const CCircuitDef* cdef = unit->GetCircuitDef();
			if (unit->IsDead() || !cdef->IsMobile() || cdef->IsAbleToFly()) {
				continue;
			}
			const AIFloat3& pos = unit->GetPos(frame);
			if (!geom::is_valid(pos) || (terrainMgr->GetAreaData()->GetElevationAt(pos.x, pos.z) >= lavaLevel)
				|| (terrainMgr->GetOriginalElevationAt(pos.x, pos.z) < lavaLevel + lavaMargin))
			{
				continue;
			}
			candidates.push_back({pos, LAVA, 0.f});
		}
	}
	// 2. Sites a task could not build on, and script requests.
	for (const SRequest& r : requests) {
		if (frame - r.frame < FRAMES_PER_SEC * 120) {
			candidates.push_back({r.pos, r.reason, 1.f});
		}
	}
	requests.clear();
	// 3. Our base.
	if (geom::is_valid(basePos) && (baseRadius > 0.f)) {
		std::vector<int> sectors;
		terrainMgr->FindDamagedSectors(basePos, baseRadius, threshold, lavaLevel, sectors);
		for (int i : sectors) {
			const AIFloat3 pos = terrainMgr->GetSectorCenter(i);
			candidates.push_back({pos, BASE, 2.f + std::sqrt(pos.SqDistance2D(basePos)) * 1e-5f});
		}
	}
	if (candidates.empty()) {
		return;
	}
	std::stable_sort(candidates.begin(), candidates.end(),
			[](const SCandidate& a, const SCandidate& b) { return a.order < b.order; });

	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	const int cooldownFrames = FRAMES_PER_SEC * cooldownSeconds;
	int tried = 0;
	for (const SCandidate& c : candidates) {
		if ((int(active.size()) >= maxActive) || (tried >= 8)) {
			break;
		}
		if (IsCoolingDown(terrainMgr->GetSectorIndex(c.pos), frame) || IsCovered(c.pos)) {
			continue;
		}
		++tried;
		SPatch patch;
		if (!BuildPatch(c.pos, patch)) {
			CoolDown(c.pos, terrainMgr->GetConvertStoP() * 0.5f, cooldownFrames);
			continue;
		}
		if (IsCovered(patch.center)) {
			continue;
		}
		CCircuitUnit* unit = PickUnit(patch.center, patch.radius);
		if (unit == nullptr) {
			// nobody may go (busy, too far, unsafe): ask again in two scans
			CoolDown(patch.center, patch.radius, GetScanInterval() * 2);
			continue;
		}
		CBRestoreTask* task = builderMgr->EnqueueRestore(patch.center, patch.radius, c.reason, FRAMES_PER_SEC * maxSeconds);
		active.push_back({task, patch.center, patch.radius});
		CoolDown(patch.center, patch.radius, cooldownFrames);
		const AIFloat3& upos = unit->GetPos(frame);
		circuit->LOG("RESTORE: start %s(%i) reason=%s at (%.0f, %.0f) r=%.0f cells=%i lava=%i depth=%.0f lavaLevel=%.0f from %.0f away",
				unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), ReasonName(c.reason),
				patch.center.x, patch.center.z, patch.radius, patch.cells, patch.lavaCells, patch.depth,
				(lavaLevel > -1e8f) ? lavaLevel : 0.f, std::sqrt(upos.SqDistance2D(patch.center)));
		builderMgr->AssignTask(unit, task);
		if (!task->IsDead() && task->GetAssignees().empty()) {
			builderMgr->AbortTask(task);  // the assignment was refused; TaskEnded drops it
		}
	}
}

void CRestoreControl::TaskEnded(CBRestoreTask* task, bool done, float seconds)
{
	auto it = std::find_if(active.begin(), active.end(), [task](const SActive& a) { return a.task == task; });
	if (it == active.end()) {
		return;
	}
	if (done) {
		++restored;
	} else {
		++failed;
	}
	circuit->LOG("RESTORE: %s reason=%s at (%.0f, %.0f) r=%.0f seconds=%.1f (restored %i, failed %i)",
			done ? "done" : "aborted", ReasonName(task->GetReason()), it->pos.x, it->pos.z, it->radius, seconds,
			restored, failed);
	active.erase(it);
}

} // namespace circuit
