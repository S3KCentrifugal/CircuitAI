/*
 * ConstructorBrace.h
 *
 * D-474: the engine-free rules of the constructor brace. A land constructor
 * that is damaged, or whose structure under construction is destroyed, steps
 * back from the threat and builds one defence between itself and the threat.
 * The manager (CBuilderManager) and the task (CBBraceTask) call these; nothing
 * here touches the engine, so tests/constructor_brace_test.cpp covers it.
 */

#ifndef SRC_CIRCUIT_CONTROL_KERNEL_CONSTRUCTORBRACE_H_
#define SRC_CIRCUIT_CONTROL_KERNEL_CONSTRUCTORBRACE_H_

#include <algorithm>
#include <cmath>

namespace circuit {
namespace brace {

struct Point { float x = 0.f, z = 0.f; };

// Below this length a vector has no usable direction.
constexpr float MIN_DIRECTION = 1.f;

inline float Length(Point p) { return std::sqrt(p.x * p.x + p.z * p.z); }

inline Point Normal(Point p)
{
	const float length = Length(p);
	return (length < MIN_DIRECTION) ? Point{} : Point{p.x / length, p.z / length};
}

// The unit vector from the constructor toward the threat. Order: the attacker
// (or the killer of the structure) when its position is known; otherwise the
// enemy lies ahead of the base, so base -> constructor; otherwise +z.
inline Point ThreatDirection(Point unit, bool hasThreat, Point threat, Point base)
{
	if (hasThreat) {
		const Point toward = Normal(Point{threat.x - unit.x, threat.z - unit.z});
		if (Length(toward) > 0.f) {
			return toward;
		}
	}
	const Point ahead = Normal(Point{unit.x - base.x, unit.z - base.z});
	return (Length(ahead) > 0.f) ? ahead : Point{0.f, 1.f};
}

// Retreat directions tried in order when the straight step back is not
// reachable: straight back, then 45 and 90 degrees to either side.
constexpr int RETREAT_CANDIDATES = 5;
constexpr float RETREAT_ANGLES[RETREAT_CANDIDATES] = {0.f, 0.7853982f, -0.7853982f, 1.5707963f, -1.5707963f};

inline Point RetreatPoint(Point unit, Point toward, float distance, int candidate)
{
	const float angle = RETREAT_ANGLES[std::clamp(candidate, 0, RETREAT_CANDIDATES - 1)];
	const Point back{-toward.x, -toward.z};
	const float c = std::cos(angle), s = std::sin(angle);
	const Point dir{back.x * c - back.z * s, back.x * s + back.z * c};
	return Point{unit.x + dir.x * distance, unit.z + dir.z * distance};
}

// The engine's own move goal is 0.9 of its build range (BuilderCAI).
constexpr float REACH_SHARE = 0.9f;

// How far ahead of the retreat point (toward the threat) the defence goes.
// At least `clearance` (the defence's radius plus the constructor's, so it
// does not sit on the builder), at most 0.9 of the engine's build range
// (buildDistance + the defence's radius) so it is built without walking
// forward again. When the two conflict the reach wins: never walk back in.
inline float SiteOffset(float wanted, float clearance, float reach)
{
	const float limit = std::max(0.f, reach * REACH_SHARE);
	return std::min(std::max(wanted, clearance), limit);
}

inline Point SitePoint(Point retreat, Point toward, float offset)
{
	return Point{retreat.x + toward.x * offset, retreat.z + toward.z * offset};
}

// Whether a trigger starts a brace. The health retreat supersedes the brace:
// at or below the retreat fraction the constructor's normal retreat runs.
struct Gate {
	bool enabled = false;
	bool land = false;            // mobile, not flying, not a ship or submarine
	bool retreating = false;      // already on a retreat task
	bool bracing = false;         // already on a brace task
	float health = 1.f;           // fraction of max health
	float retreat = 0.f;          // the unit's retreat fraction
	int frame = 0;
	int lastStart = -1;           // frame of its last brace, -1: never
	int cooldown = 0;             // frames between two braces
};

inline bool Starts(const Gate& g)
{
	if (!g.enabled || !g.land || g.retreating || g.bracing) {
		return false;
	}
	if (g.health <= g.retreat) {
		return false;  // the retreat threshold wins
	}
	return (g.lastStart < 0) || (g.frame - g.lastStart >= g.cooldown);
}

} // namespace brace
} // namespace circuit

#endif // SRC_CIRCUIT_CONTROL_KERNEL_CONSTRUCTORBRACE_H_
