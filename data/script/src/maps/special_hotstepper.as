#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace SpecialHotstepper {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: Special Hotstepper 1.1.1 (16384 x 16384 elmos, 13% of the ground below sea level, 12% below -30).
	// MapConfig matches "Special Hotstepper" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 0-20%, z 0-99.5%; team 2: x 80-100%, z 0-100%) and plain engine spawns (BAR's start-point guesser),
	// each spawn snapped to the nearest of the map's labeled start positions.
	// Lanes: the map is cut across the attack axis into one lane per land spawn, each lane holding an equal
	// number of mexes; each land spawn gets its own lane (the best labeled position inside the box), so the team owns mexes along
	// the whole front instead of bunching where the engine put several AIs together. An engine spawn
	// that already had a lane to itself stays in it; SEA spawns keep the engine spot.
	// Roles: water spawns (ground below -10) are SEA; of the land spawns the one farthest from the
	// enemy is TECH and the next AIR; the rest FRONT.
	// landLocked: true where no enemy spawn shares the spawn's land mass (ground above -20 elmos,
	// slopes ignored); a heuristic, not a path check.
	StartSpot@[] spots = {
		// Team 1
		StartSpot(AIFloat3(  1178, 0,   1232), AiRole::TECH,   false), // P1  lane 1/8, labeled P0 (engine spawn was in this lane)
		StartSpot(AIFloat3(  2779, 0,   3107), AiRole::FRONT,  false), // P2  lane 2/8, labeled P5 (engine spawn was in this lane)
		StartSpot(AIFloat3(  1785, 0,   4498), AiRole::FRONT,  false), // P3  lane 3/8, labeled P7 (engine spawn was in this lane)
		StartSpot(AIFloat3(  1581, 0,   6241), AiRole::FRONT,  false), // P4  lane 4/8, labeled P56 (engine spawn was in this lane)
		StartSpot(AIFloat3(   658, 0,   8381), AiRole::FRONT,  false), // P5  lane 5/8, labeled P17 (engine spawn was in this lane)
		StartSpot(AIFloat3(   692, 0,   9766), AiRole::FRONT,  false), // P6  lane 6/8, labeled P19 (engine spawn was in this lane)
		StartSpot(AIFloat3(  1015, 0,  13392), AiRole::AIR,    false), // P7  lane 7/8, labeled P25 (engine spawn was in this lane)
		StartSpot(AIFloat3(  2295, 0,  15291), AiRole::FRONT,  false), // P8  lane 8/8, labeled P29 (moved from a lane it shared)
		// Team 2
		StartSpot(AIFloat3( 14338, 0,   2059), AiRole::FRONT,  false), // P9  lane 7/8, labeled P2 (engine spawn was in this lane)
		StartSpot(AIFloat3( 15308, 0,   4173), AiRole::FRONT,  false), // P10 lane 6/8, labeled P8 (engine spawn was in this lane)
		StartSpot(AIFloat3( 15300, 0,   7010), AiRole::FRONT,  false), // P11 lane 5/8, labeled P12 (engine spawn was in this lane)
		StartSpot(AIFloat3( 13753, 0,   7673), AiRole::FRONT,  false), // P12 lane 4/8, labeled P14 (moved from a lane it shared)
		StartSpot(AIFloat3( 15975, 0,   9693), AiRole::TECH,   false), // P13 lane 3/8 shared (only 7 lanes had a site), labeled P18
		StartSpot(AIFloat3( 15368, 0,  11543), AiRole::AIR,    false), // P14 lane 3/8, labeled P22 (engine spawn was in this lane)
		StartSpot(AIFloat3( 14433, 0,  13768), AiRole::FRONT,  false), // P15 lane 2/8, labeled P26 (engine spawn was in this lane)
		StartSpot(AIFloat3( 13993, 0,  14707), AiRole::FRONT,  false)  // P16 lane 1/8, labeled P28 (moved from a lane it shared)
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("Special Hotstepper", mapUnitLimits, spots, getFactoryWeights());

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
