/*
 * BattleLanes.cpp
 *
 * D-127: lanes between both teams' start positions, per movement class
 * (doc/roles/tech-lanes.md). Passability is the engine's own test: the slope
 * map (1 - cos(angle), 16 elmos a pixel) against each BAR movedef class's
 * maxslope, and the depth limits (gamedata/movedefs.lua):
 *   land (tanks, TANK2..HTANK4)      27 deg -> 0.109, wade 20
 *   bot (BOT2..HBOT7)                54 deg -> 0.412, wade 20
 *   amphibious (ABOT3, ATANK3, ...)  54 deg on land, any water
 *   hover (HOVER2..HHOVER4)          33 deg -> 0.161 on land, any water
 *   all-terrain (TBOT3, HTBOT6)      90 deg, wade 20
 *   naval (BOAT3..5)                 8 deep
 *   air                              everywhere; cost rises with enemy AA
 * For each class, least capable first, a Dijkstra from every enemy start to
 * all cells; from each of our team's starts, the path to the nearest enemy
 * start; repeated with the used cells penalised for alternatives. A path that
 * runs mostly within the merge radius of a lane already found joins it, so a
 * lane is kept under the least capable class that can use it: an all-terrain
 * lane is one only spiders and all-terrain bots can take.
 */

#include "terrain/BattleAnalysis.h"
#include "terrain/TerrainManager.h"
#include "map/ThreatMap.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "spring/SpringMap.h"

#include "Log.h"
#include "scheduler/Scheduler.h"
#include <chrono>
#include <exception>

#include <algorithm>
#include <cmath>
#include <limits>
#include <queue>
#include <map>

