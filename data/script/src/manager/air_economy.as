#include "air_layout.as"
#include "economy.as"

namespace AirEconomy {
    float metal = 0.0f, energy = 0.0f, bankM = 0.0f, bankE = 0.0f;
    float demandM = 0.0f, demandE = 0.0f;
    int sampleFrame = -1, stableSince = -1, lastLog = -100000;
    bool recovery = false;
    int badSamples = 0, goodSamples = 0;
    int t1 = 0, t2 = 0;
    string state = "BOOTSTRAP";
    array<int> owned;
    dictionary nanoBay; // one primary bay per live assistant
    array<float> power;
    array<int> nanoCount;
    array<int> nanoFuture;

    bool Active() { return Global::AISettings::Role == AiRole::AIR && AirLayout::enabled; }
    int Count(const string &in name)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        return d is null ? 0 : d.count;
    }
    int Planned(CCircuitDef@ d, Task::BuildType type)
    {
        return d is null ? 0 : d.count + aiBuilderMgr.GetQueuedBuildCount(int(type), d);
    }
    void Reset()
    {
        sampleFrame = -1; stableSince = -1; lastLog = -100000;
        recovery = false; badSamples = 0; goodSamples = 0;
        t1 = 0; t2 = 0; state = "BOOTSTRAP";
        owned.resize(0); nanoBay.deleteAll(); power.resize(0); nanoCount.resize(0); nanoFuture.resize(0);
    }
    string Fighter(bool advanced, const string &in faction = "")
    {
        const string side = faction.length() > 0 ? faction : Global::AISettings::Side;
        if (advanced) return UnitHelpers::GetT2FighterForSide(side);
        return side == "cortex" ? "corveng" : side == "legion" ? "legfig" : "armfig";
    }
    float EnemyAir() { return Military::GetCachedRoleCost("air") + Military::GetCachedRoleCost("bomber"); }
    int HomeTarget()
    {
        CCircuitDef@ d = ai.GetCircuitDef(Fighter(t2 > 0));
        const float cost = d is null ? 150.0f : AiMax(d.costM, 1.0f);
        return AiMax(Global::RoleSettings::Air::HomeFighterFloor,
            AiMin(Global::RoleSettings::Air::HomeFighterCeiling, int(EnemyAir() / cost * 1.1f)));
    }
    // Expected mixed sortie: seven fighters and three bombers. No average of rates.
    void Mix(bool advanced, float &out work, float &out costM, float &out costE)
    {
        CCircuitDef@ f = ai.GetCircuitDef(Fighter(advanced));
        const string side = Global::AISettings::Side;
        const string bn = advanced ? UnitHelpers::GetT2WaveBomberForSide(side)
            : (side == "cortex" ? "corshad" : side == "legion" ? "legmos" : "armthund");
        CCircuitDef@ b = ai.GetCircuitDef(bn);
        work = 0.0f; costM = 0.0f; costE = 0.0f;
        if (f is null) return;
        work = f.GetBuildTime(); costM = f.costM; costE = f.costE;
        if (b !is null) {
            work = (work * 7.0f + b.GetBuildTime() * 3.0f) / 10.0f;
            costM = (costM * 7.0f + b.costM * 3.0f) / 10.0f;
            costE = (costE * 7.0f + b.costE * 3.0f) / 10.0f;
        }
    }
    void Tick()
    {
        if (!Active() || (sampleFrame >= 0 && ai.frame - sampleFrame < SECOND)) return;
        sampleFrame = ai.frame;
        if (aiEconomyMgr.assistNanoEnabled)
            Invariants::Violation("INV-073", "AIR", "native nano planner enabled while AIR owns production support");
        metal = Economy::GetMinMetalIncomeLast10s(); energy = Economy::GetMinEnergyIncomeLast10s();
        bankM = aiEconomyMgr.metal.current; bankE = aiEconomyMgr.energy.current;
        const bool bad = aiEconomyMgr.isEnergyStalling && bankE < aiEconomyMgr.energy.storage * 0.3f;
        badSamples = bad ? badSamples + 1 : 0;
        goodSamples = !bad && bankE > aiEconomyMgr.energy.storage * 0.45f ? goodSamples + 1 : 0;
        if (badSamples >= 3) recovery = true;
        if (goodSamples >= 10) recovery = false;
        owned = ai.GetOwnedUnitIds();
        nanoBay.deleteAll();
        power.resize(AirLayout::bays.length()); nanoCount.resize(power.length()); nanoFuture.resize(power.length());
        for (uint b = 0; b < power.length(); ++b) {
            if (!AirLayout::Inside(AirLayout::bays[b].centre, 0.0f))
                Invariants::Violation("INV-074", "" + b, "AIR published a bay outside map bounds");
            power[b] = 0.0f; nanoCount[b] = 0; nanoFuture[b] = 0;
            AirLayout::bays[b].factoryId = -1;
        }
        t1 = 0; t2 = 0;
        for (uint i = 0; i < owned.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(owned[i]);
            if (u is null || Lifecycle::IsRetiring(u)) continue;
            const string name = u.circuitDef.GetName();
            // A native MEX task can build T2 directly when a gifted constructor
            // is available. Task completion then registers it as an ordinary
            // mex; reconcile observed T2 structures before proposing upgrades.
            if (UnitHelpers::IsT2Mex(name) && u.GetBuildProgress() >= 1.0f) {
                Economy::MexTracker::RegisterMex(u.GetPos(ai.frame));
                Economy::MexTracker::MarkUpgraded(u.GetPos(ai.frame));
            }
            if (!UnitHelpers::IsT1AircraftPlant(name) && !UnitHelpers::IsT2AircraftPlant(name)) continue;
            if (u.GetBuildProgress() >= 1.0f) { if (UnitHelpers::IsT2AircraftPlant(name)) ++t2; else ++t1; }
            int best = -1;
            float dist = 96.0f * 96.0f;
            for (uint b = 0; b < AirLayout::bays.length(); ++b) {
                const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), AirLayout::bays[b].centre);
                if (sq < dist) { best = int(b); dist = sq; }
            }
            // Gifts and role switches adopt the standing plant; never move it.
            if (best < 0) {
                AirLayout::Bay bay; bay.key = AirLayout::Key(int(AirLayout::bays.length()));
                bay.defName = name; bay.factoryId = u.id; bay.centre = u.GetPos(ai.frame); bay.facing = AirLayout::facing;
                AirLayout::bays.insertLast(bay); AirLayout::AdoptSupport(bay);
                power.insertLast(0.0f); nanoCount.insertLast(0); nanoFuture.insertLast(0);
                best = int(power.length()) - 1;
            }
            AirLayout::bays[best].factoryId = u.id;
            if (u.GetBuildProgress() >= 1.0f) power[best] = u.circuitDef.GetBuildSpeed();
        }
        const string nanoName = UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side);
        for (uint i = 0; i < owned.length(); ++i) {
            CCircuitUnit@ n = ai.GetTeamUnit(owned[i]);
            if (n is null || n.circuitDef.GetName() != nanoName || Lifecycle::IsRetiring(n)) continue;
            int best = -1;
            float dist = n.circuitDef.GetBuildDistance() * n.circuitDef.GetBuildDistance();
            for (uint b = 0; b < AirLayout::bays.length(); ++b) {
                if (AirLayout::bays[b].factoryId < 0) continue;
                const float sq = MapHelpers::SqDist(n.GetPos(ai.frame), AirLayout::bays[b].centre);
                if (sq < dist) { best = int(b); dist = sq; }
            }
            if (best < 0) continue;
            nanoBay.set("" + n.id, int64(best));
            if (n.GetBuildProgress() < 1.0f) { ++nanoFuture[best]; continue; }
            ++nanoCount[best];
            power[best] += n.circuitDef.GetBuildSpeed();
        }
        demandM = 0.0f; demandE = 0.0f;
        for (uint b = 0; b < power.length(); ++b) {
            float work = 0.0f, cm = 0.0f, ce = 0.0f;
            Mix(UnitHelpers::IsT2AircraftPlant(AirLayout::bays[b].defName), work, cm, ce);
            const float rate = ProductionMath::Rate(work, power[b], Global::RoleSettings::Air::WarmFactoryGapSeconds);
            demandM += rate * cm; demandE += rate * ce;
        }
        const bool spare = !recovery && metal * Global::RoleSettings::Air::ProductionIncomeShare > demandM * 1.15f
            && energy * 0.8f > demandE * 1.15f && bankM > 500.0f;
        if (!spare) stableSince = -1; else if (stableSince < 0) stableSince = ai.frame;
        string next = t1 + t2 == 0 ? "BOOTSTRAP" : t2 > 1 ? "MULTIPLANT" : t2 == 1 ? "T2_SUSTAIN" : metal >= 15.0f ? "T1_SCALE" : "T1_CONTEST";
        CCircuitDef@ ad = ai.GetCircuitDef(UnitHelpers::GetT2AirPlantForSide(Global::AISettings::Side));
        if (t2 == 0 && Planned(ad, Task::BuildType::FACTORY) > 0) next = "T2_TRANSITION";
        if (next != state) { state = next; GenericHelpers::LogUtil("[AIR][State] " + state, 1); }
        if (ai.frame - lastLog >= Global::RoleSettings::Air::TelemetrySeconds * SECOND) {
            lastLog = ai.frame;
            GenericHelpers::LogUtil("[AIR][Economy] " + state + (recovery ? " RECOVERY" : "") + " M=" + int(metal) + " bank=" + int(bankM)
                + " E=" + int(energy) + " bank=" + int(bankE) + " pull=" + int(aiEconomyMgr.energy.pull)
                + " plants=" + t1 + "/" + t2 + " aircraftDemand=" + int(demandM) + "/" + int(demandE), 1);
            GenericHelpers::LogUtil("[AIR][Projects] energyQueued=" + aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::ENERGY), null)
                + " committed=" + int(AirBuild::Committed(false)) + "/" + int(AirBuild::Committed(true)), 1);
            for (uint b = 0; b < power.length(); ++b) {
                CCircuitDef@ nd = ai.GetCircuitDef(nanoName);
                GenericHelpers::LogUtil("[AIR][Bay] " + b + " plant=" + AirLayout::bays[b].factoryId + " BP=" + int(power[b])
                    + " nanos=" + nanoCount[b] + "+" + nanoFuture[b] + "/" + NanoTarget(b)
                    + " available=" + (nd !is null && nd.IsAvailable(ai.frame) ? "yes" : "no")
                    + " firstSlot=" + (AirLayout::bays[b].nanos.length() > 0 ? aiTerrainMgr.GetReservationState(AirLayout::bays[b].nanos[0]) : -1), 1);
            }
        }
    }
    bool Transition(CCircuitDef@ plant)
    {
        if (plant is null || recovery || ai.frame < Global::RoleSettings::Air::TransitionEarliestSeconds * SECOND
            || metal < Global::RoleSettings::Air::TransitionMinMetal || energy < Global::RoleSettings::Air::TransitionMinEnergy) return false;
        const float seconds = Global::RoleSettings::Air::TransitionFundSeconds;
        // Plant + constructor + two mex upgrades + two seed nanos, with replacement screen.
        CCircuitDef@ cons = ai.GetCircuitDef(UnitHelpers::GetT2AirConstructorNameForSide(Global::AISettings::Side));
        CCircuitDef@ mex = ai.GetCircuitDef(UnitHelpers::GetT2MexNameForSide(Global::AISettings::Side));
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (cons is null || mex is null || nano is null) return false;
        return ProductionMath::Funded(bankM, metal * 0.35f, metal * 15.0f, AirBuild::Committed(false), plant.costM + cons.costM + 2.0f * (mex.costM + nano.costM), seconds)
            && ProductionMath::Funded(bankE, AiMax(energy - demandE, 0.0f), demandE * 5.0f, AirBuild::Committed(true),
                plant.costE + cons.costE + 2.0f * (mex.costE + nano.costE), seconds);
    }
    int NanoTarget(uint bay)
    {
        if (bay >= power.length() || recovery) return 0;
        const bool advanced = UnitHelpers::IsT2AircraftPlant(AirLayout::bays[bay].defName);
        CCircuitDef@ plant = ai.GetCircuitDef(AirLayout::bays[bay].defName);
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (plant is null || nano is null) return 0;
        float work = 0.0f, cm = 0.0f, ce = 0.0f; Mix(advanced, work, cm, ce);
        const int count = AiMax(1, advanced ? t2 : t1 + t2);
        const float share = Global::RoleSettings::Air::ProductionIncomeShare / float(count);
        float rate = ProductionMath::FundedRate(100.0f, cm, ce, metal * share, energy * share);
        const int space = AiMax(int(AirLayout::bays[bay].nanos.length()), nanoCount[bay]);
        const int limit = advanced ? AiMin(20, Global::RoleSettings::Air::T2NanoSoftLimit) : AiMin(5, Global::RoleSettings::Air::T1NanoLimit);
        return ProductionMath::SupportTarget(work, plant.GetBuildSpeed(), nano.GetBuildSpeed(), Global::RoleSettings::Air::WarmFactoryGapSeconds,
            rate, AiMin(space, limit));
    }
}
