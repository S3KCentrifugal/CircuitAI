#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace NineMetalIslands {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: Nine_Metal_Islands_V1 (16384 x 16384 elmos, 89% of the ground below sea level, 88% below -30).
	// MapConfig matches "Nine_Metal_Islands" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): an 8v8 headless game with the map's default start boxes
	// (team 1: x 0-35%, z 0-100%; team 2: x 65-100%, z 0-100%) and plain engine spawns (BAR's start-point guesser),
	// kept as spawned (metal map: no mex spots to snap to).
	// Roles: spawns on open water (a water body over 3% of the map) are SEA; of the land spawns the one farthest from the
	// enemy is TECH and the next AIR; the rest FRONT.
	// landLocked: true where no enemy spawn shares the spawn's land mass (ground above -20 elmos,
	// slopes ignored); a heuristic, not a path check.
	StartSpot@[] spots = {
		// Team 1
		StartSpot(AIFloat3(  2064, 0,   5120), AiRole::AIR,    true), // P1  engine spawn, engine team 4
		StartSpot(AIFloat3(  2064, 0,   6144), AiRole::FRONT,  true), // P2  engine spawn, engine team 3
		StartSpot(AIFloat3(  3088, 0,   6144), AiRole::FRONT,  true), // P3  engine spawn, engine team 7
		StartSpot(AIFloat3(  2064, 0,  10240), AiRole::FRONT,  true), // P4  engine spawn, engine team 1
		StartSpot(AIFloat3(  3088, 0,  10240), AiRole::FRONT,  true), // P5  engine spawn, engine team 2
		StartSpot(AIFloat3(  1040, 0,  11264), AiRole::TECH,   true), // P6  engine spawn, engine team 6
		StartSpot(AIFloat3(  3088, 0,  11264), AiRole::FRONT,  true), // P7  engine spawn, engine team 0
		StartSpot(AIFloat3(  5136, 0,  13312), AiRole::FRONT,  true), // P8  engine spawn, engine team 5
		// Team 2
		StartSpot(AIFloat3( 13328, 0,   5120), AiRole::FRONT,  true), // P9  engine spawn, engine team 15
		StartSpot(AIFloat3( 14352, 0,   5120), AiRole::FRONT,  true), // P10 engine spawn, engine team 8
		StartSpot(AIFloat3( 14352, 0,   6144), AiRole::SEA,    true), // P11 engine spawn, engine team 13
		StartSpot(AIFloat3( 13328, 0,   9216), AiRole::FRONT,  true), // P12 engine spawn, engine team 14
		StartSpot(AIFloat3( 14352, 0,   9216), AiRole::FRONT,  true), // P13 engine spawn, engine team 9
		StartSpot(AIFloat3( 15376, 0,   9216), AiRole::AIR,    true), // P14 engine spawn, engine team 11
		StartSpot(AIFloat3( 14352, 0,  10240), AiRole::FRONT,  true), // P15 engine spawn, engine team 10
		StartSpot(AIFloat3( 15376, 0,  10240), AiRole::TECH,   true)  // P16 engine spawn, engine team 12
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("Nine_Metal_Islands", mapUnitLimits, spots, getFactoryWeights());

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
