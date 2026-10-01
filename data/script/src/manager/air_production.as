#include "air_economy.as"
#include "air_waves.as"
#include "air_screen.as"
namespace AirProduction {
    dictionary home; // mutually exclusive with AirWaves' held/launch ledgers
    int countLog = -100000;
    CRouteTask@ openingScout = null;
    int Projected(CCircuitDef@ d) { return d is null ? 0 : d.count + aiFactoryMgr.GetPendingRecruitCount(d); }
    float AvailableFighterValue()
    {
        float value = AirScreen::HomeValue();
        array<string>@ ids = AirWaves::heldFighters.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(ids[i]));
            if (u !is null && u.GetBuildProgress() >= 1.0f && !home.exists(ids[i])) value += u.circuitDef.costM;
        }
        return value;
    }
    IUnitTask@ Recruit(CCircuitUnit@ plant, const string &in name, int target, const string &in purpose, Task::Priority priority, bool utility = false)
    {
        CCircuitDef@ d = ai.GetCircuitDef(name);
        if (d is null || !plant.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame) || Projected(d) >= target) return null;
        IUnitTask@ t = aiFactoryMgr.Enqueue(TaskS::Recruit(utility ? Task::RecruitType::BUILDPOWER : Task::RecruitType::FIREPOWER,
            priority, d, plant.GetPos(ai.frame), 64.0f));
        if (t !is null) {
            const string key = "air.crew.streak." + plant.id;
            aiTerrainMgr.SetLayoutInt(key, utility ? aiTerrainMgr.GetLayoutInt(key, 0) + 1 : 0);
            GenericHelpers::LogUtil("[AIR][Produce] " + purpose + " " + name + " plant=" + plant.id + " projected=" + Projected(d) + "/" + target, 1);
        }
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
                CCircuitUnit@ frame = AirBuild::FindAssistTarget(u, false, null, true);
                if (frame !is null) return aiFactoryMgr.Enqueue(TaskS::Repair(Task::Priority::HIGH, frame));
                return aiFactoryMgr.Enqueue(TaskS::Wait(false, SECOND));
            }
            return aiFactoryMgr.DefaultMakeTask(u);
        }
        const string side = UnitHelpers::GetSideForUnitName(name);
        const string cons = advanced ? UnitHelpers::GetT2AirConstructorNameForSide(side) : UnitHelpers::GetT1AirConstructorNameForSide(side);
        IUnitTask@ t = null;
        if (basic && aiTerrainMgr.GetLayoutInt("air.scout.finished", 0) == 0) {
            const string scout = UnitHelpers::GetT1AirScoutForSide(side);
            array<Id>@ ids = ai.GetOwnedUnitIds();
            for (uint i = 0; i < ids.length(); ++i) {
                CCircuitUnit@ live = ai.GetTeamUnit(ids[i]);
                if (live !is null && live.circuitDef.GetName() == scout && live.GetBuildProgress() >= 1.0f)
                    aiTerrainMgr.SetLayoutInt("air.scout.finished", 1);
            }
            @t = Recruit(u, scout, 1, "opening.scout", Task::Priority::HIGH);
            if (t !is null) return t;
            if (aiTerrainMgr.GetLayoutInt("air.scout.finished", 0) == 0)
                return aiFactoryMgr.Enqueue(TaskS::Wait(false, SECOND));
        }
        const int firstCrew = basic ? Global::RoleSettings::Air::OpeningAirConstructors : (AirEconomy::PreparingFusion() ? 2 : 1);
        @t = Recruit(u, cons, firstCrew, "constructor.recovery", Task::Priority::HIGH, true);
        if (t !is null) return t;
        if (basic && !ProductionMath::CrewReady(AirEconomy::CompletedConstructors(), firstCrew))
            return aiFactoryMgr.Enqueue(TaskS::Wait(false, SECOND));
        const string fighter = AirEconomy::Fighter(advanced, side);
        // The first screen follows the completed crew without an income gate.
        // Recovery buildings use NOW priority; do not leave the plant empty
        // waiting for wind income while it could work on an interceptor.
        CCircuitUnit@ scoutUnit = ai.GetTeamUnit(aiTerrainMgr.GetLayoutInt("air.scout.id", -1));
        const int scoutAway = scoutUnit !is null && scoutUnit.circuitDef.GetName() == fighter ? 1 : 0;
        if (basic) {
            const int initialTarget = ProductionMath::DefenceRecruitTarget(Global::RoleSettings::Air::HomeFighterFloor,
                AirScreen::CountOther(fighter), scoutAway);
            @t = Recruit(u, fighter, initialTarget, "opening.screen", Task::Priority::NORMAL);
            if (t !is null) return t;
            CCircuitDef@ initialFighter = ai.GetCircuitDef(fighter);
            if (initialFighter !is null && initialFighter.IsAvailable(ai.frame) && u.circuitDef.CanBuild(initialFighter)
                && Projected(initialFighter) < initialTarget)
                Invariants::Violation("INV-082", "" + u.id, "AIR failed to enqueue available initial fighter after completed crew");
        }
        const bool affordable = AirEconomy::energy >= 160.0f && (AirEconomy::bankE > 200.0f || !AirEconomy::recovery);
        const float intrusion = AirScreen::IntrusionCost();
        if (affordable) {
            const int assignedToWaves = advanced ? int(AirWaves::heldFighters.getSize() + AirWaves::waveFighters.getSize()) : 0;
            const int urgent = intrusion > 0.0f ? AirEconomy::HomeTarget() : advanced ? AiMin(4, AirEconomy::HomeTarget()) : 2;
            @t = Recruit(u, fighter, ProductionMath::DefenceRecruitTarget(urgent,
                AirScreen::CountOther(fighter), assignedToWaves + scoutAway), "intercept", Task::Priority::HIGH);
            if (t !is null) return t;
        }
        CCircuitDef@ builder = ai.GetCircuitDef(cons);
        const int constructors = AirEconomy::ConstructorTarget(builder, advanced);
        if (AirEconomy::FundConstructor(builder) && Projected(builder) < constructors) {
            if (ProductionMath::ConstructorTurn(aiTerrainMgr.GetLayoutInt("air.crew.streak." + u.id, 0), Global::RoleSettings::Air::ConstructorsPerFighter))
                @t = Recruit(u, cons, constructors, "constructor.expand", Task::Priority::HIGH, true);
            else
                @t = Recruit(u, fighter, Projected(ai.GetCircuitDef(fighter)) + 1, "constructor.screen", Task::Priority::NORMAL);
            if (t !is null) return t;
        }
        if (!affordable || AirEconomy::recovery) return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        const int waveScreen = advanced ? int(AirWaves::heldFighters.getSize() + AirWaves::waveFighters.getSize()) : 0;
        @t = Recruit(u, fighter, ProductionMath::DefenceRecruitTarget(AirEconomy::HomeTarget(), AirScreen::CountOther(fighter), waveScreen + scoutAway), "intercept", Task::Priority::HIGH);
        if (t !is null) return t;
        // Transports and the defensive fighter floor above remain first.
        const bool strike = ProductionMath::StrikeReady(AvailableFighterValue(), AirEconomy::EnemyAir(), intrusion > 0.0f, Global::RoleSettings::Air::StrikeControlRatio);
        if (basic && strike && AirEconomy::metal >= 12.0f) {
            const string bomber = side == "cortex" ? "corshad" : side == "legion" ? "legmos" : "armthund";
            // One strike order per two fighters after the screen: finite targets
            // replenish casualties without letting strike losses starve air control.
            const int phase = aiTerrainMgr.GetLayoutInt("air.t1.mix", 0);
            if (phase % 3 == 0) {
                const bool supportFirst = (phase / 3) % 2 == 0;
                for (int pass = 0; pass < 2; ++pass) {
                    const bool support = pass == 0 ? supportFirst : !supportFirst;
                    if (support && aiBattle.EnemyCost(0) + aiBattle.EnemyCost(4) + aiBattle.EnemyCost(5) < 300.0f) continue;

                    const int target = ProductionMath::StrikeTarget(AirEconomy::metal,
                        support ? Global::RoleSettings::Air::T1SupportMetalStep : Global::RoleSettings::Air::T1BomberMetalStep,
                        support ? 3 : 1, support ? (side == "cortex" ? Global::RoleSettings::Air::T1SupportCap : Global::RoleSettings::Air::T1StrikeOpenerSize) : Global::RoleSettings::Air::T1BomberCap);
                    @t = Recruit(u, support ? RoleAir::GetT1StrikeAircraftNameForSide(side) : bomber, target, support ? "front.support" : "t1.bomber", Task::Priority::NORMAL);
                    if (t !is null) { aiTerrainMgr.SetLayoutInt("air.t1.mix", phase + 1); return t; }
                }
            }
        }
        if (advanced && strike && AirEconomy::metal >= 250.0f && aiBattle.EnemyCost(0) >= 1000.0f) {
            const string heavy = side == "cortex" ? "corcrwh" : side == "legion" ? "legfort" : "";
            @t = Recruit(u, heavy, 6, "heavy", Task::Priority::NORMAL);
            if (t !is null) return t;
        }
        if (advanced && strike && AirEconomy::metal >= Global::RoleSettings::Air::BomberWaveProductionMetalIncome) {
            const string bomber = UnitHelpers::GetT2WaveBomberForSide(side);
            CCircuitDef@ bd = ai.GetCircuitDef(bomber);
            CCircuitDef@ fd = ai.GetCircuitDef(fighter);
            // Native counts include frames and orders immediately, including births between slow ticks.
            const int b = AiMax(0, Projected(bd) - int(AirWaves::waveBombers.getSize()));
            const int f = AiMax(0, Projected(fd) - int(home.getSize()) + AirScreen::CountOther(fighter) - int(AirWaves::waveFighters.getSize()));
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
        // Keep the old lab available for economic crews and finite land support;
        // sustained advanced fighter production belongs to the advanced bays.
        if (basic && AirEconomy::t2 > 0 && AirEconomy::metal >= Global::RoleSettings::Air::TransitionMinMetal) {
            aiTerrainMgr.SetLayoutInt("air.t1.mix", aiTerrainMgr.GetLayoutInt("air.t1.mix", 0) + 1);
            return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        }
        if (Global::RoleSettings::Air::UseDynamicFactoryProduction) {
            @t = FactoryProduction::MakeTask(u);
            if (t !is null) return t;
        }
        CCircuitDef@ fd = ai.GetCircuitDef(fighter);
        @t = Recruit(u, fighter, Projected(fd) + 1, "air.control", Task::Priority::NORMAL);
        if (basic && t !is null) aiTerrainMgr.SetLayoutInt("air.t1.mix", aiTerrainMgr.GetLayoutInt("air.t1.mix", 0) + 1);
        return t is null ? aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND)) : t;
    }
    void Reset() { home.deleteAll(); AirScreen::Reset(); countLog = -100000; }
    void Leave()
    {
        if (openingScout !is null && !openingScout.IsDead()) openingScout.Abort();
        @openingScout = null;
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
        // This callback observes the finished scout before it can be lost on a sortie.
        if (AirEconomy::Active() && u !is null && u.GetBuildProgress() >= 1.0f
            && u.circuitDef.GetName() == UnitHelpers::GetT1AirScoutForSide(UnitHelpers::GetSideForUnitName(u.circuitDef.GetName()))) {
            if (aiTerrainMgr.GetLayoutInt("air.scout.id", -1) == -1) aiTerrainMgr.SetLayoutInt("air.scout.id", u.id);
            aiTerrainMgr.SetLayoutInt("air.scout.finished", 1);
            // Legion's Noctua is the roster's fighter/scout drone, without a
            // native SCOUT classification. Only the opening aircraft scouts.
            if (u.id == aiTerrainMgr.GetLayoutInt("air.scout.id", -1) && AirScreen::IsFighter(u.circuitDef)) {
                if (openingScout !is null && !openingScout.IsDead()) return openingScout;
                @openingScout = cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
                if (openingScout !is null) {
                    array<AIFloat3> route;
                    array<AIFloat3> starts = Lanes::ScriptStarts(true);
                    if (starts.length() == 0) starts.insertLast(LayoutHelpers::TerrainCentre());
                    for (uint i = 0; i < starts.length(); ++i) route.insertLast(AirScreen::Clamp(starts[i]));
                    openingScout.SetRoute(route);
                    GenericHelpers::LogUtil("[AIR][Scout] opening drone=" + u.id + " enemy starts=" + route.length(), 1);
                    return openingScout;
                }
            }
        }
        if (!AirEconomy::Active() || u is null || !AirScreen::IsFighter(u.circuitDef)) return null;
        const string key = "" + u.id;
        // Fighters already on a wave keep their assignment until it ends.
        if (AirWaves::heldFighters.exists(key) || AirWaves::waveFighters.exists(key) || AirWaves::launchQueue.exists(key)) return null;
        if (!home.exists(key) && AirWaves::IsWaveFighter(u.circuitDef) && int(home.getSize()) >= AirEconomy::HomeTarget()) return null;
        IUnitTask@ task = AirScreen::TaskFor(u);
        if (task !is null) home.set(key, true);
        return task;
    }
    void Removed(CCircuitUnit@ u)
    {
        if (u is null) return;
        home.delete("" + u.id); AirScreen::Removed(u.id);
        if (u.id == aiTerrainMgr.GetLayoutInt("air.scout.id", -1)) {
            aiTerrainMgr.SetLayoutInt("air.scout.id", -2); @openingScout = null;
        }
    }
    void Tick()
    {
        AirScreen::Tick();
        // Static repairs have no timeout. Return borrowed economy assistance to
        // its production bay as soon as that plant has a unit frame again.
        array<string>@ nanos = AirEconomy::nanoBay.getKeys();
        for (uint i = 0; i < nanos.length(); ++i) {
            int64 owner = -1;
            if (!AirEconomy::nanoBay.get(nanos[i], owner) || owner < 0 || owner >= int(AirLayout::bays.length())) continue;
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(nanos[i]));
            IBuilderTask@ help = u is null ? null : cast<IBuilderTask>(u.task);
            if (help is null || help.GetBuildType() != int(Task::BuildType::REPAIR) || help.target is null || help.target.circuitDef.IsMobile()) continue;
            CCircuitUnit@ plant = ai.GetTeamUnit(AirLayout::bays[int(owner)].factoryId);
            IBuilderTask@ job = plant is null ? null : cast<IBuilderTask>(plant.task);
            if (job is null || job.target is null || Lifecycle::IsRetiring(plant)) continue;
            GenericHelpers::LogUtil("[AIR][Support] return to production bay=" + owner, 1);
            aiFactoryMgr.AbortTask(u.task);
        }
        array<string>@ ids = home.getKeys();
        for (uint i = 0; i < ids.length(); ++i) {
            if (ai.GetTeamUnit(parseInt(ids[i])) is null || !AirScreen::routes.exists(ids[i])) home.delete(ids[i]);
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
