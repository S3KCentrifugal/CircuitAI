#pragma once
// D-430: the battle group controller, the first group controller
// (control/core/GroupController.h). A battle group is a screen cohort of the ranged
// controller's units (Thugs, Maces) with the rear cohort paired behind it
// (Aggravators, Rocketeers) through the existing `t1_bot_group` family. The
// cohort world still forms and merges the cohorts (behaviour parity with the
// attribute path); this controller rides them and adds what the cohorts never
// had: one mind per battle group. It reads the enemy composition near the battle group, turns
// the battle group to the threat axis and opens its spacing to the enemy's splash, and
// routes every order (its own, from the cohort's assessment, or the script's)
// to the two slot kinds with the template's delays, so a withdrawal reaches
// the rear first and the screen covers until its delay elapses. Members read
// the resulting directive inside CRangedEngagement::UpdateCohort; a member's
// hard-hazard escape always wins over the battle group's timing.
//
// Cost: once per `period` frames, O(L x (M + K)) for L battle groups, M members and K
// contacts within `threat_radius` from the shared per-frame snapshot; no
// engine query, no orders. Directives are written in place (one small map),
// read by members in O(1). Phase: performance::BATTLE_GROUP_DECISION.
#include "control/core/ConfigTable.h"
#include "control/core/GroupController.h"
#include "control/kernel/ActionWhy.h"
#include "control/kernel/AirDefence.h"
#include "control/kernel/TradeMomentum.h"
#include "control/kernel/BattleGroup.h"
#include "control/group/GroupRegistry.h"

#include <map>
#include <string>
#include <unordered_map>
#include <vector>

namespace circuit {
class CCircuitAI;
class CRangedWorld;

struct BattleGroupConfig {
    // Routing: seconds; a negative rear delay means "until the separation opens".
    float withdrawScreenDelay = 1.f, withdrawRearDelay = 0.f, withdrawScreenCover = 1.f;
    float advanceScreenDelay = 0.f, advanceRearDelay = -1.f;
    float attackScreenDelay = 0.f, attackRearDelay = 0.f;
    float holdDelay = 0.f;
    float orderMinSeconds = 3.f;      // a less cautious order waits this long (cohort modes flicker faster)
    float scriptOrderSeconds = 20.f;  // a script order's lifetime
    // Orientation and spacing from the enemy composition.
    float orient = 1.f, headingDeadband = 20.f, threatRadius = 1400.f, peerBand = .25f;
    float standShortShare = .6f;      // stand and shoot when short-range hostiles hold this metal share (0: never)
    float spreadEnabled = 1.f, spreadCap = 2.f;
    float period = 15.f, log = 1.f;
    // D-501 (control/group/GroupRegistry.h): group size and cohesion. size_target 0
    // leaves the registry off for the template (the D-430 cohorts unchanged).
    float sizeMin = 1.f, sizeTarget = 0.f, sizeMax = 24.f;
    float joinSeekRadius = 0.f, recruitSeconds = 2.f;
    float strayRadius = 0.f, straySeconds = 6.f, splitLink = 0.f;
    // D-504: recall a fighting group below this size to the main group (0: off),
    // except within home_radius of the base.
    float recallSize = 0.f, homeRadius = 0.f;
    // D-509 (control/kernel/AirDefence.h): with an "air" rank, armed enemy air
    // within air_radius of the screen asks for escorts that kill it within
    // air_kill_seconds, held air_memory_seconds; escorts stand escort_behind
    // elmos behind the screen's rear edge, escort_spacing apart.
    float airRadius = 1600.f, airKillSeconds = 10.f, airMemorySeconds = 20.f;
    float escortBehind = 100.f, escortSpacing = 64.f;
    // D-512 (control/kernel/TradeMomentum.h): the trade ledger's prior (metal
    // a sign needs) and half-life (seconds).
    float momentumPrior = 300.f, momentumHalfLife = 120.f;
};

class CBattleGroupController final : public IGroupController {
public:
    explicit CBattleGroupController(CCircuitAI* ai);

    const char* Name() const override { return "battle_group"; }
    int ParseTemplate(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) override;
    int TemplateIndex(const std::string& name) const override;
    bool SetTemplateOption(const std::string& name, const std::string& key, float value) override;
    void Update() override;
    void UnitRemoved(int unitId) override;
    bool Order(const std::string& name, const std::string& kind, const springai::AIFloat3& pos) override;

    // The member side: O(1); null when the unit is in no battle group.
    const battle_group::Directive* DirectiveFor(int unitId) const {
        const auto it = directives.find(unitId);
        return it == directives.end() ? nullptr : &it->second;
    }
    int Groups() const { return int(groups.size()); }
    std::string Describe(int groupKey) const;

