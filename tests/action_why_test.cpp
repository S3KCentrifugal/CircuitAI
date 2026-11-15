// D-508: the unit monitor's activity and factor codes (control/kernel/ActionWhy.h):
// the activity a walk to the main group or a siege shows, a member's own
// activity over its cohort's, the hex sets and the decode table the widget reads.
#include "control/kernel/ActionWhy.h"

#include <cassert>
#include <cstdio>
#include <cstring>
#include <string>

using namespace circuit;

int main() {
    using why::Of;
    {  // A join or recall walk runs in ADVANCE but is a regroup; a stand-off in WITHDRAW is a siege.
        assert(why::CohortActivity(cohort::Mode::ADVANCE, Of(why::plan::JOINING)) == why::Activity::REGROUP);
        assert(why::CohortActivity(cohort::Mode::HOLD, Of(why::plan::RECALLED) | Of(why::plan::ARRIVED)) == why::Activity::REGROUP);
        assert(why::CohortActivity(cohort::Mode::WITHDRAW, Of(why::plan::SIEGE)) == why::Activity::SIEGE);
        assert(why::CohortActivity(cohort::Mode::ADVANCE, Of(why::plan::OBJECTIVE)) == why::Activity::ADVANCE);
        assert(why::CohortActivity(cohort::Mode::WITHDRAW, Of(why::plan::OUTRANGED)) == why::Activity::WITHDRAW);
    }
    {  // A member's own escape, tuck, poke or siege step wins over its cohort's activity.
        const auto advance = why::Activity::ADVANCE;
        assert(why::UnitActivity(advance, 0) == advance);
        assert(why::UnitActivity(advance, Of(why::unit::SHOOTING)) == advance);
        assert(why::UnitActivity(advance, Of(why::unit::ESCAPE)) == why::Activity::ESCAPE);
        assert(why::UnitActivity(advance, Of(why::unit::ESCAPE) | Of(why::unit::TUCK)) == why::Activity::TUCK);
        assert(why::UnitActivity(advance, Of(why::unit::POKE_OUT)) == why::Activity::POKE);
        assert(why::UnitActivity(why::Activity::SIEGE, Of(why::unit::SIEGE_STEP)) == why::Activity::SIEGE);
    }
    {  // Hex: lower case, no prefix, "0" for none.
        assert(why::Hex(0) == "0");
        assert(why::Hex(Of(why::plan::OBJECTIVE) | Of(why::plan::OUTRANGED)) == "10001");
        assert(why::Hex(0xffffffffu) == "ffffffff");
    }
    {  // The decode table: version, then A, P, U, G with entry i for bit i.
        const std::string d = why::Dictionary();
        assert(d.rfind(std::to_string(why::DICTIONARY_VERSION) + ";A=advance:hold:", 0) == 0);
        assert(d.find(";P=objective:joining:recalled:") != std::string::npos);
        assert(d.find(";U=escape:poke_in:poke_out:") != std::string::npos);
        assert(d.find(";G=script_order:order_held:stand_firm:staggered") != std::string::npos);
        // A code never holds a separator of the wire format.
        const auto clean = [](const char* code) { return std::strpbrk(code, ",;:=|+ ") == nullptr && *code != '\0'; };
        for (const char* c : why::plan::CODES) assert(clean(c));
        for (const char* c : why::unit::CODES) assert(clean(c));
        for (const char* c : why::group::CODES) assert(clean(c));
        for (const char* c : why::ACTIVITY_CODES) assert(clean(c));
        // Entry i is bit i: the last plan code sits at the last plan bit.
        const std::size_t p = d.find(";P="), u = d.find(";U=");
        const std::string plan = d.substr(p + 3, u - p - 3);
        int entries = 1;
        for (char ch : plan) entries += ch == ':';
        assert(entries == why::plan::COUNT);
        assert(plan.substr(plan.rfind(':') + 1) == why::plan::CODES[why::plan::COUNT - 1]);
    }
    std::puts("action_why_test: ok");
    return 0;
}
