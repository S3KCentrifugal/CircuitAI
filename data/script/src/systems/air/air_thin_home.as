// AIR thin home on a calm map (owner 2026-11-13, Moonshine Run: 3 home mex spots, wind 0).
// Such an AIR lives on converted energy; elsewhere (windy maps, rich homes such as
// Proving Grounds' 5 spots) every lever below returns its ordinary setting.
namespace AirThinHome {
    int state = -1; // -1 not judged yet, 0 off, 1 active; judged once per game
    int homeSpots = 0;
    float wind = 0.0f;
    void Reset() { state = -1; homeSpots = 0; wind = 0.0f; }
    void Judge()
    {
        wind = (ai.GetWindMin() + ai.GetWindMax()) * 0.5f;
        const float r = Global::RoleSettings::Air::HomeMexRadius;
        homeSpots = 0;
        const int count = ai.GetMetalSpotCount();
        for (int i = 0; i < count; ++i) {
            const AIFloat3 p = ai.GetMetalSpot(i);
            if (p.x >= 0.0f && MapHelpers::SqDist(p, Global::Map::StartPos) <= r * r) ++homeSpots;
        }
        const bool on = Global::RoleSettings::Air::ThinHomeEnabled && !aiEconomyMgr.IsMetalMap()
            && wind < Global::RoleSettings::Air::GoodWindMinimumEnergy
            && homeSpots <= Global::RoleSettings::Air::ThinHomeMaxSpots;
        state = on ? 1 : 0;
        GenericHelpers::LogUtil("[AIR][ThinHome] " + (on ? "active" : "off") + " wind=" + wind
            + " homeSpots=" + homeSpots + " within " + int(r) + " (max " + Global::RoleSettings::Air::ThinHomeMaxSpots + ")", 1);
    }
    bool Active()
    {
        if (state < 0) {
            if (ai.frame < SECOND) return false; // the start position settles in the first second
            Judge();
        }
        return state == 1;
    }
    int ConverterParallel()
    {
        const int base = Global::RoleSettings::Air::ConverterParallel;
        return Active() && AirEconomy::EnergyFloating() ? AiMax(base, Global::RoleSettings::Air::ThinHomeConverterParallel) : base;
    }
    float ProductionShare(float base)
    {
        return Active() && AirEconomy::EnergyFloating() && !AirEconomy::MetalFloating()
            ? AiMin(base, Global::RoleSettings::Air::ThinHomeFloatProductionShare) : base;
    }
    int ReclaimConcurrent()
    {
        const int base = Global::RoleSettings::Air::ReclaimEnergyConcurrent;
        return Active() ? AiMax(base, Global::RoleSettings::Air::ThinHomeReclaimConcurrent) : base;
    }
}
