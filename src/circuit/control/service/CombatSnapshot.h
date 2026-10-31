#pragma once
// D-389: one picture of the enemy per side (ally team), rebuilt once a second
// by the side's owner AI and read by every AI and controller on it.
//
// Members are the side's enemy records (CEnemyManager) that are in sight, on
// radar, or *remembered*: CMapManager keeps an enemy after it leaves sight and
// only marks it hidden once its last known position is back in sight and it
// is not there. So a unit that walked into fog, or under an enemy jammer, is
// assumed to still be where it was last seen until the area is re-explored.
// The snapshot records when each enemy was last observed (the engine-side
// lastSeen is only set on leaving radar) so readers can widen its position
// by speed x age.
//
// Costs: Rebuild O(E) for E enemy records, once a second per side; Query
// O(cells + K) for K members in the touched cells. Buckets are cleared only
// where the last rebuild wrote. Engine callback thread only.

#include "control/kernel/CommanderCombat.h"

#include <algorithm>
#include <cmath>
#include <unordered_map>
#include <vector>

namespace circuit {
class CCircuitAI;

class CCombatSnapshot final {
public:
	struct Entry {
		int id = -1;
		int defId = -1;        // -1: a radar blip of unknown type
		commander::Point pos;  // last known position
		int lastObserved = 0;  // frame it was last in sight or on radar
		bool los = false, radar = false;
		float speed = 0.f;     // immutable definition speed; unknown blips use BLIP_SPEED
		float elevation = 0.f; // cached observed height, retained in fog (including aircraft)
		float landRange = 300.f; // published range; setters disable this broad phase
	};
	struct Disc { commander::Point center; float radius = 0.f; };

	static constexpr float CELL_SIZE = 512.f;           // elmos per bucket side
	static constexpr int REBUILD_FRAMES = 30;           // once a second
	static constexpr float BLIP_SPEED = 60.f;
	static constexpr float RADAR_ERROR = 64.f;

	// Strategic IGNORE does not make an attacker harmless. Callers distinguish
	// actual hidden/neutral/dead/fake records from profile and gadget exclusion.
	static bool Admit(bool unavailable, bool ignored, bool profileIgnored, bool gadgetExcluded) {
		return !unavailable && (!ignored || (profileIgnored && !gadgetExcluded));
	}

	// Built only while some reader wants it: a reader calls Want each update.
	static constexpr int WANT_FRAMES = 60;              // readers renew within two seconds
	void Want(int frame) const { wantedUntil = frame + WANT_FRAMES; }
	bool Due(int frame) const { return frame >= next && frame <= wantedUntil; }
	void Rebuild(CCircuitAI* ai, int frame);
	int Frame() const { return built; }

	// Conservative broad phase for the reader's uncertainty-aware distance
	// test. The maximum observed speed is accumulated once during Add, not
	// scanned per commander. Reset owns invalidation; tests/control_core_test.cpp
	// covers remembered contacts across bucket boundaries and stale snapshots.
	float QueryRadius(float radius, float memoryCap, float snapshotAge) const {
		return radius + std::max(memoryCap, maxObservedSpeed * std::max(0.f, snapshotAge)) + RADAR_ERROR;
	}

