// Spam: economy-gated mass production of cheap units sent down fixed routes.
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/map_helpers.as"
#include "roster.as"
#include "widget_link.as"

/******************************************************************************

SPAM

Units carrying the "spam" attribute (behaviour.json "attribute": ["spam"],
read as Unit::Attr::SPAM) get a behaviour of their own once the economy
clears Global::Spam::MinMetalIncome and MinEnergyIncome (both, sliding 10 s
minimum; deactivation at ReleaseFraction of each so a dip does not flap):

  factories   Every T1 factory with an entry in Global::Spam::UnitByFactory
              produces that unit on repeat and nothing else while spam is
              active (Factory::AiMakeTask asks here first).
  routes      Each spam factory owns one native CRouteTask (TaskF::Route)
              holding a multi-step route from the factory to the destination.
              Routes of different factories run in parallel lanes: the k-th
              factory is offset sideways by LaneSpacing * (0, +1, -1, +2, ...)
              from the direct line, with two intermediate waypoints so the
              lane is held, not just the end point.
  units       A finished spam unit is assigned to its factory's route task
              from Military::AiMakeTask (nearest spam factory, units spawn at
              their factory). CRouteTask issues plain move orders only, so
              nothing on the way interrupts the run; the units hold at the
              destination and fire at whatever comes into range.
  focus       The destination is BehindEnemyDistance beyond the current focus
              along the line from our start through it, clamped to the map:
              behind the enemy line and past its radar and LOS when the map
              allows. The focus is an enemy start spot (map start spots minus
              our own and our allies' from the roster; with no map spots the
              mirror of our start through the map centre). It rotates through
              the enemy spots nearest-first every RefocusMinutes, and
              SetFocus(pos) retargets on demand. Every refocus rebuilds every
              factory route and the route task re-issues it to all units
              already on the field.

Everything here is data on the script side plus one native task type; the
task keeps only unit pointers it is told about through the normal assignment
path and drops them through the normal removal path.

******************************************************************************/
namespace Spam {
    bool active = false;
    int activeSinceFrame = -1;
    dictionary routeByFactory;     // factory id string -> CRouteTask@
    dictionary laneByFactory;      // factory id string -> int lane (0, 1, -1, 2, -2 ...)
    int lanesIssued = 0;
    // Two different points, previously conflated:
    //   focus  - WHERE THE RUN ENDS. An enemy start spot; the destination is
    //            BehindEnemyDistance past it. Rotates on the refocus timer.
    //   front  - WHERE THE RUN GOES THROUGH. The AI's current combat focus
    //            from aiMilitaryMgr.GetCombatFocusPos(): the leader of the
    //            strongest ATTACK squad, else the enemy centroid. Spam is
    //            worth most crossing the fight - vision and decoy targets
    //            where the shooting already is - and only then carrying on
    //            into the backline.
    AIFloat3 focus;
    bool hasFocus = false;
    int focusIdx = 0;
    int lastFocusFrame = -1;
    AIFloat3 front;
    bool hasFront = false;
    // Diagnostics. Activation is one line; everything between activation and a
    // unit actually moving used to be silent, so a game where spam activated
    // and then did nothing (Eight Horses, f=19115: "Activated", no "Route
    // created", ever) could not be told apart from one where no spam factory
    // existed. Both memos log only when the answer changes, so a factory that
    // asks every few seconds produces one line, not hundreds.
    dictionary rejectByFactory;    // factory id string -> last reason logged
    int lastIdleReportFrame = -1;

    bool IsEnabled() { return Global::Spam::Enabled; }
    bool IsActive() { return active; }

    bool IsSpamDef(const CCircuitDef@ d)
    {
        return d !is null && d.IsAttrAny(Unit::Attr::SPAM.mask);
    }

    // The spam unit a factory produces, "" when the factory is not a spam factory.
    string SpamUnitFor(const CCircuitDef@ facDef)
    {
        if (facDef is null) return "";
        string name = "";
        if (!Global::Spam::UnitByFactory.get(facDef.GetName(), name)) return "";
        return name;
    }

