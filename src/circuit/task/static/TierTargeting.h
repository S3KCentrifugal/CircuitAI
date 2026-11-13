#pragma once

// Engine-free tiered target choice for a super weapon whose script hands it a
// roster of target defs in tiers (lolcannons, owner 2026-10-26). CSuperTask
// feeds every enemy of the roster in range through Better(); the policy - which
// defs, which tier - stays in script (systems/construction/lolcannon.as).

#include <algorithm>
#include <cmath>
#include <numeric>
#include <vector>

namespace circuit::tier {

struct Candidate {
	int id;        // enemy unit id
	int tier;      // 1 fires first
	float cost;    // metal
	float sqDist;  // squared 2D distance from the weapon
	float x = 0.f, z = 0.f;  // map position (areas)
};

// Does `c` beat `best`? The lower tier wins. Inside a tier the target already
// under fire (currentId) is kept while it is a candidate, so a rapid-fire gun
// does not swing between two equal targets; else the dearer, then the nearer.
inline bool Better(const Candidate& c, const Candidate* best, int currentId)
{
	if (best == nullptr) return true;
	if (c.tier != best->tier) return c.tier < best->tier;
	if (best->id == currentId) return false;
	if (c.id == currentId) return true;
	if (c.cost != best->cost) return c.cost > best->cost;
	return c.sqDist < best->sqDist;
}

// The rank before any grouping: lower tier, dearer, nearer, lower id.
inline bool Ranks(const Candidate& a, const Candidate& b)
{
	if (a.tier != b.tier) return a.tier < b.tier;
	if (a.cost != b.cost) return a.cost > b.cost;
	if (a.sqDist != b.sqDist) return a.sqDist < b.sqDist;
	return a.id < b.id;
}

/*
 * Areas (owner 2026-10-27): the gun works through target areas, not single
 * targets. The best target left seeds an area; every candidate left within
 * `radius` of it joins. An area ranks by its best tier, then by the metal of
 * its roster targets; it is aimed at its best target (Better, so the one under
 * fire is kept inside its tier). O(candidates x areas), and it stops once
 * maxAreas are formed and no later seed can rank among them.
 */
struct Area {
	int seedId;    // the area's best target: it names the area
	int tier;      // the best tier in it
	float metal;   // the metal of all roster targets in it
	float x, z;    // the seed's position
	int aim;       // index into the candidates: the target to fire at
};

inline bool AreaRanks(const Area& a, const Area& b)
{
	if (a.tier != b.tier) return a.tier < b.tier;
	return a.metal > b.metal;
}

inline std::vector<Area> BuildAreas(const std::vector<Candidate>& cs, float radius, int currentId, size_t maxAreas)
{
	std::vector<size_t> order(cs.size());
	std::iota(order.begin(), order.end(), size_t(0));
	std::sort(order.begin(), order.end(), [&cs](size_t a, size_t b) { return Ranks(cs[a], cs[b]); });
	std::vector<bool> taken(cs.size(), false);
	std::vector<Area> areas;
	const float sqRadius = radius * radius;
	for (size_t o = 0; o < order.size(); ++o) {
		const Candidate& seed = cs[order[o]];
		if (taken[order[o]]) continue;
		if ((areas.size() >= maxAreas) && (seed.tier > areas.back().tier)) break;
		Area a{seed.id, seed.tier, 0.f, seed.x, seed.z, int(order[o])};
		for (size_t k = o; k < order.size(); ++k) {
			const size_t j = order[k];
			if (taken[j]) continue;
			const float dx = cs[j].x - seed.x, dz = cs[j].z - seed.z;
			if (dx * dx + dz * dz > sqRadius) continue;
			taken[j] = true;
			a.metal += cs[j].cost;
			if (Better(cs[j], &cs[a.aim], currentId)) a.aim = int(j);
		}
		areas.push_back(a);
	}
	std::stable_sort(areas.begin(), areas.end(), AreaRanks);
	if (areas.size() > maxAreas) areas.resize(maxAreas);
	return areas;
}

/*
 * Likely killed (owner 2026-11-12): a lolcannon keeps firing at the last-seen
 * image of a structure in the fog after its shell killed it. A big death blast
 * (fusion, advanced fusion, advanced geothermal) digs a crater the AI can read
 * in the synced heightmap, so the ground round a big-blast roster structure is
 * watched: its height at BLAST_RING_POINTS points on a ring just outside the
 * footprint, kept while the structure is known alive (in radar or LOS). Out of
 * sight, a ring where at least `minPoints` points sank by `drop` elmos or more
 * is a blast. The engine leaves the ground under a standing building alone, so
 * only the ring counts. The cannon shells themselves dig little (crater
 * strength ~ (radius x 0.1)^0.6, about a tenth of an advanced fusion's) and
 * only inside their own small bowl, so one shell cannot sink a whole ring.
 * Engine crater (BasicMapDamage): a bowl to about 0.55 of the blast radius,
 * a raised lip beyond it, so the ring sits at 0.3 of the radius, at least
 * `footprint + margin`, at most 0.45 of the radius; a blast too small to put
 * the ring outside the footprint is not watched.
 */
constexpr int BLAST_RING_POINTS = 8;

// The ring radius for a death blast of `blastRadius` round a footprint of half
// diagonal `footHalfDiag`; 0 when the bowl would not reach past the footprint.
inline float BlastRingRadius(float blastRadius, float footHalfDiag, float margin = 24.f)
{
	const float lo = footHalfDiag + margin, hi = blastRadius * 0.45f;
	if ((blastRadius <= 0.f) || (lo > hi)) return 0.f;
	return std::min(hi, std::max(lo, blastRadius * 0.3f));
}

/*
 * How deep the ring should sink (owner 2026-11-12: use what the ground restore
 * measured). The engine's own crater (BasicMapDamage::Explosion): depth =
 * 3 x strength^0.6 x profile(distance / radius) / hardness, strength =
 * min(radius x 10, damage) x craterMult (CGameHelper::Explosion; 1 for unit
 * death blasts). Checked against the restore runs (BAR\afus-restore-runs, Forge
 * v2.3, 9ef618b2: an advanced fusion digs 22-38 elmos at its centre, a 6-16
 * elmo bowl) and this kit's Proving Grounds runs (ring 192 sank 2.5-3.2): a
 * fixed Forge depth predicted 17 there, so depth is read through the map's
 * hardness (Map_getHardness; per-terrain-type modifiers ignored, 1 on most
 * maps). `scale` is a calibration lever, 1 = the engine's formula.
 */
inline float CraterProfile(float rel)
{
	if ((rel < 0.f) || (rel >= 1.f)) return 0.f;
	constexpr float PI = 3.14159265f;
	const float c1 = std::cos((rel - 0.1f) * (PI + 0.3f));
	const float c2 = std::cos(std::max(0.0f, rel * 3.0f - 2.0f) * PI);
	return c1 * (1.0f - rel) * (0.5f + 0.5f * c2);
}

inline float CraterStrength(float blastRadius, float damage)
{
	return std::max(0.f, std::min(blastRadius * 10.f, damage));
}

inline float ExpectedRingDepth(float blastRadius, float damage, float ringRadius, float hardness, float scale = 1.f)
{
	const float s = CraterStrength(blastRadius, damage);
	if ((s <= 0.f) || (blastRadius <= 0.f) || (hardness <= 0.f) || (scale <= 0.f)) return 0.f;
	return scale * 3.f * std::pow(s, 0.6f) * CraterProfile(ringRadius / blastRadius) / hardness;
}

// The drop a ring point must show: `share` of the expected depth, at least `floor`.
inline float BlastDropLine(float expected, float share, float floor)
{
	return std::max(floor, expected * share);
}

// How many ring points sank by `drop` or more from `before` to `now`.
inline int SunkPoints(const float* before, const float* now, int n, float drop)
{
	int sunk = 0;
	for (int i = 0; i < n; ++i) {
		if (before[i] - now[i] >= drop) ++sunk;
	}
	return sunk;
}

// A blast at the ring: enough points sank.
inline bool RingBlasted(const float* before, const float* now, int n, float drop, int minPoints)
{
	return SunkPoints(before, now, n, drop) >= std::max(1, minPoints);
}

// A likely-killed target falls `penalty` tiers (below every live tier of the
// roster, 1-6) and adds no metal to its area, until it is seen again.
inline Candidate Downranked(Candidate c, int penalty)
{
	c.tier += std::max(0, penalty);
	c.cost = 0.f;
	return c;
}

/*
 * The rotation through the areas (owner 2026-10-27), like the nuke silo's
 * no-repeat: Ragnarok and Calamity dwell on an area for a time, Starfall for a
 * number of shots, then the next area down, and from the last back to the top.
 */
struct Rotation {
	int index = 0;    // the area under fire, 0 = the top
	int since = 0;    // the frame it took that area
	int shots = 0;    // shots fired at that area
	int topId = -1;   // the top area's seed at the last scan
};

// Fresh scouting changed the top area: its old seed is gone (dead, or out of
// sight for a mobile one), or the new seed is a target the last scan did not
// have. A reshuffle among targets already known is not fresh news.
inline bool TopChanged(int oldTop, int newTop, bool oldTopStill, bool newTopSeenBefore)
{
	return (newTop != oldTop) && ((oldTop < 0) || !oldTopStill || !newTopSeenBefore);
}

inline void Restart(Rotation& r, int frame)
{
	r.index = 0;
	r.since = frame;
	r.shots = 0;
}

// The next area once the dwell is up (dwellShots > 0 counts shots, else
// frames); areas is how many there are now. True when the area changed.
inline bool Advance(Rotation& r, int areas, int frame, int dwellFrames, int dwellShots)
{
	if (r.index >= areas) {
		const bool moved = (r.index != 0);
		Restart(r, frame);
		return moved;
	}
	const bool due = (dwellShots > 0) ? (r.shots >= dwellShots) : (frame - r.since >= dwellFrames);
	if (!due) return false;
	const int next = (r.index + 1) % areas;
	const bool moved = (next != r.index);
	r.index = next;
	r.since = frame;
	r.shots = 0;
	return moved;
}

} // namespace circuit::tier
