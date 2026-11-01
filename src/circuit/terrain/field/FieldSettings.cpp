/*
 * FieldSettings.cpp
 *
 * Part B1: see FieldSettings.h.
 */

#include "terrain/field/FieldSettings.h"
#include "terrain/field/FieldLandmarks.h"

#include "json/json.h"
#include <algorithm>

namespace circuit::field {

// Shared by the live field service and offline map regression: tuning must
// be exercised, not silently replaced by SSettings defaults in the test.
void ReadTerrainSettings(const Json::Value& root, SSettings& settings)
{
	const Json::Value& f = root["field"];
	settings.cellSize = f.get("cell_size", settings.cellSize).asInt();
	settings.regionMinCells = f.get("region_min_cells", settings.regionMinCells).asInt();
	settings.waterMinCells = f.get("water_min_cells", settings.waterMinCells).asInt();
	settings.chokeFraction = f.get("choke_fraction", settings.chokeFraction).asFloat();
	settings.highGroundRise = f.get("high_ground_rise", settings.highGroundRise).asFloat();
	settings.rampMinRise = std::max(1.f, f.get("ramp_min_rise", settings.rampMinRise).asFloat());
	settings.passageExpansion = std::max(1.05f, f.get("passage_expansion", settings.passageExpansion).asFloat());
	settings.passageProbeCells = std::clamp(f.get("passage_probe_cells", settings.passageProbeCells).asInt(), 8, 256);
	settings.beachDepth = f.get("beach_depth", settings.beachDepth).asFloat();
	settings.crossingMinLength = f.get("crossing_min_length", settings.crossingMinLength).asInt();
	settings.landingMerge = f.get("landing_merge", settings.landingMerge).asInt();
	settings.avenueDetour = f.get("avenue_detour", settings.avenueDetour).asFloat();
	settings.avenueMax = f.get("avenue_max", settings.avenueMax).asInt();
	settings.seaReach = f.get("sea_reach", settings.seaReach).asFloat();
	settings.pondMaxShare = f.get("pond_max_share", settings.pondMaxShare).asFloat();
	// D-358: the corridor planner's levers (field.json "corridors")
	const Json::Value& cr = f["corridors"];
	if (cr.isObject()) {
		settings.obstacleMinShare = std::clamp(cr.get("obstacle_min_share", settings.obstacleMinShare).asFloat(), 0.f, 0.1f);
		settings.corridorDetour = std::clamp(cr.get("detour", settings.corridorDetour).asFloat(), 1.f, 8.f);
		settings.corridorMax = std::clamp(cr.get("max_routes", settings.corridorMax).asInt(), 1, 32);
		settings.seamBlocked = std::clamp(cr.get("seam_blocked", settings.seamBlocked).asFloat(), 0.f, 1.f);
		settings.footprintWidth = std::clamp(cr.get("footprint_width", settings.footprintWidth).asFloat(), 0.f, 1024.f);
		settings.corridorBand = std::clamp(cr.get("band", settings.corridorBand).asFloat(), 16.f, 4096.f);
		settings.laneSpacing = std::clamp(cr.get("lane_spacing", settings.laneSpacing).asFloat(), 128.f, 4096.f);
		settings.laneMax = std::clamp(cr.get("lane_max", settings.laneMax).asInt(), 1, 8);
		settings.laneDistanceCost = std::clamp(cr.get("distance_cost", settings.laneDistanceCost).asFloat(), 0.f, 1.f);
	}
}

void ReadMarkSettings(const Json::Value& root, SMarkSettings& ms)
{
	const Json::Value& field = root["field"];
	ms.enabled = field.get("landmarks_enabled", ms.enabled).asBool();
	auto num = [](const Json::Value& block, const char* key, float& v) { v = block.get(key, v).asFloat(); };
	auto integer = [](const Json::Value& block, const char* key, int& v) { v = block.get(key, v).asInt(); };
	const Json::Value& pos = field["positions"];
	if (pos.isObject()) {
		num(pos, "walk_radius", ms.walkRadius); num(pos, "min_spacing", ms.minSpacing);
		integer(pos, "kmedoids_rounds", ms.kmedoidsRounds); integer(pos, "site_step", ms.siteStep);
		num(pos, "geo_weight", ms.geoWeight); num(pos, "area_weight", ms.areaWeight); num(pos, "metal_scale", ms.metalScale);
	}
	const Json::Value& lab = field["labels"];
	if (lab.isObject()) {
		num(lab, "sea_yard_reach", ms.seaYardReach); num(lab, "yard_depth", ms.yardDepth); num(lab, "yard_clear", ms.yardClear); num(lab, "sea_share_min", ms.seaShareMin); num(lab, "sea_full_share", ms.seaFullShare);
		num(lab, "geo_reach", ms.geoReach); integer(lab, "pond_min_cells", ms.pondMinCells); num(lab, "island_base_area", ms.islandBaseArea);
		num(lab, "rear_fraction", ms.rearFraction); num(lab, "geo_share_min", ms.geoShareMin);
		integer(lab, "air_per_side", ms.airPerSide); integer(lab, "tech_per_side", ms.techPerSide); integer(lab, "sea_per_sea", ms.seaPerSea);
		integer(lab, "air_min_positions", ms.airMinPositions); integer(lab, "tech_min_positions", ms.techMinPositions);
		num(lab, "front_tech_metal", ms.frontTechMetal); num(lab, "tech_area_weight", ms.techAreaWeight);
	}
	const Json::Value& op = field["openings"];
	if (op.isObject()) {
		num(op, "veh_share", ms.vehShare); num(op, "open_width", ms.openWidth); num(op, "veh_map_scale", ms.vehMapScale);
		num(op, "wind_min", ms.windMin); num(op, "tidal_margin", ms.tidalMargin);
		const Json::Value& fac = op["factories"];
		for (int c = 0; c < _OPENINGS_; ++c) {
			const Json::Value& ids = fac[OpeningName(c)];
			if (!ids.isArray()) continue;
			for (int f = 0; f < 3 && f < (int)ids.size(); ++f) ms.factories[c][f] = ids[f].asString();
		}
		const Json::Value& second = op["second"];
		for (int l = 0; l < _LABELS_; ++l) {
			if (second.isMember(LabelName(l))) ms.second[l] = second[LabelName(l)].asString();
		}
	}
	const Json::Value& lm = field["landmarks"];
	if (lm.isObject()) {
		num(lm, "contest_distance", ms.contestDistance); num(lm, "kill_reach", ms.killReach); num(lm, "radar_front_share", ms.radarFrontShare);
		num(lm, "perch_range", ms.perchRange); num(lm, "forward_income", ms.forwardIncome); num(lm, "forward_share_max", ms.forwardShareMax);
		num(lm, "artillery_ship_range", ms.artilleryShipRange); num(lm, "lrpc_range", ms.lrpcRange); num(lm, "antinuke_coverage", ms.antinukeCoverage);
		integer(lm, "labels_per_kind", ms.labelsPerKind); integer(lm, "lrpc_per_side", ms.lrpcPerSide);
		integer(lm, "antinuke_per_side", ms.antinukePerSide); integer(lm, "coast_targets", ms.coastTargets);
	}
}

} // namespace circuit::field
