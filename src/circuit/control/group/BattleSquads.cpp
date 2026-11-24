#include "control/group/BattleSquads.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "task/fighter/RangedWorld.h"
#include "task/fighter/RouteTask.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitDef.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "json/json.h"
#include "Log.h"

#include <algorithm>
#include <cmath>

namespace circuit {

using namespace springai;
using battle_group::Order;
using battle_group::Stance;

namespace {
ranged::Point P(const AIFloat3& p) { return {p.x, p.z}; }
bool Valid(const AIFloat3& p) { return p.x >= 0.f; }
const AIFloat3 NONE_POS(-1.f, 0.f, -1.f);

// One float lever: JSON key -> member, clamped to [lo, hi].
struct Lever { const char* key; float BattleSquadTemplate::* field; float lo, hi; };
const Lever LEVERS[] = {
    {"utility_ahead", &BattleSquadTemplate::utilityAhead, 0.f, 600.f},
    {"screen_ahead", &BattleSquadTemplate::screenAhead, 0.f, 600.f},
    {"spacing", &BattleSquadTemplate::spacing, 16.f, 300.f},
    {"row_width", &BattleSquadTemplate::rowWidth, 0.f, 2000.f},
    {"row_depth", &BattleSquadTemplate::rowDepth, 16.f, 300.f},
    {"range_fraction", &BattleSquadTemplate::rangeFraction, 0.3f, 1.f},
    {"screen_range_fraction", &BattleSquadTemplate::screenRangeFraction, 0.3f, 1.f},
    {"min_screen_distance", &BattleSquadTemplate::minScreenDistance, 0.f, 1000.f},
    {"threat_radius", &BattleSquadTemplate::threatRadius, 200.f, 5000.f},
    {"engage_radius", &BattleSquadTemplate::engageRadius, 200.f, 6000.f},
    {"static_weight", &BattleSquadTemplate::staticWeight, 0.f, 10.f},
    {"advantage_enter", &BattleSquadTemplate::advantageEnter, 0.1f, 10.f},
    {"advantage_exit", &BattleSquadTemplate::advantageExit, 0.f, 10.f},
    {"pace_step", &BattleSquadTemplate::paceStep, 32.f, 3000.f},
    {"pace_tolerance", &BattleSquadTemplate::paceTolerance, 32.f, 3000.f},
    {"wait_seconds", &BattleSquadTemplate::waitSeconds, 0.f, 600.f},
    {"repath", &BattleSquadTemplate::repath, 8.f, 1000.f},
    {"withdraw_step", &BattleSquadTemplate::withdrawStep, 64.f, 4000.f},
    {"withdraw_screen_delay", &BattleSquadTemplate::withdrawScreenDelay, 0.f, 20.f},
    {"withdraw_rear_delay", &BattleSquadTemplate::withdrawRearDelay, -1.f, 20.f},
    {"advance_rear_delay", &BattleSquadTemplate::advanceRearDelay, -1.f, 20.f},
    {"attack_rear_delay", &BattleSquadTemplate::attackRearDelay, -1.f, 20.f},
    {"order_min_seconds", &BattleSquadTemplate::orderMinSeconds, 0.f, 60.f},
    {"momentum_prior", &BattleSquadTemplate::momentumPrior, 1.f, 20000.f},
    {"momentum_half_life", &BattleSquadTemplate::momentumHalfLife, 1.f, 1800.f},
    {"momentum_press", &BattleSquadTemplate::momentumPress, 0.f, 2.f},
    {"momentum_caution", &BattleSquadTemplate::momentumCaution, 0.f, 2.f},
    {"momentum_fall_back", &BattleSquadTemplate::momentumFallBack, 0.f, 1.f},
    {"merge_radius", &BattleSquadTemplate::mergeRadius, 0.f, 6000.f},
    {"home_radius", &BattleSquadTemplate::homeRadius, 100.f, 6000.f},
    {"ghost_margin", &BattleSquadTemplate::ghostMargin, 0.f, 500.f},
    {"ghost_max_range", &BattleSquadTemplate::ghostMaxRange, 0.f, 5000.f},
    {"period", &BattleSquadTemplate::period, 0.5f, 30.f},
    {"log", &BattleSquadTemplate::log, 0.f, 1.f},
};
}

CBattleSquads::CBattleSquads(CCircuitAI* ai, CMilitaryManager* military) : ai(ai), military(military) {}

void CBattleSquads::ReadConfig(const Json::Value& root)
{
    templates.clear();
    const Json::Value& all = root["squad_formations"];
    if (!all.isObject()) return;
    for (const std::string& name : all.getMemberNames()) {
        const Json::Value& j = all[name];
        if (!j.isObject()) { ai->LOG("SQUAD: template %s is not an object", name.c_str()); continue; }
        BattleSquadTemplate t;
        t.name = name;
        for (const std::string& key : j.getMemberNames()) {
            const Json::Value& v = j[key];
            if (key == "screen" || key == "utility" || key == "artillery") {
                std::vector<int>& list = key == "screen" ? t.screen : (key == "utility" ? t.utility : t.artillery);
                if (!v.isArray()) { ai->LOG("SQUAD: %s.%s: not an array", name.c_str(), key.c_str()); continue; }
                for (const auto& unit : v) {
                    // Another faction's file may list types this game lacks: skipped quietly.
                    const CCircuitDef* def = unit.isString() ? ai->GetCircuitDef(unit.asCString()) : nullptr;
                    if (def != nullptr) list.push_back(def->GetId());
                }
                std::sort(list.begin(), list.end());
                list.erase(std::unique(list.begin(), list.end()), list.end());
                continue;
            }
            if (key == "break_size" && v.isNumeric()) { t.breakSize = std::clamp(v.asInt(), 0, 32); continue; }
            if (key == "size_max" && v.isNumeric()) { t.sizeMax = std::clamp(v.asInt(), 1, 64); continue; }
            bool known = false;
            for (const Lever& l : LEVERS) {
                if (key != l.key) continue;
                known = true;
                if (v.isNumeric()) t.*(l.field) = std::clamp(v.asFloat(), l.lo, l.hi);
                else ai->LOG("SQUAD: %s.%s: not a number", name.c_str(), key.c_str());
            }
            if (!known) ai->LOG("SQUAD: %s.%s: unknown key", name.c_str(), key.c_str());
        }
        ai->LOG("SQUAD: template %s screen=%u utility=%u artillery=%u break=%i max=%i",
            name.c_str(), unsigned(t.screen.size()), unsigned(t.utility.size()), unsigned(t.artillery.size()), t.breakSize, t.sizeMax);
        templates.push_back(std::move(t));
    }
}

int CBattleSquads::TemplateIndex(const std::string& name) const
{
    for (std::size_t i = 0; i < templates.size(); ++i) if (templates[i].name == name) return int(i);
    return -1;
}

// A listed type takes its list's rank; an unlisted one falls back by role:
// artillery to the back, support and anti-air in the middle, the rest in front.
CBattleSquads::Rank CBattleSquads::RankOf(const BattleSquadTemplate& t, const CCircuitDef* def) const
{
    const int id = def->GetId();
    if (std::binary_search(t.artillery.begin(), t.artillery.end(), id)) return Rank::ARTILLERY;
    if (std::binary_search(t.utility.begin(), t.utility.end(), id)) return Rank::UTILITY;
    if (std::binary_search(t.screen.begin(), t.screen.end(), id)) return Rank::SCREEN;
    if (def->IsRoleArty()) return Rank::ARTILLERY;
    if (def->IsRoleSupport() || def->IsRoleAA()) return Rank::UTILITY;
    return Rank::SCREEN;
}

int CBattleSquads::Create(const std::string& tmpl, const std::string& label, const AIFloat3& rally)
{
    const int index = TemplateIndex(tmpl);
    if (index < 0) return -1;
    Squad s;
    s.id = nextId++; s.tmpl = index; s.label = label; s.rally = rally; s.anchor = rally;
    s.created = ai->GetLastFrame();
    const AIFloat3& base = ai->GetSetupManager()->GetBasePos();
    s.forward = squad_formation::Toward(P(base), P(rally), {1.f, 0.f});
    ai->LOG("SQUAD: create squad=%i template=%s label=%s rally=%.0f,%.0f frame=%i",
        s.id, tmpl.c_str(), label.c_str(), rally.x, rally.z, s.created);
    squads.emplace(s.id, std::move(s));
    return nextId - 1;
}

bool CBattleSquads::Add(int squad, CCircuitUnit* unit)
{
    const auto it = squads.find(squad);
    if (it == squads.end() || unit == nullptr || unit->IsDead()) return false;
    Squad& s = it->second;
    const int id = unit->GetId();
    const auto old = squadOf.find(id);
    if (old != squadOf.end()) return old->second == squad;
    Member m;
    m.id = id; m.rank = RankOf(templates[s.tmpl], unit->GetCircuitDef()); m.joined = ai->GetLastFrame();
    s.members.push_back(m);
    squadOf[id] = squad;
    return true;
}

bool CBattleSquads::Launch(int squad)
{
    const auto it = squads.find(squad);
    if (it == squads.end()) return false;
    Squad& s = it->second;
    if (s.launched) return true;
    s.launched = true;
    s.nextFrame = 0;
    s.waitSince = -1;
    ai->LOG("SQUAD: launch squad=%i label=%s members=%u frame=%i", s.id, s.label.c_str(), unsigned(s.members.size()), ai->GetLastFrame());
    return true;
}

bool CBattleSquads::SetGoal(int squad, const AIFloat3& goal)
{
    const auto it = squads.find(squad);
    if (it == squads.end() || !std::isfinite(goal.x) || !std::isfinite(goal.z)) return false;
    it->second.goal = goal;
    return true;
}

bool CBattleSquads::Release(int squad, const char* why)
{
    if (squads.count(squad) == 0) return false;
    Drop(squad, why);
    return true;
}

// The squad's members go back to their ordinary tasks: the route ends, its
// units go idle and MakeTask finds them in no squad.
void CBattleSquads::Drop(int squadId, const char* why)
{
    const auto it = squads.find(squadId);
    if (it == squads.end()) return;
    CRouteTask* route = it->second.route;
    for (const Member& m : it->second.members) squadOf.erase(m.id);
    ai->LOG("SQUAD: release squad=%i label=%s members=%u why=%s killed=%.0f lost=%.0f frame=%i",
        squadId, it->second.label.c_str(), unsigned(it->second.members.size()), why,
        it->second.trades.killed, it->second.trades.lost, ai->GetLastFrame());
    squads.erase(it);
    if (route != nullptr && !route->IsDead()) military->AbortTask(route);
}

IUnitTask* CBattleSquads::TaskFor(CCircuitUnit* unit)
{
    if (unit == nullptr) return nullptr;
    const auto it = squadOf.find(unit->GetId());
    if (it == squadOf.end()) return nullptr;
    const auto s = squads.find(it->second);
    if (s == squads.end()) return nullptr;
    for (Member& m : s->second.members) if (m.id == unit->GetId()) m.sent = NONE_POS;  // re-sent on the next decision
    unit->TrySetFireState(CCircuitDef::FireType::OPEN);
    return EnsureRoute(s->second);
}

int CBattleSquads::SquadOf(int unitId) const
{
    const auto it = squadOf.find(unitId);
    return it == squadOf.end() ? -1 : it->second;
}

int CBattleSquads::Size(int squad) const
{
    const auto it = squads.find(squad);
    return it == squads.end() ? -1 : int(it->second.members.size());
}

int CBattleSquads::Armed(int squad) const
{
    const auto it = squads.find(squad);
    if (it == squads.end()) return -1;
    int armed = 0;
    for (const Member& m : it->second.members) if (m.rank != Rank::UTILITY) ++armed;
    return armed;
}

int CBattleSquads::AnyMember(int squad) const
{
    const auto it = squads.find(squad);
    if (it == squads.end()) return -1;
    int any = -1;
    for (const Member& m : it->second.members) {
        CCircuitUnit* unit = ai->GetTeamUnit(m.id);
        if (unit == nullptr || unit->IsDead()) continue;
        if (m.rank != Rank::UTILITY) return m.id;
        if (any < 0) any = m.id;
    }
    return any;
}

int CBattleSquads::OrderOf(int squad) const
{
    const auto it = squads.find(squad);
    return it == squads.end() ? -1 : int(it->second.order);
}

CRouteTask* CBattleSquads::EnsureRoute(Squad& s)
{
    if (s.route != nullptr && !s.route->IsDead()) return s.route;
    IFighterTask* task = military->Enqueue(TaskF::Common(IFighterTask::FightType::ROUTE));
    s.route = static_cast<CRouteTask*>(task);
    s.route->SetTraversal(false, 96.f, false);
    s.route->SetHoldPosition(true);   // they stand on their slots and fire at will; no chasing
    s.route->SetRoute({Valid(s.anchor) ? s.anchor : s.rally});
    for (Member& m : s.members) m.sent = NONE_POS;
    return s.route;
}

void CBattleSquads::TaskRemoved(IUnitTask* task)
{
    for (auto& [id, s] : squads) if (s.route == task) s.route = nullptr;
}

void CBattleSquads::UnitDestroyed(CCircuitUnit* unit, int frame)
{
    if (unit == nullptr) return;
    const auto it = squadOf.find(unit->GetId());
    if (it == squadOf.end()) return;
    const auto s = squads.find(it->second);
    squadOf.erase(it);
    if (s == squads.end()) return;
    Squad& q = s->second;
    const BattleSquadTemplate& t = templates[q.tmpl];
    trade::Loss(q.trades, unit->GetCircuitDef()->GetCostM(), frame, int(t.momentumHalfLife * FRAMES_PER_SEC));
    const auto gone = std::find_if(q.members.begin(), q.members.end(), [&](const Member& m) { return m.id == unit->GetId(); });
    if (gone == q.members.end()) return;
    // The field life per rank is the A/B measure: does the screen soak for the guns?
    if (t.log > 0.f) ai->LOG("SQUAD: lost squad=%i unit=%s %i rank=%s life=%i launched=%i left=%u frame=%i", q.id,
        unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), squad_formation::Name(gone->rank),
        (frame - gone->joined) / FRAMES_PER_SEC, int(q.launched), unsigned(q.members.size() - 1), frame);
    q.members.erase(gone);
}

