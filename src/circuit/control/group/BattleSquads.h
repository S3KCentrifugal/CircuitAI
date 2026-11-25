#pragma once
// Owner 2026-11-24: battle squads. The battle group's rules (D-430, Cent's
// control/group/BattleGroupController on smrt-test) for squads that script
// builds: the FRONT T2 artillery and bot squads (systems/production/
// front_arty_squad.as) and the T3 heavy wave (systems/production/heavy_wave.as).
// Script keeps what to build and when (rolls, compositions, gather deadlines,
// the lane goal); this controller owns the members once they are out:
//
//   ranks      screen (heavy soak) in front, utility (radar, jammer, flak) in
//              the middle, artillery at the back (kernel/SquadFormation.h)
//   orders     advance down the lane, attack, hold, withdraw, decided from the
//              local metal balance scaled by trade momentum (kernel/TradeMomentum.h)
//              and routed per rank with the battle group's delays and damping
//              (kernel/BattleGroup.h): a withdrawal moves the rear first while the
//              screen covers
//   artillery  each gun stands at its own height-aware reach from the target
//              (CRangedWorld::StandoffRange, util/WeaponReach.h)
//   membership a squad below break_size armed members joins a squad of its
//              template nearby or walks home and is released; two squads out of
//              a fight within merge_radius merge while they fit size_max
//   ghosts     an advance never steps the utility or artillery rows into the
//              reach of an armed ghost structure (as FrontArtySquad did)
//
// Units: one CRouteTask per squad (hold position, per-member routes); the
// member's task is claimed before the native ranged task (Military::AiMakeTask).
// Retreat, player orders and external control keep their owner.
//
// Cost: Update runs every UPDATE_FRAMES; each squad decides once per `period`.
// One decision is O(M log M + K + M x W + G) for M members, K contacts within
// threat_radius (one spatial query), W the StandoffRange steps per artillery
// member (3 at most) and G ghosts within ghost reach; merges are O(S) per squad
// for S squads. No engine query beyond unit positions, health and route orders.
// Templates: behaviour.json "squad_formations" (opt-in: no template, no squad).
#include "control/kernel/BattleGroup.h"
#include "control/kernel/SquadFormation.h"
#include "control/kernel/TradeMomentum.h"
#include "AIFloat3.h"

#include <map>
#include <string>
#include <unordered_map>
#include <vector>

namespace Json { class Value; }

namespace circuit {
class CCircuitAI;
class CCircuitDef;
class CCircuitUnit;
class CMilitaryManager;
class CRouteTask;
class IUnitTask;

struct BattleSquadTemplate {
    std::string name;
    std::vector<int> screen, utility, artillery;  // sorted def ids; unlisted types fall back by role
    // Layout (elmos)
    float utilityAhead = 120.f, screenAhead = 140.f, spacing = 80.f, rowWidth = 480.f, rowDepth = 72.f;
    float rangeFraction = 0.95f, screenRangeFraction = 0.9f, minScreenDistance = 96.f;
    // Engagement
    float threatRadius = 1600.f, engageRadius = 2200.f, staticWeight = 1.5f;
    float advantageEnter = 1.2f, advantageExit = 0.7f;
    // Movement
    float paceStep = 300.f, paceTolerance = 220.f, waitSeconds = 20.f, repath = 64.f, withdrawStep = 500.f;
    // Routing (seconds), as the battle group template
    float withdrawScreenDelay = 2.f, withdrawRearDelay = 0.f, advanceRearDelay = 0.f, attackRearDelay = 0.f;
    float orderMinSeconds = 4.f;
    // Owner 2026-11-25: order hysteresis (kernel/SquadFormation.h Settle)
    float withdrawConfirm = 2.f, withdrawHoldSeconds = 10.f, reenterFactor = 1.25f;
    // Trade momentum
    float momentumPrior = 600.f, momentumHalfLife = 120.f, momentumPress = 0.5f, momentumCaution = 0.5f, momentumFallBack = 0.4f;
    // Membership
    int breakSize = 2, sizeMax = 32;
    float mergeRadius = 1500.f, homeRadius = 1200.f;
    // Ghost porc
    float ghostMargin = 50.f, ghostMaxRange = 1500.f;
    float period = 1.f, log = 1.f;
};

class CBattleSquads {
public:
    CBattleSquads(CCircuitAI* ai, CMilitaryManager* military);

    // Load time: behaviour.json "squad_formations". O(T x U) for T templates, U listed units.
    void ReadConfig(const Json::Value& root);
    bool HasTemplate(const std::string& name) const { return TemplateIndex(name) >= 0; }

