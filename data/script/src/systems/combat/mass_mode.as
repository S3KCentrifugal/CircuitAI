// Mass mode (owner, 2026-11-13): what the army does once the allied SMRTBARbs
// together hold 4,000 units.
#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/spatial/map_helpers.as"
#include "edge_lanes.as"
#include "spam.as"

/******************************************************************************

MASS MODE

Owner, 2026-11-13: past 4,000 allied units every unit except spam and
commanders gets a stop, fire at will, then one order with all its waypoints,
and then no more orders from the AI.

Trigger    ai.GetAlliedAIUnitCount(): every unit of every SMRTBARb on this AI's
           ally team (this one included). On at OnUnits (4,000). Off once the
           count has stayed below OffUnits (3,600) for OffSeconds (60): one big
           fight's losses do not flip it back and forth. Every SMRTBARb reads
           the same count, so they switch together (within one pass).

Per unit, once per mass-mode period (one pass every PassSeconds, at most
UnitBudget units per pass; new units are caught by the next pass):
  skipped  commanders, spam (the spam pump roster Spam::IsSpamDef, the "spam"
           role or attribute: they keep their spam lanes), units a player
           commands (a player task we did not give), unfinished units,
           everything without a weapon or with a build ability (builders,
           radars, jammers), transports, and stockpile weapons (nukes,
           antinukes, EMP, Juno, Perdition, Catalyst only fire on an explicit
           order, so they keep their native task).
  hold     the unit goes under a player task (ai.UnitControl(u, false)): the
           AI gives it no further orders (CCircuitAI::UpdateActions skips
           player tasks; Military::AiMakeTask is never asked for it).
  then     fire at will, and one order (CCircuitUnit::CmdOrderOnce: STOP, the
           first waypoint, the rest shift-queued; straight to the engine, past
           the LagLoad floor that would drop it):
    offensive structure (not mobile, has a weapon; LRPCs and lolcannons
           included, the engine aims them itself): STOP only.
    fighting air (fighters, bombers, gunships, capital ships; not
           transports or air scouts): one FIGHT to the far map edge straight
           ahead along the team axis (FarEdge).
    ground, below T3: MOVE along its nearer edge lane (the side of the team
           axis it stands on; -1 left, +1 right as EdgeLanes::Decide deals
           them): EdgeLanes::RallyFor, the rim at the two shares, the enemy
           back edge's end, the jackknife to its other end, the 2-step retrace
           (mid, home). Leading lane points already behind the unit along the
           axis are left out, so no unit walks back to rally 1.
    ground T3: MOVE straight to its nearer map edge (the edge lane's rim at
           the unit's own place along the axis: RimSide, else EdgePoint), then
           the jackknife (end, turn) and the 2-step retrace (mid, home).
           Without a rim: RallyFor's corner and enemy corner.
    ground that cannot reach our start (ships, subs): fire at will only, AI
           control kept.

Off        Every held unit gets ai.UnitControl(u, true) back (its native task
           picks it up when idle) and its def's fire state. Nothing else.

Cost       O(own units) per pass with O(1) dictionary checks; at most
           UnitBudget orders and RouteBudget new route computations
           (EdgeLanes::RallyFor/RimEnds walk the rim) per pass. Routes are
           cached per kind, side and def.

Needs the DLL that registers CCircuitAI::GetAlliedAIUnitCount,
CCircuitDef::GetTechLevel and CCircuitUnit::CmdOrderOnce (pending-all, owner
2026-11-13).

******************************************************************************/
namespace MassMode {
    // levers
    bool Enabled = true;
    int OnUnits = 4000;
    int OffUnits = 3600;
    int OffSeconds = 60;
    int PassSeconds = 5;
    int UnitBudget = 200;
    int RouteBudget = 4;
    int RouteRetrySeconds = 60;

    const int FIRE_AT_WILL = 2;

    bool on = false;
    int belowSince = -1;
    int passFrame = -1;
    int lastCount = 0;
    int routesMade = 0;          // RouteBudget counter for this pass
    dictionary done;             // unit id -> 1: handled in this period
    dictionary held;             // unit id -> 1: under our player task
    dictionary routeCache;       // kind|side|def -> array<AIFloat3>@ (kind 0 edge lane, 1 T3 tail)
    dictionary routeFrom;        // kind|side|def -> Pos@: where it was computed from (the rim cache's key)
    dictionary routeFail;        // kind|side|def -> frame of the last empty route