void CBattleSquads::EnemyKilled(int attackerId, float metal, int frame)
{
    const auto it = squadOf.find(attackerId);
    if (it == squadOf.end()) return;
    const auto s = squads.find(it->second);
    if (s == squads.end()) return;
    trade::Kill(s->second.trades, metal, frame, int(templates[s->second.tmpl].momentumHalfLife * FRAMES_PER_SEC));
}

// Puts a member that a native default task took (the ranged engagement, an
// attack or defend squad, idle) back on the squad's route. Retreat, player
// orders and external control keep it for now; another script route (an air
// emergency, a spam lane) took it on purpose: it leaves the squad (false).
bool CBattleSquads::Claim(Squad& s, CCircuitUnit* unit)
{
    IUnitTask* task = unit->GetTask();
    if (task == nullptr || task->GetManager() != military) return true;
    const auto type = task->GetType();
    if (type == IUnitTask::Type::PLAYER || type == IUnitTask::Type::RETREAT || type == IUnitTask::Type::NIL
        || task->IsExternalControlled()) return true;
    CRouteTask* route = EnsureRoute(s);
    if (task == route) return true;
    if (type == IUnitTask::Type::FIGHTER
        && static_cast<IFighterTask*>(task)->GetFightType() == IFighterTask::FightType::ROUTE) return false;
    military->AssignTask(unit, route);
    unit->TrySetFireState(CCircuitDef::FireType::OPEN);
    return true;
}

