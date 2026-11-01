/*
 * DebugStrike.h
 *
 * Debug strikes (owner 2026-10-31, branch debug-widget-test): the team link
 * widget's debug window aims every nuke silo, or every lolcannon in range, at
 * one map position or at the scouted units of one player (or team), until the
 * same button is pressed again. The widget names a player id; units carry only
 * their team, so CMilitaryManager resolves the player to the team it plays
 * (engine Game::GetPlayerTeam, -1 for a spectator) and the strike runs on that
 * team, remembering the player for the status line. CMilitaryManager owns one Strike per weapon; each
 * CSuperTask compares the serial with the one it last acted on, so a new
 * command reaches every silo and cannon at its next update without a walk over
 * the tasks. Pure state and rules here (tests/debug_strike_test.cpp); the
 * orders are in CSuperTask::UpdateDebug.
 */

#ifndef SRC_CIRCUIT_TASK_STATIC_DEBUGSTRIKE_H_
#define SRC_CIRCUIT_TASK_STATIC_DEBUGSTRIKE_H_

#include <cmath>
#include <cstdio>
#include <string>

namespace circuit {
namespace debug {

// GOAL (owner 2026-11-01): not a weapon - the army's move goal, CDebugGoalTask
enum Weapon: int {NUKE = 0, LOL = 1, GOAL = 2, _WEAPONS_};

inline bool ValidWeapon(int weapon) { return (weapon >= NUKE) && (weapon < _WEAPONS_); }
inline const char* WeaponName(int weapon)
{
	return (weapon == NUKE) ? "nuke" : (weapon == LOL) ? "lol" : (weapon == GOAL) ? "goal" : "?";
}
// DONE: a team strike whose team has no scouted unit left after a launch
enum class Mode: int {OFF = 0, POS = 1, TEAM = 2, DONE = 3};

struct Strike {
	Mode mode = Mode::OFF;
	float x = 0.f, z = 0.f;  // POS: the aim
	int team = -1;           // TEAM: the target team
	int player = -1;         // TEAM by player id: the player the team was resolved from, else -1
	int launches = 0;        // nuke launches since the strike began; GOAL: targets gone while units were sent to them
	int serial = 0;          // bumped by every Set: tasks act on a change at once

	bool Active() const { return (mode == Mode::POS) || (mode == Mode::TEAM); }
};

// A position strike needs a finite point on the map; a team strike a team id
// other than our own. width/height are the map size in elmos.
inline bool ValidPos(float x, float z, float width, float height)
{
	return std::isfinite(x) && std::isfinite(z) && (x >= 0.f) && (z >= 0.f) && (x <= width) && (z <= height);
}

inline bool ValidTeam(int team, int ownTeam)
{
	return (team >= 0) && (team != ownTeam);
}

// Applies a widget command; false (and no change) when it is malformed.
inline bool Set(Strike& s, Mode mode, float x, float z, int team, float width, float height, int ownTeam)
{
	switch (mode) {
		case Mode::POS: if (!ValidPos(x, z, width, height)) return false; break;
		case Mode::TEAM: if (!ValidTeam(team, ownTeam)) return false; break;
		case Mode::OFF: break;
		default: return false;  // DONE is reached, never asked for
	}
	s.mode = mode;
	s.x = (mode == Mode::POS) ? x : 0.f;
	s.z = (mode == Mode::POS) ? z : 0.f;
	s.team = (mode == Mode::TEAM) ? team : -1;
	s.player = -1;
	s.launches = 0;
	++s.serial;
	return true;
}

// A strike on a player's units: playerTeam is the team the engine resolved
// the player to (-1 for an unknown player or a spectator); our own team and a
// negative player id are refused too.
inline bool SetPlayer(Strike& s, int player, int playerTeam, int ownTeam)
{
	if ((player < 0) || !Set(s, Mode::TEAM, 0.f, 0.f, playerTeam, 0.f, 0.f, ownTeam)) return false;
	s.player = player;
	return true;
}

// A team nuke strike ends when the AI knows no unit of the team any more and
// at least one missile went: before the first launch nothing may have been
// scouted yet, and the strike waits for scouting instead of ending.
inline bool TeamDone(const Strike& s, int knownUnits)
{
	return (s.mode == Mode::TEAM) && (knownUnits <= 0) && (s.launches > 0);
}

// The widget's status text: "off", "pos <x> <z> <units> <launches>",
// "team <team> <units> <launches>", "done <team> <launches>"; a strike set by
// player id reads "player <player> <team> <units> <launches>" and ends as
// "done <team> <launches> <player>". units is the number of silos or cannons
// acting on the strike now.
inline std::string Describe(const Strike& s, int units)
{
	char buf[96];
	switch (s.mode) {
		case Mode::POS:  std::snprintf(buf, sizeof(buf), "pos %.0f %.0f %d %d", s.x, s.z, units, s.launches); break;
		case Mode::TEAM:
			if (s.player >= 0) std::snprintf(buf, sizeof(buf), "player %d %d %d %d", s.player, s.team, units, s.launches);
			else std::snprintf(buf, sizeof(buf), "team %d %d %d", s.team, units, s.launches);
			break;
		case Mode::DONE:
			if (s.player >= 0) std::snprintf(buf, sizeof(buf), "done %d %d %d", s.team, s.launches, s.player);
			else std::snprintf(buf, sizeof(buf), "done %d %d", s.team, s.launches);
			break;
		default:         std::snprintf(buf, sizeof(buf), "off"); break;
	}
	return buf;
}

// Goal (owner 2026-11-01): which units the goal takes, by the map's long
// edge. A position goal takes the army within half of it of the point; a
// player (team) goal the units within three quarters of it of that team's
// nearest scouted unit.
inline float GoalReach(Mode mode, float width, float height)
{
	const float edge = (width > height) ? width : height;
	return (mode == Mode::POS) ? 0.5f * edge : (mode == Mode::TEAM) ? 0.75f * edge : 0.f;
}

// The index of the point nearest (x, z) no farther than reach, or -1.
// P has .x and .z; O(points).
template<typename P>
int NearestWithin(float x, float z, const P* points, int count, float reach)
{
	int best = -1;
	float bestSq = reach * reach;
	for (int i = 0; i < count; ++i) {
		const float dx = points[i].x - x, dz = points[i].z - z;
		const float sq = dx * dx + dz * dz;
		if (sq <= bestSq) { bestSq = sq; best = i; }
	}
	return best;
}

} // namespace debug
} // namespace circuit

#endif // SRC_CIRCUIT_TASK_STATIC_DEBUGSTRIKE_H_
