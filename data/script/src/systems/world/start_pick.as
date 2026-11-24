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
// Boxes (2026-11-15): the game checks the polygon boxes of the lobby's box override or
// the map's default box set (StartBoxes, start_boxes.as), not the script's startrect
// that FriendlyStartBoxAt reads; they can differ by hundreds of elmos (King's Assault:
// startrect 0.7, real box 0.79). With those polygons known, an out-of-box spot is
// clamped to the nearest point BoxInset inside its box on footing the commander can
// stand on (no slope over FootMaxSlope within FootHalf), slid along the edge to keep
// StartSpacing from the side's other spots (the game rejects a start within 350 of
// another). The old pull toward the nearest in-box spot moved Forge P15 332 elmos up
// the edge onto ground the game rejected; the clamp moves it 70 straight in.
//
// Needs BAR PR #9749 (game_initial_spawn: AI start points accepted, 2026-10-22).
// A point the game does not use (rejected: untraversable, too close to another start;
// or sent after the start countdown ended) leaves the game's guess in place, and
// setupMap still takes the picked spot's role, so an ally team's roles stay distinct.
// Cost: runs once from AiMain; O(spots + ally AIs).
#include "../../define.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../types/start_spot.as"
#include "../../types/map_config.as"
#include "start_boxes.as"

namespace StartPick {
	bool done = false;
	// The spot this AI sent (setupMap uses it when the game start is the sent point)
	int pickedIdx = -1;
	AIFloat3 pickedPos;
	// This AI took a generated extra spot (more AIs than configured spots); its role is FRONT
	bool pickedExtra = false;

	// Extra start spots for ally teams larger than the map config (11v11, 12v12; owner 2026-11-24).
	// Lanes across the attack axis (our box centre to the nearest enemy box centre), one per AI
	// of the team, each holding an equal share of the map's mex spots. Every lane no configured
	// spot of ours occupies gets the richest 2-3 mex cluster inside our box in that lane; when
	// lanes run out, the richest cluster anywhere in the box. Each extra keeps ExtraSpacing from
	// every spot already taken. Deterministic: every ally computes the same list.
	// Cost: once per AI at start; O(M^2) over the map's M mex spots (M is a few hundred).
	array<AIFloat3>@ ExtraSpots(const array<AIFloat3>& in taken, uint want, uint lanes) {
		array<AIFloat3> out;
		const int M = ai.GetMetalSpotCount();
		if (M <= 0 || want == 0 || lanes == 0 || !HasOwnPoly()) return out;
		// attack axis
		float ox = 0, oz = 0, ex = 0, ez = 0;
		const array<AIFloat3>@ own = StartBoxes::boxes[ai.allyTeamId];
		for (uint i = 0; i < own.length(); ++i) { ox += own[i].x; oz += own[i].z; }
		ox /= float(own.length()); oz /= float(own.length());
		float best = 1e30f;
		for (uint k = 0; k < StartBoxes::boxes.length(); ++k) {
			if (int(k) == ai.allyTeamId || StartBoxes::boxes[k].length() == 0) continue;
			float cx = 0, cz = 0;
			for (uint i = 0; i < StartBoxes::boxes[k].length(); ++i) { cx += StartBoxes::boxes[k][i].x; cz += StartBoxes::boxes[k][i].z; }
			cx /= float(StartBoxes::boxes[k].length()); cz /= float(StartBoxes::boxes[k].length());
			const float d = (cx - ox) * (cx - ox) + (cz - oz) * (cz - oz);
			if (d < best) { best = d; ex = cx; ez = cz; }
		}
		float ux = ex - ox, uz = ez - oz;
		const float ul = sqrt(ux * ux + uz * uz);
		if (ul < 1.0f) return out;
		const float vx = -uz / ul, vz = ux / ul;  // across the attack axis
		// lane cuts: equal mex counts by projection on v
		array<float> pv(M);
		array<AIFloat3> mex(M);
		for (int i = 0; i < M; ++i) { mex[i] = ai.GetMetalSpot(i); pv[i] = mex[i].x * vx + mex[i].z * vz; }
		array<float> sorted = pv;
		sorted.sortAsc();
		array<float> cuts;
		for (uint k = 1; k < lanes; ++k) cuts.insertLast(sorted[(uint(M) * k) / lanes]);
		// clusters: each in-box mex with its (up to) 2 nearest neighbours within ClusterRadius
		const float r2 = Global::StartPick::ClusterRadius * Global::StartPick::ClusterRadius;
		array<AIFloat3> cpos; array<int> ccount; array<uint> clane;
		for (int i = 0; i < M; ++i) {
			if (!InOwnBox(mex[i])) continue;
			float d1 = 1e30f, d2 = 1e30f; int n1 = -1, n2 = -1;
			for (int j = 0; j < M; ++j) {
				if (j == i) continue;
				const float d = SqDist2(mex[i], mex[j]);
				if (d >= r2) continue;
				if (d < d1) { d2 = d1; n2 = n1; d1 = d; n1 = j; } else if (d < d2) { d2 = d; n2 = j; }
			}
			float sx = mex[i].x, sz = mex[i].z; int c = 1;
			if (n1 >= 0) { sx += mex[n1].x; sz += mex[n1].z; ++c; }
			if (n2 >= 0) { sx += mex[n2].x; sz += mex[n2].z; ++c; }
			AIFloat3 p(sx / float(c), 0, sz / float(c));
			if (!InOwnBox(p)) continue;
			if (aiTerrainMgr.FlatFraction(p, 0, Global::StartPick::FootHalf, Global::StartPick::FootHalf, Global::StartPick::FootMaxSlope) < 1.0f) continue;
			uint ln = 0;
			const float q = p.x * vx + p.z * vz;
			while (ln < cuts.length() && q >= cuts[ln]) ++ln;
			cpos.insertLast(p); ccount.insertLast(c); clane.insertLast(ln);
		}
		array<AIFloat3> all = taken;
		array<bool> laneUsed(lanes, false);
		for (uint i = 0; i < taken.length(); ++i) {
			uint ln = 0;
			const float q = taken[i].x * vx + taken[i].z * vz;
			while (ln < cuts.length() && q >= cuts[ln]) ++ln;
			laneUsed[ln] = true;
		}
		const float sp2 = Global::StartPick::ExtraSpacing * Global::StartPick::ExtraSpacing;
		for (int pass = 0; pass < 2 && out.length() < want; ++pass) {
			for (uint ln = 0; ln < lanes && out.length() < want; ++ln) {
				if (pass == 0 && laneUsed[ln]) continue;
				int pick = -1;
				for (uint c = 0; c < cpos.length(); ++c) {
					if (pass == 0 && clane[c] != ln) continue;
					bool crowded = false;
					for (uint o = 0; o < all.length() && !crowded; ++o) crowded = SqDist2(cpos[c], all[o]) < sp2;
					if (crowded) continue;
					// most mexes; ties to the front of the box (toward the enemy)
					if (pick < 0 || ccount[c] > ccount[pick]
						|| (ccount[c] == ccount[pick] && cpos[c].x * ux + cpos[c].z * uz > cpos[pick].x * ux + cpos[pick].z * uz)) pick = int(c);
				}
				if (pick < 0) continue;
				if (pass == 0) laneUsed[ln] = true;
				out.insertLast(cpos[pick]);
				all.insertLast(cpos[pick]);
			}
		}
		Log("extra spots: " + out.length() + " of " + want + " wanted (" + lanes + " lanes, " + cpos.length() + " in-box clusters)");
		return out;
	}

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