float CBattleSquads::GhostDepth(const AIFloat3& p, float margin, float maxRange) const
{
    if (maxRange <= 0.f) return 0.f;
    float worst = 0.f;
    for (const auto& g : military->GetRangedWorld()->Ghosts()) {
        if (g.def == nullptr || !g.armed || g.groundRange <= 0.f || g.groundRange > maxRange) continue;
        const float depth = g.groundRange + margin - std::sqrt(p.SqDistance2D(g.pos));
        worst = std::max(worst, depth);
    }
    return worst;
}

// The height-aware distance from `target` at which `unit`'s longest ground
// weapon still reaches, standing along `dir` (target -> squad). O(weapons x 3).
float CBattleSquads::StandoffFor(CCircuitUnit* unit, const AIFloat3& target, ranged::Point dir, float fraction)
{
    auto world = military->GetRangedWorld();
    const auto& caps = world->CapabilitiesFor(unit->GetCircuitDef());
    const CRangedWorld::Weapon* best = nullptr;
    for (const auto& w : caps.weapons) if (w.range > 0.f && !w.fake && (best == nullptr || w.range > best->range)) best = &w;
    if (best == nullptr) return unit->GetCircuitDef()->GetMaxRange() * fraction;
    const float r = world->StandoffRange(*best, target, AIFloat3(dir.x, 0.f, dir.z), fraction);
    return r > 0.f ? r : best->range * fraction * .5f;
}