namespace circuit {

using namespace springai;

static const int NB[8][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};

#define SLOPE_TANK   0.109f   // 1 - cos(27 deg)
#define SLOPE_HOVER  0.161f   // 1 - cos(33 deg)
#define SLOPE_BOT    0.412f   // 1 - cos(54 deg)
#define WADE_DEPTH   20.f
#define SHIP_DEPTH   8.f


namespace {
using LaneClock = std::chrono::steady_clock;
double LaneMilliseconds(LaneClock::time_point start) {
    return std::chrono::duration<double, std::milli>(LaneClock::now()-start).count();
}
float LaneFinite(float v, float fallback, float lo, float hi) {
    return std::isfinite(v) ? std::clamp(v, lo, hi) : fallback;
}
}

lane::Request CBattleAnalysis::CaptureLaneRequest(int alternatives, float mergeRadius, float threatWeight,
        float specialistBias, float highGroundRise, float highGroundDetour, int highGroundRoutes)
{
    // Engine access is confined to this main-thread boundary. Terrain is built
    // once per AI and shared by its jobs; dynamic threats and endpoints are
    // copied per request, never shared across teams with different knowledge.
    EnsureGrid();
    BuildWater();
    if (!laneTerrain) {
        auto snapshot = std::make_shared<lane::Terrain>();
        snapshot->gw = gw; snapshot->gh = gh; snapshot->cellSize = cellSize;
        snapshot->height = height; snapshot->surfaceSlope = surfaceSlope; snapshot->body8 = body8;
        for (int c = 0; c < _LANE_CLASSES_; ++c) snapshot->pass[c] = pass[c];
        laneTerrain = std::move(snapshot);
    }
    lane::Request r;
    r.settings = laneSettings;
    r.alternatives = std::clamp(alternatives, 1, 8);
    r.highGroundRoutes = std::clamp(highGroundRoutes, 0, 16);
    r.mergeRadius = LaneFinite(mergeRadius, 450.f, 0.f, 4096.f);
    r.threatWeight = LaneFinite(threatWeight, 1.f, 0.f, 100.f);
    r.specialistBias = LaneFinite(specialistBias, 1.f, 1.f, 8.f);
    r.highGroundRise = LaneFinite(highGroundRise, 128.f, 0.f, 8192.f);
    r.highGroundDetour = LaneFinite(highGroundDetour, 3.f, 1.f, 16.f);
    auto copyEnds = [](const std::vector<AIFloat3>& input, std::vector<lane::Point>& output) {
        output.reserve(input.size());
        for (const auto& p : input) if (std::isfinite(p.x) && std::isfinite(p.z)) output.emplace_back(p.x,p.y,p.z);
    };
    copyEnds(allyEnds, r.allyEnds); copyEnds(enemyEnds, r.enemyEnds);
    r.airThreat.resize(height.size()); r.surfThreat.resize(height.size());
    const CThreatMap* threat = circuit->GetThreatMap();
    for (int c = 0; c < gw*gh; ++c) {
        const auto p = CellPos(c);
        r.airThreat[c] = LaneFinite(threat->GetAirThreatAtPos(p), 0.f, 0.f, 1e9f);
        r.surfThreat[c] = LaneFinite(threat->GetSurfThreatAtPos(p), 0.f, 0.f, 1e9f);
    }
    return r;
}

bool CBattleAnalysis::StartLaneAnalysis(bool background, int alternatives, float mergeRadius, float threatWeight,
        float specialistBias, float highGroundRise, float highGroundDetour, int highGroundRoutes)
{
    const auto token = laneJobs.Begin();
    if (token == 0) return false; // coalesce, including while a cancelled worker winds down
    const auto begin = LaneClock::now();
    try {
        auto request = CaptureLaneRequest(alternatives,mergeRadius,threatWeight,specialistBias,
            highGroundRise,highGroundDetour,highGroundRoutes);
        const double captureMs = LaneMilliseconds(begin);
        laneCancel = std::make_shared<std::atomic<bool>>(false);
        // Never capture this or circuit on a worker. Immutable snapshot ownership
        // outlives teardown; the weak AI owner is locked ONLY by main completion.
        // The scheduler's finish queue is the happens-before handoff for results.
        struct Result {
            std::vector<lane::Route> routes;
            std::uint64_t searches = 0, expanded = 0, fingerprint = 0;
            double queueMs = 0, solveMs = 0;
            std::exception_ptr error;
        };
        auto result = std::make_shared<Result>();
        // Allocate the return callback on main as well. Even an allocation
        // failure inside the solver is caught; nothing escapes the worker entry.
        auto complete = CScheduler::GameJob([owner = weak_from_this(), token, cancel = laneCancel,
                                            result, captureMs, background]() {
            const auto self = owner.lock();
            if (!self || !self->laneJobs.Finish(token)) return;
            self->laneCancel.reset();
            if (cancel->load(std::memory_order_relaxed)) return;
            if (result->error) {
                try { std::rethrow_exception(result->error); }
                catch (const std::exception& e) { self->circuit->LOG("LANES: worker failed: %s", e.what()); }
                catch (...) { self->circuit->LOG("LANES: worker failed: unknown exception"); }
                return; // retain last good lanes; script observes failed completion
            }
            const auto publish = LaneClock::now();
            self->lanes.swap(result->routes); // complete generation; readers run only on main
            ++self->laneRevision;
            self->circuit->LOG("LANE_PERF team=%i revision=%i mode=%s cells=%i lanes=%i snapshot_ms=%.3f queue_ms=%.3f solve_ms=%.3f publish_ms=%.3f searches=%llu expanded=%llu fingerprint=%llu",
                self->circuit->GetTeamId(), self->laneRevision, background ? "worker" : "sync", self->gw*self->gh,
                int(self->lanes.size()), captureMs, result->queueMs, result->solveMs, LaneMilliseconds(publish),
                static_cast<unsigned long long>(result->searches), static_cast<unsigned long long>(result->expanded),
                static_cast<unsigned long long>(result->fingerprint));
        });
        auto work = [terrain = laneTerrain, request = std::move(request), cancel = laneCancel,
                     result, complete, queued = LaneClock::now()]() -> std::shared_ptr<IMainJob> {
            result->queueMs = LaneMilliseconds(queued);
            const auto start = LaneClock::now();
            try {
                lane::Solver solver(*terrain, request.settings, cancel.get());
                result->routes = solver.Run(request);
                result->searches = solver.Searches(); result->expanded = solver.Expanded();
                result->fingerprint = lane::Fingerprint(result->routes);
            } catch (...) {
                result->error = std::current_exception(); // includes cooperative cancellation
            }
            result->solveMs = LaneMilliseconds(start);
            return complete;
        };
        if (background) circuit->GetScheduler()->RunBackgroundJob(CScheduler::WorkJob(std::move(work)));
        else work()->Run(); // profiling/reference mode uses exactly the same solver and publication
        return true;
    } catch (const std::exception& e) {
        laneJobs.Finish(token);
        circuit->LOG("LANES: snapshot failed: %s", e.what());
    } catch (...) {
        laneJobs.Finish(token);
        circuit->LOG("LANES: snapshot failed: unknown exception");
    }
    return false;
}

bool CBattleAnalysis::RequestLanes(int alternatives, float mergeRadius, float threatWeight, float specialistBias,
        float highGroundRise, float highGroundDetour, int highGroundRoutes)
{
    return StartLaneAnalysis(true, alternatives, mergeRadius, threatWeight, specialistBias,
        highGroundRise, highGroundDetour, highGroundRoutes);
}
int CBattleAnalysis::AnalyseLanes(int alternatives, float mergeRadius, float threatWeight, float specialistBias,
        float highGroundRise, float highGroundDetour, int highGroundRoutes)
{
    StartLaneAnalysis(false, alternatives, mergeRadius, threatWeight, specialistBias,
        highGroundRise, highGroundDetour, highGroundRoutes);
    return GetLaneCount();
}
void CBattleAnalysis::EndLanePostprocess()
{
    circuit->LOG("LANE_POST team=%i revision=%i main_ms=%.3f", circuit->GetTeamId(), laneRevision,
        LaneMilliseconds(lanePostStart));
}
void CBattleAnalysis::CancelLaneRequest()
{
    laneJobs.Invalidate();
    if (laneCancel) laneCancel->store(true, std::memory_order_relaxed);
}

void CBattleAnalysis::BuildPass()
{
	const size_t N = height.size();
	if (N > static_cast<size_t>(std::numeric_limits<int>::max())) return;
	FloatVec slope;
	circuit->GetMap()->GetSlopeMap(slope);
	const int sw = std::max(1, CTerrainManager::GetTerrainWidth() / 16);
	const int sh = std::max(1, CTerrainManager::GetTerrainHeight() / 16);
	const int per = cellSize / 16;   // slope pixels a cell side
	for (int k = 0; k < _LANE_CLASSES_; ++k) {
		pass[k].assign(N, 0);
	}
	surfaceSlope.assign(N, 0.f);
	for (size_t c = 0; c < N; ++c) {
		const int cx = c % gw, cz = c / gw;
		int n = 0, tank = 0, hover = 0, bot = 0;
		for (int z = cz * per; z < (cz + 1) * per && z < sh; ++z) {
			for (int x = cx * per; x < (cx + 1) * per && x < sw; ++x) {
				const size_t i = size_t(z) * sw + x;
				const float s = (i < slope.size()) ? slope[i] : 0.f;
				surfaceSlope[c] += std::clamp(s, 0.f, 1.f);
				++n;
				tank += (s <= SLOPE_TANK);
				hover += (s <= SLOPE_HOVER);
				bot += (s <= SLOPE_BOT);
			}
		}
		n = std::max(1, n);
		surfaceSlope[c] /= n;
		const bool water = height[c] < 0.f;
		const bool wadable = height[c] >= -WADE_DEPTH;
		pass[L_LAND][c] = wadable && (tank * 2 >= n);
		pass[L_BOT][c] = wadable && (bot * 2 >= n);
		pass[L_ALLTERRAIN][c] = wadable;
		pass[L_AMPH][c] = water || (bot * 2 >= n);
		pass[L_HOVER][c] = water || (hover * 2 >= n);
		pass[L_NAVAL][c] = maxHeight[c] <= -SHIP_DEPTH;
		pass[L_AIR][c] = 1;
	}
}

bool CBattleAnalysis::IsPassable(const AIFloat3& pos, int cls) const
{
	if ((cls < 0) || (cls >= _LANE_CLASSES_) || pass[cls].empty()) {
		return false;
	}
	return pass[cls][Cell(pos)];
}

void CBattleAnalysis::Clearance(std::vector<int>& clr, int cls) const
{
    lane::Solver::Clearance(gw, gh, pass[cls], clr);
}

int CBattleAnalysis::GetLaneClass(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].cls : -1; }
int CBattleAnalysis::GetLaneMask(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].mask : 0; }
void CBattleAnalysis::SetCliffDescentParams(int approachClass, float minDrop, float maxRun, float minProgress)
{
	laneSettings.cliffApproachClass = (approachClass >= L_LAND && approachClass <= L_BOT) ? approachClass : -1;
	laneSettings.cliffMinDrop = std::isfinite(minDrop) ? std::clamp(minDrop, 64.f, 2000.f) : 256.f;
	laneSettings.cliffMaxRun = std::isfinite(maxRun) ? std::clamp(maxRun, 128.f, 4096.f) : 1600.f;
	laneSettings.cliffMinProgress = std::isfinite(minProgress) ? std::clamp(minProgress, 0.f, 1.f) : 0.6f;
}
void CBattleAnalysis::SetMountainPathParams(float gradeWeight, float peakTolerance)
{
	laneSettings.mountainGradeWeight = std::isfinite(gradeWeight) ? std::clamp(gradeWeight, 0.f, 64.f) : 8.f;
	laneSettings.mountainPeakTolerance = std::isfinite(peakTolerance) ? std::clamp(peakTolerance, 0.f, 1024.f) : 256.f;
}
void CBattleAnalysis::SetMountainShelfParams(float surfaceWeight, float heightWeight)
{
	laneSettings.mountainSurfaceWeight = std::isfinite(surfaceWeight) ? std::clamp(surfaceWeight, 0.f, 64.f) : 12.f;
	laneSettings.mountainHeightWeight = std::isfinite(heightWeight) ? std::clamp(heightWeight, 0.f, 32.f) : 4.f;
}
void CBattleAnalysis::SetCliffPreference(float weight, float qualityTolerance, float heightFraction)
{
	laneSettings.cliffPreference = std::isfinite(weight) ? std::clamp(weight, 0.f, 32.f) : 8.f;
	laneSettings.cliffQualityTolerance = std::isfinite(qualityTolerance) ? std::clamp(qualityTolerance, 0.f, 1.f) : 0.1f;
	laneSettings.cliffHeightFraction = std::isfinite(heightFraction) ? std::clamp(heightFraction, 0.f, 1.f) : 0.5f;
}
AIFloat3 CBattleAnalysis::GetLaneAscent(int i) const
{
	return (i >= 0 && i < int(lanes.size()) && lanes[i].ascent >= 0) ? CellPos(lanes[i].ascent) : AIFloat3(-1.f, 0.f, 0.f);
}
float CBattleAnalysis::GetLaneCliffQuality(int i, int end) const
{
	return (i >= 0 && i < int(lanes.size()) && end >= 0 && end < 2) ? lanes[i].cliffQuality[end] : 0.f;
}
AIFloat3 CBattleAnalysis::GetLaneDescent(int i) const
{
	return (i >= 0 && i < int(lanes.size()) && lanes[i].descent >= 0) ? CellPos(lanes[i].descent) : AIFloat3(-1.f, 0.f, 0.f);
}
float CBattleAnalysis::GetLaneLength(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].length : 0.f; }
float CBattleAnalysis::GetLaneWidth(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].width : 0.f; }
float CBattleAnalysis::GetLaneThreat(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].threat : 0.f; }
float CBattleAnalysis::GetLaneFront(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].front : -1.f; }
int CBattleAnalysis::GetLaneHeat(int i) const { return ((i >= 0) && (i < (int)lanes.size())) ? lanes[i].heat : 0; }

