// Deterministic economy build order for TECH (D-058, D-063). Formula: doc/eco-planner.md.
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/unitdef_helpers.as"
#include "../helpers/map_helpers.as"
#include "builder.as"
#include "layout.as"

/******************************************************************************

ECO PLANNER

A pure function of the economy's state that names the next economy structure
to build, re-evaluated every time a constructor asks for work, so the build
order re-adjusts as the game goes. The state: the map's wind range and
current wind, its tidal strength, energy and metal income, energy and metal
banked against storage, what stands (solars, advanced solars, winds, fusions,
converters, storages, turrets), the build power standing around the base,
whether a T2 lab and T2 constructors exist, what the asking constructor can
build, and what the turret box has room for (D-063).

The order it produces, from the meta (doc/eco-planner.md for the numbers):

  0. The opening (roles/tech.as Opening) claims every reachable mex within
     OpeningMexRadius before this planner runs; nothing pays back faster.
  1. Energy draining (bank under EcoEnergyLowPercent and pull over income):
     the source with the lowest metal per E/s the constructor can build,
     the bank can pay within EcoAffordSeconds, and the box can hold.
  2. Energy floating (bank near full, sustained surplus over pull): a
     converter whose actual native energy draw is covered; advanced when a
     T2 constructor asks.
  3. Metal floating, or build power short of EcoBuildPowerPerMetal times
     the metal income: a construction turret on the next planned slot,
     nearest the factories first.
  4. Energy below the target for this metal income: the cheapest source as
     in 1. One energy structure at a time (D-037) unless the bank drains.
  5. Storage: one energy storage once winds carry the base or the bank is
     under EcoStorageSeconds of income; metal storage when metal is full.
  6. Metal floating with energy already ahead: the best-payback source
     anyway, unless energy is already twice the target.
  7. Otherwise nothing: the ladder's factories, defence and military run.

Range is part of every choice: an option the turret box cannot hold within
a turret's reach is not offered, and what is chosen is pinned to the box
cells nearest a turret (Layout::Place). Nothing here spirals.

Only TECH runs it (Tech::EcoPlannerEnabled), from its constructor ladders.

******************************************************************************/
namespace EcoPlanner {

    class State {
        float windMin;
        float windMax;
        float windCur;
        float tidal;
        float eIncome;
        float ePull;
        float eCur;
        float eStor;
        float mIncome;
        float mCur;
        float mStor;
        bool metalMap;
        int t1Cons;
        int t2Cons;
        bool t2Lab;
        int solars;
        int advSolars;
        int winds;
        int t1Convs;
        int advConvs;
        int t1ConvsQueued;
        int advConvsQueued;
        int fusions;
        int afus;
        int estors;
        int mstors;
        int estorsQueued;
        int mstorsQueued;
        int nanosQueued;            // turret orders not yet started
        int nanosBuilding;          // turrets under construction
        bool turretSlot;            // a planned turret slot is left (Layout::CanPlaceTurret)
        bool builderIsCommander;
        float buildPowerNear;       // static assist build power around the base (turrets), workertime units
        bool builderIsT2;
        const CCircuitDef@ builderDef;    // the asking constructor: only its build options are offered (CR-006)
        bool energyBuilding;        // an energy structure of ours is under construction
    }

    class Option {
        string key;             // "solar", "advsolar", "wind", "tidal", "fusion", "afus", "t1conv", "advconv", "estor", "mstor", "nano"
        CCircuitDef@ def;
        float cost;             // metal
        float output;           // E/s (energy sources), M/s (converters)
        float metalPerE;        // cost / output for energy sources
        float energyUse;        // converter draw
        float metalMake;        // converter output
        bool tier2;
    }

    string lastChoice = "";
    int lastLogFrame = -100000;

    // ---------------------------------------------------------------- numbers

    // Energy output per def (E/s). The script API has no energyMake; these are
    // the game's values (rjm.bar.docs knowledge/50-economy/50-income-sources.md).
    float OutputOf(const string &in name, const State@ s)
    {
        if (name == "armsolar" || name == "corsolar" || name == "legsolar") return 20.0f;
        if (name == "armadvsol" || name == "coradvsol") return 80.0f;
        if (name == "legadvsol") return 100.0f;
        if (name == "armwin" || name == "corwin" || name == "legwin") return WindEffective(s);
        if (name == "armtide" || name == "cortide" || name == "legtide") return s.tidal;
        if (name == "armgeo" || name == "corgeo" || name == "leggeo") return 300.0f;
        if (name == "armfus") return 750.0f;
        if (name == "corfus") return 850.0f;
        if (name == "legfus") return 950.0f;
        if (name == "armafus" || name == "corafus") return 3000.0f;
        if (name == "legafus") return 3300.0f;
        return 0.0f;
    }

