/*
 * RestoreControl.h
 *
 * Terrain restore (owner 2026-10-31). Finds ground that weapons dug or raised
 * against the heightmap read at game start (nuke and commander craters, and the
 * lava that fills a crater below a lava map's level) and sends one eligible
 * builder per patch to restore it with the engine's CMD_RESTORE.
 *
 * Where it looks: our base (behaviour.json restore.base_radius), sites a task
 * could not build on (RequestSite, e.g. a cratered metal spot), sites the
 * script asks for, crater lava under our own ground units, and our attack
 * paths (restore.path): around our ground army and along the line from the
 * base to each unit, a crater that is now steeper than a vehicle can climb
 * (restore.path_slope, Thor's 33 degrees, or the unit's own limit when lower)
 * where the ground was not, or crater lava.
 *
 * Cost: one scan per restore.interval seconds. Damage per sector is computed
 * by the terrain worker inside its existing 10 s heightmap diff (changed
 * sectors only), so a scan reads the sectors inside the base radius (a few
 * thousand floats), and only a candidate patch reads its height cells
 * (at most 51x51). Nothing runs per frame. Commands: one restore order per
 * patch, at most restore.max_active at once.
 */

#ifndef SRC_CIRCUIT_MODULE_RESTORECONTROL_H_
#define SRC_CIRCUIT_MODULE_RESTORECONTROL_H_

#include "AIFloat3.h"
#include "terrain/TerrainManager.h"

#include <map>
#include <set>
#include <vector>

namespace Json {
	class Value;
}

namespace circuit {

class CCircuitAI;
class CCircuitUnit;
class CCircuitDef;
class CBRestoreTask;

class CRestoreControl final {
public:
	enum Reason: int {BASE = 0, SITE = 1, LAVA = 2, SCRIPT = 3, PATH = 4};

	CRestoreControl(CCircuitAI* circuit);
	~CRestoreControl();

	void ReadConfig(const Json::Value& root);
	int GetScanInterval() const;  // frames
	void Scan();

	bool IsEnabled() const { return enabled; }
	// The unit's class is allowed (restore.units) and its def can restore
	bool IsEligible(CCircuitUnit* unit) const;
	// A place we want to build on: restore it on the next scan when it is
	// damaged. True when the request was taken.
	bool RequestSite(const springai::AIFloat3& pos, float radius, int reason);

	float GetLavaLevel() const;  // the BAR lava gadget's level; very low when the map has none
	float GetDamageThreshold() const { return threshold; }
	float GetLavaMargin() const { return lavaMargin; }

	void TaskEnded(CBRestoreTask* task, bool done, float seconds);
	// A restorer went away mid-patch (killed or taken): the whole patch area
	// (radius + 64) backs off, so the crater is not re-sent at a shifted centre.
	void Lost(const springai::AIFloat3& pos, float radius, bool killed);
	// Restorer class bit (commander, t1 ground, t2, rez, air); a patch's
	// restorers are all of one class, at most restore.max_per_task of them
	unsigned ClassOf(const CCircuitUnit* unit) const;
	int GetMaxPerTask() const { return maxPerTask; }
	bool IsProtected() const { return protect; }
	// Live heights in the square, our and allied structures' pads skipped,
	// every 2nd cell (at most 26x26 engine reads for the 200 cap).
	CTerrainManager::STerrainDamage MeasureLive(const springai::AIFloat3& pos, float radius);
	// Fewer than min_cells in the every-2nd-cell sample (about 4x min_cells
	// cells): a residue the engine leaves at corners, too small to start on
	bool IsRestored(const CTerrainManager::STerrainDamage& damage) const { return damage.cells < minCells; }

private:
	struct SPatch {
		springai::AIFloat3 center;
		float radius;
		int cells;
		int lavaCells;
		float depth;
	};
	bool BuildPatch(const springai::AIFloat3& nearPos, SPatch& patch);
	CTerrainManager::STerrainDamage Measure(const springai::AIFloat3& pos, float radius, bool live, int step);
	// Spots tried before: each start or loss doubles the spot's wait from
	// restore.cooldown up to restore.retry_cap; restore.max_tries starts in a
	// row put it straight on the cap. A real restore (3 s+) clears the count.
	struct SSpot {
		springai::AIFloat3 pos;
		int tries;
		int until;     // frame
		float radius;  // matches within it (64; the patch + 64 after a loss)
	};
	SSpot& Spot(const springai::AIFloat3& pos);
	bool IsSpotHeld(const springai::AIFloat3& pos, int frame) const;
	void HoldSpot(const springai::AIFloat3& pos, float radius, float spotRadius = 64.f);
	// classMask: restorer classes allowed; front: no commander, and the line
	// from the unit to the patch must be free of threat for that unit
	CCircuitUnit* PickUnit(const springai::AIFloat3& pos, float radius, float maxDist, bool front,
			unsigned classMask, int* threatSkips);
	// A known, finished, armed enemy structure reaches pos (its weapon range
	// against ground or air plus restore.porc_margin)
	bool IsPorcCovered(const springai::AIFloat3& pos, bool air) const;
	bool IsLineSafe(CCircuitUnit* unit, const springai::AIFloat3& to) const;
	void TryJoin(CBRestoreTask* task, const springai::AIFloat3& pos, float radius, int reason, unsigned cls);
	void FindPathSectors(const springai::AIFloat3& basePos, float lavaLevel, std::vector<int>& out);
	bool IsCovered(const springai::AIFloat3& pos) const;
	bool IsCoolingDown(int sector, int frame) const;
	void CoolDown(const springai::AIFloat3& pos, float radius, int frames);
	void ClearCoolDown(const springai::AIFloat3& pos, float radius);
	int UnitClass(const CCircuitDef* cdef) const;

