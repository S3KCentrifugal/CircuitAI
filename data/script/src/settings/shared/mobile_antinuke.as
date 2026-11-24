// FRONT mobile antinukes (owner, 2026-11-24; systems/combat/mobile_antinuke.as).
// Armada Umbrella (armscab, T2 bot lab, coverage 1400), Cortex Saviour (cormabm, T2 vehicle lab,
// coverage 1750), Legion Hera (legavantinuke, T2 vehicle lab, coverage 1575); coverage is read from
// the unit def at run time (CBattleAnalysis::InterceptorCoverage), these are the BAR values.
namespace Global { namespace MobileAntiNuke {
        bool Enabled = true;
        // Wanted: none until the first enemy nuke launch is seen (BAR launch warning or an interception),
        // then one per enemy silo (SiloAntiNukes::Silos: the higher of scouted and inferred from the
        // launch frequency), at least 1. Two or more scouted / inferred silos also start it with no launch.
        int Max = 4;
        int UpdateSeconds = 2;

        // Artillery it covers: our own Ambassador / Negotiator / Boreas.
        array<string> Artillery = {"armmerl", "corvroc", "legavroc"};
        // An artillery unit this far from the other artillery forms its own group (one antinuke per group).
        float GroupGap = 900.0f;
        // Post: as far back from the group (toward our start) as still keeps every member within
        // CoverShare x coverage ("just barely" under the umbrella).
        float CoverShare = 0.88f;
        float BackStep = 0.05f;          // tried from BackMax down, in this share of coverage
        float BackMax = 0.85f;

        // Porc: our own finished ground-armed static defences (light laser tower to heavy porc; no AA-only,
        // walls, silos, antinukes or long-range plasma). The antinuke never stands ahead of the furthest
        // forward of them in its lane (within LaneRadius of the post) less BehindPorc. When the artillery
        // is out of reach from there, it waits BehindPorc behind that furthest porc instead.
        float LaneRadius = 2500.0f;
        float BehindPorc = 200.0f;
        float PorcMaxRange = 1800.0f;
        // No porc at all: it waits this far from our start toward the enemy.
        float NoPorcForward = 500.0f;

        // Orders: a new post only when it moved this much, at most this often.
        float Retarget = 120.0f;
        int RetargetSeconds = 4;

        // Production: one order at a time in a lab that can build one (cap leased as in CatalystTrade).
        int OrderTimeoutSeconds = 420;

        // Trade (FRONTs without the lab): ask every allied FRONT, the nearest with the lab builds and gives it.
        int OfferSeconds = 4;
        int DeliverSeconds = 480;
        int RetrySeconds = 60;
        // A FRONT that has no lab yet waits this long before asking (its T2 lab may be on the way).
        int AskAfterSeconds = 30;
} }
