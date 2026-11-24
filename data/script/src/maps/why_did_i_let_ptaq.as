#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace WhyDidILetPtaQ {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: Why did I let PtaQ talk me into this 1.0 (16384 x 16384 elmos, 59% of the ground below sea level, 50% below -30).
	// MapConfig matches "Why did I let PtaQ talk me into this" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 10.5-40%, z 31-96.5%; team 2: x 61-94.5%, z 29-96.5%) and plain engine spawns (BAR's start-point guesser),
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
		StartSpot(AIFloat3(  3928, 0,   5147), AiRole::FRONT,  false), // P1  lane 2/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  5005, 0,   5861), AiRole::SEA,    false), // P2  middle of 3 mexes, engine team 1
		StartSpot(AIFloat3(  5989, 0,   5989), AiRole::FRONT,  false), // P3  lane 3/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  2083, 0,   6397), AiRole::TECH,   false), // P4  lane 3/7 shared (only 6 lanes had a site), middle of 3 mexes
		StartSpot(AIFloat3(  2405, 0,   7861), AiRole::AIR,    false), // P5  lane 4/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  2952, 0,   9064), AiRole::FRONT,  false), // P6  lane 5/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  4603, 0,  12168), AiRole::FRONT,  false), // P7  lane 6/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  6501, 0,  13640), AiRole::FRONT,  false), // P8  lane 7/7, middle of 3 mexes (moved from a lane it shared)
		// Team 2
		StartSpot(AIFloat3( 11992, 0,   4803), AiRole::AIR,    false), // P9  lane 7/7, middle of 3 mexes (moved from a lane it shared)
		StartSpot(AIFloat3( 11109, 0,   5704), AiRole::SEA,    false), // P10 middle of 3 mexes, engine team 8
		StartSpot(AIFloat3( 10133, 0,   5805), AiRole::FRONT,  false), // P11 lane 6/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 12341, 0,   7333), AiRole::FRONT,  false), // P12 lane 5/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 12099, 0,   8523), AiRole::FRONT,  false), // P13 lane 4/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 10432, 0,  10581), AiRole::FRONT,  false), // P14 lane 3/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 11936, 0,  12123), AiRole::TECH,   false), // P15 lane 2/7, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 10384, 0,  13371), AiRole::FRONT,  false)  // P16 lane 1/7, middle of 3 mexes (engine spawn was in this lane)
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("Why did I let PtaQ talk me into this", mapUnitLimits, spots, getFactoryWeights());

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