void CBattleSquads::MoveMembers(Squad& from, Squad& into, int frame)
{
    const BattleSquadTemplate& t = templates[into.tmpl];
    for (Member m : from.members) {
        CCircuitUnit* unit = ai->GetTeamUnit(m.id);
        if (unit == nullptr || unit->IsDead()) continue;
        m.rank = RankOf(t, unit->GetCircuitDef());
        m.sent = NONE_POS;
        into.members.push_back(m);
        squadOf[m.id] = into.id;
        Claim(into, unit);
    }
    from.members.clear();
    // The ledgers add up: the merged squad keeps both records.
    const int half = int(t.momentumHalfLife * FRAMES_PER_SEC);
    trade::Decay(from.trades, frame, half); trade::Decay(into.trades, frame, half);
    into.trades.killed += from.trades.killed; into.trades.lost += from.trades.lost;
}

// One merge per squad update: a broken squad joins the nearest squad of its
// template that takes it; two healthy squads out of a fight merge, the larger
// keeps its id (the lower id on a tie). O(S).
bool CBattleSquads::TryMerge(Squad& s, int frame)
{
    const BattleSquadTemplate& t = templates[s.tmpl];
    if (t.mergeRadius <= 0.f || !s.launched) return false;
    const AIFloat3 here = Valid(s.anchor) ? s.anchor : s.rally;
    int armed = 0;
    for (const Member& m : s.members) if (m.rank != Rank::UTILITY) ++armed;
    const bool broken = squad_formation::Broken(armed, t.breakSize);
    const bool fighting = s.order == Order::ATTACK;
    Squad* best = nullptr; float bestDistance = 0.f;
    for (auto& [id, o] : squads) {
        if (id == s.id || o.tmpl != s.tmpl || !o.launched || o.homeward || o.members.empty()) continue;
        const float d = here.SqDistance2D(Valid(o.anchor) ? o.anchor : o.rally);
        const float radius = broken ? t.mergeRadius * 2.f : t.mergeRadius;
        const bool oFighting = o.order == Order::ATTACK;
        if (!squad_formation::CanMerge(int(s.members.size()), int(o.members.size()), d, radius, t.sizeMax,
                broken ? false : fighting, broken ? false : oFighting)) continue;
        // A healthy pair merges into the larger squad only (so each pair merges once).
        if (!broken && (o.members.size() < s.members.size() || (o.members.size() == s.members.size() && o.id > s.id))) continue;
        if (best == nullptr || d < bestDistance) { best = &o; bestDistance = d; }
    }
    if (best == nullptr) return false;
    if (t.log > 0.f) ai->LOG("SQUAD: merge squad=%i into=%i members=%u+%u broken=%i frame=%i",
        s.id, best->id, unsigned(s.members.size()), unsigned(best->members.size()), int(broken), frame);
    MoveMembers(s, *best, frame);
    releases.emplace_back(s.id, "merged");
    return true;
}