    /**************************************************************************
     Activation (Main::AiUpdate, every 30 frames).
     **************************************************************************/
    void Update()
    {
        if (!IsEnabled()) return;
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const float ei = Economy::GetMinEnergyIncomeLast10s();
        if (!active) {
            if (mi < Global::Spam::MinMetalIncome || ei < Global::Spam::MinEnergyIncome) {
                // Spam is a fusion-era behaviour by design: below this the same
                // units are ordinary front-line combat units and the roles should
                // keep using them as such. Report the shortfall occasionally so
                // "never activated" is distinguishable from "never evaluated".
                if (lastIdleReportFrame < 0 || (ai.frame - lastIdleReportFrame) >= MINUTE) {
                    lastIdleReportFrame = ai.frame;
                    GenericHelpers::LogUtil("[Spam] Idle: mi=" + int(mi) + "/" + int(Global::Spam::MinMetalIncome)
                        + " ei=" + int(ei) + "/" + int(Global::Spam::MinEnergyIncome), 3);
                }
            }
            if (mi >= Global::Spam::MinMetalIncome && ei >= Global::Spam::MinEnergyIncome) {
                active = true;
                activeSinceFrame = ai.frame;
                _EnsureFocus();
                GenericHelpers::LogUtil("[Spam] Activated: mi=" + mi + " ei=" + ei + " focus=(" + int(focus.x) + "," + int(focus.z) + ")", 1);
                WidgetLink::Send("spam", "on|" + int(mi) + "|" + int(ei));
            }
            return;
        }
        const float rel = Global::Spam::ReleaseFraction;
        if (mi < Global::Spam::MinMetalIncome * rel || ei < Global::Spam::MinEnergyIncome * rel) {
            active = false;
            GenericHelpers::LogUtil("[Spam] Deactivated: mi=" + mi + " ei=" + ei + "; units on the field keep their routes", 1);
            WidgetLink::Send("spam", "off|" + int(mi) + "|" + int(ei));
            return;
        }
        if (lastFocusFrame >= 0 && (ai.frame - lastFocusFrame) >= Global::Spam::RefocusMinutes * MINUTE) {
            NextFocus();
        }
        UpdateFront();
    }

    // Poll the AI's combat focus and rebuild every lane when it has moved far
    // enough to matter. This is the "route updated whenever the combat target
    // changed" half; the refocus timer above only moves the destination.
    void UpdateFront()
    {
        const AIFloat3 p = aiMilitaryMgr.GetCombatFocusPos();
        if (p.x < 0.0f) {   // invalid: no army and no known enemy
            return;
        }
        if (hasFront && MapHelpers::SqDist(p, front)
                < Global::Spam::FrontMoveThreshold * Global::Spam::FrontMoveThreshold) {
            return;
        }
        front = p;
        hasFront = true;
        RefreshRoutes();
        GenericHelpers::LogUtil("[Spam] Front moved to (" + int(p.x) + "," + int(p.z) + "); "
            + routeByFactory.getSize() + " route(s) rebuilt", 2);
        WidgetLink::Send("spam", "front|" + int(p.x) + "|" + int(p.z));
    }

    /**************************************************************************
     Focus (the target the routes lead behind).
     **************************************************************************/
    // Map start spots that are neither ours nor an ally's, nearest to us first.
    array<AIFloat3> EnemyStartSpots()
    {
        array<AIFloat3> result;
        StartSpot@[]@ spots = Global::Map::Config.StartSpots;
        if (spots is null || spots.length() == 0) return result;
        dictionary taken;
        const int own = MapHelpers::NearestSpotIdx(Global::Map::StartPos, spots);
        if (own >= 0) taken.set("" + own, true);
        array<Team::Roster::Entry@>@ allies = Team::Roster::All();
        for (uint i = 0; i < allies.length(); ++i) {
            if (allies[i].spotIndex >= 0) taken.set("" + allies[i].spotIndex, true);
        }
        array<float> dist;
        for (uint i = 0; i < spots.length(); ++i) {
            if (taken.exists("" + i)) continue;
            const float d = MapHelpers::SqDist(Global::Map::StartPos, spots[i].pos);
            uint pos = 0;
            while (pos < dist.length() && dist[pos] <= d) ++pos;
            result.insertAt(pos, spots[i].pos);
            dist.insertAt(pos, d);
        }
        return result;
    }

    AIFloat3 _MirrorOfStart()
    {
        const float w = float(aiTerrainMgr.GetTerrainWidth());
        const float h = float(aiTerrainMgr.GetTerrainHeight());
        return AIFloat3(w - Global::Map::StartPos.x, 0.0f, h - Global::Map::StartPos.z);
    }

    void _EnsureFocus()
    {
        if (hasFocus) return;
        focusIdx = 0;
        array<AIFloat3> enemies = EnemyStartSpots();
        SetFocus(enemies.length() > 0 ? enemies[0] : _MirrorOfStart());
    }

