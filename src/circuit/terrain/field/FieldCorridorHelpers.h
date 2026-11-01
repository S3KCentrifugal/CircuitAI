// Engine-free stages. Borrowed inputs, caller-owned output/scratch buffers;
// raster sizes must match their grid and outputs must not alias inputs.
// No retained state, virtual dispatch, callbacks or extra raster copies.
#ifndef SRC_CIRCUIT_TERRAIN_FIELD_FIELDCORRIDORHELPERS_H_
#define SRC_CIRCUIT_TERRAIN_FIELD_FIELDCORRIDORHELPERS_H_
#include "terrain/field/FieldCorridors.h"
namespace circuit::field::corridor {
// Cost floor stops arbitrarily wide ground making a detour almost free. Inline
// scalar arithmetic in existing raster passes: no new search or allocation.
inline float CentreCost(int clearance, float distanceCost) { return distanceCost + 1.f / (float)(clearance + 1); }

using Paths = std::vector<std::vector<int>>;
struct Geometry {
 SGridShape g, fg;
 int ratio, mapWidth, mapHeight;
 float cell;
 SPoint origin;
 float ax, az;
 Geometry(SGridShape grid, SGridShape fine, int size, SPoint from, SPoint to, int width, int height)
  : g(grid), fg(fine), ratio(std::max(1, size / 16)), mapWidth(width), mapHeight(height), cell((float)size), origin(from) {
  const float length = std::max(1.f, std::hypot(to.x-from.x, to.z-from.z));
  ax = (to.x-from.x)/length; az = (to.z-from.z)/length;
 }
 int Coarse(int c) const { return g.Index(std::min(g.gw-1, fg.X(c)/ratio), std::min(g.gh-1, fg.Z(c)/ratio)); }
 SPoint Centre(int c) const { return {(g.X(c)+0.5f)*cell, (g.Z(c)+0.5f)*cell}; }
 float Forward(float x, float z) const { return (x-origin.x)*ax+(z-origin.z)*az; }
 float Sideways(float x, float z) const { return -(x-origin.x)*az+(z-origin.z)*ax; }
};
// O(fine cells), reuses all caller-owned raster allocations.
void BuildClearance(
		const Geometry& geometry,
		const std::vector<unsigned char>& pass,
		std::vector<char>& open,
		std::vector<char>& fineMask,
		std::vector<int>& clr16,
		std::vector<int>& clr,
		std::vector<int>& clrMin);

// O(fine cells), appends obstacle records; four-connected closed components.
void FindObstacles(
		const SGridShape& fg,
		const std::vector<unsigned char>& pass,
		int obstacleMin,
		int cls,
		std::vector<int>& comp,
		std::vector<char>& kept16,
		std::vector<SObstacle>& obstacles);

// Bounded Dijkstra candidates, O(routes * cells log cells) plus band stamping.
Paths FindCandidates(
		const Geometry& geometry,
		const SSettings& st,
		const std::atomic<bool>* cancel,
		const std::vector<int>& seedsA,
		const std::vector<char>& goal,
		const std::vector<char>& open,
		const std::vector<int>& clr,
		const std::vector<int>& clrMin,
		std::vector<char>& routeOpen,
		std::vector<float>& cost);

// Sort lateral routes then scan fine-grid seams between adjacent routes.
int GroupRoutes(
		const Geometry& geometry,
		const Paths& routes,
		float seamBlocked,
		const std::vector<char>& kept16,
		std::vector<char>& inside,
		std::vector<char>& seamBins,
		std::vector<char>& blockedBins,
		std::vector<int>& group);

// Multi-source Dijkstra, O(cells log cells); lower group wins equal costs.
void AssignOwnership(
		const SGridShape& g,
		const std::vector<char>& open,
		const Paths& routes,
		const std::vector<int>& group,
		std::vector<std::int16_t>& owner);

// O(path vertices) plus Douglas-Peucker simplification; empty path allowed.
SCorridor MakeRecord(
		const Geometry& geometry,
		int cls,
		int id,
		const std::vector<int>& path,
		const std::vector<int>& clr,
		float footprintWidth,
		int routeCount,
		int lane,
		int lanes);

// One Dijkstra. Preconditions: firstRoute names a non-empty candidate in gi.
std::vector<int> FindCentre(
		const Geometry& geometry,
		const Paths& routes,
		const std::vector<int>& group,
		int gi,
		int firstRoute,
		const std::vector<int>& seedsA,
		const std::vector<int>& seedsB,
		const std::vector<char>& routeOpen,
		const std::vector<std::int16_t>& owner,
		const std::vector<int>& clr,
		float distanceCost,
		std::vector<char>& free,
		std::vector<char>& goal,
		std::vector<float>& cost);

// O(cells * centre vertices + bin sorting + lanes * cells log cells).
// Scratch remains local to this passage; outputs move into published records.
int BuildLanePaths(
		const Geometry& geometry,
		const SSettings& st,
		int gi,
		const std::vector<char>& open,
		const std::vector<char>& free,
		const std::vector<std::int16_t>& owner,
		const std::vector<int>& clr,
		SCorridor& whole,
		std::vector<char>& goal,
		Paths& lanePaths,
		std::vector<int>& bandOf);
}
#endif