AIFloat3 CBattleAnalysis::GetLaneChoke(int i) const
{
	return ((i >= 0) && (i < (int)lanes.size())) ? CellPos(lanes[i].choke) : AIFloat3(-1.f, 0.f, 0.f);
}

AIFloat3 CBattleAnalysis::GetLanePoint(int i, float share) const
{
	if ((i < 0) || (i >= (int)lanes.size()) || lanes[i].cells.empty()) {
		return AIFloat3(-1.f, 0.f, 0.f);
	}
	const std::vector<int>& p = lanes[i].cells;
	const float f = std::max(0.f, std::min(1.f, share)) * (p.size() - 1);
	const int a = int(f);
	const int b = std::min((int)p.size() - 1, a + 1);
	const AIFloat3 pa = CellPos(p[a]), pb = CellPos(p[b]);
	const float t = f - a;
	AIFloat3 r(pa.x + (pb.x - pa.x) * t, 0.f, pa.z + (pb.z - pa.z) * t);
	r.y = Height(r);
	return r;
}

std::vector<AIFloat3> CBattleAnalysis::GetTerrainRoute(const AIFloat3& from, const AIFloat3& to,
        int cls, float landCost, float waterCost, float threatWeight, float maxWaterThreat)
{
    EnsureGrid();
    if (!laneTerrain) CaptureLaneRequest(1, 0.f, 0.f, 1.f, 0.f, 1.f, 0);
    Grid threat(height.size());
    for (size_t c = 0; c < threat.size(); ++c) {
        const auto p = CellPos(c);
        threat[c] = cls == L_AIR ? AirThreat(p) : (cls == L_AMPH ? AmphThreat(p) : SurfThreat(p));
    }
    const auto cells = lane::Solver(*laneTerrain, laneSettings).PointRoute(
        {from.x, from.y, from.z}, {to.x, to.y, to.z}, cls, threat,
        landCost, waterCost, threatWeight, maxWaterThreat);
    std::vector<AIFloat3> result;
    result.reserve(cells.size());
    for (int c : cells) { auto p = CellPos(c); p.y = Height(p); result.push_back(p); }
    return result;
}

