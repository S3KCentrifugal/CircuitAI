// Owner 2026-11-24: battle squads (native control/group/BattleSquads.h). Script
// builds a squad (FrontArtySquad, HeavyWave) and hands its members over; the
// native controller ranks, places and orders them (screen front, utility middle,
// artillery back). This file is the script half that stays after the hand-over:
//   MilitaryTask  a member's task is its squad's route, claimed before the native
//                 ranged task (Military::AiMakeTask), so nothing pulls it away
//   Track/Update  each launched squad gets its lane goal once a second from
//                 Military::AiGroundObjective (FRONT lanes, else the best lane,
//                 else the nearest enemy start) read at one of its members
//   Lanes (owner 2026-11-25) every squad attacks down its own AI's lane; when it is well behind
//                 the enemy metal (land porc + army) on the rest of that lane it moves to the lane
//                 with the best ratio, preferring one our squads already fight on, then comes back
//                 once its own lane is even again. Settings: settings/shared/battle_squads.as.
// Templates: behaviour.json "squad_formations"; no template, no battle squad.
#include "../../define.as"
#include "../../unit.as"
#include "../../helpers/common/generic_helpers.as"

namespace BattleSquads {
    array<int> ids;          // launched squads whose goal script keeps
    array<AIFloat3> goals;   // parallel: the last goal sent
    array<int> lanes;        // parallel: -1 = its own AI's lane (AiGroundObjective), else the D-127 lane it moved to
    array<int> switchedAt;   // parallel: frame of the last lane move
    array<int> nextCheck;    // parallel: frame of the next lane assessment
    const int SAMPLES = 20;

    bool Has(const string &in tmpl) { return aiMilitaryMgr.BattleSquadTemplate(tmpl); }

    // Military MakeTask: the squad's route for a member, else null.
    IUnitTask@ MilitaryTask(CCircuitUnit@ u) {
        if (u is null || aiMilitaryMgr.BattleSquadOf(u.id) < 0) return null;
        return aiMilitaryMgr.BattleSquadTask(u);
    }

    void Track(int squad, const AIFloat3 &in first) {
        if (squad < 0 || ids.find(squad) >= 0) return;
        ids.insertLast(squad);
        goals.insertLast(first);
        lanes.insertLast(-1); switchedAt.insertLast(-1); nextCheck.insertLast(ai.frame + SECOND * (1 + squad % 10));
        aiMilitaryMgr.BattleSquadGoal(squad, first);
    }

    // AiUpdate (every 30 frames): O(tracked squads), one objective query each.
    void Update() {
        for (int i = int(ids.length()) - 1; i >= 0; --i) {
            const int squad = ids[i];
            if (aiMilitaryMgr.BattleSquadSize(squad) < 0) {
                ids.removeAt(uint(i)); goals.removeAt(uint(i)); lanes.removeAt(uint(i));
                switchedAt.removeAt(uint(i)); nextCheck.removeAt(uint(i));
                continue;
            }
            CCircuitUnit@ m = ai.GetTeamUnit(aiMilitaryMgr.BattleSquadMember(squad));
            if (m is null) continue;
            if (Global::BattleSquads::LaneSwitch && ai.frame >= nextCheck[i]) {
                nextCheck[i] = ai.frame + AiMax(1, Global::BattleSquads::LaneCheckSeconds) * SECOND;
                CheckLane(uint(i), m);
            }
            AIFloat3 goal;
            if (lanes[i] >= 0) {
                const AIFloat3 pos = m.GetPos(ai.frame);
                goal = aiBattle.GetLanePoint(lanes[i], float(AiMin(SAMPLES, NearestSample(lanes[i], pos) + 2)) / float(SAMPLES));
            } else goal = Military::AiGroundObjective(m, goals[i]);
            goals[i] = goal;
            aiMilitaryMgr.BattleSquadGoal(squad, goal);
        }
    }

    // The rally `offset` elmos from `from` toward the nearest enemy start (off a factory's exit).
    AIFloat3 RallyFrom(const AIFloat3 &in from, float offset) {
        array<AIFloat3> enemies = Lanes::EnemyStarts();
        float best = -1.0f;
        AIFloat3 goal = from;
        for (uint i = 0; i < enemies.length(); ++i) {
            const float d = from.SqDistance2D(enemies[i]);
            if (best < 0.0f || d < best) { best = d; goal = enemies[i]; }
        }
        if (best <= 0.0f) return from;
        const float len = sqrt(best);
        const float step = AiMin(offset, len * 0.5f);
        return AIFloat3(from.x + (goal.x - from.x) / len * step, from.y, from.z + (goal.z - from.z) / len * step);
    }

