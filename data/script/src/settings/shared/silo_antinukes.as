// Antinukes against scouted enemy nuclear silos (owner, 2026-11-15;
// systems/construction/silo_antinukes.as).
namespace Global {
namespace SiloAntiNukes {
        bool Enabled = true;
        // Known enemy silos (armsilo / corsilo / legsilo, frames included) are counted
        // from the battle analysis at most this often.
        int CountSeconds = 5;
        // Never more antinukes from this rule than this, whatever the silo count.
        int Max = 6;

        // FRONT: the first antinuke covers the main base and the front together.
        // The front point is FrontFraction of the way from our start to the nearest
        // enemy start, at most 2 x CoverShare x coverage out; the block's centre must be
        // within CoverShare x coverage of our start (the main base is always covered)
        // and is scored on its larger distance to start and front point.
        bool Front = true;
        float FrontFraction = 0.45f;
        float CoverShare = 0.80f;
        // First antinuke: 10 s minimum income. After RelaxSeconds with a silo known and
        // no antinuke, the gate halves so a FRONT short of energy is never left bare.
        float FirstMetalIncome = 25.0f;
        float FirstEnergyIncome = 600.0f;
        int RelaxSeconds = 180;
        // Each further antinuke (one per known silo).
        float ExtraMetalIncome = 35.0f;
        float ExtraEnergyIncome = 900.0f;
        // Block shapes, columns x rows, tried in order at the chosen site (each also turned
        // a quarter): the first antinuke takes slot 0, later ones fill the block.
        array<int> Shapes = {3, 2, 2, 2, 2, 1, 1, 1};
        float Margin = 48.0f;          // free ring round the block (units walk round it)
        float LaneClear = 250.0f;      // preferred clearance from every allied start-to-enemy line
        float LanePenalty = 900.0f;    // score penalty for a site inside that clearance
        int SearchRings = 10;
        int SearchSpokes = 16;
        float SearchStep = 128.0f;
        int MaxTries = 12;
        int RetrySeconds = 20;
        int RetryMaxSeconds = 160;
        int SlotBackoffSeconds = 120;
        int SlotStallSeconds = 120;

        // TECH and AIR: after their own first antinuke, one more per known silo at the
        // base periphery: a ring round the start, spread away from our other antinukes,
        // away from the enemy, never off the map, every pad still covering the core.
        bool Periphery = true;
        float PeripheryMinRadius = 800.0f;
        float TechPeripheryMaxRadius = 1500.0f;
        float AirPeripheryMaxRadius = 1400.0f;   // AIR: inside HomeDefenceRadius (INV-091)
        float TechCoreRadius = 600.0f;           // every pad covers this much round the start
        float AirCoreRadius = 800.0f;            // = Air::AntiNukeCoreRadius (INV-094)
        float MapEdgeMargin = 96.0f;             // beyond half the footprint
        int PeripherySpokes = 24;
        float PeripheryStep = 128.0f;
    }
}
