/*
 * AllyTeam.h
 *
 *  Created on: Apr 7, 2015
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_SETUP_ALLYTEAM_H_
#define SRC_CIRCUIT_SETUP_ALLYTEAM_H_

#include <unordered_map>
#include "unit/enemy/EnemyManager.h"
#include "util/math/QuadField.h"
#include "util/math/Region.h"
#include "terrain/AlliedReservations.h"
#include "control/kernel/CommanderCombat.h"
#include "control/service/CombatSnapshot.h"
#include "control/kernel/DefenseClaims.h"
#include "resource/MetalField.h"
#include "task/static/StrategicTargeting.h"

#include <cstdlib>
#include <memory>
#include <string>
#include <map>
#include <unordered_set>

namespace springai {
	class AIFloat3;
	class Unit;
}

namespace terrain {
	struct SArea;
}

namespace circuit {

class CCircuitAI;
class CAllyUnit;
class CMapManager;
class CMetalManager;
class CEnergyManager;
class CEnergyGrid;
class CDefenceData;
class CPathFinder;
class CFactoryData;
class CRangedObservation;

class CAllyTeam final {
public:
	using Id = int;
	using AllyUnits = std::map<ICoreUnit::Id, CAllyUnit*>;
	using TeamIds = std::unordered_set<Id>;
	struct SClusterTeam {
		SClusterTeam(int tid, unsigned cnt = 0) : teamId(tid), count(cnt) {}
		int teamId;  // cluster leader
		unsigned count;  // number of commanders
	};
	struct SAreaTeam {
		SAreaTeam(int tid) : teamId(tid) {}
		int teamId;  // area leader
	};

public:
	CAllyTeam(const TeamIds& tids, const geom::CRegion* sb);
	~CAllyTeam();

	int GetSize() const { return teamIds.size(); }
	int GetAliveSize() const { return GetSize() - resignSize; }
	const TeamIds& GetTeamIds() const { return teamIds; }
	const Id GetLeaderId() const;
	const CCircuitAI* GetLeader() const { return circuit; }
	const geom::CRegion& GetStartBox() const { return *startBox; }

	void Init(CCircuitAI* circuit, float decloakRadius);
	void NonDefaultThreats(std::set<CCircuitDef::RoleT>&& modRoles, CCircuitAI* ai);
	void InitThreatRanges(CCircuitAI* ai);
	void Release();

	void ForceUpdateFriendlyUnits();
	void UpdateFriendlyUnits();
	CAllyUnit* GetFriendlyUnit(ICoreUnit::Id unitId) const;
	const AllyUnits& GetFriendlyUnits() const { return friendlyUnits; }
	// D-493: finished allied units of one definition (ours included). The
	// per-definition counts are rebuilt once per friendly-unit refresh, on the
	// first ask: O(F) then, O(1) per ask until the next refresh.
	int FinishedCount(int defId);
	using AllyStructures=std::vector<std::pair<int,CAllyUnit*>>;
	const AllyStructures& GetFriendlyStructures();

	const std::set<CEnemyUnit*>& GetDyingEnemies() const { return enemyManager->GetDyingEnemies(); }
	void DyingEnemy(CEnemyUnit* enemy, int frame) { enemyManager->DyingEnemy(enemy, frame); ++enemyRevision; }
	bool EnemyInLOS(CEnemyUnit* data, CCircuitAI* ai);
	std::pair<CEnemyUnit*, bool> RegisterEnemyUnit(ICoreUnit::Id unitId, bool isInLOS, CCircuitAI* ai);
	CEnemyUnit* RegisterEnemyUnit(springai::Unit* e, CCircuitAI* ai);
	void UnregisterEnemyUnit(CEnemyUnit* data, CCircuitAI* ai);

	void RegisterEnemyFake(CCircuitDef::Id unitDefId, const springai::AIFloat3& pos, int timeout);
	void UnregisterEnemyFake(CEnemyFake* data);

	void EnemyEnterLOS(CEnemyUnit* enemy, CCircuitAI* ai);
	void EnemyLeaveLOS(CEnemyUnit* enemy, CCircuitAI* ai);
	void EnemyEnterRadar(CEnemyUnit* enemy, CCircuitAI* ai);
	void EnemyLeaveRadar(CEnemyUnit* enemy, CCircuitAI* ai);
	void EnemyDestroyed(CEnemyUnit* enemy, CCircuitAI* ai);

	void UpdateInLOS(CEnemyUnit* data, CCircuitDef::Id unitDefId);

	void Update(CCircuitAI* ai);
	void EnqueueUpdate();

	CEnemyUnit* GetEnemyOrFakeIn(const springai::AIFloat3& startPos, const springai::AIFloat3& dir, float length,
			const springai::AIFloat3& enemyPos, float radius, const std::set<CCircuitDef::Id>& unitDefIds);

	const std::shared_ptr<CMapManager>&    GetMapManager()    const { return mapManager; }
	const std::shared_ptr<CEnemyManager>&  GetEnemyManager()  const { return enemyManager; }
	const std::shared_ptr<CMetalManager>&  GetMetalManager()  const { return metalManager; }
	const std::shared_ptr<CEnergyManager>& GetEnergyManager() const { return energyManager; }
	const std::shared_ptr<CEnergyGrid>&    GetEnergyGrid()    const { return energyGrid; }
	const std::shared_ptr<CDefenceData>&   GetDefenceData()   const { return defence; }
	const std::shared_ptr<CPathFinder>&    GetPathfinder()    const { return pathfinder; }
	const std::shared_ptr<CFactoryData>&   GetFactoryData()   const { return factoryData; }
	// D-462: the ranged combat picture shared by this ally team's AIs, created
	// on first use. The revision counts every mutation of the shared enemy
	// records (events, the authority's update, dying, fakes, decoys and an
	// authority change) so a shared contact view rebuilds within a frame
	// exactly when a private snapshot taken at that moment would differ.
	const std::shared_ptr<CRangedObservation>& GetRangedObservation(CCircuitAI* reader);
	unsigned GetEnemyRevision() const { return enemyRevision; }

	void OccupyCluster(int clusterId, int teamId);
	SClusterTeam GetClusterTeam(int clusterId);
	void OccupyArea(terrain::SArea* area, int teamId);
	SAreaTeam GetAreaTeam(terrain::SArea* area);
	void ResetStartOnce();

	CCircuitAI* GetAuthority() const { return circuit; }
	void SetAuthority(CCircuitAI* authority);

	/*
	 * Reclaim marks shared by the whole ally team. Each AI keeps its own
	 * reclaimUnits map, so a teammate's nanos and builders could not see what
	 * it was reclaiming and repaired the structure out from under it. A unit
	 * marked here is never a repair or assist candidate for any AI on the
	 * team. Counted, because two AIs may mark the same unit; pruned when the
	 * unit is gone, since the engine reuses unit ids.
	 */
	void MarkReclaim(ICoreUnit::Id unitId) { ++reclaimMarks[unitId]; }
	void UnmarkReclaim(ICoreUnit::Id unitId);
	bool IsReclaimMarked(ICoreUnit::Id unitId) const { return reclaimMarks.find(unitId) != reclaimMarks.end(); }
	allied_layout::Reservations& GetLayoutReservations() { return layoutReservations; }
	metal_field::Claims& GetMetalClaims() { return metalClaims; }
	strategic::Ledger& GetPulseClaims() { return pulseClaims; }
    commander::ShotClaims& GetCommanderShots() { return commanderShots; }
    // D-389: the side's enemy picture, seen and remembered, rebuilt once a second by the owner AI.
    const CCombatSnapshot& GetCombatSnapshot() const { return combatSnapshot; }
    defense::Claims& GetDefenseClaims() { return defenseClaims; }
    void NuclearWarning(int frame) { nuclearWarning=std::max(nuclearWarning,frame); }
    int LastNuclearWarning() const { return nuclearWarning; }
	strategic::Ledger& GetNuclearHistory() { return nuclearHistory; }
	// Nuke outcomes (owner 2026-11-06): every allied silo's pending launches, struck areas, presumed interceptors.
	strategic::StrikeLedger& GetNuclearStrikes() { return nuclearStrikes; }
	// Probing shots (owner 2026-11-03): spots a Juno probed, so no ally probes them again for a while.
	strategic::Ledger& GetProbeHistory() { return probeHistory; }
	// One overnuke per ally team (owner 2026-11-01): every allied BARb's silos, FRONT's
	// grid included, count towards the breakpoints and fire at the same target.
	strategic::Overnuke& GetOvernuke() { return overnuke; }
	// Team rolls (owner 2026-11-03, front nukerush): one draw per key for the
	// whole ally team, made by whichever allied BARb asks first; every later
	// ask, by any ally, gets the same answer.
	bool TeamRoll(const std::string& key, float chance, bool& first)
	{
		auto it = teamRolls.find(key);
		first = (it == teamRolls.end());
		if (first) it = teamRolls.emplace(key, (float(rand()) / (float(RAND_MAX) + 1.f)) < chance).first;
		return it->second;
	}
