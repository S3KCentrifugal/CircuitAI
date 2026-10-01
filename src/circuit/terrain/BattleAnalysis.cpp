/*
 * BattleAnalysis.cpp
 *
 * D-126: see BattleAnalysis.h and doc/roles/tech-weapon-clusters.md.
 */

#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "terrain/TerrainData.h"
#include "map/ThreatMap.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitWDef.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "spring/SpringMap.h"

#include "UnitDef.h"
#include "WeaponDef.h"
#include "WeaponMount.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <queue>
#include <string>

namespace circuit {

using namespace springai;
using namespace terrain;

#define BA_CELL          64    // route and water grid, elmos
#define BA_HEAT_CELL     256   // combat and air heat grid, elmos
#define BA_WADE_DEPTH    20.f  // BOT/TANK movedefs: land units stop 20 deep
#define BA_SHIP_DEPTH    8.f   // BOAT3/4/5
#define BA_SUB_DEPTH     15.f  // UBOAT4: submarines
#define BA_CLIFF_GRADE   0.75f // steeper than this from the water: nothing climbs out
#define BA_HOVER_GRADE   0.45f
#define BA_NEAR_WATER    600.f // a beach's water must be this close to count

static const int NB8[8][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};

CBattleAnalysis::CBattleAnalysis(CCircuitAI* circuit)
		: circuit(circuit)
		, cellSize(BA_CELL)
		, gw(0), gh(0)
		, analysed(false)
		, heatCell(BA_HEAT_CELL)
		, hw(0), hh(0)
		, lastDecay(0)
		, combatHalfLife(180.f)
		, airHalfLife(300.f)
		, waterBuilt(false)
{
	for (int i = 0; i < _KIND_SIZE_; ++i) {
		cost[i] = 0.f;
		count[i] = 0;
	}
}

CBattleAnalysis::~CBattleAnalysis()
{
    CancelLaneRequest();
}

// ---------------------------------------------------------------- grid

void CBattleAnalysis::EnsureGrid()
{
	if (gw > 0) {
		return;
	}
	gw = std::max(1, CTerrainManager::GetTerrainWidth() / cellSize);
	gh = std::max(1, CTerrainManager::GetTerrainHeight() / cellSize);
	height.assign(gw * gh, 0.f);
	maxHeight.assign(gw * gh, 0.f);
	const SAreaData* ad = circuit->GetTerrainManager()->GetAreaData();
	const float W = CTerrainManager::GetTerrainWidth() - 1, H = CTerrainManager::GetTerrainHeight() - 1;
	for (int z = 0; z < gh; ++z) {
		for (int x = 0; x < gw; ++x) {
			float sum = 0.f, hi = -1e9f;
			int n = 0;
			for (int sz = 0; sz < 4; ++sz) {
				for (int sx = 0; sx < 4; ++sx) {
					const float px = std::min(W, float(x * cellSize + 8 + sx * 16));
					const float pz = std::min(H, float(z * cellSize + 8 + sz * 16));
					const float h = ad->GetElevationAt(px, pz);
					sum += h;
					hi = std::max(hi, h);
					++n;
				}
			}
			height[z * gw + x] = sum / n;
			maxHeight[z * gw + x] = hi;
		}
	}
	hw = std::max(1, CTerrainManager::GetTerrainWidth() / heatCell);
	hh = std::max(1, CTerrainManager::GetTerrainHeight() / heatCell);
	combat.assign(hw * hh, 0.f);
	air.assign(hw * hh, 0.f);
	BuildPass();   // D-127: per movement class, from the engine's slope map
}

int CBattleAnalysis::Cell(const AIFloat3& pos) const
{
	const int x = std::max(0, std::min(gw - 1, int(pos.x) / cellSize));
	const int z = std::max(0, std::min(gh - 1, int(pos.z) / cellSize));
	return z * gw + x;
}

AIFloat3 CBattleAnalysis::CellPos(int c) const
{
	const float x = (c % gw) * cellSize + cellSize * 0.5f;
	const float z = (c / gw) * cellSize + cellSize * 0.5f;
	return AIFloat3(x, height[c], z);
}

float CBattleAnalysis::CellHeight(int c) const { return height[c]; }
float CBattleAnalysis::CellMaxHeight(int c) const { return maxHeight[c]; }

float CBattleAnalysis::Height(const AIFloat3& pos) const
{
	const float x = std::max(0.f, std::min(float(CTerrainManager::GetTerrainWidth() - 1), pos.x));
	const float z = std::max(0.f, std::min(float(CTerrainManager::GetTerrainHeight() - 1), pos.z));
	return circuit->GetTerrainManager()->GetAreaData()->GetElevationAt(x, z);
}

float CBattleAnalysis::HeightAbove(const AIFloat3& pos, float radius) const
{
	float sum = 0.f;
	for (int i = 0; i < 8; ++i) {
		const float a = i * float(M_PI) / 4.f;
		sum += Height(AIFloat3(pos.x + std::cos(a) * radius, 0.f, pos.z + std::sin(a) * radius));
	}
	return Height(pos) - sum / 8.f;
}

// ---------------------------------------------------------------- range

// The engine's range test (Weapon.cpp TestRange, Cannon.cpp GetStaticRange2D):
// beams and missiles use a sphere scaled by heightmod; a cylinder-targeting
// weapon keeps its flat range; a cannon gains range firing downhill.
// the unit's longest-range weapon (played: the Starfall's recorded weapon is a
// short auxiliary mount, so its reach read 1 to 4 elmos)
CWeaponDef* CBattleAnalysis::MainWeapon(const CCircuitDef* cdef) const
{
	if ((cdef == nullptr) || (cdef->GetDef() == nullptr)) {
		return nullptr;
	}
	auto it = mainWeapon.find(cdef->GetId());
	if (it != mainWeapon.end()) {
		return it->second;
	}
	CWeaponDef* best = cdef->GetWeaponDef();
	float bestRange = (best != nullptr) ? best->GetRange() : 0.f;
	for (WeaponMount* mount : cdef->GetDef()->GetWeaponMounts()) {
		WeaponDef* wd = mount->GetWeaponDef();
		CWeaponDef* cw = circuit->GetWeaponDef(wd->GetWeaponDefId());
		if ((cw != nullptr) && (cw->GetRange() > bestRange)) {
			bestRange = cw->GetRange();
			best = cw;
		}
		delete wd;
		delete mount;
	}
	mainWeapon[cdef->GetId()] = best;
	return best;
}

float CBattleAnalysis::MainRange(const CCircuitDef* cdef) const
{
	CWeaponDef* w = MainWeapon(cdef);
	return (w == nullptr) ? 0.f : w->GetRange();
}

float CBattleAnalysis::InterceptorCoverage(const CCircuitDef* cdef) const
{
	if (cdef == nullptr || cdef->GetDef() == nullptr) return 0.f;
	float coverage = 0.f;
	// Generated wrapper children are caller-owned; the UnitDef is borrowed.
	for (WeaponMount* raw : cdef->GetDef()->GetWeaponMounts()) {
		const std::unique_ptr<WeaponMount> mount(raw);
		const std::unique_ptr<WeaponDef> weapon(mount->GetWeaponDef());
		if (weapon != nullptr && weapon->GetInterceptor() != 0) {
			const float range = weapon->GetCoverageRange();
			if (std::isfinite(range)) coverage = std::max(coverage, range);
		}
	}
	return coverage;
}

AIFloat3 CBattleAnalysis::GetAirContactPos(int index) const
{
	return index >= 0 && static_cast<size_t>(index) < airContacts.size()
		? airContacts[index].pos : AIFloat3(-1.f, 0.f, -1.f);
}

float CBattleAnalysis::GetAirContactCost(int index) const
{
	return index >= 0 && static_cast<size_t>(index) < airContacts.size() ? airContacts[index].cost : 0.f;
}

float CBattleAnalysis::EffectiveRange(const CCircuitDef* cdef, const AIFloat3& from, const AIFloat3& to) const
{
	CWeaponDef* main = MainWeapon(cdef);
	if (main == nullptr) {
		return 0.f;
	}
	WeaponDef* wd = main->GetDef();
	const float range = wd->GetRange();
	// a weapon on or over water stands, and aims, at the surface
	const float heightDiff = (std::max(0.f, Height(to)) - std::max(0.f, Height(from))) * wd->GetHeightMod();   // negative: firing downhill
	const float cyl = wd->GetCylinderTargetting();
	if (cyl > 0.f) {
		return (cyl * range > std::fabs(heightDiff)) ? range : 0.f;
	}
	const std::string type = wd->GetType();
	if (type != "Cannon") {
		return std::sqrt(std::max(0.f, range * range - heightDiff * heightDiff));
	}
	const float speed = wd->GetProjectileSpeed();   // elmos per frame
	float grav = wd->GetMyGravity();
	grav = (grav > 0.f) ? -grav : circuit->GetMap()->GetGravity();
	if ((speed <= 0.f) || (grav >= 0.f)) {
		return range;
	}
	auto calc = [speed, grav](float hd, float rbf, float hbf) {
		const float speed2D = speed * 0.7071067f;
		const float sq = speed2D * speed2D;
		if (hd < -100.f) {
			hd *= hbf;
		} else if (hd < 0.f) {
			hd *= (1.f + (hbf - 1.f) * -hd / 100.f);
		}
		const float root = sq + 2.f * grav * hd;
		if (root < 0.f) {
			return 0.f;
		}
		return rbf * (sq + speed2D * std::sqrt(root)) / -grav;
	};
	const float hbfDef = wd->GetHeightBoostFactor();
	const float base = calc(0.f, 1.f, hbfDef);
	const float rbf = (base > 0.f) ? std::max(0.f, std::min(1.f, range / base)) : 0.f;
	float hbf = hbfDef;
	if ((hbf < 0.f) && (rbf > 0.f)) {
		hbf = (2.f - rbf) / std::sqrt(rbf);
	}
	return calc(heightDiff, rbf, hbf);
}

float CBattleAnalysis::ShotEnergy(const CCircuitDef* cdef) const
{
	CWeaponDef* w = MainWeapon(cdef);
	return (w == nullptr) ? 0.f : w->GetCostEShot();
}

float CBattleAnalysis::ShotReload(const CCircuitDef* cdef) const
{
	CWeaponDef* w = MainWeapon(cdef);
	return (w == nullptr) ? 0.f : w->GetDef()->GetReload();
}

bool CBattleAnalysis::LineOfFire(const AIFloat3& from, const AIFloat3& to, float muzzle) const
{
	const float h0 = Height(from) + muzzle;
	const float h1 = Height(to) + 16.f;
	const float dx = to.x - from.x, dz = to.z - from.z;
	const float len = std::sqrt(dx * dx + dz * dz);
	const int steps = std::max(1, int(len / 32.f));
	for (int i = 1; i < steps; ++i) {
		const float t = float(i) / steps;
		const float ground = Height(AIFloat3(from.x + dx * t, 0.f, from.z + dz * t));
		if (ground > h0 + (h1 - h0) * t) {
			return false;
		}
	}
	return true;
}

// ---------------------------------------------------------------- routes

// D-127: the engine's own test, per cell: the bot class (54 degrees, 20 deep)
// for the weapon routes, the amphibious class for landing routes
bool CBattleAnalysis::Passable(int from, int to, bool amph) const
{
	const std::vector<char>& p = pass[amph ? L_AMPH : L_BOT];
	return p[from] && p[to];
}

void CBattleAnalysis::Dijkstra(int start, const Grid& penalty, bool amph, Grid& dist, std::vector<int>& prev) const
{
	const int N = gw * gh;
	dist.assign(N, std::numeric_limits<float>::max());
	prev.assign(N, -1);
	using QE = std::pair<float, int>;
	std::priority_queue<QE, std::vector<QE>, std::greater<QE>> q;
	dist[start] = 0.f;
	q.push({0.f, start});
	while (!q.empty()) {
		const QE e = q.top();
		q.pop();
		const int c = e.second;
		if (e.first > dist[c]) {
			continue;
		}
		const int cx = c % gw, cz = c / gw;
		for (const auto& d : NB8) {
			const int nx = cx + d[0], nz = cz + d[1];
			if ((nx < 0) || (nz < 0) || (nx >= gw) || (nz >= gh)) {
				continue;
			}
			const int n = nz * gw + nx;
			if (!Passable(c, n, amph)) {
				continue;
			}
			const float step = cellSize * ((d[0] != 0 && d[1] != 0) ? 1.4142f : 1.f);
			const float grade = std::fabs(height[n] - height[c]) / step;
			const float w = step * (1.f + 2.f * grade) * penalty[n];
			if (dist[c] + w < dist[n]) {
				dist[n] = dist[c] + w;
				prev[n] = c;
				q.push({dist[n], n});
			}
		}
	}
}

int CBattleAnalysis::Analyse(const AIFloat3& base, int alternatives, float chokeMaxHalfWidth, float chokeMerge)
{
	EnsureGrid();
	const int N = gw * gh;
	routeHeat.assign(N, 0.f);
	routeShare.assign(N, -1.f);
	lane.assign(N, 0);
	routes.clear();
	chokes.clear();

	std::vector<int> clr;
	Clearance(clr);

	const int baseCell = Cell(base);
	Grid penalty(N, 1.f);
	Grid dist;
	std::vector<int> prev;
	for (int it = 0; it < std::max(1, alternatives); ++it) {
		Dijkstra(baseCell, penalty, false, dist, prev);
		for (const AIFloat3& s : sources) {
			const int sc = Cell(s);
			if (dist[sc] == std::numeric_limits<float>::max()) {
				continue;   // no land route: the water analysis covers it
			}
			std::vector<int> path;
			for (int c = sc; c >= 0; c = prev[c]) {
				path.push_back(c);
				if (c == baseCell) {
					break;
				}
			}
			std::reverse(path.begin(), path.end());   // base first
			const float total = std::max(1.f, dist[sc]);
			for (int c : path) {
				routeHeat[c] += 1.f;
				const float sh = dist[c] / total;
				if ((routeShare[c] < 0.f) || (sh < routeShare[c])) {
					routeShare[c] = sh;
				}
				penalty[c] *= 4.f;
				if (it == 0) {
					const int cx = c % gw, cz = c / gw;
					lane[c] = 1;
					for (const auto& d : NB8) {
						const int nx = cx + d[0], nz = cz + d[1];
						if ((nx >= 0) && (nz >= 0) && (nx < gw) && (nz < gh)) {
							lane[nz * gw + nx] = 1;
						}
					}
				}
			}
			routes.push_back(std::move(path));
		}
	}

	// chokes: along each route, the narrowest points within the corridor limit
	std::vector<SChoke> cand;
	const int maxClr = std::max(1, int(chokeMaxHalfWidth / cellSize));
	for (const std::vector<int>& path : routes) {
		const int L = (int)path.size();
		for (int i = 3; i < L - 3; ++i) {
			const int c = path[i];
			if (clr[c] > maxClr) {
				continue;
			}
			bool isMin = true;
			for (int k = i - 3; k <= i + 3; ++k) {
				if (clr[path[k]] < clr[c]) {
					isMin = false;
					break;
				}
			}
			const float sh = routeShare[c];
			if (!isMin || (sh < 0.05f) || (sh > 0.95f)) {
				continue;
			}
			AIFloat3 a = CellPos(path[i - 3]), b = CellPos(path[i + 3]);
			AIFloat3 dir(b.x - a.x, 0.f, b.z - a.z);
			const float len = std::sqrt(dir.x * dir.x + dir.z * dir.z);
			if (len > 0.f) {
				dir.x /= len;
				dir.z /= len;
			}
			cand.push_back({CellPos(c), dir, float(2 * clr[c] * cellSize), routeHeat[c], sh});
		}
	}
	std::sort(cand.begin(), cand.end(), [](const SChoke& l, const SChoke& r) {
		return (l.heat != r.heat) ? (l.heat > r.heat) : (l.width < r.width);
	});
	for (const SChoke& k : cand) {
		bool close = false;
		for (const SChoke& o : chokes) {
			if (k.pos.SqDistance2D(o.pos) < chokeMerge * chokeMerge) {
				close = true;
				break;
			}
		}
		if (!close) {
			chokes.push_back(k);
		}
	}
	analysed = true;
	circuit->LOG("BATTLE: analysed from (%i, %i): %i sources, %i routes, %i chokes", int(base.x), int(base.z),
			(int)sources.size(), (int)routes.size(), (int)chokes.size());
	return (int)chokes.size();
}

float CBattleAnalysis::RouteHeat(const AIFloat3& pos) const
{
	return routeHeat.empty() ? 0.f : routeHeat[Cell(pos)];
}

float CBattleAnalysis::RouteShare(const AIFloat3& pos) const
{
	return routeShare.empty() ? -1.f : routeShare[Cell(pos)];
}

bool CBattleAnalysis::IsFriendlyLane(const AIFloat3& pos) const
{
	return !lane.empty() && lane[Cell(pos)];
}

AIFloat3 CBattleAnalysis::GetChokePos(int i) const { return ((i >= 0) && (i < (int)chokes.size())) ? chokes[i].pos : AIFloat3(-1.f, 0.f, 0.f); }
AIFloat3 CBattleAnalysis::GetChokeDir(int i) const { return ((i >= 0) && (i < (int)chokes.size())) ? chokes[i].dir : AIFloat3(1.f, 0.f, 0.f); }
float CBattleAnalysis::GetChokeWidth(int i) const { return ((i >= 0) && (i < (int)chokes.size())) ? chokes[i].width : 0.f; }
float CBattleAnalysis::GetChokeHeat(int i) const { return ((i >= 0) && (i < (int)chokes.size())) ? chokes[i].heat : 0.f; }
float CBattleAnalysis::GetChokeShare(int i) const { return ((i >= 0) && (i < (int)chokes.size())) ? chokes[i].share : 0.f; }

AIFloat3 CBattleAnalysis::GetRoutePoint(int route, float share) const
{
	if ((route < 0) || (route >= (int)routes.size()) || routes[route].empty()) {
		return AIFloat3(-1.f, 0.f, 0.f);
	}
	const std::vector<int>& p = routes[route];
	const int i = std::max(0, std::min((int)p.size() - 1, int(share * (p.size() - 1))));
	return CellPos(p[i]);
}

// ---------------------------------------------------------------- heat

void CBattleAnalysis::Decay(Grid& g, float factor)
{
	for (float& v : g) {
		v *= factor;
	}
}

void CBattleAnalysis::AddHeat(Grid& g, const AIFloat3& pos, float v)
{
	if (g.empty()) {
		return;
	}
	const int x = std::max(0, std::min(hw - 1, int(pos.x) / heatCell));
	const int z = std::max(0, std::min(hh - 1, int(pos.z) / heatCell));
	g[z * hw + x] += v;
}

float CBattleAnalysis::SumHeat(const Grid& g, const AIFloat3& pos, float radius) const
{
	if (g.empty()) {
		return 0.f;
	}
	const int r = std::max(0, int(radius / heatCell));
	const int x0 = int(pos.x) / heatCell, z0 = int(pos.z) / heatCell;
	float sum = 0.f;
	for (int z = std::max(0, z0 - r); z <= std::min(hh - 1, z0 + r); ++z) {
		for (int x = std::max(0, x0 - r); x <= std::min(hw - 1, x0 + r); ++x) {
			sum += g[z * hw + x];
		}
	}
	return sum;
}

void CBattleAnalysis::OnOwnDamaged(const AIFloat3& pos)
{
	EnsureGrid();
	AddHeat(combat, pos, 1.f);
}

void CBattleAnalysis::OnOwnLost(const AIFloat3& pos, float c)
{
	EnsureGrid();
	AddHeat(combat, pos, 1.f + c / 100.f);
}

void CBattleAnalysis::OnEnemyLost(const AIFloat3& pos, float c)
{
	EnsureGrid();
	AddHeat(combat, pos, 1.f + c / 100.f);
}

void CBattleAnalysis::Update(int frame)
{
	EnsureGrid();
	airContacts.clear();
    groundContacts.clear();
    observedWaterWeapons.assign(height.size(), 0.f);
	const float dt = float(frame - lastDecay) / FRAMES_PER_SEC;
	if (dt > 0.f) {
		Decay(combat, std::pow(0.5f, dt / combatHalfLife));
		Decay(air, std::pow(0.5f, dt / airHalfLife));
		lastDecay = frame;
	}
	for (int i = 0; i < _KIND_SIZE_; ++i) {
		cost[i] = 0.f;
		count[i] = 0;
	}
	for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		const CCircuitDef* d = e->GetCircuitDef();
		if (d == nullptr) {
			continue;
		}
		const float m = d->GetCostM();
        // Role-level target preferences (e.g. TECH ignoring T1 combat) must not
        // label an occupied foothold empty. Still respect hidden/dead/neutral
        // contacts and the game's explicit ignoredByAI exclusion.
        const bool observed = e->IsInRadarOrLOS()
            && !(e->GetData().losStatus & (SEnemyData::LosMask::HIDDEN | SEnemyData::LosMask::NEUTRAL
                | SEnemyData::LosMask::DYING | SEnemyData::LosMask::DEAD))
            && (!e->IsIgnore() || (d->IsIgnore() && e->GetUnit()->GetRulesParamFloat("ignoredByAI", 0.f) <= 0.f));
        // Current ally-visible contacts only. No hidden mobile or destroyed-memory targets.
        if (!d->IsAbleToFly() && observed && Height(e->GetPos()) >= 0.f) {
            const bool economy = !d->IsMobile() && (d->IsMex() || d->IsBuilder() || d->IsWind()
                || d->GetMaxRange() <= 0.f);
            groundContacts.push_back({e->GetPos(), m, economy});
        }
        // Some profiles intentionally zero torpedo-tower combat weights. The new
        // route query must still see an observed underwater weapon's coverage.
        // This does not alter the legacy threat maps or their callers.
        if (observed) {
            const AIFloat3& p = e->GetPos();
            const bool submerged = e->GetCircuitDef()->IsInWater(Height(p), p.y);
            if (submerged ? d->HasSubToWater() : d->HasSurfToWater()) {
                // Include cell discretisation and the moving unit's footprint.
                const float reach = d->GetMaxRange(CCircuitDef::RangeType::WATER) + 2.f * cellSize;
                const int x0 = std::max(0, int((p.x - reach) / cellSize));
                const int z0 = std::max(0, int((p.z - reach) / cellSize));
                const int x1 = std::min(gw - 1, int((p.x + reach) / cellSize));
                const int z1 = std::min(gh - 1, int((p.z + reach) / cellSize));
                for (int z = z0; z <= z1; ++z) for (int x = x0; x <= x1; ++x) {
                    const int cell = z * gw + x;
                    if (height[cell] < 0.f && CellPos(cell).SqDistance2D(p) <= reach * reach)
                        observedWaterWeapons[cell] = 1.f;
                }
            }
        }
		auto add = [this, m](Kind k) { cost[k] += m; ++count[k]; };
		if (d->IsAbleToFly()) {
			add(AIR);
			const AIFloat3& pos = e->GetPos();
			if (!e->IsHidden() && e->IsInRadarOrLOS() && std::isfinite(pos.x) && std::isfinite(pos.z)
				&& pos.x >= 0.f && pos.z >= 0.f && pos.x < circuit->GetTerrainManager()->GetTerrainWidth()
				&& pos.z < circuit->GetTerrainManager()->GetTerrainHeight()) {
				airContacts.push_back({pos, m});
			}
			if (!e->IsHidden()) {
				AddHeat(air, e->GetPos(), 1.f);
			}
			continue;
		}
		if (d->IsMobile()) {
			if (d->IsSubmarine()) {
				add(SUB);
			} else if (d->IsFloater()) {
				add(SHIP);
			} else if (d->IsSurfer()) {
				add(HOVER);
			} else if (d->IsAmphibious()) {
				add(AMPH);
			} else {
				add(LAND);
			}
			if (d->IsRoleArty()) {
				add(ARTY);
			}
			if (m >= 3000.f) {
				add(HEAVY);
			}
			if (!e->IsHidden() && (d->IsSubmarine() || d->IsFloater() || d->IsSurfer())) {
				MarkHostileWater(e->GetPos(), 256.f);
			}
			continue;
		}
		if (d->IsRoleSuper() && d->IsAttrStock()) {
			add(NUKE);
		} else if (d->GetMaxRange() >= 3000.f) {
			add(LRPC);
		} else if (d->GetMaxRange() > 0.f) {
			add(STATIC_DEF);
		}
	}
}

