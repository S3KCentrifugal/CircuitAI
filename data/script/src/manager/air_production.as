#include "air_economy.as"
#include "air_waves.as"
namespace AirProduction {
    dictionary home; // mutually exclusive with AirWaves' held/launch ledgers
    int strikeOrders = 0;
    int countLog = -100000;
    int Projected(CCircuitDef@ d) { return d is null ? 0 : d.count + aiFactoryMgr.GetPendingRecruitCount(d); }
    IUnitTask@ Recruit(CCircuitUnit@ plant, const string &in name, int target, const string &in purpose, Task::Priority priority, bool utility = false)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        if (d is null || !plant.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame) || Projected(d) >= target) return null;
        IUnitTask@ t = aiFactoryMgr.Enqueue(TaskS::Recruit(utility ? Task::RecruitType::BUILDPOWER : Task::RecruitType::FIREPOWER,
            priority, d, plant.GetPos(ai.frame), 64.0f));
        if (t !is null) GenericHelpers::LogUtil("[AIR][Produce] " + purpose + " " + name + " plant=" + plant.id + " projected=" + Projected(d) + "/" + target, 1);
        return t;
    }
    IUnitTask@ MakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        AirEconomy::Tick();
        if (Lifecycle::IsRetiring(u)) return aiFactoryMgr.Enqueue(TaskS::Wait(true, 3 * SECOND));
        const string name = u.circuitDef.GetName();
        const bool advanced = UnitHelpers::IsT2AircraftPlant(name);
        const bool basic = UnitHelpers::IsT1AircraftPlant(name);
        if (!advanced && !basic) {
            // A nano serves one bay even where reach discs overlap. Reacquire all IDs.
            int64 owner = -1;
            if (AirEconomy::nanoBay.get("" + u.id, owner) && owner >= 0 && owner < int(AirLayout::bays.length())) {
                CCircuitUnit@ plant = ai.GetTeamUnit(AirLayout::bays[int(owner)].factoryId);
                IBuilderTask@ job = plant is null ? null : cast<IBuilderTask>(plant.task);
                if (job !is null && job.target !is null && !Lifecycle::IsRetiring(plant))
                    return aiFactoryMgr.Enqueue(TaskS::Repair(Task::Priority::NORMAL, job.target));
                return aiFactoryMgr.Enqueue(TaskS::Wait(false, SECOND));
            }
            return aiFactoryMgr.DefaultMakeTask(u);
        }
        const string side = UnitHelpers::GetSideForUnitName(name);
        const string cons = advanced ? UnitHelpers::GetT2AirConstructorNameForSide(side) : UnitHelpers::GetT1AirConstructorNameForSide(side);
        IUnitTask@ t = Recruit(u, cons, 1, "constructor.recovery", Task::Priority::HIGH, true);
        if (t !is null) return t;
        if (basic) {
            @t = Recruit(u, UnitHelpers::GetT1AirScoutForSide(side), 1, "scout", Task::Priority::HIGH);
            if (t !is null) return t;
        }
        const string fighter = AirEconomy::Fighter(advanced, side);
        const bool affordable = AirEconomy::energy >= 160.0f && (AirEconomy::bankE > 200.0f || !AirEconomy::recovery);
        if (affordable) {
            const int assignedToWaves = advanced ? int(AirWaves::heldFighters.getSize() + AirWaves::waveFighters.getSize()) : 0;
            @t = Recruit(u, fighter, (advanced ? AirEconomy::HomeTarget() : 2) + assignedToWaves, "intercept", Task::Priority::HIGH);
            if (t !is null) return t;
        }
        int constructors = 1;
        if (AirEconomy::metal >= 8.0f && AirEconomy::energy >= 160.0f && !advanced) constructors = 2;
        if (AirEconomy::metal >= 18.0f && AirEconomy::energy >= 300.0f && !advanced) constructors = 3;
        // Factory-bound nanos cannot supply remote wind/solar construction.
        if (!advanced && AirEconomy::t2 == 0 && !AirEconomy::recovery && AirEconomy::metal >= 30.0f
            && AirEconomy::energy >= 500.0f && AirEconomy::bankM >= 500.0f)
            constructors = AiMax(3, AiMin(Global::RoleSettings::Air::MaxT1EconomyBuilders, 3 + int(AirEconomy::metal / 20.0f)));
        if (advanced && AirEconomy::metal >= 40.0f && AirEconomy::energy >= 1200.0f)
            constructors = AiMin(6, 2 + int(AirEconomy::metal / 150.0f));
        @t = Recruit(u, cons, constructors, "constructor.expand", Task::Priority::NORMAL, true);
        if (t !is null) return t;
        if (basic && AirEconomy::t2 > 0) return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        if (!affordable || AirEconomy::recovery) return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        if (basic) {
            @t = Recruit(u, fighter, AirEconomy::HomeTarget(), "intercept", Task::Priority::HIGH);
            if (t !is null) return t;
        }
        if (basic && strikeOrders < Global::RoleSettings::Air::T1StrikeOpenerSize && AirEconomy::metal >= 12.0f && AirEconomy::EnemyAir() < 1000.0f) {
            @t = Recruit(u, RoleAir::GetT1StrikeAircraftNameForSide(side), Global::RoleSettings::Air::T1StrikeOpenerSize, "strike", Task::Priority::NORMAL);
            if (t !is null) { ++strikeOrders; return t; }
        }
        if (advanced && AirEconomy::metal >= 250.0f) {
            const string heavy = side == "cortex" ? "corcrwh" : side == "legion" ? "legfort" : "";
            @t = Recruit(u, heavy, 6, "heavy", Task::Priority::NORMAL);
            if (t !is null) return t;
        }
        if (advanced && AirEconomy::metal >= Global::RoleSettings::Air::BomberWaveProductionMetalIncome) {
            const string bomber = UnitHelpers::GetT2WaveBomberForSide(side);
            CCircuitDef@ bd = ai.GetCircuitDef(bomber);
            CCircuitDef@ fd = ai.GetCircuitDef(fighter);
            // Native counts include frames and orders immediately, including births between slow ticks.
            const int b = AiMax(0, Projected(bd) - int(AirWaves::waveBombers.getSize()));
            const int f = AiMax(0, Projected(fd) - int(home.getSize()) - int(AirWaves::waveFighters.getSize()));
            if (f < AirWaves::FightersFor(b)) {
                @t = Recruit(u, fighter, Projected(fd) + 1, "wave.escort", Task::Priority::NORMAL);
            } else if (b < AirWaves::Required()) {
                @t = Recruit(u, bomber, Projected(bd) + 1, "wave.bomber", Task::Priority::NORMAL);
            }
            if (t !is null) return t;
        }
        // A sustainable production share leaves resources for growth. Emergency floor above bypasses this.
        if (AirEconomy::bankM < 80.0f && aiEconomyMgr.metal.pull > AirEconomy::metal * 1.2f)
            return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        if (Global::RoleSettings::Air::UseDynamicFactoryProduction) {
            @t = FactoryProduction::MakeTask(u);
            if (t !is null) return t;
        }
        CCircuitDef@ fd = ai.GetCircuitDef(fighter);
        @t = Recruit(u, fighter, Projected(fd) + 1, "air.control", Task::Priority::NORMAL);
        return t is null ? aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND)) : t;
    }
    void Reset() { home.deleteAll(); strikeOrders = 0; countLog = -100000; }
    void Leave()
    {
        array<IUnitTask@> holds;
        array<string>@ ids = home.getKeys();
        array<string>@ bombers = AirWaves::heldBombers.getKeys();
        array<string>@ escorts = AirWaves::heldFighters.getKeys();
        for (uint i = 0; i < bombers.length(); ++i) ids.insertLast(bombers[i]);
        for (uint i = 0; i < escorts.length(); ++i) ids.insertLast(escorts[i]);
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u !is null && u.task !is null && holds.findByRef(u.task) < 0) holds.insertLast(u.task);
        }
        for (uint i = 0; i < holds.length(); ++i) holds[i].Abort();
        Reset(); AirWaves::Init();
    }
    IUnitTask@ HomeTask(CCircuitUnit@ u)
    {
        if (!AirEconomy::Active() || u is null || !AirWaves::IsWaveFighter(u.circuitDef)) return null;
        const string key = "" + u.id;
        // Fighters already on a wave keep their assignment until it ends.
        if (AirWaves::heldFighters.exists(key) || AirWaves::waveFighters.exists(key) || AirWaves::launchQueue.exists(key)) return null;
        if (!home.exists(key) && int(home.getSize()) >= AirEconomy::HomeTarget()) return null;
        home.set(key, true);
        // Distinct from both wave AA holds and native ATTACK threshold rewrites.
        return aiMilitaryMgr.Enqueue(TaskF::Defend(Task::FightType::MELEE, Task::FightType::SCOUT, 1.0e9f));
    }
    void Removed(CCircuitUnit@ u) { if (u !is null) home.delete("" + u.id); }
    void Tick()
    {
        array<string>@ ids = home.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            if (ai.GetTeamUnit(parseInt(ids[i])) is null) home.delete(ids[i]);
            else if (AirWaves::heldFighters.exists(ids[i]) || AirWaves::waveFighters.exists(ids[i]))
                Invariants::Violation("INV-072", ids[i], "AIR fighter has both home and wave assignment");
        }
        if (ai.frame - countLog >= 30 * SECOND) {
            countLog = ai.frame;
            GenericHelpers::LogUtil("[AIR][Attack] home=" + home.getSize() + " target=" + AirEconomy::HomeTarget()
                + " heldBombers=" + AirWaves::heldBombers.getSize() + " escorts=" + AirWaves::heldFighters.getSize()
                + " wave=" + AirWaves::waveIndex + " enemyAir=" + int(AirEconomy::EnemyAir()), 1);
        }
    }
}
