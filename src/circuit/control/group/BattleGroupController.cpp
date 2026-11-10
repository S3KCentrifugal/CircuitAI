#include "control/group/BattleGroupController.h"
#include "control/kernel/GroupLayout.h"
#include "module/FactoryManager.h"
#include "module/MilitaryManager.h"
#include "task/fighter/RangedWorld.h"
#include "task/static/RecruitTask.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "util/Performance.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

#include <algorithm>
#include <cstdlib>

namespace circuit {

namespace {
using Field = control::ConfigField<BattleGroupConfig>;
template <auto M> Field F(const char* name, float lo, float hi) {
    return {name, [](BattleGroupConfig& c) -> float& { return c.*M; }, lo, hi};
}
// JSON keys of a "battle_group" template and the aiControllers.SetOption levers.
const control::CConfigTable<BattleGroupConfig> kTable({
    F<&BattleGroupConfig::withdrawScreenDelay>("withdraw_screen_delay", 0.f, 10.f),
    F<&BattleGroupConfig::withdrawRearDelay>("withdraw_rear_delay", -1.f, 10.f),
    F<&BattleGroupConfig::withdrawScreenCover>("withdraw_screen_cover", 0.f, 1.f),
    F<&BattleGroupConfig::advanceScreenDelay>("advance_screen_delay", 0.f, 10.f),
    F<&BattleGroupConfig::advanceRearDelay>("advance_rear_delay", -1.f, 10.f),
    F<&BattleGroupConfig::attackScreenDelay>("attack_screen_delay", 0.f, 10.f),
    F<&BattleGroupConfig::attackRearDelay>("attack_rear_delay", -1.f, 10.f),
    F<&BattleGroupConfig::holdDelay>("hold_delay", 0.f, 10.f),
    F<&BattleGroupConfig::orderMinSeconds>("order_min_seconds", 0.f, 30.f),
    F<&BattleGroupConfig::scriptOrderSeconds>("script_order_seconds", 0.f, 600.f),
    F<&BattleGroupConfig::orient>("orient", 0.f, 1.f),
    F<&BattleGroupConfig::headingDeadband>("heading_deadband", 0.f, 90.f),
    F<&BattleGroupConfig::threatRadius>("threat_radius", 200.f, 4000.f),
    F<&BattleGroupConfig::peerBand>("peer_band", 0.f, 1.f),
    F<&BattleGroupConfig::standShortShare>("stand_short_share", 0.f, 1.f),
    F<&BattleGroupConfig::spreadEnabled>("spread", 0.f, 1.f),
    F<&BattleGroupConfig::spreadCap>("spread_cap", 1.f, 4.f),
    F<&BattleGroupConfig::period>("period", 1.f, 300.f),
    F<&BattleGroupConfig::log>("log", 0.f, 1.f),
    // D-501: group size and cohesion (control/group/GroupRegistry.h)
    F<&BattleGroupConfig::sizeMin>("size_min", 1.f, float(group_layout::MAX_GROUP_SIZE)),
    F<&BattleGroupConfig::sizeTarget>("size_target", 0.f, float(group_layout::MAX_GROUP_SIZE)),
    F<&BattleGroupConfig::sizeMax>("size_max", 1.f, float(group_layout::MAX_GROUP_SIZE)),
    F<&BattleGroupConfig::joinSeekRadius>("join_seek_radius", 0.f, 6000.f),
    F<&BattleGroupConfig::recruitSeconds>("recruit_seconds", 0.5f, 60.f),
    F<&BattleGroupConfig::strayRadius>("stray_radius", 0.f, 4000.f),
    F<&BattleGroupConfig::straySeconds>("stray_seconds", 1.f, 120.f),
    F<&BattleGroupConfig::splitLink>("split_link", 0.f, 2000.f),
    F<&BattleGroupConfig::recallSize>("recall_size", 0.f, float(group_layout::MAX_GROUP_SIZE)),  // D-504
    F<&BattleGroupConfig::homeRadius>("home_radius", 0.f, 8000.f),  // D-504
    // D-509: anti-air escorts (control/kernel/AirDefence.h)
    F<&BattleGroupConfig::airRadius>("air_radius", 0.f, 6000.f),
    F<&BattleGroupConfig::airKillSeconds>("air_kill_seconds", 1.f, 120.f),
    F<&BattleGroupConfig::airMemorySeconds>("air_memory_seconds", 0.f, 300.f),
    F<&BattleGroupConfig::escortBehind>("escort_behind", 0.f, 1000.f),
    F<&BattleGroupConfig::escortSpacing>("escort_spacing", 16.f, 256.f),
    // D-512: trade momentum (control/kernel/TradeMomentum.h)
    F<&BattleGroupConfig::momentumPrior>("momentum_prior", 1.f, 10000.f),
    F<&BattleGroupConfig::momentumHalfLife>("momentum_half_life", 1.f, 1200.f),
    // D-514: the repair crew (control/kernel/RepairCrew.h)
    F<&BattleGroupConfig::crewBehind>("crew_behind", 0.f, 1000.f),
    F<&BattleGroupConfig::crewSpacing>("crew_spacing", 16.f, 256.f),
    F<&BattleGroupConfig::tripHealth>("repair_trip_health", 0.f, 1.f),
    F<&BattleGroupConfig::tripDone>("repair_trip_done", 0.f, 1.f),
    F<&BattleGroupConfig::tripSeconds>("repair_trip_seconds", 1.f, 600.f),
});
// D-509: the template rank whose types are anti-air escorts.
constexpr const char* AIR_RANK = "air";
// D-514: the template rank whose types are the repair crew (resurrection bots).
constexpr const char* REPAIR_RANK = "repair";
constexpr float PER_UNITS_MAX = 100.f;
// D-514: member health for the repair trip is read at most this often.
constexpr int TRIP_CHECK_FRAMES = FRAMES_PER_SEC;
// D-501: a template rank's max is bounded like the group size.
constexpr int RANK_MAX = group_layout::MAX_GROUP_SIZE;
constexpr float PER_SCREEN_MAX = 4.f;
// One cohort class per template and formation position (SetCohortClasses).
constexpr int CLASSES_PER_TEMPLATE = 4;
ranged::Point P(const springai::AIFloat3& p) { return {p.x, p.z}; }
}

CBattleGroupController::CBattleGroupController(CCircuitAI* ai) : ai(ai), trace(std::getenv("CIRCUIT_RANGED_TRACE") != nullptr), registry(ai)
{
    registry.SetTrips(&tripOf);  // D-514: both members of this object; the map outlives every Tick
}

// D-501: "ranks": {"screen": {"roles": [...], "units": [...], "max": n, "per_screen": f}, "support": {...}}.
// screen is the front cohort, support the rear (CGroupRegistry::RankName).
void CBattleGroupController::ParseRanks(Template& t, const Json::Value& ranks, std::vector<std::string>& problems) const
{
    t.ranks.clear();
    if (ranks.isNull()) return;
    if (!ranks.isObject()) { problems.push_back(t.name + ".ranks: not an object"); return; }
    const auto& roleNames = CCircuitDef::GetRoleNames();
    for (const std::string& name : ranks.getMemberNames()) {
        const Json::Value& r = ranks[name];
        if (name != "screen" && name != "support" && name != AIR_RANK && name != REPAIR_RANK) { problems.push_back(t.name + ".ranks." + name + ": unknown rank (screen, support, air, repair)"); continue; }
        if (!r.isObject()) { problems.push_back(t.name + ".ranks." + name + ": not an object"); continue; }
        group_composition::RankSpec spec;
        spec.name = name;
        for (const std::string& key : r.getMemberNames()) {
            const Json::Value& v = r[key];
            if (key == "roles" && v.isArray()) {
                for (const auto& role : v) {
                    const auto it = roleNames.find(role.asString());
                    if (it == roleNames.end()) problems.push_back(t.name + ".ranks." + name + ": unknown role " + role.asString());
                    else spec.roleMask |= it->second.mask;
                }
            } else if (key == "units" && v.isArray()) {
                for (const auto& unit : v) {
                    const CCircuitDef* def = ai->GetCircuitDef(unit.asCString());
                    if (def == nullptr) problems.push_back(t.name + ".ranks." + name + ": unknown unit " + unit.asString());
                    else spec.defs.push_back(def->GetId());
                }
            } else if (key == "max" && v.isNumeric()) {
                spec.max = std::clamp(v.asInt(), 0, RANK_MAX);
            } else if (key == "per_screen" && v.isNumeric()) {
                spec.perScreen = std::clamp(v.asFloat(), 0.f, PER_SCREEN_MAX);
            } else if (key == "per_units" && v.isNumeric() && name == REPAIR_RANK) {
                spec.perUnits = std::clamp(v.asFloat(), 0.f, PER_UNITS_MAX);
            } else problems.push_back(t.name + ".ranks." + name + "." + key + ": unknown or wrong type");
        }
        std::sort(spec.defs.begin(), spec.defs.end());
        t.ranks.push_back(std::move(spec));
    }
}

const GroupSpec* CBattleGroupController::SpecFor(const CCircuitDef* def) const
{
    const int index = TemplateIndex(def->GetRangedPolicy().formationFamily);
    return index < 0 ? nullptr : &templates[index].spec;
}

// D-501: the types each template rank admits share a cohort class, so the
// cohort world lets them join one cohort. A rank with neither roles nor
// units gives no class: its types join only their own type (D-430).
// O(D x T) over the unit defs, once after a template parse.
void CBattleGroupController::PushClasses(CRangedWorld& world)
{
    classesDirty = false;
    std::unordered_map<const CCircuitDef*, int> classes;
    for (const CCircuitDef& def : ai->GetCircuitDefs()) {
        const auto& policy = def.GetRangedPolicy();
        if (policy.formationFamily.empty() || policy.formationPosition == RangedPolicy::FormationPosition::NONE) continue;
        const int index = TemplateIndex(policy.formationFamily);
        if (index < 0) continue;
        const auto* rank = group_composition::Find(templates[index].ranks, CGroupRegistry::RankName(policy.formationPosition));
        if (rank == nullptr || (rank->roleMask == 0 && rank->defs.empty())) continue;
        if (!group_composition::Admits(*rank, def.GetId(), def.GetRoleMask())) continue;
        classes[&def] = index * CLASSES_PER_TEMPLATE + int(policy.formationPosition);
    }
    world.SetCohortClasses(std::move(classes));
}

int CBattleGroupController::ParseTemplate(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems)
{
    Template t;
    t.name = name;
    kTable.Apply(t.config, resolved, {"type", "ranks"}, problems);
    ParseRanks(t, resolved["ranks"], problems);
    classesDirty = true;
    const int existing = TemplateIndex(name);
    if (existing >= 0) { templates[existing] = std::move(t); return existing; }
    templates.push_back(std::move(t));
    return int(templates.size()) - 1;
}
int CBattleGroupController::TemplateIndex(const std::string& name) const
{
    for (std::size_t i = 0; i < templates.size(); ++i) if (templates[i].name == name) return int(i);
    return -1;
}
bool CBattleGroupController::SetTemplateOption(const std::string& name, const std::string& key, float value)
{
    const int index = TemplateIndex(name);
    return index >= 0 && kTable.Set(templates[index].config, key, value);
}
bool CBattleGroupController::Order(const std::string& name, const std::string& kind, const springai::AIFloat3& pos)
{
    const int index = TemplateIndex(name);
    if (index < 0) return false;
    battle_group::Order order;
    if (kind == "hold") order = battle_group::Order::HOLD;
    else if (kind == "advance") order = battle_group::Order::ADVANCE;
    else if (kind == "attack") order = battle_group::Order::ATTACK;
    else if (kind == "withdraw") order = battle_group::Order::WITHDRAW;
    else if (kind == "release") order = battle_group::Order::NONE;
    else return false;
    const int frame = ai->GetLastFrame();
    for (auto& [key, l] : groups) {
        if (l.tmpl != index) continue;
        l.script = order; l.scriptFrame = frame; l.scriptGoal = pos;
    }
    ai->LOG("GROUP: script order template=%s kind=%s groups=%u", name.c_str(), kind.c_str(), unsigned(groups.size()));
    return true;
}
void CBattleGroupController::UnitRemoved(int unitId)
{
    directives.erase(unitId); registry.UnitRemoved(unitId); escorts.erase(unitId); crewMembers.erase(unitId);
    // D-514: a member that dies on its repair trip frees the trip at once.
    if (const auto trip = tripOf.find(unitId); trip != tripOf.end()) {
        if (const auto g = groups.find(trip->second); g != groups.end() && g->second.tripUnit == unitId) g->second.tripUnit = -1;
        tripOf.erase(trip);
    }
}

std::string CBattleGroupController::Describe(int groupKey) const
{
    const auto it = groups.find(groupKey);
    if (it == groups.end()) return "";
    const Group& l = it->second;
    const auto& c = l.composition;
    return std::string("order=") + battle_group::Name(l.effective) + " screen=" + battle_group::Name(l.screenStance)
        + " rear=" + battle_group::Name(l.rearStance) + " short=" + std::to_string(c.count[0]) + " peer=" + std::to_string(c.count[1])
        + " long=" + std::to_string(c.count[2]) + " static=" + std::to_string(c.count[3]) + " comm=" + std::to_string(c.count[4])
        + " spread=" + std::to_string(l.spread);
}

std::vector<CBattleGroupController::GroupView> CBattleGroupController::Snapshot() const
{
    std::vector<GroupView> out;
    out.reserve(groups.size());
    for (const auto& [key, l] : groups) {
        GroupView v;
        v.key = l.key; v.partner = l.partner;
        v.templateName = (l.tmpl >= 0 && l.tmpl < int(templates.size())) ? templates[l.tmpl].name : std::string();
        v.effective = l.effective; v.script = l.script; v.internal = l.internal;
        v.screenStance = l.screenStance; v.rearStance = l.rearStance;
        v.spread = l.spread; v.separation = l.separation;
        v.facing = l.facing; v.facingSet = l.facingSet;
        v.scripted = l.scripted; v.standFirm = l.standFirm;
        v.screens = l.screens; v.rears = l.rears;
        v.orderFrame = l.orderFrame; v.seen = l.seen; v.why = l.why;
        v.airNeed = l.airNeed; v.airCap = l.airCap; v.escorts = l.escorts; v.airHeld = l.airHeld;
        v.momentum = l.momentum; v.killed = l.trades.killed; v.lost = l.trades.lost;
        if (l.tmpl >= 0 && l.tmpl < int(templates.size()) && templates[l.tmpl].spec.Enabled()) {
            const auto& t = templates[l.tmpl];
            const auto* screen = group_composition::Find(t.ranks, "screen");
            v.sizeTarget = group_composition::Target(screen, t.spec.size);
            v.sizeMax = group_composition::Max(screen, t.spec.size);
        }
        v.composition = l.composition;
        for (const auto& [id, e] : escorts) if (e.group == l.key) v.escortIds.push_back(id);  // O(E), on request only
        v.crewNeed = l.crewNeed; v.tripUnit = l.tripUnit;
        for (const auto& [id, e] : crewMembers) if (e.group == l.key) v.crewIds.push_back(id);  // O(C), on request only
        out.push_back(std::move(v));
    }
    return out;
}

// D-509: the least anti-air DPS among the air rank's types (0: no air rank):
// the conservative figure, so a group never plans on more than it gets. O(R).
float CBattleGroupController::EscortDps(const Template& t) const
{
    const auto* rank = group_composition::Find(t.ranks, AIR_RANK);
    if (rank == nullptr) return 0.f;
    float least = 0.f;
    for (int id : rank->defs) {
        const CCircuitDef* def = ai->GetCircuitDefSafe(id);
        const float dps = def ? def->GetAirDps() : 0.f;
        if (dps > 0.f) least = least > 0.f ? std::min(least, dps) : dps;
    }
    return least;
}

// D-509: armed enemy air within air_radius of the screen, its HP held over
// air_memory_seconds, and the escorts that answer it (air_defence::Need).
// One bounded contact query per group update, O(K) for K contacts in reach.
void CBattleGroupController::ObserveAir(Group& l, const Template& t, CRangedWorld& world, const springai::AIFloat3& center, int frame)
{
    const auto* rank = group_composition::Find(t.ranks, AIR_RANK);
    if (rank == nullptr) { l.airNeed = 0; l.airCap = 0; l.airHeld = 0.f; return; }
    const BattleGroupConfig& c = t.config;
    float health = 0.f;
    world.Nearby(center, c.airRadius, airNearby);
    const auto& contacts = world.Contacts();
    for (int i : airNearby) {
        const auto& e = contacts[i];
        if (!e.def || !e.def->IsAbleToFly() || !e.armed) continue;
        if (e.pos.SqDistance2D(center) > c.airRadius * c.airRadius) continue;
        health += e.health;
    }
    l.airHeld = air_defence::Held(l.airMemory, health, frame, int(c.airMemorySeconds * FRAMES_PER_SEC));
    l.airCap = air_defence::Cap(l.screens, rank->perScreen, rank->max);
    l.airNeed = air_defence::Need(l.airHeld, EscortDps(t), c.airKillSeconds, l.airCap);
}

// D-509: every escort rides with a group. One surplus escort per update moves
// to a group short of escorts (no churn); an escort without a group takes the
// nearest group short of escorts, else the nearest group with an air rank
// (it stays with the army). Then each group's escorts, in id order, get
// their slots. O(E x G) for E escorts and G groups, once per update.
void CBattleGroupController::AssignEscorts(int frame)
{
    airDeficit = 0; airUnassigned = 0;
    for (auto& [key, l] : groups) { l.escorts = 0; l.escortIndex = 0; }
    for (auto& [id, e] : escorts) {
        const auto g = e.group >= 0 ? groups.find(e.group) : groups.end();
        if (g == groups.end() || g->second.airCap <= 0) { e.group = -1; continue; }
        ++g->second.escorts;
    }
    const auto shortOf = [](const Group& l) { return l.airNeed - l.escorts; };
    bool anyShort = false;
    for (const auto& [key, l] : groups) anyShort = anyShort || shortOf(l) > 0;
    if (anyShort) {
        for (auto it = escorts.rbegin(); it != escorts.rend(); ++it) {
            if (it->second.group < 0) continue;
            Group& from = groups.at(it->second.group);
            if (from.escorts <= from.airNeed) continue;
            --from.escorts; it->second.group = -1;
            break;
        }
    }
    for (auto& [id, e] : escorts) {
        if (e.group >= 0) continue;
        CCircuitUnit* unit = ai->GetTeamUnit(id);
        if (unit == nullptr || unit->IsDead()) continue;
        const ranged::Point pos = P(unit->GetPos(frame));
        int best = -1, nearest = -1; float bestDistance = 0.f, nearestDistance = 0.f;
        for (const auto& [key, l] : groups) {
            if (l.airCap <= 0) continue;
            const float d = ranged::DistanceSq(pos, l.escortCenter);
            if (shortOf(l) > 0 && (best < 0 || d < bestDistance)) { best = key; bestDistance = d; }
            if (nearest < 0 || d < nearestDistance) { nearest = key; nearestDistance = d; }
        }
        e.group = best >= 0 ? best : nearest;
        if (e.group >= 0) ++groups.at(e.group).escorts;
    }
    for (const auto& [key, l] : groups) airDeficit += std::max(0, shortOf(l));
    for (auto& [id, e] : escorts) {
        if (e.group < 0) { ++airUnassigned; continue; }
        Group& l = groups.at(e.group);
        const BattleGroupConfig& c = templates[l.tmpl].config;
        e.slot = air_defence::Slot(l.escortCenter, l.escortBack, l.rearDepth, c.escortBehind, l.escortIndex++, l.escorts, c.escortSpacing);
    }
}

CBattleGroupController::Group* CBattleGroupController::GroupOf(int unitId)
{
    int key = -1;
    if (const auto d = directives.find(unitId); d != directives.end()) key = d->second.group;
    else if (const auto e = escorts.find(unitId); e != escorts.end()) key = e->second.group;
    const auto g = key >= 0 ? groups.find(key) : groups.end();
    return g == groups.end() ? nullptr : &g->second;
}
void CBattleGroupController::RecordKill(int attackerId, float metal, int frame)
{
    if (Group* l = GroupOf(attackerId))
        trade::Kill(l->trades, metal, frame, int(templates[l->tmpl].config.momentumHalfLife * FRAMES_PER_SEC));
}
void CBattleGroupController::RecordLoss(int unitId, float metal, int frame)
{
    if (Group* l = GroupOf(unitId))
        trade::Loss(l->trades, metal, frame, int(templates[l->tmpl].config.momentumHalfLife * FRAMES_PER_SEC));
}

bool CBattleGroupController::HasAirGroups() const
{
    for (const auto& [key, l] : groups) if (l.airCap > 0) return true;
    return false;
}
// D-514: a join counts as unassigned at once, so a burst of idle bots between
// two updates is not leased past the shortfall (WantsCrew).
void CBattleGroupController::CrewJoin(int unitId)
{
    if (crewMembers.emplace(unitId, Escort{}).second) ++crewUnassigned;
}
void CBattleGroupController::CrewLeave(int unitId) { crewMembers.erase(unitId); }
bool CBattleGroupController::CrewPoint(int unitId, springai::AIFloat3& station, int& group) const
{
    const auto it = crewMembers.find(unitId);
    if (it == crewMembers.end() || it->second.group < 0) return false;
    station = springai::AIFloat3(it->second.slot.x, 0.f, it->second.slot.z);
    group = it->second.group;
    return true;
}
const std::vector<CBattleGroupController::MemberHealth>* CBattleGroupController::CrewPatients(int group) const
{
    const auto g = groups.find(group);
    return g == groups.end() ? nullptr : &g->second.patients;
}
bool CBattleGroupController::CrewUnderFire(int group) const
{
    const auto g = groups.find(group);
    return g != groups.end() && g->second.composition.any;
}
int CBattleGroupController::CrewTrip(int group) const
{
    const auto g = groups.find(group);
    return g == groups.end() ? -1 : g->second.tripUnit;
}
bool CBattleGroupController::RepairTrip(int unitId, springai::AIFloat3& point) const
{
    const auto trip = tripOf.find(unitId);
    if (trip == tripOf.end()) return false;
    const auto g = groups.find(trip->second);
    if (g == groups.end() || g->second.tripUnit != unitId) return false;
    point = g->second.station;
    return true;
}

// D-514: every bot serves at most one group. A group whose need fell keeps
// its bots up to the need; the rest, and bots with no group, take the nearest
// group short of crew, else stay unassigned (the rezzer controller hands them
// back to ordinary builder work after its release_seconds: no hoarding).
// Stations are a row crew_behind elmos behind the screen's rear edge.
// O(C x G) for C bots and G groups, once per update.
void CBattleGroupController::AssignCrew(int frame)
{
    crewDeficit = 0; crewUnassigned = 0;
    for (auto& [key, l] : groups) { l.crew = 0; l.crewIndex = 0; }
    for (auto& [id, e] : crewMembers) {
        const auto g = e.group >= 0 ? groups.find(e.group) : groups.end();
        if (g == groups.end() || g->second.crew >= g->second.crewKeep) { e.group = -1; continue; }
        ++g->second.crew;
    }
    for (auto& [id, e] : crewMembers) {
        if (e.group >= 0) continue;
        CCircuitUnit* unit = ai->GetTeamUnit(id);
        if (unit == nullptr || unit->IsDead()) continue;
        const ranged::Point pos = P(unit->GetPos(frame));
        // The nearest group short of its need, else the nearest still allowed
        // to keep one more (a leased bot is used before it is released).
        int best = -1, kept = -1; float bestDistance = 0.f, keptDistance = 0.f;
        for (const auto& [key, l] : groups) {
            if (l.crew >= l.crewKeep) continue;
            const float d = ranged::DistanceSq(pos, l.escortCenter);
            if (l.crew < l.crewNeed && (best < 0 || d < bestDistance)) { best = key; bestDistance = d; }
            if (kept < 0 || d < keptDistance) { kept = key; keptDistance = d; }
        }
        if (best < 0) best = kept;
        e.group = best;
        if (best >= 0) ++groups.at(best).crew;
    }
    for (const auto& [key, l] : groups) crewDeficit += std::max(0, l.crewNeed - l.crew);
    for (auto& [id, e] : crewMembers) {
        if (e.group < 0) { ++crewUnassigned; continue; }
        Group& l = groups.at(e.group);
        const BattleGroupConfig& c = templates[l.tmpl].config;
        e.slot = air_defence::Slot(l.escortCenter, l.escortBack, l.rearDepth, c.crewBehind, l.crewIndex++, l.crew, c.crewSpacing);
    }
    for (auto& [key, l] : groups) {
        const ranged::Point centre = air_defence::Slot(l.escortCenter, l.escortBack, l.rearDepth,
            templates[l.tmpl].config.crewBehind, 0, 1, 0.f);
        l.station = springai::AIFloat3(centre.x, 0.f, centre.z);
        if (l.crew == 0 && l.tripUnit >= 0) EndTrip(l, "no_crew", frame);
    }
}

void CBattleGroupController::EndTrip(Group& l, const char* why, int frame)
{
    if (l.tripUnit < 0) return;
    if (templates[l.tmpl].config.log > 0.f)
        ai->LOG("GROUP: repair trip end group=%i unit=%i why=%s seconds=%.0f frame=%i",
            l.key, l.tripUnit, why, float(frame - l.tripFrame) / FRAMES_PER_SEC, frame);
    tripOf.erase(l.tripUnit);
    l.tripUnit = -1;
}

// D-514: one member at a time walks back to the crew for repair: the lowest
// health under repair_trip_health, never while the cohort holds a rush (D-513)
// and never the last screen. It rejoins at repair_trip_done, when it leaves
// the group, or after repair_trip_seconds (then it may not go again for as
// long). Health is read for the screen and support once a second: O(M).
void CBattleGroupController::Rotate(Group& l, const Template& t, const std::vector<int>& screen, const std::vector<int>* rear, bool holding, int frame)
{
    const auto* rank = group_composition::Find(t.ranks, REPAIR_RANK);
    if (rank == nullptr) { l.crewNeed = 0; l.crewKeep = 0; l.patients.clear(); EndTrip(l, "no_rank", frame); return; }
    const int members = int(screen.size() + (rear ? rear->size() : 0));
    l.crewNeed = repair_crew::Need(members, rank->perUnits, rank->max);
    l.crewKeep = repair_crew::Keep(members, rank->perUnits, rank->max);
    if (l.checkFrame >= 0 && frame - l.checkFrame < TRIP_CHECK_FRAMES) return;
    l.checkFrame = frame;
    l.patients.clear();
    const auto read = [&](const std::vector<int>& ids) {
        for (int id : ids) {
            CCircuitUnit* u = ai->GetTeamUnit(id);
            if (u != nullptr && !u->IsDead()) l.patients.push_back({id, u->GetHealthPercent()});
        }
    };
    read(screen);
    if (rear != nullptr) read(*rear);
    const BattleGroupConfig& c = t.config;
    if (l.tripUnit >= 0) {
        const auto it = std::find_if(l.patients.begin(), l.patients.end(), [&](const MemberHealth& m) { return m.id == l.tripUnit; });
        if (it == l.patients.end()) EndTrip(l, "left", frame);
        else if (repair_crew::TripDone(it->health, c.tripDone)) EndTrip(l, "healed", frame);
        else if (frame - l.tripFrame > int(c.tripSeconds * FRAMES_PER_SEC)) {
            l.tripBlocked[l.tripUnit] = frame + int(c.tripSeconds * FRAMES_PER_SEC);
            EndTrip(l, "timeout", frame);
        }
    }
    for (auto it = l.tripBlocked.begin(); it != l.tripBlocked.end();) {
        if (it->second <= frame) it = l.tripBlocked.erase(it); else ++it;
    }
    if (l.tripUnit >= 0 || l.crew == 0 || holding || screen.size() < 2) return;
    std::vector<repair_crew::Candidate> candidates;
    candidates.reserve(l.patients.size());
    for (const MemberHealth& m : l.patients) if (!l.tripBlocked.count(m.id)) candidates.push_back({m.id, m.health});
    const int chosen = repair_crew::ChooseTrip(candidates, c.tripHealth);
    if (chosen < 0) return;
    l.tripUnit = chosen; l.tripFrame = frame;
    tripOf[chosen] = l.key;
    if (c.log > 0.f) {
        const auto it = std::find_if(l.patients.begin(), l.patients.end(), [&](const MemberHealth& m) { return m.id == chosen; });
        ai->LOG("GROUP: repair trip start group=%i unit=%i health=%.2f crew=%i station=%.0f,%.0f frame=%i",
            l.key, chosen, it != l.patients.end() ? it->health : 0.f, l.crew, l.station.x, l.station.z, frame);
    }
}

void CBattleGroupController::EscortJoin(int unitId) { escorts.emplace(unitId, Escort{}); }
void CBattleGroupController::EscortLeave(int unitId) { escorts.erase(unitId); }
bool CBattleGroupController::EscortPoint(int unitId, springai::AIFloat3& point, int& group) const
{
    const auto it = escorts.find(unitId);
    if (it == escorts.end() || it->second.group < 0) return false;
    point = springai::AIFloat3(it->second.slot.x, 0.f, it->second.slot.z);
    group = it->second.group;
    return true;
}

CCircuitDef* CBattleGroupController::AirRequest(const CCircuitDef* factoryDef) const
{
    return RankRequest(factoryDef, AIR_RANK, airDeficit, airUnassigned);
}
CCircuitDef* CBattleGroupController::CrewRequest(const CCircuitDef* factoryDef) const
{
    return RankRequest(factoryDef, REPAIR_RANK, crewDeficit, crewUnassigned);
}

// D-509, D-514: shared by the escort and crew requests. O(R + Q) for R rank
// types and Q factory tasks, on a factory decision only.
CCircuitDef* CBattleGroupController::RankRequest(const CCircuitDef* factoryDef, const char* rankName, int deficit, int unassigned) const
{
    if (factoryDef == nullptr || deficit <= 0) return nullptr;
    const auto rankType = [this, rankName](const CCircuitDef* def) {
        if (def == nullptr) return false;
        for (const Template& t : templates) {
            const auto* rank = group_composition::Find(t.ranks, rankName);
            if (rank && std::binary_search(rank->defs.begin(), rank->defs.end(), def->GetId())) return true;
        }
        return false;
    };
    int inProduction = 0;  // queued or being built
    for (const CRecruitTask* task : ai->GetFactoryManager()->GetTasks())
        if (!task->IsDead() && rankType(task->GetBuildDef())) ++inProduction;
    if (air_defence::Request(deficit, unassigned, inProduction) <= 0) return nullptr;
    const int frame = ai->GetLastFrame();
    for (const Template& t : templates) {
        const auto* rank = group_composition::Find(t.ranks, rankName);
        if (rank == nullptr) continue;
        for (int id : rank->defs) {
            CCircuitDef* def = ai->GetCircuitDefSafe(id);
            if (def && factoryDef->CanBuild(def) && def->IsAvailable(frame)) return def;
        }
    }
    return nullptr;
}

void CBattleGroupController::Observe(Group& l, CRangedWorld& world, int frame)
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
    // Composition of armed hostiles near the battle group, from the shared snapshot.
    const float ownRange = def->GetMaxRange(CCircuitDef::RangeType::LAND);
    l.composition = battle_group::Composition();
    world.Nearby(center, t.config.threatRadius, nearby);
    const auto& contacts = world.Contacts();
    for (int i : nearby) {
        const auto& c = contacts[i];
        if (!c.def || c.def->IsAbleToFly() || c.pos.y < -20.f) continue;
        const bool commander = c.def->IsEnemyRoleAny(CCircuitDef::COMM);
        if (!c.armed && !commander) continue;
        const battle_group::Threat kind = battle_group::Classify(c.mobile, commander, c.groundRange, ownRange, t.config.peerBand);
        l.composition.Add(kind, cohort::HealthValue(c.cost, c.health, c.def->GetHealth()), P(c.pos), world.MaxSplash(c.def));
    }
    if (plan.backToHelp) {
        // D-510: a retreat toward help turns the rows to its axis (the plan's
        // back points at the help), past the heading deadband as any turn.
        const ranged::Point wanted = P(plan.back);
        if (!l.facingSet || battle_group::Reorient(l.facing, wanted, t.config.headingDeadband)) { l.facing = wanted; l.facingSet = true; }
    } else if (t.config.orient > 0.f && l.composition.any) {
        const ranged::Point wanted = battle_group::Facing(P(center), l.composition.Centroid());
        if (battle_group::Reorient(l.facingSet ? l.facing : ranged::Point{0.f, 0.f}, wanted, t.config.headingDeadband)) {
            l.facing = wanted; l.facingSet = true;
        }
    } else if (!l.composition.any) {
        // D-502: nothing hostile near: the cohort's own travel axis (along its
        // lane) orients the rows again, perpendicular to the push. The last
        // threat's facing used to persist and turned a marching line sideways.
        l.facingSet = false;
    }
    l.spread = t.config.spreadEnabled > 0.f ? battle_group::Spread(l.composition.maxSplash, def->GetRangedPolicy().spacing, t.config.spreadCap) : 1.f;
    l.standFirm = battle_group::StandFirm(l.composition, t.config.standShortShare);
    // D-509: the escort geometry (the axis away from the enemy, the screen's
    // rear edge along it) and the air near the screen. O(M + K_air).
    ranged::Point back = l.facingSet ? l.facing : P(plan.back);
    if (back.x == 0.f && back.z == 0.f) back = {1.f, 0.f};
    float rear = 0.f;
    for (int id : plan.members) {
        auto* u = ai->GetTeamUnit(id);
        if (u == nullptr || u->IsDead()) continue;
        const auto p = u->GetPos(frame);
        rear = std::max(rear, (p.x - center.x) * back.x + (p.z - center.z) * back.z);
    }
    l.escortCenter = P(center); l.escortBack = back; l.rearDepth = rear;
    ObserveAir(l, t, world, center, frame);
    // D-514: the crew need and the one-at-a-time repair trip. O(M) once a second.
    Rotate(l, t, plan.members, l.partner >= 0 ? &cohorts.at(l.partner).members : nullptr, plan.holdFrame >= 0, frame);
    // D-512: the trade momentum, to both cohorts' plans. O(1).
    trade::Decay(l.trades, frame, int(t.config.momentumHalfLife * FRAMES_PER_SEC));
    l.momentum = trade::Momentum(l.trades, t.config.momentumPrior);
    world.SetCohortMomentum(l.key, l.momentum);
    if (l.partner >= 0) world.SetCohortMomentum(l.partner, l.momentum);
    // The battle group's own order: the cohort's assessment.
    const battle_group::Order internal = battle_group::InternalOrder(int(plan.mode), plan.target >= 0, plan.committed);
    if (l.script != battle_group::Order::NONE && frame - l.scriptFrame > int(t.config.scriptOrderSeconds * 30.f)) l.script = battle_group::Order::NONE;
    const battle_group::Order wanted = battle_group::Effective(internal, l.script);
    const bool scripted = l.script != battle_group::Order::NONE && battle_group::Caution(l.script) > battle_group::Caution(internal);
    l.internal = internal;
    if (l.effective == battle_group::Order::NONE || battle_group::Replace(l.effective, wanted, frame - l.orderFrame, int(t.config.orderMinSeconds * 30.f))) {
        if (wanted != l.effective) {
            const auto& c = l.composition;
            if (t.config.log > 0.f) ai->LOG("GROUP: group=%i order=%s from=%s source=%s screens=%i rears=%i short=%i peer=%i long=%i static=%i comm=%i metal=%.0f facing=%.2f,%.2f spread=%.2f firm=%i cover=%i reason=%i frame=%i",
                l.key, battle_group::Name(wanted), battle_group::Name(l.effective), scripted ? "script" : "cohort",
                l.screens, l.rears, c.count[0], c.count[1], c.count[2], c.count[3], c.count[4], c.total, l.facing.x, l.facing.z, l.spread, int(l.standFirm),
                int(plan.jammerCover), int(plan.reason), frame);
            l.effective = wanted; l.orderFrame = frame; l.scripted = scripted;
        }
    }
    // D-508: the order's factors for the unit monitor (Route adds STAGGERED).
    l.why = 0;
    if (l.scripted) l.why |= why::Of(why::group::SCRIPT_ORDER);
    if (wanted != l.effective) l.why |= why::Of(why::group::ORDER_HELD);
    if (l.standFirm) l.why |= why::Of(why::group::STAND_FIRM);
    if (l.airNeed > 0) l.why |= why::Of(why::group::AIR_THREAT);
    if (l.tripUnit >= 0) l.why |= why::Of(why::group::REPAIR_TRIP);  // D-514
    Route(l, t, frame);
    Write(l, plan.members, battle_group::Slot::SCREEN, l.screenStance);
    if (l.partner >= 0) Write(l, cohorts.at(l.partner).members, battle_group::Slot::REAR, l.rearStance);
}

