#include "task/fighter/AssaultMicro.h"
#include "task/UnitTask.h"
#include "task/fighter/FighterTask.h"
#include "unit/CircuitUnit.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "terrain/TerrainManager.h"
#include "spring/SpringMap.h"
#include "util/GameAttribute.h"
#include "util/Utils.h"
#include "CircuitAI.h"

#include "Log.h"
#include "UnitDef.h"
#include "WeaponDef.h"
#include "Damage.h"

#include <memory>

#include <algorithm>
#include <cmath>
#include <cstdlib>

namespace circuit {

using namespace springai;

namespace {
// Owner 2026-11-08: Pulsar, Bulwark, Bastion, Persecutor, Rattlesnake, Eviscerator.
const char* const HEAVY_PORC[] = {"armanni", "cordoom", "legbastion", "cortoast", "armamb", "legacluster"};
constexpr int TICK = 15;                        // run cadence (frames)
constexpr int HOLD_FRAMES = TICK * 2 + 2;       // gate outlives one missed run
constexpr float RESEND_DIST = 24.f;             // a goal this close is the same order
constexpr int RESEND_FRAMES = FRAMES_PER_SEC * 2;
// Hold at a heavy porc edge at most this long, then let the task steer again
// (if it walks back in, the reach test pulls the hull out and holds anew).
constexpr int EDGE_HOLD_FRAMES = FRAMES_PER_SEC * 30;

inline float Dist2(const AIFloat3& a, const AIFloat3& b) { return SQUARE(a.x - b.x) + SQUARE(a.z - b.z); }
inline AIFloat3 Away(const AIFloat3& from, const AIFloat3& to)
{
    AIFloat3 d(to.x - from.x, 0.f, to.z - from.z);
    const float len = std::sqrt(d.x * d.x + d.z * d.z);
    return len > 1.f ? AIFloat3(d.x / len, 0.f, d.z / len) : AIFloat3(1.f, 0.f, 0.f);
}
const char* ModeName(int m)
{
    static const char* const names[] = {"none", "superior", "equal", "deficient", "porc"};
    return (m >= 0 && m < 5) ? names[m] : "?";
}
}

CAssaultMicro::CAssaultMicro(CCircuitAI* circuit) : circuit(circuit) {}

bool CAssaultMicro::InPorc(const AIFloat3& p, float margin) const
{
    for (int i : heavy) {
        const Enemy& h = enemies[i];
        if (Dist2(p, h.pos) < SQUARE(h.reach + margin)) return true;
    }
    return false;
}

float CAssaultMicro::BlastOf(CCircuitDef* def)
{
    auto [it, fresh] = blastByDef.try_emplace(def->GetId(), 0.f);
    if (fresh) {
        // Same measure as the old ranged controller: the death explosion's
        // area of effect when it does any damage.
        const std::unique_ptr<WeaponDef> explosion(def->GetDef()->GetDeathExplosion());
        if (explosion) {
            const std::unique_ptr<Damage> damage(explosion->GetDamage());
            const auto types = damage ? damage->GetTypes() : std::vector<float>{};
            if (std::any_of(types.begin(), types.end(), [](float v) { return v > 0.f; }))
                it->second = explosion->GetAreaOfEffect();
        }
    }
    return it->second;
}

void CAssaultMicro::Snapshot(int frame)
{
    if (!heavyResolved) {
        heavyResolved = true;
        for (const char* name : HEAVY_PORC) if (CCircuitDef* d = circuit->GetCircuitDef(name)) heavyDefs.insert(d->GetId());
    }
    enemies.clear(); heavy.clear(); friends.clear();
    for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
        const CEnemyUnit* e = kv.second;
        CCircuitDef* def = e ? e->GetCircuitDef() : nullptr;
        // Unidentified radar dots have no cost or reach: not counted.
        if (def == nullptr || e->IsFake() || e->IsDead() || e->IsDying() || e->IsHidden()) continue;
        if (def->IsAbleToFly() || !def->IsAttacker()) continue;
        const AIFloat3& at = e->GetPos();
        if (!std::isfinite(at.x) || !std::isfinite(at.z) || at.y < -20.f) continue;  // submerged: out of our reach
        const bool mobile = def->IsMobile();
        // A mobile contact out of radar and LOS has a stale position; a
        // structure stays where it was last seen until the spot is seen empty.
        if (mobile && !e->IsInRadarOrLOS()) continue;
        const float reach = def->GetMaxRange(CCircuitDef::RangeType::LAND);
        if (!mobile && reach <= 0.f) continue;
        Enemy en;
        en.pos = at; en.cost = def->GetCostM(); en.reach = reach; en.radius = e->GetRadius();
        en.heavy = !mobile && heavyDefs.count(def->GetId()) > 0;
        en.comm = mobile && def->IsRoleComm();
        if (en.comm) en.blast = BlastOf(def);
        // Heavy porc nanoframes are avoided too (assisted frames finish in
        // seconds); only finished units count as metal or anchor the cadence.
        en.counts = !e->IsBeingBuilt();
        en.target = en.counts && !en.heavy;
        if (!en.counts && !en.heavy) continue;
        if (en.heavy) heavy.push_back(int(enemies.size()));
        enemies.push_back(en);
    }
    // Allied AI hulls of the six types, every BARb AI of this ally team.
    for (CCircuitAI* ai : circuit->GetGameAttribute()->GetCircuits()) {
        if (ai == nullptr || !ai->IsInitialized() || ai->GetAllyTeamId() != circuit->GetAllyTeamId()) continue;
        for (const auto& kv : ai->GetTeamUnits()) {
            CCircuitUnit* u = kv.second;
            if (u == nullptr || u->IsDead() || !u->IsFinished()) continue;
            CCircuitDef* d = u->GetCircuitDef();
            if (d == nullptr || !d->GetAssaultPolicy().enabled) continue;
            friends.push_back({u->GetPos(frame), d->GetCostM()});
        }
    }
}

