// Stealth land scouts (owner, 2026-11-16): radar-stealthy cloaked spy bots
// (Ghost armspy, Spectre corspy, Eidolon legaspy) and the Armada Gremlin
// stealth tank (armgremlin) scout what the team has not seen recently.
// systems/combat/stealth_scout.as. Off by default; experimental_balanced turns it on.
namespace Global {
namespace StealthScout {
        bool Enabled = false;
        array<string> Units = {"armspy", "corspy", "legaspy", "armgremlin"};
        // Cloak upkeep while standing (the game's cloakcost); only for the cloak
        // log line - the native finish rule cloaks a unit when this is below
        // 10% of the average energy income.
        array<float> CloakCost = {15.0f, 15.0f, 15.0f, 5.0f};
        int MaxScouts = 12;                 // per AI; further units keep native CScoutTask
        // Last-seen map: the ally team's line of sight (allied air scouts, spam
        // units, radar-planes' LOS, our own units) sampled per sector.
        float SectorElmos = 512.0f;
        int ScanSeconds = 6;                // every sector is resampled this often
        // Target choice. A sector is a candidate when it is on the enemy side of
        // the map (SideMin of the way from our starts' centre to theirs, or
        // further) and nobody has seen it for MinStaleSeconds.
        float SideMin = 0.55f;
        int MinStaleSeconds = 90;
        int StaleCapSeconds = 900;          // never-seen sectors count as this old
        float BackWeight = 2.0f;            // x(1 + BackWeight*b): b = 0 at the enemy starts' line .. 1 at 1.5x further
        float EdgeWeight = 1.0f;            // x(1 + EdgeWeight*e) behind their starts: e = 1 at the map border .. 0 at EdgeElmos
        float EdgeElmos = 1500.0f;
        float DistanceElmos = 5000.0f;      // score / (1 + travel / DistanceElmos)
        float ClaimRadius = 1100.0f;        // another of our scouts' goal this close: score x ClaimFactor
        float ClaimFactor = 0.25f;
        int Candidates = 8;                 // best sectors checked for reach and threat per plan
        // Discovery avoidance. These units are radar-stealthy and cloaked: weapon
        // range does not reveal them, an enemy unit within the cloak radius
        // (65-75 elmos) does. Headless 11-16 v1 (hard-avoiding weapon coverage)
        // stalled every scout at the front line and dithered there. So:
        //  - routes only COST observed armed coverage and radar dots (soft;
        //    HardAvoid = true restores v1's hard avoidance first);
        //  - every observed enemy ground contact, armed or not, gets a
        //    ProxRadius gap: a waypoint ahead inside it is stepped round,
        //    a contact inside EvadeRadius of the scout makes it step away.
        bool HardAvoid = false;
        float HazardMargin = 120.0f;
        float HazardWeight = 150.0f;
        // Script ticks once a second; an enemy at 60-100 elmo/s closes ~100
        // elmos between ticks, so the gaps are cloak radius + one tick + margin.
        float ProxRadius = 330.0f;
        float EvadeRadius = 260.0f;
        // Flank routes (v3): via the map border on either side when the line's
        // enemy density (contacts per sector, 3x3 weighted) is below FlankRatio
        // of the straight line's.
        bool FlankEnabled = true;
        float FlankRatio = 0.9f;
        float FlankMinElmos = 1500.0f;      // only for goals this far along the axis
        float FlankInsetElmos = 450.0f;     // from the lateral border
        float FlankLengthElmos = 1500.0f;   // path length per unit of risk
        int HotSeconds = 180;               // sectors round a hit scout
        int EvadeHotSeconds = 45;           // sectors round a contact a scout had to evade
        int RetreatSeconds = 8;             // a hit scout pulls back at least this long
        int HoldMaxSeconds = 8;             // no way round a contact ahead: wait this long, then a new target
        float ContactKeepOut = 320.0f;      // a goal this close to ANY observed enemy ground contact is moved/skipped
        float DecloakRisk = 110.0f;         // a contact this close to the scout is logged as a decloak risk
        float LookaheadElmos = 700.0f;      // contacts near waypoints this far ahead are stepped round
        float ArriveElmos = 220.0f;
        float WaypointSpacing = 192.0f;
        int MaxIssuedWaypoints = 6;
        int WindowSeconds = 2;
        int StuckSeconds = 10;
        int ReplanCooldownSeconds = 4;
        int MaxRoutesPerSecond = 2;
        int GoalTimeoutSeconds = 240;       // a goal not reached this long is dropped (and put aside)
        int UnreachableForgetSeconds = 600; // a sector a scout could not reach is skipped this long
        // Hold fire (owner 2026-11-16): firing reveals a cloaked unit. This
        // overrides GremlinEcoFire for Gremlins while they stealth-scout.
        bool HoldFire = true;
        int FireResendSeconds = 10;
        int SummarySeconds = 120;

        // ---- Spotter squad (owner 2026-11-23) ----
        // The first SpottersPerAi stealth units of each AI are spotters, not
        // backline scouts: each parks still near an enemy structure our
        // artillery can reach but nobody sees (a ghost, or a radar-only
        // structure), so the artillery fires at a live target. Ally LOS is
        // shared, so every allied AI's artillery gains from it.
        bool SpotEnabled = true;
        int SpottersPerAi = 1;               // owner 2026-11-23: one spotter per AI
        // Our "artillery": mobile ground units with a max range this long.
        float RangedMinRange = 950.0f;
        float RangedReachMargin = 300.0f;   // target within range + this of one of them
        int RangedRefreshSeconds = 5;
        float MinTargetCost = 100.0f;       // walls and the like are not worth a spotter
        float HeavyRange = 900.0f;          // a target structure with this reach (heavy porc) scores x HeavyFactor
        float HeavyFactor = 2.0f;
        // Post: PostDistances from the target (spy sight 550, Gremlin 494), on the
        // side of our artillery, PostBearingsDeg either side of that bearing.
        array<float> PostDistances = {430.0f, 390.0f, 470.0f, 350.0f};
        array<float> PostBearingsDeg = {0.0f, 25.0f, -25.0f, 50.0f, -50.0f, 75.0f, -75.0f};
        // A parked spotter is still and cloaked: a structure can never walk into
        // it, so structures only need StaticGap; mobile contacts keep ProxRadius.
        float StaticGap = 170.0f;
        float SpotClaimRadius = 350.0f;     // one spotter per target area
        int SpotCandidates = 6;
        int SpotCheckSeconds = 5;           // parked: target / LOS / usefulness check
        int NoLosSeconds = 12;              // parked but the target is still not in LOS: new post
        int IdleSpotSeconds = 240;          // no artillery in reach this long: new target
        float SwitchFactor = 1.6f;          // a new target must score this much better to leave a working post
        int SpotAsideSeconds = 300;         // a target/post that failed is skipped this long
        // Production: one spotter at a time from a finished T2 bot lab (or the
        // Armada T2 vehicle plant: Gremlin) while short of SpottersPerAi.
        bool SpotBuild = true;
        array<string> SpotLabs = {"armalab", "coralab", "legalab", "armavp"};
        array<string> SpotLabUnits = {"armspy", "corspy", "legaspy", "armgremlin"};
        float SpotBuildMetalIncome = 20.0f;
        int SpotBuildCooldownSeconds = 90;  // also how long an order counts as pending
    }
}
