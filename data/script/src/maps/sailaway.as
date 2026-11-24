#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace SailAway {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: SailAway 2 (10240 x 10240 elmos, 70% of the ground below sea level, 63% below -30).
	// MapConfig matches "SailAway" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 0-100%, z 0-24%; team 2: x 0-100%, z 76-100%) and plain engine spawns (BAR's start-point guesser),
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
		StartSpot(AIFloat3(  4973, 0,    205), AiRole::FRONT,  true), // P1  lane 3/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(   371, 0,    840), AiRole::TECH,   true), // P2  lane 5/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  2712, 0,   1069), AiRole::SEA,    true), // P3  middle of 3 mexes, engine team 3
		StartSpot(AIFloat3(  6531, 0,   1309), AiRole::FRONT,  true), // P4  lane 2/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  9763, 0,   1517), AiRole::AIR,    true), // P5  lane 1/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  8259, 0,   1725), AiRole::SEA,    true), // P6  middle of 3 mexes, engine team 4
		StartSpot(AIFloat3(  5219, 0,   2328), AiRole::SEA,    true), // P7  middle of 3 mexes, engine team 5
		StartSpot(AIFloat3(  3320, 0,   2419), AiRole::FRONT,  true), // P8  lane 4/5, middle of 3 mexes (engine spawn was in this lane)
		// Team 2
		StartSpot(AIFloat3(  6920, 0,   7821), AiRole::FRONT,  true), // P9  lane 4/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  5021, 0,   7912), AiRole::SEA,    true), // P10 middle of 3 mexes, engine team 12
		StartSpot(AIFloat3(  1981, 0,   8515), AiRole::SEA,    true), // P11 middle of 3 mexes, engine team 11
		StartSpot(AIFloat3(   477, 0,   8723), AiRole::AIR,    true), // P12 lane 1/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  3709, 0,   8931), AiRole::FRONT,  true), // P13 lane 2/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  7528, 0,   9171), AiRole::SEA,    true), // P14 middle of 3 mexes, engine team 10
		StartSpot(AIFloat3(  9869, 0,   9400), AiRole::TECH,   true), // P15 lane 5/5, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  5267, 0,  10035), AiRole::FRONT,  true)  // P16 lane 3/5, middle of 3 mexes (engine spawn was in this lane)
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("SailAway", mapUnitLimits, spots, getFactoryWeights());

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
