/*
 * CaptureAction.cpp
 *
 *  Created on: Oct 31, 2021
 *      Author: rlcevg
 */

#include "unit/action/CaptureAction.h"
#include "unit/CircuitUnit.h"
#include "map/ThreatMap.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "control/unit/commander/CommanderController.h"
#include "terrain/TerrainManager.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"

#include "Unit.h"
#include "Log.h"

#include <algorithm>
#include <climits>
#include <utility>
#include <vector>

namespace circuit {

CCaptureAction::CCaptureAction(CCircuitUnit* owner, float range)
		: IUnitAction(owner, Type::CAPTURE)
		, range(range)
		, updCount(0)
{
}

CCaptureAction::~CCaptureAction()
{
}

void CCaptureAction::Update(CCircuitAI* circuit)
{
	if (updCount++ % 2 != 0) {
		return;
	}
	isBlocking = false;
	CCircuitUnit* unit = static_cast<CCircuitUnit*>(ownerList);

//	if (CCircuitUnit::ETaskState::EXECUTE == unit->GetTaskState()) {
//		StateWait();
//		return;
//	}

	COOAICallback* clb = circuit->GetCallback();
	CThreatMap* threatMap = circuit->GetThreatMap();
	threatMap->SetThreatType(unit);
	const float power = threatMap->GetUnitPower(unit) * 0.5f;
	const AIFloat3& pos = unit->GetPos(circuit->GetLastFrame());
	const float metalIncome = circuit->GetEconomyManager()->GetAvgMetalIncome() * 0.5f;
	const float energyIncome = circuit->GetEconomyManager()->GetAvgEnergyIncome() * 0.5f;

	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	const bool canReclaim = unit->GetCircuitDef()->IsAbleToReclaim();
	// Enemy walls within range, nearest first; the porc and keep-out gates
	// run on a short list only (ReclaimWall).
	std::vector<std::pair<float, std::pair<Unit*, int>>> walls;

	const std::vector<Unit*>& neutrals = clb->GetNeutralUnitsIn(pos, range);
	if (!neutrals.empty()) {
		float minSqDist = SQUARE(range);
		Unit* neutral = nullptr;
		for (Unit* n : neutrals) {
			// NOTE: check allyTeam as BAR creates units as neutral (nano-frame spam fix)
			if (n->GetAllyTeam() == circuit->GetAllyTeamId()) {
				continue;
			}
			CCircuitDef::Id defId = clb->Unit_GetDefId(n->GetUnitId());
			if (defId != -1) {
				CCircuitDef* ndef = circuit->GetCircuitDef(defId);
				// BAR objectifies dragon's teeth and walls (neutral units):
				// reclaim them, never capture.
				if (builderMgr->IsReclaimWallDef(ndef)) {
					if (canReclaim) {
						AIFloat3 wpos = n->GetPos();
						CTerrainManager::CorrectPosition(wpos);
						if (threatMap->GetThreatAt(wpos) <= power) {
							walls.push_back({wpos.SqDistance2D(pos), {n, n->GetUnitId()}});
						}
					}
					continue;
				}
				if (ndef->IsIgnore() || !ndef->IsCapturable()
					|| (ndef->GetUpkeepM() > metalIncome) || (ndef->GetUpkeepE() > energyIncome))
				{
					continue;
				}
				CWeaponDef* wdef = ndef->GetWeaponDef();
				if ((wdef != nullptr) && ((wdef->GetCostM() > metalIncome) || (wdef->GetCostE() > energyIncome))) {
					continue;
				}
			}
			AIFloat3 npos = n->GetPos();
			CTerrainManager::CorrectPosition(npos);
			if (threatMap->GetThreatAt(npos) > power) {
				continue;
			}
			float sqDist = npos.SqDistance2D(pos);
			if (minSqDist > sqDist) {
				minSqDist = sqDist;
				neutral = n;
			}
		}
		bool acted = false;
		if (!walls.empty()) {
			std::sort(walls.begin(), walls.end(),
				[](const auto& a, const auto& b) { return a.first < b.first || (a.first == b.first && a.second.second < b.second.second); });
			int tried = 0;
			for (const auto& w : walls) {
				if ((neutral != nullptr) && (w.first > minSqDist)) {
					break;  // a capture target is nearer
				}
				if (++tried > 4) {
					break;
				}
				if (ReclaimWall(circuit, unit, w.second.first, w.second.second)) {
					acted = true;
					break;
				}
			}
		}
		if (!acted && (neutral != nullptr)) {
			TRY_UNIT(circuit, unit,
				unit->GetUnit()->Capture(neutral);
			)
			isBlocking = true;
			acted = true;
		}
		utils::free(neutrals);
		if (acted) {
			return;
		}
	}

	const std::vector<CCircuitUnit::Id>& enemies = clb->GetEnemyUnitIdsIn(pos, range);
	if (enemies.empty()) {
		return;
	}

	const float maxSpeed = unit->GetCircuitDef()->GetSpeed() * 0.5f;
	float minSqDist = SQUARE(range);
	CEnemyInfo* enemy = nullptr;
	walls.clear();
	for (ICoreUnit::Id eId : enemies) {
		CEnemyInfo* e = circuit->GetEnemyInfo(eId);
		if ((e == nullptr) || (threatMap->GetThreatAt(e->GetPos()) > power)) {
			continue;
		}
		CCircuitDef* edef = e->GetCircuitDef();
		if (builderMgr->IsReclaimWallDef(edef)) {
			if (canReclaim && !e->IsHidden()) {
				walls.push_back({e->GetPos().SqDistance2D(pos), {e->GetUnit(), eId}});
			}
			continue;
		}
		if ((edef != nullptr)
			&& (edef->IsIgnore() || !edef->IsCapturable() || edef->GetSpeed() > maxSpeed))
		{
			continue;
		}
		float sqDist = e->GetPos().SqDistance2D(pos);
		if (minSqDist > sqDist) {
			minSqDist = sqDist;
			enemy = e;
		}
	}
	if (!walls.empty()) {
		std::sort(walls.begin(), walls.end(),
			[](const auto& a, const auto& b) { return a.first < b.first || (a.first == b.first && a.second.second < b.second.second); });
		int tried = 0;
		for (const auto& w : walls) {
			if ((enemy != nullptr) && (w.first > minSqDist)) {
				break;  // a capture target is nearer
			}
			if (++tried > 4) {
				break;
			}
			if (ReclaimWall(circuit, unit, w.second.first, w.second.second)) {
				return;
			}
		}
	}
	if (enemy != nullptr) {
		TRY_UNIT(circuit, unit,
			unit->GetUnit()->Capture(enemy->GetUnit());
		)
		isBlocking = true;
	}
}

bool CCaptureAction::ReclaimWall(CCircuitAI* circuit, CCircuitUnit* unit, Unit* wall, int wallId)
{
	if (wall == nullptr) {
		return false;
	}
	AIFloat3 wpos = wall->GetPos();
	CTerrainManager::CorrectPosition(wpos);
	// The commander's own safety rules for a work site: never inside a
	// keep-out zone (scouted laser tower range, recent shelling), and, like
	// the rez bots, never inside the reach of enemy short-ranged porc
	// (ghosts included). Health, cloak-energy, drone and shelling
	// withdrawals replace the builder task, which clears this action.
	if (circuit->GetCommanderController()->KeepOutBlocks(unit, wpos)
		|| circuit->GetBuilderManager()->IsUnderEnemyShortPorc(wpos))
	{
		return false;
	}
	isBlocking = true;
	// One order per wall, refreshed every 2 s (another order may replace it).
	const int frame = circuit->GetLastFrame();
	if ((wallId == lastWallId) && (frame < lastWallOrder + FRAMES_PER_SEC * 2)) {
		return true;
	}
	lastWallOrder = frame;
	TRY_UNIT(circuit, unit,
		unit->GetUnit()->ReclaimUnit(wall, 0, INT_MAX);
	)
	if (wallId != lastWallId) {
		lastWallId = wallId;
		CCircuitDef::Id defId = circuit->GetCallback()->Unit_GetDefId(wallId);
		CCircuitDef* wdef = (defId != -1) ? circuit->GetCircuitDef(defId) : nullptr;
		circuit->LOG("COMMANDER WALL: %s(%i) reclaims enemy wall %s(%i) at (%.0f, %.0f) instead of capturing",
				unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(),
				(wdef != nullptr) ? wdef->GetDef()->GetName() : "?", wallId, wpos.x, wpos.z);
	}
	return true;
}

} // namespace circuit
