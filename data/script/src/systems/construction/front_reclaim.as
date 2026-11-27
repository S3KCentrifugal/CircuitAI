// FRONT (owner, 2026-10-16): once a fusion stands, FRONT reclaims its winds, solars and
// advanced solars, those closest to its factories first. Played (2026-10-16): FRONT #12 boxed
// several Fatboys in with advanced solars and winds round its labs; they could not leave to fight.
// Modelled on AirReclaim / TECH D-077: winds and solars once energy income without them covers the
// pull by Front::ReclaimT1EnergyMargin, advanced solars at Front::ReclaimAdvSolarMargin (or as soon
// as an advanced fusion stands). Off unless the profile sets Front::ReclaimT1EnergyAfterFusion
// (experimental_balanced/main.as).
// SUPPORT used this reclaim from 2026-10-16 until 2026-10-26, when SUPPORT went back to
// Cent's smrt-test code, which does not call it; only FRONT's settings are read now.
// FRONT eco ladder (owner, 2026-10-16; Front::EcoLadder, systems/construction/front_eco_ladder.as):
// the fusions come down once the second advanced fusion is framed, one at a time, when the bank has
// room for the refund (BAR pays it at completion; metal past storage is lost) and energy income
// without the fusion covers the pull by Front::EcoLadderFusionReclaimMargin (always once the second
// advanced fusion stands).
// Owner (2026-11-27, Glitters: AI 14's wind and T1 converter blocks boxed AI 13's T3 units in; the
// reclaim and the ladder had been off since 2026-11-08): the first finished fusion (any faction's
// fusion or advanced fusion of ours, geothermals not counted) opens the reclaim on its own, eco
// ladder on or off: winds, solars, advanced solars and T1 converters. The energy test also passes
// while the energy bank is at Front::ReclaimBankFill or more (the engine's pull counts the builds in
// progress and sat above income for whole minutes). T1 converters make no energy, so only "no
// energy stall" applies to them. Order: structures on an ally's (or our own) T2 lab / gantry path
// first (systems/team/ally_paths.as), then those round our factories, then the nearest to the worker.
// Front::NoT1EcoAfterFusion: while a fusion stands nobody orders those four defs (native caps 0,
// Global::energyAllowed); they reopen when every fusion is gone.
#include "../../helpers/math/production_math.as"
#include "front_eco_ladder.as"
namespace FrontReclaim {
    array<int> targets;          // structures being reclaimed
    array<IUnitTask@> tasks;

    bool IsSupport() { return Global::AISettings::Role == AiRole::SUPPORT; }
    bool Enabled() { return Global::RoleSettings::Front::ReclaimT1EnergyAfterFusion; }
    float T1Margin() { return Global::RoleSettings::Front::ReclaimT1EnergyMargin; }
    float AdvSolarMargin() { return Global::RoleSettings::Front::ReclaimAdvSolarMargin; }
    float NearFactoryRadius() { return Global::RoleSettings::Front::ReclaimNearFactoryRadius; }
    float EnergyRadius() { return Global::RoleSettings::Front::ReclaimEnergyRadius; }
    int Concurrent() { return Global::RoleSettings::Front::ReclaimEnergyConcurrent; }
    string Tag() { return IsSupport() ? "SUPPORT" : "FRONT"; }

