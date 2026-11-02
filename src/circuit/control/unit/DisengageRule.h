#pragma once
// D-433: what a skirmisher or backline controller does on a damage event,
// shared by both: the legacy retreat floor, then the retreat rule
// (control/kernel/Disengage.h: threshold, veterancy, escape feasibility),
// then the heavy repair and the repair rotation, then self-destruct. Levers
// are the policy's retreat_health, retreat_veteran_bonus, repair_health,
// repair_radius and repair_cooldown_seconds; with all at their defaults the
// legacy IFighterTask damage handling is reproduced exactly.
#include <string>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class CRangedEngagement;
struct RangedPolicy;

namespace disengage_rule {

// Per-unit memory the rule keeps between damage events.
struct Memory {
    int lastRepairFrame = -1;     // the last repair rotation trip
    float experience = 0.f;       // engine experience, read at most once a second
    int experienceFrame = -1;
};

// Returns true when the unit was handed to the retreat task (the caller's
// lease ends there). `tag` prefixes the log lines ("SKIRMISHER", "BACKLINE").
bool Apply(CCircuitAI* ai, CCircuitUnit* unit, const CRangedEngagement& engagement, const RangedPolicy& policy,
           Memory& memory, int frame, const char* tag);

} // namespace disengage_rule
} // namespace circuit
