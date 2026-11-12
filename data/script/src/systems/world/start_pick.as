// Start-position pick. When start points are placed in game (start boxes), each
// SMRTBARb instance sends the game its own start point: one of the map config's
// StartSpots inside its ally team's start box. Without it the game guesses a point
// in the box and setupMap takes the role of the nearest spot, so two AIs of one
// team could both land nearest an AIR spot (2026-11-11, start box override missing).
//
// Every ally computes the same assignment with no messaging: the candidate spots in
// the box, in the map's StartPickOrder or else role priority (TECH, AIR, SUPPORT,
// SEA, TACTICAL, then FRONT, each in list order), and the ally team's AI teams of
// this AI sorted by team id; the k-th AI takes the k-th spot. An AI beyond the
// spot count sends nothing and the game guesses its point as before.
//
// Needs BAR PR #9749 (game_initial_spawn: AI start points accepted, 2026-10-22).
// A point the gadget rejects (outside the box, untraversable, too close to another
// start) leaves the guess in place; setupMap then derives the role as before.
// Cost: runs once from AiMain; O(spots + ally AIs).
#include "../../define.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../types/start_spot.as"
#include "../../types/map_config.as"

namespace StartPick {
	bool done = false;

	int RolePriority(AiRole r) {
		switch (r) {
			case AiRole::TECH: return 0;
			case AiRole::AIR: return 1;
			case AiRole::SUPPORT: return 2;
			case AiRole::SEA: return 3;
			case AiRole::TACTICAL: return 4;
		}
		return 5;  // FRONT and anything else
	}

	bool InOwnBox(const AIFloat3& in p) {
		const float m = Global::StartPick::BoxMargin;
		return aiSetupMgr.FriendlyStartBoxAt(p) == 1
			&& aiSetupMgr.FriendlyStartBoxAt(AIFloat3(p.x - m, 0, p.z)) == 1
			&& aiSetupMgr.FriendlyStartBoxAt(AIFloat3(p.x + m, 0, p.z)) == 1
			&& aiSetupMgr.FriendlyStartBoxAt(AIFloat3(p.x, 0, p.z - m)) == 1
			&& aiSetupMgr.FriendlyStartBoxAt(AIFloat3(p.x, 0, p.z + m)) == 1;
	}

	void Log(const string& in msg) {
		GenericHelpers::LogUtil("[StartPick] " + msg, 1);
	}

	void Run() {
		if (done) return;
		done = true;
		if (!Global::StartPick::Enabled) return;
		if (!aiSetupMgr.IsChooseInGame()) {
			Log("start points are not chosen in game; nothing to send");
			return;
		}
		MapConfig cfg = Maps::mapManager.getMapConfig(ai.GetMapName());
		const uint n = cfg.StartSpots.length();
		if (n == 0) {
			Log("no StartSpots for '" + ai.GetMapName() + "'; game guesses the start");
			return;
		}
		array<bool> inBox(n, false);
		for (uint i = 0; i < n; ++i) inBox[i] = InOwnBox(cfg.StartSpots[i].pos);

		array<int> cand;
		array<bool> taken(n, false);
		for (uint k = 0; k < cfg.StartPickOrder.length(); ++k) {
			const int idx = cfg.StartPickOrder[k] - 1;
			if (idx < 0 || uint(idx) >= n || taken[idx] || !inBox[idx]) continue;
			taken[idx] = true;
			cand.insertLast(idx);
		}
		for (int prio = 0; prio <= 5; ++prio) {
			for (uint i = 0; i < n; ++i) {
				if (taken[i] || !inBox[i] || RolePriority(cfg.StartSpots[i].aiRole) != prio) continue;
				taken[i] = true;
				cand.insertLast(int(i));
			}
		}

		array<Id>@ teams = aiSetupMgr.GetAllySameAITeams();
		int rank = -1;
		string order = "";
		for (uint i = 0; i < teams.length(); ++i) {
			if (teams[i] == ai.teamId) rank = int(i);
			order += (i > 0 ? "," : "") + teams[i];
		}
		string spotsStr = "";
		for (uint i = 0; i < cand.length(); ++i) spotsStr += (i > 0 ? "," : "") + "P" + (cand[i] + 1);
		Log("map='" + ai.GetMapName() + "' allyTeam=" + ai.allyTeamId + " aiTeams=[" + order
			+ "] rank=" + rank + " spotsInBox=[" + spotsStr + "]");
		if (rank < 0 || uint(rank) >= cand.length()) {
			Log("no spot for this AI (rank " + rank + " of " + cand.length() + " spots); game guesses the start");
			return;
		}
		const int idx = cand[rank];
		StartSpot@ spot = cfg.StartSpots[idx];
		const bool sent = aiSetupMgr.SendStartPos(spot.pos);
		Log("team " + ai.teamId + " takes P" + (idx + 1) + " role=" + int(spot.aiRole)
			+ " at (" + spot.pos.x + "," + spot.pos.z + ") sent=" + sent);
	}
}