	// Visits every member whose bucket overlaps the square around center.
	template <class F>
	void Query(commander::Point center, float radius, F visit) const {
		if (cols <= 0 || rows <= 0) return;
		const int x0 = Cell(center.x - radius, cols), x1 = Cell(center.x + radius, cols);
		const int z0 = Cell(center.z - radius, rows), z1 = Cell(center.z + radius, rows);
		for (int z = z0; z <= z1; ++z)
			for (int x = x0; x <= x1; ++x)
				for (int index : buckets[z * cols + x]) visit(entries[index]);
	}
    // Conservative lane broad phase, retaining the original z/x/insertion order.
    // Bounds use actual contact positions (including clamped edge cells). Outside
    // the lane width movement prediction is zero; range + capped uncertainty
    // therefore bounds all possible contributors. O(grid buckets + candidates).
    // SetRange is a public script lever, and profiles may differ across AIs.
    // Once used anywhere in this DLL lifetime, retain the original full scan.
    // A monotone latch avoids stale bounds without adding per-AI refresh scans.
    static void InvalidateRangeBounds() { rangeBoundsValid=false; }
    template<class F> void QueryInfluencing(commander::Point lo, commander::Point hi, float padding, F visit) const {
        for(std::size_t b=0;b<buckets.size();++b) {
            if(buckets[b].empty()) continue;
            const auto& box=bounds[b];
            const double reach=double(padding)+box.range+1.0; // conservative float-rounding margin
            if(rangeBoundsValid && (double(box.hi.x)+reach<lo.x || double(box.lo.x)-reach>hi.x
                || double(box.hi.z)+reach<lo.z || double(box.lo.z)-reach>hi.z)) continue;
            for(int index:buckets[b]) visit(entries[index]);
        }
    }
	// Remembered enemy jammers: silence inside them is not evidence of absence.
	const std::vector<Disc>& EnemyJammers() const { return jammers; }
    const std::vector<Entry>& StrategicContacts() const { return strategic; }
    void AddStrategic(const Entry& entry) { strategic.push_back(entry); }

	// Engine-free building blocks, used by Rebuild and the unit test.
	void Reset(float mapWidth, float mapHeight) {
		const int c = std::max(1, int(std::ceil(mapWidth / CELL_SIZE)));
		const int r = std::max(1, int(std::ceil(mapHeight / CELL_SIZE)));
		if (c != cols || r != rows) {
			cols = c; rows = r;
			buckets.assign(std::size_t(cols) * rows, {});
			bounds.resize(buckets.size());
			touched.clear();
		} else {
			for (int b : touched) buckets[b].clear();
			touched.clear();
		}
		entries.clear();
		jammers.clear();
        strategic.clear();
		maxObservedSpeed = 0.f;
	}
	void Add(const Entry& entry) {
		if (cols <= 0 || rows <= 0) return;
		const int b = Cell(entry.pos.z, rows) * cols + Cell(entry.pos.x, cols);
		if (buckets[b].empty()) {
            touched.push_back(b);bounds[b]={entry.pos,entry.pos,entry.landRange};
        } else {
            auto& box=bounds[b];
            box.lo.x=std::min(box.lo.x,entry.pos.x);box.lo.z=std::min(box.lo.z,entry.pos.z);
            box.hi.x=std::max(box.hi.x,entry.pos.x);box.hi.z=std::max(box.hi.z,entry.pos.z);
            box.range=std::max(box.range,entry.landRange);
        }
		buckets[b].push_back(int(entries.size()));
		entries.push_back(entry);
		if (entry.los || entry.radar) maxObservedSpeed = std::max(maxObservedSpeed, entry.speed);
	}
	void AddJammer(const Disc& disc) { jammers.push_back(disc); }
	std::size_t Size() const { return entries.size(); }

private:
    inline static bool rangeBoundsValid=true; // simulation thread, module lifetime
	static int Cell(float coordinate, int count) {
		return std::clamp(int(std::floor(coordinate / CELL_SIZE)), 0, count - 1);
	}
	struct Bounds {commander::Point lo,hi;float range=0;};
    std::vector<Bounds> bounds;
	std::vector<Entry> entries;
	std::vector<std::vector<int>> buckets;
	std::vector<int> touched;            // buckets written by the last rebuild
	std::vector<Disc> jammers;
    std::vector<Entry> strategic; // known immobile long-range weapons, never hidden positions
	std::unordered_map<int, int> observed;   // enemy id -> last frame in sight or on radar
	std::unordered_map<int, float> jammerRadius;  // unit type -> jammer radius, cached
	int cols = 0, rows = 0, built = -1, next = 0;
	mutable int wantedUntil = -1;
	float maxObservedSpeed = 0.f;
};

} // namespace circuit
