#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace BarrierReefRemake {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: The BARrier Reef Remake v1.0 (10240 x 10240 elmos, 80% of the ground below sea level, 71% below -30).
	// MapConfig matches "The BARrier Reef Remake" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 70-100%, z 40-100%; team 2: x 0-30%, z 0-60%) and plain engine spawns (BAR's start-point guesser),
	// each spawn moved to the middle of its 2-3 nearest mexes when they sit within 450 elmos.
	// Lanes: the map is cut across the attack axis into one lane per land spawn, each lane holding an equal
	// number of mexes; each land spawn gets its own lane (the richest 2-3 mex cluster in the box), so the team owns mexes along
	// the whole front instead of bunching where the engine put several AIs together. An engine spawn
	// that already had a lane to itself stays in it; SEA spawns keep the engine spot. (Only team 2: the other team is all sea.)
	// Roles: spawns on open water (a water body over 3% of the map) are SEA; of the land spawns the one farthest from the
	// enemy is TECH and the next AIR; the rest FRONT.
	// landLocked: true where no enemy spawn shares the spawn's land mass (ground above -20 elmos,
	// slopes ignored); a heuristic, not a path check.
	StartSpot@[] spots = {
		// Team 1
		StartSpot(AIFloat3(  7168, 0,   4096), AiRole::SEA,    true), // P1  engine spawn, engine team 0
		StartSpot(AIFloat3(  9906, 0,   4283), AiRole::SEA,    true), // P2  engine spawn, engine team 7
		StartSpot(AIFloat3(  8880, 0,   4525), AiRole::SEA,    true), // P3  middle of 3 mexes, engine team 3
		StartSpot(AIFloat3(  7773, 0,   5133), AiRole::SEA,    true), // P4  middle of 3 mexes, engine team 1
		StartSpot(AIFloat3(  7359, 0,   6293), AiRole::SEA,    true), // P5  engine spawn, engine team 5
		StartSpot(AIFloat3(  9652, 0,   7812), AiRole::AIR,    true), // P6  middle of 2 mexes, engine team 4
		StartSpot(AIFloat3(  7352, 0,   8389), AiRole::SEA,    true), // P7  engine spawn, engine team 2
		StartSpot(AIFloat3(  9344, 0,   9664), AiRole::TECH,   true), // P8  middle of 2 mexes, engine team 6
		// Team 2
		StartSpot(AIFloat3(  2832, 0,    600), AiRole::FRONT,  true), // P9  lane 1/3, middle of 2 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  3208, 0,   1852), AiRole::SEA,    true), // P10 middle of 2 mexes, engine team 10
		StartSpot(AIFloat3(   256, 0,   2244), AiRole::TECH,   true), // P11 lane 2/3, middle of 2 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  1952, 0,   2440), AiRole::SEA,    true), // P12 middle of 3 mexes, engine team 8
		StartSpot(AIFloat3(  1971, 0,   3680), AiRole::SEA,    true), // P13 middle of 3 mexes, engine team 9
		StartSpot(AIFloat3(   248, 0,   3968), AiRole::AIR,    true), // P14 lane 3/3, single mex (moved from a lane it shared)
		StartSpot(AIFloat3(  1284, 0,   4776), AiRole::SEA,    true), // P15 middle of 2 mexes, engine team 11
		StartSpot(AIFloat3(   501, 0,   6104), AiRole::SEA,    true)  // P16 middle of 3 mexes, engine team 13
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("The BARrier Reef Remake", mapUnitLimits, spots, getFactoryWeights());

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
