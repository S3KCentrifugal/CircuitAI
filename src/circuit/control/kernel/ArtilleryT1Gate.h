#pragma once
// D-495: when the FRONT commander group may build T1 static artillery
// (Gauntlet, Agitator, Amputator), engine free. A T1 gun costs a third to a
// half of a fusion or a T2 lab, so it goes up only against a target it can
// reach from a site the enemy cannot (owner, 2026-11-07):
//
//  - Counter-battery: an enemy T1 static artillery within counterRadius of one
//    of our structures. Only the definitions the profile lists for it (the
//    Amputator, 1000 range, loses that duel to both 1220+ guns).
//  - Siege: known enemy armed structures worth at least value x the gun's
//    metal round a defence that out-ranges our mobile artillery (its range,
//    adjusted for its height over our front, reaches mobileRange).
//
// Either way the gun stands where it reaches the target (its range adjusted
// for the height difference, less margin) and where no known enemy static
// weapon reaches it. Counter-battery is a duel: the target gun itself may reach
// the site only if ours reaches at least as far back (Duel); a Gauntlet (1220)
// takes on an Agitator (1245) only from higher ground. The native caller (CommanderArtilleryT1.cpp) gathers the
// contacts from the side's combat snapshot; tests/artillery_t1_gate_test.cpp
// names a test after each rule.

#include "control/kernel/CommanderCombat.h"

#include <algorithm>
#include <vector>

namespace circuit::artillery_t1 {

using commander::Point;

// A known enemy structure, as the gate needs it.
struct Contact {
	int id = -1;
	Point pos;
	float elevation = 0.f;
	float costM = 0.f;
	float range = 0.f;      // its weapon range; 0 unarmed
	bool t1Gun = false;     // one of the T1 static artillery definitions
	bool seen = false;      // in sight or on radar within the vision window
};

enum class Case : int { None = 0, Counter = 1, Siege = 2 };

inline float SqDist(Point a, Point b) { const Point d = a - b; return commander::Dot(d, d); }

// A ballistic weapon's reach over a height difference: shooter above the
// target gains gain elmos per elmo, below it loses them (knowledge base,
// 66-defensive-placement.md: 0.4 to 0.8 for an ordinary cannon). Never negative.
inline float RangeAt(float range, float gain, float shooterY, float targetY) {
	return std::max(0.f, range + gain * (shooterY - targetY));
}

// The site reaches the target with margin to spare.
inline bool Reaches(Point site, float siteY, const Contact& target, float gunRange, float gain, float margin) {
	const float reach = RangeAt(gunRange, gain, siteY, target.elevation) - margin;
	return reach > 0.f && SqDist(site, target.pos) <= reach * reach;
}

// Some known enemy weapon reaches the site (margin added to its reach);
// ignoreId: the counter-battery target, whose reach Duel judges instead.
inline bool Covered(Point site, float siteY, const std::vector<Contact>& enemies, float gain, float margin, int ignoreId = -1) {
	for (const Contact& e : enemies) {
		if (e.range <= 0.f || (ignoreId >= 0 && e.id == ignoreId)) continue;
		const float reach = RangeAt(e.range, gain, e.elevation, siteY) + margin;
		if (SqDist(site, e.pos) <= reach * reach) return true;
	}
	return false;
}

// From this site our gun reaches the target at least as far as the target
// reaches back: an even or better duel.
inline bool Duel(float siteY, float gunRange, const Contact& target, float gain) {
	return RangeAt(gunRange, gain, siteY, target.elevation) >= RangeAt(target.range, gain, target.elevation, siteY);
}

// The enemy id the cover test leaves to Duel at this site, or -1.
inline int DuelIgnore(Case why, float siteY, float gunRange, const Contact& target, float gain) {
	return (why == Case::Counter && Duel(siteY, gunRange, target, gain)) ? target.id : -1;
}

// Our mobile artillery cannot hit this defence without being hit first.
inline bool OutrangesMobile(const Contact& c, float frontY, float gain, float mobileRange) {
	return c.range > 0.f && RangeAt(c.range, gain, c.elevation, frontY) >= mobileRange;
}

// Metal of the armed structures within radius of the target, itself included.
inline float ClusterValue(const Contact& target, const std::vector<Contact>& enemies, float radius) {
	float sum = 0.f;
	for (const Contact& e : enemies)
		if (e.range > 0.f && SqDist(e.pos, target.pos) <= radius * radius) sum += e.costM;
	return sum;
}

// Which case, if any, makes this contact a target. structureNear: one of our
// structures is within counterRadius of it (the caller's engine query, asked
// only for a seen enemy T1 gun). counterAllowed: the gun being considered may
// take counter-battery work.
inline Case Justify(const Contact& c, const std::vector<Contact>& enemies, bool structureNear, bool counterAllowed,
	float frontY, float gain, float mobileRange, float gunCostM, float value, float clusterRadius) {
	if (!c.seen || c.range <= 0.f) return Case::None;
	if (c.t1Gun && counterAllowed && structureNear) return Case::Counter;
	if (OutrangesMobile(c, frontY, gain, mobileRange) && ClusterValue(c, enemies, clusterRadius) >= value * gunCostM)
		return Case::Siege;
	return Case::None;
}

// Our T1 guns standing or framed, against the per-AI cap.
inline bool UnderCap(int ours, int cap) { return cap > 0 && ours < cap; }

} // namespace circuit::artillery_t1
