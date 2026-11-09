#ifndef SRC_CIRCUIT_TERRAIN_REACHDESTINATION_H_
#define SRC_CIRCUIT_TERRAIN_REACHDESTINATION_H_

#include "AIFloat3.h"
#include <cmath>

namespace circuit {
// D-314 / KI-591: reject before float-to-int conversion, threat/influence
// indexing or the flying-unit shortcut. An index-only guard lets x wrap into
// an adjacent row. These O(1) checks allocate nothing and do not clamp a bad
// request into a different job. Actual-VM coverage: run_terrain_reachability.py.
// Shared by TerrainManager.cpp and FactoryDistricts.cpp (D-451 split).
inline bool ValidReachDestination(const springai::AIFloat3& p, float range = 0.f) {
	return std::isfinite(p.x) && std::isfinite(p.y) && std::isfinite(p.z)
		&& p.x >= 0.f && p.z >= 0.f
		&& p.x < springai::AIFloat3::maxxpos && p.z < springai::AIFloat3::maxzpos
		&& std::isfinite(range) && range >= 0.f;
}
} // namespace circuit

#endif // SRC_CIRCUIT_TERRAIN_REACHDESTINATION_H_
