/*
 * CircuitWDef.cpp
 *
 *  Created on: Oct 27, 2019
 *      Author: rlcevg
 */

#include "unit/CircuitWDef.h"

#include "Damage.h"

#include <algorithm>
#include "util/Defines.h"

#include "Lua/LuaConfig.h"

namespace circuit {

using namespace springai;

CWeaponDef::CWeaponDef(WeaponDef* def, Resource* resM, Resource* resE)
		: def(def)
{
	range = def->GetRange();
	aoe = def->GetAreaOfEffect();
	costM = def->GetCost(resM);
	costE = def->GetCost(resE);
	costMShot = costM;
	costEShot = costE;

	std::string wt(def->GetType());
	fireTime = (wt == "BeamLaser") ? def->GetBeamTime() : 0.f;  // FIXME: non-complete weapon list

	// Damage against the `default` armour class, and the alpha of one full
	// firing. A weapondef's `burst` is the engine's salvoSize, so a
	// Stormbringer's 110-damage bomb with burst 5 is 550 per pass - the
	// number that decides whether a bomber group one-shots a target.
	// A paralyzer deals that as paralysis rather than health damage; the
	// engine stuns while paralyzeDamage >= maxHealth and drains it at
	// maxHealth / modrules.paralyze.paralyzeDeclineRate per second.
	isParalyzer = def->IsParalyzer();
	edgeEffectiveness = def->GetEdgeEffectiveness();
	damage = 0.f;
	alpha = 0.f;
	paralyzeDamage = 0.f;
	paralyzeTime = 0.f;
	{
		springai::Damage* dmg = def->GetDamage();
		if (dmg != nullptr) {
			const std::vector<float> types = dmg->GetTypes();
			if (!types.empty()) {
				damage = types[0];  // `default` armour class
			}
			if (isParalyzer) {
				paralyzeTime = float(dmg->GetParalyzeDamageTime());
				paralyzeDamage = damage;
				damage = 0.f;  // a paralyzer removes no health
			}
			delete dmg;
		}
	}
	{
		const int salvo = std::max(1, def->GetSalvoSize());
		const int projectiles = std::max(1, def->GetProjectilesPerShot());
		alpha = damage * float(salvo) * float(projectiles);
		paralyzeDamage *= float(salvo) * float(projectiles);
	}

	isStockpile = def->IsStockpileable();
	if (isStockpile) {
		const float stockTime = def->GetStockpileTime() / FRAMES_PER_SEC;
		costM /= stockTime;
		costE /= stockTime;
	}

	isHigh = (wt == "StarburstLauncher")
			|| ((wt == "MissileLauncher") && (def->GetTrajectoryHeight() > 0.5f))  // 1.0 ~ 45 deg
			|| ((wt == "Cannon") && (def->GetHighTrajectory() >= 1));
}

CWeaponDef::~CWeaponDef()
{
	delete def;
}

CWeaponDef::Id CWeaponDef::WeaponIdFromLua(int luaId)
{
	return luaId - LUA_WEAPON_BASE_INDEX;
}

} // namespace circuit
