// Commander-group T1.5 AA against bomber raids (owner, 2026-11-14).
//
// While the armed enemy air the ally team currently sees within Radius of the
// FRONT commander is worth at least TriggerMetal, the defence planner's slot
// Slot (a T1.5 AA turret) is switched on for HoldSeconds after the last such
// sighting. The turret is one of the side's pair, 50% each, re-rolled every
// time one of ours is started:
//   Armada  Ferret / Chainsaw      (armferret / armcir)
//   Cortex  SAM / Eradicator       (cormadsam / corerad)
//   Legion  Rhapsis / Lupara       (legrhapsis / leglupara)
// TriggerMetal (750) is the raid the owner named: Pyroglacious's T1 raid on
// Entrenched Plains 2026-11-14 (6-7 Shadows, 900-1050 metal, over the
// commanders of teams 12 and 14) minus 1-2 bombers, i.e. 5 Shadows. Air
// contacts carry no def in script, so armed fighters count as well.
//
// Who builds it: first the native planner (CommanderDefense.cpp) with the
// slot's air weight, so placement, funding, coverage and the group limit stay
// native. Only T1 constructors build these turrets, and the group often has no
// free T1 seat (needs_builder; first headless test: 2 turrets from 24 raids).
// So when no turret of the pair has started FallbackSeconds after a raid
// switched the row on, Fallback() gives the nearest free T1 constructor within
// FallbackReach of the commander a direct order for the pick, FallbackBack
// elmos behind the commander toward our start (one order per raid).
//
// Cost: one pass over the ally-visible air contacts once a second (the
// snapshot CBattleAnalysis already keeps), FRONT only, no messages. The
// fallback scans our owned units once per raid and issues at most one order.
// SetDefenseRule is called only when the state or the pick changes.
// Null safety: commander, defs and contacts are checked at use.
namespace CommanderGroupAirAA {
    const int Slot = 17;
    bool loaded = false;
    bool enabled = true;
    float radius = 1800.0f;
    float triggerMetal = 750.0f;
    float holdSeconds = 60.0f;
    float priority = 3.0f;
    int next = 0;
    int lastTrigger = -100000;
    bool active = false;
    int generation = -1;           // DefensePlanner load the slot was last written for
    string pick = "";
    int pickCount = 0;             // our units of the pick when it was rolled
    array<string> pair;
    float fallbackSeconds = 10.0f, fallbackReach = 3000.0f, fallbackBack = 150.0f, orderSeconds = 180.0f;
    int onFrame = -1;              // frame this raid switched the row on
    int pairAtOn = 0;              // our pair turrets (both defs) when it did
    bool ordered = false;          // this raid's fallback order was given
    IUnitTask@ pending;
    int orderFrame = 0;

    float Setting(const string &in key, float fallback) {
        return aiSetupMgr.ConfigFloat("commander/defense/air_t15/" + key, fallback);
    }

    void Load() {
        if (loaded) return;
        loaded = true;
        enabled = Setting("enabled", 1) != 0;
        radius = Setting("radius", 1800);
        triggerMetal = Setting("trigger_metal", 750);
        holdSeconds = Setting("hold_seconds", 60);
        priority = Setting("priority", 3);
        fallbackSeconds = Setting("fallback_seconds", 10);
        fallbackReach = Setting("fallback_reach", 3000);
        fallbackBack = Setting("fallback_back", 150);
        orderSeconds = Setting("order_seconds", 180);
        const string side = Global::AISettings::Side.length() > 0 ? Global::AISettings::Side : ai.GetSideName();
        pair.resize(0);
        if (side == "cortex") { pair.insertLast("cormadsam"); pair.insertLast("corerad"); }
        else if (side == "legion") { pair.insertLast("legrhapsis"); pair.insertLast("leglupara"); }
        else { pair.insertLast("armferret"); pair.insertLast("armcir"); }
    }

    // 50% each. Keeps the planner slot's catalog def in step with the pick.
    void Roll() {
        if (pair.length() == 0) return;
        pick = pair[AiRandom(0, int(pair.length()) - 1)];
        CCircuitDef@ def = ai.GetCircuitDef(pick);
        if (def is null) return;
        pickCount = def.count;
        aiBuilderMgr.SetDefenseRule(Slot, "def", float(def.id));
        if (def.IsBuildAllowed() && def.maxThisUnit < 32) def.maxThisUnit = 32;
    }

    int PairCount() {
        int n = 0;
        for (uint i = 0; i < pair.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(pair[i]);
            if (d !is null) n += d.count;
        }
        return n;
    }

    void Apply(bool on) {
        if (on && !active) { onFrame = ai.frame; pairAtOn = PairCount(); ordered = false; }
        active = on;
        generation = DefensePlanner::generation;
        if (on) Roll();
        aiBuilderMgr.SetDefenseRule(Slot, "priority", on ? priority : 0.0f);
        GenericHelpers::LogUtil("[CommanderGroupAA] " + (on ? "on pick=" + pick : "off"), 1);
    }