void CBattleGroupController::Route(Group& l, const Template& t, int frame)
{
    battle_group::Routing routing;
    switch (l.effective) {
        case battle_group::Order::WITHDRAW:
            routing = {t.config.withdrawScreenDelay, t.config.withdrawRearDelay, t.config.withdrawScreenCover > 0.f}; break;
        case battle_group::Order::ADVANCE:
            routing = {t.config.advanceScreenDelay, t.config.advanceRearDelay, false}; break;
        case battle_group::Order::ATTACK:
            routing = {t.config.attackScreenDelay, t.config.attackRearDelay, false}; break;
        case battle_group::Order::HOLD:
            routing = {t.config.holdDelay, t.config.holdDelay, false}; break;
        default: break;
    }
    const int elapsed = frame - l.orderFrame;
    const int screenDelay = battle_group::DelayFrames(routing.screenDelay, l.separation, l.screenSpeed);
    const int rearDelay = battle_group::DelayFrames(routing.rearDelay, l.separation, l.screenSpeed);
    const battle_group::Stance screen = battle_group::StanceFor(l.effective, battle_group::Slot::SCREEN, routing, elapsed, screenDelay);
    const battle_group::Stance rear = battle_group::StanceFor(l.effective, battle_group::Slot::REAR, routing, elapsed, rearDelay);
    if (t.config.log > 0.f && (screen != l.screenStance || rear != l.rearStance))
        ai->LOG("GROUP: group=%i order=%s screen=%s rear=%s elapsed=%i screen_delay=%i rear_delay=%i frame=%i",
            l.key, battle_group::Name(l.effective), battle_group::Name(screen), battle_group::Name(rear), elapsed, screenDelay, rearDelay, frame);
    l.screenStance = screen; l.rearStance = rear;
    if (l.partner >= 0 && screen != rear) l.why |= why::Of(why::group::STAGGERED);
}

