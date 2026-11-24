/*
 * AllyTeam.cpp
 *
 *  Created on: Apr 7, 2015
 *      Author: rlcevg
 */

#include "unit/ally/AllyTeam.h"
#include "task/fighter/RangedObservation.h"
#include "unit/FactoryData.h"
#include "map/MapManager.h"
#include "map/ThreatMap.h"
#include "module/MilitaryManager.h"
#include "terrain/BattleAnalysis.h"
#include "resource/MetalManager.h"
#include "resource/EnergyManager.h"
#include "resource/EnergyGrid.h"
#include "scheduler/Scheduler.h"
#include "setup/DefenceData.h"
#include "setup/SetupManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/TerrainData.h"
#include "terrain/TerrainManager.h"  // Only for ApplyAuthority
#include "CircuitAI.h"
#include "util/math/RayBox.h"
#include "util/GameAttribute.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "Log.h"

#include "AIFloat3.h"
#include "Team.h"

namespace circuit {

using namespace springai;
using namespace terrain;

CAllyTeam::CAllyTeam(const TeamIds& tids, const geom::CRegion* sb)
		: circuit(nullptr)
		, teamIds(tids)
		, startBox(sb)
		, initCount(0)
		, resignSize(0)
		, lastUpdate(-1)
		, isResetStart(true)
		, uEnemyMark(0)
{
}

CAllyTeam::~CAllyTeam()
{
	if (initCount > 0) {
		initCount = 1;
		Release();
	}
}

const CAllyTeam::Id CAllyTeam::GetLeaderId() const
{
	return circuit->GetTeamId();
}

void CAllyTeam::Init(CCircuitAI* circuit, float decloakRadius)
{
	if (initCount++ > 0) {
		mapManager->GetThreatMap()->CopyDefs(circuit);
		return;
	}

	this->circuit = circuit;

	quadField.Init(int2(circuit->GetMap()->GetWidth(), circuit->GetMap()->GetHeight()), CQuadField::BASE_QUAD_SIZE);

	int boxId = circuit->GetTeam()->GetRulesParamFloat("start_box_id", -1);
	if (boxId >= 0) {
		startBox = circuit->GetGameAttribute()->GetSetupData().GetStartBox(boxId);
	}

	mapManager = std::make_shared<CMapManager>(circuit, decloakRadius);
	mapManager->InitMaps();
	enemyManager = std::make_shared<CEnemyManager>(circuit);
	enemyManager->ReadConfig();

	uEnemyMark = circuit->GetSkirmishAIId() % THREAT_UPDATE_RATE;

	metalManager = std::make_shared<CMetalManager>(circuit, &circuit->GetGameAttribute()->GetMetalData());
	if (metalManager->HasMetalSpots() && !metalManager->HasMetalClusters() && !metalManager->IsClusterizing()) {
		metalManager->ClusterizeMetal(circuit->GetSetupManager()->GetCommChoice());
	}

	energyManager = std::make_shared<CEnergyManager>(circuit, &circuit->GetGameAttribute()->GetEnergyData());
	energyGrid = std::make_shared<CEnergyGrid>(circuit);
	energyGrid->ReadConfig();
	defence = std::make_shared<CDefenceData>(circuit);
	defence->ReadConfig(circuit);
	pathfinder = std::make_shared<CPathFinder>(&circuit->GetGameAttribute()->GetTerrainData(), circuit->GetScheduler()->GetMaxWorkThreads());
	factoryData = std::make_shared<CFactoryData>();

	releaseTask = CScheduler::GameJob(&CAllyTeam::DelegateAuthority, this);
	circuit->GetScheduler()->RunOnRelease(releaseTask);
}

void CAllyTeam::NonDefaultThreats(std::set<CCircuitDef::RoleT>&& modRoles, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	mapManager->GetThreatMap()->Init(circuit->GetGameAttribute()->GetRoleMasker().GetMasks().size(), std::move(modRoles));
}

void CAllyTeam::InitThreatRanges(CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	mapManager->GetThreatMap()->InitRanges();
}

void CAllyTeam::Release()
{
	resignSize++;
	if (rangedObservation) rangedObservation->Invalidate();  // D-462: reader and definitions may be gone
	if (--initCount > 0) {
		return;
	}

	for (auto& kv : friendlyUnits) {
		delete kv.second;
	}
	friendlyUnits.clear();
	friendlyStructures.clear();
	friendlyStructuresReady=false;

	mapManager = nullptr;
	metalManager = nullptr;
	energyManager = nullptr;
	energyGrid = nullptr;
	defence = nullptr;
	pathfinder = nullptr;
	factoryData = nullptr;

	quadField.Kill();
}

void CAllyTeam::UnmarkReclaim(ICoreUnit::Id unitId)
{
	auto it = reclaimMarks.find(unitId);
	if ((it != reclaimMarks.end()) && (--it->second <= 0)) {
		reclaimMarks.erase(it);
	}
}

void CAllyTeam::ForceUpdateFriendlyUnits()
{
	--lastUpdate;
	UpdateFriendlyUnits();
}

int CAllyTeam::FinishedCount(int defId)
{
	if (finishedCountsFrame != lastUpdate) {
		finishedCounts.clear();
		for (const auto& kv : friendlyUnits) {
			const CAllyUnit* unit = kv.second;
			if ((unit == nullptr) || (unit->GetCircuitDef() == nullptr) || unit->GetUnit()->IsBeingBuilt()) continue;
			++finishedCounts[unit->GetCircuitDef()->GetId()];
		}
		finishedCountsFrame = lastUpdate;
	}
	const auto it = finishedCounts.find(defId);
	return (it == finishedCounts.end()) ? 0 : it->second;
}

void CAllyTeam::UpdateFriendlyUnits()
{
	// FIXME: Works bad because of circuit->GetCircuitDef(unitDefId) inside allyTeam:
	//   If resigned ai updated the list then all teammates will have broken links to CCircuitDef*.
	// Options:
	//   1) save CCircuitDef::Id instead of pointer. But u->GetCircuitDef() is too spread out to fix it now.
	//   2) Move friendlyUnits from CAllyTeam level to CCircuitAI (and eat more memory and cpu on updates for each ai instance).
	if (lastUpdate >= circuit->GetLastFrame()) {
		return;
	}

	for (auto& kv : friendlyUnits) {
		delete kv.second;
	}
	friendlyUnits.clear();
	friendlyStructures.clear();
	friendlyStructuresReady=false;
	COOAICallback* clb = circuit->GetCallback();
	const std::vector<Unit*>& units = clb->GetFriendlyUnits();
	if (!reclaimMarks.empty()) {
		// Drop marks on units that no longer exist: ids are reused by the engine.
		std::unordered_set<int> alive;
		for (Unit* u : units) {
			alive.insert(u->GetUnitId());
		}
		for (auto it = reclaimMarks.begin(); it != reclaimMarks.end();) {
			it = (alive.find(it->first) == alive.end()) ? reclaimMarks.erase(it) : std::next(it);
		}
	}
	for (Unit* u : units) {
		int unitId = u->GetUnitId();
		CCircuitDef::Id unitDefId = clb->Unit_GetDefId(unitId);
		CAllyUnit* unit = new CAllyUnit(unitId, u, circuit->GetCircuitDef(unitDefId));
		friendlyUnits[unitId] = unit;
	}
	lastUpdate = circuit->GetLastFrame();
	const auto alive = [this](int id) { return friendlyUnits.find(id) != friendlyUnits.end(); };
	// Launched missiles still cover their area if the firing Juno dies. Pending
	// claims are released by RemoveAssignee, with the timeout as a safety net.
	pulseClaims.Prune(lastUpdate, [](int) { return true; });
	probeHistory.Prune(lastUpdate, [](int) { return true; });
	nuclearHistory.Prune(lastUpdate, alive);
}

const CAllyTeam::AllyStructures& CAllyTeam::GetFriendlyStructures()
{
    // One ordered filter per existing publication, shared by all allied layout
    // readers. No extra refresh, callback or per-structure tree allocation.
    if (!friendlyStructuresReady) {
        for (const auto& entry : friendlyUnits)
            if (!entry.second->GetCircuitDef()->IsMobile()) friendlyStructures.push_back(entry);
        friendlyStructuresReady=true;
    }
    return friendlyStructures;
}

CAllyUnit* CAllyTeam::GetFriendlyUnit(ICoreUnit::Id unitId) const
{
	decltype(friendlyUnits)::const_iterator it = friendlyUnits.find(unitId);
	return (it != friendlyUnits.end()) ? it->second : nullptr;
}

bool CAllyTeam::EnemyInLOS(CEnemyUnit* data, CCircuitAI* ai)
{
	if (circuit != ai) {
		return !data->IsIgnore();
	}

	++enemyRevision;
	return enemyManager->UnitInLOS(data);
}

std::pair<CEnemyUnit*, bool> CAllyTeam::RegisterEnemyUnit(ICoreUnit::Id unitId, bool isInLOS, CCircuitAI* ai)
{
	if (circuit != ai) {
		return std::make_pair(enemyManager->GetEnemyUnit(unitId), true);
	}

	++enemyRevision;
	return enemyManager->RegisterEnemyUnit(unitId, isInLOS);
}

CEnemyUnit* CAllyTeam::RegisterEnemyUnit(Unit* e, CCircuitAI* ai)
{
	if (circuit != ai) {
		const ICoreUnit::Id unitId = e->GetUnitId();
		delete e;
		return enemyManager->GetEnemyUnit(unitId);
	}

	++enemyRevision;
	return enemyManager->RegisterEnemyUnit(e);
}

void CAllyTeam::UnregisterEnemyUnit(CEnemyUnit* data, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	enemyManager->UnregisterEnemyUnit(data);
	++enemyRevision;
}

void CAllyTeam::RegisterEnemyFake(CCircuitDef::Id unitDefId, const AIFloat3& pos, int timeout)
{
	++enemyRevision;
	CEnemyFake* data = enemyManager->RegisterEnemyFake(unitDefId, pos, timeout);
	mapManager->AddFakeEnemy(data);
	quadField.MovedEnemyFake(data);
}

void CAllyTeam::UnregisterEnemyFake(CEnemyFake* data)
{
	quadField.RemoveEnemyFake(data);
	mapManager->DelFakeEnemy(data);
	enemyManager->UnregisterEnemyFake(data);
	++enemyRevision;
}

void CAllyTeam::EnemyEnterLOS(CEnemyUnit* enemy, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	if (mapManager->EnemyEnterLOS(enemy)) {
		enemyManager->AddEnemyCost(enemy);
	}
	++enemyRevision;
}

void CAllyTeam::EnemyLeaveLOS(CEnemyUnit* enemy, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	mapManager->EnemyLeaveLOS(enemy);
	++enemyRevision;
}

void CAllyTeam::EnemyEnterRadar(CEnemyUnit* enemy, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	mapManager->EnemyEnterRadar(enemy);
	++enemyRevision;
}

void CAllyTeam::EnemyLeaveRadar(CEnemyUnit* enemy, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	mapManager->EnemyLeaveRadar(enemy);
	++enemyRevision;
}

void CAllyTeam::EnemyDestroyed(CEnemyUnit* enemy, CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	if (mapManager->EnemyDestroyed(enemy)) {
		enemyManager->DelEnemyCost(enemy);
	}

	quadField.RemoveEnemyUnit(enemy);
	++enemyRevision;
}

const std::shared_ptr<CRangedObservation>& CAllyTeam::GetRangedObservation(CCircuitAI* reader)
{
	if (!rangedObservation) rangedObservation = std::make_shared<CRangedObservation>(this, reader);
	return rangedObservation;
}

void CAllyTeam::UpdateInLOS(CEnemyUnit* data, CCircuitDef::Id unitDefId)
{
	enemyManager->DelEnemyCost(data);
	enemyManager->UnitInLOS(data, unitDefId);
	mapManager->EnemyEnterLOS(data);
	enemyManager->AddEnemyCost(data);
	++enemyRevision;
}

void CAllyTeam::Update(CCircuitAI* ai)
{
	if (circuit != ai) {
		return;
	}

	if (combatSnapshot.Due(circuit->GetLastFrame())) {
		combatSnapshot.Rebuild(circuit, circuit->GetLastFrame());  // D-389
	}
	if (circuit->GetLastFrame() % (FRAMES_PER_SEC * 2) == (uEnemyMark + 7) % (FRAMES_PER_SEC * 2)) {
		UpdateMobileAntis();
	}
	if (circuit->GetLastFrame() % THREAT_UPDATE_RATE == uEnemyMark) {
		EnqueueUpdate();
	} else {
		enemyManager->UpdateEnemyDatas(quadField);
	}
	++enemyRevision;  // D-462: enemy records (and hidden flags) changed this frame
}

/*
 * Mobile antinuke memory (owner 2026-11-24). Every 2 s: each enemy mobile unit
 * with an interceptor weapon in radar or LOS marks (or refreshes) its spot;
 * spots seen by our LOS without the unit, of dead units, or older than
 * nuclear.mobile_antinuke_memory_seconds go. CSuperTask::KnownInterceptors
 * counts the spots of units out of radar and LOS as cover.
 */
void CAllyTeam::UpdateMobileAntis()
{
	CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
	CBattleAnalysis* battle = circuit->GetBattle();
	if ((militaryMgr == nullptr) || (battle == nullptr)) return;
	const auto& policy = militaryMgr->GetNuclearInfo();
	if (policy.mobileAntiMemoryFrames <= 0) return;
	const int frame = circuit->GetLastFrame();
	auto name = [](const CCircuitDef* d) { return (d != nullptr) ? d->GetDef()->GetName() : "?"; };
	std::unordered_map<int, const CCircuitDef*> alive;  // mobile interceptors still on record
	std::unordered_set<int> visible;
	for (const auto* pool : {&enemyManager->GetHostileDatas(), &enemyManager->GetPeaceDatas()}) for (const SEnemyData& e : *pool) {
		if (e.IsFake() || e.IsDead() || e.IsDying() || (e.cdef == nullptr) || !e.cdef->IsMobile()) continue;
		auto it = mobileAntiCoverage.find(e.cdef);
		if (it == mobileAntiCoverage.end()) {
			it = mobileAntiCoverage.emplace(e.cdef, battle->InterceptorCoverage(e.cdef)).first;
		}
		if (it->second <= 0.f) continue;
		alive.emplace(e.id, e.cdef);
		if (!e.IsInRadarOrLOS()) continue;
		visible.insert(e.id);
		const bool added = mobileAntis.Observe(e.id, {e.pos.x, e.pos.z}, it->second,
				it->second * policy.mobileAntiMerge, frame);
		if (added) {
			const int n = mobileAntis.Count(e.id);
			circuit->LOG("MOBILE ANTINUKE: %s(%i) spot %i at (%.0f, %.0f) coverage %.0f (%s, %s)",
					name(e.cdef), e.id, n, e.pos.x, e.pos.z, it->second, e.IsInLOS() ? "LOS" : "radar",
					(n > 1) ? "moving" : "first sighting");
		}
	}
	if (mobileAntis.Empty()) return;
	std::vector<int> gone;
	for (const auto& s : mobileAntis.Spots()) {
		if ((alive.find(s.id) == alive.end()) && (std::find(gone.begin(), gone.end(), s.id) == gone.end())) gone.push_back(s.id);
	}
	for (int id : gone) {
		int n = 0;
		mobileAntis.Forget(id, [&n](const strategic::MobileAntiMemory::Spot&) { ++n; });
		circuit->LOG("MOBILE ANTINUKE: unit %i gone (destroyed or no record): %i spots dropped", id, n);
	}
	mobileAntis.Expire(frame, policy.mobileAntiMemoryFrames, [&](const strategic::MobileAntiMemory::Spot& s) {
		circuit->LOG("MOBILE ANTINUKE: %s(%i) spot (%.0f, %.0f) expired %.0f s after its last sighting",
				name(alive[s.id]), s.id, s.pos.x, s.pos.z, float(frame - s.seen) / FRAMES_PER_SEC);
	});
	// scouted without it: the spot is in our LOS and this sample did not refresh it
	CMap* map = circuit->GetMap();
	mobileAntis.Clear([&](const strategic::MobileAntiMemory::Spot& s) {
		if (s.seen == frame) return false;
		const AIFloat3 p(s.pos.x, std::max(0.f, map->GetElevationAt(s.pos.x, s.pos.z)), s.pos.z);
		return mapManager->IsInLOS(p);
	}, [&](const strategic::MobileAntiMemory::Spot& s) {
		circuit->LOG("MOBILE ANTINUKE: %s(%i) spot (%.0f, %.0f) scouted empty %.0f s after its last sighting (%s)",
				name(alive[s.id]), s.id, s.pos.x, s.pos.z, float(frame - s.seen) / FRAMES_PER_SEC,
				(visible.count(s.id) > 0) ? "seen elsewhere" : "unit not in sight");
	});
}

void CAllyTeam::EnqueueUpdate()
{
	if (enemyManager->IsUpdating() || mapManager->IsUpdating()) {
		return;
	}

	mapManager->PrepareUpdate();
	enemyManager->PrepareUpdate();

	mapManager->EnqueueUpdate();
	enemyManager->EnqueueUpdate();
}

CEnemyUnit* CAllyTeam::GetEnemyOrFakeIn(const AIFloat3& startPos, const AIFloat3& dir, float length,
		const AIFloat3& enemyPos, float radius, const std::set<CCircuitDef::Id>& unitDefIds)
{
	QuadFieldQuery qfQuery(quadField);
	quadField.GetEnemyAndFakes(qfQuery, enemyPos, radius);  // TODO: predicate
	for (CEnemyUnit* e : *qfQuery.enemyUnits) {
		CCircuitDef* edef = e->GetCircuitDef();
		if ((edef != nullptr) && (unitDefIds.find(edef->GetId()) != unitDefIds.end())) {
			return e;
		}
	}
	for (CEnemyFake* e : *qfQuery.enemyFakes) {
		CCircuitDef* edef = e->GetCircuitDef();
		if (unitDefIds.find(edef->GetId()) != unitDefIds.end()) {
			return e;
		}
	}

	const CRay ray(startPos, dir);
	const AIFloat3 offset(SQUARE_SIZE * 8, SQUARE_SIZE * 8, SQUARE_SIZE * 8);
	// WARNING: Do not reuse QuadFieldQuery within same scope. Otherwise cached vector may stuck in limbo.
	//   In this particular case it looks safe because quadField.GetEnemyAndFakes reserves enemyUnits and enemyFakes,
	//   while quadField.GetQuadsOnRay reserves quads only.
	quadField.GetQuadsOnRay(qfQuery, startPos, dir, length - radius);
	for (const int quadIdx: *qfQuery.quads) {
		const CQuadField::Quad& quad = quadField.GetQuad(quadIdx);

		for (CEnemyUnit* e : quad.enemyUnits) {
			CCircuitDef* edef = e->GetCircuitDef();
			if ((edef != nullptr) && (unitDefIds.find(edef->GetId()) != unitDefIds.end())
				&& CAABBox(e->GetPos() - offset, e->GetPos() + offset).Intersection(ray))
			{
				return e;
			}
		}
		for (CEnemyFake* e : quad.enemyFakes) {
			CCircuitDef* edef = e->GetCircuitDef();
			if (unitDefIds.find(edef->GetId()) != unitDefIds.end()
				&& CAABBox(e->GetPos() - offset, e->GetPos() + offset).Intersection(ray))
			{
				return e;
			}
		}
	}

	return nullptr;
}

void CAllyTeam::OccupyCluster(int clusterId, int teamId)
{
	auto it = occupants.find(clusterId);
	if (it != occupants.end()) {
		it->second.count++;
	} else {
		occupants.insert(std::make_pair(clusterId, SClusterTeam(teamId, 1)));
	}
}

CAllyTeam::SClusterTeam CAllyTeam::GetClusterTeam(int clusterId)
{
	auto it = occupants.find(clusterId);
	if (it != occupants.end()) {
		return it->second;
	}
	return SClusterTeam(-1);
}

void CAllyTeam::OccupyArea(SArea* area, int teamId)
{
	auto it = habitants.find(area);
	if (it == habitants.end()) {
		habitants.insert(std::make_pair(area, SAreaTeam(teamId)));
	}
}

CAllyTeam::SAreaTeam CAllyTeam::GetAreaTeam(SArea* area)
{
	auto it = habitants.find(area);
	if (it != habitants.end()) {
		return it->second;
	}
	return SAreaTeam(-1);
}

void CAllyTeam::ResetStartOnce()
{
	if (isResetStart) {
		occupants.clear();
		habitants.clear();
	}
	isResetStart = false;
}

void CAllyTeam::SetAuthority(CCircuitAI* authority)
{
	// FIXME: Authority should be first one who gets message from the engine.
	//        Remove method, commented in SetupManager
	if (circuit == authority) {
		return;
	}
	circuit->GetScheduler()->RemoveReleaseJob(releaseTask);
	ApplyAuthority(authority);
}

void CAllyTeam::DelegateAuthority()
{
	std::map<Id, CCircuitAI*> teamAIs;
	for (CCircuitAI* newOwner : circuit->GetGameAttribute()->GetCircuits()) {
		if (newOwner->IsInitialized() && (newOwner != circuit) && (newOwner->GetAllyTeamId() == circuit->GetAllyTeamId())) {
			teamAIs[newOwner->GetSkirmishAIId()] = newOwner;
		}
	}
	if (!teamAIs.empty()) {
		ApplyAuthority(teamAIs.begin()->second);
	}
}

void CAllyTeam::ApplyAuthority(CCircuitAI* newOwner)
{
	this->circuit = newOwner;
	++enemyRevision;
	if (rangedObservation) rangedObservation->Invalidate();  // D-462: definitions belong to the authority
	mapManager->SetAuthority(newOwner);
	metalManager->SetAuthority(newOwner);
	energyManager->SetAuthority(newOwner);
	energyGrid->SetAuthority(newOwner);

	UpdateFriendlyUnits();
	enemyManager->ApplyAuthority(newOwner);
	for (CCircuitAI* ai : circuit->GetGameAttribute()->GetCircuits()) {
		// TODO: Is updating oldOwner desired?
		if (ai->GetAllyTeamId() == circuit->GetAllyTeamId()) {
			ai->GetTerrainManager()->ApplyAuthority();
		}
	}

	releaseTask = CScheduler::GameJob(&CAllyTeam::DelegateAuthority, this);
	newOwner->GetScheduler()->RunOnRelease(releaseTask);
}

} // namespace circuit
