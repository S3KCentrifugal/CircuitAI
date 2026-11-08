// Factory districts, clusters and the builder travel preview (D-440..D-445,
// D-452, D-454). Split from TerrainManager.cpp (A3); same class, same state.
#include "terrain/TerrainManager.h"
#include "terrain/FactoryDistrictGeometry.h"
#include "terrain/BuildTravelBudget.h"
#include "terrain/TerrainCorridor.h"
#include "terrain/TerrainData.h"
#include "terrain/ReachDestination.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/PathQuery.h"
#include "map/ThreatMap.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "WeaponDef.h"
#include "MoveData.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <memory>
#include <unordered_set>

namespace circuit {
using namespace springai;
namespace {
constexpr float kHalfCell = float(base_layout::HALF_CELL_ELMOS);  // layout half-cell, elmos
constexpr int kCellElmos = base_layout::CELL_ELMOS;                // blocking-map cell, elmos
// Departure probe: this many half-cells beyond the factory's exit lane.
constexpr int kExitDepartureExtraHalfCells = 8;
// A builder stops this far inside its build range (engine tolerance).
constexpr float kBuildRangeMargin = 16.f;
constexpr float kMaxFactoryTravelSeconds = 10.f;  // planning walk budget cap
constexpr int kMaxSupportRows = 8;  // ResizeSupportBank's own limit
constexpr int kSpeedModClassHover = 2;
// D-459: the slot search no longer walk-tests; these keys from earlier saves
// are erased on load and never written.
constexpr const char* kRetiredTravelKey = "policy.layout.factory_travel_ms";
constexpr const char* kLegacyTravelKey = "policy.layout.travel_ms";        // PR #51 builds
constexpr const char* kLegacyFactoryRequiredKey = "policy.layout.factory_required";

base_layout::Footprint FootprintOf(const CCircuitDef* def)
{
	return base_layout::Footprint{def->GetDef()->GetXSize() / 2, def->GetDef()->GetZSize() / 2};
}
base_layout::Point HalfCellOf(const AIFloat3& pos)
{
	return {int(std::round(pos.x / kHalfCell)), int(std::round(pos.z / kHalfCell))};
}
}

bool CTerrainManager::ReleaseUnusedLayout(const std::string& name)
{
	if (name.empty()) return false;
	const std::string prefix = name + ".";
	// Lifecycle-only cleanup, O(named groups + reservations). Never revoke a
	// task's claim or completed support when adopting an ordinary factory.
	std::unordered_set<int> groups;
	for (const auto& entry : layoutGroups) {
		if (entry.first.rfind(prefix, 0) == 0) groups.insert(entry.second);
	}
	for (const auto& entry : reservations) {
		const auto& r = entry.second;
		if (groups.count(r.group) && (r.claimed || r.consumed || r.unitId != 0)) return false;
	}
	ReleaseLayoutPrefix(prefix);
	return true;
}

void CTerrainManager::SetFactoryFacingGoal(const AIFloat3& goal)
{
	// Script policy; a point off the map (or x < 0) switches the rule off.
	const bool valid = std::isfinite(goal.x) && std::isfinite(goal.z) && geom::is_in_map(goal);
	factoryFacingGoal = valid ? AIFloat3(goal.x, 0.f, goal.z) : AIFloat3(-1.f, 0.f, -1.f);
	SavePlacementPolicy();
}

void CTerrainManager::SavePlacementPolicy()
{
	layoutInts[kFactoryActivateKey] = factoryReservationOnActivate ? 1 : 0;
	layoutInts[kFactoryFlushKey] = factoryFlushPacking ? 1 : 0;
	layoutInts[kFactoryDirectKey] = factoryDirectSite ? 1 : 0;
	layoutInts[kFacingGoalXKey] = int(factoryFacingGoal.x);
	layoutInts[kFacingGoalZKey] = int(factoryFacingGoal.z);
}

void CTerrainManager::LoadPlacementPolicy()
{
	// Older saves wrote a slot-search travel budget and one combined
	// "required" flag.
	const bool legacyRequired = GetLayoutInt(kLegacyFactoryRequiredKey, 1) != 0;
	factoryReservationOnActivate = GetLayoutInt(kFactoryActivateKey, legacyRequired) != 0;
	factoryFlushPacking = GetLayoutInt(kFactoryFlushKey, legacyRequired) != 0;
	factoryDirectSite = GetLayoutInt(kFactoryDirectKey, legacyRequired) != 0;
	const AIFloat3 goal(float(GetLayoutInt(kFacingGoalXKey, -1)), 0.f, float(GetLayoutInt(kFacingGoalZKey, -1)));
	factoryFacingGoal = (goal.x >= 0.f && goal.z >= 0.f && geom::is_in_map(goal)) ? goal : AIFloat3(-1.f, 0.f, -1.f);
	layoutInts.erase(kLegacyTravelKey);
	layoutInts.erase(kRetiredTravelKey);
	layoutInts.erase(kLegacyFactoryRequiredKey);
	SavePlacementPolicy();
}

bool CTerrainManager::FactoryExitUsable(const base_layout::FactoryCluster& cluster, CCircuitDef* factory)
{
	if (!cluster.valid || !factory) return false;
	const auto& facts = FactoryMovementFacts(factory);
	if (facts.empty()) return false;
	const auto& slot = cluster.factory;
	const int depth = base_layout::Along(slot.footprint, slot.facing);
	const auto entrance = base_layout::Offset(slot.centre, slot.facing, depth, 0);
	const auto departure = base_layout::Offset(slot.centre, slot.facing,
		depth + 2 * base_layout::FACTORY_EXIT_DEPTH + kExitDepartureExtraHalfCells, 0);
	const AIFloat3 from(entrance.x2 * kHalfCell, 0.f, entrance.z2 * kHalfCell);
	const AIFloat3 to(departure.x2 * kHalfCell, 0.f, departure.z2 * kHalfCell);
	return FactoryExitTerrainUsable(facts, from, to);
}

const std::vector<CTerrainManager::ExitMovementFacts>& CTerrainManager::FactoryMovementFacts(CCircuitDef* factory)
{
	auto [it, inserted] = factoryExitFacts.try_emplace(factory->GetId());
	auto& facts = it->second;
	if (inserted) for (const auto id : factory->GetBuildOptions()) {
		auto* product = circuit->GetCircuitDef(id);
		if (!product || !product->IsMobile() || product->GetDef()->IsAbleToFly()) continue;
		const std::unique_ptr<MoveData> move(product->GetDef()->GetMoveData());
		if (!move || move->GetSpeedModClass() > kSpeedModClassHover || product->GetMobileId() < 0) continue;
		const bool hover = move->GetSpeedModClass() == kSpeedModClassHover;
		const float half = std::max(move->GetXSize(), move->GetZSize()) * SQUARE_SIZE * .5f;
		auto same = std::find_if(facts.begin(), facts.end(), [&](const auto& f) { return f.mobile == product->GetMobileId(); });
		if (same == facts.end()) facts.push_back({product->GetMobileId(), half, move->GetMaxSlope(),
			hover ? std::numeric_limits<float>::max() : move->GetDepth(), hover});
		else same->halfWidth = std::max(same->halfWidth, half);
	}
	return facts;
}

bool CTerrainManager::FactoryExitTerrainUsable(const std::vector<ExitMovementFacts>& facts, const AIFloat3& from, const AIFloat3& to)
{
	if (!ValidReachDestination(from) || !ValidReachDestination(to)) return false;
	const auto& slopes = terrainData->GetSlopeMap();
	const int slopeWidth = terrainData->GetSlopeMapXSize();
	const auto height = [&](float x, float z) {
		return ValidReachDestination({x, 0.f, z}) ? areaData->GetElevationAt(x, z)
			: std::numeric_limits<float>::quiet_NaN();
	};
	const auto slope = [&](float x, float z) {
		if (!ValidReachDestination({x, 0.f, z})) return std::numeric_limits<float>::quiet_NaN();
		const int px = int(x / kCellElmos), pz = int(z / kCellElmos);
		const auto index = std::size_t(pz) * slopeWidth + px;
		if (index >= slopes.size() || !blockingMap.IsInBounds(px, pz)) return std::numeric_limits<float>::quiet_NaN();
		const auto& cell = blockingMap.grid[pz * blockingMap.columns + px];
		if (cell.blockerMask != 0 || static_cast<unsigned>(cell.structMask) != 0) return std::numeric_limits<float>::infinity();
		return slopes[index];
	};
	// Startup/extension admission only: distinct production move classes and
	// a short fine-grid corridor. No whole-map path solve or recurring scan.
	for (const auto& f : facts) {
		const auto* mobile = GetMobileTypeById(f.mobile);
		const int a = GetSectorIndex(from), b = GetSectorIndex(to);
		if (!mobile || a < 0 || b < 0 || a >= int(mobile->sector.size()) || b >= int(mobile->sector.size())
			|| !mobile->sector[a].area || mobile->sector[a].area != mobile->sector[b].area) return false;
		const auto movementSlope = [&](float x, float z) {
			const float value = slope(x, z);
			return f.hover ? base_layout::FactoryExitSlope(height(x, z), value, true) : value;
		};
		if (!lane::TerrainCorridor(from.x, from.z, to.x, to.z, f.halfWidth, f.slope, f.depth, false, height, movementSlope)) return false;
	}
	return true;
}

float CTerrainManager::GetBuildingBlastRadius(const CCircuitDef* def) const
{
	if (!def) return 0.f;
	const auto known = buildingBlastRadii.find(def->GetId());
	if (known != buildingBlastRadii.end()) return known->second;
	const std::unique_ptr<WeaponDef> death(def->GetDef()->GetDeathExplosion());
	const float radius = death ? std::max(0.f, death->GetAreaOfEffect()) : 0.f;
	buildingBlastRadii.emplace(def->GetId(), radius);
	return radius;
}

int CTerrainManager::ReserveIsolatedBuilding(const std::string& name, CCircuitDef* def,
		const AIFloat3& pos, int facing, const std::string& protectedPrefix, float margin)
{
	if (name.empty() || protectedPrefix.empty() || !def || !std::isfinite(margin) || margin < 0.f
		|| !CanReserveBuilding(def, pos, facing)) return -1;
	const auto snapped = Pos2BuildPos(def, pos, facing);
	const float radius = GetBuildingBlastRadius(def) + margin;
	const auto candidateRect = base_layout::RectFromCentre(HalfCellOf(snapped), FootprintOf(def), facing);
	std::unordered_set<int> protectedGroups;
	const std::string prefix = protectedPrefix + ".";
	for (const auto& group : layoutGroups)
		if (group.first.rfind(prefix, 0) == 0) protectedGroups.insert(group.second);
	for (const auto& [id, r] : reservations) {
		if (!protectedGroups.count(r.group)) continue;
		const auto rect = base_layout::RectFromCentre(HalfCellOf(r.pos), FootprintOf(r.def), r.facing);
		if (!base_layout::OutsideBlast(snapped.x, snapped.z, rect, radius)
			|| !base_layout::OutsideBlast(r.pos.x, r.pos.z, candidateRect, GetBuildingBlastRadius(r.def) + margin)) return -1;
	}
	return ReserveBuilding(def, snapped, facing, 0, EnsureLayoutGroup(name));
}

int CTerrainManager::PlanFactoryCluster(const std::string& name, CCircuitDef* factory,
		CCircuitDef* nano, const AIFloat3& centre, int facing, int columns, int rows)
{
	if (!layoutEnabled || name.empty() || !factory || !nano || facing < 0 || facing > 3
		|| !geom::is_in_map(centre)) return -1;
	const int existing = GetLayoutInt(name + ".factory_slot", -1);
	if (reservations.count(existing)) return existing;
	const auto snapped = Pos2BuildPos(factory, centre, facing);
	auto cluster = base_layout::MakeFactoryCluster(HalfCellOf(snapped), facing,
		FootprintOf(factory), FootprintOf(nano), base_layout::FactoryTier::T1);
	if (!base_layout::ResizeSupportBank(cluster, FootprintOf(nano), columns, rows, nano->GetBuildDistance())) return -1;
	if (!FactoryExitUsable(cluster, factory)) return -1;
	int id = -1;
	return ReserveFactoryCluster(name, cluster, factory, nano, id) ? id : -1;
}

int CTerrainManager::PlanFactoryDistrict(const std::string& name, CCircuitDef* firstFactory,
		CCircuitDef* secondFactory, CCircuitDef* nanoDef, const AIFloat3& rear,
		int facing, int maxRows, bool allowCompact, CCircuitUnit* builder, float travelSeconds)
{
	if (!layoutEnabled || name.empty() || !firstFactory || !secondFactory || !nanoDef
		|| !geom::is_in_map(rear) || maxRows < 1) return 0;
	if (HasLayoutGroup(name + ".t1.factory")) return GetLayoutInt(name + ".capacity", 1);
	const base_layout::Point origin = HalfCellOf(rear);
	// B6: the factory centres do not depend on the support rows, since
	// ResizeSupportBank only re-lays the banks behind them. Exit and travel
	// are tested once per site (-1 = not tested yet) and kept across rows;
	// the rows are still tried from most to fewest, as the script did.
	int firstExit = -1, secondExit = -1, travel = -1;
	// D-459: the opening builder's walk is tested here only, once per site.
	const float budget = std::isfinite(travelSeconds) ? std::clamp(travelSeconds, 0.f, kMaxFactoryTravelSeconds) : 0.f;
	for (int rows = std::min(maxRows, kMaxSupportRows); rows >= 1; --rows) {
		const auto pair = base_layout::MakeFactoryDistrict(origin, facing, FootprintOf(firstFactory),
			FootprintOf(secondFactory), FootprintOf(nanoDef), rows, rows,
			base_layout::FACTORY_EXIT_MARGIN * 2, nanoDef->GetBuildDistance());
		if (!pair.valid || !CanReserveFactoryCluster(pair.first, firstFactory, nanoDef)) continue;
		if (firstExit < 0) firstExit = FactoryExitUsable(pair.first, firstFactory) ? 1 : 0;
		if (firstExit == 0) return 0;
		// Preview only: do not commit an attractive but inaccessible opening bay.
		// The borrowed builder is used synchronously and never retained.
		if (travel < 0) {
			const AIFloat3 firstPos(pair.first.factory.centre.x2 * kHalfCell, 0.f, pair.first.factory.centre.z2 * kHalfCell);
			travel = (!builder || budget <= 0.f || WithinBuildTravel(builder, firstPos, budget)) ? 1 : 0;
		}
		if (travel == 0) return 0;
		bool expandable = CanReserveFactoryCluster(pair.second, secondFactory, nanoDef);
		if (expandable) {
			if (secondExit < 0) secondExit = FactoryExitUsable(pair.second, secondFactory) ? 1 : 0;
			expandable = secondExit != 0;
		}
		if (!expandable && !allowCompact) continue;
		int firstId = -1, secondId = -1;
		if (!ReserveFactoryCluster(name + ".t1", pair.first, firstFactory, nanoDef, firstId)
			|| (expandable && !ReserveFactoryCluster(name + ".t2", pair.second, secondFactory, nanoDef, secondId))) {
			ReleaseLayoutPrefix(name + ".");
			continue;
		}
		layoutInts[name + ".capacity"] = expandable ? 2 : 1;
		layoutInts[name + ".facing"] = facing;
		layoutInts[name + ".rows"] = rows;
		layoutInts[name + ".t1_slot"] = firstId;
		layoutInts[name + ".t2_slot"] = secondId;
		return expandable ? 2 : 1;
	}
	return 0;
}

bool CTerrainManager::WithinBuildTravel(CCircuitUnit* builder, const AIFloat3& site, float seconds)
{
	if (!builder || !(seconds > 0.f)) return false;
	auto* def = builder->GetCircuitDef();
	const auto from = builder->GetPos(circuit->GetLastFrame());
	const float range = std::max(0.f, def->GetBuildDistance() - kBuildRangeMargin);
	const float budget = def->GetSpeed() * seconds;
	if (from.SqDistance2D(site) > SQUARE(range + budget)) return false;
	if (!CanReachAtSafe(builder, site, range)) return false;
	if (from.SqDistance2D(site) <= range * range) return true;
	auto* pathfinder = circuit->GetPathfinder();
	// Borrow current mobility/threat arrays synchronously; no worker or cached
	// unit pointer. The local search is bounded (BuildTravelBudget.h).
	const auto query = pathfinder->CreatePathSingleQuery(builder, circuit->GetThreatMap(), from, site, range);
	return build_travel::Within(site.x - from.x, site.z - from.z, range, budget, [&](float dx, float dz) {
		const AIFloat3 p(from.x + dx, from.y, from.z + dz);
		int px, pz;
		pathfinder->Pos2PathXY(p, &px, &pz);
		if (!geom::is_in_map(p) || !pathfinder->IsInPathMap(px, pz)) return false;
		const auto move = reinterpret_cast<std::size_t>(pathfinder->Pos2MoveNode(p));
		if (!query->GetCanMoveArray()[move]
			|| query->GetThreatFun()(pathfinder->Pos2PathIndex(p)) > THREAT_MIN) return false;
		if (def->IsAbleToFly()) return true;
		const int hx = (def->GetDef()->GetXSize() + 1) / 2;
		const int hz = (def->GetDef()->GetZSize() + 1) / 2;
		for (int z = int((p.z - hz * SQUARE_SIZE) / kCellElmos); z <= int((p.z + hz * SQUARE_SIZE) / kCellElmos); ++z)
			for (int x = int((p.x - hx * SQUARE_SIZE) / kCellElmos); x <= int((p.x + hx * SQUARE_SIZE) / kCellElmos); ++x) {
				if (!blockingMap.IsInBounds(x, z)) return false;
				const auto& cell = blockingMap.grid[z * blockingMap.columns + x];
				if (build_travel::PhysicalBlock(cell.blockerMask, static_cast<unsigned>(cell.structMask),
						static_cast<unsigned>(SBlockingMap::StructMask::RESERVED))) return false;
			}
		return true;
	});
}

} // namespace circuit