void CBattleSquads::Update()
{
    if (squads.empty()) return;
    const int frame = ai->GetLastFrame();
    for (auto& [id, s] : squads) {
        if (frame < s.nextFrame) continue;
        s.nextFrame = frame + std::max(1, int(templates[s.tmpl].period * FRAMES_PER_SEC));
        Decide(s, frame);
    }
    // Releases change the squad map: applied once the loop is over.
    std::vector<std::pair<int, std::string>> done;
    done.swap(releases);
    for (const auto& [id, why] : done) Drop(id, why.c_str());
}

void CBattleSquads::Decide(Squad& s, int frame)
{
    const BattleSquadTemplate& t = templates[s.tmpl];
    // Prune members that are gone or no longer ours; claim strays back.
    AIFloat3 centre; int counted = 0, armed = 0;
    float own = 0.f;
    bool hasUtility = false, hasArtillery = false;
    for (auto it = s.members.begin(); it != s.members.end();) {
        CCircuitUnit* unit = ai->GetTeamUnit(it->id);
        if (unit == nullptr || unit->IsDead()) { squadOf.erase(it->id); it = s.members.erase(it); continue; }
        if (!Claim(s, unit)) {
            if (templates[s.tmpl].log > 0.f) ai->LOG("SQUAD: taken squad=%i unit=%i by another route frame=%i", s.id, it->id, frame);
            squadOf.erase(it->id); it = s.members.erase(it); continue;
        }
        if (frame - it->fireFrame >= 15 * FRAMES_PER_SEC) { unit->TrySetFireState(CCircuitDef::FireType::OPEN); it->fireFrame = frame; }
        centre += unit->GetPos(frame); ++counted;
        if (it->rank == Rank::UTILITY) hasUtility = true;
        else {
            ++armed;
            own += unit->GetCircuitDef()->GetCostM() * std::clamp(unit->GetHealthPercent(), 0.f, 1.f);
            if (it->rank == Rank::ARTILLERY) hasArtillery = true;
        }
        ++it;
    }
    if (counted == 0) {
        // A held squad waits for its first member; a launched one is gone.
        if (s.launched) releases.emplace_back(s.id, "destroyed");
        return;
    }
    centre *= 1.f / float(counted);
    s.rows = squad_formation::Stack(hasUtility, hasArtillery, t.utilityAhead, t.screenAhead);

    // Held at the rally until script launches it (the gather deadline).
    if (!s.launched) {
        s.order = Order::HOLD;
        s.anchor = s.rally;
        Place(s, t, nullptr, frame);
        return;
    }
    if (TryMerge(s, frame)) return;
    const AIFloat3& base = ai->GetSetupManager()->GetBasePos();
    if (!s.homeward && squad_formation::Broken(armed, t.breakSize)) {
        s.homeward = true;
        if (t.log > 0.f) ai->LOG("SQUAD: broken squad=%i armed=%i walks home frame=%i", s.id, armed, frame);
    }
    if (s.homeward && centre.SqDistance2D(base) < t.homeRadius * t.homeRadius) {
        releases.emplace_back(s.id, "home");
        return;
    }

    // The enemy near: armed ground contacts within threat_radius (metal x
    // health, structures weighted by static_weight), the target the nearest
    // armed one within engage_radius, else the nearest structure there.
    auto world = military->GetRangedWorld();
    world->Refresh();  // idempotent per frame
    world->Nearby(centre, std::max(t.threatRadius, t.engageRadius), nearby);
    const auto& contacts = world->Contacts();
    float hostile = 0.f, nearestArmed = 0.f, nearestOther = 0.f;
    int armedTarget = -1, otherTarget = -1;
    for (int i : nearby) {
        const auto& c = contacts[i];
        if (c.def == nullptr || c.def->IsAbleToFly() || c.pos.y < -20.f) continue;
        const float d = c.pos.SqDistance2D(centre);
        if (c.armed && d <= t.threatRadius * t.threatRadius) {
            const float health = c.def->GetHealth() > 0.f ? std::clamp(c.health / c.def->GetHealth(), 0.f, 1.f) : 1.f;
            hostile += c.cost * health * (c.mobile ? 1.f : t.staticWeight);
        }
        if (d > t.engageRadius * t.engageRadius) continue;
        if (c.armed) { if (armedTarget < 0 || d < nearestArmed) { armedTarget = i; nearestArmed = d; } }
        else if (!c.mobile) { if (otherTarget < 0 || d < nearestOther) { otherTarget = i; nearestOther = d; } }
    }
    const int targetIndex = armedTarget >= 0 ? armedTarget : otherTarget;
    s.target = targetIndex >= 0 ? contacts[targetIndex].id : -1;
    s.own = own; s.hostile = hostile;

    // Momentum and the order.
    const int half = int(t.momentumHalfLife * FRAMES_PER_SEC);
    trade::Decay(s.trades, frame, half);
    s.momentum = trade::Momentum(s.trades, t.momentumPrior);
    const float entryScale = trade::EntryScale(s.momentum, t.momentumPress, t.momentumCaution);
    const bool fallBack = trade::FallsBack(s.momentum, t.momentumFallBack);
    squad_formation::Balance balance{own, hostile, hostile > 0.f};
    Order wanted = squad_formation::Decide(balance, s.order, t.advantageEnter, t.advantageExit, entryScale, fallBack);
    if (wanted == Order::ADVANCE && targetIndex >= 0) wanted = Order::ATTACK;  // an unarmed structure in reach
    if (s.homeward) wanted = Order::WITHDRAW;
    if (s.order == Order::NONE || battle_group::Replace(s.order, wanted, frame - s.orderFrame, int(t.orderMinSeconds * FRAMES_PER_SEC))) {
        if (wanted != s.order) {
            if (t.log > 0.f) ai->LOG("SQUAD: order squad=%i label=%s %s->%s own=%.0f hostile=%.0f momentum=%.2f armed=%i members=%u target=%i frame=%i",
                s.id, s.label.c_str(), battle_group::Name(s.order), battle_group::Name(wanted), own, hostile, s.momentum, armed,
                unsigned(s.members.size()), s.target, frame);
            s.order = wanted; s.orderFrame = frame;
        }
    }
    const AIFloat3* target = (s.order == Order::ATTACK && targetIndex >= 0) ? &contacts[targetIndex].pos : nullptr;

    // The anchor: the artillery row (or the row of the rank behind the screen).
    const ranged::Point c2 = P(centre);
    if (target != nullptr) {
        s.forward = squad_formation::Toward(c2, P(*target), s.forward);
    } else if (s.order == Order::WITHDRAW) {
        // Facing stays toward the threat; the anchor walks back toward base.
        const ranged::Point home = squad_formation::Toward(c2, P(base), {-s.forward.x, -s.forward.z});
        const float step = s.homeward ? std::sqrt(centre.SqDistance2D(base)) : t.withdrawStep;
        s.anchor = AIFloat3(centre.x + home.x * std::min(step, t.withdrawStep * 2.f), 0.f, centre.z + home.z * std::min(step, t.withdrawStep * 2.f));
    } else if (s.order == Order::ADVANCE) {
        const AIFloat3 goal = Valid(s.goal) ? s.goal : s.anchor;
        if (!Valid(s.anchor)) s.anchor = centre;
        s.forward = squad_formation::Toward(P(s.anchor), P(goal), s.forward);
        // The slowest member's lag behind its place along the advance.
        float lag = 0.f;
        for (const Member& m : s.members) {
            if (!Valid(m.sent)) continue;
            CCircuitUnit* unit = ai->GetTeamUnit(m.id);
            if (unit == nullptr) continue;
            const AIFloat3& p = unit->GetPos(frame);
            lag = std::max(lag, (m.sent.x - p.x) * s.forward.x + (m.sent.z - p.z) * s.forward.z);
        }
        const bool lagging = lag > t.paceTolerance;
        if (!lagging) s.waitSince = -1; else if (s.waitSince < 0) s.waitSince = frame;
        const bool waitOver = lagging && frame - s.waitSince >= int(t.waitSeconds * FRAMES_PER_SEC);
        const float toGoal = std::sqrt(s.anchor.SqDistance2D(goal));
        const float step = squad_formation::AdvanceStep(toGoal, lag, t.paceTolerance, t.paceStep, waitOver);
        AIFloat3 next(s.anchor.x + s.forward.x * step, 0.f, s.anchor.z + s.forward.z * step);
        CTerrainManager::CorrectPosition(next);
        // Never step the utility or artillery rows into armed ghost reach; wait for sight there.
        const AIFloat3 rear(next.x + s.forward.x * s.rows.utility, 0.f, next.z + s.forward.z * s.rows.utility);
        const bool ghost = step > 0.f && std::max(GhostDepth(next, t.ghostMargin, t.ghostMaxRange),
            GhostDepth(rear, t.ghostMargin, t.ghostMaxRange)) > 0.f;
        if (ghost != s.ghostHeld && t.log > 0.f)
            ai->LOG("SQUAD: squad=%i %s ghost porc reach frame=%i", s.id, ghost ? "holds at" : "clear of", frame);
        s.ghostHeld = ghost;
        if (!ghost) s.anchor = next;
    }
    Place(s, t, target, frame);

    if (t.log > 0.f && frame >= s.nextLog) {
        s.nextLog = frame + 20 * FRAMES_PER_SEC;
        // Each rank's mean place along the axis to the enemy, from the centre: the
        // wanted order is screen > utility > artillery (O(M), once per 20 s).
        int ranks[3] = {}; float along[3] = {};
        for (const Member& m : s.members) {
            ++ranks[int(m.rank)];
            if (CCircuitUnit* u = ai->GetTeamUnit(m.id)) {
                const AIFloat3& p = u->GetPos(frame);
                along[int(m.rank)] += (p.x - centre.x) * s.forward.x + (p.z - centre.z) * s.forward.z;
            }
        }
        for (int r = 0; r < 3; ++r) if (ranks[r] > 0) along[r] /= float(ranks[r]);
        ai->LOG("SQUAD: status squad=%i label=%s order=%s screen=%i utility=%i artillery=%i along=%.0f/%.0f/%.0f own=%.0f hostile=%.0f momentum=%.2f killed=%.0f lost=%.0f anchor=%.0f,%.0f centre=%.0f,%.0f target=%i frame=%i",
            s.id, s.label.c_str(), battle_group::Name(s.order), ranks[0], ranks[1], ranks[2], along[0], along[1], along[2],
            own, hostile, s.momentum, s.trades.killed, s.trades.lost, s.anchor.x, s.anchor.z, centre.x, centre.z, s.target, frame);
    }
}