    bool IsOn() { return on; }
    float Min(float a, float b) { return (a < b) ? a : b; }
    float Max(float a, float b) { return (a > b) ? a : b; }
    class Pos { AIFloat3 p; Pos(const AIFloat3 &in q) { p = q; } }

    // ------------------------------------------------------------ who is who

    bool HasWeapon(const CCircuitDef@ d) { return d.GetMaxRange() > 0.0f; }
    bool IsBuilderDef(const CCircuitDef@ d) { return d.GetBuildSpeed() > 0.0f || d.IsRoleAny(Unit::Role::BUILDER.mask); }
    bool IsSpam(const CCircuitDef@ d)
    {
        return Spam::IsSpamDef(d) || d.IsRoleAny(Unit::Role::SPAM.mask) || d.IsAttrAny(Unit::Attr::SPAM.mask);
    }
    bool IsOffensiveStructure(const CCircuitDef@ d)
    {
        return !d.IsMobile() && HasWeapon(d) && !IsBuilderDef(d)
            && !d.IsRoleAny(Unit::Role::MINE.mask) && !d.IsAttrAny(Unit::Attr::STOCK.mask);
    }
    bool IsArmy(const CCircuitDef@ d)
    {
        return d.IsMobile() && HasWeapon(d) && !IsBuilderDef(d) && !d.IsRoleAny(Unit::Role::COMM.mask)
            && !IsSpam(d) && !d.IsRoleAny(Unit::Role::TRANS.mask);
    }
    bool IsAirFighter(const CCircuitDef@ d) { return d.IsAbleToFly() && !d.IsRoleAny(Unit::Role::SCOUT.mask); }

    // ------------------------------------------------------------ geometry

    bool Axis(AIFloat3 &out s0, AIFloat3 &out e0, float &out ax, float &out az, float &out nx, float &out nz)
    {
        if (!EdgeLanes::Ends(s0, e0)) return false;
        EdgeLanes::Axis(s0, e0, ax, az, nx, nz);
        return true;
    }
    int SideOf(const AIFloat3 &in p)
    {
        AIFloat3 s0, e0; float ax, az, nx, nz;
        if (!Axis(s0, e0, ax, az, nx, nz)) return 0;
        return ((p.x - s0.x) * nx + (p.z - s0.z) * nz < 0.0f) ? -1 : 1;
    }
    // The far map edge straight ahead of `p` along the team axis (inside the edge margin)
    AIFloat3 FarEdge(const AIFloat3 &in p)
    {
        AIFloat3 s0, e0; float ax, az, nx, nz;
        if (!Axis(s0, e0, ax, az, nx, nz)) return AIFloat3(-1.0f, 0.0f, -1.0f);
        const float m = Global::Spam::EdgeMargin;
        const float w = float(AiTerrainWidth()) - m, h = float(AiTerrainHeight()) - m;
        float t = 1.0e9f;
        if (ax > 0.001f) t = Min(t, (w - p.x) / ax); else if (ax < -0.001f) t = Min(t, (m - p.x) / ax);
        if (az > 0.001f) t = Min(t, (h - p.z) / az); else if (az < -0.001f) t = Min(t, (m - p.z) / az);
        if (t > 1.0e8f || t < 0.0f) t = 0.0f;
        return AIFloat3(Max(m, Min(w, p.x + ax * t)), 0.0f, Max(m, Min(h, p.z + az * t)));
    }
    // T3: the rim (else the margin edge) on `side` at the unit's own place along the axis
    AIFloat3 EdgePointFor(CCircuitDef@ d, const AIFloat3 &in from, const AIFloat3 &in p, int side)
    {
        AIFloat3 s0, e0;
        if (!EdgeLanes::Ends(s0, e0)) return AIFloat3(-1.0f, 0.0f, -1.0f);
        const float len2 = MapHelpers::SqDist(s0, e0);
        float share = ((p.x - s0.x) * (e0.x - s0.x) + (p.z - s0.z) * (e0.z - s0.z)) / len2;
        share = Max(0.0f, Min(1.0f, share));
        const AIFloat3 r = EdgeLanes::RimSide(d, from, s0, e0, side, share);
        if (r.x >= 0.0f) return r;
        return EdgeLanes::EdgePoint(d, from, s0, e0, side, share);
    }
    // T3: the jackknife and the 2-step retrace on `side`
    array<AIFloat3> BackEdgeTail(CCircuitDef@ d, const AIFloat3 &in from, int side)
    {
        array<AIFloat3> r;
        AIFloat3 end, turn, mid, home;
        if (EdgeLanes::RimEnds(d, from, from, side, "", end, turn, mid, home)) {
            const array<AIFloat3> pts = { end, turn, mid, home };
            for (uint i = 0; i < pts.length(); ++i) if (pts[i].x >= 0.0f) r.insertLast(pts[i]);
            return r;
        }
        array<AIFloat3> lane = EdgeLanes::RallyFor(d, from, side);   // no rim: past its two side rallies
        for (uint i = 2; i < lane.length(); ++i) r.insertLast(lane[i]);
        return r;
    }

