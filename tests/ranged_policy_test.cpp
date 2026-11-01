// D-430: the shared ranged policy parser (unit/RangedPolicyParse.cpp). The
// attribute block and the controller preset go through one function, so the
// test proves (1) the preset form of the balanced Thug and Aggravator blocks
// parses to the same policy as the attribute form, (2) the legacy rules hold:
// an out-of-range or mistyped value rejects the block, a formation needs
// coordinated, sustained rush needs its prerequisites, unknown keys are only
// reported, (3) a lever name in the numeric table has the parser's range.
#include "unit/RangedPolicyParse.h"

#include <cassert>
#include <cstdio>
#include <memory>
#include <string>
#include <vector>

using namespace circuit;

namespace {
Json::Value Parse(const std::string& text) {
    Json::Value v;
    Json::CharReaderBuilder builder;
    std::string errors;
    std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
    const bool ok = reader->parse(text.data(), text.data() + text.size(), &v, &errors);
    assert(ok);
    return v;
}
const ranged_policy::Resolver kResolver{
    [](const std::string& name) { return name == "armpw" ? 7 : -1; },
    [](const std::string& names) { return names == "GROUNDSCOUT" ? 64 : 0; }};

bool Same(const RangedPolicy& a, const RangedPolicy& b) {
    return a.formationFamily == b.formationFamily && a.formationPosition == b.formationPosition
        && a.formationSeparationMinimum == b.formationSeparationMinimum && a.formationSeparationMaximum == b.formationSeparationMaximum
        && a.withdrawalLeadSeconds == b.withdrawalLeadSeconds && a.mode == b.mode && a.rangeFraction == b.rangeFraction
        && a.spacing == b.spacing && a.safetyMargin == b.safetyMargin && a.hysteresis == b.hysteresis
        && a.reactionSeconds == b.reactionSeconds && a.targetHysteresis == b.targetHysteresis && a.moveMinSeconds == b.moveMinSeconds
        && a.targetMinSeconds == b.targetMinSeconds && a.targetSwitchRatio == b.targetSwitchRatio && a.sensorOffset == b.sensorOffset
        && a.cloakReserve == b.cloakReserve && a.repairedTargetPenalty == b.repairedTargetPenalty && a.splashWeight == b.splashWeight
        && a.cloakOnReload == b.cloakOnReload && a.allowMobile == b.allowMobile && a.allowStatic == b.allowStatic
        && a.preferHeavy == b.preferHeavy && a.commanderPriority == b.commanderPriority && a.preferScreen == b.preferScreen
        && a.allowRadar == b.allowRadar && a.advanceUnknownRadar == b.advanceUnknownRadar && a.lowTrajectory == b.lowTrajectory
        && a.holdFireline == b.holdFireline && a.stageWhenBlocked == b.stageWhenBlocked && a.coordinated == b.coordinated
        && a.cohortSize == b.cohortSize && a.cohortRadius == b.cohortRadius && a.regroupSeconds == b.regroupSeconds
        && a.rushRatio == b.rushRatio && a.catchSeconds == b.catchSeconds && a.engagementSeconds == b.engagementSeconds
        && a.sustainedRush == b.sustainedRush && a.sustainedRushRatio == b.sustainedRushRatio && a.sustainedRushRadius == b.sustainedRushRadius
        && a.sustainedRushMinFront == b.sustainedRushMinFront && a.sustainedRushRemaining == b.sustainedRushRemaining
        && a.sustainedRushCooldown == b.sustainedRushCooldown && a.sustainedRushRange == b.sustainedRushRange
        && a.advantageEnter == b.advantageEnter && a.advantageExit == b.advantageExit && a.lossFraction == b.lossFraction
        && a.staticLossFraction == b.staticLossFraction && a.supportAllies == b.supportAllies && a.supportLossFraction == b.supportLossFraction
        && a.intentGain == b.intentGain && a.avoidCategory == b.avoidCategory && a.evasionLimit == b.evasionLimit
        && a.pokeIn == b.pokeIn && a.pokeInDominant == b.pokeInDominant && a.pokeOut == b.pokeOut && a.pokeRatio == b.pokeRatio
        && a.pokeHealth == b.pokeHealth && a.pokePressHealth == b.pokePressHealth && a.pokePauseSeconds == b.pokePauseSeconds
        && a.fireAtWill == b.fireAtWill && a.fireInRange == b.fireInRange && a.commanderFocus == b.commanderFocus
        && a.spamMaxCost == b.spamMaxCost && a.spamDefs == b.spamDefs && a.pressStatic == b.pressStatic
        && a.assistRadius == b.assistRadius && a.assistMargin == b.assistMargin && a.assistScreen == b.assistScreen;
}

// The balanced profile's Thug block (2026-11-01) in both forms.
const char* kThugAttribute = R"({"fire_in_range": true, "commander_focus": true, "coordinated": true,
    "sustained_rush": true, "sustained_rush_ratio": 2.0, "sustained_rush_radius": 900.0, "sustained_rush_min_front": 8,
    "sustained_rush_remaining": 0.25, "sustained_rush_cooldown": 20.0, "sustained_rush_range": 0.8,
    "formation": {"family": "t1_cortex_line", "position": "front"}, "range_fraction": 0.97, "poke_in": 0.95,
    "poke_in_dominant": 0.90, "poke_out": 1.05, "poke_ratio": 1.5, "poke_health": 0.8, "poke_press_health": 0.5,
    "poke_pause_seconds": 5, "fire_at_will": false, "spacing": 64, "safety_margin": 4, "range_hysteresis": 16,
    "reaction_seconds": 1.25, "move_min_seconds": 0, "target_min_seconds": 0, "cohort_size": 12, "cohort_radius": 900,
    "regroup_seconds": 8, "rush_ratio": 1.5, "catch_seconds": 6, "engagement_seconds": 12, "support_allies": true,
    "support_loss_fraction": 0.70, "intent_gain": 0.20, "advantage_enter": 1.4, "advantage_exit": 1.1,
    "loss_fraction": 0.4, "static_loss_fraction": 0.12})";
