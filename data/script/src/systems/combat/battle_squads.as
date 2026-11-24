// Owner 2026-11-24: battle squads (native control/group/BattleSquads.h). Script
// builds a squad (FrontArtySquad, HeavyWave) and hands its members over; the
// native controller ranks, places and orders them (screen front, utility middle,
// artillery back). This file is the script half that stays after the hand-over:
//   MilitaryTask  a member's task is its squad's route, claimed before the native
//                 ranged task (Military::AiMakeTask), so nothing pulls it away
//   Track/Update  each launched squad gets its lane goal once a second from
//                 Military::AiGroundObjective (FRONT lanes, else the best lane,
//                 else the nearest enemy start) read at one of its members
// Templates: behaviour.json "squad_formations"; no template, no battle squad.
#include "../../define.as"
#include "../../unit.as"
#include "../../helpers/common/generic_helpers.as"

namespace BattleSquads {
    array<int> ids;          // launched squads whose goal script keeps
    array<AIFloat3> goals;   // parallel: the last goal sent

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
        aiMilitaryMgr.BattleSquadGoal(squad, first);
    }

    // AiUpdate (every 30 frames): O(tracked squads), one objective query each.
    void Update() {
        for (int i = int(ids.length()) - 1; i >= 0; --i) {
            const int squad = ids[i];
            if (aiMilitaryMgr.BattleSquadSize(squad) < 0) { ids.removeAt(uint(i)); goals.removeAt(uint(i)); continue; }
            CCircuitUnit@ m = ai.GetTeamUnit(aiMilitaryMgr.BattleSquadMember(squad));
            if (m is null) continue;
            const AIFloat3 goal = Military::AiGroundObjective(m, goals[i]);
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

    void Load() {
        ids.resize(0); goals.resize(0);
    }
}