void CBattleGroupController::Write(const Group& l, const std::vector<int>& members, battle_group::Slot /*slot*/, battle_group::Stance stance)
{
    for (int id : members) {
        auto& d = directives[id];
        d.stance = stance; d.order = l.effective; d.orderFrame = l.orderFrame;
        d.scripted = l.scripted; d.standFirm = l.standFirm;
        d.facingSet = l.facingSet; d.facing = l.facing; d.spread = l.spread;
        d.group = l.key; d.generation = generation;
    }
}

void CBattleGroupController::Update()
{
    if (templates.empty()) return;
    const int frame = ai->GetLastFrame();
    if (frame < nextFrame) return;
    auto* military = ai->GetMilitaryManager();
    if (military == nullptr || !military->HasRangedUnits()) {
        // No screen or support hull is left: every battle group is gone. Drop
        // them (and their directives) now, and release the escorts, so the
        // air request falls to zero and escorts return to their ordinary
        // tasks. Returning before this kept the last groups: their air
        // shortfall had every T1 bot lab build anti-air bots without end, and
        // escorts stayed bound to dead slots (D-509 correction). O(G + E).
        if (!groups.empty() || !directives.empty()) { groups.clear(); directives.clear(); }
        tripOf.clear();
        AssignEscorts(frame);
        AssignCrew(frame);  // D-514: the crew goes unassigned and back to builder work
        nextFrame = frame + 30;
        return;
    }
    performance::Scope measured(ai, performance::BATTLE_GROUP_DECISION);
    auto world = military->GetRangedWorld();
    world->Refresh();  // idempotent per frame
    ++generation;
    // D-501: membership first, so this update's directives see the groups it leaves.
    bool registryOn = false;
    for (Template& t : templates) {
        const auto& c = t.config;
        const int sizeMax = std::max(1, int(c.sizeMax));
        t.spec.size = {std::clamp(int(c.sizeMin), 1, sizeMax), std::min(int(c.sizeTarget), sizeMax), sizeMax};
        t.spec.ranks = &t.ranks;
        t.spec.joinSeekRadius = c.joinSeekRadius; t.spec.recruitSeconds = c.recruitSeconds;
        t.spec.strayRadius = c.strayRadius; t.spec.straySeconds = c.straySeconds; t.spec.splitLink = c.splitLink;
        t.spec.recallSize = int(c.recallSize); t.spec.homeRadius = c.homeRadius;
        registryOn = registryOn || t.spec.Enabled();
    }
    if (classesDirty) PushClasses(*world);
    if (registryOn) registry.Tick(*world, frame, [this](const CCircuitDef* def) { return SpecFor(def); });
    int period = 300;
    for (const auto& [key, plan] : world->Cohorts()) {
        if (plan.members.empty()) continue;
        auto* leader = ai->GetTeamUnit(plan.members.front());
        if (leader == nullptr || leader->IsDead()) continue;
        const auto& policy = leader->GetCircuitDef()->GetRangedPolicy();
        if (policy.formationPosition != RangedPolicy::FormationPosition::FRONT) continue;
        const int tmpl = TemplateIndex(policy.formationFamily);
        if (tmpl < 0) continue;
        Group& l = groups[key];
        l.key = key; l.tmpl = tmpl; l.seen = frame;
        period = std::min(period, int(templates[tmpl].config.period));
        Observe(l, *world, frame);
    }
    for (auto it = groups.begin(); it != groups.end();) {
        if (it->second.seen != frame) it = groups.erase(it); else ++it;
    }
    for (auto it = directives.begin(); it != directives.end();) {
        if (it->second.generation != generation) it = directives.erase(it); else ++it;
    }
    for (auto it = tripOf.begin(); it != tripOf.end();) {  // D-514: trips of groups that are gone
        const auto g = groups.find(it->second);
        if (g == groups.end() || g->second.tripUnit != it->first) it = tripOf.erase(it); else ++it;
    }
    AssignEscorts(frame);
    AssignCrew(frame);
    nextFrame = frame + std::max(1, period);
}

} // namespace circuit