    // D-509: anti-air escorts (control/unit/escort/EscortController.h). An
    // escort joins on its lease and leaves on its end or death; the group it
    // rides with and its slot are decided here each update. O(log E) each.
    void EscortJoin(int unitId);
    void EscortLeave(int unitId);
    bool EscortPoint(int unitId, springai::AIFloat3& point, int& group) const;
    // The escort type a factory of `factoryDef` should start now, or null:
    // the shortfall no assigned, spare, queued or building escort covers
    // (air_defence::Request). O(R + Q) for R rank types and Q factory tasks.
    CCircuitDef* AirRequest(const CCircuitDef* factoryDef) const;
    // D-512: a kill by a member (the engine's enemy-destroyed attacker) and the
    // loss of a member, booked to its group's trade ledger. O(1) expected.
    void RecordKill(int attackerId, float metal, int frame);
    void RecordLoss(int unitId, float metal, int frame);
    // A group with an air rank exists: an escort has somewhere to go. O(G).
    bool HasAirGroups() const;

    // The unit monitor's read-only view of one battle group (control/group/GroupMonitor.h).
    // Copied on request only, O(L); nothing here runs per frame.
    struct GroupView {
        int key = -1, partner = -1;
        std::string templateName;
        battle_group::Order effective = battle_group::Order::NONE, script = battle_group::Order::NONE, internal = battle_group::Order::NONE;
        battle_group::Stance screenStance = battle_group::Stance::FOLLOW, rearStance = battle_group::Stance::FOLLOW;
        float spread = 1.f, separation = 0.f;
        ranged::Point facing{0.f, 0.f};
        bool facingSet = false, scripted = false, standFirm = false;
        int screens = 0, rears = 0, orderFrame = -1, seen = -1;
        int sizeTarget = 0, sizeMax = 0;  // D-501: the screen rank's target and maximum (0: registry off)
        battle_group::Composition composition;
        why::Set why = 0;                 // D-508: the order's factors (why::group bits)
        int airNeed = 0, airCap = 0, escorts = 0;  // D-509: escorts needed, the most it takes, assigned
        float airHeld = 0.f;                       // D-509: the air HP it plans for
        std::vector<int> escortIds;                // D-509: its escorts, id order
        float momentum = 0.f, killed = 0.f, lost = 0.f;  // D-512: the trade ledger, decayed to the last update
    };
    std::vector<GroupView> Snapshot() const;

private:
    struct Template {
        std::string name; BattleGroupConfig config;
        std::vector<group_composition::RankSpec> ranks;  // D-501: the template's "ranks"
        GroupSpec spec;                                  // D-501: refreshed from config each update
    };
    struct Group {
        int key = -1, tmpl = -1, partner = -1;
        battle_group::Order internal = battle_group::Order::NONE, script = battle_group::Order::NONE, effective = battle_group::Order::NONE;
        int orderFrame = -1, scriptFrame = -1, seen = -1;
        springai::AIFloat3 scriptGoal;
        battle_group::Composition composition;
        ranged::Point facing{0.f, 0.f};
        bool facingSet = false;
        float spread = 1.f, separation = 0.f, screenSpeed = 1.f;
        bool scripted = false, standFirm = false;
        int screens = 0, rears = 0;
        battle_group::Stance screenStance = battle_group::Stance::FOLLOW, rearStance = battle_group::Stance::FOLLOW;
        why::Set why = 0;  // D-508: the order's factors (why::group bits), set by Observe and Route
        // D-509: the air near it and the escort geometry (centre, axis away
        // from the enemy, the screen's rear edge along it), set by Observe.
        air_defence::Memory airMemory;
        float airHeld = 0.f, rearDepth = 0.f;
        int airNeed = 0, airCap = 0, escorts = 0;
        ranged::Point escortCenter{0.f, 0.f}, escortBack{1.f, 0.f};
        int escortIndex = 0;  // the next slot index while slots are laid out (AssignEscorts)
        trade::Ledger trades;  // D-512: metal killed and lost, decaying
        float momentum = 0.f;  // D-512: from `trades`, set by Observe
    };
    Group* GroupOf(int unitId);  // D-512: the group a member or escort is in, or null
    struct Escort { int group = -1; ranged::Point slot{0.f, 0.f}; };
    void ObserveAir(Group& l, const Template& t, CRangedWorld& world, const springai::AIFloat3& center, int frame);
    void AssignEscorts(int frame);
    float EscortDps(const Template& t) const;
    void Observe(Group& l, CRangedWorld& world, int frame);
    void Route(Group& l, const Template& t, int frame);
    void Write(const Group& l, const std::vector<int>& members, battle_group::Slot slot, battle_group::Stance stance);
    void ParseRanks(Template& t, const Json::Value& ranks, std::vector<std::string>& problems) const;
    void PushClasses(CRangedWorld& world);
    const GroupSpec* SpecFor(const CCircuitDef* def) const;

    CCircuitAI* ai;
    std::vector<Template> templates;
    std::map<int, Group> groups;                        // front cohort key -> battle group
    std::unordered_map<int, battle_group::Directive> directives;  // member id -> directive
    std::vector<int> nearby;                            // reused contact buffer
    int generation = 0, nextFrame = 0;
    bool trace = false;
    CGroupRegistry registry;   // D-501: membership decisions
    std::map<int, Escort> escorts;    // D-509: escort unit id -> its group and slot (id order: deterministic)
    std::vector<int> airNearby;       // D-509: reused contact buffer
    int airDeficit = 0, airUnassigned = 0;  // D-509: from the last update, for AirRequest
    bool classesDirty = true;  // D-501: ranks changed since the world last got the cohort classes
};

} // namespace circuit
