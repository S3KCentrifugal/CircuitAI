/*
 * MexUpTask.cpp
 *
 *  Created on: Jun 21, 2021
 *      Author: rlcevg
 */

#include "task/builder/MexUpTask.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "resource/MetalManager.h"
#include "terrain/TerrainManager.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"

#include "AISCommands.h"

namespace circuit {

using namespace springai;

CBMexUpTask::CBMexUpTask(ITaskModule* mgr, Priority priority,
						 CCircuitDef* buildDef, int spotId, const AIFloat3& position,
						 SResource cost, int timeout)
		: IBuilderTask(mgr, priority, buildDef, position, Type::BUILDER, BuildType::MEXUP, cost, 0.f, timeout)
		, spotId(spotId)
		, reclaimMex(nullptr)
{
	manager->GetCircuit()->GetEconomyManager()->SetUpgradingMexSpot(spotId, true);
	if (spotId == metal_field::SiteTagV1) {
		auto* circuit = manager->GetCircuit();
		for (const auto& [id, unit] : circuit->GetTeamUnits()) {
			const float depth = unit->GetCircuitDef()->GetExtractsM();
			if (depth > 0 && depth < buildDef->GetExtractsM()
				&& unit->GetPos(circuit->GetLastFrame()).SqDistance2D(position) < 1.f) { fieldTargetId = id; break; }
		}
		FindFacing(position);
		SetBuildPos(position);
		if (fieldTargetId < 0 || !circuit->GetEconomyManager()->ClaimFieldSite(fieldKey, buildDef, buildPos, fieldTargetId)) fieldKey = 0;
	}
}

CBMexUpTask::CBMexUpTask(ITaskModule* mgr)
		: IBuilderTask(mgr, Type::BUILDER, BuildType::MEXUP)
		, spotId(-1)
		, reclaimMex(nullptr)
{
}

CBMexUpTask::~CBMexUpTask()
{
}

void CBMexUpTask::Finish()
{
	IBuilderTask::Finish();
	if (spotId == metal_field::SiteTagV1) return; // BAR owns replacement/refund; never reclaim a neighboring mex

	CCircuitAI* circuit = manager->GetCircuit();
	const float maxRange = buildDef->GetExtrRangeM();
	CCircuitUnit* oldMex = nullptr;
	const auto& unitIds = circuit->GetCallback()->GetFriendlyUnitIdsIn(buildPos, maxRange, false);
	float curExtract = buildDef->GetExtractsM();
	for (ICoreUnit::Id unitId : unitIds) {
		CCircuitUnit* curMex = circuit->GetTeamUnit(unitId);
		if ((curMex == nullptr) || !curMex->GetCircuitDef()->IsMex()) {
			continue;
		}
		const float extract = curMex->GetCircuitDef()->GetExtractsM();
		if (curExtract > extract) {
			oldMex = curMex;
			break;
		}
	}
	if (oldMex != nullptr) {
		circuit->GetBuilderManager()->Enqueue(TaskB::Reclaim(priority, oldMex));
	}

	// FIXME: Won't work with EnqueueReclaim
	circuit->GetEconomyManager()->SetUpgradingMexSpot(spotId, false);
	circuit->GetBuilderManager()->UnregisterReclaim(reclaimMex);
}

void CBMexUpTask::Stop(bool done)
{
	IBuilderTask::Stop(done);
	if (fieldKey != 0) manager->GetCircuit()->GetEconomyManager()->ReleaseFieldSite(fieldKey);
	fieldKey = 0;
}

void CBMexUpTask::Cancel()
{
	IBuilderTask::Cancel();

	CCircuitAI* circuit = manager->GetCircuit();
	if (spotId >= 0) {  // for broken Load
		circuit->GetEconomyManager()->SetUpgradingMexSpot(spotId, false);
	}
	circuit->GetBuilderManager()->UnregisterReclaim(reclaimMex);
}

bool CBMexUpTask::Execute(CCircuitUnit* unit)
{
	if (spotId == metal_field::SiteTagV1 && !manager->GetCircuit()->GetEconomyManager()->OwnsFieldSite(fieldKey)) {
		manager->AbortTask(this);
		return false;
	}
	executors.insert(unit);

	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdPriority(ClampPriority());
	)

	const int frame = circuit->GetLastFrame();
	if (target != nullptr) {
		TRY_UNIT(circuit, unit,
			unit->CmdRepair(target, UNIT_CMD_OPTION, CmdTimeout(frame));
		)
		return true;
	}
	if (geom::is_valid(buildPos)
		&& !circuit->GetTerrainManager()->IsAllyLayoutBlocked(buildDef, buildPos, facing)
        && circuit->GetMap()->IsPossibleToBuildAt(buildDef->GetDef(), buildPos, facing))
	{
		TRY_UNIT(circuit, unit,
			unit->CmdBuild(buildDef, buildPos, facing, 0, CmdTimeout(frame));
		)
		return true;
	}

	circuit->GetThreatMap()->SetThreatType(unit);
	if (spotId == metal_field::SiteTagV1) { manager->AbortTask(this); return false; }

	// FIXME: short on purpose, won't work with EnqueueReclaim() in Finish()
	const float searchRadius = /*buildDef->GetDef()->GetResourceExtractorRange(metalRes) + */SQUARE_SIZE * 4;
	FindBuildSite(unit, position, searchRadius);

	if (geom::is_valid(buildPos)) {
		TRY_UNIT(circuit, unit,
			unit->CmdBuild(buildDef, buildPos, facing, 0, CmdTimeout(frame));
		)
		return true;
	}

