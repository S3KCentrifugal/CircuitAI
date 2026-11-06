// Factory-to-lane routing and reservation lifetime (D-440, D-451). Role
// policy is supplied by script; this file owns the mechanism.
#include "terrain/FactoryCorridors.h"
#include "terrain/TerrainManager.h"
#include "terrain/TerrainData.h"
#include "module/BuilderManager.h"
#include "module/FactoryManager.h"
#include "scheduler/Scheduler.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "util/Performance.h"
#include "Log.h"
#include <algorithm>
#include <charconv>
#include <cmath>
#include <string_view>
#include <cstdlib>

namespace circuit {
using namespace springai;
namespace {
constexpr int kCellElmos = 16;            // one blocking-map cell
constexpr float kCellCentre = 8.f;        // offset from a cell corner to its centre, elmos
constexpr int kRouteStep = 2;             // route grid = 2x2 blocking cells
constexpr int kWindowRadius = 256;        // planning window half-size, blocking cells (4096 elmos)
constexpr float kMinHalfWidth = 16.f;     // narrowest corridor half-width, elmos
constexpr float kGoalSampleElmos = 16.f;  // spacing of lane goal samples
constexpr int kRetryFrames = 5 * FRAMES_PER_SEC;  // failed probe throttle per site
constexpr int kGraceFrames = 5 * FRAMES_PER_SEC;  // an unclaimed new route survives this long
constexpr int kMaxRouteId = 1000000;
constexpr int kMaxRoutes = 256;
constexpr int kMaxSegments = 512;
constexpr int kMaxLanePoints = 4096;
constexpr int kExitIdStride = 1024;       // > kMaxSegments: route ids never collide
constexpr int kMaxFailedSites = 64;       // C4: failure throttle entries, oldest dropped
constexpr int kRefreshItemsPerJob = 64;   // B4: cache hits are cheap; bound the loop anyway
constexpr int kRefreshDelayFrames = 1;
constexpr float kSameSiteSq = 1.f;
constexpr float kMaxGoalElmos = 8192.f;
constexpr float kMaxGoalStartElmos = 4096.f;
constexpr float kMaxLaneWaitSeconds = 600.f;
constexpr int kMaxProbes = 16;
constexpr int kMinVisits = 256;
constexpr int kMaxVisits = 65536;
constexpr int kMillis = 1000;
constexpr const char* kPrefix = "native.factoryRoutes.";
constexpr std::size_t kWordBits = 64;     // terrain cache packing: cells per uint64_t
constexpr unsigned kWordShift = 6;        // log2(kWordBits)
constexpr std::string_view kCountSuffix = "count";  // saved lane key: <prefix><team>.count
constexpr std::string_view kDefSuffix = "def";      // saved route key: <prefix><id>.def
constexpr int kRoadId = 0;                // D-460: the lane road's claim ids, -1..-kMaxSegments
static_assert(kExitIdStride > kMaxSegments, "exit claim ids must not overlap between routes");

bool SameSite(const AIFloat3& a, const AIFloat3& b) { return a.SqDistance2D(b) < kSameSiteSq; }
std::string Key(const char* name) { return std::string(kPrefix) + name; }
// Cached once: the trace switch is read on failure paths only.
bool Trace() { static const bool trace = std::getenv("CIRCUIT_FACTORY_CORRIDOR_TRACE") != nullptr; return trace; }
}

int CFactoryCorridors::ExitClaimId(int routeId, int segment)
{
	// Negative EXIT ids cannot collide with ordinary positive zone ids.
	return -(routeId * kExitIdStride + segment + 1);
}

void CFactoryCorridors::SetPolicy(bool enabledIn, bool ownLaneIn)
{
	const bool next = enabledIn && terrain.layoutConfigured;
	const bool changed = enabled != next || ownLane != ownLaneIn;
	enabled = next;
	ownLane = ownLaneIn;
	if (enabled && enabledFrame < 0) enabledFrame = terrain.circuit->GetLastFrame();
	if (!enabled && !road.empty()) {  // D-460: no road while corridors are off, saved that way
		ShareRects(kRoadId, road, false);
		road.clear();
		Save();
	} else {
		SaveOptions();
	}
	if (changed) {
		for (auto& [id, r] : routes) Invalidate(r);
		QueueRefresh();
	}
}

void CFactoryCorridors::SetExemptDef(int def)
{
	// Once a non-T1 factory stands the T1 lab is kept, so it is routed too.
	exemptDef = terrain.GetLayoutInt(Key("promoted"), 0) ? -1 : def;
	SaveOptions();
}

void CFactoryCorridors::SetOptions(const SOptions& in)
{
	options.liveProbes = std::clamp(in.liveProbes, 1, kMaxProbes);
	options.backgroundProbes = std::clamp(in.backgroundProbes, 0, kMaxProbes);
	options.visits = std::clamp(in.visits, kMinVisits, kMaxVisits);
	options.goalStart = std::isfinite(in.goalStart) ? std::clamp(in.goalStart, 0.f, kMaxGoalStartElmos) : SOptions().goalStart;
	options.goalEnd = std::isfinite(in.goalEnd) ? std::clamp(in.goalEnd, options.goalStart, kMaxGoalElmos) : SOptions().goalEnd;
	options.laneWaitSeconds = std::isfinite(in.laneWaitSeconds)
		? std::clamp(in.laneWaitSeconds, 0.f, kMaxLaneWaitSeconds) : SOptions().laneWaitSeconds;
	SaveOptions();
}

void CFactoryCorridors::SetLane(int team, const std::vector<AIFloat3>& points)
{
	const auto& blocking = terrain.blockingMap;
	if (team < 0 || int(points.size()) > kMaxLanePoints) return;
	for (const auto& p : points) if (!std::isfinite(p.x) || !std::isfinite(p.z)
		|| p.x < 0 || p.z < 0 || p.x >= blocking.columns * kCellElmos || p.z >= blocking.rows * kCellElmos) return;
	const auto previous = lanes.find(team);
	if (previous != lanes.end() && previous->second.size() == points.size()) {
		bool equal = true;
		for (std::size_t i = 0; i < points.size(); ++i) if (!SameSite(points[i], previous->second[i])) { equal = false; break; }
		if (equal) return;
	}
	if (points.size() < 2) lanes.erase(team); else lanes[team] = points;
	// B2: a FRONT AI only routes to its own lane; another team's lane is kept
	// for a later policy change but cannot affect any route now.
	if (ownLane && team != terrain.circuit->GetTeamId()) { Save(); return; }
	// Only routes to this team, and routes without a lane, can change. A
	// connected road keeps its lane (and its old exclusion until replaced).
	for (auto& [id, r] : routes) {
		if (r.lane == team) Invalidate(r);
		else if (r.lane < 0) r.retry = 0;
	}
	QueueRefresh();
	Save();
}

bool CFactoryCorridors::HasLane() const
{
	for (const auto& [team, points] : lanes) if (!ownLane || team == terrain.circuit->GetTeamId()) return true;
	return false;
}

int CFactoryCorridors::ProbeBudget(bool background) const
{
	return background ? options.backgroundProbes - backgroundProbesUsed : options.liveProbes - liveProbesUsed;
}

bool CFactoryCorridors::TerrainOpen(int x, int z, int def)
{
	const auto& blocking = terrain.blockingMap;
	const auto facts = terrain.factoryExitFacts.find(def);
	if (facts == terrain.factoryExitFacts.end()) return false;
	// B1: slope, depth, resource plots and finite samples change only with
	// the height map; cache them per factory definition, two bits per cell.
	auto& cache = terrainCache[def];
	const std::uint64_t height = terrain.areaData != nullptr ? terrain.areaData->heightRevision : 0;
	const std::size_t cells = std::size_t(blocking.columns) * blocking.rows;
	const std::size_t words = (cells + kWordBits - 1) / kWordBits;
	if (cache.height != height || cache.known.size() != words) {
		cache.height = height;
		cache.known.assign(words, 0);
		cache.open.assign(words, 0);
	}
	const std::size_t index = std::size_t(z) * blocking.columns + x;
	const std::uint64_t bit = std::uint64_t{1} << (index & (kWordBits - 1));
	auto& known = cache.known[index >> kWordShift];
	auto& open = cache.open[index >> kWordShift];
	if (known & bit) return (open & bit) != 0;
	known |= bit;
	if (blocking.IsResourceSite(x, z) || terrain.IsResourceKeepOut(x, z)) return false;  // D-460: KI-744
	const auto& slopes = terrain.terrainData->GetSlopeMap();
	const auto si = std::size_t(z) * terrain.terrainData->GetSlopeMapXSize() + x;
	if (si >= slopes.size() || !std::isfinite(slopes[si]) || terrain.areaData == nullptr) return false;
	const float elevation = terrain.areaData->GetElevationAt(x * kCellElmos + kCellCentre, z * kCellElmos + kCellCentre);
	if (!std::isfinite(elevation)) return false;
	for (const auto& f : facts->second) if (elevation < -f.depth
		|| (!(f.hover && elevation < 0.f) && slopes[si] > f.slope)) return false;
	open |= bit;
	return true;
}

bool CFactoryCorridors::CellOpen(int x, int z, int def)
{
	const auto& blocking = terrain.blockingMap;
	if (!blocking.IsInBounds(x, z)) return false;
	// Building-yard spacing is not a movement obstacle. Actual footprints are;
	// reservations are checked in the claim raster.
	const auto& cell = blocking.grid[z * blocking.columns + x];
	if (static_cast<unsigned>(cell.structMask) & ~unsigned(SBlockingMap::StructMask::RESERVED)) return false;
	return TerrainOpen(x, z, def);
}

bool CFactoryCorridors::RouteClear(SRoute& route, int def)
{
	// B3: building marks and heights both carry a revision. An unchanged pair
	// means the last clear scan still holds; no cell is read.
	const std::uint64_t height = terrain.areaData != nullptr ? terrain.areaData->heightRevision : 0;
	if (route.checkedPacking == terrain.packingRevision && route.checkedHeight == height) return true;
	for (const auto& r : route.rectangles)
		for (int z = r.z1; z < r.z2; ++z) for (int x = r.x1; x < r.x2; ++x)
			if (!CellOpen(x, z, def)) return false;
	route.checkedPacking = terrain.packingRevision;
	route.checkedHeight = height;
	return true;
}

void CFactoryCorridors::ShareRects(int routeId, const std::vector<allied_layout::Rect>& rectangles, bool add)
{
	if (rectangles.empty()) return;
	const int team = terrain.circuit->GetTeamId();
	auto& shared = terrain.circuit->GetAllyTeam()->GetLayoutReservations();
	// Each route owns its rectangles independently. Overlapping trunks retain
	// exclusion when either route is released.
	for (std::size_t i = 0; i < rectangles.size(); ++i) {
		const int id = ExitClaimId(routeId, int(i));
		coverage.ChangeCells(team, rectangles[i], add);
		if (add) shared.Put(team, allied_layout::Reservations::EXIT, id, rectangles[i]);
		else shared.Erase(team, allied_layout::Reservations::EXIT, id);
	}
	++terrain.packingRevision;
}

int CFactoryCorridors::Clearance(CCircuitDef* def) const
{
	const auto& facts = terrain.FactoryMovementFacts(def);
	if (facts.empty()) return 0;
	float half = kMinHalfWidth;
	for (const auto& f : facts) half = std::max(half, f.halfWidth);
	return int(std::ceil(half / kCellElmos)) + 1;
}

void CFactoryCorridors::PaintWindow(const allied_layout::Rect& window, int defId)
{
	const int x0 = window.x1, z0 = window.z1, x1 = window.x2, z1 = window.z2;
	const int w = x1 - x0, h = z1 - z0;
	windowW = w; windowH = h;
	blocked.assign(w * h, 0); reused.assign(w * h, 0);
	allyZones.assign(w * h, 0); allyExits.assign(w * h, 0);
	const auto paint = [&](const allied_layout::Rect& r, std::vector<std::uint8_t>& grid) {
		for (int z = std::max(z0, r.z1); z < std::min(z1, r.z2); ++z)
			for (int x = std::max(x0, r.x1); x < std::min(x1, r.x2); ++x) grid[(z - z0) * w + x - x0] = 1;
	};
	// Our envelope is space we may allocate, not an occupied building. Carve
	// roads through its unused cells; slot/task/structure footprints remain hard
	// obstacles and Blocked() protects the road from later packing. Allied
	// envelopes remain protected unless they already contain an exit.
	for (const auto& [id, z] : terrain.zones) if (z.corridor) paint({z.c1.x, z.c1.y, z.c2.x, z.c2.y}, reused);
	const int team = terrain.circuit->GetTeamId();
	auto& allies = terrain.circuit->GetAllyTeam()->GetLayoutReservations();
	allies.ForEachOther(team, allied_layout::Reservations::ZONE, window, [&](const auto& r) { paint(r, allyZones); });
	allies.ForEachOther(team, allied_layout::Reservations::EXIT, window, [&](const auto& r) { paint(r, allyExits); });
	for (int i = 0; i < w * h; ++i) { if (allyZones[i] && !allyExits[i]) blocked[i] = 1; if (allyExits[i]) reused[i] = 1; }
	for (auto kind : {allied_layout::Reservations::SLOT, allied_layout::Reservations::TASK, allied_layout::Reservations::STRUCTURE})
		allies.ForEachOther(-1, kind, window, [&](const auto& r) { paint(r, blocked); });  // includes our own ordinary tasks
	for (const auto& [id, r] : terrain.reservations) {
		int2 a, b;
		if (terrain.ReservationCells(r.def, r.pos, r.facing, a, b)) paint({a.x, a.y, b.x, b.y}, blocked);
	}
	for (const auto& [id, r] : routes) for (const auto& rect : r.rectangles) paint(rect, reused);
	for (const auto& rect : road) paint(rect, reused);
	for (int z = z0; z < z1; ++z) for (int x = x0; x < x1; ++x) {
		const int i = (z - z0) * w + x - x0;
		if (!blocked[i]) blocked[i] = !CellOpen(x, z, defId);
	}
}

void CFactoryCorridors::SetRoad(const std::vector<AIFloat3>& points, CCircuitDef* widthDef)
{
	CCircuitAI* circuit = terrain.circuit;
	performance::Scope timing(circuit, performance::FACTORY_CORRIDOR);
	ShareRects(kRoadId, road, false);
	road.clear();
	const int clearance = (widthDef != nullptr) ? Clearance(widthDef) : 0;
	const auto& blocking = terrain.blockingMap;
	if (!enabled || clearance <= 0 || points.size() < 2 || int(points.size()) > kMaxLanePoints) { Save(); return; }
	// The lane's first goalStart elmos run through the base, which the
	// factory corridors already serve; the road starts where they connect.
	// Vertices go to the route grid of one planning window anchored at that
	// start; the road is clipped where it leaves the window (8192 elmos). Called
	// once per published lane (fixed per match), so locals are fine here.
	float walked = 0.f;
	int bx0 = blocking.columns, bz0 = blocking.rows, bx1 = 0, bz1 = 0;
	std::vector<AIFloat3> trimmed;
	trimmed.reserve(points.size());
	for (std::size_t i = 1; i < points.size(); ++i) {
		const auto delta = points[i] - points[i - 1];
		const float length = std::sqrt(delta.SqLength2D());
		if (trimmed.empty() && walked + length >= options.goalStart && length > 0.f)
			trimmed.push_back(points[i - 1] + delta * ((options.goalStart - walked) / length));
		if (!trimmed.empty()) trimmed.push_back(points[i]);
		walked += length;
	}
	for (const auto& p : trimmed) {
		if (!std::isfinite(p.x) || !std::isfinite(p.z)) { Save(); return; }
		const int x = int(p.x / kCellElmos), z = int(p.z / kCellElmos);
		bx0 = std::min(bx0, x); bz0 = std::min(bz0, z); bx1 = std::max(bx1, x); bz1 = std::max(bz1, z);
	}
	if (trimmed.size() < 2) { Save(); return; }
	const int pad = clearance + kRouteStep;
	const int x0 = std::max(0, bx0 - pad), z0 = std::max(0, bz0 - pad);
	const int x1 = std::min({blocking.columns, bx1 + pad + 1, x0 + 2 * kWindowRadius});
	const int z1 = std::min({blocking.rows, bz1 + pad + 1, z0 + 2 * kWindowRadius});
	PaintWindow({x0, z0, x1, z1}, widthDef->GetId());
	const int gw = windowW / kRouteStep, gh = windowH / kRouteStep;
	if (!factory_corridor::OpenCentres(windowW, windowH, blocked, kRouteStep, clearance, sums, open)) { Save(); return; }
	std::vector<std::pair<int, int>> vertices;
	vertices.reserve(trimmed.size());
	for (const auto& p : trimmed)
		vertices.emplace_back((int(p.x / kCellElmos) - x0) / kRouteStep, (int(p.z / kCellElmos) - z0) / kRouteStep);
	std::vector<int> cells, run;
	factory_corridor::TraceCells(vertices, gw, gh, cells);
	// Closed cells (structures, plans, resource keep-out) split the road;
	// each open run becomes rectangles of the corridor's own width.
	const auto flush = [&]() {
		if (run.empty()) return;
		for (const auto& r : factory_corridor::Rectangles(run, gw, x0, z0, kRouteStep, clearance))
			if (int(road.size()) < kMaxSegments) road.push_back({r.x1, r.z1, r.x2, r.z2});
		run.clear();
	};
	int closed = 0;
	for (const int cell : cells) {
		if (open[cell]) { run.push_back(cell); continue; }
		++closed;
		flush();
	}
	flush();
	ShareRects(kRoadId, road, true);
	Save();
	circuit->LOG("[FactoryCorridor] lane road segments=%u cells=%u closed=%d clearance=%d team=%d",
		unsigned(road.size()), unsigned(cells.size()), closed, clearance, circuit->GetTeamId());
}

bool CFactoryCorridors::Ensure(CCircuitDef* def, const AIFloat3& position, int facing, bool planning)
{
	return EnsureImpl(def, position, facing, planning, false);
}

bool CFactoryCorridors::EnsureImpl(CCircuitDef* def, const AIFloat3& position, int facing, bool planning, bool background)
{
	CCircuitAI* circuit = terrain.circuit;
	if (!enabled || !def || def->IsMobile() || def->GetId() == exemptDef
		|| !circuit->GetFactoryManager()->GetFactoryDef(def)) return true;
	const auto& facts = terrain.FactoryMovementFacts(def);
	if (facts.empty()) return true;  // aircraft-only and ship-only factories keep their exits
	if (facing < 0 || facing > 3 || !std::isfinite(position.x) || !std::isfinite(position.z)) return false;
	performance::Scope timing(circuit, performance::FACTORY_CORRIDOR);
	const int frame = circuit->GetLastFrame();
	if (probeFrame != frame) { probeFrame = frame; liveProbesUsed = 0; backgroundProbesUsed = 0; }
	const int defId = def->GetId();
	const auto pos = CTerrainManager::Pos2BuildPos(def, position, facing);
	int2 fa, fb;
	if (!terrain.ReservationCells(def, pos, facing, fa, fb)) return false;
	SRoute* record = nullptr;
	for (auto& [id, r] : routes) if (r.def == defId && r.facing == facing && SameSite(r.pos, pos)) { record = &r; break; }
	if (record && record->lane >= 0 && !record->rectangles.empty()) {
		if (RouteClear(*record, defId)) return true;
		Invalidate(*record);
	}
	if (record && record->retry > frame) return false;
	// C4: failures are throttled outside the route table.
	auto failure = std::find_if(failed.begin(), failed.end(), [&](const SFailedSite& f) {
		return f.def == defId && f.facing == facing && SameSite(f.pos, pos);
	});
	if (failure != failed.end() && failure->retry > frame) return false;
	if (!HasLane()) {
		if (planning) return true;  // pending layout is allowed, actual construction waits
		// C1: no lane at all after the wait: build unrouted rather than hold
		// the factory. QueueRefresh adds a route once a lane is published.
		const int wait = int(options.laneWaitSeconds * FRAMES_PER_SEC);
		if (enabledFrame >= 0 && frame >= enabledFrame + wait) {
			if (!unroutedLogged) {
				circuit->LOG("[FactoryCorridor] no lane after %.0fs; factories build unrouted until one is published", options.laneWaitSeconds);
				unroutedLogged = true;
			}
			return true;
		}
		return false;
	}
	// KI-745 item 3: a spent frame budget is "not probed yet", not "no
	// route". A plan may keep the site, as it does before any lane exists;
	// construction admission (planning false) probes it again. Played: FRONT
	// T2 extension previews of 12 sites failed after the 4th probe.
	if (ProbeBudget(background) <= 0) return planning;
	++(background ? backgroundProbesUsed : liveProbesUsed);
	const auto fail = [&]() {
		if (record) { record->retry = frame + kRetryFrames; return false; }
		if (failure != failed.end()) { failure->retry = frame + kRetryFrames; return false; }
		if (int(failed.size()) >= kMaxFailedSites) failed.erase(failed.begin());
		failed.push_back({defId, facing, frame + kRetryFrames, pos});
		return false;
	};
	const auto& blocking = terrain.blockingMap;
	const int clearance = Clearance(def);
	const auto [sx, sz] = factory_corridor::Mouth({fa.x, fa.y, fb.x, fb.y}, facing, clearance, kRouteStep);
	if (!blocking.IsInBounds(sx, sz)) return fail();
	const int x0 = std::max(0, sx - kWindowRadius), z0 = std::max(0, sz - kWindowRadius);
	const int x1 = std::min(blocking.columns, x0 + 2 * kWindowRadius), z1 = std::min(blocking.rows, z0 + 2 * kWindowRadius);
	const int w = x1 - x0, h = z1 - z0;
	const int team = circuit->GetTeamId();
	PaintWindow({x0, z0, x1, z1}, defId);
	// Ordinary fallback candidates have no slot/task footprint yet. Without
	// this provisional obstacle a road can cross the factory it must serve,
	// then its EXIT claim prevents the factory build order from being admitted.
	for (int z = std::max(z0, fa.y); z < std::min(z1, fb.y); ++z)
		for (int x = std::max(x0, fa.x); x < std::min(x1, fb.x); ++x) blocked[(z - z0) * w + x - x0] = 1;
	// Integral occupancy: O(W*H + V), rather than footprint scans at every
	// Dijkstra neighbour.
	const int gw = w / kRouteStep, gh = h / kRouteStep;
	factory_corridor::OpenCentres(w, h, blocked, kRouteStep, clearance, sums, open);
	reuse.assign(gw * gh, 0); goals.assign(gw * gh, 0); owners.assign(gw * gh, -1);
	for (int z = 0; z < gh; ++z) for (int x = 0; x < gw; ++x)
		reuse[z * gw + x] = reused[(z * kRouteStep + 1) * w + x * kRouteStep + 1];
	// Only the homeward goalStart..goalEnd elmos of each published lane are
	// connection goals: a base route never travels down the front.
	for (const auto& [laneTeam, points] : lanes) {
		if (ownLane && laneTeam != team) continue;
		float walked = 0.f;
		for (std::size_t i = 1; i < points.size() && walked < options.goalEnd; ++i) {
			const auto delta = points[i] - points[i - 1];
			const float length = std::sqrt(delta.SqLength2D());
			const float usable = std::min(length, options.goalEnd - walked);
			if (length > 0.f) for (float t = std::max(0.f, options.goalStart - walked); t <= usable; t += kGoalSampleElmos) {
				const auto p = points[i - 1] + delta * (t / length);
				const int x = (int(p.x / kCellElmos) - x0) / kRouteStep, z = (int(p.z / kCellElmos) - z0) / kRouteStep;
				if (p.x < x0 * kCellElmos || p.z < z0 * kCellElmos || x < 0 || z < 0 || x >= gw || z >= gh) continue;
				const int cell = z * gw + x;
				if (owners[cell] < 0) { goals[cell] = 1; owners[cell] = laneTeam; }
			}
			walked += length;
		}
	}
	const int start = ((sz - z0) / kRouteStep) * gw + (sx - x0) / kRouteStep;
	if (open.empty() || start < 0 || start >= int(open.size())) return fail();
	auto route = factory_corridor::Connect(gw, gh, start, open, reuse, goals, options.visits, connect);
	if (route.cells.empty()) {
		if (Trace()) circuit->LOG("[FactoryCorridorTrace] def=%s facing=%d site=%.0f,%.0f startOpen=%d goals=%u visited=%d exhausted=%d",
			def->GetDef()->GetName(), facing, pos.x, pos.z, int(open[start]),
			unsigned(std::count(goals.begin(), goals.end(), 1)), route.visited, int(route.exhausted));
		return fail();
	}
	std::vector<allied_layout::Rect> rectangles;
	for (const auto& r : factory_corridor::Rectangles(route.cells, gw, x0, z0, kRouteStep, clearance))
		rectangles.push_back({r.x1, r.z1, r.x2, r.z2});
	if (rectangles.empty()) return fail();
	// Connect the reserved road to the factory's mouth, including ordinary
	// fallback factories which have no pre-existing short exit zone.
	const int cx = int(pos.x / kCellElmos), cz = int(pos.z / kCellElmos);
	allied_layout::Rect stem{cx - clearance, cz - clearance, cx + clearance + 1, cz + clearance + 1};
	const auto& first = rectangles.front();
	if (facing == 0) { stem.z1 = fb.y; stem.z2 = first.z2; }
	else if (facing == 1) { stem.x1 = fb.x; stem.x2 = first.x2; }
	else if (facing == 2) { stem.z1 = first.z1; stem.z2 = fa.y; }
	else { stem.x1 = first.x1; stem.x2 = fa.x; }
	if (!stem.Valid() || stem.x1 < x0 || stem.z1 < z0 || stem.x2 > x1 || stem.z2 > z1) return fail();
	for (int z = stem.z1; z < stem.z2; ++z) for (int x = stem.x1; x < stem.x2; ++x)
		if (blocked[(z - z0) * w + x - x0]) {
			if (Trace()) circuit->LOG("[FactoryCorridorTrace] def=%s stem blocked at %d,%d", def->GetDef()->GetName(), x, z);
			return fail();
		}
	rectangles.push_back(stem);
	if (int(rectangles.size()) > kMaxSegments) return fail();
	if (!record) {
		if (routes.size() >= std::size_t(kMaxRoutes)) Prune();  // rare: only when the table is full
		if (nextId >= kMaxRouteId || routes.size() >= std::size_t(kMaxRoutes)) return fail();
		auto& r = routes[nextId];
		r.id = nextId++; r.def = defId; r.facing = facing; r.pos = pos;
		record = &r;
	}
	if (failure != failed.end()) failed.erase(failure);
	Share(*record, false);
	record->rectangles = std::move(rectangles);
	record->lane = owners[route.cells.back()];
	record->retry = 0;
	record->graceUntil = frame + kGraceFrames;
	Share(*record, true);
	record->checkedPacking = terrain.packingRevision;
	record->checkedHeight = terrain.areaData != nullptr ? terrain.areaData->heightRevision : 0;
	Save();
	QueuePrune();  // an unclaimed candidate's road is released after its grace
	circuit->LOG("[FactoryCorridor] def=%s lane=%d segments=%u visited=%d team=%d site=%.0f,%.0f facing=%d",
		def->GetDef()->GetName(), record->lane, unsigned(record->rectangles.size()), route.visited, team, pos.x, pos.z, facing);
	return true;
}

void CFactoryCorridors::ObserveFactory(int unitId, CCircuitDef* def, const AIFloat3& pos, int facing, bool isT1)
{
	factories[unitId] = {def->GetId(), facing, pos};
	if (!isT1) {
		exemptDef = -1;
		terrain.layoutInts[Key("promoted")] = 1;
		SaveOptions();
	}
}

void CFactoryCorridors::ForgetFactory(int unitId)
{
	if (!factories.erase(unitId)) return;
	performance::Scope timing(terrain.circuit, performance::FACTORY_CORRIDOR);
	Prune();
	QueuePrune();
}

void CFactoryCorridors::TaskReleased(int claim)
{
	if (tasks.erase(claim)) QueuePrune();
}

void CFactoryCorridors::ReservationErased()
{
	performance::Scope timing(terrain.circuit, performance::FACTORY_CORRIDOR);
	Prune();
	QueuePrune();
}

void CFactoryCorridors::Describe(std::string& out) const
{
	char buf[160];
	const auto describe = [&](int id, const std::vector<allied_layout::Rect>& rectangles) {
		for (std::size_t i = 0; i < rectangles.size(); ++i) {
			const auto& r = rectangles[i];
			snprintf(buf, sizeof(buf), "corridor:%i:%i:%i:0:%i:%i:z;", ExitClaimId(id, int(i)),
				(r.x1 + r.x2) * kCellElmos / 2, (r.z1 + r.z2) * kCellElmos / 2, (r.x2 - r.x1) * kCellElmos, (r.z2 - r.z1) * kCellElmos);
			out += buf;
		}
	};
	for (const auto& [id, route] : routes) describe(id, route.rectangles);
	describe(kRoadId, road);
}

void CFactoryCorridors::SaveOptions()
{
	auto& ints = terrain.layoutInts;
	ints[Key("probes")] = options.liveProbes;
	ints[Key("background")] = options.backgroundProbes;
	ints[Key("visits")] = options.visits;
	ints[Key("goalStart")] = int(options.goalStart);
	ints[Key("goalEnd")] = int(options.goalEnd);
	ints[Key("laneWaitMs")] = int(options.laneWaitSeconds * kMillis);
	ints[Key("enabled")] = enabled;
	ints[Key("own")] = ownLane;
	ints[Key("exempt")] = exemptDef;
	ints[Key("enabledFrame")] = enabledFrame;
}

void CFactoryCorridors::Save()
{
	auto& ints = terrain.layoutInts;
	SaveOptions();
	const std::string lanePrefix = Key("lane.");
	for (auto it = ints.lower_bound(lanePrefix); it != ints.end() && it->first.rfind(lanePrefix, 0) == 0;) it = ints.erase(it);
	for (const auto& [team, points] : lanes) {
		const auto key = lanePrefix + std::to_string(team) + ".";
		ints[key + "count"] = int(points.size());
		for (std::size_t i = 0; i < points.size(); ++i) {
			ints[key + std::to_string(i) + ".x"] = int(points[i].x);
			ints[key + std::to_string(i) + ".z"] = int(points[i].z);
		}
	}
	const std::string routePrefix = Key("route.");
	for (auto it = ints.lower_bound(routePrefix); it != ints.end() && it->first.rfind(routePrefix, 0) == 0;) it = ints.erase(it);
	ints[Key("next")] = nextId;
	for (const auto& [id, r] : routes) {
		const auto k = routePrefix + std::to_string(id) + ".";
		ints[k + "def"] = r.def; ints[k + "x"] = int(r.pos.x); ints[k + "z"] = int(r.pos.z);
		ints[k + "facing"] = r.facing; ints[k + "lane"] = r.lane; ints[k + "count"] = int(r.rectangles.size());
		SaveRects(ints, k, r.rectangles);
	}
	const std::string roadPrefix = Key("road.");
	for (auto it = ints.lower_bound(roadPrefix); it != ints.end() && it->first.rfind(roadPrefix, 0) == 0;) it = ints.erase(it);
	ints[roadPrefix + "count"] = int(road.size());
	SaveRects(ints, roadPrefix, road);
}

void CFactoryCorridors::SaveRects(std::map<std::string, int>& ints, const std::string& key, const std::vector<allied_layout::Rect>& rectangles)
{
	for (std::size_t i = 0; i < rectangles.size(); ++i) {
		const auto s = key + std::to_string(i) + ".";
		const auto& a = rectangles[i];
		ints[s + "x1"] = a.x1; ints[s + "z1"] = a.z1; ints[s + "x2"] = a.x2; ints[s + "z2"] = a.z2;
	}
}

bool CFactoryCorridors::LoadRects(const std::string& key, int count, std::vector<allied_layout::Rect>& out) const
{
	const auto& blocking = terrain.blockingMap;
	out.clear();
	if (count < 0 || count > kMaxSegments) return false;
	for (int i = 0; i < count; ++i) {
		const auto s = key + std::to_string(i) + ".";
		allied_layout::Rect a{terrain.GetLayoutInt(s + "x1", -1), terrain.GetLayoutInt(s + "z1", -1),
			terrain.GetLayoutInt(s + "x2", -1), terrain.GetLayoutInt(s + "z2", -1)};
		if (!a.Valid() || a.x2 > blocking.columns || a.z2 > blocking.rows) { out.clear(); return false; }
		out.push_back(a);
	}
	return true;
}

void CFactoryCorridors::Clear()
{
	for (const auto& [id, r] : routes) Share(r, false);
	ShareRects(kRoadId, road, false);
	routes.clear(); road.clear(); lanes.clear(); refresh.clear(); failed.clear(); terrainCache.clear();
	nextId = 1;
}

void CFactoryCorridors::OnLayoutReset()
{
	performance::Scope timing(terrain.circuit, performance::FACTORY_CORRIDOR);
	Prune();
	Save();
}

void CFactoryCorridors::Load()
{
	const auto& blocking = terrain.blockingMap;
	SOptions loaded;
	loaded.liveProbes = terrain.GetLayoutInt(Key("probes"), loaded.liveProbes);
	loaded.backgroundProbes = terrain.GetLayoutInt(Key("background"), loaded.backgroundProbes);
	loaded.visits = terrain.GetLayoutInt(Key("visits"), loaded.visits);
	loaded.goalStart = float(terrain.GetLayoutInt(Key("goalStart"), int(loaded.goalStart)));
	loaded.goalEnd = float(terrain.GetLayoutInt(Key("goalEnd"), int(loaded.goalEnd)));
	loaded.laneWaitSeconds = float(terrain.GetLayoutInt(Key("laneWaitMs"), int(loaded.laneWaitSeconds * kMillis))) / kMillis;
	// Read every saved policy key before SetOptions, which re-saves them all.
	enabled = terrain.GetLayoutInt(Key("enabled"), 0) != 0 && terrain.layoutConfigured;
	ownLane = terrain.GetLayoutInt(Key("own"), 0) != 0;
	exemptDef = terrain.GetLayoutInt(Key("promoted"), 0) ? -1 : terrain.GetLayoutInt(Key("exempt"), -1);
	enabledFrame = terrain.GetLayoutInt(Key("enabledFrame"), enabled ? terrain.circuit->GetLastFrame() : -1);
	SetOptions(loaded);
	nextId = std::clamp(terrain.GetLayoutInt(Key("next"), 1), 1, kMaxRouteId);
	auto& ints = terrain.layoutInts;
	const std::string lanePrefix = Key("lane.");
	for (auto it = ints.lower_bound(lanePrefix); it != ints.end() && it->first.rfind(lanePrefix, 0) == 0; ++it) {
		if (!it->first.ends_with(".count") || it->second < 2 || it->second > kMaxLanePoints) continue;
		const auto k = it->first.substr(0, it->first.size() - kCountSuffix.size());
		int team = -1;
		const auto parsed = std::from_chars(k.data() + lanePrefix.size(), k.data() + k.size() - 1, team);
		if (parsed.ec != std::errc{} || parsed.ptr != k.data() + k.size() - 1 || team < 0) continue;
		std::vector<AIFloat3> points;
		for (int i = 0; i < it->second; ++i) {
			const auto s = k + std::to_string(i) + ".";
			const int x = terrain.GetLayoutInt(s + "x", -1), z = terrain.GetLayoutInt(s + "z", -1);
			if (x < 0 || z < 0 || x >= blocking.columns * kCellElmos || z >= blocking.rows * kCellElmos) { points.clear(); break; }
			points.emplace_back(float(x), 0.f, float(z));
		}
		if (points.size() > 1) lanes.emplace(team, std::move(points));
	}
	const std::string routePrefix = Key("route.");
	for (auto it = ints.lower_bound(routePrefix); it != ints.end() && it->first.rfind(routePrefix, 0) == 0; ++it) {
		if (!it->first.ends_with(".def")) continue;
		const auto k = it->first.substr(0, it->first.size() - kDefSuffix.size());
		SRoute r;
		r.def = it->second;
		const char* begin = k.data() + routePrefix.size();
		const char* end = k.data() + k.size() - 1;
		const auto parsed = std::from_chars(begin, end, r.id);
		if (parsed.ec != std::errc{} || parsed.ptr != end) continue;
		if (r.id <= 0 || r.id >= nextId || !terrain.circuit->GetCircuitDef(r.def)) continue;
		r.pos = AIFloat3(float(terrain.GetLayoutInt(k + "x", -1)), 0.f, float(terrain.GetLayoutInt(k + "z", -1)));
		r.facing = terrain.GetLayoutInt(k + "facing", -1);
		r.lane = terrain.GetLayoutInt(k + "lane", -1);  // older saves re-plan on first use
		const int count = terrain.GetLayoutInt(k + "count", 0);
		if (count < 0 || count > kMaxSegments || r.facing < 0 || r.facing > 3) continue;
		LoadRects(k, count, r.rectangles);
		if (r.rectangles.empty()) r.lane = -1;
		// checkedPacking stays 0: the first use re-validates every cell once.
		routes.emplace(r.id, r);
		Share(r, true);
	}
	const std::string roadPrefix = Key("road.");
	if (enabled && LoadRects(roadPrefix, terrain.GetLayoutInt(roadPrefix + "count", 0), road)) ShareRects(kRoadId, road, true);
}

void CFactoryCorridors::Prune()
{
	// B5: event-driven only. O(routes * (slots + factory tasks + factories)).
	// Callers time it: Ensure already holds the corridor scope.
	const int frame = terrain.circuit->GetLastFrame();
	bool changed = false;
	for (auto it = routes.begin(); it != routes.end();) {
		const auto& r = it->second;
		bool used = r.graceUntil > frame || r.retry > frame;
		if (!used) for (const auto& [id, slot] : terrain.reservations)
			if (slot.def->GetId() == r.def && SameSite(slot.pos, r.pos)) { used = true; break; }
		if (!used) for (const auto* task : terrain.circuit->GetBuilderManager()->GetTasks(IBuilderTask::BuildType::FACTORY))
			if (!task->IsDead() && task->GetBuildDef() && task->GetBuildDef()->GetId() == r.def
				&& SameSite(task->GetBuildPos(), r.pos)) { used = true; break; }
		if (!used) for (const auto& [id, site] : factories)
			if (site.def == r.def && SameSite(site.pos, r.pos)) { used = true; break; }
		if (used) { ++it; continue; }
		Share(r, false);
		it = routes.erase(it);
		changed = true;
	}
	if (changed) Save();
}

void CFactoryCorridors::QueueRefresh()
{
	refresh.clear();
	// Release destroys the scheduler before the factory/builder managers.
	// Do not inspect those managers or reconstruct work during that teardown.
	CCircuitAI* circuit = terrain.circuit;
	if (!circuit->GetScheduler() || !enabled || !HasLane()) return;
	// Event-driven O(unconnected routes + factory slots + standing factories).
	// B2: connected roads need no refresh; capture values, since Ensure may
	// prune route records while the queue drains.
	for (const auto& [id, r] : routes) if (r.lane < 0) refresh.push_back({r.def, r.facing, r.pos});
	for (const auto& [id, r] : terrain.reservations) if (!r.consumed && !r.unitId
		&& r.def->GetId() != exemptDef && circuit->GetFactoryManager()->GetFactoryDef(r.def))
		refresh.push_back({r.def->GetId(), r.facing, r.pos});
	// C1: a factory built unrouted during the lane wait gets its road now.
	for (const auto& [unitId, site] : factories) {
		if (site.def == exemptDef) continue;
		bool routed = false;
		for (const auto& [id, r] : routes) if (r.def == site.def && SameSite(r.pos, site.pos)) { routed = true; break; }
		if (!routed) refresh.push_back({site.def, site.facing, site.pos});
	}
	DrainRefresh();
}

void CFactoryCorridors::DrainRefresh()
{
	if (refreshQueued || refresh.empty()) return;
	// No background budget: live placement asks plan routes themselves.
	if (options.backgroundProbes <= 0) { refresh.clear(); return; }
	auto* scheduler = terrain.circuit->GetScheduler().get();
	if (!scheduler) return;
	refreshQueued = true;
	const std::weak_ptr<int> alive = lifetime;
	scheduler->RunJobAfter(CScheduler::GameJob([this, alive]() {
		if (alive.expired()) return;
		refreshQueued = false;
		CCircuitAI* circuit = terrain.circuit;
		const int frame = circuit->GetLastFrame();
		if (probeFrame != frame) { probeFrame = frame; liveProbesUsed = 0; backgroundProbesUsed = 0; }
		// B4: the refresh spends only its own budget, so a real placement ask
		// is never refused because this advisory job ran first.
		for (int i = 0; i < kRefreshItemsPerJob && !refresh.empty() && ProbeBudget(true) > 0; ++i) {
			const auto request = refresh.back();
			refresh.pop_back();
			EnsureImpl(circuit->GetCircuitDef(request.def), request.pos, request.facing, true, true);
		}
		DrainRefresh();
	}), kRefreshDelayFrames);
}

void CFactoryCorridors::QueuePrune()
{
	if (pruneQueued || routes.empty()) return;
	// KI-736: ClearRelease still removes task claims after scheduler teardown.
	// That synchronous cleanup must succeed without queuing a future prune.
	// Borrow on the AI thread; do not extend scheduler lifetime across Release.
	auto* scheduler = terrain.circuit->GetScheduler().get();
	if (!scheduler) return;
	pruneQueued = true;
	const std::weak_ptr<int> alive = lifetime;
	scheduler->RunJobAfter(CScheduler::GameJob([this, alive]() {
		if (alive.expired()) return;
		pruneQueued = false;
		performance::Scope timing(terrain.circuit, performance::FACTORY_CORRIDOR);
		Prune();
	}), kGraceFrames + 1);
}

} // namespace circuit