// Every member's slot: ranks in rows across the axis (sorted across it so
// nobody crosses the squad), the artillery each at its own reach when it
// attacks. A rank whose stance holds keeps its last slot (a withdrawal moves
// the rear first, the screen covers). O(M log M + M x W).
void CBattleSquads::Place(Squad& s, const BattleSquadTemplate& t, const AIFloat3* target, int frame)
{
    CRouteTask* route = EnsureRoute(s);
    const ranged::Point fwd = s.forward;
    const ranged::Point dir{-fwd.x, -fwd.z};  // target -> squad
    battle_group::Routing routing;
    switch (s.order) {
        case Order::WITHDRAW: routing = {t.withdrawScreenDelay, t.withdrawRearDelay, true}; break;
        case Order::ADVANCE: routing = {0.f, t.advanceRearDelay, false}; break;
        case Order::ATTACK: routing = {0.f, t.attackRearDelay, false}; break;
        default: break;
    }
    const int elapsed = s.orderFrame >= 0 ? frame - s.orderFrame : 0;
    const float speed = 60.f;  // the rear delay "-1" opens the separation at a T2 walking pace
    const int screenDelay = battle_group::DelayFrames(routing.screenDelay, t.screenAhead, speed);
    const int rearDelay = battle_group::DelayFrames(routing.rearDelay, t.screenAhead, speed);
    const Stance screenStance = battle_group::StanceFor(s.order, battle_group::Slot::SCREEN, routing, elapsed, screenDelay);
    const Stance rearStance = battle_group::StanceFor(s.order, battle_group::Slot::REAR, routing, elapsed, rearDelay);

    // Distances from the target of each row while attacking.
    float artilleryNearest = 0.f, screenReach = 0.f;
    std::unordered_map<int, float> reach;
    if (target != nullptr) {
        float nearest = -1.f, screen = -1.f;
        for (const Member& m : s.members) {
            if (m.rank == Rank::UTILITY) continue;
            CCircuitUnit* unit = ai->GetTeamUnit(m.id);
            if (unit == nullptr) continue;
            const float fraction = m.rank == Rank::ARTILLERY ? t.rangeFraction : t.screenRangeFraction;
            const float r = StandoffFor(unit, *target, dir, fraction);
            reach[m.id] = r;
            if (m.rank == Rank::ARTILLERY) nearest = nearest < 0.f ? r : std::min(nearest, r);
            else screen = screen < 0.f ? r : std::min(screen, r);
        }
        artilleryNearest = std::max(0.f, nearest);
        screenReach = std::max(0.f, screen);
        // The rows in front of the guns, never closer than min_screen_distance.
        if (nearest >= 0.f) {
            const float utility = std::max(t.minScreenDistance, artilleryNearest - s.rows.utility);
            const float front = std::max(t.minScreenDistance * .5f, artilleryNearest - s.rows.screen);
            s.anchor = AIFloat3(target->x + dir.x * artilleryNearest, 0.f, target->z + dir.z * artilleryNearest);
            s.rows.utility = artilleryNearest - utility;
            s.rows.screen = artilleryNearest - front;
        } else {
            // No artillery: the screen fights at its own reach, the utility behind it.
            const float front = std::max(t.minScreenDistance * .5f, screenReach);
            const float back = front + (s.rows.screen - s.rows.utility);
            s.anchor = AIFloat3(target->x + dir.x * back, 0.f, target->z + dir.z * back);
        }
        CTerrainManager::CorrectPosition(s.anchor);
    }
    if (!Valid(s.anchor)) s.anchor = s.rally;

    const int perRow = squad_formation::PerRow(t.rowWidth, t.spacing);
    const auto* area = ai->GetTerrainManager()->GetAreaData();
    for (int r = 0; r < int(Rank::COUNT); ++r) {
        const Rank rank = Rank(r);
        const Stance stance = rank == Rank::SCREEN ? screenStance : rearStance;
        const bool moves = !(stance == Stance::HOLD || stance == Stance::COVER) || s.order == Order::HOLD || !s.launched;
        // Members of this rank, across the axis (left to right), ties by id.
        struct Item { Member* m; float lateral; CCircuitUnit* unit; };
        std::vector<Item> items;
        for (Member& m : s.members) {
            if (m.rank != rank) continue;
            CCircuitUnit* unit = ai->GetTeamUnit(m.id);
            if (unit == nullptr || unit->GetTask() != route) continue;
            const AIFloat3& p = unit->GetPos(frame);
            items.push_back({&m, -(p.x - s.anchor.x) * fwd.z + (p.z - s.anchor.z) * fwd.x, unit});
        }
        if (items.empty()) continue;
        std::sort(items.begin(), items.end(), [](const Item& a, const Item& b) {
            return a.lateral != b.lateral ? a.lateral < b.lateral : a.m->id < b.m->id;
        });
        const float ahead = rank == Rank::SCREEN ? s.rows.screen : (rank == Rank::UTILITY ? s.rows.utility : s.rows.artillery);
        const ranged::Point rowCentre{s.anchor.x + fwd.x * ahead, s.anchor.z + fwd.z * ahead};
        for (int i = 0; i < int(items.size()); ++i) {
            Member& m = *items[i].m;
            if (!moves && Valid(m.sent)) continue;
            ranged::Point slot = squad_formation::RowSlot(rowCentre, fwd, i, int(items.size()), t.spacing, perRow, t.rowDepth);
            if (target != nullptr && rank == Rank::ARTILLERY) {
                // Each gun at its own reach along the axis, its lateral place kept.
                const auto it = reach.find(m.id);
                const float extra = it != reach.end() ? it->second - artilleryNearest : 0.f;
                slot.x -= fwd.x * extra; slot.z -= fwd.z * extra;
            }
            AIFloat3 point(slot.x, 0.f, slot.z);
            CTerrainManager::CorrectPosition(point);
            point.y = area->GetElevationAt(point.x, point.z);
            if (Valid(m.sent) && m.sent.SqDistance2D(point) < t.repath * t.repath) continue;
            if (route->SetUnitRoute(items[i].unit, {point}, rank == Rank::SCREEN ? 32.f : 48.f)) m.sent = point;
        }
    }
}

} // namespace circuit