// The same block as a resolved preset: the grammar key is skipped.
const char* kThugPreset = R"({"type": "ranged", "fire_in_range": true, "commander_focus": true, "coordinated": true,
    "sustained_rush": true, "sustained_rush_ratio": 2.0, "sustained_rush_radius": 900.0, "sustained_rush_min_front": 8,
    "sustained_rush_remaining": 0.25, "sustained_rush_cooldown": 20.0, "sustained_rush_range": 0.8,
    "formation": {"family": "t1_cortex_line", "position": "front"}, "range_fraction": 0.97, "poke_in": 0.95,
    "poke_in_dominant": 0.90, "poke_out": 1.05, "poke_ratio": 1.5, "poke_health": 0.8, "poke_press_health": 0.5,
    "poke_pause_seconds": 5, "fire_at_will": false, "spacing": 64, "safety_margin": 4, "range_hysteresis": 16,
    "reaction_seconds": 1.25, "move_min_seconds": 0, "target_min_seconds": 0, "cohort_size": 12, "cohort_radius": 900,
    "regroup_seconds": 8, "rush_ratio": 1.5, "catch_seconds": 6, "engagement_seconds": 12, "support_allies": true,
    "support_loss_fraction": 0.70, "intent_gain": 0.20, "advantage_enter": 1.4, "advantage_exit": 1.1,
    "loss_fraction": 0.4, "static_loss_fraction": 0.12})";
// D-432: the balanced Mace block (attribute form) and its resolved preset
// (t1_skirmisher + mace): the Thug block without fire_in_range and
// commander_focus, Armada family.
const char* kMaceAttribute = R"({"coordinated": true, "sustained_rush": true, "sustained_rush_ratio": 2.0,
    "sustained_rush_radius": 900.0, "sustained_rush_min_front": 8, "sustained_rush_remaining": 0.25,
    "sustained_rush_cooldown": 20.0, "sustained_rush_range": 0.8, "formation": {"family": "t1_bot_line", "position": "front"},
    "range_fraction": 0.97, "poke_in": 0.95, "poke_in_dominant": 0.90, "poke_out": 1.05, "poke_ratio": 1.5, "poke_health": 0.8,
    "poke_press_health": 0.5, "poke_pause_seconds": 5, "fire_at_will": false, "spacing": 64, "safety_margin": 4,
    "range_hysteresis": 16, "reaction_seconds": 1.25, "move_min_seconds": 0, "target_min_seconds": 0, "cohort_size": 12,
    "cohort_radius": 900, "regroup_seconds": 8, "rush_ratio": 1.5, "catch_seconds": 6, "engagement_seconds": 12,
    "support_allies": true, "support_loss_fraction": 0.70, "intent_gain": 0.20, "advantage_enter": 1.4, "advantage_exit": 1.1,
    "loss_fraction": 0.4, "static_loss_fraction": 0.12})";
