// T3 unstick (owner, 2026-10-20; systems/combat/t3_unstick.as): a T3 unit that
// stops moving while it has an order, hemmed in by our T1 porc, T1 eco or T1
// construction turrets, gets those structures reclaimed by nearby construction
// turrets and T1/T2 constructors, then is sent on toward the enemy.
namespace Global { namespace T3Unstick {
    bool Enabled = false;                 // on in experimental_balanced
    float MinMetal = 2500.0f;             // a mobile ground unit this costly counts as T3 even when not from a gantry
    float StuckSeconds = 20.0f;           // ... stuck after this long within StuckRadius while it has a fighter task
    float StuckRadius = 96.0f;            // elmos
    float GraceSeconds = 15.0f;           // after it is finished, before the clock starts
    float PenGap = 64.0f;                 // a structure is penning it when its footprint is within this of the unit's
    int MaxRounds = 5;                    // each round widens the ring by PenGap (64 ... 320); then the unit is left alone (owner 2026-11-18: 3 -> 5, Stronghold Astraeus)
    float RetrySeconds = 45.0f;           // between rounds for the same unit
    float ReclaimSeconds = 90.0f;         // a round gives up on its reclaims after this
    float BuilderRange = 2000.0f;         // mobile T1/T2 constructors this close to a blocker help
    float TurretMargin = 32.0f;           // construction turrets within build range + this join each reclaim
    int BuildersPerBlocker = 2;
    float NudgeDistance = 600.0f;         // after a round, one move this far toward the nearest enemy start
    // A cleared blocker's site leaves TECH's plans (owner, 2026-10-22): the
    // native layout slot is forgotten on reclaim (D-101); the script plans
    // (weapon slots, fortifications, forward defence, eco flak) skip these.
    int MaxCleared = 64;                  // oldest dropped first
    // Engine (CircuitAI.cpp UnitMoveFailed): after 40 failed moves it stops the
    // unit and orders it reclaimed. For a T3 that reclaim is aborted here and
    // treated as the stuck signal.
    bool AbortSelfReclaim = true;
    // Cleared on top of AllyClearPorc (T1 porc), AllyClearEco (T1 eco) and T1
    // construction turrets (owner, 2026-10-20): T2 flak and the T2 pop-up
    // artillery (Rattlesnake, Persecutor, Eviscerator).
    array<string> ExtraClear = {
        "armflak", "corflak", "legflak",
        "armamb", "cortoast", "legacluster" };
    // Our own T1 metal extractors are cleared too (owner, 2026-11-12): a T1 mex
    // penning a T3 is reclaimed like T1 eco; its spot is free for a T2 mex.
    array<string> MexClear = {
        "armmex", "cormex", "legmex", "armamex" };
    // Wider list (owner, 2026-11-18, after the Nuclear Winter Thors): own and allied, every round.
    array<string> IntelClear = {          // T2 radars and T2 jammers
        "armarad", "corarad", "legarad", "armveil", "corshroud", "legajam" };
    array<string> ConverterClear = {      // T2 converters, land and naval
        "armmmkr", "cormmkr", "legadveconv", "armuwmmm", "coruwmmm" };
    array<string> WallClear = {           // dragon's teeth and fortification walls, land and floating
        "armdrag", "cordrag", "legdrag", "armfdrag", "corfdrag", "legfdrag", "armfort", "corfort", "legforti" };
    array<string> StorageClear = {        // metal storage
        "armmstor", "cormstor", "legmstor", "armuwms", "coruwms" };
    // Owner, 2026-11-18 (Stronghold: legadvsol 5143 and a legestor penned Astraeus 18128): advanced solars,
    // and T1 energy storage even for TECH, whose D-290 protection is lifted for that one reclaim only
    // (T3Unstick::EnqueueReclaim). Advanced energy storage stays protected.
    array<string> AdvSolarClear = { "armadvsol", "coradvsol", "legadvsol" };
    array<string> EnergyStorageT1 = { "armestor", "corestor", "legestor", "armuwes", "coruwes", "leguwestore" };
    // From round PopupRound: T2 pop-up porc (Pit Bull, Scorpion, Chimera)
    int PopupRound = 2;
    array<string> PopupClear = { "armpb", "corvipe", "legapopupdef" };
    // From round FusionRound: fusion reactors, all factions, land and naval (never the advanced fusion).
    // TECH's T3 reclaim squad (tech_air_squads.as) takes them from round 1.
    int FusionRound = 3;
} }