    // The cached route for kind|side|def, computed on first use (RouteBudget per pass)
    array<AIFloat3>@ CachedRoute(CCircuitUnit@ u, int kind, int side, Pos@ &out from)
    {
        @from = null;
        const string key = "" + kind + "|" + side + "|" + u.circuitDef.GetName();
        array<AIFloat3>@ r = null;
        if (routeCache.get(key, @r) && r !is null) { routeFrom.get(key, @from); return r; }
        int failed = -1;
        if (routeFail.get(key, failed) && ai.frame - failed < RouteRetrySeconds * SECOND) return null;
        if (routesMade >= RouteBudget) return null;
        ++routesMade;
        CCircuitDef@ d = ai.GetCircuitDef(u.circuitDef.id);   // EdgeLanes takes a non-const def
        if (d is null) return null;
        const AIFloat3 p = u.GetPos(ai.frame);
        array<AIFloat3> pts;
        if (kind == 1) pts = BackEdgeTail(d, p, side);
        else pts = EdgeLanes::RallyFor(d, p, side);
        if (pts.length() == 0) { routeFail.set(key, ai.frame); return null; }
        @r = array<AIFloat3>();
        r = pts;
        @from = Pos(p);
        routeCache.set(key, @r);
        routeFrom.set(key, @from);
        GenericHelpers::LogUtil("[MassMode] " + (kind == 1 ? "T3 tail " : "edge lane ") + EdgeLanes::Name(side) + " for "
            + u.circuitDef.GetName() + ", " + r.length() + " points" + Spam::RouteText(r), 1);
        return r;
    }

    // The waypoints of one ground unit; empty when it has none (yet)
    array<AIFloat3> GroundRoute(CCircuitUnit@ u)
    {
        array<AIFloat3> route;
        const AIFloat3 p = u.GetPos(ai.frame);
        const int side = SideOf(p);
        if (side == 0) return route;
        const int kind = (u.circuitDef.GetTechLevel() >= 3.0f) ? 1 : 0;
        Pos@ from = null;
        array<AIFloat3>@ r = CachedRoute(u, kind, side, from);
        if (r is null || r.length() == 0) return route;
        if (kind == 1) {
            CCircuitDef@ d = ai.GetCircuitDef(u.circuitDef.id);
            const AIFloat3 edge = (d is null || from is null) ? AIFloat3(-1.0f, 0.0f, -1.0f) : EdgePointFor(d, from.p, p, side);
            if (edge.x >= 0.0f) route.insertLast(edge);
            for (uint i = 0; i < r.length(); ++i) route.insertLast(r[i]);
            return route;
        }
        // edge lane: leave out the leading rallies already behind the unit
        AIFloat3 s0, e0; float ax, az, nx, nz;
        uint first = 0;
        if (Axis(s0, e0, ax, az, nx, nz)) {
            const float here = (p.x - s0.x) * ax + (p.z - s0.z) * az;
            while (first + 1 < r.length() && (r[first].x - s0.x) * ax + (r[first].z - s0.z) * az < here) ++first;
        }
        for (uint i = first; i < r.length(); ++i) route.insertLast(r[i]);
        return route;
    }

    // ------------------------------------------------------------ the pass