std::vector<AIFloat3> CBattleAnalysis::GetLaneRoute(int lane, const AIFloat3& from, int cls) const
{
	std::vector<AIFloat3> result;
	if (lane < 0 || lane >= static_cast<int>(lanes.size()) || cls < 0 || cls >= _LANE_CLASSES_
			|| !(lanes[lane].mask & (1 << cls)) || lanes[lane].cells.empty()
			|| !std::isfinite(from.x) || !std::isfinite(from.z) || from.x < 0.f || from.z < 0.f
			|| from.x >= gw * cellSize || from.z >= gh * cellSize) return result;
	// Never snap an inaccessible start across water or a cliff to another component.
	const int origin = Cell(from), entry = lanes[lane].cells.front();
	if (!pass[cls][origin] || !pass[cls][entry]) return result;
	Grid distance;
	std::vector<int> previous;
	lane::Solver(*laneTerrain, laneSettings).DijkstraMulti({entry}, Grid(height.size(), 1.f), cls, nullptr, distance, previous);
	if (distance[origin] == std::numeric_limits<float>::max()) return result;
	int at = origin;
	for (size_t step = 0; step < height.size() && at != entry; ++step) {
		result.push_back(CellPos(at));
		at = previous[at];
		if (at < 0) return {};
	}
	if (at != entry) return {};
	for (int cell : lanes[lane].cells) result.push_back(CellPos(cell));
	return result;
}

} // namespace circuit

void circuit::CBattleAnalysis::SetSpecialistSpan(float minimum, float fraction)
{
    laneSettings.specialistMinSpan = std::isfinite(minimum) ? std::clamp(minimum, 0.f, 16384.f) : 1024.f;
    laneSettings.specialistSpanFraction = std::isfinite(fraction) ? std::clamp(fraction, 0.f, 1.f) : 0.45f;
}

bool circuit::CBattleAnalysis::IsLaneSpecialist(int i) const
{
    return i >= 0 && i < int(lanes.size()) && lanes[i].cls == L_ALLTERRAIN && lanes[i].mountainQualified;
}