    // A wind turbine's effective output: the map's average, capped by the
    // turbine's nominal 25, and discounted when the lulls go below the floor
    // (a base on wind alone stalls in a lull; storage and solars cover it).
    float WindEffective(const State@ s)
    {
        const float avg = (s.windMin + s.windMax) * 0.5f;
        float eff = AiMin(avg, 25.0f);
        if (s.windMin < Global::RoleSettings::Tech::EcoWindLullFloor) eff *= Global::RoleSettings::Tech::EcoWindLullFactor;
        return eff;
    }

    // The energy income a metal income wants: EcoEnergyRatioLow E per M at
    // EcoEnergyRampStart metal, rising to EcoEnergyRatioHigh by EcoEnergyRampEnd.
    // (Played: the old 25 per M from +18 asked +16 metal for 456 E, sixty
    // turbines on a 1-19 wind map, and every metal went to energy.)
    float TargetEnergy(float m)
    {
        const float span = Global::RoleSettings::Tech::EcoEnergyRampEnd - Global::RoleSettings::Tech::EcoEnergyRampStart;
        float r = Global::RoleSettings::Tech::EcoEnergyRatioLow
            + (m - Global::RoleSettings::Tech::EcoEnergyRampStart)
                * (Global::RoleSettings::Tech::EcoEnergyRatioHigh - Global::RoleSettings::Tech::EcoEnergyRatioLow) / ((span > 1.0f) ? span : 1.0f);
        if (r < Global::RoleSettings::Tech::EcoEnergyRatioLow) r = Global::RoleSettings::Tech::EcoEnergyRatioLow;
        if (r > Global::RoleSettings::Tech::EcoEnergyRatioHigh) r = Global::RoleSettings::Tech::EcoEnergyRatioHigh;
        return r * m + Global::RoleSettings::Tech::EcoEnergyReserve;
    }

    // The assist build power a metal income can keep busy (doc/eco-planner.md:
    // about 8 BP per metal per second spends the income on T2 work).
    float TargetBuildPower(float m, bool floating)
    {
        return m * Global::RoleSettings::Tech::EcoBuildPowerPerMetal
            * (floating ? Global::RoleSettings::Tech::EcoBuildPowerFloatFactor : 1.0f);
    }

    // ---------------------------------------------------------------- state

