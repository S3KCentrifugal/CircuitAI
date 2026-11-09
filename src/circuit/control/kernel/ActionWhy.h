#pragma once
// D-508: why a battle group, a cohort or a unit does what it does, for the
// unit monitor (control/group/GroupMonitor.cpp, tools/widgets/
// gui_barb_unit_monitor.lua). Engine-free.
//
// Factors. A cohort's mode and its single `reason` say which branch won; the
// factors record every condition that held when the plan, the battle group or
// a member decided, so the monitor can list several (withdraw: outranged,
// static cover, unknown contact). They are diagnostics: no decision reads
// them. Each is one bit set where its decision is made (an OR, no allocation).
//
// Activity. The label the monitor shows: the mode, except where the mode
// hides the purpose. A walk to the main group (join or recall) runs in ADVANCE
// but is a regroup; the D-507 stand-off runs in WITHDRAW but is a siege; a
// member's own escape, poke, siege step or tuck overrides its cohort's. The
// behaviour modes are unchanged.
//
// Wire format (owner 2026-11-09: codes, not words). A record carries the
// activity as its index and each factor set as lower-case hex. The names
// travel once, in Dictionary(), which the script publishes as its own state key
// when the monitor lease starts; the widget decodes with it and shows an
// unknown bit as "bit<N>", so a newer AI never breaks an older widget. The
// tables below are the one source of the names: bit i of a set is entry i of
// its table (checked at compile time), and a code is lower case without
// ',', ';', ':', '=' or '|'.
#include "terrain/GroundCohort.h"

#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <string>