void CAssaultMicro::Issue(CCircuitUnit* unit, State& s, const AIFloat3& target, int frame, bool urgent)
{
    AIFloat3 goal = target;
    CTerrainManager::CorrectPosition(goal);
    goal.y = circuit->GetMap()->GetElevationAt(goal.x, goal.z);
    if (!urgent && s.goal.x >= 0.f && Dist2(goal, s.goal) < SQUARE(RESEND_DIST) && frame - s.moveFrame < RESEND_FRAMES) return;
    unit->SetMicroIssuing(true);
    TRY_UNIT(circuit, unit,
        unit->CmdMoveTo(goal, 0, frame + FRAMES_PER_SEC * 10);
    )
    unit->SetMicroIssuing(false);
    s.goal = goal; s.moveFrame = frame;
    ++cntMoves;
}

void CAssaultMicro::Release(CCircuitUnit* unit, State& s, int frame)
{
    if (!s.owned) return;
    s.owned = false;
    s.mode = Mode::NONE;
    s.goal = AIFloat3(-1.f, 0.f, -1.f);
    unit->SetMicroUntil(-1);
    if (s.prevMove >= 0) {
        unit->TrySetMoveState(CCircuitDef::MoveT(s.prevMove));
        s.prevMove = -1;
    }
    unit->ForceUpdate(frame);  // the task re-sends its orders on its next update
    ++cntRelease;
}

