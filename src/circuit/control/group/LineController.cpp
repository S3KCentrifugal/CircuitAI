#include "control/group/LineController.h"
#include "module/MilitaryManager.h"
#include "task/fighter/RangedWorld.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

#include <cstdlib>

namespace circuit {

namespace {
using Field = control::ConfigField<LineConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
    return {name, [](LineConfig& c) -> float& { return c.*M; }, lo, hi};
}
// JSON keys of a "line" template and the aiControllers.SetOption levers.
const control::CConfigTable<LineConfig> kTable({
    F<&LineConfig::withdrawScreenDelay>("withdraw_screen_delay", 0.f, 10.f),
    F<&LineConfig::withdrawRearDelay>("withdraw_rear_delay", -1.f, 10.f),
    F<&LineConfig::withdrawScreenCover>("withdraw_screen_cover", 0.f, 1.f),
    F<&LineConfig::advanceScreenDelay>("advance_screen_delay", 0.f, 10.f),
    F<&LineConfig::advanceRearDelay>("advance_rear_delay", -1.f, 10.f),
    F<&LineConfig::attackScreenDelay>("attack_screen_delay", 0.f, 10.f),
    F<&LineConfig::attackRearDelay>("attack_rear_delay", -1.f, 10.f),
    F<&LineConfig::holdDelay>("hold_delay", 0.f, 10.f),
    F<&LineConfig::orderMinSeconds>("order_min_seconds", 0.f, 30.f),
    F<&LineConfig::scriptOrderSeconds>("script_order_seconds", 0.f, 600.f),
    F<&LineConfig::orient>("orient", 0.f, 1.f),
    F<&LineConfig::headingDeadband>("heading_deadband", 0.f, 90.f),
    F<&LineConfig::threatRadius>("threat_radius", 200.f, 4000.f),
    F<&LineConfig::peerBand>("peer_band", 0.f, 1.f),
    F<&LineConfig::standShortShare>("stand_short_share", 0.f, 1.f),
    F<&LineConfig::spreadEnabled>("spread", 0.f, 1.f),
    F<&LineConfig::spreadCap>("spread_cap", 1.f, 4.f),
    F<&LineConfig::period>("period", 1.f, 300.f),
    F<&LineConfig::log>("log", 0.f, 1.f),
});
ranged::Point P(const springai::AIFloat3& p) { return {p.x, p.z}; }
}

CLineController::CLineController(CCircuitAI* ai) : ai(ai), trace(std::getenv("CIRCUIT_RANGED_TRACE") != nullptr) {}

int CLineController::ParseTemplate(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems)
{
    LineConfig config;
    kTable.Apply(config, resolved, {"type"}, problems);
    const int existing = TemplateIndex(name);
    if (existing >= 0) { templates[existing].config = config; return existing; }
    templates.push_back({name, config});
    return int(templates.size()) - 1;
}
int CLineController::TemplateIndex(const std::string& name) const
{
    for (std::size_t i = 0; i < templates.size(); ++i) if (templates[i].name == name) return int(i);
    return -1;
}
bool CLineController::SetTemplateOption(const std::string& name, const std::string& key, float value)
{
    const int index = TemplateIndex(name);
    return index >= 0 && kTable.Set(templates[index].config, key, value);
}
bool CLineController::Order(const std::string& name, const std::string& kind, const springai::AIFloat3& pos)
{
    const int index = TemplateIndex(name);
    if (index < 0) return false;
    line::Order order;
    if (kind == "hold") order = line::Order::HOLD;
    else if (kind == "advance") order = line::Order::ADVANCE;
    else if (kind == "attack") order = line::Order::ATTACK;
    else if (kind == "withdraw") order = line::Order::WITHDRAW;
    else if (kind == "release") order = line::Order::NONE;
    else return false;
    const int frame = ai->GetLastFrame();
    for (auto& [key, l] : lines) {
        if (l.tmpl != index) continue;
        l.script = order; l.scriptFrame = frame; l.scriptGoal = pos;
    }
    ai->LOG("LINE: script order template=%s kind=%s lines=%u", name.c_str(), kind.c_str(), unsigned(lines.size()));
    return true;
}
void CLineController::UnitRemoved(int unitId) { directives.erase(unitId); }