float CBattleAnalysis::AmphThreat(const AIFloat3& pos) const {
    const float coverage = observedWaterWeapons.empty() ? 0.f : observedWaterWeapons[Cell(pos)];
    return std::max(coverage, circuit->GetThreatMap()->GetAmphThreatAtPos(pos));
}
AIFloat3 CBattleAnalysis::GetGroundContactPos(int i) const {
    return i >= 0 && i < int(groundContacts.size()) ? groundContacts[i].pos : AIFloat3(-1.f, 0.f, -1.f);
}
float CBattleAnalysis::GetGroundContactCost(int i) const {
    return i >= 0 && i < int(groundContacts.size()) ? groundContacts[i].cost : 0.f;
}
bool CBattleAnalysis::IsGroundContactEconomy(int i) const {
    return i >= 0 && i < int(groundContacts.size()) && groundContacts[i].economy;
}
float CBattleAnalysis::CombatHeat(const AIFloat3& pos, float radius) const { return SumHeat(combat, pos, radius); }
float CBattleAnalysis::AirHeat(const AIFloat3& pos, float radius) const { return SumHeat(air, pos, radius); }

AIFloat3 CBattleAnalysis::CombatNear(const AIFloat3& from, float minHeat) const
{
	float best = std::numeric_limits<float>::max();
	AIFloat3 res(-1.f, 0.f, 0.f);
	for (int c = 0; c < (int)combat.size(); ++c) {
		if (combat[c] < minHeat) {
			continue;
		}
		const AIFloat3 p((c % hw) * heatCell + heatCell * 0.5f, 0.f, (c / hw) * heatCell + heatCell * 0.5f);
		const float d = from.SqDistance2D(p);
		if (d < best) {
			best = d;
			res = p;
		}
	}
	return res;
}

