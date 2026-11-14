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
// Who builds it: the native planner (CommanderDefense.cpp) with the slot's air
// weight, so placement, funding, coverage (no second turret where the first
// already answers the raid) and the group limit stay native. Only T1
// constructors build these turrets; a group with no free T1 seat records
// needs_builder and builds nothing.
//
// Cost: one pass over the ally-visible air contacts once a second (the
// snapshot CBattleAnalysis already keeps), FRONT only, no orders, no messages.
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

    void Apply(bool on) {
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
        if (active && ai.frame - lastTrigger > int(holdSeconds * SECOND)) Apply(false);
    }
}