std::string CLineController::Describe(int lineKey) const
{
    const auto it = lines.find(lineKey);
    if (it == lines.end()) return "";
    const Line& l = it->second;
    const auto& c = l.composition;
    return std::string("order=") + line::Name(l.effective) + " screen=" + line::Name(l.screenStance)
        + " rear=" + line::Name(l.rearStance) + " short=" + std::to_string(c.count[0]) + " peer=" + std::to_string(c.count[1])
        + " long=" + std::to_string(c.count[2]) + " static=" + std::to_string(c.count[3]) + " comm=" + std::to_string(c.count[4])
        + " spread=" + std::to_string(l.spread);
}

void CLineController::Observe(Line& l, CRangedWorld& world, int frame)
{
    const auto& cohorts = world.Cohorts();
    const auto front = cohorts.find(l.key);
    if (front == cohorts.end() || front->second.members.empty()) return;
    const auto& plan = front->second;
    auto* leader = ai->GetTeamUnit(plan.members.front());
    if (leader == nullptr || leader->IsDead()) return;
    const CCircuitDef* def = leader->GetCircuitDef();
    const Template& t = templates[l.tmpl];
    // Centre from live member positions: the plan's centre is refreshed only
    // when a member decides, and this update may run between decisions.
    springai::AIFloat3 center; int counted = 0;
    for (int id : plan.members) {
        auto* u = ai->GetTeamUnit(id);
        if (u && !u->IsDead()) { center += u->GetPos(frame); ++counted; }
    }
    if (counted == 0) return;
    center *= 1.f / float(counted);
    l.screens = counted; l.screenSpeed = std::max(1.f, def->GetSpeed());
    l.partner = plan.formationPartner;
    l.rears = 0; l.separation = 0.f;
    if (l.partner >= 0) {
        const auto rear = cohorts.find(l.partner);
        if (rear != cohorts.end() && rear->second.formationPartner == l.key) {
            l.rears = int(rear->second.members.size());
            l.separation = rear->second.formationScreenOffset;
        } else l.partner = -1;
    }
    // Composition of armed hostiles near the line, from the shared snapshot.
    const float ownRange = def->GetMaxRange(CCircuitDef::RangeType::LAND);
    l.composition = line::Composition();
    world.Nearby(center, t.config.threatRadius, nearby);
    const auto& contacts = world.Contacts();
    for (int i : nearby) {
        const auto& c = contacts[i];
        if (!c.def || c.def->IsAbleToFly() || c.pos.y < -20.f) continue;
        const bool commander = c.def->IsEnemyRoleAny(CCircuitDef::COMM);
        if (!c.armed && !commander) continue;
        const line::Threat kind = line::Classify(c.mobile, commander, c.groundRange, ownRange, t.config.peerBand);
        l.composition.Add(kind, cohort::HealthValue(c.cost, c.health, c.def->GetHealth()), P(c.pos), world.MaxSplash(c.def));
    }
    if (t.config.orient > 0.f && l.composition.any) {
        const ranged::Point wanted = line::Facing(P(center), l.composition.Centroid());
        if (line::Reorient(l.facingSet ? l.facing : ranged::Point{0.f, 0.f}, wanted, t.config.headingDeadband)) {
            l.facing = wanted; l.facingSet = true;
        }
    }
    l.spread = t.config.spreadEnabled > 0.f ? line::Spread(l.composition.maxSplash, def->GetRangedPolicy().spacing, t.config.spreadCap) : 1.f;
    l.standFirm = line::StandFirm(l.composition, t.config.standShortShare);
    // The line's own order: the cohort's assessment.
    const line::Order internal = line::InternalOrder(int(plan.mode), plan.target >= 0, plan.committed);
    if (l.script != line::Order::NONE && frame - l.scriptFrame > int(t.config.scriptOrderSeconds * 30.f)) l.script = line::Order::NONE;
    const line::Order wanted = line::Effective(internal, l.script);
    const bool scripted = l.script != line::Order::NONE && line::Caution(l.script) > line::Caution(internal);
    l.internal = internal;
    if (l.effective == line::Order::NONE || line::Replace(l.effective, wanted, frame - l.orderFrame, int(t.config.orderMinSeconds * 30.f))) {
        if (wanted != l.effective) {
            const auto& c = l.composition;
            if (t.config.log > 0.f) ai->LOG("LINE: line=%i order=%s from=%s source=%s screens=%i rears=%i short=%i peer=%i long=%i static=%i comm=%i metal=%.0f facing=%.2f,%.2f spread=%.2f firm=%i frame=%i",
                l.key, line::Name(wanted), line::Name(l.effective), scripted ? "script" : "cohort",
                l.screens, l.rears, c.count[0], c.count[1], c.count[2], c.count[3], c.count[4], c.total, l.facing.x, l.facing.z, l.spread, int(l.standFirm), frame);
            l.effective = wanted; l.orderFrame = frame; l.scripted = scripted;
        }
    }
    Route(l, t, frame);
    Write(l, plan.members, line::Slot::SCREEN, l.screenStance);
    if (l.partner >= 0) Write(l, cohorts.at(l.partner).members, line::Slot::REAR, l.rearStance);
}

