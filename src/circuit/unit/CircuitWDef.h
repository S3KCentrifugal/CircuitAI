/*
 * CircuitWDef.h
 *
 *  Created on: Oct 27, 2019
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_UNIT_CIRCUITWDEF_H_
#define SRC_CIRCUIT_UNIT_CIRCUITWDEF_H_

#include "WeaponDef.h"

namespace circuit {

class CWeaponDef final {
public:
	using Id = int;

//	CWeaponDef(const CWeaponDef& that) = delete;
	CWeaponDef& operator=(const CWeaponDef&) = delete;
	CWeaponDef(springai::WeaponDef* def, springai::Resource* resM, springai::Resource* resE);
	~CWeaponDef();

	static Id WeaponIdFromLua(int luaId);

	springai::WeaponDef* GetDef() const { return def; }

	float GetRange() const { return range; }
	float GetAoe() const { return aoe; }
	float GetCostM() const { return costM; }
	float GetCostE() const { return costE; }
	// Absolute cost of one shot. For a stockpile weapon costM/costE are the
	// per-second stockpiling *rate*; these stay the metal/energy per shot.
	float GetCostMShot() const { return costMShot; }
	float GetCostEShot() const { return costEShot; }
	float GetFireTime() const { return fireTime; }
	// Damage of one projectile against the `default` armour class, and the
	// alpha of one full firing: damage * salvoSize * projectilesPerShot. For a
	// bomber that is the whole pass, which is what decides whether a group
	// kills a target outright or wastes the run.
	float GetDamage() const { return damage; }
	float GetAlpha() const { return alpha; }
	float GetEdgeEffectiveness() const { return edgeEffectiveness; }
	// Paralysis: a paralyzer deals no health damage, so its worth against a
	// target is decided by paralyzeDamage vs that target's max health.
	bool IsParalyzer() const { return isParalyzer; }
	float GetParalyzeDamage() const { return paralyzeDamage; }
	float GetParalyzeTime() const { return paralyzeTime; }
	bool IsStockpile() const { return isStockpile; }
	bool IsHighTrajectory() const { return isHigh; }

private:
	springai::WeaponDef* def;  // owner

	float range;
	float aoe;
	float costM;
	float costE;
	float costMShot;
	float costEShot;
	float fireTime;
	float damage;
	float alpha;
	float edgeEffectiveness;
	float paralyzeDamage;
	float paralyzeTime;
	bool isParalyzer : 1;
	bool isStockpile : 1;
	bool isHigh : 1;
};

} // namespace circuit

#endif // SRC_CIRCUIT_UNIT_CIRCUITWDEF_H_