    void NextFocus()
    {
        array<AIFloat3> enemies = EnemyStartSpots();
        if (enemies.length() == 0) { SetFocus(_MirrorOfStart()); return; }
        focusIdx = (focusIdx + 1) % int(enemies.length());
        SetFocus(enemies[focusIdx]);
    }

    // Retarget every route and every unit already on the field.
    void SetFocus(const AIFloat3 &in pos)
    {
        focus = pos;
        hasFocus = true;
        lastFocusFrame = ai.frame;
        RefreshRoutes();
        GenericHelpers::LogUtil("[Spam] Focus set to (" + int(pos.x) + "," + int(pos.z) + "); " + routeByFactory.getSize() + " route(s) rebuilt", 1);
        WidgetLink::Send("spam", "focus|" + int(pos.x) + "|" + int(pos.z));
    }

    /**************************************************************************
     Routes.
     **************************************************************************/
    AIFloat3 _Clamp(const AIFloat3 &in p)
    {
        const float margin = Global::Spam::MapMargin;
        const float w = float(aiTerrainMgr.GetTerrainWidth());
        const float h = float(aiTerrainMgr.GetTerrainHeight());
        float x = p.x, z = p.z;
        if (x < margin) x = margin;
        if (x > w - margin) x = w - margin;
        if (z < margin) z = margin;
        if (z > h - margin) z = h - margin;
        return AIFloat3(x, 0.0f, z);
    }

    // Destination: BehindEnemyDistance past the focus on the line from our start.
    AIFloat3 Destination()
    {
        float dx = focus.x - Global::Map::StartPos.x;
        float dz = focus.z - Global::Map::StartPos.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { dx = 1.0f; dz = 0.0f; len = 1.0f; }
        const float d = Global::Spam::BehindEnemyDistance;
        return _Clamp(AIFloat3(focus.x + dx / len * d, 0.0f, focus.z + dz / len * d));
    }

    // Factory -> two lane waypoints -> destination. Lane k is offset sideways by
    // LaneSpacing * k from the direct line so several factories run in parallel.
    array<AIFloat3> BuildRoute(const AIFloat3 &in from, int lane)
    {
        array<AIFloat3> route;
        const AIFloat3 to = Destination();
        float dx = to.x - from.x;
        float dz = to.z - from.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { route.insertLast(to); return route; }
        const float nx = -dz / len;   // left-hand normal
        const float nz = dx / len;
        const float off = Global::Spam::LaneSpacing * float(lane);

        // Via the front when we know where it is, otherwise the old straight
        // run. The lane offset is applied to every waypoint including the
        // destination, so parallel lanes stay parallel the whole way instead
        // of converging on one point.
        if (hasFront) {
            // Half way to the front, then the front itself: two waypoints hold
            // the lane on the approach, which one waypoint would not.
            route.insertLast(_Clamp(AIFloat3(from.x + (front.x - from.x) * 0.5f + nx * off, 0.0f,
                                             from.z + (front.z - from.z) * 0.5f + nz * off)));
            route.insertLast(_Clamp(AIFloat3(front.x + nx * off, 0.0f, front.z + nz * off)));
        } else {
            route.insertLast(_Clamp(AIFloat3(from.x + dx * 0.33f + nx * off, 0.0f, from.z + dz * 0.33f + nz * off)));
            route.insertLast(_Clamp(AIFloat3(from.x + dx * 0.66f + nx * off, 0.0f, from.z + dz * 0.66f + nz * off)));
        }
        route.insertLast(_Clamp(AIFloat3(to.x + nx * off, 0.0f, to.z + nz * off)));
        return route;
    }

    int _NextLane()
    {
        // 0, +1, -1, +2, -2, ...
        const int n = lanesIssued++;
        if (n == 0) return 0;
        const int k = (n + 1) / 2;
        return (n % 2 == 1) ? k : -k;
    }

    // The route task of a factory, created on first use.
    CRouteTask@ RouteFor(CCircuitUnit@ factory)
    {
        if (factory is null) return null;
        const string key = "" + factory.id;
        CRouteTask@ task = null;
        if (routeByFactory.get(key, @task) && task !is null) return task;

        IUnitTask@ t = aiMilitaryMgr.Enqueue(TaskF::Route());
        IFighterTask@ ft = cast<IFighterTask>(t);
        @task = (ft is null) ? null : cast<CRouteTask>(ft);
        if (task is null) return null;
        int lane = 0;
        if (!laneByFactory.get(key, lane)) {
            lane = _NextLane();
            laneByFactory.set(key, lane);
        }
        _EnsureFocus();
        task.SetRoute(BuildRoute(factory.GetPos(ai.frame), lane));
        routeByFactory.set(key, @task);
        GenericHelpers::LogUtil("[Spam] Route created for factory " + factory.id + " lane " + lane
            + " -> (" + int(Destination().x) + "," + int(Destination().z) + ")", 2);
        return task;
    }