void CAssaultMicro::Update()
{
    const int frame = circuit->GetLastFrame();
    static const bool trace = std::getenv("CIRCUIT_ASSAULT_TRACE") != nullptr;
    bool any = false;
    for (const auto& kv : circuit->GetTeamUnits()) {
        CCircuitDef* d = kv.second->GetCircuitDef();
        if (d != nullptr && d->GetAssaultPolicy().enabled) { any = true; break; }
    }
    if (!any) { states.clear(); return; }
    Snapshot(frame);

    std::vector<std::pair<float, int>> local;
    std::unordered_set<int> alive;
    for (const auto& kv : circuit->GetTeamUnits()) {
        CCircuitUnit* unit = kv.second;
        CCircuitDef* def = unit->GetCircuitDef();
        if (def == nullptr) continue;
        const AssaultPolicy& p = def->GetAssaultPolicy();
        if (!p.enabled || unit->IsDead() || !unit->IsFinished()) continue;
        alive.insert(unit->GetId());
        State& s = states[unit->GetId()];
        // Fire at will always (owner 2026-11-08), owned or not.
        if (unit->GetRequestedFireState() != CCircuitDef::FireType::OPEN) unit->TrySetFireState(CCircuitDef::FireType::OPEN);
        IUnitTask* task = unit->GetTask();
        if (task == nullptr || task->GetType() != IUnitTask::Type::FIGHTER || task->IsExternalControlled()) {
            if (s.owned) { s.owned = false; s.mode = Mode::NONE; s.prevMove = -1; unit->SetMicroUntil(-1); }
            continue;
        }
        const float range = def->GetMaxRange(CCircuitDef::RangeType::LAND);
        if (range <= 0.f) continue;
        ++cntUnits;
        const AIFloat3 pos = unit->GetPos(frame);
        const float radiusSq = SQUARE(p.radius);

        float ally = 0.f, enemy = 0.f;
        for (const Friend& f : friends) if (Dist2(pos, f.pos) <= radiusSq) ally += f.cost;
        local.clear();
        for (int i = 0; i < int(enemies.size()); ++i) {
            const Enemy& e = enemies[i];
            const float d2 = Dist2(pos, e.pos);
            if (d2 > radiusSq) continue;
            if (e.counts) enemy += e.cost;   // heavy porc is enemy static defence too
            if (e.target) local.emplace_back(d2, i);
        }

        // Heavy porc reach over our own ground: leave it, whatever the odds.
        int deepest = -1; float depth = 0.f;
        for (int i : heavy) {
            const Enemy& h = enemies[i];
            const float edge = h.reach + p.porcMargin;
            const float d = std::sqrt(Dist2(pos, h.pos));
            if (d < edge && edge - d > depth) { depth = edge - d; deepest = i; }
        }
        auto take = [&](Mode m) {
            if (!s.owned) {
                s.owned = true;
                s.prevMove = unit->GetRequestedMoveState();
                unit->TrySetMoveState(CCircuitDef::MoveType::HOLD_POS);  // no engine chase past our goal
                s.outUntil = -1;
                s.holdSince = frame;
            }
            if (m != s.mode && trace) {
                circuit->LOG("[AssaultMicro] f=%d unit=%d %s %s->%s ally=%.0f enemy=%.0f range=%.0f",
                    frame, unit->GetId(), def->GetDef()->GetName(), ModeName(int(s.mode)), ModeName(int(m)), ally, enemy, range);
            }
            s.mode = m;
            unit->SetMicroUntil(frame + HOLD_FRAMES);
        };
        if (deepest >= 0) {
            const Enemy& h = enemies[deepest];
            AIFloat3 goal = h.pos + Away(h.pos, pos) * (h.reach + p.porcMargin + 32.f);
            // Out of one disc into another: step further along the same line.
            for (int k = 0; k < 3 && InPorc(goal, p.porcMargin); ++k) goal += Away(h.pos, pos) * 128.f;
            take(Mode::PORC);
            ++cntPorc;
            Issue(unit, s, goal, frame, s.goal.x < 0.f || Dist2(goal, s.goal) > SQUARE(RESEND_DIST));
            continue;
        }
        if (local.empty()) {
            // Nothing to fight here. At a heavy porc edge hold (not walk in)
            // for a while; otherwise hand the hull back to its task.
            bool edge = false;
            for (int i : heavy) {
                const Enemy& h = enemies[i];
                if (Dist2(pos, h.pos) < SQUARE(h.reach + p.porcMargin + range)) { edge = true; break; }
            }
            if (edge && s.owned && s.mode == Mode::PORC && frame - s.holdSince < EDGE_HOLD_FRAMES) {
                take(Mode::PORC);
                ++cntPorc;
                Issue(unit, s, pos, frame, false);
            } else {
                Release(unit, s, frame);
            }
            continue;
        }

        const float ratio = enemy > 0.f ? ally / enemy : 1e9f;
        float inF, outF, period;
        Mode mode;
        if (ratio >= p.superior)   { mode = Mode::SUPERIOR;  inF = p.supIn; outF = p.supOut; period = 0.f; }
        else if (ratio >= p.equal) { mode = Mode::EQUAL;     inF = p.eqIn;  outF = p.eqOut;  period = p.eqPeriod; }
        else                       { mode = Mode::DEFICIENT; inF = p.defIn; outF = p.defOut; period = p.defPeriod; }

        // Cadence: step in with a ready weapon, back out after the shot until
        // it is ready again and `period` seconds have passed since the shot.
        const bool ready = unit->IsWeaponReady(frame);
        if (s.wasReady && !ready) s.outUntil = frame + int(period * FRAMES_PER_SEC);
        s.wasReady = ready;
        const bool out = !ready || frame < s.outUntil;
        const float frac = out ? outF : inF;

        // Nearest enemy whose firing ground is outside heavy porc reach.
        std::sort(local.begin(), local.end());
        const Enemy* anchor = nullptr;
        AIFloat3 goal;
        for (const auto& [d2, i] : local) {
            const Enemy& e = enemies[i];
            float dist = frac * range;
            if (e.comm) {
                // Owner 2026-11-08: Mace/Thug/Satyr stand and shoot a commander
                // (no back-out) but never inside its death blast.
                if (p.commanderNoRetreat) dist = inF * range;
                if (p.commanderBlast) dist = std::max(dist, e.blast + p.commanderMargin);
            }
            AIFloat3 g = e.pos + Away(e.pos, pos) * dist;
            if (p.commanderBlast) {
                // Any other local commander's blast pushes the goal out radially.
                for (const auto& [d2c, ci] : local) {
                    const Enemy& c = enemies[ci];
                    if (!c.comm || c.blast <= 0.f) continue;
                    const float keep = c.blast + p.commanderMargin;
                    if (Dist2(g, c.pos) < SQUARE(keep)) g = c.pos + Away(c.pos, g) * keep;
                }
            }
            if (InPorc(g, p.porcMargin)) continue;
            anchor = &e; goal = g;
            break;
        }
        if (anchor == nullptr) {
            // Every local enemy sits under heavy porc: hold outside it.
            take(Mode::PORC);
            ++cntPorc;
            Issue(unit, s, pos, frame, false);
            continue;
        }
        take(mode);
        if (mode == Mode::SUPERIOR) ++cntSup; else if (mode == Mode::EQUAL) ++cntEq; else ++cntDef;
        Issue(unit, s, goal, frame, false);
    }
    for (auto it = states.begin(); it != states.end();) {
        it = alive.count(it->first) ? std::next(it) : states.erase(it);
    }
    if (frame - lastSummary >= FRAMES_PER_SEC * 60) {
        lastSummary = frame;
        circuit->LOG("[AssaultMicro] f=%d hull-runs=%d superior=%d equal=%d deficient=%d porc=%d moves=%d releases=%d",
            frame, cntUnits, cntSup, cntEq, cntDef, cntPorc, cntMoves, cntRelease);
        cntUnits = cntSup = cntEq = cntDef = cntPorc = cntMoves = cntRelease = 0;
    }
}

} // namespace circuit
