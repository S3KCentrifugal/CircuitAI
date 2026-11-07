#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../../global.as"
#include "../../settings/shared/scout_raid.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/spatial/map_helpers.as"
#include "../../helpers/math/scout_raid_math.as"

// D-296: non-spam land scouts raid the enemy backline - extractors,
// construction turrets and wind - and wrap around armed enemies.
//
// Policy only. Native mechanism: aiBattle.GroundHazard (observed armed ground
// coverage, lazy per 1 s publication), aiBattle.GetUnitRaidRoute (dry unit
// route with optional hard coverage avoidance and soft escape), CRouteTask
// SetLandTarget (BAR priority target, no ATTACK chase) and the ground
// contact kind flags. One CRouteTask per raider.
//
// Cost (16 AIs): Tick once per second per AI, O(R*(C+P)) with C observed
// ground contacts, P lookahead waypoints and R <= MaxRaiders; no army scans. Route
// solves are synchronous and capped at MaxRoutesPerSecond per AI (a latency
// budget for this new behaviour only; replans are event-driven: target lost,
// hazard ahead, stuck). Commands: one compacted shift-MOVE batch plus at most
// one SET_TARGET per replan. No cross-AI messages.
namespace ScoutRaid {
    final class Raider {
        int id = -1;
        CRouteTask@ task;
        int target = -1;            // enemy unit id, -1 = travelling to a fallback goal
        AIFloat3 targetPos;
        int excluded = -1;          // target given up after repeated hazard replans
        array<AIFloat3> route;      // the compacted route last issued
        uint cursor = 0;            // first route point not yet reached
        uint issuedEnd = 0;         // route points [.., issuedEnd) handed to the task so far
        int lastWindow = -100000;   // frame of the last window handed out
        AIFloat3 lastPos;
        int lastMove = 0;
        int nextReplan = 0;
        int hazardSince = -1;
        int hazardReplans = 0;
        int routeFailures = 0;      // consecutive failed solves: exponential replan backoff
        int targetLostFrame = -1;   // first tick the (static) target was not observed; -1 = observed
        bool insideCoverage = false; // log once on entering coverage and once when clear again
        bool escaping = false;     // finish leaving coverage before considering another raid
        int exploreIndex = 0;      // rotate bounded backline probes after arrival/blocked approaches
        int escapeAttempt = 0;     // do not repeat an unreachable escape bearing forever
        int lastDirectLog = -100000; // `detour`/`blocked` lines at most once per 30 s per raider
        int nextTargetScan = 0;     // next tick a target-less raider may replan for a new contact
        bool queued = false;
        // Pile-up breakthrough (owner 2026-11-07).
        AIFloat3 edgeAnchor;
        int edgeSince = -1;         // first tick at a coverage edge near edgeAnchor; -1 = not at an edge
        bool rushing = false;
        int rushUntil = 0;          // rush timeout frame
        AIFloat3 rushFrom;
        float rushLength = 0.0f;
        int rushCooldownUntil = 0;
    }

    array<Raider@> raiders;
    array<int> natives;             // scout ids deliberately left to native CScoutTask
    array<int> replanQueue;         // raider ids, FIFO
    int lastTick = -100000;
    bool configRead = false, jsonEnabled = false;
    dictionary unitSet;
    bool unitsReady = false;

    bool Active()
    {
        if (!configRead) {
            // Configuration is fixed for this AI instance.
            // Native CSetupManager::CloseConfig keeps the "scout_raid" section
            // readable after init (D-296); other sections are gone by now.
            jsonEnabled = aiSetupMgr.ConfigBool("scout_raid/enabled", false);
            configRead = true;
            aiBattle.SetUnknownHazardRange(Global::ScoutRaid::UnknownHazardRange);
            string units;
            for (uint i = 0; i < Global::ScoutRaid::Units.length(); ++i) units += (i > 0 ? "," : "") + Global::ScoutRaid::Units[i];
            GenericHelpers::LogUtil("[ScoutRaid] enabled=" + (Global::ScoutRaid::Enabled && jsonEnabled) + " json=" + jsonEnabled
                + " units=" + units + " max=" + Global::ScoutRaid::MaxRaiders + " keepNative=" + Global::ScoutRaid::KeepNativeScouts, 1);
        }
        return Global::ScoutRaid::Enabled && jsonEnabled;
    }

    bool IsRaidDef(const CCircuitDef@ d)
    {
        if (d is null) return false;
        if (!unitsReady) {
            for (uint i = 0; i < Global::ScoutRaid::Units.length(); ++i) unitSet.set(Global::ScoutRaid::Units[i], true);
            unitsReady = true;
        }
        return unitSet.exists(d.GetName()) && !Spam::IsSpamDef(d);
    }

    Raider@ Find(int id)
    {
        for (uint i = 0; i < raiders.length(); ++i) if (raiders[i].id == id) return raiders[i];
        return null;
    }

    float KindWeight(int kind)
    {
        float w = 0.0f;
        if ((kind & 4) != 0) w = AiMax(w, Global::ScoutRaid::NanoWeight);   // CBattleAnalysis::K_NANO
        if ((kind & 1) != 0) w = AiMax(w, Global::ScoutRaid::MexWeight);    // K_MEX
        if ((kind & 2) != 0) w = AiMax(w, Global::ScoutRaid::WindWeight);   // K_WIND
        if ((kind & 8) != 0) w = AiMax(w, Global::ScoutRaid::OtherEconomyWeight); // K_OTHER_ECO
        return w;
    }

    bool IsRaidKind(int kind) { return KindWeight(kind) > 0.0f; }

    float Range(const CCircuitDef@ d)
    {
        return AiMax(48.0f, d.GetMaxRange() * Global::ScoutRaid::StandoffFraction);
    }

    AIFloat3 Standoff(const AIFloat3& in from, const AIFloat3& in target, float range)
    {
        const float distance = from.distance2D(target);
        if (distance <= range) return from;
        AIFloat3 p = target + (from - target) * (range / distance);
        p.y = aiBattle.Height(p);
        return p;
    }

