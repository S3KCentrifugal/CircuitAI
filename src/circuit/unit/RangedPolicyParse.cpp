#include "unit/RangedPolicyParse.h"

#include <algorithm>
#include <cmath>

namespace circuit::ranged_policy {

namespace {
// Owner 2026-10-17/19 poke bounds, moved here with the parser (D-430).
constexpr float POKE_MIN_IN_RANGE = 0.f;
constexpr float POKE_MAX_IN_RANGE = .99f;
constexpr float POKE_MIN_PRESS_RANGE = .5f;
constexpr float POKE_MIN_OUT_RANGE = 1.f;
constexpr float POKE_MAX_OUT_RANGE = 1.5f;
constexpr float POKE_MIN_METAL_RATIO = 1.f;
constexpr float POKE_MAX_METAL_RATIO = 10.f;
constexpr float POKE_MIN_HEALTH = 0.f;
constexpr float POKE_MAX_HEALTH = 1.f;
constexpr float POKE_MIN_PAUSE_SECONDS = 0.f;
constexpr float POKE_MAX_PAUSE_SECONDS = 60.f;

template <auto M> float& Field(RangedPolicy& p) { return p.*M; }

// Every numeric lever with the legacy parser's range. Order is the legacy
// parse order, so a reader can diff this table against the old code.
const std::vector<NumericKey> kNumeric{
    {"range_fraction", Field<&RangedPolicy::rangeFraction>, .5f, .99f},
    {"spacing", Field<&RangedPolicy::spacing>, 16.f, 1024.f},
    {"safety_margin", Field<&RangedPolicy::safetyMargin>, 0.f, 512.f},
    {"range_hysteresis", Field<&RangedPolicy::hysteresis>, 8.f, 256.f},
    {"reaction_seconds", Field<&RangedPolicy::reactionSeconds>, .1f, 5.f},
    {"target_hysteresis", Field<&RangedPolicy::targetHysteresis>, 1.f, 3.f},
    {"move_min_seconds", Field<&RangedPolicy::moveMinSeconds>, 0.f, 3.f},
    {"target_min_seconds", Field<&RangedPolicy::targetMinSeconds>, 0.f, 3.f},
    {"target_switch_ratio", Field<&RangedPolicy::targetSwitchRatio>, 1.f, 5.f},
    {"sensor_offset", Field<&RangedPolicy::sensorOffset>, 32.f, 512.f},
    {"cloak_reserve_seconds", Field<&RangedPolicy::cloakReserve>, 0.f, 30.f},
    {"repaired_target_penalty", Field<&RangedPolicy::repairedTargetPenalty>, .01f, 1.f},
    {"splash_weight", Field<&RangedPolicy::splashWeight>, 0.f, 3.f},
    {"spam_max_cost", Field<&RangedPolicy::spamMaxCost>, 0.f, 2000.f},
    {"commander_priority", Field<&RangedPolicy::commanderPriority>, 1.f, 100.f},
    {"cohort_size", Field<&RangedPolicy::cohortSize>, 1.f, 12.f},
    {"cohort_radius", Field<&RangedPolicy::cohortRadius>, 128.f, 1600.f},
    {"regroup_seconds", Field<&RangedPolicy::regroupSeconds>, 0.f, 20.f},
    {"rush_ratio", Field<&RangedPolicy::rushRatio>, 1.f, 5.f},
    {"catch_seconds", Field<&RangedPolicy::catchSeconds>, 0.f, 15.f},
    {"engagement_seconds", Field<&RangedPolicy::engagementSeconds>, 0.f, 30.f},
    {"sustained_rush_ratio", Field<&RangedPolicy::sustainedRushRatio>, 1.f, 10.f},
    {"sustained_rush_radius", Field<&RangedPolicy::sustainedRushRadius>, 128.f, 1600.f},
    {"sustained_rush_min_front", Field<&RangedPolicy::sustainedRushMinFront>, 1.f, 256.f},
    {"sustained_rush_remaining", Field<&RangedPolicy::sustainedRushRemaining>, .01f, 1.f},
    {"sustained_rush_cooldown", Field<&RangedPolicy::sustainedRushCooldown>, 1.f, 120.f},
    {"sustained_rush_range", Field<&RangedPolicy::sustainedRushRange>, .25f, 1.f},
    {"advantage_enter", Field<&RangedPolicy::advantageEnter>, 1.f, 5.f},
    {"advantage_exit", Field<&RangedPolicy::advantageExit>, 1.f, 5.f},
    {"loss_fraction", Field<&RangedPolicy::lossFraction>, 0.f, .9f},
    {"static_loss_fraction", Field<&RangedPolicy::staticLossFraction>, 0.f, .9f},
    {"support_loss_fraction", Field<&RangedPolicy::supportLossFraction>, 0.f, .9f},
    {"intent_gain", Field<&RangedPolicy::intentGain>, 0.f, .5f},
    {"evasion_limit", Field<&RangedPolicy::evasionLimit>, 0.f, 10.f},
    {"poke_in", Field<&RangedPolicy::pokeIn>, POKE_MIN_IN_RANGE, POKE_MAX_IN_RANGE},
    {"poke_in_dominant", Field<&RangedPolicy::pokeInDominant>, POKE_MIN_PRESS_RANGE, POKE_MAX_IN_RANGE},
    {"poke_out", Field<&RangedPolicy::pokeOut>, POKE_MIN_OUT_RANGE, POKE_MAX_OUT_RANGE},
    {"poke_ratio", Field<&RangedPolicy::pokeRatio>, POKE_MIN_METAL_RATIO, POKE_MAX_METAL_RATIO},
    {"poke_health", Field<&RangedPolicy::pokeHealth>, POKE_MIN_HEALTH, POKE_MAX_HEALTH},
    {"poke_press_health", Field<&RangedPolicy::pokePressHealth>, POKE_MIN_HEALTH, POKE_MAX_HEALTH},
    {"poke_pause_seconds", Field<&RangedPolicy::pokePauseSeconds>, POKE_MIN_PAUSE_SECONDS, POKE_MAX_PAUSE_SECONDS},
    {"press_static", Field<&RangedPolicy::pressStatic>, 0.f, 3.f},
    {"assist_radius", Field<&RangedPolicy::assistRadius>, 0.f, 6000.f},
    {"assist_margin", Field<&RangedPolicy::assistMargin>, 0.f, 600.f},
};

struct BoolKey { const char* name; bool RangedPolicy::* member; };
const BoolKey kBooleans[]{
    {"cloak_on_reload", &RangedPolicy::cloakOnReload},
    {"allow_mobile", &RangedPolicy::allowMobile},
    {"allow_static", &RangedPolicy::allowStatic},
    {"prefer_heavy", &RangedPolicy::preferHeavy},
    {"prefer_screen", &RangedPolicy::preferScreen},
    {"allow_radar", &RangedPolicy::allowRadar},
    {"advance_unknown_radar", &RangedPolicy::advanceUnknownRadar},
    {"low_trajectory", &RangedPolicy::lowTrajectory},
    {"hold_fireline", &RangedPolicy::holdFireline},
    {"stage_when_blocked", &RangedPolicy::stageWhenBlocked},
    {"fire_at_will", &RangedPolicy::fireAtWill},
    {"fire_in_range", &RangedPolicy::fireInRange},
    {"commander_focus", &RangedPolicy::commanderFocus},
    {"coordinated", &RangedPolicy::coordinated},
    {"sustained_rush", &RangedPolicy::sustainedRush},
    {"support_allies", &RangedPolicy::supportAllies},
    {"assist_screen", &RangedPolicy::assistScreen},
};
const char* const kOtherKeys[]{"target_mode", "spam_units", "avoid_categories", "formation"};
}

const std::vector<NumericKey>& NumericKeys() { return kNumeric; }

bool Parse(const Json::Value& settings, RangedPolicy& policy, const Resolver& resolver,
           const std::vector<std::string>& skip, std::vector<std::string>& problems)
{
    return Parse(settings, policy, resolver, skip, {}, problems);
}

bool Parse(const Json::Value& settings, RangedPolicy& policy, const Resolver& resolver,
           const std::vector<std::string>& skip, const std::vector<std::string>& forbidden,
           std::vector<std::string>& problems)
{
    if (!settings.isObject()) { problems.push_back("ranged policy is not an object"); return false; }
    bool valid = true;
    const auto fail = [&](const std::string& why) { valid = false; problems.push_back(why); };
    // D-432: a job's parser owns its levers; another job's key rejects the block.
    for (const std::string& key : settings.getMemberNames()) {
        if (std::find(forbidden.begin(), forbidden.end(), key) != forbidden.end())
            fail("'" + key + "' belongs to another job's controller");
    }

    const auto modeValue = settings.get("target_mode", "skirmish");
    if (!modeValue.isString()) fail("target_mode is not a string");
    const std::string mode = modeValue.isString() ? modeValue.asString() : "";
    if (mode == "precision") policy.mode = RangedPolicy::Mode::PRECISION;
    else if (mode == "bombardment") policy.mode = RangedPolicy::Mode::BOMBARDMENT;
    else if (mode == "carrier") policy.mode = RangedPolicy::Mode::CARRIER;
    else if (mode == "skirmish") policy.mode = RangedPolicy::Mode::SKIRMISH;
    else if (modeValue.isString()) fail("target_mode '" + mode + "' is unknown");

    // Validate at load, not in each shooter update. Reject malformed policies
    // explicitly instead of letting NaNs disable safety checks (legacy rule).
    for (const auto& key : kNumeric) {
        const auto& setting = settings[key.name];
        if (setting.isNull()) continue;
        if (!setting.isNumeric()) { fail(std::string(key.name) + " is not a number"); continue; }
        const float candidate = setting.asFloat();
        if (!std::isfinite(candidate) || candidate < key.low || candidate > key.high) {
            fail(std::string(key.name) + " is outside [" + std::to_string(key.low) + ", " + std::to_string(key.high) + "]");
            continue;
        }
        key.access(policy) = candidate;
    }
    for (const auto& key : kBooleans) {
        const auto& setting = settings[key.name];
        if (setting.isNull()) continue;
        if (!setting.isBool()) { fail(std::string(key.name) + " is not a boolean"); continue; }
        policy.*key.member = setting.asBool();
    }
    {
        // Owner 2026-10-27: an explicit spam roster. A name this game does
        // not have is reported and skipped, not a malformed policy.
        const auto& spam = settings["spam_units"];
        if (!spam.isNull() && !spam.isArray()) fail("spam_units is not an array");
        else for (const auto& name : spam) {
            if (!name.isString()) { fail("spam_units holds a non-string"); continue; }
            const int id = resolver.defId ? resolver.defId(name.asString()) : -1;
            if (id < 0) problems.push_back("spam_units has unknown unit '" + name.asString() + "'");
            else policy.spamDefs.insert(id);
        }
    }
    // Fireline holding is an individual forward-arc doctrine. Reject
    // unsupported cohort ownership instead of silently allowing retreats.
    if (policy.holdFireline && policy.coordinated) fail("hold_fireline cannot be coordinated");
    // D-294: resolve category names once at load. A malformed value or a
    // non-empty name the engine does not know disables the policy.
    const auto& avoid = settings["avoid_categories"];
    if (!avoid.isNull()) {
        if (!avoid.isString()) fail("avoid_categories is not a string");
        else if (!avoid.asString().empty()) {
            policy.avoidCategory = resolver.categoryFlag ? resolver.categoryFlag(avoid.asString()) : 0;
            if (policy.avoidCategory == 0) fail("avoid_categories '" + avoid.asString() + "' is unknown");
        }
    }
    // The cohort controller has its own static admission (assault list).
    if (policy.pressStatic > 0.f && policy.coordinated) fail("press_static cannot be coordinated");
    // D-295: assist is an individual-controller lever; a coordinated cohort
    // already has support_allies. Reject the combination.
    if (policy.assistRadius > 0.f && policy.coordinated) fail("assist_radius cannot be coordinated");
    const auto& formation = settings["formation"];
    if (!formation.isNull()) {
        if (!formation.isObject() || !formation["family"].isString() || !formation["position"].isString()) {
            fail("formation needs string family and position");
        } else {
            policy.formationFamily = formation["family"].asString();
            const auto position = formation["position"].asString();
            if (position == "front") policy.formationPosition = RangedPolicy::FormationPosition::FRONT;
            else if (position == "rear") policy.formationPosition = RangedPolicy::FormationPosition::REAR;
            else fail("formation position '" + position + "' is unknown");
            if (policy.formationFamily.empty() || !policy.coordinated) fail("formation needs a family and coordinated");
            const auto readFormationNumber = [&](const char* name, float& value, float minimum, float maximum) {
                const auto& setting = formation[name];
                if (setting.isNull()) return;
                if (!setting.isNumeric()) { fail(std::string("formation.") + name + " is not a number"); return; }
                const float candidate = setting.asFloat();
                if (!std::isfinite(candidate) || candidate < minimum || candidate > maximum) fail(std::string("formation.") + name + " is out of range");
                else value = candidate;
            };
            readFormationNumber("separation_minimum", policy.formationSeparationMinimum, 16.f, 512.f);
            readFormationNumber("separation_maximum", policy.formationSeparationMaximum, 16.f, 1024.f);
            readFormationNumber("withdrawal_lead_seconds", policy.withdrawalLeadSeconds, 0.f, 5.f);
            if (policy.formationSeparationMinimum > policy.formationSeparationMaximum) fail("formation separation minimum exceeds maximum");
        }
    }
    if (policy.sustainedRush && (!policy.coordinated || policy.engagementSeconds <= 0.f
        || policy.formationPosition == RangedPolicy::FormationPosition::NONE)) fail("sustained_rush needs coordinated, engagement_seconds and a formation");
    if (policy.advantageExit > policy.advantageEnter) fail("advantage_exit exceeds advantage_enter");

    // Unknown keys are reported (the controller framework's rule) but, as in
    // the legacy parser, never invalidate the block.
    for (const std::string& key : settings.getMemberNames()) {
        if (std::find(skip.begin(), skip.end(), key) != skip.end()) continue;
        bool known = std::any_of(kNumeric.begin(), kNumeric.end(), [&](const NumericKey& k) { return key == k.name; })
            || std::any_of(std::begin(kBooleans), std::end(kBooleans), [&](const BoolKey& k) { return key == k.name; })
            || std::any_of(std::begin(kOtherKeys), std::end(kOtherKeys), [&](const char* k) { return key == k; });
        if (!known) problems.push_back("unknown key '" + key + "'");
    }
    return valid;
}

} // namespace circuit::ranged_policy