namespace circuit::why {

using Set = std::uint32_t;

// The cohort plan (CRangedWorld::CohortPlan::why), reset on every plan.
namespace plan {
enum Bit : int {
    OBJECTIVE,        // nothing in sight: walking to its objective on the lane
    JOINING,          // below its size target: walking to merge with the main group (D-501)
    RECALLED,         // pulled out of its own fight to the main group (D-504 recall_size)
    ARRIVED,          // at its travel goal
    LOST_CONTACT,     // a commander or reclaimer left sight: holds the safe line
    ALLY_ENGAGED,     // its own damaged members or allies are fighting: turned to that fight (D-503)
    TARGET_IN_SIGHT,  // an enemy objective is in sight
    FAVORABLE,        // the local trade is worth taking: committed
    OUTMATCHED,       // the local trade costs more than the loss limit allows
    UNKNOWN_CONTACT,  // an unseen mobile near the firing point
    HAZARD_ON_PATH,   // a commander, reclaimer or death blast on the approach
    BATTERY,          // more armed statics than one assault may name
    TARGET_REPAIRED,  // the static target is being repaired
    TOO_FAR,          // cannot reach its firing band within the assessment horizon
    OFF_MAP,          // the firing point lies off the map
    STATIC_COVER,     // armed statics cover the approach
    OUTRANGED,        // an enemy's reach extends past its firing band
    SIEGE,            // its support outranges every armed static here: stands off (D-507)
    ASSEMBLING,       // waiting for members to arrive before the fight
    SPREAD_OUT,       // too deep a column: the front waits for the rear
    JAMMER_HOLD,      // inside our jammer cover: a withdraw became a hold (D-505)
    SCREENING,        // screens allied support in the fight
    RUSH,             // a sustained rush campaign
    RUSH_COOLDOWN,    // after a rush: falls back while it cools down
    FOLLOWS_SCREEN,   // a support cohort taking its screen's plan
    RUSHED,           // D-510: shorter-ranged raiders close on it: it kites them
    TOWARD_HELP,      // D-510: its retreat heads for allied defences or units that can help
    DOWN_LANE,        // D-510: no help in reach: its retreat heads back down the lane
    TO_BASE,          // D-510: no help and no lane behind it: its retreat heads for the base
    STANDS,           // D-510: rushed by raiders it cannot outrun, help too far: stands and fires
    PRESSING,         // D-512: trading well: commits sooner and pushes on with nothing in sight
    FALLING_BACK,     // D-512: trading badly: falls back toward help to heal
    COUNT
};
inline constexpr const char* CODES[] = {
    "objective", "joining", "recalled", "arrived", "lost_contact", "ally_engaged", "target_in_sight",
    "favorable", "outmatched", "unknown_contact", "hazard_on_path", "battery", "target_repaired",
    "too_far", "off_map", "static_cover", "outranged", "siege", "assembling", "spread_out",
    "jammer_hold", "screening", "rush", "rush_cooldown", "follows_screen",
    "rushed", "toward_help", "down_lane", "to_base", "stands", "pressing", "falling_back",
};
static_assert(sizeof(CODES) / sizeof(CODES[0]) == COUNT, "why::plan::CODES must follow why::plan::Bit");
} // namespace plan

// One member's last decision (CRangedEngagement::UpdateCohort), kept by the
// ranged world per unit (CRangedWorld::NoteUnitWhy).
namespace unit {
enum Bit : int {
    ESCAPE,          // inside an enemy's reach: steps out of it
    POKE_IN,         // weapon ready: steps in to fire
    POKE_OUT,        // reloading: steps back out
    HOLD_INCOMING,   // a shorter-ranged enemy closes: lets it come into range
    SHOOTING,        // a legal shot from a free spot: stays and fires
    TO_SLOT,         // too far from its place in the rows: walks there
    SIEGE_STATION,   // on its way to or on the support's siege station
    SIEGE_STEP,      // the last step into its own reach of the tower
    TUCK,            // an enemy leaked past the screen: tucks behind it
    NO_SCREEN,       // no screen left: the fallback station
    COVER_DELAY,     // the support leaves first: the screen holds and fires
    BEHIND_SUPPORT,  // a retreat stops at the support line
    JAMMER_NO_BACK,  // inside our jammer cover: never steps back
    GROUP_HOLD,      // the battle group's hold or cover keeps it in place
    GROUP_WITHDRAW,  // a script withdraw steps it back
    STAGED,          // stops short of static coverage on the way
    NO_SAFE_MOVE,    // no safe move: holds where it is
    WAIT_RELOAD,     // moves only between shots
    SETTLED,         // at its point
    COUNT
};
inline constexpr const char* CODES[] = {
    "escape", "poke_in", "poke_out", "hold_incoming", "shooting", "to_slot", "siege_station", "siege_step",
    "tuck", "no_screen", "cover_delay", "behind_support", "jammer_no_back", "group_hold", "group_withdraw",
    "staged", "no_safe_move", "wait_reload", "settled",
};
static_assert(sizeof(CODES) / sizeof(CODES[0]) == COUNT, "why::unit::CODES must follow why::unit::Bit");
} // namespace unit

// The battle group's order (CBattleGroupController, kept per group).
namespace group {
enum Bit : int {
    SCRIPT_ORDER,  // the script's order is more cautious than its own
    ORDER_HELD,    // its own plan changed: the order waits order_min_seconds
    STAND_FIRM,    // shorter-ranged enemies push: the screen stands and fires
    STAGGERED,     // screen and support follow the order at different delays
    AIR_THREAT,    // D-509: armed enemy air near the screen: anti-air escorts needed
    COUNT
};
inline constexpr const char* CODES[] = { "script_order", "order_held", "stand_firm", "staggered", "air_threat" };
static_assert(sizeof(CODES) / sizeof(CODES[0]) == COUNT, "why::group::CODES must follow why::group::Bit");
} // namespace group

static_assert(plan::COUNT <= 32 && unit::COUNT <= 32 && group::COUNT <= 32, "a factor set is 32 bits");

constexpr Set Of(int bit) { return Set(1) << bit; }

enum class Activity : int { ADVANCE, HOLD, KITE, WITHDRAW, RUSH, REGROUP, SIEGE, TUCK, ESCAPE, POKE, COUNT };
inline constexpr const char* ACTIVITY_CODES[] = {
    "advance", "hold", "kite", "withdraw", "rush", "regroup", "siege", "tuck", "escape", "poke",
};
static_assert(sizeof(ACTIVITY_CODES) / sizeof(ACTIVITY_CODES[0]) == std::size_t(Activity::COUNT),
    "why::ACTIVITY_CODES must follow why::Activity");

// The cohort's activity (see the header comment).
inline Activity CohortActivity(cohort::Mode mode, Set factors) {
    if (factors & (Of(plan::JOINING) | Of(plan::RECALLED))) return Activity::REGROUP;
    if (factors & Of(plan::SIEGE)) return Activity::SIEGE;
    switch (mode) {
        case cohort::Mode::ADVANCE: return Activity::ADVANCE;
        case cohort::Mode::HOLD: return Activity::HOLD;
        case cohort::Mode::KITE: return Activity::KITE;
        case cohort::Mode::WITHDRAW: return Activity::WITHDRAW;
        case cohort::Mode::RUSH: return Activity::RUSH;
        case cohort::Mode::REGROUP: return Activity::REGROUP;
    }
    return Activity::ADVANCE;
}

// A member's activity: what it does on its own this decision, else its cohort's.
inline Activity UnitActivity(Activity cohortActivity, Set factors) {
    if (factors & Of(unit::TUCK)) return Activity::TUCK;
    if (factors & Of(unit::ESCAPE)) return Activity::ESCAPE;
    if (factors & (Of(unit::POKE_IN) | Of(unit::POKE_OUT))) return Activity::POKE;
    if (factors & (Of(unit::SIEGE_STATION) | Of(unit::SIEGE_STEP))) return Activity::SIEGE;
    return cohortActivity;
}

// A factor set as lower-case hex without prefix ("0" when empty).
inline std::string Hex(Set set) {
    char buf[12];
    std::snprintf(buf, sizeof(buf), "%x", unsigned(set));
    return buf;
}

// The decode table: "<version>;A=<activity>:...;P=<plan bit 0>:...;U=...;G=...".
inline constexpr int DICTIONARY_VERSION = 1;
inline std::string Dictionary() {
    std::string out = std::to_string(DICTIONARY_VERSION);
    const auto list = [&out](const char* tag, const char* const* codes, int count) {
        out += ';'; out += tag; out += '=';
        for (int i = 0; i < count; ++i) { if (i > 0) out += ':'; out += codes[i]; }
    };
    list("A", ACTIVITY_CODES, int(Activity::COUNT));
    list("P", plan::CODES, plan::COUNT);
    list("U", unit::CODES, unit::COUNT);
    list("G", group::CODES, group::COUNT);
    return out;
}

} // namespace circuit::why
