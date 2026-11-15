/*
 * WeaponReach.h
 *
 * Owner 2026-11-15: one copy of the engine's height-aware range test, shared by
 * the battle analysis (porc reach, lolcannon sites), the ranged controller
 * (Fatboy, Myrmidon, ...) and the assault micro (Thug, Mace, Satyr, ...).
 *
 * Engine source (RecoilEngine):
 *   CWeapon::TestRange (Weapon.cpp): heightDiff = target.y - aimFrom.y, scaled by
 *     the weapon's heightmod; a unit target of a cylinder-targeting weapon keeps
 *     the flat range while |heightDiff| < cylinderTargeting * range, else the
 *     2-D reach is GetRange2D(0, heightDiff).
 *   CWeapon::GetRange2D: sqrt(range^2 - heightDiff^2) (beams, missiles, lasers).
 *   CStarburstLauncher: range + heightDiff.
 *   CCannon::GetStaticRange2D (Cannon.cpp): the ballistic reach at 45 degrees,
 *     with the range boost factor clamping it to the def's range on flat ground
 *     and the height boost factor lengthening it downhill (smoothed over the
 *     first 100 elmos of drop). Uphill it shrinks, to 0 once the shell cannot
 *     climb that high.
 *
 * Pure functions: no engine calls, safe on any thread.
 */

#ifndef SRC_CIRCUIT_UTIL_WEAPONREACH_H_
#define SRC_CIRCUIT_UTIL_WEAPONREACH_H_

#include <algorithm>
#include <cmath>

namespace circuit {
namespace weapon_reach {

enum class Kind { SPHERE, CANNON, STARBURST };

struct Ballistics {
	float range = 0.f;
	float heightMod = 1.f;
	float cylinder = 0.f;      // cylinderTargeting
	float speed = 0.f;         // projectile speed, elmos per frame
	float gravity = 0.f;       // magnitude, elmos per frame^2 (> 0)
	float heightBoost = -1.f;  // the def's heightBoostFactor (< 0: engine formula)
	Kind kind = Kind::SPHERE;
};

// CCannon::GetStaticRange2D's inner CalcRange2D; heightDiff already heightmod scaled.
inline float CannonRange2D(float heightDiff, float speed, float gravity, float rangeBoost, float heightBoost)
{
	const float speed2D = speed * 0.7071067f;
	const float sq = speed2D * speed2D;
	if (heightDiff < -100.f) {
		heightDiff *= heightBoost;
	} else if (heightDiff < 0.f) {
		heightDiff *= (1.f + (heightBoost - 1.f) * -heightDiff / 100.f);
	}
	const float root = sq - 2.f * gravity * heightDiff;
	if (root < 0.f) return 0.f;
	return rangeBoost * (sq + speed2D * std::sqrt(root)) / gravity;
}

// 2-D reach of a weapon aimed from height fromY at a unit at height toY.
inline float Reach2D(const Ballistics& b, float fromY, float toY)
{
	if (b.range <= 0.f) return 0.f;
	const float hd = (toY - fromY) * b.heightMod;   // negative: firing downhill
	if (b.cylinder >= 0.01f) {
		return (b.cylinder * b.range > std::fabs(hd)) ? b.range : 0.f;
	}
	switch (b.kind) {
		case Kind::STARBURST:
			return std::max(0.f, b.range + hd);
		case Kind::CANNON: {
			if (b.speed <= 0.f || b.gravity <= 0.f) break;
			const float base = CannonRange2D(0.f, b.speed, b.gravity, 1.f, b.heightBoost);
			const float rbf = (base > 0.f) ? std::clamp(b.range / base, 0.f, 1.f) : 0.f;
			float hbf = b.heightBoost;
			if (hbf < 0.f && rbf > 0.f) hbf = (2.f - rbf) / std::sqrt(rbf);
			return CannonRange2D(hd, b.speed, b.gravity, rbf, hbf);
		}
		default: break;
	}
	return std::sqrt(std::max(0.f, b.range * b.range - hd * hd));
}

} // namespace weapon_reach
} // namespace circuit

#endif // SRC_CIRCUIT_UTIL_WEAPONREACH_H_