	bool InPolyM(const array<AIFloat3>& in poly, const AIFloat3& in p) {
		return InPolyD(poly, p, Global::StartPick::BoxMargin);
	}

	// p and the 4 points m elmos away along the axes are inside poly
	bool InPolyD(const array<AIFloat3>& in poly, const AIFloat3& in p, float m) {
		return StartBoxes::InPoly(poly, p.x, p.z)
			&& StartBoxes::InPoly(poly, p.x - m, p.z) && StartBoxes::InPoly(poly, p.x + m, p.z)
			&& StartBoxes::InPoly(poly, p.x, p.z - m) && StartBoxes::InPoly(poly, p.x, p.z + m);
	}

	bool HasOwnPoly() {
		return StartBoxes::loaded && ai.allyTeamId >= 0 && uint(ai.allyTeamId) < StartBoxes::boxes.length();
	}

	bool InEnemyBox(const AIFloat3& in p) {
		if (!HasOwnPoly()) return aiSetupMgr.EnemyStartBoxAt(p) == 1;
		for (uint k = 0; k < StartBoxes::boxes.length(); ++k)
			if (int(k) != ai.allyTeamId && StartBoxes::InPoly(StartBoxes::boxes[k], p.x, p.z)) return true;
		return false;
	}

	// Nearest point inset elmos inside our polygon, StartSpacing from every point in others;
	// false when none (box too thin, or every edge point crowded).
	bool Clamp(const AIFloat3& in p, const array<AIFloat3>& in others, float inset, AIFloat3& out res) {
		const array<AIFloat3>@ poly = StartBoxes::boxes[ai.allyTeamId];
		const uint n = poly.length();
		const float sp2 = Global::StartPick::StartSpacing * Global::StartPick::StartSpacing;
		float cx = 0, cz = 0;
		for (uint i = 0; i < n; ++i) { cx += poly[i].x; cz += poly[i].z; }
		cx /= float(n); cz /= float(n);
		array<AIFloat3> cands;
		for (uint i = 0; i < n; ++i) {
			const AIFloat3 a = poly[i], b = poly[(i + 1) % n];
			const float dx = b.x - a.x, dz = b.z - a.z;
			const float L = sqrt(dx * dx + dz * dz);
			if (L < 1.0f) continue;
			const float ux = dx / L, uz = dz / L;
			float nx = -uz, nz = ux;
			if (!StartBoxes::InPoly(poly, (a.x + b.x) * 0.5f + nx * 2.0f, (a.z + b.z) * 0.5f + nz * 2.0f)) { nx = -nx; nz = -nz; }
			float t = (p.x - a.x) * ux + (p.z - a.z) * uz;
			t = (t < 0.0f) ? 0.0f : ((t > L) ? L : t);
			for (int k = 0; k <= 64; ++k) {
				// slide 0, +64, -64, +128, -128, ... along the edge
				const float slide = (k == 0) ? 0.0f : float((k + 1) / 2) * 64.0f * ((k % 2 == 1) ? 1.0f : -1.0f);
				const float tt = t + slide;
				if (tt < 0.0f || tt > L) continue;
				cands.insertLast(AIFloat3(a.x + ux * tt + nx * inset, 0, a.z + uz * tt + nz * inset));
			}
		}
		for (int k = 1; k <= 64; ++k) {  // corner / thin box: walk toward the centroid
			const float f = float(k) / 64.0f;
			cands.insertLast(AIFloat3(p.x + (cx - p.x) * f, 0, p.z + (cz - p.z) * f));
		}
		float best = 1e30f;
		bool found = false;
		for (uint c = 0; c < cands.length(); ++c) {
			const AIFloat3 q = cands[c];
			if (!InPolyD(poly, q, (inset * 0.75f > Global::StartPick::BoxMargin) ? inset * 0.75f : Global::StartPick::BoxMargin)) continue;
			// footing: the game drops a start the commander cannot stand on (TestMoveOrder)
			if (aiTerrainMgr.FlatFraction(q, 0, Global::StartPick::FootHalf, Global::StartPick::FootHalf, Global::StartPick::FootMaxSlope) < 1.0f) continue;
			bool crowded = false;
			for (uint o = 0; o < others.length() && !crowded; ++o) crowded = SqDist2(q, others[o]) < sp2;
			if (crowded) continue;
			const float d = SqDist2(q, p);
			if (d < best) { best = d; res = q; found = true; }
		}
		return found;
	}