void CLineController::Route(Line& l, const Template& t, int frame)
{
    line::Routing routing;
    switch (l.effective) {
        case line::Order::WITHDRAW:
            routing = {t.config.withdrawScreenDelay, t.config.withdrawRearDelay, t.config.withdrawScreenCover > 0.f}; break;
        case line::Order::ADVANCE:
            routing = {t.config.advanceScreenDelay, t.config.advanceRearDelay, false}; break;
        case line::Order::ATTACK:
            routing = {t.config.attackScreenDelay, t.config.attackRearDelay, false}; break;
        case line::Order::HOLD:
            routing = {t.config.holdDelay, t.config.holdDelay, false}; break;
        default: break;
    }
    const int elapsed = frame - l.orderFrame;
    const int screenDelay = line::DelayFrames(routing.screenDelay, l.separation, l.screenSpeed);
    const int rearDelay = line::DelayFrames(routing.rearDelay, l.separation, l.screenSpeed);
    const line::Stance screen = line::StanceFor(l.effective, line::Slot::SCREEN, routing, elapsed, screenDelay);
    const line::Stance rear = line::StanceFor(l.effective, line::Slot::REAR, routing, elapsed, rearDelay);
    if (t.config.log > 0.f && (screen != l.screenStance || rear != l.rearStance))
        ai->LOG("LINE: line=%i order=%s screen=%s rear=%s elapsed=%i screen_delay=%i rear_delay=%i frame=%i",
            l.key, line::Name(l.effective), line::Name(screen), line::Name(rear), elapsed, screenDelay, rearDelay, frame);
    l.screenStance = screen; l.rearStance = rear;
}

void CLineController::Write(const Line& l, const std::vector<int>& members, line::Slot /*slot*/, line::Stance stance)
{
    for (int id : members) {
        auto& d = directives[id];
        d.stance = stance; d.order = l.effective; d.orderFrame = l.orderFrame;
        d.scripted = l.scripted; d.standFirm = l.standFirm;
        d.facingSet = l.facingSet; d.facing = l.facing; d.spread = l.spread;
        d.line = l.key; d.generation = generation;
    }
}

void CLineController::Update()
{
    if (templates.empty()) return;
    const int frame = ai->GetLastFrame();
    if (frame < nextFrame) return;
    auto* military = ai->GetMilitaryManager();
    if (military == nullptr || !military->HasRangedUnits()) { nextFrame = frame + 30; return; }
    performance::Scope measured(ai, performance::LINE_DECISION);
    auto world = military->GetRangedWorld();
    world->Refresh();  // idempotent per frame
    ++generation;
    int period = 300;
    for (const auto& [key, plan] : world->Cohorts()) {
        if (plan.members.empty()) continue;
        auto* leader = ai->GetTeamUnit(plan.members.front());
        if (leader == nullptr || leader->IsDead()) continue;
        const auto& policy = leader->GetCircuitDef()->GetRangedPolicy();
        if (policy.formationPosition != RangedPolicy::FormationPosition::FRONT) continue;
        const int tmpl = TemplateIndex(policy.formationFamily);
        if (tmpl < 0) continue;
        Line& l = lines[key];
        l.key = key; l.tmpl = tmpl; l.seen = frame;
        period = std::min(period, int(templates[tmpl].config.period));
        Observe(l, *world, frame);
    }
    for (auto it = lines.begin(); it != lines.end();) {
        if (it->second.seen != frame) it = lines.erase(it); else ++it;
    }
    for (auto it = directives.begin(); it != directives.end();) {
        if (it->second.generation != generation) it = directives.erase(it); else ++it;
    }
    nextFrame = frame + std::max(1, period);
}

} // namespace circuit
