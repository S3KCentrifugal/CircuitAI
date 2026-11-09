#include "control/service/CombatSnapshot.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitDef.h"
#include "CircuitAI.h"

#include "AIFloat3.h"
#include "UnitDef.h"
#include "Unit.h"

namespace circuit {

void CCombatSnapshot::Rebuild(CCircuitAI* ai, int frame) {
	next = frame + REBUILD_FRAMES;
	built = frame;
	Reset(springai::AIFloat3::maxxpos, springai::AIFloat3::maxzpos);
	const auto& enemies = ai->GetEnemyManager()->GetEnemyUnits();
	for (const auto& [id, enemy] : enemies) {
		if (enemy == nullptr) continue;
		CCircuitDef* def = enemy->GetCircuitDef();
		const auto data = enemy->GetData();
		const bool unavailable = enemy->IsFake() || (data.losStatus &
			(SEnemyData::HIDDEN | SEnemyData::NEUTRAL | SEnemyData::DEAD | SEnemyData::DYING));
		const bool ignored = data.IsIgnore();
		const bool profileIgnored = def != nullptr && def->IsIgnore();
		// Match Observe: only profile-ignored candidates require the extra
		// rules-param callback, once per side per rebuild. Never change the
		// strategic ignore flag or read a remembered unit's hidden position.
		const bool gadgetExcluded = !unavailable && ignored && profileIgnored
			&& enemy->GetUnit()->GetRulesParamFloat("ignoredByAI", 0.f) > 0.f;
		if (!Admit(unavailable, ignored, profileIgnored, gadgetExcluded)) continue;
		const bool los = enemy->IsInLOS(), radar = enemy->IsInRadar();
		if (def == nullptr && !radar) continue;  // nothing known about it
		if (los || radar) observed[id] = frame;
		const auto seen = observed.find(id);
		Entry e;
		e.id = id;
		e.defId = def ? def->GetId() : -1;
		e.pos = {enemy->GetPos().x, enemy->GetPos().z};
		e.elevation = enemy->GetPos().y;
		// A record remembered from before this snapshot existed counts as seen now.
		e.lastObserved = seen != observed.end() ? seen->second : frame;
		if (seen == observed.end()) observed[id] = frame;
		e.los = los; e.radar = radar;
		e.speed = def ? def->GetSpeed() : BLIP_SPEED;
		e.landRange = def ? def->GetMaxRange(CCircuitDef::RangeType::LAND) : 300.f;
		Add(e);
        if (def && !def->IsMobile() && (def->GetMaxRange() >= 3000.f || (def->IsRoleSuper() && def->IsAttrStock())))
            AddStrategic(e);
		if (def != nullptr) {
			auto cached = jammerRadius.find(def->GetId());
			if (cached == jammerRadius.end()) cached = jammerRadius.emplace(def->GetId(), def->GetDef()->GetJammerRadius()).first;
			if (cached->second > 0.f) AddJammer({e.pos, cached->second});
		}
	}
	// Forget observation times of enemies no longer on record.
	for (auto it = observed.begin(); it != observed.end();) {
		it = enemies.count(it->first) ? std::next(it) : observed.erase(it);
	}
}

} // namespace circuit