	bool InOwnBox(const AIFloat3& in p) {
		if (HasOwnPoly()) return InPolyM(StartBoxes::boxes[ai.allyTeamId], p);
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

	// The spot this AI picked, or null. setupMap takes its role even when the game
	// did not use the point (sent after the start countdown, or rejected: footing,
	// too close to another start): the picks of an ally team are distinct, so the
	// roles stay distinct (one AIR per team) wherever the game put the commander.
	StartSpot@ PickedSpot(const AIFloat3& in startPos, StartSpot@[]@ spots) {
		if (pickedExtra) {
			Log("start (" + int(startPos.x) + "," + int(startPos.z) + ") is " + int(sqrt(SqDist2(startPos, pickedPos)))
				+ " elmos from the extra spot sent; role FRONT");
			StartSpot@ extraSpot = StartSpot(pickedPos, AiRole::FRONT, false);
			return extraSpot;
		}
		if (pickedIdx < 0 || spots is null || uint(pickedIdx) >= spots.length()) return null;
		Log("start (" + int(startPos.x) + "," + int(startPos.z) + ") is " + int(sqrt(SqDist2(startPos, pickedPos)))
			+ " elmos from the point sent for P" + (pickedIdx + 1));
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
		// the game's polygons (override, else the map's default set); 2 ally teams in our lobbies
		StartBoxes::Load((ai.allyTeamId >= 2) ? ai.allyTeamId + 1 : 2);
		if (HasOwnPoly()) {
			const array<AIFloat3>@ own = StartBoxes::boxes[ai.allyTeamId];
			string pts = "";
			for (uint i = 0; i < own.length(); ++i) pts += (i > 0 ? " " : "") + "(" + int(own[i].x) + "," + int(own[i].z) + ")";
			Log("box from " + StartBoxes::source + ": " + StartBoxes::boxes.length() + " boxes, ours " + pts);
		} else {
			Log("no polygon box modoption for allyTeam " + ai.allyTeamId + "; using the script startrect");
		}
		array<bool> inBox(n, false);
		for (uint i = 0; i < n; ++i) inBox[i] = InOwnBox(cfg.StartSpots[i].pos);
		array<bool> side(n, false);
		array<AIFloat3> at(n);
		for (uint i = 0; i < n; ++i) { side[i] = inBox[i]; at[i] = cfg.StartSpots[i].pos; }
		// a spot in no box joins the side of the nearest spot that is in a box
		array<int> boxed(n, 0);  // 1 ours, -1 an enemy's, 0 none
		for (uint i = 0; i < n; ++i)
			boxed[i] = inBox[i] ? 1 : (InEnemyBox(at[i]) ? -1 : 0);
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
		array<AIFloat3> placed;
		array<AIFloat3> backup(n);
		array<bool> hasBackup(n, false);  // our side's points so far (clamp keeps StartSpacing from them)
		for (uint i = 0; i < n; ++i) if (side[i] && inBox[i]) placed.insertLast(at[i]);
		for (uint i = 0; i < n; ++i) {
			if (!side[i] || inBox[i]) continue;
			if (HasOwnPoly()) {
				AIFloat3 q;
				const bool ok = Clamp(cfg.StartSpots[i].pos, placed, Global::StartPick::BoxInset, q);
				const float pull = ok ? sqrt(SqDist2(q, cfg.StartSpots[i].pos)) : -1.0f;
				if (!ok || pull > Global::StartPick::MaxPull) {
					Log("P" + (i + 1) + " cannot be clamped into our box" + (ok ? " within " + int(Global::StartPick::MaxPull) + " (" + int(pull) + ")" : "") + "; skipped");
					side[i] = false;
					continue;
				}
				// a backup point deeper in, sent first: the game keeps it if it rejects the
				// clamp point (a blocking feature: rocks there are invisible to the script)
				AIFloat3 q2;
				if (Clamp(cfg.StartSpots[i].pos, placed, Global::StartPick::BackupInset, q2)) { backup[i] = q2; hasBackup[i] = true; }
				at[i] = q;
				placed.insertLast(q);
				Log("P" + (i + 1) + " clamped " + int(pull) + " elmos into our box at (" + int(q.x) + "," + int(q.z) + "), flat "
					+ int(100.0f * aiTerrainMgr.FlatFraction(q, 0, 64.0f, 64.0f, Global::StartPick::FootMaxSlope)) + "% of 128x128");
				continue;
			}
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
		if (rank >= 0 && uint(rank) >= cand.length() && Global::StartPick::ExtraSpots) {
			// More AIs on this ally team than the map config has spots for it (11v11, 12v12):
			// every ally builds the same extra list from the same data, the k-th AI beyond the
			// configured spots takes the k-th extra spot.
			array<AIFloat3> taken2;
			for (uint i = 0; i < cand.length(); ++i) taken2.insertLast(at[cand[i]]);
			array<AIFloat3>@ extra = ExtraSpots(taken2, teams.length() - cand.length(), teams.length());
			const uint k = uint(rank) - cand.length();
			if (k < extra.length()) {
				const bool sent = aiSetupMgr.SendStartPos(extra[k]);
				if (sent) { pickedIdx = -1; pickedExtra = true; pickedPos = extra[k]; }
				Log("team " + ai.teamId + " takes extra spot E" + (k + 1) + " of " + extra.length() + " (FRONT) at ("
					+ int(extra[k].x) + "," + int(extra[k].z) + ") sent=" + sent);
				return;
			}
		}
		if (rank < 0 || uint(rank) >= cand.length()) {
			Log("no spot for this AI (rank " + rank + " of " + cand.length() + " spots); game guesses the start");
			return;
		}
		const int idx = cand[rank];
		StartSpot@ spot = cfg.StartSpots[idx];
		if (hasBackup[idx]) {
			aiSetupMgr.SendStartPos(backup[idx]);
			Log("backup point for P" + (idx + 1) + " sent first at (" + int(backup[idx].x) + "," + int(backup[idx].z) + ")");
		}
		const bool sent = aiSetupMgr.SendStartPos(at[idx]);
		if (sent) { pickedIdx = idx; pickedPos = at[idx]; }
		Log("team " + ai.teamId + " takes P" + (idx + 1) + " role=" + int(spot.aiRole)
			+ " at (" + int(at[idx].x) + "," + int(at[idx].z) + ") sent=" + sent);
	}
}