    void Tick()
    {
        for (int i = int(targets.length()) - 1; i >= 0; --i) {
            if (ai.GetTeamUnit(targets[i]) is null || tasks[i] is null || tasks[i].IsDead()) {
                targets.removeAt(i); tasks.removeAt(i);
            }
        }
    }
    bool IsFactoryName(const string &in n)
    {
        return UnitHelpers::IsT1BotLab(n) || UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT1VehicleLab(n)
            || UnitHelpers::IsT2VehicleLab(n) || n == "armshltx" || n == "corgant" || n == "leggant";
    }
    int Count(const string &in name)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        return d is null ? 0 : AiMax(0, d.count - aiBuilderMgr.GetUnfinishedCount(d));
    }
    // Finished reactors of any faction (a rezzed one counts); geothermals do not
    int FinishedReactors()
    {
        int n = 0;
        for (uint i = 0; i < FrontEcoLadder::FusionLike.length(); ++i) n += Count(FrontEcoLadder::FusionLike[i]);
        for (uint i = 0; i < FrontEcoLadder::AdvFusionLike.length(); ++i) n += Count(FrontEcoLadder::AdvFusionLike[i]);
        return n;
    }
    bool FirstFusionStands() { return FinishedReactors() > 0; }
    bool AdvFusionStands()
    {
        for (uint i = 0; i < FrontEcoLadder::AdvFusionLike.length(); ++i) if (Count(FrontEcoLadder::AdvFusionLike[i]) > 0) return true;
        return false;
    }
    bool BankFull()
    {
        const float storage = aiEconomyMgr.energy.storage;
        return storage > 0.0f && aiEconomyMgr.energy.current >= storage * Global::RoleSettings::Front::ReclaimBankFill;
    }
    // 0 = not allowed, 1 = winds and solars, 2 = advanced solars too
    int Level()
    {
        if (aiEconomyMgr.isEnergyStalling || !FirstFusionStands()) return 0;
        const string side = Global::AISettings::Side;
        const bool afus = AdvFusionStands();
        const bool bank = BankFull();
        const float wind = AiMax(0.0f, AiMin(25.0f, (ai.GetWindMin() + ai.GetWindMax()) * 0.5f));
        const float t1 = Count(UnitHelpers::GetWindNameForSide(side)) * wind + Count(UnitHelpers::GetSolarNameForSide(side)) * 20.0f;
        const float adv = Count(UnitHelpers::GetAdvSolarNameForSide(side)) * 75.0f;
        const float income = aiEconomyMgr.energy.income;
        const float pull = aiEconomyMgr.energy.pull;
        if (!bank && !ProductionMath::LowTierEnergyReclaim(afus, income, t1, pull, T1Margin())) return 0;
        return (bank || ProductionMath::LowTierEnergyReclaim(afus, income - t1, adv, pull, AdvSolarMargin())) ? 2 : 1;
    }
    // The four defs whose era ends with the first fusion
    bool IsT1Eco(const string &in name)
    {
        const string side = Global::AISettings::Side;
        return name == UnitHelpers::GetWindNameForSide(side) || name == UnitHelpers::GetSolarNameForSide(side)
            || name == UnitHelpers::GetAdvSolarNameForSide(side) || name == UnitHelpers::GetEnergyConverterNameForSide(side);
    }
    bool T1EcoClosed()
    {
        return Global::RoleSettings::Front::NoT1EcoAfterFusion && Global::AISettings::Role == AiRole::FRONT && FirstFusionStands();
    }
    // Global::energyAllowed for FRONT (registered in Front_Init): no wind, solar, advanced solar or T1
    // converter while a fusion stands (energy defs only; everything else allowed).
    bool EnergyAllowed(const string &in name)
    {
        return !(IsT1Eco(name) && T1EcoClosed());
    }
    // Native caps (Front_IncomeLimits, after the map limits): maxThisUnit 0 for the four defs while a
    // fusion stands, so native energy, the converter fill-in, the energy and converter seats and the
    // build chain order none; the def's own cap comes back when every fusion is gone.
    dictionary capOriginal;
    bool capsLogged = false;
    void ApplyCaps()
    {
        const bool closed = T1EcoClosed();
        const string side = Global::AISettings::Side;
        array<string> names = { UnitHelpers::GetWindNameForSide(side), UnitHelpers::GetSolarNameForSide(side),
            UnitHelpers::GetAdvSolarNameForSide(side), UnitHelpers::GetEnergyConverterNameForSide(side) };
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d is null) continue;
            int was;
            const bool saved = capOriginal.get(names[i], was);
            if (closed) {
                if (!saved) capOriginal.set(names[i], d.maxThisUnit);
                d.maxThisUnit = 0;
            } else if (saved) {
                d.maxThisUnit = was;
                capOriginal.delete(names[i]);
            }
        }
        if (closed != capsLogged) {
            capsLogged = closed;
            GenericHelpers::LogUtil("[FRONT][Reclaim] T1 eco " + (closed ? "closed: a fusion stands, no more winds, solars, advanced solars or T1 converters"
                : "reopened: no fusion stands") + " | E +" + int(aiEconomyMgr.energy.income), 1);
        }
    }
    // A fusion at a time; its refund must fit the bank unless the storage never could hold it and
    // the ladder has built its metal storages
    int fusionLog = -100000;
    bool FusionsAllowed()
    {
        if (IsSupport() || !FrontEcoLadder::ReclaimFusions() || aiEconomyMgr.isEnergyStalling) return false;
        const string fus = UnitHelpers::GetFusionNameForSide(Global::AISettings::Side);
        for (uint i = 0; i < targets.length(); ++i) {
            CCircuitUnit@ t = ai.GetTeamUnit(targets[i]);
            if (t !is null && t.circuitDef !is null && t.circuitDef.GetName() == fus) return false;
        }
        CCircuitDef@ d = ai.GetCircuitDef(fus);
        if (d is null) return false;
        const float fusOut = FrontEcoLadder::FusionOutput(fus);
        if (!ProductionMath::LowTierEnergyReclaim(FrontEcoLadder::SecondAdvFusionStands(), aiEconomyMgr.energy.income, fusOut,
            aiEconomyMgr.energy.pull, Global::RoleSettings::Front::EcoLadderFusionReclaimMargin)) return false;
        const float bank = aiEconomyMgr.metal.current, storage = aiEconomyMgr.metal.storage;
        const bool fits = bank + d.costM <= storage;
        const bool never = storage < d.costM && FrontEcoLadder::StoragesDone();
        if (!fits && !never) {
            if (ai.frame - fusionLog >= 30 * SECOND) {
                fusionLog = ai.frame;
                GenericHelpers::LogUtil("[FRONT][Reclaim] fusion waits: refund " + int(d.costM) + " does not fit the bank " + int(bank) + "/" + int(storage), 1);
            }
            return false;
        }
        return true;
    }

    IUnitTask@ Work(CCircuitUnit@ worker)
    {
        if (!Enabled() || worker is null || worker.circuitDef is null
            || !worker.circuitDef.IsMobile() || UnitHelpers::IsCommander(worker.circuitDef)) return null;
        Tick();
        if (targets.length() >= uint(Concurrent())) return null;
        const int level = Level();
        const bool t1Conv = !IsSupport() && FirstFusionStands() && !aiEconomyMgr.isEnergyStalling;
        const bool fusions = FusionsAllowed();
        if (level == 0 && !t1Conv && !fusions) return null;
        const string side = Global::AISettings::Side;
        const string wind = UnitHelpers::GetWindNameForSide(side);
        const string solar = UnitHelpers::GetSolarNameForSide(side);
        const string advSolar = UnitHelpers::GetAdvSolarNameForSide(side);
        const string converter = UnitHelpers::GetEnergyConverterNameForSide(side);
        const string fusion = UnitHelpers::GetFusionNameForSide(side);
        array<Id>@ ids = ai.GetOwnedUnitIds();
        array<AIFloat3> labs;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u !is null && u.circuitDef !is null && IsFactoryName(u.circuitDef.GetName())) labs.insertLast(u.GetPos(ai.frame));
        }
        // T2 constructors take only the structures on a factory path; the rest is T1 constructors' work
        const bool t2Worker = Team::IsT2Constructor(worker.circuitDef);
        const AIFloat3 wp = worker.GetPos(ai.frame);
        const float nearLab = NearFactoryRadius();
        const float reach = EnergyRadius();
        CCircuitUnit@ best = null;
        float bestScore = 1e30f;
        int bestRank = 3;   // 0 on a factory path, 1 round a factory, 2 elsewhere
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f) continue;
            const string n = u.circuitDef.GetName();
            const bool lowTier = level >= 1 && (n == wind || n == solar || (level == 2 && n == advSolar));
            if (!lowTier && !(t1Conv && n == converter) && !(fusions && n == fusion)) continue;
            if (targets.find(u.id) >= 0 || Lifecycle::IsRetiring(u)) continue;
            const AIFloat3 p = u.GetPos(ai.frame);
            const float toWorker = MapHelpers::SqDist(wp, p);
            if (toWorker > reach * reach) continue;
            const float half = float(AiMax(u.circuitDef.GetFootprintX(), u.circuitDef.GetFootprintZ())) * SQUARE_SIZE;
            int rank = 2;
            float score = toWorker;
            if (n != fusion && Team::AllyPaths::OnPath(p, half)) rank = 0;
            else {
                float toLab = 1e30f;
                for (uint l = 0; l < labs.length(); ++l) toLab = AiMin(toLab, MapHelpers::SqDist(labs[l], p));
                if (toLab <= nearLab * nearLab) { rank = 1; score = toLab; }
            }
            if (t2Worker && rank != 0) continue;
            // structures on a factory path first, then round the factories (they box units in), then the nearest
            if (rank < bestRank || (rank == bestRank && score < bestScore)) { @best = u; bestScore = score; bestRank = rank; }
        }
        if (best is null || !aiTerrainMgr.CanReachAt(worker, best.GetPos(ai.frame), worker.circuitDef.GetBuildDistance())) return null;
        IUnitTask@ task = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, best, 120 * SECOND));
        if (task is null) return null;
        targets.insertLast(best.id);
        tasks.insertLast(task);
        const string bestName = best.circuitDef.GetName();
        Lifecycle::Retire(best, Tag() + (bestName == fusion ? " fusion replaced by advanced fusions"
            : bestName == converter ? " T1 converter retired past the first fusion" : " low-tier energy replaced by a fusion"));
        GenericHelpers::LogUtil("[" + Tag() + "][Reclaim] " + bestName + " id=" + best.id
            + (bestRank == 0 ? " on a factory path" : bestRank == 1 ? " beside a factory" : "")
            + " by " + worker.circuitDef.GetName() + " " + worker.id + " | E +" + int(aiEconomyMgr.energy.income) + " pull " + int(aiEconomyMgr.energy.pull)
            + " bank " + int(aiEconomyMgr.energy.current) + "/" + int(aiEconomyMgr.energy.storage)
            + (level == 2 ? " (advanced solars too)" : ""), 1);
        return task;
    }
}
