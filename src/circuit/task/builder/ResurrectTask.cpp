/*
 * ResurrectTask.cpp
 *
 *  Created on: Apr 16, 2020
 *      Author: rlcevg
 */

#include "task/builder/ResurrectTask.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"

#include "Log.h"
#include "Feature.h"
#include "FeatureDef.h"

namespace circuit {

using namespace springai;

CBResurrectTask::CBResurrectTask(ITaskModule* mgr, Priority priority,
								 const AIFloat3& position,
								 SResource cost, int timeout, float radius)
		: IBuilderTask(mgr, priority, nullptr, position, Type::BUILDER, BuildType::RESURRECT, cost, 0.f, timeout)
		, radius(radius)
{
}

CBResurrectTask::CBResurrectTask(ITaskModule* mgr)
		: IBuilderTask(mgr, Type::BUILDER, BuildType::RESURRECT)
		, radius(0.f)
{
}

CBResurrectTask::~CBResurrectTask()
{
}

bool CBResurrectTask::CanAssignTo(CCircuitUnit* unit) const
{
	return unit->GetCircuitDef()->IsAbleToResurrect();
}

void CBResurrectTask::AssignTo(CCircuitUnit* unit)
{
	IBuilderTask::AssignTo(unit);

	lastTouched = manager->GetCircuit()->GetLastFrame();
}

void CBResurrectTask::RemoveAssignee(CCircuitUnit* unit)
{
	reclaimOnly.erase(unit);
	IBuilderTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}
}

void CBResurrectTask::Finish()
{
}

void CBResurrectTask::Cancel()
{
}

bool CBResurrectTask::Execute(CCircuitUnit* unit)
{
	executors.insert(unit);

	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdPriority(ClampPriority());
	)

	const int frame = circuit->GetLastFrame();
	AIFloat3 pos;
	float rezzRadius;
	if ((radius == .0f) || !geom::is_valid(position)) {
		pos = circuit->GetTerrainManager()->GetTerrainCenter();
		rezzRadius = pos.Length2D();
	} else {
		pos = position;
		rezzRadius = radius;
	}
	// Owner rule: inside the reach of enemy short-ranged porc (LLT, Beamer,
	// HLT, Twin Guard, pop-ups...; seen or ghost) the wreck is reclaimed, not
	// resurrected - a rez takes far longer under fire and the new unit spawns
	// into the porc. Not for the whole-map area order (radius 0).
	if ((radius > .0f) && IsPorcReclaim(unit, pos)) {
		if (reclaimOnly.insert(unit).second) {
			circuit->LOG("REZ: %s(%i) reclaims instead of resurrecting at (%.0f, %.0f): enemy short porc reach",
					unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), pos.x, pos.z);
		}
		TRY_UNIT(circuit, unit,
			unit->CmdReclaimInArea(pos, rezzRadius, UNIT_CMD_OPTION, frame + FRAMES_PER_SEC * 60);
		)
		return true;
	}
	reclaimOnly.erase(unit);
	TRY_UNIT(circuit, unit,
		unit->CmdResurrectInArea(pos, rezzRadius, UNIT_CMD_OPTION, frame + FRAMES_PER_SEC * 60);
	)
	return true;
}

bool CBResurrectTask::IsPorcReclaim(CCircuitUnit* unit, const AIFloat3& target) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	return builderMgr->IsUnderEnemyShortPorc(target)
		|| builderMgr->IsUnderEnemyShortPorc(unit->GetPos(circuit->GetLastFrame()));
}

