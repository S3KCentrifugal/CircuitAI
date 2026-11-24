#include "../define.as"
#include "../types/start_spot.as"
#include "../types/map_config.as"

namespace DWorld {
	// NOTE: This map file intentionally holds only static data (start spots & MapConfig).
	// Role determination and factory selection now occur in Main::AiMain using shared helpers.
	//
	// Map: DWorld_V4 (14336 x 14336 elmos, 51% of the ground below sea level, 50% below -30).
	// MapConfig matches "DWorld" as a case-sensitive prefix, so later revisions keep matching.
	// Start positions (2026-11-24): the map has no team start boxes (FFA layout) and an 8v8 headless
	// game stacked each team on one point, so the 16 start positions in the map's own mapinfo.lua
	// are used, split into the west 8 (team 1) and east 8 (team 2), each moved to the middle of
	// its 2-3 nearest mexes when they sit within 450 elmos.
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
		StartSpot(AIFloat3(  3699, 0,   2664), AiRole::FRONT,  false), // P1  lane 1/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  2988, 0,   3464), AiRole::FRONT,  false), // P2  lane 2/8, middle of 2 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  3384, 0,   4491), AiRole::FRONT,  false), // P3  lane 3/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  3344, 0,   6304), AiRole::FRONT,  false), // P4  lane 4/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  4616, 0,   7008), AiRole::FRONT,  false), // P5  lane 5/8, middle of 2 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  4220, 0,  10048), AiRole::FRONT,  false), // P6  lane 7/8, middle of 2 mexes (moved from a lane it shared)
		StartSpot(AIFloat3(  2613, 0,  10701), AiRole::TECH,   false), // P7  lane 8/8 shared (only 7 lanes had a site), middle of 3 mexes
		StartSpot(AIFloat3(  4893, 0,  11443), AiRole::AIR,    false), // P8  lane 8/8, middle of 3 mexes (engine spawn was in this lane)
		// Team 2
		StartSpot(AIFloat3(  9556, 0,   3032), AiRole::FRONT,  false), // P9  lane 8/8, middle of 2 mexes (moved from a lane it shared)
		StartSpot(AIFloat3( 10688, 0,   3168), AiRole::TECH,   false), // P10 lane 7/8 shared (only 7 lanes had a site), middle of 3 mexes
		StartSpot(AIFloat3(  8429, 0,   3525), AiRole::FRONT,  false), // P11 lane 7/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 10621, 0,   4768), AiRole::FRONT,  false), // P12 lane 6/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  8531, 0,   6056), AiRole::FRONT,  false), // P13 lane 5/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  9173, 0,   7944), AiRole::FRONT,  false), // P14 lane 4/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3( 11312, 0,   8256), AiRole::AIR,    false), // P15 lane 3/8, middle of 3 mexes (engine spawn was in this lane)
		StartSpot(AIFloat3(  9888, 0,  10005), AiRole::FRONT,  false)  // P16 lane 2/8, middle of 3 mexes (engine spawn was in this lane)
	};

	// Base per-map unit limits
	dictionary mapUnitLimits; // add per-map unit restrictions here if needed

	MapConfig config = MapConfig("DWorld", mapUnitLimits, spots, getFactoryWeights());

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