    // The lane sample (0..SAMPLES) nearest `pos`. O(SAMPLES).
    int NearestSample(int lane, const AIFloat3 &in pos) {
        int best = 0; float nearest = 1e30f;
        for (int k = 0; k <= SAMPLES; ++k) {
            const float d = pos.SqDistance2D(aiBattle.GetLanePoint(lane, float(k) / float(SAMPLES)));
            if (d < nearest) { nearest = d; best = k; }
        }
        return best;
    }
    // Squads mix bots and vehicles: the vehicle (LAND) lanes when there are any, else the bot lanes.
    int GroundClass() {
        for (int l = 0; l < aiBattle.GetLaneCount(); ++l) if (aiBattle.GetLaneClass(l) == Lanes::LAND) return Lanes::LAND;
        return Lanes::BOT;
    }
    // The ground lane `pos` stands on (nearest sample), -1 none. O(lanes x SAMPLES).
    int LaneAt(const AIFloat3 &in pos) {
        int best = -1; float nearest = 1e30f;
        for (int l = 0; l < aiBattle.GetLaneCount(); ++l) {
            if (aiBattle.GetLaneClass(l) != GroundClass()) continue;
            const float d = pos.SqDistance2D(aiBattle.GetLanePoint(l, float(NearestSample(l, pos)) / float(SAMPLES)));
            if (d < nearest) { nearest = d; best = l; }
        }
        return best;
    }
    array<AIFloat3> Ahead(int lane, int from) {
        array<AIFloat3> path;
        for (int k = AiMax(0, from); k <= SAMPLES; ++k) path.insertLast(aiBattle.GetLanePoint(lane, float(k) / float(SAMPLES)));
        return path;
    }
    // (own + our squads on it) / enemy on the rest of `lane` from the squad's progress; 1e6 with no enemy.
    float Ratio(int squad, int lane, const AIFloat3 &in pos, float own, float &out enemy, float &out friends) {
        const array<AIFloat3> path = Ahead(lane, NearestSample(lane, pos));
        const float width = Global::BattleSquads::LaneWidth;
        enemy = aiMilitaryMgr.BattleSquadPathEnemy(path, width, Global::BattleSquads::LaneStaticWeight);
        friends = aiMilitaryMgr.BattleSquadPathFriends(path, width, squad);
        return enemy <= 0.0f ? 1.0e6f : (own + friends) / enemy;
    }

    // Owner 2026-11-25: stay on the own lane while it is winnable; move to the best other lane when
    // well behind there; come back once the own lane is even again. O(lanes x SAMPLES x contacts near).
    void CheckLane(uint i, CCircuitUnit@ m) {
        const int squad = ids[i];
        const float own = aiMilitaryMgr.BattleSquadValue(squad);
        if (own <= 0.0f || aiBattle.GetLaneCount() == 0) return;
        const AIFloat3 pos = m.GetPos(ai.frame);
        const int home = LaneAt(pos);
        if (home < 0) return;
        float enemy, friends;
        const int current = lanes[i] >= 0 ? lanes[i] : home;
        const float here = Ratio(squad, current, pos, own, enemy, friends);
        const bool held = switchedAt[i] >= 0 && ai.frame - switchedAt[i] < Global::BattleSquads::LaneHoldSeconds * SECOND;
        if (lanes[i] >= 0 && !held) {
            // back to our own lane once it is even again
            float e2, f2;
            const float back = Ratio(squad, home, pos, own, e2, f2);
            if (home != lanes[i] && back >= Global::BattleSquads::LaneSwitchBack) {
                GenericHelpers::LogUtil("[BattleSquads] squad " + squad + " back to its own lane (ratio " + back + ")", 1);
                lanes[i] = -1; switchedAt[i] = ai.frame;
                return;
            }
        }
        if (here >= Global::BattleSquads::LaneSwitchBelow || held) return;
        int best = -1; float bestScore = 0.0f, bestRatio = 0.0f, bestEnemy = 0.0f, bestFriends = 0.0f;
        for (int l = 0; l < aiBattle.GetLaneCount(); ++l) {
            if (l == current || aiBattle.GetLaneClass(l) != GroundClass()) continue;
            float e, f;
            const float r = Ratio(squad, l, pos, own, e, f);
            const float score = r * (f > 0.0f ? Global::BattleSquads::LaneFriendBonus : 1.0f);
            if (best < 0 || score > bestScore) { best = l; bestScore = score; bestRatio = r; bestEnemy = e; bestFriends = f; }
        }
        if (best < 0 || bestRatio < Global::BattleSquads::LaneSwitchMin || bestRatio < here * Global::BattleSquads::LaneSwitchGain) {
            GenericHelpers::LogUtil("[BattleSquads] squad " + squad + " behind on lane " + (current + 1) + " (own " + int(own)
                + " + friends " + int(friends) + " vs enemy " + int(enemy) + "), no better lane", 2);
            return;
        }
        GenericHelpers::LogUtil("[BattleSquads] squad " + squad + " lane " + (current + 1) + " -> " + (best + 1) + ": own " + int(own)
            + " + friends " + int(friends) + " vs enemy " + int(enemy) + " (ratio " + here + "); there friends " + int(bestFriends)
            + " vs enemy " + int(bestEnemy) + " (ratio " + bestRatio + ")", 1);
        lanes[i] = best; switchedAt[i] = ai.frame;
    }

    void Load() {
        ids.resize(0); goals.resize(0); lanes.resize(0); switchedAt.resize(0); nextCheck.resize(0);
    }
}