const char* kMacePreset = R"({"type": "skirmisher", "coordinated": true,
    "sustained_rush_ratio": 2.0, "sustained_rush_radius": 900.0, "sustained_rush_min_front": 8, "sustained_rush_remaining": 0.25,
    "sustained_rush_cooldown": 20.0, "sustained_rush_range": 0.8, "spacing": 64, "safety_margin": 4, "range_hysteresis": 16,
    "reaction_seconds": 1.25, "cohort_size": 12, "cohort_radius": 900, "regroup_seconds": 8, "catch_seconds": 6,
    "engagement_seconds": 12, "advantage_enter": 1.4, "advantage_exit": 1.1, "intent_gain": 0.20, "range_fraction": 0.97,
    "poke_in": 0.95, "poke_in_dominant": 0.90, "poke_out": 1.05, "poke_ratio": 1.5, "poke_health": 0.8, "poke_press_health": 0.5,
    "poke_pause_seconds": 5, "fire_at_will": false, "move_min_seconds": 0, "target_min_seconds": 0, "rush_ratio": 1.5,
    "support_allies": true, "support_loss_fraction": 0.70, "loss_fraction": 0.4, "static_loss_fraction": 0.12,
    "formation": {"family": "t1_bot_line", "position": "front"}, "sustained_rush": true})";
// The balanced Rocketeer block (attribute form) and the resolved backline preset
// (t1_backline + rocketeer): no sustained rush (the backline refuses it), the
// backline's own keys skipped by the shared parser.
const char* kRocketeerAttribute = R"({"coordinated": true, "range_fraction": 0.95, "spacing": 64, "safety_margin": 4,
    "range_hysteresis": 16, "reaction_seconds": 1.25, "cohort_size": 12, "cohort_radius": 900, "regroup_seconds": 8,
    "catch_seconds": 6, "engagement_seconds": 12, "advantage_enter": 1.4, "advantage_exit": 1.1, "loss_fraction": 0.25,
    "static_loss_fraction": 0.08, "intent_gain": 0.20,
    "formation": {"family": "t1_bot_line", "position": "rear", "separation_minimum": 64, "separation_maximum": 96, "withdrawal_lead_seconds": 1.0}})";
const char* kRocketeerPreset = R"({"type": "backline", "coordinated": true, "spacing": 64, "safety_margin": 4,
    "range_hysteresis": 16, "reaction_seconds": 1.25, "cohort_size": 12, "cohort_radius": 900, "regroup_seconds": 8,
    "catch_seconds": 6, "engagement_seconds": 12, "advantage_enter": 1.4, "advantage_exit": 1.1, "intent_gain": 0.20,
    "range_fraction": 0.95, "loss_fraction": 0.25, "static_loss_fraction": 0.08,
    "screen_radius": 900, "static_bonus": 1.5, "beyond_screen_bonus": 1.3, "fast_target_speed": 70, "fast_target_penalty": 0.3,
    "self_defence_radius": 250, "self_defence_bonus": 4, "move_after_shot": true, "aim_hold_seconds": 0.8,
    "leak_radius": 350, "leak_corridor": 96, "tuck_count": 2, "tuck_offset": 96, "tuck_seconds": 8, "log": 1,
    "formation": {"family": "t1_bot_line", "position": "rear", "separation_minimum": 64, "separation_maximum": 96, "withdrawal_lead_seconds": 1.0}})";
