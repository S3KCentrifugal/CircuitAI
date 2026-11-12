// Start-position pick. When start points are placed in game (start boxes), each
// SMRTBARb instance sends the game its own start point: one of the map config's
// StartSpots inside its ally team's start box. Without it the game guesses a point
// in the box and setupMap takes the role of the nearest spot, so two AIs of one
// team could both land nearest an AIR spot (2026-11-11, start box override missing).
//
// Every ally computes the same assignment with no messaging: the candidate spots of
// our side, in the map's StartPickOrder or else role priority (TECH, AIR, SUPPORT,
// SEA, TACTICAL, then FRONT, each in list order), and the ally team's AI teams of
// this AI sorted by team id; the k-th AI takes the k-th spot. An AI beyond the
// spot count sends nothing and the game guesses its point as before.
//
// Our side: the spots inside our box, plus each spot inside no box whose nearest
// boxed spot is ours (one inside an enemy box is theirs). Default boxes
// often leave a spot or two of a side just outside (a 20% strip): such a spot is
// pulled along the line to the nearest in-box spot of the side until it is inside
// (at most MaxPull elmos), and setupMap takes the role of the picked spot, not the
// nearest one, so the pulled point keeps its role.
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
	// The spot this AI sent (setupMap uses it when the game start is the sent point)
	int pickedIdx = -1;
	AIFloat3 pickedPos;

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

	float SqDist2(const AIFloat3& in a, const AIFloat3& in b) {
		return (a.x - b.x) * (a.x - b.x) + (a.z - b.z) * (a.z - b.z);
	}

	// The picked spot when the game start is (near) the point we sent, else null
	StartSpot@ PickedSpot(const AIFloat3& in startPos, StartSpot@[]@ spots) {
		if (pickedIdx < 0 || spots is null || uint(pickedIdx) >= spots.length()) return null;
		if (SqDist2(startPos, pickedPos) > 64.0f * 64.0f) return null;
		return spots[pickedIdx];
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
		array<bool> side(n, false);
		array<AIFloat3> at(n);
		for (uint i = 0; i < n; ++i) { side[i] = inBox[i]; at[i] = cfg.StartSpots[i].pos; }
		// a spot in no box joins the side of the nearest spot that is in a box
		array<int> boxed(n, 0);  // 1 ours, -1 an enemy's, 0 none
		for (uint i = 0; i < n; ++i)
			boxed[i] = inBox[i] ? 1 : ((aiSetupMgr.EnemyStartBoxAt(at[i]) == 1) ? -1 : 0);
		for (uint i = 0; i < n; ++i) {
			if (boxed[i] != 0) continue;
			int near = -1; float best = 1e30f;
			for (uint j = 0; j < n; ++j) {
				if (boxed[j] == 0) continue;
				const float d = SqDist2(at[i], at[j]);
				if (d < best) { best = d; near = int(j); }
			}
			side[i] = (near >= 0) && (boxed[near] == 1);
		}
		// pull our side's out-of-box spots into the box
		for (uint i = 0; i < n; ++i) {
			if (!side[i] || inBox[i]) continue;
			int ref = -1; float best = 1e30f;
			for (uint j = 0; j < n; ++j) {
				if (!side[j] || !inBox[j]) continue;
				const float d = SqDist2(at[i], at[j]);
				if (d < best) { best = d; ref = int(j); }
			}
			if (ref < 0) { side[i] = false; continue; }
			AIFloat3 a = at[i], b = at[ref];  // a outside, b inside
			for (int it = 0; it < 16; ++it) {
				AIFloat3 m((a.x + b.x) * 0.5f, 0, (a.z + b.z) * 0.5f);
				if (InOwnBox(m)) b = m; else a = m;
			}
			const float pull = sqrt(SqDist2(b, cfg.StartSpots[i].pos));
			if (pull > Global::StartPick::MaxPull) {
				Log("P" + (i + 1) + " is " + int(pull) + " elmos outside our box; skipped");
				side[i] = false;
				continue;
			}
			at[i] = b;
			Log("P" + (i + 1) + " pulled " + int(pull) + " elmos into our box");
		}

		array<int> cand;
		array<bool> taken(n, false);
		for (uint k = 0; k < cfg.StartPickOrder.length(); ++k) {
			const int idx = cfg.StartPickOrder[k] - 1;
			if (idx < 0 || uint(idx) >= n || taken[idx] || !side[idx]) continue;
			taken[idx] = true;
			cand.insertLast(idx);
		}
		for (int prio = 0; prio <= 5; ++prio) {
			for (uint i = 0; i < n; ++i) {
				if (taken[i] || !side[i] || RolePriority(cfg.StartSpots[i].aiRole) != prio) continue;
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
		const bool sent = aiSetupMgr.SendStartPos(at[idx]);
		if (sent) { pickedIdx = idx; pickedPos = at[idx]; }
		Log("team " + ai.teamId + " takes P" + (idx + 1) + " role=" + int(spot.aiRole)
			+ " at (" + int(at[idx].x) + "," + int(at[idx].z) + ") sent=" + sent);
	}
}