    // Hold the unit (player task), fire at will, then its one order. False: try later.
    bool Take(CCircuitUnit@ u, const array<AIFloat3> &in route, bool fight)
    {
        if (u.task is null || !ai.UnitControl(u, false)) return false;
        held.set("" + u.id, 1);
        u.SetFireState(FIRE_AT_WILL);
        if (route.length() > 0) u.CmdOrderOnce(route, fight);
        else u.CmdStop();
        return true;
    }

    void Pass()
    {
        array<int>@ ids = ai.GetOwnedUnitIds();
        int taken = 0, structures = 0, air = 0, ground = 0, fireOnly = 0;
        for (uint i = 0; i < ids.length() && taken < UnitBudget; ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f) continue;
            const string key = "" + u.id;
            if (done.exists(key)) continue;
            const CCircuitDef@ d = u.circuitDef;
            const bool structure = IsOffensiveStructure(d);
            if (!structure && !IsArmy(d)) { done.set(key, 1); continue; }
            if (u.task !is null && u.task.GetType() == int(Task::Type::PLAYER)) { done.set(key, 1); continue; }   // a player's
            array<AIFloat3> route;
            bool fight = false;
            if (structure) {
                // STOP only
            } else if (IsAirFighter(d)) {
                const AIFloat3 goal = FarEdge(u.GetPos(ai.frame));
                if (goal.x < 0.0f) continue;
                route.insertLast(goal);
                fight = true;
            } else if (d.IsAbleToFly()) {
                done.set(key, 1);   // an armed air scout: AI control kept
                continue;
            } else if (aiTerrainMgr.CanMoveTo(u, Global::Map::StartPos)) {
                route = GroundRoute(u);
                if (route.length() == 0) continue;   // route not computed yet (budget) or none: next pass
            } else {
                u.SetFireState(FIRE_AT_WILL);   // ships, subs: fire at will, AI control kept
                done.set(key, 1);
                ++fireOnly;
                continue;
            }
            if (!Take(u, route, fight)) continue;
            done.set(key, 1);
            ++taken;
            if (structure) ++structures; else if (fight) ++air; else ++ground;
        }
        if (taken + fireOnly > 0)
            GenericHelpers::LogUtil("[MassMode] held " + taken + " unit(s) with one order each: " + structures + " structure(s) stopped, "
                + air + " air fight to the far edge, " + ground + " ground on their lane; " + fireOnly + " fire at will only", 1);
    }

    // Off: held units back to the AI, fire states back to their defs' defaults
    void Restore()
    {
        int n = 0;
        array<string>@ keys = held.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(int(parseInt(keys[i])));
            if (u is null || u.circuitDef is null) continue;
            if (u.task !is null && u.task.GetType() == int(Task::Type::PLAYER) && ai.UnitControl(u, true)) ++n;
            u.SetFireState(u.circuitDef.GetFireState());
        }
        done.deleteAll();
        held.deleteAll();
        GenericHelpers::LogUtil("[MassMode] off: " + n + " unit(s) back under AI control", 1);
    }

    void Forget()
    {
        array<string>@ keys = done.getKeys();
        for (uint i = 0; i < keys.length(); ++i)
            if (ai.GetTeamUnit(int(parseInt(keys[i]))) is null) { done.delete(keys[i]); held.delete(keys[i]); }
    }

    // Main::AiUpdate (every second): one pass every PassSeconds
    void Update()
    {
        if (!Enabled || ai.frame - passFrame < PassSeconds * SECOND) return;
        passFrame = ai.frame;
        lastCount = ai.GetAlliedAIUnitCount();
        if (!on) {
            if (lastCount < OnUnits) return;
            on = true;
            belowSince = -1;
            GenericHelpers::LogUtil("[MassMode] on: " + lastCount + " allied SMRTBARb units (on at " + OnUnits
                + ", off below " + OffUnits + " for " + OffSeconds + " s)", 1);
        } else if (lastCount < OffUnits) {
            if (belowSince < 0) belowSince = ai.frame;
            if (ai.frame - belowSince >= OffSeconds * SECOND) {
                on = false;
                belowSince = -1;
                GenericHelpers::LogUtil("[MassMode] off: " + lastCount + " allied SMRTBARb units", 1);
                Restore();
                return;
            }
        } else {
            belowSince = -1;
        }
        routesMade = 0;
        Pass();
        if (ai.frame % MINUTE < PassSeconds * SECOND) Forget();
    }
}  // namespace MassMode