const std::vector<std::string> kBacklineOwnKeys{"type", "screen_radius", "static_bonus", "beyond_screen_bonus", "fast_target_speed",
    "fast_target_penalty", "self_defence_radius", "self_defence_bonus", "move_after_shot", "aim_hold_seconds", "leak_radius",
    "leak_corridor", "tuck_count", "tuck_offset", "tuck_seconds", "log"};
const std::vector<std::string> kBacklineForbidden{"poke_in", "sustained_rush", "commander_focus", "fire_in_range", "press_static"};
const char* kAggravator = R"({"coordinated": true, "sustained_rush": true, "sustained_rush_ratio": 2.0,
    "sustained_rush_radius": 900.0, "sustained_rush_min_front": 8, "sustained_rush_remaining": 0.25,
    "sustained_rush_cooldown": 20.0, "sustained_rush_range": 0.8, "range_fraction": 0.95, "spacing": 64,
    "safety_margin": 4, "range_hysteresis": 16, "reaction_seconds": 1.25, "cohort_size": 12, "cohort_radius": 900,
    "regroup_seconds": 8, "catch_seconds": 6, "engagement_seconds": 12, "advantage_enter": 1.4, "advantage_exit": 1.1,
    "loss_fraction": 0.25, "static_loss_fraction": 0.08, "intent_gain": 0.20,
    "formation": {"family": "t1_cortex_line", "position": "rear", "separation_minimum": 64, "separation_maximum": 96, "withdrawal_lead_seconds": 1.0}})";
}

