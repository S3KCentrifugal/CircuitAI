#ifndef CIRCUIT_ASSAULT_MICRO_H
#define CIRCUIT_ASSAULT_MICRO_H

#include "AIFloat3.h"
#include <unordered_map>
#include <unordered_set>
#include <vector>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class CCircuitDef;

// Owner 2026-11-08: one shared micro for the hulls whose behaviour has
// "assault_micro" (Mace, Thug, Satyr, Aggravator, Rocketeer, Ballista); see
// unit/AssaultPolicy.h for the rules. The hull keeps its task (attack, defend,
// raid, script waves...), which still decides where it goes; while an enemy is
// within the policy radius, or heavy porc reach is near, this controller owns
// its movement (CCircuitUnit::IsMicroBlocked drops task orders) and lets go
// with a forced task update when the area is clear.
//
// Cost per run (every 15 frames): O(E) enemy snapshot + O(A) allied hull
// snapshot, then O(U * (E_local scan)) with a linear scan of the snapshots,
// U = this AI's hulls in the micro. No engine queries besides positions and
// the weapon reload frame; one MOVE per hull only when its goal changes.
class CAssaultMicro {
public:
    explicit CAssaultMicro(CCircuitAI* circuit);
    void Update();

private:
    enum class Mode : char { NONE, SUPERIOR, EQUAL, DEFICIENT, PORC };
    struct Enemy {
        springai::AIFloat3 pos;
        float cost = 0.f, reach = 0.f, radius = 0.f;
        bool heavy = false;   // heavy porc: never engaged, reach + margin avoided
        bool counts = false;  // in the metal census (finished army / static defence)
        bool target = false;  // may be the nearest-enemy anchor
    };
    struct Friend { springai::AIFloat3 pos; float cost; };
    struct State {
        Mode mode = Mode::NONE;
        bool owned = false, out = false, wasReady = true;
        int outUntil = -1, moveFrame = -100000, holdSince = -1;
        int prevMove = -1;
        springai::AIFloat3 goal{-1.f, 0.f, -1.f};
    };

    void Snapshot(int frame);
    void Release(CCircuitUnit* unit, State& s, int frame);
    bool InPorc(const springai::AIFloat3& p, float margin) const;
    void Issue(CCircuitUnit* unit, State& s, const springai::AIFloat3& goal, int frame, bool urgent);

    CCircuitAI* circuit;
    std::unordered_set<int> heavyDefs;
    bool heavyResolved = false;
    std::vector<Enemy> enemies;
    std::vector<int> heavy;   // indices into enemies
    std::vector<Friend> friends;
    std::unordered_map<int, State> states;
    int lastSummary = 0;
    int cntUnits = 0, cntSup = 0, cntEq = 0, cntDef = 0, cntPorc = 0, cntMoves = 0, cntRelease = 0;
};

} // namespace circuit

#endif // CIRCUIT_ASSAULT_MICRO_H
