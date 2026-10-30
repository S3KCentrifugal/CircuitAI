#pragma once
// D-388: the ownership precedence ladder (unit-controller-architecture.md
// section 5). A controller owns its unit except while something higher on the
// ladder holds it; then it pauses and must neither order the unit nor change
// its cloak, fire or move state. Engine-free so the order of the rungs is
// tested (tests/control_core_test.cpp); COwnership fills the flags.

namespace circuit::control {

// Logged as integers: append only.
enum class Suspension : int {
	NONE = 0,
	NO_TASK,        // the unit has no task yet (just created, or being freed)
	PLAYER,         // an allied human ordered it (PlayerTask)
	EXTERNAL,       // Lua or a widget controls it (ExternalControlTask)
	ENEMY_RECLAIM,  // protected enemy-reclaim work
	TRANSPORTED,    // carried by a transport
	MORPHING,
	BEING_BUILT,
	STUNNED,        // paralysed
	DISARMED,
};

struct SuspensionFlags {
	bool noTask = false, player = false, external = false, enemyReclaim = false, transported = false;
	bool morphing = false, beingBuilt = false, stunned = false, disarmed = false;
};

// First matching rung wins; the order is the precedence.
inline Suspension Suspended(const SuspensionFlags& f) {
	if (f.noTask) return Suspension::NO_TASK;
	if (f.player) return Suspension::PLAYER;
	if (f.external) return Suspension::EXTERNAL;
	if (f.enemyReclaim) return Suspension::ENEMY_RECLAIM;
	if (f.transported) return Suspension::TRANSPORTED;
	if (f.morphing) return Suspension::MORPHING;
	if (f.beingBuilt) return Suspension::BEING_BUILT;
	if (f.stunned) return Suspension::STUNNED;
	if (f.disarmed) return Suspension::DISARMED;
	return Suspension::NONE;
}

inline const char* Name(Suspension s) {
	switch (s) {
		case Suspension::NONE:          return "none";
		case Suspension::NO_TASK:       return "no_task";
		case Suspension::PLAYER:        return "player";
		case Suspension::EXTERNAL:      return "external";
		case Suspension::ENEMY_RECLAIM: return "enemy_reclaim";
		case Suspension::TRANSPORTED:   return "transported";
		case Suspension::MORPHING:      return "morphing";
		case Suspension::BEING_BUILT:   return "being_built";
		case Suspension::STUNNED:       return "stunned";
		case Suspension::DISARMED:      return "disarmed";
	}
	return "?";
}

} // namespace circuit::control