int main() {
    {  // Attribute form and preset form parse to one policy.
        RangedPolicy attribute, preset;
        std::vector<std::string> problems;
        assert(ranged_policy::Parse(Parse(kThugAttribute), attribute, kResolver, {}, problems) && problems.empty());
        assert(ranged_policy::Parse(Parse(kThugPreset), preset, kResolver, {"type"}, problems) && problems.empty());
        assert(Same(attribute, preset));
        assert(attribute.coordinated && attribute.fireInRange && attribute.commanderFocus && !attribute.fireAtWill);
        assert(attribute.formationPosition == RangedPolicy::FormationPosition::FRONT && attribute.formationFamily == "t1_cortex_line");
        assert(attribute.pokeIn == .95f && attribute.rangeFraction == .97f && attribute.lossFraction == .4f);
        assert(attribute.mode == RangedPolicy::Mode::SKIRMISH);
        // Without the skip the grammar key is only reported, never a rejection.
        RangedPolicy again;
        assert(ranged_policy::Parse(Parse(kThugPreset), again, kResolver, {}, problems) && problems.size() == 1);
        assert(problems.front().find("unknown key 'type'") != std::string::npos && Same(again, attribute));
    }
    {  // The rear block: separations and the withdrawal lead.
        RangedPolicy rear;
        std::vector<std::string> problems;
        assert(ranged_policy::Parse(Parse(kAggravator), rear, kResolver, {}, problems) && problems.empty());
        assert(rear.formationPosition == RangedPolicy::FormationPosition::REAR && rear.withdrawalLeadSeconds == 1.f);
        assert(rear.formationSeparationMinimum == 64.f && rear.formationSeparationMaximum == 96.f);
        assert(rear.lossFraction == .25f && rear.staticLossFraction == .08f && !rear.fireInRange);
    }
    {  // Legacy rejection rules: out of range, wrong type, inconsistent combinations.
        RangedPolicy p;
        std::vector<std::string> problems;
        assert(!ranged_policy::Parse(Parse(R"({"range_fraction": 1.2})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"spacing": "wide"})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"coordinated": 1})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"target_mode": "sniper"})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"hold_fireline": true, "coordinated": true})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"press_static": 1, "coordinated": true})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"assist_radius": 100, "coordinated": true})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"formation": {"family": "x", "position": "front"}})"), p, kResolver, {}, problems));  // not coordinated
        assert(!ranged_policy::Parse(Parse(R"({"coordinated": true, "formation": {"family": "x", "position": "side"}})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"coordinated": true, "formation": {"family": "x", "position": "rear", "separation_minimum": 200, "separation_maximum": 100}})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"sustained_rush": true, "coordinated": true})"), p, kResolver, {}, problems));  // no engagement, no formation
        assert(!ranged_policy::Parse(Parse(R"({"advantage_enter": 1.1, "advantage_exit": 1.4})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"({"avoid_categories": "NOSUCH"})"), p, kResolver, {}, problems));
        assert(!ranged_policy::Parse(Parse(R"([1,2])"), p, kResolver, {}, problems));
    }
    {  // Resolved names, reported-but-valid cases, defaults untouched by absent keys.
        RangedPolicy p;
        std::vector<std::string> problems;
        assert(ranged_policy::Parse(Parse(R"({"avoid_categories": "GROUNDSCOUT", "spam_units": ["armpw", "nosuch"], "typo_key": 3})"), p, kResolver, {}, problems));
        assert(p.avoidCategory == 64 && p.spamDefs.count(7) == 1 && p.spamDefs.size() == 1);
        assert(problems.size() == 2);  // unknown spam unit, unknown key
        assert(p.rangeFraction == .95f && p.spacing == 96.f && !p.coordinated);  // defaults
        RangedPolicy empty;
        assert(ranged_policy::Parse(Parse("{}"), empty, kResolver, {}, problems) && Same(empty, RangedPolicy()));
    }
    {  // The lever table carries the parser's ranges for every numeric key.
        const auto& keys = ranged_policy::NumericKeys();
        assert(keys.size() >= 40 && keys.size() <= 64);
        bool pokeIn = false, cohort = false;
        for (const auto& k : keys) {
            RangedPolicy p;
            k.access(p) = k.high;  // the accessor writes the named field
            if (std::string(k.name) == "poke_in") { pokeIn = p.pokeIn == .99f && k.low == 0.f; }
            if (std::string(k.name) == "cohort_size") { cohort = p.cohortSize == 12.f && k.low == 1.f; }
            assert(k.low <= k.high);
        }
        assert(pokeIn && cohort);
    }
    {  // D-432: Mace, attribute form against the resolved skirmisher preset.
        RangedPolicy attribute, preset;
        std::vector<std::string> problems;
        assert(ranged_policy::Parse(Parse(kMaceAttribute), attribute, kResolver, {}, problems) && problems.empty());
        assert(ranged_policy::Parse(Parse(kMacePreset), preset, kResolver, {"type"}, problems) && problems.empty());
        assert(Same(attribute, preset) && !attribute.fireInRange && !attribute.commanderFocus);
        assert(attribute.formationFamily == "t1_bot_line" && attribute.sustainedRush);
    }
    {  // D-432: Rocketeer, attribute form against the resolved backline preset (own keys skipped).
        RangedPolicy attribute, preset;
        std::vector<std::string> problems;
        assert(ranged_policy::Parse(Parse(kRocketeerAttribute), attribute, kResolver, {}, problems) && problems.empty());
        assert(ranged_policy::Parse(Parse(kRocketeerPreset), preset, kResolver, kBacklineOwnKeys, kBacklineForbidden, problems) && problems.empty());
        assert(Same(attribute, preset) && !attribute.sustainedRush);
        assert(attribute.formationPosition == RangedPolicy::FormationPosition::REAR && attribute.withdrawalLeadSeconds == 1.f);
    }
    {  // D-432: a job's parser refuses another job's lever, naming it.
        RangedPolicy p;
        std::vector<std::string> problems;
        assert(!ranged_policy::Parse(Parse(R"({"coordinated": true, "cloak_on_reload": true})"), p, kResolver, {}, {"cloak_on_reload"}, problems));
        assert(problems.size() == 1 && problems.front().find("'cloak_on_reload' belongs to another job") != std::string::npos);
        problems.clear();
        assert(ranged_policy::Parse(Parse(R"({"coordinated": true, "cloak_on_reload": true})"), p, kResolver, {}, {"poke_in"}, problems) && problems.empty());
        assert(!ranged_policy::Parse(Parse(kAggravator), p, kResolver, {}, kBacklineForbidden, problems));  // the D-430 rear carried sustained_rush
    }
    std::puts("ranged policy: attribute and preset forms agree, legacy rejections, job refusals and levers PASS");
    return 0;
}
