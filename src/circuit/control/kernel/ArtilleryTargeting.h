#pragma once
// D-492 / D-493: the artillery fire-control rules (owner, 2026-11-07), engine
// free. The artillery controller (control/unit/artillery/) feeds it contacts
// from the side's combat snapshot; tests/artillery_targeting_test.cpp names a
// test after each rule.
//
// Order: an enemy construction turret or resurrection bot in range (support),
// then a heavy unit within a share of the range (heavy), then the known enemy
// static weapon with the longest range (static). A static aim is kept until the
// enemy is gone or out of reach; only a higher kind replaces an aim. Spam (a
// mobile unit that is neither heavy nor support) is never chosen.

#include <vector>

namespace circuit::artillery {

enum class Kind : int { None = 0, Static = 1, Heavy = 2, Support = 3 };

// What the rules need of an enemy unit's definition.
struct DefFacts {
	bool mobile = false;
	bool assist = false;        // can assist construction
	bool buildOptions = false;  // has build options (a factory or constructor)
	bool resurrect = false;     // can resurrect
	bool heavyRole = false;     // the profile's heavy role
	float costM = 0.f;
	float range = 0.f;          // its own weapon range (0: no weapon)
};

// heavyCost <= 0: only the heavy role makes a unit heavy.
inline Kind Classify(const DefFacts& d, float heavyCost)
{
	if ((!d.mobile && d.assist && !d.buildOptions) || (d.mobile && d.resurrect)) return Kind::Support;
	if (d.mobile && (d.heavyRole || (heavyCost > 0.f && d.costM >= heavyCost))) return Kind::Heavy;
	if (!d.mobile && d.range > 0.f) return Kind::Static;
	return Kind::None;
}

struct Contact {
	int id = -1;
	Kind kind = Kind::None;
	float range = 0.f;   // the enemy's own weapon range: the static tie-break
	float distSq = 0.f;  // squared distance from the gun
};

// A heavy unit counts only within heavyShare of the gun's range.
inline bool InReach(const Contact& c, float gunRange, float heavyShare)
{
	const float reach = (c.kind == Kind::Heavy) ? gunRange * heavyShare : gunRange;
	return c.kind != Kind::None && c.distSq <= reach * reach;
}

// a before b: the higher kind, then the longer enemy range, then the nearer.
inline bool Before(const Contact& a, const Contact& b)
{
	if (a.kind != b.kind) return int(a.kind) > int(b.kind);
	if (a.range != b.range) return a.range > b.range;
	return a.distSq < b.distSq;
}

// The index of the aim in `candidates` (all in reach), or -1 to release to the
// engine. The current aim, while among the candidates, is kept unless a
// candidate of a higher kind exists.
inline int Choose(int currentId, const std::vector<Contact>& candidates)
{
	int best = -1, current = -1;
	for (int i = 0; i < int(candidates.size()); ++i) {
		if (candidates[i].id == currentId) current = i;
		if (best < 0 || Before(candidates[i], candidates[best])) best = i;
	}
	if (current >= 0 && int(candidates[best].kind) <= int(candidates[current].kind)) return current;
	return best;
}

// INV-265: an aim change is lawful when the previous target is gone or out of
// reach, or the new one is of a higher kind.
inline bool AimChangeAllowed(bool previousInReach, Kind previous, Kind next)
{
	return !previousInReach || int(next) > int(previous);
}

// The group holds another artillery back while `max` of ours stand near the
// site, unless the enemy statics in reach outnumber them (max <= 0: off).
inline bool Crowded(int ours, int statics, int max)
{
	return max > 0 && ours >= max && statics <= ours;
}

// A pop-up gun is armoured only while closed. Under fire from an attacker it
// cannot reach, a structure aim is dropped so the gun closes; support and heavy
// aims are kept (they are the reason to stay open).
inline bool CloseUnderFire(Kind aim, bool attackerReachable)
{
	return !attackerReachable && int(aim) <= int(Kind::Static);
}

} // namespace circuit::artillery
