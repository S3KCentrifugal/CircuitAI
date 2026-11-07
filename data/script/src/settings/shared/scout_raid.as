// D-296: land scout backline raids. Shared defaults; a role may override
// these before units are admitted. The feature also requires the profile JSON
// switch "scout_raid": {"enabled": true} (experimental_balanced only).
namespace Global {
namespace ScoutRaid {
        bool Enabled = true;
        // Non-spam land scouts that raid. Spam defs (Global::Spam::UnitByFactory)
        // are never admitted even if listed here.
        array<string> Units = {"armflea", "armfav", "corfav", "legscout"};
        int MaxRaiders = 6;          // per AI, concurrent
        int KeepNativeScouts = 1;    // first N listed scouts keep native CScoutTask recon
        // Observed armed-ground coverage is dilated by this margin (elmos).
        float HazardMargin = 120.0f;
        // An unidentified radar dot is avoided with this radius (a T1 turret's
        // range); identification replaces it with the contact's real range.
        float UnknownHazardRange = 700.0f;
        // Extra route cost per 64-elmo cell inside that coverage (soft avoid).
        float HazardWeight = 50.0f;
        // Target kind weights (0 disables a kind).
        float MexWeight = 3.0f;
        float NanoWeight = 4.0f;
        float WindWeight = 2.0f;
        float OtherEconomyWeight = 0.0f;
        float StandoffFraction = 0.8f;      // of weapon range from the target
        // Covered-waypoint lookahead along the issued route (elmos; at least
        // the next three waypoints). Sensor-to-tick latency is 2-3 s.
        float LookaheadElmos = 1200.0f;
        float LookaheadSeconds = 10.0f;     // or this many seconds of the def's speed, if larger
        float ChainRadius = 1500.0f;        // after a kill, prefer the next target this close
        int ReplanCooldownSeconds = 4;      // per raider
        // New-feature latency budget (D-296), not a cap on existing behaviour:
        // synchronous raid-route solves per AI per second.
        int MaxRoutesPerSecond = 2;
        int StuckSeconds = 8;
        float WaypointSpacing = 192.0f;     // minimum spacing of compacted MOVE waypoints
        // Owner 2026-10-21: route points handed to the unit at once (the rest
        // follow in windows near the end); <= 0 = the whole route.
        int MaxIssuedWaypoints = 6;
        int WindowSeconds = 2;              // at most one new window per raider this often
        // Owner 2026-11-07: pile-up breakthrough. Raiders whose gap search has
        // failed bunch up just outside grunt/pawn/LLT coverage. When
        // PileMinGroup or more scouts (this AI's raiders plus allied BARb
        // raiders, any scout type) have been pinned at a coverage edge within
        // PileRadius of each other for PileSeconds, this AI's raiders in the
        // group rush RushMinElmos..RushMaxElmos straight through the bearing
        // (toward the enemy side) with the fewest overlapping firing ranges,
        // then resume normal dodging and economy raids.
        bool PileRushEnabled = true;
        int PileMinGroup = 3;
        float PileRadius = 450.0f;          // scouts this close count as one pile
        float PileEdgeProbe = 420.0f;       // coverage this close (8 bearings) = "at the edge"
        int PileSeconds = 6;                // pinned at the edge this long before it counts
        float PileAnchorDrift = 260.0f;     // dodging inside this of the anchor stays "pinned"
        float RushMinElmos = 1000.0f;
        float RushMaxElmos = 1200.0f;
        float RushConeDegrees = 75.0f;      // bearings tried either side of the enemy direction
        int RushBearings = 11;              // odd: includes the straight bearing
        float RushSampleElmos = 100.0f;     // overlap samples along each bearing
        float RushAnglePenalty = 0.6f;      // overlap units per radian off the enemy direction
        int RushExtraSeconds = 4;           // timeout = length / speed + this
        int RushCooldownSeconds = 40;       // per raider, after a rush ends
        int PileShareSeconds = 2;           // pinned-position broadcast to allies at most this often
        int PileShareTtlSeconds = 5;        // an ally's pinned positions expire after this
    }
}
