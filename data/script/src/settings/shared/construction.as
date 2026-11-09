// Shared defaults; existing Global namespaces are retained for callers.
namespace Global {
namespace RoleSettings {        
        // Early allocation by reachable walking distance from starting commanders.
        // At this game time, every ally may take unoccupied reachable spots.
        bool MexOwnershipEnabled = false;
        float MexOwnershipSeconds = 360.0f; // 0 disables early protection (D-352: 6 minutes, down from 10, land and water alike)
        // D-387: capture for the owner. A builder takes a spot an allied AI owns
        // instead of skipping it, and the finished extractor is given to that
        // owner; ownership names the recipient, not the builder. False restores
        // the skip. Upgrades and metal-map field sites are not captured.
        bool MexCaptureForOwner = true;
        // D-352: mex ownership by theatre. Rules in resource/MexTerritory.h; policy
        // here. Every number an ally reads comes from the roster broadcast
        // (systems/team/mex_claim.as), never from a map config.
        namespace MexClaim {
            bool TheatresEnabled = false;      // experimental_balanced switches it on
            float TheatreSeconds = -1.0f;      // sea and race-won spots: -1 the land window, 0 the whole game
            float HomeRadius = 900.0f;         // rule 1: every role owns the land spots this close to its start
            float LaneMergeRadius = 450.0f;    // retired by D-358 (the partition is the field's corridor table); accepted, ignored
            float LaneMergeShare = 0.6f;       //   retired by D-358; accepted, ignored
            float LaneBandRadius = 1200.0f;    //   a cluster this close to its corridor's centre line is a lane cluster (D-358)
            bool FrontLaneSpots = true;        // roles that claim lane clusters inside the window
            bool SupportLaneSpots = true;
            bool TacticalLaneSpots = false;
            bool TechLaneSpots = false;
            bool AirLaneSpots = false;
            bool SeaLaneSpots = false;
            // Securing structures per role (counts), timed with the constructor's
            // build power and the role's income: the race's secure lead.
            int AirSecureLLT = 1;  int AirSecureAA = 1;
            int TacticalSecureLLT = 1; int TacticalSecureAA = 0;
            int SeaSecureLLT = 0;  int SeaSecureAA = 0;
            float ExpectedOpeningIncome = 6.0f; // metal per second assumed while the opener runs and nothing is measured
            int ReannounceSeconds = 30;         // a readiness change smaller than this is not rebroadcast (a slow factory moves the estimate every tick)
            int ReannounceAnchor = 64;          // elmos an anchor must move to rebroadcast
            int WidgetSeconds = 10;             // territory overlay refresh check
        }
        /******************** MEX UPGRADE PRIORITY ********************/
        // A mex upgrade is the best metal-per-metal available and spots are
        // finite, so every role ranks it ahead of its energy ladder. Radius is
        // measured from the role's economy anchor; MaxConcurrent 0 disables it.
        bool MexUpgradeFirst = true;
        float MexUpgradeRadius = 2500.0f;
        int MexUpgradeMaxConcurrent = 1;

       

        // Max number of workers assigned as guards to a single leader (primary or secondary)
        // Applies to builder guard distribution logic (bots/veh/air/sea). Can be tuned per-profile.
        int BuilderMaxGuardsPerLeader = 10;

        // Max number of workers assigned as guards to a tactical constructor (per category)
        // Independent from primary/secondary caps. Default 0 disables tactical guarding.
        int BuilderMaxGuardsPerTacticalLeader = 0;

        // Shared AIR/TECH wall exclusion, measured from every allied start.
        float WallBaseExclusionRadius = 1200.0f;

        // D-488 (owner, 2026-11-07): FRONT and AIR put the fortified geo (a
        // Cortex T2 constructor builds the Cerberus) on every forward vent: one
        // whose fortified geo, firing toward the nearest enemy start, reaches
        // mid map or beyond. A standing geo there is built over where the new
        // one stacks, else reclaimed first (systems/construction/forward_geothermal.as).
        namespace ForwardGeo {
            bool Enabled = true;
            string Definitions = "corbhmth,armgmm,legrampart"; // first one the worker can build
            string RangeDefinition = "corbhmth";  // whose main range sets the reach
            float RangeFallback = 1650.0f;        // elmos, when that definition has no range
            float MidRatio = 1.0f;                // reach point forward: ally-start distance >= MidRatio x enemy-start distance
            float EnemyBaseRadius = 2000.0f;      // a vent this near an enemy start is in its base, never forward (elmos)
            float MinMetalIncome = 20.0f;         // metal/s before the first order (the commander group's geo gate)
            float MaxThreat = 3.0f;               // threat at the vent (commander front_threat scale)
            float JoinDistance = 1500.0f;         // another worker joins the open job within this (elmos)
            float RetrySeconds = 2.0f;            // between searches for a new job
            float RefusedSeconds = 30.0f;         // a refused vent is skipped this long
            int UnbuiltLimit = 2;                 // build jobs ending without the fortified geo before a vent waits
            float UnbuiltSeconds = 300.0f;        // that wait
            bool Reclaim = true;                  // reclaim our plant when the fortified geo does not stack on it
            int ReclaimSeconds = 120;             // reclaim task timeout
        }

        
}
}
