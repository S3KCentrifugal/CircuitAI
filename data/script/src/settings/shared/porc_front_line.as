// Porc front line (owner, 2026-11-18; systems/world/porc_front_line.as): the furthest-forward point where our
// defensive buildings are alive and have stood MinAgeSeconds. Site clearing (FRONT gantry, lolcannon) never
// reclaims porc on that line; only porc left at least BehindMargin behind it.
namespace Global { namespace PorcFrontLine {
    float MinAgeSeconds = 120.0f;   // a defensive building counts for the line once it has stood this long
    float BehindMargin = 500.0f;    // porc this far or more behind the line is "left behind" and may be cleared
    float Radius = 3000.0f;         // the line at a point is drawn from our defensive buildings this close to it
    float SweepSeconds = 10.0f;     // one pass over our structures this often
} }
