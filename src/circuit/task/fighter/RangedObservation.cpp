#include "task/fighter/RangedObservation.h"
#include "CircuitAI.h"
#include "terrain/TerrainManager.h"
#include "unit/ally/AllyTeam.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"
#include "util/Performance.h"
#include "Damage.h"
#include "Log.h"
#include "unit/CircuitWDef.h"
#include "unit/RangedPolicy.h"
#include "unit/CircuitUnit.h"
#include "util/Utils.h"
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <chrono>
#include <memory>

namespace circuit {
using springai::AIFloat3;
static ranged::Point P(const AIFloat3& p) { return {p.x,p.z}; }

// A cell is read with one engine area query: a circle around the cell centre
// that covers the whole square. The engine registers a unit in its quadfield
// at most every unitQuadPositionUpdateRate frames (Recoil default 3, BAR does
// not change it), so a moving unit can be up to a few frames' travel from its
// registered quads; the drift margin covers that for ground units. Positions
// are clamped onto the map, so a border cell also covers a margin beyond the
// map edge. The INV-248 oracle compares every loaded cell with a full read.
static constexpr float FRIEND_QUAD_DRIFT_MARGIN = 64.f;   // elmos
static constexpr float FRIEND_EDGE_MARGIN = 512.f;        // elmos beyond the map edge
static constexpr float HALF_DIAGONAL = 0.70710678f;       // per cell side
// Loading path choice. Both paths give identical cells, so the choice affects
// cost only, never behaviour. Cell loads pay while few cells are read; a full
// read pays when queries spread (16-AI Glitters, D-462) or when the side is
// small (one 120-Thug AI). The observation keeps running means of the measured
// wall time of one cell load and one full read; a frame starts with a full
// read when the previous frame's visited cells would have cost more as cell
// loads, and switches to one mid-frame once its cell loads exceed a full read.
// Until both costs are measured, FRIEND_FULL_READ_CELLS visited cells decide.
static constexpr int FRIEND_FULL_READ_CELLS = 16;
static constexpr double FRIEND_COST_SMOOTHING = 0.05;   // weight of the newest sample
using CostClock = std::chrono::steady_clock;
static double Elapsed(CostClock::time_point start) {
	return std::chrono::duration<double>(CostClock::now()-start).count();
}
// Contact shortlist size and value-grid cell, as before D-462.
static constexpr size_t OBJECTIVE_COUNT = 16;
static constexpr float CLUSTER_CELL = 128.f;
// Owner 2026-11-06: a radar dot keeps the identity it had in LOS this long
// (the pre-D-462 history entry's lifetime).
static constexpr int SEEN_DEF_FRAMES = 60 * FRAMES_PER_SEC;

const bool CRangedObservation::verify = std::getenv("CIRCUIT_VERIFY_RANGED_SHARED") != nullptr;

static bool Same(float a,float b) { return a==b || (std::isnan(a) && std::isnan(b)); }
static bool Same(const AIFloat3& a,const AIFloat3& b) { return Same(a.x,b.x) && Same(a.y,b.y) && Same(a.z,b.z); }

CRangedObservation::CRangedObservation(CAllyTeam* allyTeam, CCircuitAI* reader)
	: allyTeam(allyTeam), reader(reader), order(MAX_UNITS)
{
	const float width=float(reader->GetMap()->GetWidth()*SQUARE_SIZE);
	const float height=float(reader->GetMap()->GetHeight()*SQUARE_SIZE);
	enemies.Configure(width,height); staticHazards.Configure(width,height); ghostHazards.Configure(width,height);
	clusterValues.Configure(int(width/CLUSTER_CELL)+1,int(height/CLUSTER_CELL)+1);
	friendCells.Configure(width,height);
	seen.resize(MAX_UNITS);
	if(verify) {
		verifyEnemies.Configure(width,height); verifyStatic.Configure(width,height);
		verifyClusters.Configure(int(width/CLUSTER_CELL)+1,int(height/CLUSTER_CELL)+1);
		legacyCells.Configure(width,height);
	}
}

void CRangedObservation::Invalidate()
{
	++epoch; reader=nullptr;
	contactFrame=friendFrame=-1;
	std::fill(prototypeFrames.begin(),prototypeFrames.end(),-1);
	for(auto& s:seen) s.frame=-1;
}

const CRangedObservation::Metadata& CRangedObservation::MetadataFor(CCircuitDef* def)
{
	auto [it, fresh] = metadata.try_emplace(def->GetId());
	if (fresh) {
		auto* ud = def->GetDef();
		it->second = {float(ud->GetRadarRadius()), float(ud->GetJammerRadius()), def->GetLosRadius(), ud->GetArmorType()};
		const auto& params = ud->GetCustomParams();
		const auto level = params.find("techlevel");
		if (level != params.end()) it->second.tech = float(std::atof(level->second.c_str()));
		const std::unique_ptr<springai::WeaponDef> explosion(ud->GetDeathExplosion());
		if(explosion) {
			const std::unique_ptr<springai::Damage> damage(explosion->GetDamage());
			const auto types=damage ? damage->GetTypes() : std::vector<float>{};
			if(std::any_of(types.begin(),types.end(),[](float value){return value>0.f;}))
				it->second.explosionRadius=explosion->GetAreaOfEffect();
		}
	}
	return it->second;
}

void CRangedObservation::AcquireContacts(CCircuitAI* ai)
{
	reader=ai;
	const int now=ai->GetLastFrame();
	const unsigned revision=allyTeam->GetEnemyRevision();
	if(contactFrame==now && contactRevision==revision && contactEpoch==epoch) {
		if(verify) VerifyContacts(ai);
		return;
	}
	performance::Scope measured(ai,performance::RANGED_ENEMIES);
	BuildContacts(ai,contacts,objectives,enemies,staticHazards,clusterValues,bounds);
	BuildGhosts(ai);
	contactFrame=now; contactRevision=revision; contactEpoch=epoch; ++contactGeneration;
}

// The pre-D-462 CRangedWorld::Refresh enemy pass, minus the per-AI history
// writes (CRangedWorld::ObserveHistory). Same filters, fields and order.
void CRangedObservation::BuildContacts(CCircuitAI* ai, std::vector<Contact>& out, std::vector<int>& outObjectives,
                                       ranged::SpatialIndex& outEnemies, ranged::SpatialIndex& outStatic,
                                       ranged::CellStore<float>& outClusters, ContactBounds& outBounds)
{
	out.clear(); outObjectives.clear(); outClusters.Clear(); outEnemies.Clear(); outStatic.Clear();
	outBounds=ContactBounds{};
	const int now=ai->GetLastFrame();
	if(now-seenDefsPruned>=SEEN_DEF_FRAMES) {
		seenDefsPruned=now;
		for(auto it=seenDefs.begin();it!=seenDefs.end();) it=(now-it->second.frame>SEEN_DEF_FRAMES) ? seenDefs.erase(it) : std::next(it);
	}
	// Profile threat suppression must not erase an actual weapon's coverage.
	// Respect true fog, neutral/dying contacts and BAR's explicit ignoredByAI.
	for (const auto& [id,e]:ai->GetEnemyManager()->GetEnemyUnits()) {
		if (!e || !e->IsInRadarOrLOS()) continue;
		const auto& data=e->GetData();
		if (data.losStatus & (SEnemyData::DEAD|SEnemyData::DYING|SEnemyData::NEUTRAL|SEnemyData::HIDDEN)) continue;
		if (e->IsIgnore() && (!e->GetCircuitDef() || !e->GetCircuitDef()->IsIgnore()
			|| e->GetUnit()->GetRulesParamFloat("ignoredByAI",0.f)>0.f)) continue;
		Contact c; c.id=id; c.def=e->GetCircuitDef(); c.pos=e->GetPos();
		if(!c.def) {
			// Unidentified radar contacts can support low-priority blind fire,
			// but never invented precision identities, HP or threat estimates.
			c.pos.y=ai->GetTerrainManager()->GetAreaData()->GetElevationAt(c.pos.x,c.pos.z);
			c.airDot=e->GetPos().y>c.pos.y+60.f; // radar height error is small; aircraft fly higher
			{ const auto seenIt=seenDefs.find(id); if(seenIt!=seenDefs.end() && now-seenIt->second.frame<=SEEN_DEF_FRAMES) c.seenDef=seenIt->second.def; }
			c.mobile=true;
			// D-294: the engine reports a radar dot's velocity (UpdateInRadarData);
			// a shooter uses it to tell a slow or stationary dot (blind shot
			// allowed) from one too fast for its shell. Zero until sampled.
			c.velocity=e->GetVel()*30.f;
			outEnemies.Add(P(c.pos),int(out.size())); outObjectives.push_back(int(out.size()));
			out.push_back(c); continue;
		}
		c.velocity=e->GetVel()*30.f; c.health=std::max(1.f,e->GetHealth());
		c.radius=e->GetRadius(); c.cost=e->GetCost(); c.los=e->IsInLOS();
		if(c.los) seenDefs[id]={c.def,now};
		c.mobile=c.def->IsMobile();
		c.armed=c.def->HasSurfToLand() && !e->IsBeingBuilt() && !e->IsDisarmed() && !e->IsParalyzed();
		if(e->IsIgnore()) {
			// The legacy enemy cache intentionally stops health/velocity
			// updates for profile-ignored contacts. Refresh only observable
			// fields here, without changing the global cache or other roles.
			c.velocity=e->GetUnit()->GetVel()*30.f;
			if(c.los) {
				c.health=std::max(1.f,e->GetUnit()->GetHealth());
				c.armed=c.def->HasSurfToLand() && !e->GetUnit()->IsBeingBuilt()
					&& !e->GetUnit()->IsParalyzed() && e->GetUnit()->GetRulesParamFloat("disarmed",0.f)<=0.f;
			}
		}
		c.groundRange=c.armed ? c.def->GetMaxRange(CCircuitDef::RangeType::LAND) : 0.f;
		// Definition facts are immutable for this game load. Resolve once
		// per type, not once per candidate mount in every shooter's hot loop.
		const auto& meta=MetadataFor(c.def);
		c.armor=meta.armor; c.explosionRadius=meta.explosionRadius; c.tech=meta.tech;
		c.hazardRadius=std::max(c.armed ? c.groundRange+c.radius : 0.f,c.explosionRadius);
		outBounds.largestRange=std::max(outBounds.largestRange,c.hazardRadius);
		// Reclaimers can be unarmed and exceed 600 elmos (including the
		// advanced Legion construction turret). Keep this separate from the
		// legacy weapon bound so existing ranged-query semantics stay exact.
		outBounds.largestCohortHazard=std::max(outBounds.largestCohortHazard,std::max(c.hazardRadius,
			c.def->IsAbleToReclaim()?c.def->GetBuildDistance()+c.radius:0.f));
		if(!(c.hazardRadius<=0.f)) {
			outBounds.nonnegativeHazardCosts=outBounds.nonnegativeHazardCosts && std::isfinite(c.cost) && c.cost>=0.f;
			if(!c.mobile) {
				outStatic.Add(P(c.pos),int(out.size()));
				outBounds.largestStaticRange=std::max(outBounds.largestStaticRange,c.hazardRadius);
				outBounds.finiteStaticHazards=outBounds.finiteStaticHazards && std::isfinite(c.hazardRadius);
			}
		}
		outEnemies.Add(P(c.pos),int(out.size()));
		if (!c.def->IsAbleToFly()) outObjectives.push_back(int(out.size()));
		out.push_back(c);
		outClusters.Get(int(c.pos.x/CLUSTER_CELL),int(c.pos.z/CLUSTER_CELL))+=c.cost;
	}
	// A small shared strategic shortlist bounds distant selection per shooter.
	// Local contacts are never truncated; nearby emergencies retain response.
	const auto rank = [&out](int a,int b) {
		const auto& x=out[a]; const auto& y=out[b];
		const float vx=x.cost*(x.mobile?1.f:2.f), vy=y.cost*(y.mobile?1.f:2.f);
		return vx==vy ? x.id<y.id : vx>vy;
	};
	// Fixed shortlist: O(E log 16), rather than sorting every enemy per frame.
	std::partial_sort(outObjectives.begin(),outObjectives.begin()+std::min(OBJECTIVE_COUNT,outObjectives.size()),outObjectives.end(),rank);
	if (outObjectives.size()>OBJECTIVE_COUNT) outObjectives.resize(OBJECTIVE_COUNT);
}

// Owner 2026-11-02: ghost porc. An identified armed structure out of radar
// and LOS whose spot has not been seen empty (the map manager sets HIDDEN
// then; same rule as BattleAnalysis' ghost images). Last-known state only:
// no engine reads. Moved here from CRangedWorld::Refresh at the D-462 merge.
void CRangedObservation::BuildGhosts(CCircuitAI* ai)
{
	ghosts.clear(); ghostHazards.Clear(); largestGhostHazard=0.f;
	for (const auto& [id,e]:ai->GetEnemyManager()->GetEnemyUnits()) {
		if (!e || e->IsInRadarOrLOS()) continue;
		const auto& g=e->GetData();
		CCircuitDef* gd=e->GetCircuitDef();
		if (!gd || gd->IsMobile() || gd->IsAbleToFly() || gd->IsRoleSuper() || !gd->HasSurfToLand()
			|| (g.losStatus & (SEnemyData::DEAD|SEnemyData::DYING|SEnemyData::NEUTRAL|SEnemyData::HIDDEN))
			|| (e->IsIgnore() && !gd->IsIgnore()) || e->IsBeingBuilt()
			|| !std::isfinite(e->GetPos().x) || !std::isfinite(e->GetPos().z)) continue;
		Contact c; c.id=id; c.def=gd; c.pos=e->GetPos(); c.ghost=true;
		c.health=std::max(1.f,e->GetHealth()); c.radius=e->GetRadius(); c.cost=e->GetCost();
		c.armed=true; c.groundRange=gd->GetMaxRange(CCircuitDef::RangeType::LAND);
		// Ghosts past the longest configurable ghost reach are never read.
		if (!(c.groundRange>0.f) || c.groundRange>ranged_policy_defaults::GHOST_PORC_MAX_RANGE) continue;
		const auto& meta=MetadataFor(gd);
		c.armor=meta.armor; c.explosionRadius=meta.explosionRadius; c.tech=meta.tech;
		c.hazardRadius=std::max(c.groundRange+c.radius,c.explosionRadius);
		if (!std::isfinite(c.hazardRadius) || !std::isfinite(c.cost) || c.cost<0.f) continue;
		largestGhostHazard=std::max(largestGhostHazard,c.hazardRadius);
		ghostHazards.Add(P(c.pos),int(ghosts.size()));
		ghosts.push_back(c);
	}
}

void CRangedObservation::VerifyContacts(CCircuitAI* ai)
{
	ContactBounds fresh;
	BuildContacts(ai,verifyContacts,verifyObjectives,verifyEnemies,verifyStatic,verifyClusters,fresh);
	bool equal=verifyContacts.size()==contacts.size() && verifyObjectives==objectives
		&& Same(fresh.largestRange,bounds.largestRange) && Same(fresh.largestStaticRange,bounds.largestStaticRange)
		&& Same(fresh.largestCohortHazard,bounds.largestCohortHazard)
		&& fresh.nonnegativeHazardCosts==bounds.nonnegativeHazardCosts && fresh.finiteStaticHazards==bounds.finiteStaticHazards;
	for(size_t i=0;equal && i<contacts.size();++i) {
		const auto& a=contacts[i]; const auto& b=verifyContacts[i];
		equal=a.id==b.id && a.armor==b.armor && a.def==b.def && Same(a.pos,b.pos) && Same(a.velocity,b.velocity)
			&& Same(a.health,b.health) && Same(a.radius,b.radius) && Same(a.cost,b.cost) && Same(a.groundRange,b.groundRange)
			&& Same(a.explosionRadius,b.explosionRadius) && Same(a.hazardRadius,b.hazardRadius) && Same(a.tech,b.tech)
			&& a.los==b.los && a.armed==b.armed && a.mobile==b.mobile;
		if(equal) {
			const int x=int(a.pos.x/CLUSTER_CELL), z=int(a.pos.z/CLUSTER_CELL);
			const float* shared=clusterValues.Find(x,z); const float* own=verifyClusters.Find(x,z);
			equal=(shared==nullptr)==(own==nullptr) && (!shared || Same(*shared,*own));
		}
	}
	if(!equal) ai->LOG("[INVARIANT] INV-247 shared ranged contacts differ from a private build (team %d frame %d)",ai->GetTeamId(),ai->GetLastFrame());
}

const CRangedObservation::Friend* CRangedObservation::PrototypeFor(int definitionId)
{
	// Definitions and their (mutable) ranged policy are read from the ally
	// team's authority, as the private snapshot did; restamped every frame.
	CCircuitAI* authority=allyTeam->GetAuthority();
	const size_t definitionCount=size_t(authority->GetDefCount())+1;
	if(prototypes.size()!=definitionCount) {
		prototypes.resize(definitionCount);
		prototypeFrames.assign(definitionCount,-1);
	}
	if(definitionId<=0 || size_t(definitionId)>=definitionCount) return nullptr;
	auto& prototype=prototypes[definitionId];
	if(prototypeFrames[definitionId]!=friendFrame) {
		prototypeFrames[definitionId]=friendFrame;
		auto* definition=authority->GetCircuitDef(definitionId);
		prototype.def=definition->IsAbleToFly() ? nullptr : definition;
		if(prototype.def) {
			const auto& meta=MetadataFor(definition);
			prototype.radius=definition->GetRadius();
			prototype.screen=definition->IsAttacker() && (!definition->IsAttrRanged() || definition->GetRangedPolicy().coordinated);
			prototype.radar=meta.radar; prototype.jammer=meta.jammer; prototype.los=meta.los;
			// D-295: O(D) per frame with the existing prototype; never per unit.
			prototype.range=prototype.screen ? definition->GetMaxRange(CCircuitDef::RangeType::LAND) : 0.f;
			prototype.assist=definition->IsAttrRanged() && definition->GetRangedPolicy().assistRadius>0.f;
		}
	}
	return prototype.def ? &prototype : nullptr;
}

const CRangedObservation::Friend* CRangedObservation::Observe(int id)
{
	// Each allied unit's definition id and position are read once per frame,
	// whichever cell query (or the full read) meets it first.
	Seen scratch; Seen& s=(id>=0 && size_t(id)<seen.size()) ? seen[size_t(id)] : scratch;
	if(s.frame!=friendFrame) {
		s.frame=friendFrame; s.ground=false;
		s.index=reader->GetCallback()->Unit_GetDefId(id);
		const Friend* prototype=PrototypeFor(s.index);
		if(prototype) {
			float raw[3]; reader->GetUnitAPI()->GetPosition(id,raw);
			s.pos=AIFloat3(raw[0],raw[1],raw[2]); terrain::CTerrainData::CorrectPosition(s.pos);
			s.ground=true;
		}
	}
	if(!s.ground) return nullptr;
	observed=prototypes[size_t(s.index)]; observed.id=id; observed.pos=s.pos; observed.combatHealth=-1.f;
	return &observed;
}

const CRangedObservation::Friend* CRangedObservation::ObserveDirect(int id)
{
	// Same reads as Observe, in the same order, without caching.
	const int definitionId=reader->GetCallback()->Unit_GetDefId(id);
	const Friend* prototype=PrototypeFor(definitionId);
	if(!prototype) return nullptr;
	float raw[3]; reader->GetUnitAPI()->GetPosition(id,raw);
	observed=*prototype; observed.id=id; observed.combatHealth=-1.f;
	observed.pos=AIFloat3(raw[0],raw[1],raw[2]); terrain::CTerrainData::CorrectPosition(observed.pos);
	return &observed;
}

int CRangedObservation::AppendFriend(const Friend& friendly)
{
	friends.push_back(friendly);
	loadedRadius=std::max(loadedRadius,friendly.radius);
	if(friendly.screen && !friendly.assist) screenRange=std::max(screenRange,friendly.range);
	return int(friends.size())-1;
}

void CRangedObservation::ResetFriends(int frame)
{
	if(verify && friendFrame>=0) CompareLegacyFriends();
	preferFull=friendFrame>=0 && FullReadCheaper(friendCells.Touched());
	cellSpend=0.0;
	friends.clear(); friendCells.Reset(); screenRange=loadedRadius=0.f; cellsLoaded=false;
	friendFrame=frame; friendEpoch=epoch;
	if(verify) CaptureLegacyFriends();
	// A frame expected to need the whole side reads it now, so every query
	// of the frame can use the exact largest friend radius (FriendRadius).
	if(preferFull) LoadAllFriends();
}

void CRangedObservation::BindFriends(CCircuitAI* ai)
{
	reader=ai;
	if(friendFrame!=ai->GetLastFrame() || friendEpoch!=epoch) ResetFriends(ai->GetLastFrame());
}

float CRangedObservation::FriendRadius()
{
	// Complete: the largest radius of all friends, the pre-D-462 value.
	// Partial: an upper bound, which widens exact broad phases only.
	return friendCells.Complete() ? loadedRadius : FriendRadiusBound();
}

float CRangedObservation::FriendRadiusBound()
{
	if(radiusEpoch!=epoch || radiusBound<0.f) {
		radiusBound=0.f; radiusEpoch=epoch;
		for(auto& definition:allyTeam->GetAuthority()->GetCircuitDefs())
			if(!definition.IsAbleToFly()) radiusBound=std::max(radiusBound,definition.GetRadius());
	}
	return radiusBound;
}

void CRangedObservation::LoadCell(int x,int z)
{
	const bool measuredCosts=cellCost>=0.0 && fullCost>=0.0;
	if(preferFull || (measuredCosts ? cellSpend+cellCost>fullCost : friendCells.Touched()>=FRIEND_FULL_READ_CELLS)) {
		LoadAllFriends(x,z);
		return;
	}
	performance::Scope measured(reader,performance::RANGED_FRIENDS);
	const auto start=CostClock::now();
	cellsLoaded=true;
	const float size=friendCells.CellSize();
	const bool border=x==0 || z==0 || x==friendCells.Columns()-1 || z==friendCells.Rows()-1;
	const float radius=size*HALF_DIAGONAL+FRIEND_QUAD_DRIFT_MARGIN+(border?FRIEND_EDGE_MARGIN:0.f);
	const AIFloat3 center((float(x)+.5f)*size,0.f,(float(z)+.5f)*size);
	// The callback wrapper reuses its result vector; copy before further reads.
	const auto& found=reader->GetCallback()->GetFriendlyUnitIdsIn(center,radius,false);
	local.assign(found.begin(),found.end());
	// Ascending IDs inside a cell: the order a full sorted read inserts them.
	std::sort(local.begin(),local.end());
	for(const int id:local) {
		const Friend* observed=Observe(id);
		if(!observed || friendCells.Coord(observed->pos.x)!=x || friendCells.Coord(observed->pos.z)!=z) continue;
		friendCells.Append(x,z,AppendFriend(*observed));
	}
	const double spent=Elapsed(start);
	cellSpend+=spent;
	cellCost=cellCost<0.0 ? spent : cellCost+FRIEND_COST_SMOOTHING*(spent-cellCost);
}

bool CRangedObservation::FullReadCheaper(int cells) const
{
	if(cellCost<0.0 || fullCost<0.0) return cells>=FRIEND_FULL_READ_CELLS;
	return double(cells)*cellCost>fullCost;
}

void CRangedObservation::LoadAllFriends(int adoptX,int adoptZ)
{
	if(friendCells.Complete()) return;
	performance::Scope measured(reader,performance::RANGED_FRIENDS);
	const auto start=CostClock::now();
	const int count=reader->GetUnitAPI()->GetFriendlyUnitIds(ids);
	order.Sort(ids,count);
	const int pass=friendCells.BeginPass();
	// Called from inside a cell load: that cell is marked loaded but empty.
	if(adoptX>=0) friendCells.Adopt(adoptX,adoptZ,pass);
	// Before any cell load, no unit was observed this frame and none will be
	// after this read: skip the per-unit cache (one random write per unit).
	const bool fresh=!cellsLoaded;
	for(int i=0;i<count;++i) {
		const int id=ids[i];
		const Friend* observed=fresh ? ObserveDirect(id) : Observe(id);
		if(!observed) continue;
		const int x=friendCells.Coord(observed->pos.x), z=friendCells.Coord(observed->pos.z);
		if(!friendCells.Admit(x,z,pass)) continue;
		friendCells.Append(x,z,AppendFriend(*observed));
	}
	friendCells.MarkComplete();
	const double spent=Elapsed(start);
	fullCost=fullCost<0.0 ? spent : fullCost+FRIEND_COST_SMOOTHING*(spent-fullCost);
}

void CRangedObservation::CaptureLegacyFriends()
{
	// The pre-D-462 full read, with its own engine calls and no shared cache.
	legacyFriends.clear(); legacyCells.Clear(); legacyScreenRange=legacyRadius=0.f;
	legacyFrame=friendFrame;
	std::vector<int> all;
	const int count=reader->GetUnitAPI()->GetFriendlyUnitIds(all);
	std::sort(all.begin(),all.begin()+count);
	CCircuitAI* authority=allyTeam->GetAuthority();
	for(int i=0;i<count;++i) {
		const int id=all[i];
		const int definitionId=reader->GetCallback()->Unit_GetDefId(id);
		if(definitionId<=0 || definitionId>authority->GetDefCount()) continue;
		auto* definition=authority->GetCircuitDef(definitionId);
		if(definition->IsAbleToFly()) continue;
		float raw[3]; reader->GetUnitAPI()->GetPosition(id,raw);
		AIFloat3 position(raw[0],raw[1],raw[2]); terrain::CTerrainData::CorrectPosition(position);
		Friend f; f.id=id; f.pos=position; f.def=definition; f.radius=definition->GetRadius();
		f.screen=definition->IsAttacker() && (!definition->IsAttrRanged() || definition->GetRangedPolicy().coordinated);
		const auto& meta=MetadataFor(definition);
		f.radar=meta.radar; f.jammer=meta.jammer; f.los=meta.los;
		f.range=f.screen ? definition->GetMaxRange(CCircuitDef::RangeType::LAND) : 0.f;
		f.assist=definition->IsAttrRanged() && definition->GetRangedPolicy().assistRadius>0.f;
		legacyRadius=std::max(legacyRadius,f.radius);
		if(f.screen && !f.assist) legacyScreenRange=std::max(legacyScreenRange,f.range);
		legacyCells.Add(P(f.pos),int(legacyFriends.size()));
		legacyFriends.push_back(f);
	}
}

void CRangedObservation::CompareLegacyFriends()
{
	if(legacyFrame!=friendFrame || reader==nullptr) return;
	bool equal=true;
	size_t loaded=0;
	const float size=friendCells.CellSize();
	for(int z=0;equal && z<friendCells.Rows();++z) for(int x=0;equal && x<friendCells.Columns();++x) {
		const auto* values=friendCells.Values(x,z);
		if(!values) continue;
		std::vector<int> expected;
		legacyCells.Query({(float(x)+.5f)*size,(float(z)+.5f)*size},0.f,[&](int i) { expected.push_back(i); });
		equal=expected.size()==values->size();
		for(size_t k=0;equal && k<expected.size();++k) {
			const auto& a=friends[size_t((*values)[k])]; const auto& b=legacyFriends[size_t(expected[k])];
			equal=a.id==b.id && Same(a.pos,b.pos) && a.def==b.def && Same(a.radius,b.radius) && a.screen==b.screen
				&& Same(a.radar,b.radar) && Same(a.jammer,b.jammer) && Same(a.los,b.los) && Same(a.range,b.range) && a.assist==b.assist;
		}
		loaded+=values->size();
	}
	// INV-148: every loaded friend (ID, position, definition, radius, sensors,
	// screen and range) equals the legacy sorted full read, cell by cell.
	if(!equal) reader->LOG("[INVARIANT] INV-148 ranged friends differ from the legacy full read (team %d frame %d)",reader->GetTeamId(),friendFrame);
	// INV-248: the bounds and completeness that size every friend query.
	bool bounds=FriendRadiusBound()>=legacyRadius;
	if(friendCells.Complete()) bounds=bounds && loaded==legacyFriends.size()
		&& Same(screenRange,legacyScreenRange) && Same(loadedRadius,legacyRadius);
	if(!bounds) reader->LOG("[INVARIANT] INV-248 ranged friend bounds or completeness differ from a full read (team %d frame %d)",reader->GetTeamId(),friendFrame);
}
}
