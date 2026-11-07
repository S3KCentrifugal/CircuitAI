// D-488: fortified geos (Cerberus) on forward vents. Script (ForwardGeo) owns
// which vents are forward and when to build or reclaim; this file is the
// mechanism: the vent flags, the site test and the per-vent order check.
#include "module/EconomyManager.h"
#include "module/BuilderManager.h"
#include "resource/EnergyManager.h"
#include "terrain/TerrainManager.h"
#include "map/ThreatMap.h"
#include "unit/ally/AllyUnit.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "CircuitAI.h"

namespace circuit {
using springai::AIFloat3;
namespace {
// A geo needs its vent feature within about 36 elmos of its centre (Recoil
// CGameHelper::TestUnitBuildSquare, needGeo), so a plant stands within this.
constexpr float GEO_PLANT_RADIUS = 48.f;
// An order already queued within this distance of a vent owns it.
constexpr float GEO_TASK_RADIUS = 64.f;
// Engine facings tried for a site (south, east, north, west).
constexpr int GEO_FACINGS = 4;
}

void CEconomyManager::SetGeoForward(int spot, bool value)
{
	const auto& spots = circuit->GetEnergyManager()->GetSpots();
	if (spot < 0 || std::size_t(spot) >= spots.size()) return;
	if (geoForward.size() != spots.size()) geoForward.assign(spots.size(), 0);
	geoForward[spot] = value ? 1 : 0;
}

bool CEconomyManager::IsGeoForward(int spot) const
{
	return spot >= 0 && std::size_t(spot) < geoForward.size() && geoForward[spot] != 0;
}

// O(vents); vents are tens at most.
int CEconomyManager::GeoSpotAt(const AIFloat3& pos) const
{
	const auto& spots = circuit->GetEnergyManager()->GetSpots();
	int chosen = -1;
	float best = SQUARE(GEO_PLANT_RADIUS);
	for (std::size_t i = 0; i < spots.size(); ++i) {
		const float d = spots[i].SqDistance2D(pos);
		if (d <= best) { best = d; chosen = int(i); }
	}
	return chosen;
}

CCircuitUnit* CEconomyManager::OwnGeoAt(int spot) const
{
	const auto& spots = circuit->GetEnergyManager()->GetSpots();
	if (spot < 0 || std::size_t(spot) >= spots.size()) return nullptr;
	for (int id : circuit->GetCallback()->GetFriendlyUnitIdsIn(spots[spot], GEO_PLANT_RADIUS, false)) {
		CCircuitUnit* own = circuit->GetTeamUnit(id);
		if (own && own->IsFinished() && own->GetCircuitDef()->GetDef()->IsNeedGeo()) return own;
	}
	return nullptr;
}

bool CEconomyManager::CanSpareGeo(CCircuitUnit* plant)
{
	if (!plant || isEnergyStalling) return false;
	return energy.income - GetEnergyMake(plant->GetCircuitDef()) >= GetEnergyPull();
}

bool CEconomyManager::FindGeoSite(CCircuitDef* def, int spot, AIFloat3& site, int& facing) const
{
	const auto& spots = circuit->GetEnergyManager()->GetSpots();
	if (!def || spot < 0 || std::size_t(spot) >= spots.size()) return false;
	const int frame = circuit->GetLastFrame();
	AIFloat3 candidates[2] = {spots[spot], spots[spot]};
	int count = 1;
	for (int id : circuit->GetCallback()->GetFriendlyUnitIdsIn(spots[spot], GEO_PLANT_RADIUS, false)) {
		CAllyUnit* plant = circuit->GetFriendlyUnit(id);
		if (plant && plant->GetCircuitDef()->GetDef()->IsNeedGeo()) {
			candidates[0] = plant->GetPos(frame);  // the stack position first
			count = 2;
			break;
		}
	}
	auto* map = circuit->GetMap();
	auto* terrain = circuit->GetTerrainManager();
	for (int c = 0; c < count; ++c) {
		for (int f = 0; f < GEO_FACINGS; ++f) {
			if (map->IsPossibleToBuildAt(def->GetDef(), candidates[c], f)
				&& !terrain->IsAllyLayoutBlocked(def, candidates[c], f)) {
				site = candidates[c];
				facing = f;
				return true;
			}
		}
	}
	return false;
}

// Cost: one friendly query at the vent, the queued GEO tasks, and at most
// 2 x GEO_FACINGS engine site tests. Script calls it a few times a second at most.
CEconomyManager::GeoFortify CEconomyManager::CheckGeoFortify(CCircuitUnit* builder, CCircuitDef* def, int spot,
		float maxThreat, AIFloat3& site, int& facing)
{
	const auto& spots = circuit->GetEnergyManager()->GetSpots();
	const int frame = circuit->GetLastFrame();
	if (!builder || !def || spot < 0 || std::size_t(spot) >= spots.size() || !def->GetDef()->IsNeedGeo()
		|| !def->IsBuildAllowed() || !def->IsAvailable(frame) || !builder->GetCircuitDef()->CanBuild(def)) {
		return GeoFortify::UNAVAILABLE;
	}
	const AIFloat3& vent = spots[spot];
	// An enemy unit seen on the vent (its plant, or its guard): not ours to build on.
	if (circuit->GetCallback()->IsEnemyUnitsIn(vent, GEO_PLANT_RADIUS, false)) return GeoFortify::ENEMY;
	bool plant = false;
	for (int id : circuit->GetCallback()->GetFriendlyUnitIdsIn(vent, GEO_PLANT_RADIUS, false)) {
		CAllyUnit* friendly = circuit->GetFriendlyUnit(id);
		if (!friendly || !friendly->GetCircuitDef()->GetDef()->IsNeedGeo()) continue;
		// By id: allied AIs share the unit table, each with its own definitions
		// (Forge, b46: three AIs reclaimed their own Cerberus for a Cerberus).
		if (friendly->GetCircuitDef()->GetId() == def->GetId()) return GeoFortify::BUILT;
		CCircuitUnit* own = circuit->GetTeamUnit(id);
		if (!own) return GeoFortify::ALLY;  // an ally's plant is never touched
		if (!own->IsFinished()) return GeoFortify::BUSY;
		plant = true;
	}
	for (auto* task : circuit->GetBuilderManager()->GetTasks(IBuilderTask::BuildType::GEO)) {
		if (task->GetPosition().SqDistance2D(vent) < SQUARE(GEO_TASK_RADIUS)) return GeoFortify::BUSY;
	}
	auto* terrain = circuit->GetTerrainManager();
	const bool flying = builder->GetCircuitDef()->IsAbleToFly();
	if (!terrain->CanReachAtSafe(builder, vent, builder->GetCircuitDef()->GetBuildDistance())
		|| (!flying && !CanReachMex(builder, vent))
		|| circuit->GetThreatMap()->GetThreatAt(builder, vent) > maxThreat) {
		return GeoFortify::UNREACHABLE;
	}
	if (!FindGeoSite(def, spot, site, facing)) return plant ? GeoFortify::REFUSED_PLANT : GeoFortify::REFUSED;
	return GeoFortify::READY;
}

} // namespace circuit