AIFloat3 CBattleAnalysis::AirCentre(const AIFloat3& pos, float radius) const
{
	const int r = std::max(0, int(radius / heatCell));
	const int x0 = int(pos.x) / heatCell, z0 = int(pos.z) / heatCell;
	float sum = 0.f, sx = 0.f, sz = 0.f;
	for (int z = std::max(0, z0 - r); z <= std::min(hh - 1, z0 + r); ++z) {
		for (int x = std::max(0, x0 - r); x <= std::min(hw - 1, x0 + r); ++x) {
			const float v = air.empty() ? 0.f : air[z * hw + x];
			sum += v;
			sx += v * (x * heatCell + heatCell * 0.5f);
			sz += v * (z * heatCell + heatCell * 0.5f);
		}
	}
	return (sum > 0.01f) ? AIFloat3(sx / sum, 0.f, sz / sum) : AIFloat3(-1.f, 0.f, 0.f);
}

float CBattleAnalysis::EnemyCost(int kind) const { return ((kind >= 0) && (kind < _KIND_SIZE_)) ? cost[kind] : 0.f; }
int CBattleAnalysis::EnemyCount(int kind) const { return ((kind >= 0) && (kind < _KIND_SIZE_)) ? count[kind] : 0; }

float CBattleAnalysis::SurfThreat(const AIFloat3& pos) const { return circuit->GetThreatMap()->GetSurfThreatAtPos(pos); }
float CBattleAnalysis::AirThreat(const AIFloat3& pos) const { return circuit->GetThreatMap()->GetAirThreatAtPos(pos); }

