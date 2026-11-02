// TECH heavy LRPC block (owner, 2026-11-02): six long range plasma cannons
// (Basilica armbrtha, Intimidator corint, Olympus leglrpc) in a tight cluster
// within reach of the frontmost enemy heavy defences. Policy:
// systems/construction/lrpc_block.as. experimental_balanced/main.as rolls it.
namespace Global {
namespace LrpcBlock {
    // Off by default; experimental_balanced/main.as sets it from its roll
    // (StrategyWeights::Tech_LRPC_BLOCK, 60%). TECH only.
    bool Enabled = false;
    // the gate: our 10 s minimum metal income (Economy::GetMinMetalIncomeLast10s)
    float MetalIncomeGate = 500.0f;
    float MinEnergyIncome = 0.0f;      // none asked; each shot costs 5000-6000 energy
    // the block: Guns cannons, GunCols across x GunRows along, GunGap elmos apart
    int Guns = 6;
    int GunCols = 3;
    int GunRows = 2;
    float GunGap = 16.0f;
    int GunsAtOnce = 3;                // cannon orders in flight at once; the rest of the crew helps
    // the site: every cannon between RangeFar and RangeNear of its own range from
    // the anchor (the frontmost known enemy heavy defence), the candidate nearest
    // our base first, facing the anchor
    float RangeFar = 0.8f;
    float RangeNear = 0.5f;
    float SiteRingStep = 150.0f;
    int SiteAngles = 48;
    int SiteProbes = 80;               // candidates tried, nearest our base first
    float SiteMinScore = 0.6f;         // flat x buildable over the block (TECH's layout measure)
    float SiteAvoidRadius = 500.0f;    // a site given up is not tried again this near
    // the anchor: an enemy structure, armed against the ground, not a super weapon,
    // of at least HeavyMinMetal metal (Pulsar 3500, Bulwark 3000, Bastion 4200,
    // Rattlesnake/Ambusher 2500, Perdition 1250), in sight or a ghost (last seen,
    // its spot not seen empty since); the one nearest our base
    float HeavyMinMetal = 1200.0f;
    // no heavy defence known this long after the gate opened: the nearest known
    // enemy armed structure of any cost, else the nearest enemy start
    int FallbackSeconds = 300;
    // meanwhile the allied AIR (TECH itself with no AIR) scouts the nearest enemy start
    int ScoutSeconds = 180;
    int ScoutT1 = 6;
    int ScoutRadar = 2;
    float ScoutSpread = 800.0f;
    // the construction turret block beside the cannons (cols x rows + spare rows)
    int Turrets = 6;
    int TurretCols = 2;
    int TurretRows = 3;
    int TurretSpareRows = 1;
    int MinTurrets = 4;                // a site must hold this many turret slots
    int TurretsBeforeGuns = 4;         // the cannons are ordered once this many turrets stand ...
    int TurretWaitSeconds = 120;       // ... or this long after the program starts
    // the crew: this share of our T1 and T2 constructors (ground and air, not
    // commanders, not the lolcannon's crews), nearest the site first, re-counted
    // every CrewOrderSeconds while the program runs
    float CrewShare = 0.75f;
    int CrewOrderSeconds = 20;
    // the cover once the cannons stand (as the lolcannon's): Shields of the side's
    // shield just ahead of the block, HeavyPorc of its heavy porc PorcAhead further
    // towards the anchor, PorcSpread apart, Flak T2 flak behind
    int Shields = 2;
    int HeavyPorc = 2;
    int Flak = 1;
    float ShieldSpread = 320.0f;
    float PorcAhead = 200.0f;
    float PorcSpread = 480.0f;
    float CountRadius = 700.0f;        // our structures this near the block count, wherever they went up
    // the whole program gives up after this long (the crew released, the site
    // avoided, a new try after RetrySeconds)
    int GiveUpSeconds = 1800;
    int RetrySeconds = 600;
}
}