    // Script API. A squad holds at `rally` until Launch.
    int Create(const std::string& tmpl, const std::string& label, const springai::AIFloat3& rally);
    bool Add(int squad, CCircuitUnit* unit);
    bool Launch(int squad);
    bool SetGoal(int squad, const springai::AIFloat3& goal);
    bool Release(int squad, const char* why);
    // The squad's route for a member (null when the unit is in no squad). O(1) expected.
    IUnitTask* TaskFor(CCircuitUnit* unit);
    int SquadOf(int unitId) const;
    // Live members, -1 when the squad no longer exists.
    int Size(int squad) const;
    int Armed(int squad) const;
    // A live armed member's id (the screen or artillery first joined), else any member, -1 none:
    // script reads the lane goal from it.
    int AnyMember(int squad) const;
    // The order (battle_group::Order as int), -1 when the squad no longer exists.
    int OrderOf(int squad) const;
    // Owner 2026-11-25: lane choice (script systems/combat/battle_squads.as). The squad's armed
    // metal x health at its last decision (-1: gone); the armed enemy metal x health within
    // `width` of a lane path (seen mobiles x1, seen and ghost structures x staticWeight: the
    // land porc plus the army on it); our other launched squads' value within `width` of it.
    // O(P x K_p) for P path points and K_p contacts near each, deduplicated; O(P x S) for squads.
    float Value(int squad) const;
    float PathEnemy(const std::vector<springai::AIFloat3>& path, float width, float staticWeight);
    float PathFriends(const std::vector<springai::AIFloat3>& path, float width, int exceptSquad) const;

    // Manager hooks.
    void Update();
    void TaskRemoved(IUnitTask* task);
    void UnitDestroyed(CCircuitUnit* unit, int frame);
    void EnemyKilled(int attackerId, float metal, int frame);

    static constexpr int UPDATE_FRAMES = 15;

private:
    using Rank = squad_formation::Rank;
    struct Member {
        int id = -1;
        Rank rank = Rank::SCREEN;
        springai::AIFloat3 sent = springai::AIFloat3(-1.f, 0.f, -1.f);
        int fireFrame = -100000;
        int joined = 0;  // frame it joined (the loss log's field life)
    };
    struct Squad {
        int id = -1, tmpl = -1;
        std::string label;
        std::vector<Member> members;
        CRouteTask* route = nullptr;
        bool launched = false, homeward = false;
        springai::AIFloat3 rally, goal = springai::AIFloat3(-1.f, 0.f, -1.f);
        springai::AIFloat3 anchor = springai::AIFloat3(-1.f, 0.f, -1.f);
        squad_formation::Rows rows;
        ranged::Point forward{1.f, 0.f};
        battle_group::Order order = battle_group::Order::NONE;
        int orderFrame = -1, nextFrame = 0, nextLog = 0, waitSince = -1, target = -1;
        bool ghostHeld = false;
        trade::Ledger trades;
        float momentum = 0.f, own = 0.f, hostile = 0.f;
        int created = 0;
        int withdrawStreak = 0;  // consecutive withdraw wishes (Settle)
    };

    int TemplateIndex(const std::string& name) const;
    Rank RankOf(const BattleSquadTemplate& t, const CCircuitDef* def) const;
    CRouteTask* EnsureRoute(Squad& s);
    void Decide(Squad& s, int frame);
    void Place(Squad& s, const BattleSquadTemplate& t, const springai::AIFloat3* target, int frame);
    float GhostDepth(const springai::AIFloat3& p, float margin, float maxRange) const;
    float StandoffFor(CCircuitUnit* unit, const springai::AIFloat3& target, ranged::Point dir, float fraction);
    bool TryMerge(Squad& s, int frame);
    void MoveMembers(Squad& from, Squad& into, int frame);
    bool Claim(Squad& s, CCircuitUnit* unit);
    void Drop(int squadId, const char* why);

    CCircuitAI* ai;
    CMilitaryManager* military;
    std::vector<BattleSquadTemplate> templates;
    std::map<int, Squad> squads;              // id order: deterministic
    std::unordered_map<int, int> squadOf;     // member id -> squad id
    std::vector<int> nearby;                  // reused contact buffer
    std::vector<int> counted;                 // reused: contact ids already summed by PathEnemy
    std::vector<std::pair<int, std::string>> releases;  // applied after the update loop
    int nextId = 1;
};

} // namespace circuit
