#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace JadeEmpress {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: Jade Empress 1.41 (16384 x 16384 elmos, 59% of the ground below sea level, 51% below -30).
	// MapConfig matches "Jade Empress" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 14-55%, z 13-74.5% (polygon, bounding box shown); team 2: x 28-84%, z 45-87.5% (polygon, bounding box shown)) and plain engine spawns (BAR's start-point guesser),
	// each spawn moved to the middle of its 2-3 nearest mexes when they sit within 450 elmos.
	// Lanes: the map is cut across the attack axis into one lane per land spawn, each lane holding an equal
	// number of mexes; each land spawn gets its own lane (the richest 2-3 mex cluster in the box), so the team owns mexes along
	// the whole front instead of bunching where the engine put several AIs together. An engine spawn
	// that already had a lane to itself stays in it; SEA spawns keep the engine spot.
	// Roles: spawns on open water (a water body over 3% of the map) are SEA; of the land spawns the one farthest from the
	// enemy is TECH and the next AIR; the rest FRONT.
	// landLocked: true where no enemy spawn shares the spawn's land mass (ground above -20 elmos,
	// slopes ignored); a heuristic, not a path check.
	StartSpot@[] spots = {
		// Team 1
		StartSpot(AIFloat3(  5072, 0,   2784), AiRole::TECH,   false), // P1  lane 3/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  7515, 0,   3531), AiRole::FRONT,  false), // P2  lane 2/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  4272, 0,   3760), AiRole::AIR,    false), // P3  lane 4/7 shared (only 6 lanes had a site), middle of 3 mexes
		StartSpot(AIFloat3(  7509, 0,   4885), AiRole::SEA,    false), // P4  middle of 3 mexes, engine team 2
		StartSpot(AIFloat3(  5024, 0,   5392), AiRole::FRONT,  false), // P5  lane 4/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  6747, 0,   8720), AiRole::FRONT,  false), // P6  lane 5/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  5040, 0,  10608), AiRole::FRONT,  false), // P7  lane 6/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  4331, 0,  11349), AiRole::FRONT,  false), // P8  lane 7/7, middle of 3 mexes (moved from a lane it shared)
		// Team 2
		StartSpot(AIFloat3( 12971, 0,   8064), AiRole::AIR,    false), // P9  lane 6/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  9307, 0,   8395), AiRole::FRONT,  false), // P10 lane 4/7 shared (only 6 lanes had a site), middle of 3 mexes
		StartSpot(AIFloat3( 11563, 0,   8533), AiRole::SEA,    false), // P11 middle of 3 mexes, engine team 8
		StartSpot(AIFloat3( 13248, 0,   9573), AiRole::TECH,   false), // P12 lane 5/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 11952, 0,  10197), AiRole::FRONT,  false), // P13 lane 4/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 10779, 0,  11189), AiRole::FRONT,  false), // P14 lane 3/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  7376, 0,  11312), AiRole::FRONT,  false), // P15 lane 2/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  5963, 0,  12032), AiRole::FRONT,  false)  // P16 lane 1/7, middle of 3 mexes (moved from a lane it shared)
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("Jade Empress", mapUnitLimits, spots, getFactoryWeights());

	// Factory weights per role (higher weight = more likely).
	// Schema: role -> ( side -> (factory -> weight) )
	dictionary getFactoryWeights() {
		dictionary root; // role -> sideDict

		// FRONT role: side specific dictionaries
		dictionary frontArm; frontArm.set("armlab",2); frontArm.set("armvp",5);
		dictionary frontCor; frontCor.set("corlab",2); frontCor.set("corvp",5);
		dictionary frontLeg; frontLeg.set("leglab",2); frontLeg.set("legvp",5);
		dictionary frontRole; frontRole.set("armada", @frontArm); frontRole.set("cortex", @frontCor); frontRole.set("legion", @frontLeg);
		root.set("FRONT", @frontRole);

		// AIR role
		dictionary airArm; airArm.set("armap",3);
		dictionary airCor; airCor.set("corap",3);
		dictionary airLeg; airLeg.set("legap",3);
		dictionary airRole; airRole.set("armada", @airArm); airRole.set("cortex", @airCor); airRole.set("legion", @airLeg);
		root.set("AIR", @airRole);

		// SEA role
		dictionary seaArm; seaArm.set("armsy",4);
		dictionary seaCor; seaCor.set("corsy",4);
		dictionary seaLeg; seaLeg.set("legsy",4);
		dictionary seaRole; seaRole.set("armada", @seaArm); seaRole.set("cortex", @seaCor); seaRole.set("legion", @seaLeg);
		root.set("SEA", @seaRole);

		// TACTICAL role
		dictionary tacticalArm; tacticalArm.set("armhs",4); tacticalArm.set("armhp",4); tacticalArm.set("armsy",4);
		dictionary tacticalCor; tacticalCor.set("corhs",4); tacticalCor.set("corhp",4); tacticalCor.set("corsy",4);
		dictionary tacticalLeg; tacticalLeg.set("leghs",4); tacticalLeg.set("leghp",4); tacticalLeg.set("legsy",4);
		dictionary tacticalRole; tacticalRole.set("armada", @tacticalArm); tacticalRole.set("cortex", @tacticalCor); tacticalRole.set("legion", @tacticalLeg);
		root.set("TACTICAL", @tacticalRole);

		// TECH role
		dictionary techArm; techArm.set("armlab",4);
		dictionary techCor; techCor.set("corlab",4);
		dictionary techLeg; techLeg.set("leglab",4);
		dictionary techRole; techRole.set("armada", @techArm); techRole.set("cortex", @techCor); techRole.set("legion", @techLeg);
		root.set("TECH", @techRole);

		// SUPPORT role
		dictionary supportArm; supportArm.set("armlab",4);
		dictionary supportCor; supportCor.set("corlab",4);
		dictionary supportLeg; supportLeg.set("leglab",4);
		dictionary supportRole; supportRole.set("armada", @supportArm); supportRole.set("cortex", @supportCor); supportRole.set("legion", @supportLeg);
		root.set("SUPPORT", @supportRole);

		return root;
	}

}