	CCircuitUnit* oldMex = nullptr;
	const auto& unitIds = circuit->GetCallback()->GetFriendlyUnitIdsIn(position, searchRadius, false);
	for (ICoreUnit::Id unitId : unitIds) {
		CCircuitUnit* curMex = circuit->GetTeamUnit(unitId);
		if (curMex == nullptr) {
			continue;
		}
		const float curExtract = curMex->GetCircuitDef()->GetExtractsM();
		if ((0.f < curExtract) && (curExtract < buildDef->GetExtractsM())) {
			oldMex = curMex;
			break;
		}
	}
	if ((oldMex != nullptr) && !circuit->GetBuilderManager()->IsReclaimUnit(oldMex)) {
		state = State::ENGAGE;  // reclaim finished => UnitIdle => build on 2nd try
		reclaimMex = oldMex;
		circuit->GetBuilderManager()->RegisterReclaim(reclaimMex);
		TRY_UNIT(circuit, unit,
			unit->CmdReclaimUnit(oldMex, UNIT_CMD_OPTION, frame + FRAMES_PER_SEC * 60);
		)
	} else {
		manager->AbortTask(this);
		return false;
	}
	return true;
}

void CBMexUpTask::OnUnitIdle(CCircuitUnit* unit)
{
	if (State::ENGAGE == state) {
		state = State::ROAM;
		manager->GetCircuit()->GetBuilderManager()->UnregisterReclaim(reclaimMex);
		Execute(unit);
		return;
	}

	IBuilderTask::OnUnitIdle(unit);
}

void CBMexUpTask::FindBuildSite(CCircuitUnit* builder, const AIFloat3& pos, float searchRadius)
{
	CCircuitAI* circuit = manager->GetCircuit();
	if (spotId == metal_field::SiteTagV1) {
		if (!circuit->GetEconomyManager()->OwnsFieldSite(fieldKey)) return;
		FindFacing(position);
		SetBuildPos(position); // exact upgrade identity; never drift onto another extractor
		return;
	}
	AIFloat3 adjPos = pos;

	// Check off-center ally unit
	const auto& unitIds = circuit->GetCallback()->GetFriendlyUnitIdsIn(buildPos, buildDef->GetExtrRangeM(), false);
	for (ICoreUnit::Id unitId : unitIds) {
		CAllyUnit* curMex = circuit->GetFriendlyUnit(unitId);
		if (curMex == nullptr) {
			continue;
		}
		if (curMex->GetCircuitDef()->GetExtractsM() > 0.f) {
			adjPos = curMex->GetPos(circuit->GetLastFrame());
			break;
		}
	}

	FindFacing(adjPos);

	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	if (terrainMgr->CanReachAtSafe(builder, adjPos, builder->GetCircuitDef()->GetBuildDistance())
		&& !circuit->GetTerrainManager()->IsAllyLayoutBlocked(buildDef, adjPos, facing)
        && circuit->GetMap()->IsPossibleToBuildAt(buildDef->GetDef(), adjPos, facing))
	{
		SetBuildPos(adjPos);
	} else {
		CTerrainManager::TerrainPredicate predicate = [terrainMgr, builder](const AIFloat3& p) {
			return terrainMgr->CanReachAtSafe(builder, p, builder->GetCircuitDef()->GetBuildDistance());
		};
		SetBuildPos(terrainMgr->FindBuildSite(buildDef, pos, searchRadius, facing, predicate));
	}
}

#define SERIALIZE(stream, func)	\
	utils::binary_##func(stream, spotId);		\
	utils::binary_##func(stream, reclaimMexId);

bool CBMexUpTask::Load(std::istream& is)
{
	CCircuitUnit::Id reclaimMexId;

	const bool baseValid = IBuilderTask::Load(is);
	SERIALIZE(is, read)

	CCircuitAI* circuit = manager->GetCircuit();
	reclaimMex = circuit->GetTeamUnit(reclaimMexId);
	if (spotId == metal_field::SiteTagV1) {
		utils::binary_read(is, fieldKey);
		utils::binary_read(is, fieldTargetId);
		return baseValid && bool(is) && fieldTargetId >= 0
			&& circuit->GetEconomyManager()->ClaimFieldSite(fieldKey, buildDef, buildPos, fieldTargetId);
	}

	if (!circuit->GetMetalManager()->IsSpotValid(spotId, GetPosition())) {
		spotId = -1;
#ifdef DEBUG_SAVELOAD
		manager->GetCircuit()->LOG("%s | spotId=%i | reclaimMexId=%i", __PRETTY_FUNCTION__, spotId, reclaimMexId);
#endif
		return false;
	}
	circuit->GetEconomyManager()->SetUpgradingMexSpot(spotId, true);
#ifdef DEBUG_SAVELOAD
	manager->GetCircuit()->LOG("%s | spotId=%i | reclaimMexId=%i", __PRETTY_FUNCTION__, spotId, reclaimMexId);
#endif
	return true;
}

void CBMexUpTask::Save(std::ostream& os) const
{
	CCircuitUnit::Id reclaimMexId = (reclaimMex != nullptr) ? reclaimMex->GetId() : -1;

	IBuilderTask::Save(os);
	SERIALIZE(os, write)
	if (spotId == metal_field::SiteTagV1) { utils::binary_write(os, fieldKey); utils::binary_write(os, fieldTargetId); }
#ifdef DEBUG_SAVELOAD
	manager->GetCircuit()->LOG("%s | spotId=%i | reclaimMexId=%i", __PRETTY_FUNCTION__, spotId, reclaimMexId);
#endif
}

}
// namespace circuit