// ---------------------------------------------------------------- water

void CBattleAnalysis::Label(std::vector<int>& body, float minDepth)
{
	const int N = gw * gh;
	body.assign(N, -1);
	int next = 0;
	for (int s = 0; s < N; ++s) {
		if ((body[s] >= 0) || (maxHeight[s] > -minDepth)) {
			continue;
		}
		std::queue<int> q;
		q.push(s);
		body[s] = next;
		while (!q.empty()) {
			const int c = q.front();
			q.pop();
			const int cx = c % gw, cz = c / gw;
			for (int k = 0; k < 4; ++k) {
				const int nx = cx + NB8[k][0], nz = cz + NB8[k][1];
				if ((nx < 0) || (nz < 0) || (nx >= gw) || (nz >= gh)) {
					continue;
				}
				const int n = nz * gw + nx;
				if ((body[n] < 0) && (maxHeight[n] <= -minDepth)) {
					body[n] = next;
					q.push(n);
				}
			}
		}
		++next;
	}
}

void CBattleAnalysis::BuildWater()
{
	EnsureGrid();
	if (waterBuilt) {
		return;
	}
	Label(body8, BA_SHIP_DEPTH);
	Label(body15, BA_SUB_DEPTH);
	int n8 = 0, n15 = 0;
	for (int b : body8) n8 = std::max(n8, b + 1);
	for (int b : body15) n15 = std::max(n15, b + 1);
	hostile8.assign(n8, 0);
	hostile15.assign(n15, 0);
	waterBuilt = true;
}