    State@ Read(CCircuitUnit@ u, float metalIncome, float energyIncome)
    {
        State@ s = State();
        s.windMin = ai.GetWindMin();
        s.windMax = ai.GetWindMax();
        s.windCur = ai.GetWindCur();
        s.tidal = ai.GetTidalStrength();
        s.eIncome = energyIncome;
        s.ePull = aiEconomyMgr.energy.pull;
        s.eCur = aiEconomyMgr.energy.current;
        s.eStor = aiEconomyMgr.energy.storage;
        s.mIncome = metalIncome;
        s.mCur = aiEconomyMgr.metal.current;
        s.mStor = aiEconomyMgr.metal.storage;
        s.metalMap = ai.GetMetalSpotCount() >= Global::RoleSettings::Tech::EcoMetalMapSpots;
        s.t1Cons = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT1BotConstructors());
        s.t2Cons = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors());
        s.t2Lab = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotLabs()) > 0;
        const string side = Global::AISettings::Side;
        s.solars = Count(UnitHelpers::GetSolarNameForSide(side));
        s.advSolars = Count(UnitHelpers::GetAdvSolarNameForSide(side));
        s.winds = Count(UnitHelpers::GetWindNameForSide(side));
        s.t1Convs = Count(UnitHelpers::GetEnergyConverterNameForSide(side));
        s.advConvs = Count(UnitHelpers::GetAdvEnergyConverterNameForSide(side));
        s.t1ConvsQueued = Queued(UnitHelpers::GetEnergyConverterNameForSide(side), Task::BuildType::CONVERT);
        s.advConvsQueued = Queued(UnitHelpers::GetAdvEnergyConverterNameForSide(side), Task::BuildType::CONVERT);
        s.fusions = Count(UnitHelpers::GetFusionNameForSide(side));
        s.afus = Count(UnitHelpers::GetAdvFusionNameForSide(side));
        s.estors = Count(UnitHelpers::GetEnergyStorageNameForSide(side));
        s.mstors = Count(UnitHelpers::GetMetalStorageNameForSide(side));
        s.estorsQueued = Queued(UnitHelpers::GetEnergyStorageNameForSide(side), Task::BuildType::STORE);
        s.mstorsQueued = Queued(UnitHelpers::GetMetalStorageNameForSide(side), Task::BuildType::STORE);
        s.nanosQueued = Queued(UnitHelpers::GetT1NanoNameForSide(side), Task::BuildType::NANO);
        {
            CCircuitDef@ nanoDef = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side));
            s.nanosBuilding = (nanoDef is null) ? 0 : aiBuilderMgr.GetUnfinishedCount(nanoDef);
        }
        s.builderIsCommander = (u !is null) && UnitHelpers::IsCommander(u.circuitDef);
        s.turretSlot = Layout::CanPlaceTurret();
        // Turrets only: the commander's 300 and the constructors' 90s pass
        // through; played, they hid the shortage and no turret was ever built.
        s.buildPowerNear = aiBuilderMgr.GetStaticBuildPowerNear(Layout::BaseCentre(), Global::RoleSettings::Tech::EcoBuildPowerRadius);
        s.builderIsT2 = (u !is null && u.circuitDef !is null) ? (UnitHelpers::GetConstructorTier(u.circuitDef) >= 2) : false;
        @s.builderDef = (u is null) ? null : u.circuitDef;
        // An energy structure is "in progress" from the order on, not only once
        // its frame exists: played, two advanced solars were started at once
        // while the first constructor was still walking.
        s.energyBuilding = (Builder::GetEnergyUnderConstruction() !is null)
            || (aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::ENERGY), null) > 0);
        return s;
    }

    int Count(const string &in name)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        return (d is null) ? 0 : d.count;
    }

    int Queued(const string &in name, Task::BuildType type)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        return (d is null) ? 0 : aiBuilderMgr.GetQueuedBuildCount(int(type), d);
    }

    Option@ Make(const string &in key, const string &in name, const State@ s, bool tier2)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        if (d is null || !d.IsAvailable(ai.frame)) return null;
        // Only what the asking constructor can build: a commander has no
        // advanced solar, a T1 constructor no fusion (CR-006).
        if (s.builderDef !is null && !s.builderDef.CanBuild(d)) return null;
        // Only what the turret box holds within a turret's reach (D-063).
        if (!Layout::CanPlace(d)) return null;
        Option@ o = Option();
        o.key = key;
        @o.def = d;
        o.cost = d.costM;
        o.output = OutputOf(name, s);
        o.metalPerE = (o.output > 0.0f) ? o.cost / o.output : 1.0e9f;
        o.energyUse = (key == "t1conv" || key == "advconv") ? aiEconomyMgr.GetEnergyUse(d) : 0.0f;
        o.metalMake = (key == "t1conv" || key == "advconv") ? aiEconomyMgr.GetMetalMake(d) : 0.0f;
        o.tier2 = tier2;
        return o;
    }

    bool Affordable(const Option@ o, const State@ s)
    {
        return o.cost <= s.mCur + Global::RoleSettings::Tech::EcoAffordSeconds * s.mIncome;
    }

    // The energy sources this constructor could build now, cheapest metal per E/s first.
    array<Option@> EnergyOptions(const State@ s)
    {
        const string side = Global::AISettings::Side;
        array<Option@> opts;
        Option@ o;
        @o = Make("solar", UnitHelpers::GetSolarNameForSide(side), s, false); if (o !is null) opts.insertLast(o);
        @o = Make("advsolar", UnitHelpers::GetAdvSolarNameForSide(side), s, false);
        if (o !is null && (s.mIncome >= Global::RoleSettings::Tech::EcoAdvSolarMinMetalIncome || s.mCur >= o.cost)) opts.insertLast(o);
        @o = Make("wind", UnitHelpers::GetWindNameForSide(side), s, false);
        if (o !is null && WindEffective(s) >= Global::RoleSettings::Tech::EcoWindMinimum) opts.insertLast(o);
        if (s.builderIsT2) {
            @o = Make("fusion", UnitHelpers::GetFusionNameForSide(side), s, true);
            if (o !is null && s.mIncome >= Global::RoleSettings::Tech::MinimumMetalIncomeForFUS) opts.insertLast(o);
            @o = Make("afus", UnitHelpers::GetAdvFusionNameForSide(side), s, true);
            if (o !is null && s.mIncome >= Global::RoleSettings::Tech::MinimumMetalIncomeForAFUS) opts.insertLast(o);
        }
        // affordable first, then metal per E/s, then the larger output
        array<Option@> sorted;
        for (uint i = 0; i < opts.length(); ++i) {
            Option@ c = opts[i];
            uint at = sorted.length();
            for (uint k = 0; k < sorted.length(); ++k) {
                const bool ca = Affordable(c, s);
                const bool ka = Affordable(sorted[k], s);
                if (ca && !ka) { at = k; break; }
                if (ca == ka && (c.metalPerE < sorted[k].metalPerE || (c.metalPerE == sorted[k].metalPerE && c.output > sorted[k].output))) { at = k; break; }
            }
            sorted.insertAt(at, c);
        }
        return sorted;
    }

    // The cheapest energy per E/s the bank can pay; else the cheapest lump.
    string PickEnergy(const State@ s, string &out why, const string &in reason)
    {
        array<Option@> opts = EnergyOptions(s);
        if (opts.length() == 0) return "";
        if (Affordable(opts[0], s)) {
            why = reason + "; cheapest per E/s";
            return opts[0].key;
        }
        Option@ cheapest = opts[0];
        for (uint i = 1; i < opts.length(); ++i) if (opts[i].cost < cheapest.cost) @cheapest = opts[i];
        why = reason + "; nothing affordable, cheapest lump";
        return cheapest.key;
    }

    // A converter the surplus carries: advanced for a T2 constructor at the
    // income floor, else T1 while the T1 ceiling allows.
    string PickConverter(const State@ s, float surplus, string &out why)
    {
        const string side = Global::AISettings::Side;
        Option@ adv = Make("advconv", UnitHelpers::GetAdvEnergyConverterNameForSide(side), s, true);
        if (s.builderIsT2 && adv !is null && s.advConvsQueued == 0
            && surplus >= adv.energyUse
            && s.mIncome >= Global::RoleSettings::Tech::MinimumMetalIncomeForAdvConverter) {
            why = "energy floating, surplus " + int(surplus) + " carries "
                + int(adv.energyUse) + " E/s advanced converter for +" + int(adv.metalMake) + " metal";
            return adv.key;
        }
        Option@ t1 = Make("t1conv", UnitHelpers::GetEnergyConverterNameForSide(side), s, false);
        if (t1 !is null && s.t1ConvsQueued == 0
            && (!s.builderIsT2 || s.mIncome < Global::RoleSettings::Tech::MinimumMetalIncomeForAdvConverter)
            && surplus >= t1.energyUse
            && s.mIncome < Global::RoleSettings::Tech::BuildT1ConvertersUntilMetalIncome) {
            why = "energy floating, surplus " + int(surplus) + " carries " + int(t1.energyUse) + " E/s T1 converter";
            return t1.key;
        }
        return "";
    }

    // Build power: a turret when the assist power around the base is under
    // the target for this income (or metal floats), a slot is planned and
    // the constructor can build one. One at a time: an order not yet started
    // or a turret under construction counts as the one in flight, and a
    // constructor that asks meanwhile assists it ("assistnano") instead of
    // starting another - build power is focused, not spread.
    string PickTurret(const State@ s, bool floatingM, string &out why)
    {
        if (s.nanosQueued + s.nanosBuilding >= Global::RoleSettings::Tech::EcoMaxConcurrentNanos) {
            if (s.nanosBuilding > 0 && !s.builderIsCommander && s.builderDef !is null && s.builderDef.IsMobile()) {
                why = "a turret is under construction; assist it";
                return "assistnano";
            }
            return "";
        }
        if (!s.turretSlot) return "";
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (nano is null || !nano.IsAvailable(ai.frame) || s.builderDef is null || !s.builderDef.CanBuild(nano)) return "";
        if (s.mIncome < Global::RoleSettings::Tech::EcoTurretMinMetalIncome) return "";
        if (s.mCur < nano.costM * Global::RoleSettings::Tech::EcoTurretBankFraction) return "";
        const float target = TargetBuildPower(s.mIncome, floatingM);
        if (s.buildPowerNear >= target) return "";
        why = "build power " + int(s.buildPowerNear) + " under " + int(target) + " for +" + int(s.mIncome) + " metal; turret";
        if (floatingM) why = "metal floating at " + int(s.mCur) + ", " + why;
        return "nano";
    }

    // ---------------------------------------------------------------- the decision

    // Returns the key of the structure to build next, "" for none; `why` says why.
    string Decide(const State@ s, string &out why)
    {
        const float target = TargetEnergy(s.mIncome);
        const float deficit = target - s.eIncome;
        const bool draining = (s.eStor > 0.0f) && (s.eCur < Global::RoleSettings::Tech::EcoEnergyLowPercent * s.eStor) && (s.ePull > s.eIncome);
        const bool floatingE = (s.eStor > 0.0f) && (s.eCur >= Global::RoleSettings::Tech::EcoConvertEnergyPercent * s.eStor);
        const float surplus = s.eIncome - s.ePull;
        const bool floatingM = aiEconomyMgr.isMetalFull
            || ((s.mStor > 0.0f) && (s.mCur >= Global::RoleSettings::Tech::EcoFloatMetalPercent * s.mStor) && (s.mIncome >= 5.0f));
        const bool oneAtATime = s.energyBuilding && Global::RoleSettings::Tech::EcoOneEnergyAtATime;
        string key;

        // 1. energy draining: the base is stalling, energy before anything.
        if (draining) {
            key = PickEnergy(s, why, "energy draining, bank " + int(s.eCur) + "/" + int(s.eStor) + ", pull " + int(s.ePull) + " over " + int(s.eIncome));
            if (key.length() > 0) return key;
        }

        // 2. energy floating: convert it (a metal map has metal everywhere; it converts only a hard float).
        if (floatingE && !s.energyBuilding && !aiEconomyMgr.isEnergyStalling) {
            key = PickConverter(s, surplus, why);
            if (key.length() > 0) return key;
        }

        // 3. metal floating or build power short: a construction turret.
        key = PickTurret(s, floatingM, why);
        if (key.length() > 0) return key;

        // 4. energy below the target for this income: one structure at a time (D-037).
        if (deficit > 0.0f && !oneAtATime) {
            key = PickEnergy(s, why, "energy " + int(s.eIncome) + " below target " + int(target));
            if (key.length() > 0) return key;
        }

        // 5. storage
        if (s.winds >= Global::RoleSettings::Tech::EcoStorageWinds
            && s.estors + s.estorsQueued < 1 && s.mIncome >= 4.0f && Layout::CanPlace(ai.GetCircuitDef(UnitHelpers::GetEnergyStorageNameForSide(Global::AISettings::Side)))) {
            why = s.winds + " winds and no energy storage: buffer the lulls";
            return "estor";
        }
        if (s.estors + s.estorsQueued < Global::RoleSettings::Tech::EcoMaxEnergyStorages
            && s.eStor < s.eIncome * Global::RoleSettings::Tech::EcoStorageSeconds && s.mIncome >= 15.0f
            && s.mCur >= Global::RoleSettings::Tech::EcoStorageMinMetalBank
            && Layout::CanPlace(ai.GetCircuitDef(UnitHelpers::GetEnergyStorageNameForSide(Global::AISettings::Side)))) {
            why = "energy storage holds under " + int(Global::RoleSettings::Tech::EcoStorageSeconds) + " s of income";
            return "estor";
        }
        if (aiEconomyMgr.isMetalFull && s.mstors + s.mstorsQueued < Global::RoleSettings::Tech::EcoMaxMetalStorages && s.mIncome >= 20.0f
            && Layout::CanPlace(ai.GetCircuitDef(UnitHelpers::GetMetalStorageNameForSide(Global::AISettings::Side)))) {
            why = "metal bank full at +" + int(s.mIncome) + "; metal storage";
            return "mstor";
        }

        // 6. metal floating with energy ahead: the best payback anyway, up to twice the target.
        if (floatingM && s.eIncome < 2.0f * target && !oneAtATime) {
            array<Option@> opts = EnergyOptions(s);
            for (uint i = 0; i < opts.length(); ++i) {
                if (Affordable(opts[i], s)) {
                    why = "metal floating at " + int(s.mCur) + "; best payback energy";
                    return opts[i].key;
                }
            }
        }
        why = "";
        return "";
    }

    // ---------------------------------------------------------------- execution

    CCircuitDef@ DefOf(const string &in key)
    {
        const string side = Global::AISettings::Side;
        if (key == "solar") return ai.GetCircuitDef(UnitHelpers::GetSolarNameForSide(side));
        if (key == "advsolar") return ai.GetCircuitDef(UnitHelpers::GetAdvSolarNameForSide(side));
        if (key == "wind") return ai.GetCircuitDef(UnitHelpers::GetWindNameForSide(side));
        if (key == "t1conv") return ai.GetCircuitDef(UnitHelpers::GetEnergyConverterNameForSide(side));
        if (key == "advconv") return ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(side));
        if (key == "fusion") return ai.GetCircuitDef(UnitHelpers::GetFusionNameForSide(side));
        if (key == "afus") return ai.GetCircuitDef(UnitHelpers::GetAdvFusionNameForSide(side));
        if (key == "estor") return ai.GetCircuitDef(UnitHelpers::GetEnergyStorageNameForSide(side));
        if (key == "mstor") return ai.GetCircuitDef(UnitHelpers::GetMetalStorageNameForSide(side));
        if (key == "nano") return ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(side));
        return null;
    }

    Task::BuildType TypeOf(const string &in key)
    {
        if (key == "t1conv" || key == "advconv") return Task::BuildType::CONVERT;
        if (key == "estor" || key == "mstor") return Task::BuildType::STORE;
        if (key == "nano") return Task::BuildType::NANO;
        return Task::BuildType::ENERGY;
    }

    int TimeoutOf(const string &in key)
    {
        if (key == "fusion" || key == "afus") return SECOND * 300;
        if (key == "t1conv") return SECOND * 30;
        if (key == "solar" || key == "advsolar") return SECOND * 75;
        return SECOND * 60;
    }

    // The structure goes on the turret box cells nearest a turret, pinned;
    // a turret goes on its planned slot. Null when the box has no room: the
    // caller continues its ladder and never spirals for it (D-063).
    IUnitTask@ Enqueue(const string &in key, CCircuitUnit@ u)
    {
        if (key == "nano") return Layout::NanoTask(u, Task::Priority::HIGH);
        if (key == "assistnano") {
            CCircuitDef@ nanoDef = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
            CCircuitUnit@ target = (nanoDef is null) ? null
                : aiBuilderMgr.FindUnfinishedNear(Layout::BaseCentre(), Global::RoleSettings::Tech::EcoTurretAssistRadius, nanoDef);
            if (target is null) return null;
            return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, target, 90 * SECOND));
        }
        CCircuitDef@ def = DefOf(key);
        if (def is null || !def.IsAvailable(ai.frame)) return null;
        const Task::BuildType type = TypeOf(key);
        const Task::Priority prio = (key == "fusion" || key == "afus") ? Task::Priority::HIGH : Task::Priority::NORMAL;
        IUnitTask@ t = Layout::Place(type, prio, def, TimeoutOf(key), u);
        if (t !is null && type == Task::BuildType::ENERGY) Builder::_SetEnergyBuildTask(t);
        return t;
    }

    // The next structure for this constructor as a key, "" when the economy
    // wants nothing from it now. The caller applies the role's "assist the
    // reactor under construction instead" rule, then Execute.
    string Next(CCircuitUnit@ u, float metalIncome, float energyIncome)
    {
        if (!Global::RoleSettings::Tech::ExperimentalBuild || !Global::RoleSettings::Tech::EcoPlannerEnabled || u is null) return "";
        State@ s = Read(u, metalIncome, energyIncome);
        string why;
        const string key = Decide(s, why);
        if (key.length() == 0) return "";
        if (key != lastChoice || ai.frame - lastLogFrame > 30 * SECOND) {
            lastChoice = key;
            lastLogFrame = ai.frame;
            string who = "?";
            if (s.builderDef !is null) who = s.builderDef.GetName();
            GenericHelpers::LogUtil("[Eco] next: " + key + " (" + why + ") | E " + int(s.eIncome) + "/" + int(TargetEnergy(s.mIncome))
                + " pull " + int(s.ePull) + " bank " + int(s.eCur) + "/" + int(s.eStor) + " | M +" + int(s.mIncome) + " bank " + int(s.mCur)
                + " | BP " + int(s.buildPowerNear) + "/" + int(TargetBuildPower(s.mIncome, false)) + " turrets in flight " + (s.nanosQueued + s.nanosBuilding) + " slot " + (s.turretSlot ? "yes" : "no")
                + " | wind " + int(s.windMin) + "-" + int(s.windMax) + " eff " + int(WindEffective(s)) + " tidal " + int(s.tidal)
                + " | by " + who, 1);
        }
        return key;
    }

    IUnitTask@ Execute(const string &in key, CCircuitUnit@ u)
    {
        if (key.length() == 0 || u is null) return null;
        return Enqueue(key, u);
    }
}
