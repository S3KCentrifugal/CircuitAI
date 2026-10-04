#ifndef CIRCUIT_ENEMY_RECLAIM_POLICY_H
#define CIRCUIT_ENEMY_RECLAIM_POLICY_H

#include <cmath>

namespace circuit::enemy_reclaim {

// Capability based: includes floating and Extra Units construction turrets.
inline bool EligibleTurret(bool mobile, bool assist, bool reclaim, bool finished, bool player)
{
	return !mobile && assist && reclaim && finished && !player;
}

inline bool EligibleTarget(bool visible, bool hostile, bool reclaimable, bool alive, bool ignoredByGame)
{
	return visible && hostile && reclaimable && alive && !ignoredByGame;
}

inline bool InRange(float distanceSquared, float buildDistance, float targetRadius)
{
	if (!std::isfinite(distanceSquared) || distanceSquared < 0.f
		|| !std::isfinite(buildDistance) || buildDistance <= 0.f
		|| !std::isfinite(targetRadius) || targetRadius < 0.f) return false;
	const float reach = buildDistance + targetRadius;
	return std::isfinite(reach * reach) && distanceSquared <= reach * reach;
}

} // namespace circuit::enemy_reclaim
#endif