	CCircuitAI* circuit;

	bool enabled = false;
	unsigned allowMask = 0;  // 1 commander, 2 T1 builder, 4 T2+ builder, 8 resurrector
	float threshold = 12.f;   // elmos off the original height that count as damage
	int minCells = 6;         // damaged height cells (8x8 elmos) a patch needs
	float baseRadius = 1500.f;
	int maxActive = 2;
	float reach = 2500.f;     // builders further than this are not sent
	bool lava = true;
	float lavaMargin = 4.f;   // the original ground must stand this far above the lava
	int interval = 10;        // seconds between scans
	int maxSeconds = 90;      // a restore not finished by then is aborted
	int cooldownSeconds = 60; // a patch tried (or found too small) is left alone this long
	float busyPenalty = 800.f;// distance added for a builder that is constructing
	bool path = true;         // restore craters and crater lava on our attack paths
	float pathRadius = 400.f; // around each ground army unit; half of it along base -> unit
	float pathSlope = 0.161f; // 1 - cos(33 deg): steeper than this blocks a Thor
	float pathReach = 4000.f; // builders sent this far for a path patch
	int pathUnits = 300;      // ground army units looked at per scan
	int pathMemory = 300;     // seconds a sector the army stood on or passed stays on our paths
	bool pathLane = true;     // this AI's front lane (FRONT, D-127) counts as our path too
	std::vector<int> pathSeen;     // sector -> last frame on our paths, -1 never
	std::vector<float> pathLimit;  // sector -> lowest slope limit seen there within the memory
	int maxTries = 3;         // starts at one spot before it waits retry_cap
	int retryCapSeconds = 600;// the longest a tried spot waits
	bool protect = true;      // a restorer keeps its patch against ordinary builder tasks
	int maxPerTask = 2;       // restorers per patch, all of one class
	float porcMargin = 100.f; // elmos beyond an enemy static weapon's range a front patch must be
	int baseSeenFrame = -1;   // last scan that had base/site work: PATH leaves it a slot
	std::vector<SSpot> spots; // at most 64, the oldest dropped
	std::vector<char> blocked;// structure mask scratch, reused

	struct SActive {
		CBRestoreTask* task;
		springai::AIFloat3 pos;
		float radius;
		int reason;
		unsigned cls;  // the restorers' class
	};
	std::vector<SActive> active;
	struct SRequest {
		springai::AIFloat3 pos;
		float radius;
		int reason;
		int frame;
	};
	std::vector<SRequest> requests;
	std::map<int, int> cooldown;  // sector index -> frame it may be tried again
	mutable std::map<int, int> unitClass;  // def id -> class bit (0: never)
	int restored = 0;
	int failed = 0;
	int lostKilled = 0;
	int lostTaken = 0;
};

} // namespace circuit

#endif // SRC_CIRCUIT_MODULE_RESTORECONTROL_H_
