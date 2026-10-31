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
 * script asks for, and crater lava under our own ground units.
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
	enum Reason: int {BASE = 0, SITE = 1, LAVA = 2, SCRIPT = 3};

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

private:
	struct SPatch {
		springai::AIFloat3 center;
		float radius;
		int cells;
		int lavaCells;
		float depth;
	};
	bool BuildPatch(const springai::AIFloat3& nearPos, SPatch& patch);
	CCircuitUnit* PickUnit(const springai::AIFloat3& pos, float radius);
	bool IsCovered(const springai::AIFloat3& pos) const;
	bool IsCoolingDown(int sector, int frame) const;
	void CoolDown(const springai::AIFloat3& pos, float radius, int frames);
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

	struct SActive {
		CBRestoreTask* task;
		springai::AIFloat3 pos;
		float radius;
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
};

} // namespace circuit

#endif // SRC_CIRCUIT_MODULE_RESTORECONTROL_H_