int CBattleAnalysis::WaterBody(const AIFloat3& pos, bool subDepth) const
{
	if (!waterBuilt) {
		return -1;
	}
	return subDepth ? body15[Cell(pos)] : body8[Cell(pos)];
}

bool CBattleAnalysis::IsHostileWater(int body, bool subDepth) const
{
	const std::vector<char>& h = subDepth ? hostile15 : hostile8;
	return (body >= 0) && (body < (int)h.size()) && h[body];
}

void CBattleAnalysis::MarkHostileWater(const AIFloat3& pos, float radius)
{
	BuildWater();
	const int r = std::max(0, int(radius / cellSize));
	const int x0 = std::max(0, std::min(gw - 1, int(pos.x) / cellSize));
	const int z0 = std::max(0, std::min(gh - 1, int(pos.z) / cellSize));
	for (int z = std::max(0, z0 - r); z <= std::min(gh - 1, z0 + r); ++z) {
		for (int x = std::max(0, x0 - r); x <= std::min(gw - 1, x0 + r); ++x) {
			const int c = z * gw + x;
			if (body8[c] >= 0) hostile8[body8[c]] = 1;
			if (body15[c] >= 0) hostile15[body15[c]] = 1;
		}
	}
}

// The owner's rule (D-125, W8): the engine allows a torpedo launcher 12 deep,
// a submarine needs 15. A site passes only where subs can actually come.
bool CBattleAnalysis::TorpedoSiteOK(const CCircuitDef* cdef, const AIFloat3& pos, float range, bool onLand) const
{
	if (!waterBuilt || (cdef == nullptr)) {
		return false;
	}
	if (!onLand) {
		const float hx = cdef->GetDef()->GetXSize() * SQUARE_SIZE * 0.5f;
		const float hz = cdef->GetDef()->GetZSize() * SQUARE_SIZE * 0.5f;
		for (float z = -hz; z <= hz; z += SQUARE_SIZE) {
			for (float x = -hx; x <= hx; x += SQUARE_SIZE) {
				if (Height(AIFloat3(pos.x + x, 0.f, pos.z + z)) > -BA_SUB_DEPTH) {
					return false;   // 1: every footprint square 15 deep
				}
			}
		}
		const int b = body15[Cell(pos)];
		if (!IsHostileWater(b, true)) {
			return false;   // 2: a body subs can come from
		}
	} else if (Height(pos) < 0.f) {
		return false;
	}
	// 4: half the range circle in a hostile 15 body
	const int r = std::max(1, int(range / cellSize));
	const int x0 = int(pos.x) / cellSize, z0 = int(pos.z) / cellSize;
	int inside = 0, hostile = 0;
	float nearest = std::numeric_limits<float>::max();
	for (int z = z0 - r; z <= z0 + r; ++z) {
		for (int x = x0 - r; x <= x0 + r; ++x) {
			if ((x - x0) * (x - x0) + (z - z0) * (z - z0) > r * r) {
				continue;
			}
			++inside;
			if ((x < 0) || (z < 0) || (x >= gw) || (z >= gh)) {
				continue;
			}
			const int c = z * gw + x;
			if (IsHostileWater(body15[c], true)) {
				++hostile;
				nearest = std::min(nearest, pos.SqDistance2D(CellPos(c)));
			}
		}
	}
	if (hostile * 2 < inside) {
		return false;
	}
	if (onLand) {
		return nearest <= SQUARE(300.f);   // depth charges: deep water close to the shore
	}
	// 3: a straight line 60% of the range out stays 15 deep (no sandbar)
	for (int k = 0; k < 16; ++k) {
		const float a = k * float(M_PI) / 8.f;
		const float cx = std::cos(a), cz = std::sin(a);
		bool clear = true;
		for (float d = 16.f; d <= range * 0.6f; d += 16.f) {
			if (Height(AIFloat3(pos.x + cx * d, 0.f, pos.z + cz * d)) > -BA_SUB_DEPTH) {
				clear = false;
				break;
			}
		}
		if (clear) {
			return true;
		}
	}
	return false;
}