private:
	std::map<std::string, bool> teamRolls;
    commander::ShotClaims commanderShots;
    CCombatSnapshot combatSnapshot;
    defense::Claims defenseClaims;
    int nuclearWarning=-1000000;
public:
private:
	strategic::Ledger pulseClaims, nuclearHistory, probeHistory;
	strategic::Overnuke overnuke;
	strategic::StrikeLedger nuclearStrikes;
	allied_layout::Reservations layoutReservations;
	metal_field::Claims metalClaims;
	void DelegateAuthority();
	void ApplyAuthority(CCircuitAI* newOwner);

	CCircuitAI* circuit;  // authority
	std::shared_ptr<IMainJob> releaseTask;
	TeamIds teamIds;
	const geom::CRegion* startBox;

	int initCount;
	int resignSize;
	int lastUpdate;
	AllyUnits friendlyUnits;  // owner
	std::unordered_map<int, int> finishedCounts;  // D-493: def id -> finished allied units
	int finishedCountsFrame = -1;                 // the refresh they were counted at
	AllyStructures friendlyStructures; // borrowed ordered subset, storage reused
	bool friendlyStructuresReady=false;
	CQuadField quadField;
	std::map<ICoreUnit::Id, int> reclaimMarks;  // unitId: number of AIs reclaiming it

	std::map<int, SClusterTeam> occupants;  // Cluster owner on start. clusterId: SClusterTeam
	std::map<terrain::SArea*, SAreaTeam> habitants;  // Area habitants on start.
	bool isResetStart;

	std::shared_ptr<CMapManager> mapManager;
	std::shared_ptr<CMetalManager> metalManager;
	std::shared_ptr<CEnergyManager> energyManager;
	std::shared_ptr<CEnergyGrid> energyGrid;
	std::shared_ptr<CDefenceData> defence;
	std::shared_ptr<CPathFinder> pathfinder;
	std::shared_ptr<CFactoryData> factoryData;

	std::shared_ptr<CEnemyManager> enemyManager;
	std::shared_ptr<CRangedObservation> rangedObservation;
	unsigned enemyRevision = 0;

	int uEnemyMark;
};

} // namespace circuit

#endif // SRC_CIRCUIT_SETUP_ALLYTEAM_H_