bool CBResurrectTask::Reevaluate(CCircuitUnit* unit)
{
	// A unit already working the wreck switches order when the porc picture
	// changes (porc spotted or ghost cleared) instead of waiting for its
	// 60 s area order to time out.
	if ((radius > .0f) && (executors.find(unit) != executors.end())
		&& (IsPorcReclaim(unit, position) != (reclaimOnly.find(unit) != reclaimOnly.end())))
	{
		Execute(unit);
		return false;
	}
	if (recoveryControlled) return true; // SEA selector owns target changes.
	CCircuitAI* circuit = manager->GetCircuit();
	if (units.empty()) {
		return true;
	}

	/*
	 * Update reclaim position
	 */
	const int frame = circuit->GetLastFrame();
	const AIFloat3& pos = unit->GetPos(frame);
	const std::vector<ICoreUnit::Id>& enemyIds = circuit->GetCallback()->GetEnemyUnitIdsIn(pos, 500.0f);
	for (ICoreUnit::Id enemyId : enemyIds) {
		CEnemyInfo* enemy = circuit->GetEnemyInfo(enemyId);
		if (enemy == nullptr) {
			continue;
		}
		CCircuitDef* edef = enemy->GetCircuitDef();
		if ((edef == nullptr) || (edef->IsReclaimable()
			&& (!edef->IsAttacker() || unit->GetCircuitDef()->IsAttrVampire())
			/* && enemy->GetUnit()->IsBeingBuilt()*/))
		{
			TRY_UNIT(circuit, unit,
				unit->CmdReclaimEnemy(enemy, UNIT_CMD_OPTION, frame + FRAMES_PER_SEC * 60);
			)
			return false;
		}
	}

	COOAICallback* clb = circuit->GetCallback();
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	auto features = circuit->GetCallback()->GetFeaturesIn(pos, 500.0f);
	if (!features.empty()) {
		CTerrainManager* terrainMgr = circuit->GetTerrainManager();
		circuit->GetThreatMap()->SetThreatType(unit);
		float minSqDist = std::numeric_limits<float>::max();
		Resource* metalRes = circuit->GetEconomyManager()->GetMetalRes();
		for (Feature* feature : features) {
			AIFloat3 featPos = feature->GetPosition();
			CTerrainManager::CorrectPosition(featPos);  // Impulsed flying feature
			if (!terrainMgr->CanReachAtSafe2(unit, featPos, unit->GetCircuitDef()->GetBuildDistance())) {
				continue;
			}
			if (!clb->Feature_IsResurrectable(feature->GetFeatureId())) {
				continue;
			}
			FeatureDef* featDef = feature->GetDef();
			float reclaimValue = featDef->GetContainedResource(metalRes)/* * feature->GetReclaimLeft()*/;
			delete featDef;
			if (reclaimValue < 1.0f) {
				continue;
			}
			float sqDist = pos.SqDistance2D(featPos);
			if ((sqDist < minSqDist) && !builderMgr->IsReclaimFeature(featPos, radius)) {
				position = featPos;
				minSqDist = sqDist;
			}
		}
		utils::free_clear(features);
	}

	return true;
}

void CBResurrectTask::OnUnitIdle(CCircuitUnit* unit)
{
    // A failed/finished member must not cancel its crew's productive commands.
    // The last member retains legacy completion; SEA reselects the now-idle
    // member using live feature legality on its next callback.
    if (recoveryControlled && units.size() > 1) {
        RemoveAssignee(unit);
        return;
    }
	manager->AbortTask(this);
}

bool CBResurrectTask::IsInRange(const AIFloat3& pos, float range) const
{
	return position.SqDistance2D(pos) <= SQUARE(radius + range);
}

#define SERIALIZE(stream, func)	\
	utils::binary_##func(stream, radius);

bool CBResurrectTask::Load(std::istream& is)
{
	IBuilderTask::Load(is);
	SERIALIZE(is, read)
#ifdef DEBUG_SAVELOAD
	manager->GetCircuit()->LOG("%s | radius=%f", __PRETTY_FUNCTION__, radius);
#endif
	return true;
}

void CBResurrectTask::Save(std::ostream& os) const
{
	IBuilderTask::Save(os);
	SERIALIZE(os, write)
#ifdef DEBUG_SAVELOAD
	manager->GetCircuit()->LOG("%s | radius=%f", __PRETTY_FUNCTION__, radius);
#endif
}

} // namespace circuit