    void RefreshRoutes()
    {
        array<string>@ keys = routeByFactory.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CRouteTask@ task = null;
            if (!routeByFactory.get(keys[i], @task) || task is null) continue;
            CCircuitUnit@ factory = ai.GetTeamUnit(int(parseInt(keys[i])));
            if (factory is null) { task.Abort(); routeByFactory.delete(keys[i]); continue; }
            int lane = 0;
            laneByFactory.get(keys[i], lane);
            task.SetRoute(BuildRoute(factory.GetPos(ai.frame), lane));
        }
    }

    // Nearest known spam factory to a position (spam units spawn at their factory).
    CCircuitUnit@ _NearestSpamFactory(const AIFloat3 &in pos)
    {
        CCircuitUnit@ best = null;
        float bestSq = 1e30f;
        array<string>@ keys = routeByFactory.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ f = ai.GetTeamUnit(int(parseInt(keys[i])));
            if (f is null) continue;
            const float sq = MapHelpers::SqDist(pos, f.GetPos(ai.frame));
            if (sq < bestSq) { bestSq = sq; @best = f; }
        }
        return best;
    }

    /**************************************************************************
     Hooks.
     **************************************************************************/
    // Factory::AiMakeTask asks here first. Returns null when this factory is not
    // producing spam right now, so the normal role logic runs.
    // Log `why` for this factory, but only when it differs from the last answer.
    void _Reject(CCircuitUnit@ factory, const string &in why)
    {
        const string key = "" + factory.id;
        string last = "";
        if (rejectByFactory.get(key, last) && last == why) return;
        rejectByFactory.set(key, why);
        if (why.length() == 0) return;   // memo cleared on success; nothing to say
        GenericHelpers::LogUtil("[Spam] " + factory.circuitDef.GetName() + " (" + factory.id
            + ") not spamming: " + why, 3);
    }

    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory)
    {
        if (!active || factory is null || factory.circuitDef is null) return null;
        const string unitName = SpamUnitFor(factory.circuitDef);
        if (unitName.length() == 0) {
            // Not a spam factory. Expected for every T2/T3/air/sea factory, so
            // this is the one rejection worth keeping quiet.
            return null;
        }
        CCircuitDef@ d = ai.GetCircuitDef(unitName);
        if (d is null) {
            _Reject(factory, "unit '" + unitName + "' is not a loaded def");
            return null;
        }
        if (!d.IsAvailable(ai.frame)) {
            // The likely cause when a listed T1 factory still exists and still
            // produces nothing: a role start limit or a reached unit cap makes
            // the spam unit unavailable.
            _Reject(factory, "'" + unitName + "' unavailable (tech gate or unit limit)");
            return null;
        }
        _Reject(factory, "");   // clears the memo so a later rejection logs again
        RouteFor(factory);   // make sure the lane exists before the first unit pops
        return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::NOW, d, factory.GetPos(ai.frame), 64.f));
    }

    // Military::AiMakeTask asks here first. Spam units join their factory's route
    // while spam is active or while any route still exists (units built just
    // before deactivation still go).
    IUnitTask@ MilitaryMakeTask(CCircuitUnit@ u)
    {
        if (!IsEnabled() || u is null || !IsSpamDef(u.circuitDef)) return null;
        if (routeByFactory.getSize() == 0) return null;
        CCircuitUnit@ factory = _NearestSpamFactory(u.GetPos(ai.frame));
        if (factory is null) return null;
        CRouteTask@ task = RouteFor(factory);
        if (task is null) return null;
        return task;
    }

    void OnFactoryRemoved(CCircuitUnit@ factory)
    {
        if (factory is null) return;
        const string key = "" + factory.id;
        CRouteTask@ task = null;
        if (routeByFactory.get(key, @task) && task !is null) {
            task.Abort();   // its units go idle and rejoin the nearest remaining route
        }
        routeByFactory.delete(key);
        laneByFactory.delete(key);
    }

    void OnTaskRemoved(IUnitTask@ task)
    {
        if (task is null || routeByFactory.getSize() == 0) return;
        array<string>@ keys = routeByFactory.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CRouteTask@ t = null;
            if (routeByFactory.get(keys[i], @t) && t is task) routeByFactory.delete(keys[i]);
        }
    }
}  // namespace Spam
