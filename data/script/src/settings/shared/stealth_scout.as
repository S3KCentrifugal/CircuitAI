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
        // Threat avoidance: observed armed ground coverage and unidentified radar
        // dots (aiBattle.GroundHazard), dilated by this margin, are hard-avoided
        // by the route when possible, else costed. Radar itself cannot see these
        // units (stealth); proximity (cloak radius 65-75) and sight do.
        float HazardMargin = 260.0f;
        float HazardWeight = 200.0f;
        float ContactKeepOut = 320.0f;      // a goal this close to ANY observed enemy ground contact is moved/skipped
        float DecloakRisk = 110.0f;         // a contact this close to the scout is logged as a decloak risk
        float LookaheadElmos = 900.0f;      // covered waypoints this far ahead -> hold and replan
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
    }
}
