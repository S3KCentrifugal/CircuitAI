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
        // Native dodge (owner 2026-11-23, needs the matching DLL): every 3 frames
        // a stealth unit with a visible enemy ground unit within DodgeRadius
        // (structures only within DodgeStaticRadius) moves DodgeStep away;
        // the script leaves it alone for DodgeHoldFrames after the last contact,
        // then resumes its route/post. Replaces the script's 1 Hz evade.
        bool NativeDodge = true;
        float DodgeRadius = 260.0f;
        float DodgeStep = 240.0f;
        int DodgeHoldFrames = 45;
        float DodgeStaticRadius = 110.0f;

        bool SpotEnabled = true;
        int SpottersPerAi = 1;               // owner 2026-11-23: one spotter per AI
        // Our "artillery" (owner 2026-11-23): mobile ground units with a max
        // range of RangedMinRange or more count within MobileArtyRadius of the
        // target ("in range or almost"); static artillery (T1/T2 porc guns,
        // LRPCs) of StaticArtyMinRange or more counts only with the target in
        // its range.
        float RangedMinRange = 950.0f;
        float MobileArtyRadius = 2000.0f;
        float StaticArtyMinRange = 1000.0f;
        int RangedRefreshSeconds = 5;
        // Targets are enemy porc only (an armed structure), heavy porc first.
        float MinTargetCost = 100.0f;
        float HeavyRange = 900.0f;          // a target structure with this reach (heavy porc) scores x HeavyFactor
        float HeavyFactor = 2.0f;
        // Post: just inside sight of the target (PostSightMargins below), on the
        // side of our artillery, PostBearingsDeg either side of that bearing.
        // Owner 2026-11-24: just barely in sight of the target, away from the
        // fighting's splash: post distance = the spotter's sight radius minus
        // one of these, tried in order (spy 550 -> 510/480/450/420).
        array<float> PostSightMargins = {40.0f, 70.0f, 100.0f, 130.0f};
        // Owner 2026-11-24: posts keep SpamLaneGap from our spam lanes (their
        // waypoint polylines, refreshed every SpamLaneSeconds) and skip sectors
        // with EnemyLaneDensity or more observed enemy ground contacts (3x3
        // weighted, the enemy's spam streams).
        float SpamLaneGap = 450.0f;
        int SpamLaneSeconds = 15;
        float EnemyLaneDensity = 6.0f;
        // Owner 2026-11-24: posts stay outside light porc (seen or ghost static
        // weapons of reach up to LightPorcMaxRange, LLT ~430) by LightPorcMargin.
        // Heavier porc out-ranges spy sight (550) and cannot be avoided.
        float LightPorcMaxRange = 600.0f;
        float LightPorcMargin = 40.0f;
        // Owner 2026-11-24: after a native dodge the way back passes at least
        // AvoidElmos from where the contact was, for AvoidSeconds.
        float AvoidElmos = 600.0f;
        int AvoidSeconds = 60;
        array<float> PostBearingsDeg = {0.0f, 25.0f, -25.0f, 50.0f, -50.0f, 75.0f, -75.0f};
        // A parked spotter is still and cloaked: a structure can never walk into
        // it, so structures only need StaticGap; mobile contacts keep ProxRadius.
        float StaticGap = 170.0f;
        float SpotClaimRadius = 350.0f;     // one spotter per target area
        int SpotCandidates = 6;
        int SpotCheckSeconds = 5;           // parked: target / LOS / usefulness check
        int NoLosSeconds = 12;              // parked but the target is still not in LOS: new post
        int IdleSpotSeconds = 45;           // no artillery in reach this long: move to another front
        float SwitchFactor = 1.6f;          // a new target must score this much better to leave a working post
        int SpotAsideSeconds = 300;         // a target/post that failed is skipped this long
        // Production: one spotter at a time from a finished T2 bot lab (or the
        // Armada T2 vehicle plant: Gremlin) while short of SpottersPerAi.
        bool SpotBuild = false;             // owner 2026-11-23: no replacement orders; the squad fills from spies the factories build on their normal weights
        array<string> SpotLabs = {"armalab", "coralab", "legalab", "armavp"};
        array<string> SpotLabUnits = {"armspy", "corspy", "legaspy", "armgremlin"};
        float SpotBuildMetalIncome = 20.0f;
        int SpotBuildCooldownSeconds = 90;  // also how long an order counts as pending
    }
}