int CBattleAnalysis::AnalyseBeaches(const AIFloat3& centre, float radius)
{
	BuildWater();
	beaches.clear();
	const int N = gw * gh;
	std::vector<char> shore(N, 0);
	std::vector<int> cells;
	for (int c = 0; c < N; ++c) {
		if (height[c] < 0.f || centre.SqDistance2D(CellPos(c)) > radius * radius) {
			continue;
		}
		const int cx = c % gw, cz = c / gw;
		for (int k = 0; k < 4; ++k) {
			const int nx = cx + NB8[k][0], nz = cz + NB8[k][1];
			if ((nx >= 0) && (nz >= 0) && (nx < gw) && (nz < gh) && (height[nz * gw + nx] < 0.f)) {
				shore[c] = 1;
				cells.push_back(c);
				break;
			}
		}
	}
	// landing routes for hovers and amphibious units: where they cross the shore
	std::vector<float> crossHeat(N, 0.f);
	if (!sources.empty()) {
		Grid penalty(N, 1.f), dist;
		std::vector<int> prev;
		Dijkstra(Cell(centre), penalty, true, dist, prev);
		for (const AIFloat3& s : sources) {
			const int sc = Cell(s);
			if (dist[sc] == std::numeric_limits<float>::max()) {
				continue;
			}
			bool wet = false;
			for (int c = sc; c >= 0; c = prev[c]) {
				if (height[c] < 0.f) {
					wet = true;
				} else if (wet && shore[c]) {
					crossHeat[c] += 1.f;
					wet = false;
				}
			}
		}
	}
	const float seg2 = 256.f * 256.f;
	std::vector<char> used(N, 0);
	for (int seed : cells) {
		if (used[seed]) {
			continue;
		}
		const AIFloat3 sp = CellPos(seed);
		float sx = 0.f, sz = 0.f, wx = 0.f, wz = 0.f, heat = 0.f;
		int n = 0, nw = 0;
		for (int c : cells) {
			if (used[c] || (sp.SqDistance2D(CellPos(c)) > seg2)) {
				continue;
			}
			used[c] = 1;
			const AIFloat3 p = CellPos(c);
			sx += p.x;
			sz += p.z;
			heat += crossHeat[c];
			++n;
			const int cx = c % gw, cz = c / gw;
			for (int k = 0; k < 8; ++k) {
				const int nx = cx + NB8[k][0], nz = cz + NB8[k][1];
				if ((nx >= 0) && (nz >= 0) && (nx < gw) && (nz < gh) && (height[nz * gw + nx] < 0.f)) {
					const AIFloat3 q = CellPos(nz * gw + nx);
					wx += q.x;
					wz += q.z;
					++nw;
				}
			}
		}
		if ((n == 0) || (nw == 0)) {
			continue;
		}
		SBeach b;
		b.pos = AIFloat3(sx / n, 0.f, sz / n);
		b.pos.y = Height(b.pos);
		AIFloat3 dir(wx / nw - b.pos.x, 0.f, wz / nw - b.pos.z);
		const float len = std::sqrt(dir.x * dir.x + dir.z * dir.z);
		b.seaward = (len > 0.f) ? AIFloat3(dir.x / len, 0.f, dir.z / len) : AIFloat3(1.f, 0.f, 0.f);
		b.heat = heat;
		b.cls = 0;
		auto at = [&b, this](float d) { return Height(AIFloat3(b.pos.x + b.seaward.x * d, 0.f, b.pos.z + b.seaward.z * d)); };
		const float grade = (at(-128.f) - at(64.f)) / 192.f;
		if (grade > BA_CLIFF_GRADE) {
			b.cls |= CLIFF;
		}
		const float d250 = -at(250.f), d500 = -at(500.f);
		if (!(b.cls & CLIFF) && (d250 > 0.f) && (d250 < BA_WADE_DEPTH) && (d500 < BA_WADE_DEPTH)) {
			b.cls |= WADING;
		}
		bool ship = false, deep = false;
		const int r = int(BA_NEAR_WATER / cellSize);
		const int x0 = int(b.pos.x) / cellSize, z0 = int(b.pos.z) / cellSize;
		for (int z = std::max(0, z0 - r); z <= std::min(gh - 1, z0 + r); ++z) {
			for (int x = std::max(0, x0 - r); x <= std::min(gw - 1, x0 + r); ++x) {
				const int c = z * gw + x;
				ship |= IsHostileWater(body8[c], false);
				deep |= IsHostileWater(body15[c], true);
			}
		}
		if (ship) b.cls |= SHIP_WATER;
		if (deep) b.cls |= DEEP_WATER;
		if ((ship || deep) && (grade <= BA_HOVER_GRADE)) b.cls |= HOVER_BEACH;
		beaches.push_back(b);
	}
	circuit->LOG("BATTLE: %i beach segments within %i of (%i, %i)", (int)beaches.size(), int(radius), int(centre.x), int(centre.z));
	return (int)beaches.size();
}

AIFloat3 CBattleAnalysis::GetBeachPos(int i) const { return ((i >= 0) && (i < (int)beaches.size())) ? beaches[i].pos : AIFloat3(-1.f, 0.f, 0.f); }
AIFloat3 CBattleAnalysis::GetBeachSeaward(int i) const { return ((i >= 0) && (i < (int)beaches.size())) ? beaches[i].seaward : AIFloat3(1.f, 0.f, 0.f); }
int CBattleAnalysis::GetBeachClass(int i) const { return ((i >= 0) && (i < (int)beaches.size())) ? beaches[i].cls : 0; }
float CBattleAnalysis::GetBeachHeat(int i) const { return ((i >= 0) && (i < (int)beaches.size())) ? beaches[i].heat : 0.f; }

float CBattleAnalysis::GetBeachDepth(int i, float out) const
{
	if ((i < 0) || (i >= (int)beaches.size())) {
		return 0.f;
	}
	const SBeach& b = beaches[i];
	return -Height(AIFloat3(b.pos.x + b.seaward.x * out, 0.f, b.pos.z + b.seaward.z * out));
}

} // namespace circuit
