#pragma once
// D-430: the line group controller, the first group controller
// (control/core/GroupController.h). A line is a screen cohort of the ranged
// controller's units (Thugs, Maces) with the rear cohort paired behind it
// (Aggravators, Rocketeers) through the existing `t1_bot_line` family. The
// cohort world still forms and merges the cohorts (behaviour parity with the
// attribute path); this controller rides them and adds what the cohorts never
// had: one mind per line. It reads the enemy composition near the line, turns
// the line to the threat axis and opens its spacing to the enemy's splash, and
// routes every order (its own, from the cohort's assessment, or the script's)
// to the two slot kinds with the template's delays, so a withdrawal reaches
// the rear first and the screen covers until its delay elapses. Members read
// the resulting directive inside CRangedEngagement::UpdateCohort; a member's
// hard-hazard escape always wins over the line's timing.
//
// Cost: once per `period` frames, O(L x (M + K)) for L lines, M members and K
// contacts within `threat_radius` from the shared per-frame snapshot; no
// engine query, no orders. Directives are written in place (one small map),
// read by members in O(1). Phase: performance::LINE_DECISION.
#include "control/core/ConfigTable.h"
#include "control/core/GroupController.h"
#include "control/kernel/LineFormation.h"

#include <map>
#include <string>
#include <unordered_map>
#include <vector>

namespace circuit {
class CCircuitAI;
class CRangedWorld;

struct LineConfig {
    // Routing: seconds; a negative rear delay means "until the separation opens".
    float withdrawScreenDelay = 1.f, withdrawRearDelay = 0.f, withdrawScreenCover = 1.f;
    float advanceScreenDelay = 0.f, advanceRearDelay = -1.f;
    float attackScreenDelay = 0.f, attackRearDelay = 0.f;
    float holdDelay = 0.f;
    float orderMinSeconds = 1.f;      // a less cautious order waits this long
    float scriptOrderSeconds = 20.f;  // a script order's lifetime
    // Orientation and spacing from the enemy composition.
    float orient = 1.f, headingDeadband = 20.f, threatRadius = 1400.f, peerBand = .25f;
    float spreadEnabled = 1.f, spreadCap = 2.f;
    float period = 15.f, log = 1.f;
};

class CLineController final : public IGroupController {
public:
    explicit CLineController(CCircuitAI* ai);

    const char* Name() const override { return "line"; }
    int ParseTemplate(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) override;
    int TemplateIndex(const std::string& name) const override;
    bool SetTemplateOption(const std::string& name, const std::string& key, float value) override;
    void Update() override;
    void UnitRemoved(int unitId) override;
    bool Order(const std::string& name, const std::string& kind, const springai::AIFloat3& pos) override;

    // The member side: O(1); null when the unit is in no line.
    const line::Directive* DirectiveFor(int unitId) const {
        const auto it = directives.find(unitId);
        return it == directives.end() ? nullptr : &it->second;
    }
    int Lines() const { return int(lines.size()); }
    std::string Describe(int lineKey) const;

private:
    struct Template { std::string name; LineConfig config; };
    struct Line {
        int key = -1, tmpl = -1, partner = -1;
        line::Order internal = line::Order::NONE, script = line::Order::NONE, effective = line::Order::NONE;
        int orderFrame = -1, scriptFrame = -1, seen = -1;
        springai::AIFloat3 scriptGoal;
        line::Composition composition;
        ranged::Point facing{0.f, 0.f};
        bool facingSet = false;
        float spread = 1.f, separation = 0.f, screenSpeed = 1.f;
        int screens = 0, rears = 0;
        line::Stance screenStance = line::Stance::FOLLOW, rearStance = line::Stance::FOLLOW;
    };
    void Observe(Line& l, CRangedWorld& world, int frame);
    void Route(Line& l, const Template& t, int frame);
    void Write(const Line& l, const std::vector<int>& members, line::Slot slot, line::Stance stance);

    CCircuitAI* ai;
    std::vector<Template> templates;
    std::map<int, Line> lines;                          // front cohort key -> line
    std::unordered_map<int, line::Directive> directives;  // member id -> directive
    std::vector<int> nearby;                            // reused contact buffer
    int generation = 0, nextFrame = 0;
    bool trace = false;
};

} // namespace circuit