    // Armed enemy air (bombers, gunships, armed fighters) the ally team sees
    // now within radius of p, by metal cost.
    float AirNear(const AIFloat3 &in p) {
        const float sq = radius * radius;
        float metal = 0.0f;
        for (int i = 0; i < aiBattle.GetAirContactCount(); ++i)
            if (aiBattle.IsAirContactArmed(i) && MapHelpers::SqDist(p, aiBattle.GetAirContactPos(i)) <= sq)
                metal += aiBattle.GetAirContactCost(i);
        return metal;
    }

    void Update() {
        if (Global::AISettings::Role != AiRole::FRONT) return;
        Load();
        if (!enabled || ai.frame < next) return;
        next = ai.frame + SECOND;
        // A planner reload (role or mode change) rewrote the slot: restate ours.
        if (generation != DefensePlanner::generation) Apply(active);
        CCircuitUnit@ cmdr = ai.GetTeamUnit(aiBuilderMgr.FrontCommanderId());
        if (cmdr !is null) {
            const float seen = AirNear(cmdr.GetPos(ai.frame));
            if (seen >= triggerMetal) {
                if (!active) GenericHelpers::LogUtil("[CommanderGroupAA] raid metal=" + int(seen)
                    + " trigger=" + int(triggerMetal) + " cmdr=" + cmdr.id, 1);
                lastTrigger = ai.frame;
                if (!active) Apply(true);
            }
        }
        // A turret of the current pick was started (def.count, no unit scan):
        // the next one is a fresh 50/50.
        if (active) {
            CCircuitDef@ def = ai.GetCircuitDef(pick);
            if (def !is null && def.count > pickCount) {
                GenericHelpers::LogUtil("[CommanderGroupAA] started " + pick + " count=" + def.count, 1);
                Roll();
            }
        }
        Fallback();
        if (active && ai.frame - lastTrigger > int(holdSeconds * SECOND)) Apply(false);
    }

    // Re-asks of the constructor on our order keep the same task (native would
    // swap it off). FRONT builder ask, ahead of every other rung.
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null || pending is null || pending.IsDead()) return null;
        return u.task is pending ? pending : null;
    }

    // The fallback: once per raid, FallbackSeconds after the row switched on
    // with no pair turret started, the nearest free T1 constructor within
    // FallbackReach of the commander gets the pick. One owned-unit scan per
    // raid (not per second); played: native asks never reached it (test 2/3).
    void Fallback() {
        if (!active || ordered || onFrame < 0 || ai.frame - onFrame < int(fallbackSeconds * SECOND)) return;
        if (pending !is null && !pending.IsDead()) return;
        ordered = true;
        if (PairCount() > pairAtOn) return;   // the planner started one
        CCircuitDef@ d = ai.GetCircuitDef(pick);
        CCircuitUnit@ cmdr = ai.GetTeamUnit(aiBuilderMgr.FrontCommanderId());
        if (d is null || cmdr is null) return;
        const AIFloat3 c = cmdr.GetPos(ai.frame);
        CCircuitUnit@ best = null;
        float bestSq = fallbackReach * fallbackReach;
        int capable = 0, busy = 0;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || !u.circuitDef.IsMobile() || UnitHelpers::IsCommander(u.circuitDef)
                || !u.circuitDef.CanBuild(d) || u.GetBuildProgress() < 1.0f) continue;
            // The held energy and converter seats keep their own work (INV-250; test 5).
            const int seat = FrontConstructors::Seat(u.id);
            if (seat == FrontConstructors::ENERGY || seat == FrontConstructors::CONVERTER) continue;
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), c);
            if (sq > fallbackReach * fallbackReach) continue;
            ++capable;
            if (!FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) { ++busy; continue; }
            if (sq < bestSq) { bestSq = sq; @best = u; }
        }
        if (best is null) {
            GenericHelpers::LogUtil("[CommanderGroupAA] fallback none: " + pick + " capable=" + capable + " busy=" + busy, 1);
            return;
        }
        AIFloat3 at = c;
        const AIFloat3 home = Global::Map::StartPos;
        const float dx = home.x - c.x, dz = home.z - c.z;
        const float len = sqrt(dx * dx + dz * dz);
        if (len > 1.0f) { at.x += dx / len * fallbackBack; at.z += dz / len * fallbackBack; }
        if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, at,
            SQUARE_SIZE * 32, true, int(orderSeconds * SECOND)));
        if (t is null) { GenericHelpers::LogUtil("[CommanderGroupAA] fallback order refused " + pick, 1); return; }
        @pending = t;
        orderFrame = ai.frame;
        aiBuilderMgr.AssignTask(best, t);
        GenericHelpers::LogUtil("[CommanderGroupAA] fallback " + pick + " by " + best.circuitDef.GetName() + " " + best.id
            + " at (" + int(at.x) + "," + int(at.z) + ") dist=" + int(sqrt(bestSq)), 1);
    }

    void TaskRemoved(IUnitTask@ task, bool done) {
        if (pending is null || task !is pending) return;
        IBuilderTask@ b = cast<IBuilderTask>(task);
        GenericHelpers::LogUtil("[CommanderGroupAA] fallback order ended done=" + done + " after "
            + ((ai.frame - orderFrame) / SECOND) + " s target=" + (b !is null && b.target !is null ? "framed" : "none"), 1);
        @pending = null;
    }
}