    // Best economy target by ScoutRaidMath::Score whose standoff point lies
    // outside observed armed coverage. O(G). radius < 0 means anywhere.
    int Choose(const AIFloat3& in from, const AIFloat3& in near, float radius, int exclude,
        const array<AIFloat3>& in starts, const AIFloat3& in front, float range, AIFloat3& out pos)
    {
        int best = -1;
        float bestScore = 0.0f;
        pos = from;
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            const int kind = aiBattle.GetGroundContactKind(i);
            const float weight = KindWeight(kind);
            if (weight <= 0.0f) continue;
            const int id = aiBattle.GetGroundContactId(i);
            if (id == exclude) continue;
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            if (radius >= 0.0f && MapHelpers::SqDist(p, near) > radius * radius) continue;
            float toStart = -1.0f;
            for (uint s = 0; s < starts.length(); ++s) {
                const float d = p.distance2D(starts[s]);
                if (toStart < 0.0f || d < toStart) toStart = d;
            }
            const float fromFront = front.x < 0.0f ? -1.0f : p.distance2D(front);
            float score = ScoutRaidMath::Score(weight, aiBattle.GetGroundContactCost(i),
                ScoutRaidMath::Rear(toStart, fromFront), from.distance2D(p));
            // Spread raiders: a target another raider already holds is worth less.
            for (uint r = 0; r < raiders.length(); ++r) if (raiders[r].target == id) { score *= 0.5f; break; }
            if (score <= bestScore) continue;
            // A defended target (standoff inside coverage) is skipped, not fought.
            if (aiBattle.GroundHazard(Standoff(from, p, range), Global::ScoutRaid::HazardMargin) > 0.0f) continue;
            best = id; bestScore = score; pos = p;
        }
        return best;
    }

    bool LandPassable(const AIFloat3& in p)
    {
        return aiBattle.IsPassable(p, Lanes::LAND) || aiBattle.IsPassable(p, Lanes::BOT);
    }

    // Nearest passable ground near a point (the enemy start itself can be a
    // cliff, border strip or lake centre: glitters (4000,9800) is impassable).
    // Rings of 128 elmos, 16 bearings, outside observed armed coverage when
    // possible. At most 12*16 terrain/coverage lookups per budgeted plan;
    // cached candidates are rechecked against current movement area/coverage.
    dictionary snappedGoals;
    AIFloat3 SnapGoal(const AIFloat3& in goal, CCircuitUnit@ unit, bool useCache = true, int bearing = 0)
    {
        const string key = "" + unit.circuitDef.id + ":" + int(goal.x) + "," + int(goal.z);
        AIFloat3 cached;
        // Terrain candidates are reusable, enemy coverage is not. Escape
        // positions are transient and must never grow this finite goal cache.
        if (useCache && snappedGoals.get(key, cached)
            && aiTerrainMgr.CanMoveTo(unit, cached)
            && aiBattle.GroundHazard(cached, Global::ScoutRaid::HazardMargin) <= 0.0f) return cached;
        AIFloat3 best = goal;
        if (!LandPassable(goal) || !aiTerrainMgr.CanMoveTo(unit, goal)
            || aiBattle.GroundHazard(goal, Global::ScoutRaid::HazardMargin) > 0.0f) {
            AIFloat3 fallback(-1.0f, 0.0f, -1.0f);
            bool found = false;
            for (int ring = 1 + AiMin(3, bearing / 16); ring <= 12 && !found; ++ring) {
                for (int k = 0; k < 16; ++k) {
                    const float angle = float((k + bearing) % 16) * 0.392699f;
                    AIFloat3 p = goal + AIFloat3(cos(angle), 0.0f, sin(angle)) * float(ring * 128);
                    if (p.x < 64.0f || p.z < 64.0f || p.x > AiTerrainWidth() - 64.0f || p.z > AiTerrainHeight() - 64.0f) continue;
                    if (!LandPassable(p) || !aiTerrainMgr.CanMoveTo(unit, p)) continue;
                    if (fallback.x < 0.0f) fallback = p;
                    if (aiBattle.GroundHazard(p, Global::ScoutRaid::HazardMargin) > 0.0f) continue;
                    best = p; found = true; break;
                }
            }
            if (!found && fallback.x >= 0.0f) best = fallback;
            best.y = aiBattle.Height(best);
            GenericHelpers::LogUtil("[ScoutRaid] goal snapped from=(" + int(goal.x) + "," + int(goal.z) + ") to=("
                + int(best.x) + "," + int(best.z) + ") passable=" + LandPassable(best), 1);
        }
        if (useCache) snappedGoals.set(key, best);
        return best;
    }

    // Straight leg a->b sampled every WaypointSpacing (so the 3-waypoint hazard
    // check and the hold apply to it); appends only clear samples and returns
    // false at the first covered one. O(length / spacing) hazard lookups.
    bool SampleLeg(const AIFloat3& in a, const AIFloat3& in b, float margin, array<AIFloat3>@ result)
    {
        const int steps = AiMax(1, int(a.distance2D(b) / Global::ScoutRaid::WaypointSpacing));
        for (int i = 1; i <= steps; ++i) {
            AIFloat3 p = a + (b - a) * (float(i) / float(steps));
            p.y = aiBattle.Height(p);
            if (aiBattle.GroundHazard(p, margin) > 0.0f) return false;
            result.insertLast(p);
        }
        return true;
    }

    // Fallback when the lane grid has no route (played: glitters' halves are
    // not connected for bots on the 64-elmo lane grid although the engine
    // fords them). Never a blind two-point move through coverage: the straight
    // line is sampled; if it crosses coverage, up to 24 one/two-corner detours
    // of up to 2400 elmos are tested. Cost is O(24*L/spacing) hazard lookups.
    // Otherwise stop at the clear prefix and retry/retarget at its end.
    array<AIFloat3>@ DirectRoute(Raider@ r, const AIFloat3& in from, const AIFloat3& in goal, float margin)
    {
        const int unitId = r.id;
        // Replans recur every 4-60 s per raider; one line per 30 s is enough.
        const bool say = ai.frame - r.lastDirectLog >= 30 * SECOND;
        array<AIFloat3> route = {from};
        if (SampleLeg(from, goal, margin, route)) return route;
        const AIFloat3 clear = route[route.length() - 1];
        AIFloat3 dir = goal - from; dir.y = 0.0f;
        const float len = dir.Length2D();
        if (len > 1.0f) {
            const AIFloat3 side(-dir.z / len, 0.0f, dir.x / len);
            // Lateral offsets of 600..2400 either side, each also pushed 0, 600
            // or 1200 elmos forward: a forward-shifted corner often clears the
            // return leg where a purely lateral one still crosses coverage.
            for (int k = 1; k <= 4; ++k) for (int s = -1; s <= 1; s += 2) for (int j = 0; j <= 2; ++j) {
                AIFloat3 d = clear + side * float(s * k) * 600.0f + dir * (float(j) * 600.0f / len);
                if (d.x < 64.0f || d.z < 64.0f || d.x > AiTerrainWidth() - 64.0f || d.z > AiTerrainHeight() - 64.0f) continue;
                if (!LandPassable(d) || aiBattle.GroundHazard(d, margin) > 0.0f) continue;
                array<AIFloat3> legs;
                if (!SampleLeg(clear, d, margin, legs)) continue;
                array<AIFloat3> tail;
                if (!SampleLeg(d, goal, margin, tail)) {
                    // A wide screen needs two corners: follow its flank before
                    // turning back toward the economy, not a diagonal through it.
                    AIFloat3 far = goal + side * float(s * k) * 600.0f;
                    if (far.x < 64.0f || far.z < 64.0f || far.x > AiTerrainWidth() - 64.0f
                        || far.z > AiTerrainHeight() - 64.0f || !LandPassable(far)) continue;
                    tail.resize(0);
                    if (!SampleLeg(d, far, margin, tail) || !SampleLeg(far, goal, margin, tail)) continue;
                }
                for (uint t = 0; t < tail.length(); ++t) legs.insertLast(tail[t]);
                for (uint i = 0; i < legs.length(); ++i) route.insertLast(legs[i]);
                if (say) {
                    r.lastDirectLog = ai.frame;
                    GenericHelpers::LogUtil("[ScoutRaid] detour unit=" + unitId + " around (" + int(clear.x) + "," + int(clear.z)
                        + ") via (" + int(d.x) + "," + int(d.z) + ")", 1);
                }
                return route;
            }
        }
        if (say) {
            r.lastDirectLog = ai.frame;
            GenericHelpers::LogUtil("[ScoutRaid] blocked unit=" + unitId + " waits at (" + int(clear.x) + "," + int(clear.z)
                + ") coverage ahead, no detour", 1);
        }
        return route;
    }

    AIFloat3 FallbackGoal(CCircuitUnit@ unit, const AIFloat3& in from, const array<AIFloat3>& in starts, int exploreIndex)
    {
        AIFloat3 goal(-1.0f, 0.0f, -1.0f);
        float nearest = 1e30f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float d = MapHelpers::SqDist(from, starts[i]);
            if (d < nearest) { nearest = d; goal = starts[i]; }
        }
        if (goal.x < 0.0f) return goal;
        // Search other parts of the enemy backline after a probe is exhausted.
        // Nine stable keys per start keep SnapGoal's cache bounded.
        const int probe = exploreIndex % 9;
        if (probe > 0) {
            const float angle = float(probe - 1) * 0.785398f;
            goal = goal + AIFloat3(cos(angle), 0.0f, sin(angle)) * 1400.0f;
            goal.x = AiMax(64.0f, AiMin(AiTerrainWidth() - 64.0f, goal.x));
            goal.z = AiMax(64.0f, AiMin(AiTerrainHeight() - 64.0f, goal.z));
        }
        return SnapGoal(goal, unit);
    }

    // Compact a 64-elmo grid route: turns, reversals and every WaypointSpacing.
    array<AIFloat3>@ Compact(const array<AIFloat3>& in points)
    {
        array<AIFloat3> result;
        if (points.length() == 0) return result;
        result.reserve(points.length() / 3 + 2);
        result.insertLast(points[0]);
        float since = 0.0f;
        for (uint i = 1; i + 1 < points.length(); ++i) {
            const AIFloat3 a = points[i - 1], b = points[i], c = points[i + 1];
            since += a.distance2D(b);
            if (ScoutRaidMath::Keep(b.x - a.x, b.z - a.z, c.x - b.x, c.z - b.z, since, Global::ScoutRaid::WaypointSpacing)) {
                result.insertLast(b); since = 0.0f;
            }
        }
        if (points.length() > 1) result.insertLast(points[points.length() - 1]);
        return result;
    }

    CRouteTask@ NewRoute(const CCircuitDef@ def)
    {
        IUnitTask@ task = aiMilitaryMgr.Enqueue(TaskF::Route());
        CRouteTask@ route = cast<CRouteTask>(cast<IFighterTask>(task));
        if (route is null) return null;
        // A Tick's 140 range cannot tolerate the old 48-elmo arrival radius
        // around a 112-elmo standoff point: it could hold outside gun range.
        route.SetTraversal(true, AiMax(16.0f, AiMin(48.0f, def.GetMaxRange() * 0.1f)), false);
        route.SetHoldPosition(true);   // never chase: wrap-around is the route's job
        route.SetLanes(1, 0, 0);
        return route;
    }

    void Plan(Raider@ r, CCircuitUnit@ u)
    {
        if (r.rushing) { r.queued = false; return; }   // the rush owns the route until it ends
        const AIFloat3 pos = u.GetPos(ai.frame);
        const array<AIFloat3> starts = Lanes::EnemyStarts();
        const AIFloat3 front = aiMilitaryMgr.GetCombatFocusPos();
        const float range = Range(u.circuitDef);
        int target = r.target;
        AIFloat3 targetPos = r.targetPos;
        if (target >= 0 && r.hazardReplans >= 2) {
            // The only approach to this target stays covered: give it up.
            r.excluded = target; target = -1; r.hazardReplans = 0;
        }
        // Economy targets are static: one that left sensor range is still
        // there. Keep it (remembered position) until the raider has arrived and
        // still sees nothing, or 45 s pass without an observation (round 12:
        // four `target gone` on mexes that merely left a detouring Rover's sight).
        AIFloat3 seen;
        const bool alive = target >= 0 && ContactAlive(target, seen);
        if (alive) targetPos = seen;
        const bool remembered = target >= 0 && !alive && r.targetLostFrame >= 0
            && ai.frame - r.targetLostFrame <= 45 * SECOND
            && MapHelpers::SqDist(pos, r.targetPos) >= 400.0f * 400.0f;
        if (target < 0 || (!alive && !remembered)) {
            const AIFloat3 last = r.target >= 0 ? r.targetPos : pos;
            target = Choose(pos, last, Global::ScoutRaid::ChainRadius, r.excluded, starts, front, range, targetPos);
            if (target < 0) target = Choose(pos, pos, -1.0f, r.excluded, starts, front, range, targetPos);
        }
        const bool wasEscaping = r.escaping;
        r.escaping = aiBattle.GroundHazard(pos, Global::ScoutRaid::HazardMargin) > 0.0f;
        r.escapeAttempt = r.escaping && wasEscaping ? r.escapeAttempt + 4 : 0;
        // Escape is a separate short route. Hard blocking a whole covered
        // starting region would strand the scout; soft cost finds its way out.
        const AIFloat3 goal = r.escaping ? SnapGoal(pos, u, false, r.escapeAttempt)
            : (target >= 0 ? Standoff(pos, targetPos, range) : FallbackGoal(u, pos, starts, r.exploreIndex));
        r.queued = false;
        r.hazardSince = -1;
        r.lastMove = ai.frame; r.lastPos = pos;
        if (goal.x < 0.0f) return;
        array<AIFloat3>@ path = aiBattle.GetUnitRaidRoute(u.circuitDef, pos, goal,
            Global::ScoutRaid::HazardMargin, Global::ScoutRaid::HazardWeight, !r.escaping);
        bool direct = false;
        if (path is null || path.length() < 2) {
            // No hazard-aware route (edge cell, fine corridor rejected, goal
            // unreachable on the lane grid). Never leave a raider idle: issue a
            // direct move and let the engine path it; the next replan (after
            // the cooldown, from a new position) retries the hazard route.
            // A targeted contact that stays unreachable is excluded.
            if (target >= 0) r.excluded = target;
            if (ai.frame - r.lastDirectLog >= 30 * SECOND) GenericHelpers::LogUtil("[ScoutRaid] no route unit=" + r.id + " target=" + target
                + " from=(" + int(pos.x) + "," + int(pos.z) + ") pass=" + LandPassable(pos)
                + " goal=(" + int(goal.x) + "," + int(goal.z) + ") pass=" + LandPassable(goal)
                + " hazard=" + aiBattle.GroundHazard(goal, Global::ScoutRaid::HazardMargin) + "; direct move", 1);
            if (r.escaping) {
                // Coarse lane connectivity can reject a corridor the engine
                // walks. Use only the nearest clear escape, never a backline
                // move through the entire defended region.
                @path = array<AIFloat3>();
                path.insertLast(pos); path.insertLast(goal);
            } else {
                @path = DirectRoute(r, pos, goal, Global::ScoutRaid::HazardMargin);
            }
            direct = true;
        }
        // Backoff: 4, 8, 16, 32, 60 s after consecutive solves that could not
        // move the raider at all (a sampled direct route counts as success),
        // 4 s after a success (8v8 full3: 877 failed solves on a flat 4 s).
        const bool failed = path is null || path.length() < 2;
        r.routeFailures = failed ? r.routeFailures + 1 : 0;
        const int backoff = AiMin(60 * SECOND, Global::ScoutRaid::ReplanCooldownSeconds * SECOND * (1 << AiMin(4, r.routeFailures)));
        r.nextReplan = ai.frame + backoff;
        if (path is null) return;
        r.route = direct ? path : Compact(path);
        r.cursor = 0;
        IssueWindow(r);
        // A contact the engine will not accept as a priority target still
        // gets the route; the held priority is then cleared (INV-211).
        if (!r.task.SetLandTarget(r.escaping ? -1 : target)) r.task.SetLandTarget(-1);
        if (target != r.target) { r.hazardReplans = 0; r.targetLostFrame = -1; }
        r.target = target; r.targetPos = targetPos;
        GenericHelpers::LogUtil("[ScoutRaid] route unit=" + r.id + " target=" + target + " points=" + r.route.length()
            + " goal=(" + int(goal.x) + "," + int(goal.z) + ") direct=" + direct + " escape=" + r.escaping, 1);
    }

    // Owner 2026-10-21 (SD-129 command flood): one Flea sent 482 MOVEs in a
    // minute, every replan shift-queueing the whole compacted route (~56
    // points). The task now gets at most MaxIssuedWaypoints points from the
    // cursor; the next window follows as the raider nears its end, at most
    // once per WindowSeconds. <= 0 hands out the whole route as before.
    void IssueWindow(Raider@ r)
    {
        const int cap = Global::ScoutRaid::MaxIssuedWaypoints;
        const uint total = r.route.length();
        if (cap <= 0 || total <= uint(cap) + r.cursor) {
            if (r.cursor == 0) r.task.SetRoute(r.route);
            else {
                array<AIFloat3> rest;
                for (uint i = r.cursor; i < total; ++i) rest.insertLast(r.route[i]);
                r.task.SetRoute(rest);
            }
            r.issuedEnd = total;
        } else {
            array<AIFloat3> window;
            for (uint i = r.cursor; i < r.cursor + uint(cap); ++i) window.insertLast(r.route[i]);
            r.task.SetRoute(window);
            r.issuedEnd = r.cursor + uint(cap);
        }
        r.lastWindow = ai.frame;
    }

    // Current observed ground contact of this id? O(G); only on replans.
    bool ContactAlive(int id, AIFloat3& out pos)
    {
        pos = AIFloat3(-1.0f, 0.0f, -1.0f);
        if (id < 0) return false;
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            if (aiBattle.GetGroundContactId(i) != id) continue;
            pos = aiBattle.GetGroundContactPos(i);
            return true;
        }
        return false;
    }

    void Queue(Raider@ r)
    {
        if (r.queued) return;
        r.queued = true;
        replanQueue.insertLast(r.id);
    }

    void Drop(uint index)
    {
        Raider@ r = raiders[index];
        const int q = replanQueue.find(r.id);
        if (q >= 0) replanQueue.removeAt(uint(q));
        CRouteTask@ task = r.task;
        raiders.removeAt(index);
        if (task !is null && !task.IsDead()) task.Abort();
    }

    void PruneNatives()
    {
        for (int i = int(natives.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(natives[i]) is null) natives.removeAt(uint(i));
    }

    // Military::AiMakeTask, after Spam and before the ranged controller.
    IUnitTask@ MilitaryMakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null || !Active() || !IsRaidDef(u.circuitDef)) return null;
        PruneNatives();
        if (natives.find(u.id) >= 0) return null;   // a recon scout stays native
        // A raider asking again lost its task (abort, stuck recovery): release it.
        for (int i = int(raiders.length()) - 1; i >= 0; --i) if (raiders[i].id == u.id) Drop(uint(i));
        if (int(natives.length()) < Global::ScoutRaid::KeepNativeScouts) {
            natives.insertLast(u.id);
            return null;
        }
        if (int(raiders.length()) >= Global::ScoutRaid::MaxRaiders) return null;
        CRouteTask@ task = NewRoute(u.circuitDef);
        if (task is null) return null;
        Raider@ r = Raider();
        r.id = u.id; @r.task = task;
        r.lastPos = u.GetPos(ai.frame); r.lastMove = ai.frame;
        array<AIFloat3> hold = {r.lastPos};
        task.SetRoute(hold);
        raiders.insertLast(r);
        Queue(r);
        GenericHelpers::LogUtil("[ScoutRaid] admit unit=" + u.id + " def=" + u.circuitDef.GetName()
            + " raiders=" + raiders.length(), 1);
        return task;
    }

    void TaskRemoved(IUnitTask@ task)
    {
        for (uint i = 0; i < raiders.length(); ++i) if (raiders[i].task is task) @raiders[i].task = null;
    }

    void UnitRemoved(CCircuitUnit@ unit)
    {
        if (unit is null) return;
        for (int i = int(raiders.length()) - 1; i >= 0; --i) if (raiders[i].id == unit.id) Drop(uint(i));
        const int n = natives.find(unit.id);
        if (n >= 0) natives.removeAt(uint(n));
    }

    void Reset()
    {
        array<Raider@> old = raiders;
        raiders.resize(0); replanQueue.resize(0); natives.resize(0);
        for (uint i = 0; i < old.length(); ++i)
            if (old[i].task !is null && !old[i].task.IsDead()) old[i].task.Abort();
    }

    // ---- Pile-up breakthrough (owner 2026-11-07) ----
    // Gap searches past grunt/pawn/LLT lines eventually fail and several
    // scouts (Rascal, Rover, Wheelie, Tick) sit just outside the coverage. A
    // pile is PileMinGroup+ scouts, this AI's raiders and allied BARb raiders
    // together, each pinned at a coverage edge for PileSeconds within
    // PileRadius of one another. The AI that sees it picks the bearing toward
    // the enemy side with the fewest overlapping firing ranges, rushes its own
    // members 1000-1200 elmos along it and tells allies ("go") so their
    // members rush the same bearing; afterwards every member replans normally
    // (escape coverage, dodge, raid economy) and is exempt for
    // RushCooldownSeconds.
    //
    // Cost: per raider per tick 9 GroundHazard lookups (same margin as the
    // routes, so the lazy grid is not rebuilt). Pile search O(P^2) over
    // P <= MaxRaiders + allied pins. Bearing choice only on a launch:
    // O(B * S * C) with B bearings, S samples, C armed contacts within reach.
    // Messages: one "pin" per PileShareSeconds while this AI has pinned
    // raiders, one "go" per launch.
    const string PilePrefix = "scoutpile|";
    final class PinnedSet { int frame = 0; array<AIFloat3> pos; }
    dictionary allyPinned;          // team id -> PinnedSet, expires after PileShareTtlSeconds
    int lastShare = -100000;

    bool InMap(const AIFloat3& in p)
    {
        return p.x >= 64.0f && p.z >= 64.0f && p.x <= AiTerrainWidth() - 64.0f && p.z <= AiTerrainHeight() - 64.0f;
    }

    // At a coverage edge: covered here, or within PileEdgeProbe on one of 8 bearings.
    bool NearEdge(const AIFloat3& in pos, float margin)
    {
        if (aiBattle.GroundHazard(pos, margin) > 0.0f) return true;
        const float probe = Global::ScoutRaid::PileEdgeProbe;
        for (int k = 0; k < 8; ++k) {
            const float angle = float(k) * 0.785398f;
            const AIFloat3 p = pos + AIFloat3(cos(angle), 0.0f, sin(angle)) * probe;
            if (InMap(p) && aiBattle.GroundHazard(p, margin) > 0.0f) return true;
        }
        return false;
    }

    // Pinned = at an edge and not getting anywhere (stays within
    // PileAnchorDrift of where it first reached the edge). A raider holding in
    // range of its live target is working, not pinned.
    void UpdatePin(Raider@ r, CCircuitUnit@ u, const AIFloat3& in pos, float margin)
    {
        const bool working = r.target >= 0 && pos.distance2D(r.targetPos) <= u.circuitDef.GetMaxRange() * 1.05f;
        if (working || ai.frame < r.rushCooldownUntil || !NearEdge(pos, margin)) { r.edgeSince = -1; return; }
        const float drift = Global::ScoutRaid::PileAnchorDrift;
        if (r.edgeSince < 0 || MapHelpers::SqDist(pos, r.edgeAnchor) > drift * drift) { r.edgeAnchor = pos; r.edgeSince = ai.frame; }
    }

    bool Pinned(Raider@ r)
    {
        return !r.rushing && r.edgeSince >= 0 && ai.frame - r.edgeSince >= Global::ScoutRaid::PileSeconds * SECOND;
    }

    // Overlap count at p: armed contacts whose land range (or a static
    // reclaimer's build distance) plus margin covers it.
    int Overlap(const AIFloat3& in p, const array<AIFloat3>& in cp, const array<float>& in cr)
    {
        int n = 0;
        for (uint i = 0; i < cp.length(); ++i) if (MapHelpers::SqDist(p, cp[i]) <= cr[i] * cr[i]) ++n;
        return n;
    }

    // Bearing toward the enemy side (nearest enemy start, else the map mirror)
    // with the fewest overlapping firing ranges along a 1000-1200 elmo rush.
    bool ChooseRush(const AIFloat3& in centre, AIFloat3& out dir, float& out length, float& out score, float& out offDeg)
    {
        const array<AIFloat3> starts = Lanes::EnemyStarts();
        AIFloat3 goal(AiTerrainWidth() - centre.x, 0.0f, AiTerrainHeight() - centre.z);
        float nearest = 1e30f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float d = MapHelpers::SqDist(centre, starts[i]);
            if (d < nearest) { nearest = d; goal = starts[i]; }
        }
        float base = atan2(goal.z - centre.z, goal.x - centre.x);
        if (MapHelpers::SqDist(centre, goal) < 64.0f * 64.0f) base = atan2(AiTerrainHeight() * 0.5f - centre.z, AiTerrainWidth() * 0.5f - centre.x);
        const float margin = Global::ScoutRaid::HazardMargin;
        const float maxLen = Global::ScoutRaid::RushMaxElmos, minLen = Global::ScoutRaid::RushMinElmos;
        array<AIFloat3> cp; array<float> cr;
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            const CCircuitDef@ d = ai.GetCircuitDef(aiBattle.GetGroundContactDefId(i));
            if (d is null) continue;
            float range = d.HasSurfToLand() ? d.GetMaxRange(1) : 0.0f;   // CCircuitDef::RangeType::LAND
            if (!d.IsMobile() && d.GetBuildSpeed() > 0.0f) range = AiMax(range, d.GetBuildDistance());
            if (range <= 0.0f) continue;
            range += margin;
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            if (MapHelpers::SqDist(centre, p) > (maxLen + range) * (maxLen + range)) continue;
            cp.insertLast(p); cr.insertLast(range);
        }
        const int bearings = AiMax(1, Global::ScoutRaid::RushBearings);
        const float cone = Global::ScoutRaid::RushConeDegrees * 0.0174533f;
        const float step = AiMax(32.0f, Global::ScoutRaid::RushSampleElmos);
        bool found = false;
        score = 1e30f;
        for (int b = 0; b < bearings; ++b) {
            const float off = bearings == 1 ? 0.0f : cone * (2.0f * float(b) / float(bearings - 1) - 1.0f);
            const AIFloat3 d(cos(base + off), 0.0f, sin(base + off));
            float len = -1.0f;
            for (float l = maxLen; l >= minLen - 1.0f; l -= 100.0f) {
                const AIFloat3 e = centre + d * l;
                if (InMap(e) && LandPassable(e)) { len = l; break; }
            }
            if (len < 0.0f) continue;
            float sum = 0.0f;
            int samples = 0;
            for (float s = step; s <= len + 1.0f; s += step) {
                const AIFloat3 p = centre + d * s;
                sum += float(Overlap(p, cp, cr));
                if (!InMap(p) || !LandPassable(p)) sum += 2.0f;
                ++samples;
            }
            const float value = sum / float(AiMax(1, samples)) + Global::ScoutRaid::RushAnglePenalty * abs(off);
            if (value < score - 0.001f) { score = value; dir = d; length = len; offDeg = off * 57.2958f; found = true; }
        }
        return found;
    }

    // Rush this AI's raiders at the pile (at an edge, not cooling down) along dir.
    int RushMembers(const AIFloat3& in centre, const AIFloat3& in dir, float length, const string& in why)
    {
        const float radius = Global::ScoutRaid::PileRadius * 1.25f;
        int started = 0;
        for (uint i = 0; i < raiders.length(); ++i) {
            Raider@ r = raiders[i];
            if (r.rushing || r.edgeSince < 0 || ai.frame < r.rushCooldownUntil || r.task is null) continue;
            CCircuitUnit@ u = ai.GetTeamUnit(r.id);
            if (u is null) continue;
            const AIFloat3 pos = u.GetPos(ai.frame);
            if (MapHelpers::SqDist(pos, centre) > radius * radius) continue;
            StartRush(r, u, pos, dir, length);
            ++started;
        }
        if (started > 0)
            GenericHelpers::LogUtil("[ScoutRaid] pile rush " + why + " at (" + int(centre.x) + "," + int(centre.z) + ") units=" + started
                + " dir=(" + int(dir.x * 100.0f) + "," + int(dir.z * 100.0f) + ") len=" + int(length), 1);
        return started;
    }

    void StartRush(Raider@ r, CCircuitUnit@ u, const AIFloat3& in pos, const AIFloat3& in dir, float length)
    {
        float len = length;
        AIFloat3 end = pos + dir * len;
        while ((!InMap(end) || !LandPassable(end)) && len > Global::ScoutRaid::RushMinElmos - 1.0f) { len -= 100.0f; end = pos + dir * len; }
        if (!InMap(end)) {
            end.x = AiMax(64.0f, AiMin(AiTerrainWidth() - 64.0f, end.x));
            end.z = AiMax(64.0f, AiMin(AiTerrainHeight() - 64.0f, end.z));
            len = pos.distance2D(end);
        }
        array<AIFloat3> route = {pos};
        const int steps = AiMax(1, int(len / Global::ScoutRaid::WaypointSpacing));
        for (int k = 1; k <= steps; ++k) {
            AIFloat3 p = pos + (end - pos) * (float(k) / float(steps));
            p.y = aiBattle.Height(p);
            route.insertLast(p);
        }
        const int q = replanQueue.find(r.id);
        if (q >= 0) replanQueue.removeAt(uint(q));
        r.queued = false;
        r.route = route; r.cursor = 0;
        IssueWindow(r);
        r.task.SetLandTarget(-1);
        r.target = -1; r.targetLostFrame = -1;
        r.escaping = false; r.insideCoverage = false; r.hazardSince = -1; r.edgeSince = -1;
        r.rushing = true; r.rushFrom = pos; r.rushLength = len;
        r.rushUntil = ai.frame + int((len / AiMax(30.0f, u.circuitDef.GetSpeed()) + float(Global::ScoutRaid::RushExtraSeconds)) * float(SECOND));
        r.lastMove = ai.frame; r.lastPos = pos;
    }

    void EndRush(Raider@ r, const AIFloat3& in pos)
    {
        r.rushing = false;
        r.rushCooldownUntil = ai.frame + Global::ScoutRaid::RushCooldownSeconds * SECOND;
        r.hazardReplans = 0; r.excluded = -1; r.routeFailures = 0; r.nextReplan = 0;
        r.route.resize(0); r.cursor = 0; r.issuedEnd = 0;
        r.lastMove = ai.frame; r.lastPos = pos;
        GenericHelpers::LogUtil("[ScoutRaid] rush end unit=" + r.id + " at (" + int(pos.x) + "," + int(pos.z) + ") moved="
            + int(pos.distance2D(r.rushFrom)) + "/" + int(r.rushLength), 1);
        Queue(r);
    }

    // After the raider loop: share pins, find a pile, launch it.
    void PileTick()
    {
        array<AIFloat3> own;
        for (uint i = 0; i < raiders.length(); ++i) {
            if (!Pinned(raiders[i])) continue;
            CCircuitUnit@ u = ai.GetTeamUnit(raiders[i].id);
            if (u !is null) own.insertLast(u.GetPos(ai.frame));
        }
        if (own.length() == 0) return;
        if (ai.frame - lastShare >= Global::ScoutRaid::PileShareSeconds * SECOND) {
            lastShare = ai.frame;
            string body;
            for (uint i = 0; i < own.length(); ++i) body += (i > 0 ? ";" : "") + int(own[i].x) + "," + int(own[i].z);
            AiSendMessage(PilePrefix + "pin|" + body);
        }
        array<AIFloat3> all = own;
        const int ttl = Global::ScoutRaid::PileShareTtlSeconds * SECOND;
        array<string>@ keys = allyPinned.getKeys();
        for (uint k = 0; k < keys.length(); ++k) {
            PinnedSet@ s;
            if (!allyPinned.get(keys[k], @s) || s is null) continue;
            if (ai.frame - s.frame > ttl) { allyPinned.delete(keys[k]); continue; }
            for (uint i = 0; i < s.pos.length(); ++i) all.insertLast(s.pos[i]);
        }
        if (int(all.length()) < Global::ScoutRaid::PileMinGroup) return;
        const float radius = Global::ScoutRaid::PileRadius;
        for (uint i = 0; i < own.length(); ++i) {
            AIFloat3 sum(0.0f, 0.0f, 0.0f);
            int count = 0;
            for (uint j = 0; j < all.length(); ++j) {
                if (MapHelpers::SqDist(own[i], all[j]) > radius * radius) continue;
                sum = sum + all[j]; ++count;
            }
            if (count < Global::ScoutRaid::PileMinGroup) continue;
            AIFloat3 centre = sum * (1.0f / float(count));
            centre.y = aiBattle.Height(centre);
            AIFloat3 dir; float length = 0.0f, score = 0.0f, offDeg = 0.0f;
            if (!ChooseRush(centre, dir, length, score, offDeg)) continue;
            GenericHelpers::LogUtil("[ScoutRaid] pile found at (" + int(centre.x) + "," + int(centre.z) + ") scouts=" + count
                + " own=" + own.length() + " off=" + int(offDeg) + "deg overlap=" + int(score * 100.0f) / 100.0f + " len=" + int(length), 1);
            if (RushMembers(centre, dir, length, "lead") > 0)
                AiSendMessage(PilePrefix + "go|" + int(centre.x) + "," + int(centre.z) + "|" + int(dir.x * 1000.0f) + "," + int(dir.z * 1000.0f) + "|" + int(length));
            return;   // one pile per tick
        }
    }

    // Team::HandleMessage: an allied BARb's pinned raiders, or its rush call.
    bool HandleMessage(const string &in msg, int fromTeamId)
    {
        if (msg.findFirst(PilePrefix) != 0) return false;
        if (!Active()) return true;
        array<string>@ p = msg.split("|");
        if (p.length() < 3) return true;
        if (p[1] == "pin") {
            PinnedSet s;
            s.frame = ai.frame;
            array<string>@ pts = p[2].split(";");
            for (uint i = 0; i < pts.length() && i < 16; ++i) {
                array<string>@ xz = pts[i].split(",");
                if (xz.length() != 2) continue;
                s.pos.insertLast(AIFloat3(float(parseInt(xz[0])), 0.0f, float(parseInt(xz[1]))));
            }
            allyPinned.set("" + fromTeamId, @s);
        } else if (p[1] == "go" && p.length() >= 5) {
            array<string>@ c = p[2].split(",");
            array<string>@ d = p[3].split(",");
            if (c.length() != 2 || d.length() != 2) return true;
            AIFloat3 centre(float(parseInt(c[0])), 0.0f, float(parseInt(c[1])));
            AIFloat3 dir(float(parseInt(d[0])) / 1000.0f, 0.0f, float(parseInt(d[1])) / 1000.0f);
            const float len = AiMax(Global::ScoutRaid::RushMinElmos, AiMin(Global::ScoutRaid::RushMaxElmos, float(parseInt(p[4]))));
            if (dir.Length2D() < 0.5f) return true;
            RushMembers(centre, dir, len, "join team " + fromTeamId);
        }
        return true;
    }

    // Main::AiUpdate (every 30 frames); self-limited to once per second.
    void Tick()
    {
        if (ai.frame < lastTick + SECOND) return;
        lastTick = ai.frame;
        if (!Active()) { if (raiders.length() > 0) Reset(); return; }
        if (raiders.length() == 0) return;
        const float margin = Global::ScoutRaid::HazardMargin;
        const int cooldown = Global::ScoutRaid::ReplanCooldownSeconds * SECOND;
        // Any economy contact at all? O(G) once per tick; a target-less raider
        // then replans for it on the ordinary cooldown instead of the backoff
        // (round 12: mexes seen at frame 7500, first targeted route at 8670).
        bool anyRaidTarget = false;
        {
            const int n = aiBattle.GetGroundContactCount();
            for (int c = 0; c < n && !anyRaidTarget; ++c) anyRaidTarget = IsRaidKind(aiBattle.GetGroundContactKind(c));
        }
        for (int i = int(raiders.length()) - 1; i >= 0; --i) {
            Raider@ r = raiders[i];
            CCircuitUnit@ u = ai.GetTeamUnit(r.id);
            if (u is null || r.task is null || r.task.IsDead() || u.task !is r.task) { Drop(uint(i)); continue; }
            const AIFloat3 pos = u.GetPos(ai.frame);
            // INV-211: the raider's priority target is its chosen economy target.
            const int held = r.task.GetPriorityTarget();
            if (held >= 0 && held != r.target)
                Invariants::Violation("INV-211", "" + r.id, "scout raider " + r.id + " holds target " + held
                    + " not chosen by ScoutRaid (" + r.target + ")");
            bool observed = false;
            if (r.target >= 0) {
                const int n = aiBattle.GetGroundContactCount();
                for (int c = 0; c < n; ++c) {
                    if (aiBattle.GetGroundContactId(c) != r.target) continue;
                    observed = true;
                    if (!IsRaidKind(aiBattle.GetGroundContactKind(c)))
                        Invariants::Violation("INV-211", "" + r.id, "scout raider " + r.id + " targets non-economy contact " + r.target);
                    break;
                }
            }
            bool targetLost = false;
            if (r.target >= 0) {
                if (observed) {
                    r.targetLostFrame = -1;
                    // Re-arm the BAR priority target once the contact is in sensor
                    // range again (SetLandTarget needs an observed contact).
                    if (!r.escaping && held != r.target) r.task.SetLandTarget(r.target);
                } else {
                    if (r.targetLostFrame < 0) r.targetLostFrame = ai.frame;
                    // Static target: destroyed only if the raider has arrived and
                    // still sees nothing, or nobody has seen it for 45 s.
                    targetLost = MapHelpers::SqDist(pos, r.targetPos) < 400.0f * 400.0f
                        || ai.frame - r.targetLostFrame > 45 * SECOND;
                }
            }
            // Progress along the issued route; stuck detection.
            while (r.cursor < r.route.length() && MapHelpers::SqDist(pos, r.route[r.cursor]) < 128.0f * 128.0f) ++r.cursor;
            if (MapHelpers::SqDist(pos, r.lastPos) > 64.0f * 64.0f) { r.lastPos = pos; r.lastMove = ai.frame; }
            // The next window when the raider is within two points of the
            // handed-out end (or standing on it).
            const bool windowEnd = r.issuedEnd < r.route.length() && (r.cursor + 2 >= r.issuedEnd || r.task.IsAtEnd(u));
            if (windowEnd && ai.frame - r.lastWindow >= Global::ScoutRaid::WindowSeconds * SECOND) IssueWindow(r);
            const bool atEnd = r.task.IsAtEnd(u) && r.issuedEnd >= r.route.length();
            const bool stuck = !atEnd && ai.frame - r.lastMove > Global::ScoutRaid::StuckSeconds * SECOND;
            // Pile-up breakthrough: a rushing raider ignores coverage (no hold,
            // no escape) until it has covered the rush, reached its end or
            // timed out; then it replans like any raider (escape first).
            if (r.rushing) {
                if (atEnd || ai.frame >= r.rushUntil || pos.distance2D(r.rushFrom) >= r.rushLength - 96.0f) EndRush(r, pos);
                continue;
            }
            if (Global::ScoutRaid::PileRushEnabled) UpdatePin(r, u, pos, margin);
            // Wrap-around trigger: a contact now covers a waypoint within the
            // lookahead (at least the next 3). Sensor->enemy-cache->hazard->tick
            // latency is 2-3 s, 260-400 elmos for a Tick (round 12: a Tick ran
            // from 548 elmos into an LLT seen 3 s earlier), so look 1200 ahead.
            bool hazardAhead = false;
            float ahead = 0.0f;
            AIFloat3 previous = pos;
            // Faster scouts need a longer lookahead: 10 s of travel (Rover 168
            // elmo/s -> 1680) or LookaheadElmos, whichever is larger.
            const float lookahead = AiMax(Global::ScoutRaid::LookaheadElmos, Global::ScoutRaid::LookaheadSeconds * u.circuitDef.GetSpeed());
            for (uint k = r.cursor; !r.escaping && k < r.route.length() && (ahead < lookahead || k < r.cursor + 3); ++k) {
                if (aiBattle.GroundHazard(r.route[k], margin) > 0.0f) { hazardAhead = true; break; }
                ahead += previous.distance2D(r.route[k]); previous = r.route[k];
            }
            const bool covered = aiBattle.GroundHazard(pos, margin) > 0.0f;
            if (hazardAhead && !covered) {
                if (r.hazardSince < 0) {
                    r.hazardSince = ai.frame;
                    // A fast scout covers 130+ elmos per second: stop now, at
                    // the first covered waypoint, rather than run on until the
                    // budgeted replan. One extra MOVE per hazard episode.
                    array<AIFloat3> hold = {pos};
                    r.task.SetRoute(hold);
                    r.route.resize(0); r.cursor = 0; r.issuedEnd = 0;
                    // Queue now: clearing the route also clears next tick's
                    // hazardAhead signal. A live economy target otherwise
                    // leaves this one-point hold permanent (single Tick case).
                    ++r.hazardReplans;
                    Queue(r);
                    GenericHelpers::LogUtil("[ScoutRaid] hazard ahead unit=" + r.id + " hold at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
                }
            }
            // Do not overwrite an active escape with a hold at its own
            // position. A newly covered scout gets one immediate escape plan;
            // normal stuck recovery still handles a blocked escape.
            if (covered) {
                if (!r.insideCoverage) {
                    r.insideCoverage = true;
                    GenericHelpers::LogUtil("[ScoutRaid] inside coverage unit=" + r.id + " at (" + int(pos.x) + "," + int(pos.z)
                        + "); seeking clear ground", 1);
                }
                if (!r.escaping) Queue(r);
            } else if (r.escaping || r.insideCoverage) {
                r.escaping = false;
                r.insideCoverage = false;
                GenericHelpers::LogUtil("[ScoutRaid] clear of coverage unit=" + r.id + " at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
                Queue(r);
            }
            // A partial safe route can finish far short of a live target.
            // Only holding within firing distance is productive arrival.
            const bool idleAtEnd = atEnd && (r.escaping || r.target < 0
                || pos.distance2D(r.targetPos) > u.circuitDef.GetMaxRange() * 0.95f);
            const bool wantTarget = !r.escaping && r.target < 0 && anyRaidTarget && ai.frame >= r.nextTargetScan;
            if (wantTarget) r.nextTargetScan = ai.frame + cooldown;
            if (!r.queued && (targetLost || stuck || idleAtEnd || wantTarget) && (ai.frame >= r.nextReplan || wantTarget)) {
                if (idleAtEnd || stuck) {
                    if (r.target >= 0 && !r.escaping) ++r.hazardReplans;
                    else if (!r.escaping) ++r.exploreIndex;
                }
                if (targetLost && LOG_LEVEL >= 1)
                    GenericHelpers::LogUtil("[ScoutRaid] target gone unit=" + r.id + " target=" + r.target, 1);
                Queue(r);
            }
            // INV-212: covered waypoints ahead get a queued replan in time.
            if (ScoutRaidMath::HazardOverdue(r.hazardSince, ai.frame, cooldown, 2 * SECOND, r.queued))
                Invariants::Violation("INV-212", "" + r.id, "scout raider " + r.id + " keeps a covered route without a replan");
        }
        // Serve replans FIFO within the per-second route budget.
        int budget = Global::ScoutRaid::MaxRoutesPerSecond;
        while (budget > 0 && replanQueue.length() > 0) {
            const int id = replanQueue[0];
            replanQueue.removeAt(0);
            Raider@ r = Find(id);
            if (r is null) continue;
            CCircuitUnit@ u = ai.GetTeamUnit(id);
            if (u is null || r.task is null) { r.queued = false; continue; }
            Plan(r, u);
            --budget;
        }
        if (Global::ScoutRaid::PileRushEnabled) PileTick();
        // INV-213: raider count bound and spam exclusion.
        if (int(raiders.length()) > Global::ScoutRaid::MaxRaiders)
            Invariants::Violation("INV-213", "count", "scout raiders " + raiders.length() + " exceed " + Global::ScoutRaid::MaxRaiders);
        for (uint i = 0; i < raiders.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(raiders[i].id);
            if (u !is null && Spam::IsSpamDef(u.circuitDef))
                Invariants::Violation("INV-213", "" + raiders[i].id, "spam unit " + raiders[i].id + " is a scout raider");
        }
    }
}
