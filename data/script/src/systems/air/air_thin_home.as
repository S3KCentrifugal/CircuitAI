// AIR thin home on a calm map (owner 2026-11-13, Moonshine Run: 3 home mex spots, wind 0).
// Such an AIR lives on converted energy; elsewhere (windy maps, rich homes such as
// Proving Grounds' 5 spots) every lever below returns its ordinary setting.
namespace AirThinHome {
    int state = -1; // -1 not judged yet, 0 off, 1 active; judged once per game
    int homeSpots = 0;
    float wind = 0.0f;
    float replaceCredit = 0.0f; // energy draw of advanced converters ordered and not yet spent on T1 reclaims
    void Reset() { state = -1; homeSpots = 0; wind = 0.0f; replaceCredit = 0.0f; }
    void Judge()
    {
        wind = (ai.GetWindMin() + ai.GetWindMax()) * 0.5f;
        const float r = Global::RoleSettings::Air::HomeMexRadius;
        // Spots the mex ownership resolver gives this team (owner 2026-11-13: "only sees 3
        // mexes as belonging to itself"); Moonshine has a 4th spot inside the radius that an
        // allied FRONT owns. Without any resolved owner nearby, every spot in the radius counts.
        homeSpots = 0;
        int inside = 0, resolved = 0;
        const int count = ai.GetMetalSpotCount();
        for (int i = 0; i < count; ++i) {
            const AIFloat3 p = ai.GetMetalSpot(i);
            if (p.x < 0.0f || MapHelpers::SqDist(p, Global::Map::StartPos) > r * r) continue;
            ++inside;
            const int owner = aiEconomyMgr.MexSpotOwner(p);
            if (owner >= 0) ++resolved;
            if (owner == ai.teamId) ++homeSpots;
        }
        if (resolved == 0) homeSpots = inside;
        const bool on = Global::RoleSettings::Air::ThinHomeEnabled && !aiEconomyMgr.IsMetalMap()
            && wind < Global::RoleSettings::Air::GoodWindMinimumEnergy
            && homeSpots <= Global::RoleSettings::Air::ThinHomeMaxSpots;
        state = on ? 1 : 0;
        GenericHelpers::LogUtil("[AIR][ThinHome] " + (on ? "active" : "off") + " wind=" + wind
            + " homeSpots=" + homeSpots + " (in radius " + inside + ", resolved " + resolved + ") within " + int(r) + " (max " + Global::RoleSettings::Air::ThinHomeMaxSpots + ")", 1);
    }
    bool Active()
    {
        if (state < 0) {
            // the start position and the mex ownership resolver (MexTerritory) settle in the first seconds
            if (ai.frame < 15 * SECOND) return false;
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
    float ReclaimMargin()
    {
        return Active() ? Global::RoleSettings::Air::ThinHomeReclaimMargin : Global::RoleSettings::Air::ReclaimEnergyMargin;
    }
    // Past the first completed reactor no T1 converter is built (owner 2026-11-13).
    bool T1ConvertersRetired() { return Active() && AirEconomy::HasReactor(); }
    bool IsT1Converter(const CCircuitDef@ d)
    {
        return d !is null && d.GetName() == UnitHelpers::GetEnergyConverterNameForSide(UnitHelpers::GetSideForUnitName(d.GetName()));
    }
    bool IsAdvConverter(const CCircuitDef@ d)
    {
        return d !is null && d.GetName() == UnitHelpers::GetAdvEnergyConverterNameForSide(UnitHelpers::GetSideForUnitName(d.GetName()));
    }
    int ReclaimConcurrent()
    {
        const int base = Global::RoleSettings::Air::ReclaimEnergyConcurrent;
        return Active() ? AiMax(base, Global::RoleSettings::Air::ThinHomeReclaimConcurrent) : base;
    }
}
