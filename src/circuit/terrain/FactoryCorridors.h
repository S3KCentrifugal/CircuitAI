/*
 * FactoryCorridors.h
 *
 * D-440..D-451: the protected road from a ground factory's mouth to a FRONT
 * lane. Owned by value by CTerrainManager, which stays the only caller; this
 * class owns every corridor record, lane copy, probe budget, terrain cache and
 * the named-state keys it saves. Role policy (who uses corridors, which factory
 * is exempt, how many probes) is supplied by script and JSON.
 */

#ifndef SRC_CIRCUIT_TERRAIN_FACTORYCORRIDORS_H_
#define SRC_CIRCUIT_TERRAIN_FACTORYCORRIDORS_H_

#include "terrain/AlliedReservations.h"
#include "terrain/FactoryCorridor.h"
#include "System/type2.h"
#include "AIFloat3.h"

#include <cstdint>
#include <map>
#include <memory>
#include <set>
#include <string>
#include <unordered_map>
#include <vector>

namespace circuit {

class CCircuitDef;
class CTerrainManager;

class CFactoryCorridors final {
public:
	// Script/JSON levers (factory_corridors in coverage.json). Defaults keep
	// the played D-440 values; the background budget is new (D-451, B4).
	struct SOptions {
		int liveProbes = 4;          // planning probes per frame for real placement asks
		int backgroundProbes = 1;    // probes per frame for the lane-change refresh job
		int visits = 32768;          // Dijkstra node budget per probe
		float goalStart = 768.f;     // lane distance (elmos) where connection goals begin
		float goalEnd = 2048.f;      // lane distance (elmos) where connection goals end
		float laneWaitSeconds = 30.f; // after this, real construction may proceed unrouted
	};

	explicit CFactoryCorridors(CTerrainManager& terrain) : terrain(terrain) {}
	CFactoryCorridors(const CFactoryCorridors&) = delete;
	CFactoryCorridors& operator=(const CFactoryCorridors&) = delete;

	void SetPolicy(bool enabled, bool ownLane);
	void SetExemptDef(int def);
	void SetOptions(const SOptions& options);
	void SetLane(int team, const std::vector<springai::AIFloat3>& points);
	// D-460 (KI-744): this AI's lane road, reserved past goalStart along
	// `points` (script supplies the length), as wide as widthDef's exit. Empty clears.
	void SetRoad(const std::vector<springai::AIFloat3>& points, CCircuitDef* widthDef);

	// planning: a reservation preview, which may proceed before a lane exists.
	bool Ensure(CCircuitDef* def, const springai::AIFloat3& pos, int facing, bool planning = false);
	bool Blocked(const int2& a, const int2& b) const { return coverage.OverlapsOther(-1, {a.x, a.y, b.x, b.y}); }
	bool IsEnabled() const { return enabled; }

	// Lifecycle events from the terrain manager; never polled.
	void ObserveFactory(int unitId, CCircuitDef* def, const springai::AIFloat3& pos, int facing, bool isT1);
	void ForgetFactory(int unitId);
	void TaskClaimed(int claim) { tasks.insert(claim); }
	void TaskReleased(int claim);
	void ReservationErased();

	void Describe(std::string& out) const;
	void OnLayoutReset();  // after the named-state map is cleared
	void Clear();          // before load: release shared claims
	void Load();           // after the named-state map is loaded

	// Exit-claim id shared by the claim store and the layout description.
	static int ExitClaimId(int routeId, int segment);

private:
	struct SRoute {
		int id = 0, def = -1, facing = 0;
		int lane = -1;           // goal team, -1 while unconnected or invalidated
		int retry = 0;           // frame before which a failed re-plan is not retried
		int graceUntil = 0;      // frame until which an unclaimed new route is kept
		std::uint64_t checkedPacking = 0, checkedHeight = 0;  // B3: last clear validation
		springai::AIFloat3 pos;
		std::vector<allied_layout::Rect> rectangles;
	};
	struct SFailedSite { int def, facing, retry; springai::AIFloat3 pos; };
	struct SFactorySite { int def, facing; springai::AIFloat3 pos; };
	struct SRequest { int def, facing; springai::AIFloat3 pos; };
	// B1: static terrain admission per factory definition, two bits per
	// blocking cell, filled lazily and dropped when the heights change.
	struct STerrainCache {
		std::uint64_t height = 0;
		std::vector<std::uint64_t> known, open;
	};

	bool EnsureImpl(CCircuitDef* def, const springai::AIFloat3& pos, int facing, bool planning, bool background);
	// Fill the blocked/reused scratch for a window: allied and own plans,
	// structures, own roads (passable) and per-cell terrain. O(window cells).
	void PaintWindow(const allied_layout::Rect& window, int defId);
	int Clearance(CCircuitDef* def) const;  // cells; 0 when the def has no ground exit
	void ShareRects(int routeId, const std::vector<allied_layout::Rect>& rectangles, bool add);
	static void SaveRects(std::map<std::string, int>& ints, const std::string& key, const std::vector<allied_layout::Rect>& rectangles);
	bool LoadRects(const std::string& key, int count, std::vector<allied_layout::Rect>& out) const;
	bool TerrainOpen(int x, int z, int def);
	bool CellOpen(int x, int z, int def);
	bool RouteClear(SRoute& route, int def);
	bool HasLane() const;
	void Share(const SRoute& route, bool add) { ShareRects(route.id, route.rectangles, add); }
	void Save();
	void SaveOptions();
	void Prune();
	void QueuePrune();
	void QueueRefresh();
	void DrainRefresh();
	int ProbeBudget(bool background) const;
	void Invalidate(SRoute& route) { route.lane = -1; route.retry = 0; route.checkedPacking = 0; }

	CTerrainManager& terrain;
	SOptions options;
	bool enabled = false, ownLane = false;
	int exemptDef = -1;
	int enabledFrame = -1;        // C1: lane wait counts from the frame corridors were enabled
	bool unroutedLogged = false;
	int nextId = 1;
	int probeFrame = -1, liveProbesUsed = 0, backgroundProbesUsed = 0;
	std::map<int, SRoute> routes;
	std::vector<allied_layout::Rect> road;  // D-460: claim ids ExitClaimId(kRoadId, i)
	int windowW = 0, windowH = 0;  // size of the last PaintWindow raster
	std::map<int, std::vector<springai::AIFloat3>> lanes;
	std::map<int, SFactorySite> factories;  // standing factories by unit id
	std::vector<SFailedSite> failed;
	std::set<int> tasks;
	allied_layout::CoverageIndex coverage;
	std::unordered_map<int, STerrainCache> terrainCache;
	std::vector<SRequest> refresh;
	bool refreshQueued = false, pruneQueued = false;
	std::shared_ptr<int> lifetime = std::make_shared<int>(0);
	// Scratch reused by every probe (B1): no per-probe allocation once grown.
	std::vector<std::uint8_t> blocked, reused, allyZones, allyExits, reuse, goals, open;
	std::vector<int> owners, sums;
	factory_corridor::ConnectScratch connect;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TERRAIN_FACTORYCORRIDORS_H_
