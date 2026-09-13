// role: AIR
#include "../helpers/unit_helpers.as"
#include "../helpers/unitdef_helpers.as"
#include "../helpers/objective_helpers.as"
#include "../helpers/economy_helpers.as"
#include "../types/role_config.as"
#include "../global.as"
#include "../types/terrain.as"
// Dynamic factory production
#include "../manager/factory_production.as"

namespace RoleAir {
    IUnitTask@ g_airStrategicFocusTask = null;
    int g_airStrategicFocusLeaderId = -1;
    bool g_airBuildFocusReleased = false;
    bool g_airGunshipOpenerDone = false;
    int g_airStrikeOpenerQueuedCount = 0;
    IUnitTask@ g_airCommanderWindTask = null;

    bool Air_IsEconomyHealthy()
    {
        return !aiEconomyMgr.isEnergyStalling;
    }

    bool Air_IsCombatProductionReady(float metalIncome, float energyIncome)
    {
        return Air_IsEconomyHealthy()
            && metalIncome >= Global::RoleSettings::Air::T1CombatProductionMetalIncome
            && energyIncome >= Global::RoleSettings::Air::T1CombatProductionEnergyIncome;
    }

    string Air_GetWindNameForSide(const string &in side)
    {
        if (side == "armada") return "armwin";
        if (side == "cortex") return "corwin";
        if (side == "legion") return "legwin";
        return "";
    }

    bool Air_ShouldPreferWind(const string &in side)
    {
        const string windName = Air_GetWindNameForSide(side);
        CCircuitDef@ windDef = (windName == "" ? null : ai.GetCircuitDef(windName));
        if (windDef is null || !windDef.IsAvailable(ai.frame)) return false;

        const float expectedWindEnergy = aiEconomyMgr.GetEnergyMake(windDef);
        const int windCount = windDef.count;
        return expectedWindEnergy > Global::RoleSettings::Air::GoodWindMinimumEnergy
            && windCount >= 0
            && windCount < Global::RoleSettings::Air::CommanderWindTargetCount
            && Economy::GetMinEnergyIncomeLast10s() < Global::RoleSettings::Air::CommanderWindEnergyIncomeTarget;
    }

    bool Air_HasCommanderWindOpportunity(const string &in side)
    {
        return Builder::commander !is null
            && !aiEconomyMgr.isEnergyFull
            && aiEconomyMgr.metal.current >= Global::RoleSettings::Air::CommanderWindMinimumMetalCurrent
            && Air_ShouldPreferWind(side);
    }

    IUnitTask@ Air_TryCommanderWind(CCircuitUnit@ commander)
    {
        if (commander is null || commander.circuitDef is null) return null;
        if (g_airCommanderWindTask !is null) return g_airCommanderWindTask;

        const string side = UnitHelpers::GetSideForUnitName(commander.circuitDef.GetName());
        if (!Air_HasCommanderWindOpportunity(side)) return null;

        const string windName = Air_GetWindNameForSide(side);
        CCircuitDef@ windDef = ai.GetCircuitDef(windName);
        if (windDef is null) return null;

        IUnitTask@ task = aiBuilderMgr.Enqueue(
            TaskB::Common(
                Task::BuildType::ENERGY,
                Task::Priority::NORMAL,
                windDef,
                commander.GetPos(ai.frame),
                SQUARE_SIZE * 32,
                true,
                30 * SECOND
            )
        );
        if (task !is null) {
            @g_airCommanderWindTask = @task;
            GenericHelpers::LogUtil(
                "[AIR] Commander enqueued wind generator '" + windName +
                "' expectedEnergy=" + aiEconomyMgr.GetEnergyMake(windDef),
                2
            );
        }
        return task;
    }

    bool Air_IsBuildFocusActive()
    {
        if (g_airBuildFocusReleased) return false;

        const bool deadlinePassed =
            ai.frame > Global::RoleSettings::Air::BuildFocusDeadlineSeconds * SECOND;
        const bool incomeEstablished =
            Economy::GetMinMetalIncomeLast10s() >= Global::RoleSettings::Air::BuildFocusMetalIncome
            && Economy::GetMinEnergyIncomeLast10s() >= Global::RoleSettings::Air::BuildFocusEnergyIncome;
        if (deadlinePassed || (Air_IsEconomyHealthy() && incomeEstablished)) {
            g_airBuildFocusReleased = true;
            GenericHelpers::LogUtil("[AIR] Early build-power focus released", 2);
            return false;
        }
        return true;
    }

    bool Air_IsConstructionTask(IUnitTask@ task)
    {
        IBuilderTask@ builderTask = cast<IBuilderTask>(task);
        if (builderTask is null) return false;
        return Builder::_IsConstructionBuildType(Task::BuildType(builderTask.GetBuildType()));
    }

    IUnitTask@ Air_SetStrategicFocus(CCircuitUnit@ leader, IUnitTask@ task)
    {
        if (leader !is null && Air_IsConstructionTask(task)) {
            @g_airStrategicFocusTask = @task;
            g_airStrategicFocusLeaderId = leader.id;
        }
        return task;
    }

    bool Air_HasTrackedTask(CCircuitUnit@ builder)
    {
        Builder::BuilderTaskTrack@ track = Builder::GetTrackForBuilder(builder);
        return track !is null && track.task !is null;
    }

    CCircuitUnit@ Air_GetAssignedT1Leader(CCircuitUnit@ builder)
    {
        if (builder is null) return null;
        const string key = "" + builder.id;
        CCircuitUnit@ ignored = null;
        if (Builder::primaryT1AirConstructor !is null
            && Builder::primaryT1AirConstructorGuards.get(key, @ignored)) {
            return Builder::primaryT1AirConstructor;
        }
        @ignored = null;
        if (Builder::secondaryT1AirConstructor !is null
            && Builder::secondaryT1AirConstructorGuards.get(key, @ignored)) {
            return Builder::secondaryT1AirConstructor;
        }
        return null;
    }

    IUnitTask@ Air_AssignFocusedFollower(CCircuitUnit@ builder)
    {
        IUnitTask@ assistTask = null;
        CCircuitUnit@ primary = Builder::primaryT1AirConstructor;
        if (g_airStrategicFocusTask !is null && primary !is null
            && primary.id == g_airStrategicFocusLeaderId) {
            @assistTask = GuardHelpers::AssignWorkerGuard(
                builder,
                primary,
                Task::Priority::HIGH,
                true,
                Global::RoleSettings::Air::BuildFocusAssistTimeoutSeconds * SECOND
            );
            if (assistTask !is null) return assistTask;
        }

        CCircuitUnit@ secondary = Builder::secondaryT1AirConstructor;
        if (secondary !is null && Air_HasTrackedTask(secondary)) {
            @assistTask = GuardHelpers::AssignWorkerGuard(
                builder,
                secondary,
                Task::Priority::HIGH,
                true,
                Global::RoleSettings::Air::BuildFocusAssistTimeoutSeconds * SECOND
            );
            if (assistTask !is null) return assistTask;
        }

        CCircuitUnit@ assignedLeader = Air_GetAssignedT1Leader(builder);
        if (assignedLeader !is null && Air_HasTrackedTask(assignedLeader)) {
            @assistTask = GuardHelpers::AssignWorkerGuard(
                builder,
                assignedLeader,
                Task::Priority::HIGH,
                true,
                Global::RoleSettings::Air::BuildFocusAssistTimeoutSeconds * SECOND
            );
            if (assistTask !is null) return assistTask;
        }

        return aiBuilderMgr.Enqueue(
            TaskB::Wait(Global::RoleSettings::Air::BuildFocusIdleWaitSeconds * SECOND)
        );
    }

    /******************************************************************************

    DYNAMIC MILITARY QUOTAS

    ******************************************************************************/

    // Compute the total metal "power" of our AIR force only (T1+T2 combat aircraft).
    // This intentionally ignores non-air units so that AIR's aggression reflects
    // the strength of its own role rather than the entire global army.
    float Air_GetArmyMetalCostEstimate()
    {
        // Sum metal cost for all T1/T2 combat aircraft we currently field.
        float airCost = 0.f;

        // T1 combat aircraft
        {
            array<string> t1Air = UnitHelpers::GetAllT1AircraftCombatUnits();
            for (uint i = 0; i < t1Air.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(t1Air[i]);
                if (d is null) continue;
                const int count = UnitDefHelpers::GetUnitDefCount(t1Air[i]);
                if (count <= 0) continue;
                airCost += d.costM * float(count);
            }
        }

        // T2 combat aircraft
        {
            array<string> t2Air = UnitHelpers::GetAllT2AircraftCombatUnits();
            for (uint i = 0; i < t2Air.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(t2Air[i]);
                if (d is null) continue;
                const int count = UnitDefHelpers::GetUnitDefCount(t2Air[i]);
                if (count <= 0) continue;
                airCost += d.costM * float(count);
            }
        }

        // NaN check: NaN is the only value not equal to itself
        if (!(airCost == airCost) || airCost < 0.f) {
            airCost = 0.f;
        }

        return airCost;
    }

    // Adjust AIR military quotas based on comparison of our AIR metal cost vs cached enemy AIR cost.
    void Air_UpdateDynamicMilitaryQuotas()
    {
        // Estimate our AIR metal cost only (excludes land/sea forces)
        float ourArmyCost = Air_GetArmyMetalCostEstimate();

        // Enemy AIR metrics (cost per player) are cached centrally in Military when
        // the enemy cost cache is updated; we just read the derived values here.
        float enemyAirCostPerPlayer = Military::GetEnemyAirCostPerPlayer();
        float enemyAirCostTotal     = Military::g_cachedTotalAirCost; // for logging only

        // Defensive sanity checks
        if (!(enemyAirCostPerPlayer == enemyAirCostPerPlayer) || enemyAirCostPerPlayer < 0.f) {
            enemyAirCostPerPlayer = 0.f;
        }

        float threshold = enemyAirCostPerPlayer * Global::RoleSettings::Air::DynamicQuotaEnemyCostThresholdMultiplier;

        bool isUnderpowered = (ourArmyCost < threshold);

        if (isUnderpowered) {
            // When underpowered vs enemy air cost, push quotas high to encourage more army production.
            aiMilitaryMgr.quota.attack = Global::RoleSettings::Air::UnderpoweredAttackQuota;
            aiMilitaryMgr.quota.raid.min = Global::RoleSettings::Air::UnderpoweredRaidMinQuota;
            aiMilitaryMgr.quota.raid.avg = Global::RoleSettings::Air::UnderpoweredRaidAvgQuota;

            GenericHelpers::LogUtil(
                "[AIR][Quota] Underpowered vs enemy air (ourAirCost=" + ourArmyCost +
                " enemyAirCostTotal=" + enemyAirCostTotal +
                " enemyAirPerPlayer=" + enemyAirCostPerPlayer +
                " thr=" + threshold +
                ") => HIGH quotas: scout=" + aiMilitaryMgr.quota.scout +
                " attack=" + aiMilitaryMgr.quota.attack +
                " raid.min=" + aiMilitaryMgr.quota.raid.min +
                " raid.avg=" + aiMilitaryMgr.quota.raid.avg,
                3
            );
        } else {
            // When not underpowered, keep quotas near their air-role defaults.
            aiMilitaryMgr.quota.scout = Global::RoleSettings::Air::MilitaryScoutCap;
            aiMilitaryMgr.quota.attack = Global::RoleSettings::Air::MilitaryAttackThreshold;
            aiMilitaryMgr.quota.raid.min = Global::RoleSettings::Air::MilitaryRaidMinPower;
            aiMilitaryMgr.quota.raid.avg = Global::RoleSettings::Air::MilitaryRaidAvgPower;

            GenericHelpers::LogUtil(
                "[AIR][Quota] Competitive vs enemy air (ourAirCost=" + ourArmyCost +
                " enemyAirCostTotal=" + enemyAirCostTotal +
                " enemyAirPerPlayer=" + enemyAirCostPerPlayer +
                " thr=" + threshold +
                ") => BASE quotas: scout=" + aiMilitaryMgr.quota.scout +
                " attack=" + aiMilitaryMgr.quota.attack +
                " raid.min=" + aiMilitaryMgr.quota.raid.min +
                " raid.avg=" + aiMilitaryMgr.quota.raid.avg,
                4
            );
        }
    }

    // Delay for dynamic quota adjustments: mirrors Front role but scoped to AIR.
    const int AIR_DYNAMIC_QUOTA_DELAY_FRAMES = Global::RoleSettings::Air::DynamicQuotaDelaySeconds * SECOND;

    /******************************************************************************

    INITIALIZATION

    ******************************************************************************/
    void Air_Init() {
        GenericHelpers::LogUtil("Air role initialization logic executed", 2);
        @g_airStrategicFocusTask = null;
        g_airStrategicFocusLeaderId = -1;
        g_airBuildFocusReleased = false;
        g_airGunshipOpenerDone = false;
        g_airStrikeOpenerQueuedCount = 0;
        @g_airCommanderWindTask = null;

        // Apply AIR role settings
        aiTerrainMgr.SetAllyZoneRange(Global::RoleSettings::Air::AllyRange);
        // Change scout cap (unit count)
        aiMilitaryMgr.quota.scout = Global::RoleSettings::Air::MilitaryScoutCap;

        // Change attack gate (power threshold, not a headcount)
        aiMilitaryMgr.quota.attack = Global::RoleSettings::Air::MilitaryAttackThreshold;

        // Change raid thresholds (power)
        aiMilitaryMgr.quota.raid.min = Global::RoleSettings::Air::MilitaryRaidMinPower; 
        aiMilitaryMgr.quota.raid.avg = Global::RoleSettings::Air::MilitaryRaidAvgPower; 

        GenericHelpers::LogUtil("[Air][Quota] scout=" + aiMilitaryMgr.quota.scout +
            " attack=" + aiMilitaryMgr.quota.attack +
            " raid.min=" + aiMilitaryMgr.quota.raid.min +
            " raid.avg=" + aiMilitaryMgr.quota.raid.avg, 3);

        Air_ApplyStartLimits();

        // Initialize dynamic factory production system for AIR role when enabled
        if (Global::RoleSettings::Air::UseDynamicFactoryProduction) {
            FactoryProduction::Initialize();
            GenericHelpers::LogUtil("[AIR] Dynamic factory production system initialized", 2);
        } else {
            GenericHelpers::LogUtil("[AIR] Dynamic factory production disabled; using legacy factory selection", 2);
        }

        // Log all strategic objectives with distance from start
        ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::AIR, "AIR");
    }

    void Air_ApplyStartLimits() {
        dictionary startLimits; 

        //Limit gantries to 0

        startLimits.set("armshltx", 0);
        startLimits.set("armshltxuw", 0);
        startLimits.set("corgant", 0);
        startLimits.set("corgantuw", 0);
        startLimits.set("leggant", 0);

        startLimits.set("armvp", 0);
        startLimits.set("corvp", 0);
        startLimits.set("legvp", 0);
        startLimits.set("armlab", 0);
        startLimits.set("corlab", 0);
        startLimits.set("leglab", 0);

        startLimits.set("armsilo", 0);
        startLimits.set("corsilo", 0);
        startLimits.set("legsilo", 0);

        array<string> t1GroundDefences = UnitHelpers::GetAllT1LandDefences();
        for (uint i = 0; i < t1GroundDefences.length(); ++i) {
            startLimits.set(t1GroundDefences[i], 0);
        }

        UnitHelpers::ApplyUnitLimits(startLimits);

        GenericHelpers::LogUtil("Air start limits applied", 3);
    }

    /******************************************************************************

    MAIN HOOKS

    ******************************************************************************/

    void Air_MainUpdate() {
        // Periodically update dynamic military quotas once the configured delay has passed
        if (ai.frame >= AIR_DYNAMIC_QUOTA_DELAY_FRAMES) {
            Air_UpdateDynamicMilitaryQuotas();
        }
        //LogUtil("Air update logic executed", 5);
    }

    /******************************************************************************

    ECONOMY HOOKS

    ******************************************************************************/

    void Air_EconomyUpdate() {
    }

    /******************************************************************************

    FACTORY HOOKS

    ******************************************************************************/

    // Resolve a strike aircraft that the side's T1 aircraft plant can actually build.
    string GetT1StrikeAircraftNameForSide(const string &in side)
    {
        if (side == "armada") return "armkam";
        if (side == "cortex") return "corbw";
        if (side == "legion") return "legkam";
        return "";
    }

    IUnitTask@ Air_TryT1StrikeOpener(const CCircuitDef@ facDef, const string &in side, const AIFloat3 &in pos)
    {
        if (g_airGunshipOpenerDone) return null;
        if (facDef is null) return null;
        if (Economy::GetMinMetalIncomeLast10s() < Global::RoleSettings::Air::T1StrikeOpenerMinimumMetalIncome ||
            Economy::GetMinEnergyIncomeLast10s() < Global::RoleSettings::Air::T1StrikeOpenerMinimumEnergyIncome) {
            return null;
        }

        string gunshipName = GetT1StrikeAircraftNameForSide(side);
        if (gunshipName == "") return null;

        CCircuitDef@ gdef = ai.GetCircuitDef(gunshipName);
        if (gdef is null || !gdef.IsAvailable(ai.frame)) {
            return null;
        }

        const int targetCount = Global::RoleSettings::Air::T1StrikeOpenerSize;
        if (targetCount <= 0 || g_airStrikeOpenerQueuedCount >= targetCount) {
            g_airGunshipOpenerDone = true;
            return null;
        }

        IUnitTask@ task = aiFactoryMgr.Enqueue(
            TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, gdef, pos, 64.f)
        );
        if (task !is null) {
            g_airStrikeOpenerQueuedCount++;
            g_airGunshipOpenerDone = g_airStrikeOpenerQueuedCount >= targetCount;
            GenericHelpers::LogUtil(
                "[AIR] T1 strike opener enqueued " + g_airStrikeOpenerQueuedCount +
                "/" + targetCount + " unit=" + gunshipName,
                2
            );
        }
        return task;
    }

    IUnitTask@ Air_FactoryAiMakeTask(CCircuitUnit@ u) {
        const CCircuitDef@ facDef = (u is null ? null : u.circuitDef);
        if (facDef is null) {
            return aiFactoryMgr.DefaultMakeTask(u);
        }

        // Only customize for aircraft plants; otherwise fallback
        const string fname = facDef.GetName();
        if (!UnitHelpers::IsT1AircraftPlant(fname) && !UnitHelpers::IsT2AircraftPlant(fname)) {
            return aiFactoryMgr.DefaultMakeTask(u);
        }

        const AIFloat3 pos = u.GetPos(ai.frame);
        const string side = UnitHelpers::GetSideForUnitName(fname);
        // Use the sliding-window minimum metal income across all checks in this factory make task
        const float metalIncome = Economy::GetMinMetalIncomeLast10s();
        const float energyIncome = Economy::GetMinEnergyIncomeLast10s();

        // Determine plant tier first and only queue T1 builders from T1 plants.
        bool isT1Plant = UnitHelpers::IsT1AircraftPlant(fname);
        bool isT2Plant = (!isT1Plant && UnitHelpers::IsT2AircraftPlant(fname));

        if (isT1Plant) {
            const int maxT1Builders = Global::RoleSettings::Air::MinT1AirConstructorCount;
            array<string> allT1AirCons = UnitHelpers::GetAllT1AirConstructors();
            int t1BuildersTotal = UnitDefHelpers::SumUnitDefCounts(allT1AirCons);
            string t1BuilderName = (side == "armada" ? "armca" : side == "cortex" ? "corca" : side == "legion" ? "legca" : "armca");
            CCircuitDef@ t1BuilderDef = ai.GetCircuitDef(t1BuilderName);

            // Establish economy control before consuming the opening queue on
            // scouts or combat aircraft.
            if (maxT1Builders > 0 && t1BuildersTotal < 1
                && t1BuilderDef !is null && t1BuilderDef.IsAvailable(ai.frame)) {
                return aiFactoryMgr.Enqueue(
                    TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, t1BuilderDef, pos, 64.f)
                );
            }

            // Add one early scout after the first constructor.
            int scoutTarget = Global::RoleSettings::Air::MinAirScoutCount;
            const int SCOUT_PRODUCTION_DEADLINE = 5 * 60 * SECOND;
            if (scoutTarget > 0 && ai.frame <= SCOUT_PRODUCTION_DEADLINE) {
                array<string> allScouts = UnitHelpers::GetAllT1AircraftScouts();
                int haveScouts = UnitDefHelpers::SumUnitDefCounts(allScouts);
                if (haveScouts < scoutTarget) {
                    string scoutName = UnitHelpers::GetT1AirScoutForSide(side);
                    CCircuitDef@ scoutDef = ai.GetCircuitDef(scoutName);
                    if (scoutDef !is null && scoutDef.IsAvailable(ai.frame)) {
                        // Use HIGH priority to ensure scouts are produced ahead of other unit types
                        return aiFactoryMgr.Enqueue(
                            TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, scoutDef, pos, 64.f)
                        );
                    }
                }
            }

            int desiredT1Builders = (maxT1Builders < 1 ? maxT1Builders : 1);
            if (Air_IsEconomyHealthy()
                && metalIncome >= Global::RoleSettings::Air::SecondT1AirConstructorMetalIncome
                && energyIncome >= Global::RoleSettings::Air::SecondT1AirConstructorEnergyIncome) {
                desiredT1Builders = (maxT1Builders < 2 ? maxT1Builders : 2);
            }
            if (Air_IsEconomyHealthy()
                && metalIncome >= Global::RoleSettings::Air::ThirdT1AirConstructorMetalIncome
                && energyIncome >= Global::RoleSettings::Air::ThirdT1AirConstructorEnergyIncome) {
                desiredT1Builders = maxT1Builders;
            }
            if (t1BuildersTotal < desiredT1Builders
                && t1BuilderDef !is null && t1BuilderDef.IsAvailable(ai.frame)) {
                return aiFactoryMgr.Enqueue(
                    TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, t1BuilderDef, pos, 64.f)
                );
            }

            const bool combatProductionReady = Air_IsCombatProductionReady(metalIncome, energyIncome);
            if (combatProductionReady) {
                string fighterName = (side == "armada" ? "armfig" : side == "cortex" ? "corveng" : side == "legion" ? "legfig" : "armfig");
                int haveFighters = UnitDefHelpers::GetUnitDefCount(fighterName);
                if (haveFighters < Global::RoleSettings::Air::MinT1FighterCount) {
                    CCircuitDef@ fighterDef = ai.GetCircuitDef(fighterName);
                    if (fighterDef !is null && fighterDef.IsAvailable(ai.frame)) {
                        return aiFactoryMgr.Enqueue(
                            TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, fighterDef, pos, 64.f)
                        );
                    }
                }

                IUnitTask@ gunshipOpener = Air_TryT1StrikeOpener(facDef, side, pos);
                if (gunshipOpener !is null) {
                    return gunshipOpener;
                }
            }

            if (combatProductionReady && Global::RoleSettings::Air::UseDynamicFactoryProduction) {
                GenericHelpers::LogUtil("[AIR][FactoryProduction] T1 plant '" + fname + "' side=" + side + " metalIncome=" + metalIncome, 4);
                IUnitTask@ dynTaskT1 = FactoryProduction::MakeTask(u);
                if (dynTaskT1 !is null) {
                    return dynTaskT1;
                }
                GenericHelpers::LogUtil("[AIR] Dynamic factory production returned null for '" + fname + "', using default", 3);
            }

        }

        // If T2 plant: ensure advanced constructor targets, then apply T2-specific strategy
        if (isT2Plant) {
            // 1) Ensure at least MinT2AirConstructorCount advanced air constructors exist globally
            const int maxT2Cons = Global::RoleSettings::Air::MinT2AirConstructorCount;
            int minT2Cons = (maxT2Cons < 1 ? maxT2Cons : 1);
            if (Air_IsEconomyHealthy()
                && metalIncome >= Global::RoleSettings::Air::SecondT2AirConstructorMetalIncome
                && energyIncome >= Global::RoleSettings::Air::SecondT2AirConstructorEnergyIncome) {
                minT2Cons = maxT2Cons;
            }
            if (minT2Cons > 0) {
                array<string> t2AirCons; t2AirCons = { "armaca", "coraca", "legaca" };
                int haveT2Cons = UnitDefHelpers::SumUnitDefCounts(t2AirCons);
                if (haveT2Cons < minT2Cons) {
                    string advCtorName = (side == "armada" ? "armaca" : side == "cortex" ? "coraca" : side == "legion" ? "legaca" : "armaca");
                    CCircuitDef@ advCtor = ai.GetCircuitDef(advCtorName);
                    if (advCtor !is null && advCtor.IsAvailable(ai.frame)) {
                        return aiFactoryMgr.Enqueue(
                            TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, advCtor, pos, 64.f)
                        );
                    }
                }
            }

            // 2) Heavy air strike (Legion/Cortex only), capped so this cannot
            // monopolize every subsequent T2 production decision.
            {
                float mi = metalIncome;
                float incomeThresh = Global::RoleSettings::Air::T2HeavyAirIncomeThreshold;
                int batch = Global::RoleSettings::Air::T2HeavyAirBatchPerFactory;
                if (batch > 0 && mi > incomeThresh && (side == "legion" || side == "cortex")) {
                    string heavyName = (side == "legion" ? "legfort" : "corcrwh");
                    CCircuitDef@ heavyDef = ai.GetCircuitDef(heavyName);
                    int haveHeavy = UnitDefHelpers::GetUnitDefCount(heavyName);
                    int heavyTarget = Global::RoleSettings::Air::T2HeavyAirTargetCount;
                    if (haveHeavy >= 0 && haveHeavy < heavyTarget && heavyDef !is null && heavyDef.IsAvailable(ai.frame)) {
                        int deficit = heavyTarget - haveHeavy;
                        int toQueue = (deficit < batch ? deficit : batch);
                        IUnitTask@ firstTask = null;
                        for (int i = 0; i < toQueue; ++i) {
                            IUnitTask@ t = aiFactoryMgr.Enqueue(
                                TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::NORMAL, heavyDef, pos, 64.f)
                            );
                            if (firstTask is null) @firstTask = t;
                        }
                        if (firstTask !is null) return firstTask;
                    }
                }
            }

            // Dynamic selection runs after bounded strategic quotas so it cannot
            // make constructor or heavy-air policy unreachable.
            if (Air_IsCombatProductionReady(metalIncome, energyIncome)
                && Global::RoleSettings::Air::UseDynamicFactoryProduction) {
                IUnitTask@ dynTaskT2 = FactoryProduction::MakeTask(u);
                if (dynTaskT2 !is null) {
                    return dynTaskT2;
                }
                GenericHelpers::LogUtil("[AIR] Dynamic factory production returned null for '" + fname + "', using default", 3);
            }
        }
        // If T2 plant but no specific action above, do NOT enqueue T1 construction aircraft here to avoid blocking advanced queues.

        // Economy snapshot for simple gating
        // float mi = Global::Economy::MetalIncome;
        // float ei = Global::Economy::EnergyIncome;

        // Simple air roster per side (T1)
    // string scout = (side == "armada" ? "armpeep" : side == "cortex" ? "corfink" : "legfig" );
        // string fighter = (side == "armada" ? "armfig" : side == "cortex" ? "corveng" : "legfig" );
        // string bomber = (side == "armada" ? "armthund" : side == "cortex" ? "corhurc" : "legbmb" );
        // // Prefer fighters early, sprinkle scouts and bombers

        // // Maintain a small scout presence
        // int scouts = UnitDefHelpers::SumUnitDefCounts({ scout });
        // if (scouts < 2 && ei > 150.0f) {
        //     CCircuitDef@ d = ai.GetCircuitDef(scout);
        //     if (d !is null && d.IsAvailable(ai.frame))
        //         return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::NORMAL, d, pos, 64.f));
        // }

        // // Fighters: mainline AA/air control
        // int fighters = UnitDefHelpers::SumUnitDefCounts({ fighter });
        // if (fighters < 8 && mi > 8.0f && ei > 220.0f) {
        //     CCircuitDef@ d = ai.GetCircuitDef(fighter);
        //     if (d !is null && d.IsAvailable(ai.frame))
        //         return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, d, pos, 64.f));
        // }

        // // Bombers: gated heavier by eco
        // int bombers = UnitDefHelpers::SumUnitDefCounts({ bomber });
        // if (bombers < 4 && mi > 10.0f && ei > 300.0f) {
        //     CCircuitDef@ d = ai.GetCircuitDef(bomber);
        //     if (d !is null && d.IsAvailable(ai.frame))
        //         return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::NORMAL, d, pos, 64.f));
        // }

        // Fallback to default when no specific recruit fired
        return aiFactoryMgr.DefaultMakeTask(u);
    }

    string Air_SelectFactoryHandler(const AIFloat3& in pos, bool isStart, bool isReset) {
        if(isStart) {
            if(Global::Map::NearestMapStartPosition !is null) {
                return FactoryHelpers::SelectStartFactoryForRole(Global::AISettings::Role, Global::AISettings::Side);
            } else {
                GenericHelpers::LogUtil("[Air_SelectFactoryHandler] nearestMapPosition is null", 2);
                return FactoryHelpers::GetFallbackStartFactoryForRole(Global::AISettings::Role, Global::AISettings::Side);
            }
        }
   
        return "";
    }

    // Local default implementations (ready to customize per-role)
    bool Air_AiIsSwitchTime(int lastSwitchFrame) {
        int interval = (30 * SECOND);
        return (lastSwitchFrame + interval) <= ai.frame;
    }
    bool Air_AiIsSwitchAllowed(const CCircuitDef@ facDef, float armyCost, int factoryCount, float metalCurrent, bool &out assistRequired) {
        const bool isOK = (armyCost > 1.2f * facDef.costM * float(factoryCount)) || (metalCurrent > facDef.costM);
        assistRequired = !isOK;
        return isOK;
    }
    int Air_MakeSwitchInterval() {
        return AiRandom(Global::RoleSettings::Air::MinAiSwitchTime, Global::RoleSettings::Air::MaxAiSwitchTime) * SECOND;
    }
    
    
    /******************************************************************************

    MILITARY HOOKS

    ******************************************************************************/
    
    bool Air_AiIsAirValid() {
        //GenericHelpers::LogUtil("[AIR] Enter Air_AiIsAirValid", 4);
        return true;
    }

    // If the unit is a bomber and we have fewer than a minimum bomber count globally,
    // return null to defer making a task (avoid trickling in solo bombers).
    // IUnitTask@ Air_MilitaryAiMakeTask(CCircuitUnit@ u)
    // {
    //     const CCircuitDef@ cdef = (u is null ? null : u.circuitDef);
    //     if (cdef is null) {
    //         return aiMilitaryMgr.DefaultMakeTask(u);
    //     }

    //     // Detect bomber units via role mask (engine-provided)
    // const bool isBomber = cdef.IsRoleAny(Unit::Role::BOMBER.mask);

    //     if (isBomber) {
    //         // Count total bombers across all factions we field (T1 + T2 canonical bombers)
    //         // Keep this list minimal and explicit; extend if we add more bomber variants later.
    //         array<string> bomberIds;
    //         bomberIds.insertLast("armthund");   // ARM T1 bomber
    //         bomberIds.insertLast("corshad");    // CORE T1 bomber
    //         bomberIds.insertLast("legmos");     // LEG T1 bomber
    //         bomberIds.insertLast("armpnix");    // ARM T2 bomber
    //         bomberIds.insertLast("corhurc");    // CORE T2 bomber
    //         bomberIds.insertLast("legphoenix"); // LEG T2 bomber

    //         const int totalBombers = UnitDefHelpers::SumUnitDefCounts(bomberIds);
    //         if (totalBombers < 10) {
    //             // Gate early: hold off on issuing tasks to bombers until we have a small pack
    //             // to reduce ineffective trickle attacks.
    //             return null;
    //         }
    //     }

    //     // Fallback to default military behavior for non-bombers or when threshold met
    //     return aiMilitaryMgr.DefaultMakeTask(u);
    // }

    /******************************************************************************

    BUILDER HOOKS

    ******************************************************************************/ 

    IUnitTask@ Air_BuilderAiMakeTask(CCircuitUnit@ builder) {
        GenericHelpers::LogUtil("[Air_BuilderAiMakeTask] called for builder", 3);
        if (builder is null) return null;

        const CCircuitDef@ udef = builder.circuitDef;
        if (udef is null) return Builder::MakeDefaultTaskWithLog(builder.id, "AIR");

        if (UnitHelpers::IsCommander(udef)) {
            return Air_Commander_AiMakeTask(builder);
        }

        string uname = udef.GetName();
        bool isT1AirConstructor = (uname == "armca" || uname == "corca" || uname == "legca");
        if (isT1AirConstructor) {
            if (builder is Builder::primaryT1AirConstructor) {
                return Air_T1Constructor_AiMakeTask(builder);
            }
            if (builder is Builder::secondaryT1AirConstructor) {
                return Builder::MakeDefaultTaskWithLog(builder.id, "AIR expansion");
            }
            if (Air_IsBuildFocusActive()) {
                return Air_AssignFocusedFollower(builder);
            }
        }

        return Builder::MakeDefaultTaskWithLog(builder.id, "AIR");
    }

    /******************************************************************************

    BUILDER LOGIC (COMMANDER)

    ******************************************************************************/ 

    // Accelerate the first constructor, then reinforce the strategic lane while
    // early build-power focus remains active.
    IUnitTask@ Air_Commander_AiMakeTask(CCircuitUnit@ comm)
    {
        if (comm is null) return null;

        const int AIR_FACTORY_ASSIST_DEADLINE_FRAMES = Global::RoleSettings::Air::CommanderFactoryAssistDeadlineSeconds * SECOND;
        CCircuitUnit@ primary = Builder::primaryT1AirConstructor;
        if (primary !is null) {
            IUnitTask@ windTask = Air_TryCommanderWind(comm);
            if (windTask !is null) return windTask;

            if (g_airStrategicFocusTask !is null
                && primary.id == g_airStrategicFocusLeaderId && Air_IsBuildFocusActive()) {
                IUnitTask@ focusGuard = GuardHelpers::AssignWorkerGuard(
                    comm,
                    primary,
                    Task::Priority::HIGH,
                    true,
                    Global::RoleSettings::Air::CommanderFactoryAssistGuardTimeoutSeconds * SECOND
                );
                if (focusGuard !is null) return focusGuard;
            }
        }

        if (primary !is null || ai.frame > AIR_FACTORY_ASSIST_DEADLINE_FRAMES) {
            return Builder::MakeDefaultTaskWithLog(comm.id, "AIR commander");
        }

        CCircuitUnit@ target = null;
        if (Factory::primaryT1AirPlant !is null) {
            @target = Factory::primaryT1AirPlant;
        }

        if (target is null) {
            return Builder::MakeDefaultTaskWithLog(comm.id, "AIR commander");
        }

        // Assign a high-priority guard task so the commander sticks near the air factory.
        // The guard timeout is configurable via role settings.
        const int AIR_FACTORY_ASSIST_GUARD_TIMEOUT_FRAMES = Global::RoleSettings::Air::CommanderFactoryAssistGuardTimeoutSeconds * SECOND;
        IUnitTask@ guardTask = GuardHelpers::AssignWorkerGuard(
            comm,
            target,
            Task::Priority::HIGH,
            true,
            AIR_FACTORY_ASSIST_GUARD_TIMEOUT_FRAMES // guard duration; can be renewed while within deadline
        );

        if (guardTask !is null) return guardTask;
        return Builder::MakeDefaultTaskWithLog(comm.id, "AIR commander");
    }

    void Air_BuilderAiUnitAdded(CCircuitUnit@ unit, Unit::UseAs usage)
	{
		//LogUtil("BUILDER::AiUnitAdded:" + unit.circuitDef, 2);
		const CCircuitDef@ cdef = unit.circuitDef;
		if (usage != Unit::UseAs::BUILDER || cdef.IsRoleAny(Unit::Role::COMM.mask))
			return;

        string uname = cdef.GetName();
        bool isT1AirConstructor = (uname == "armca" || uname == "corca" || uname == "legca");
        bool isT2AirConstructor = (uname == "armaca" || uname == "coraca" || uname == "legaca");

        if (isT1AirConstructor && unit !is Builder::primaryT1AirConstructor) {
            unit.DelAttribute(Unit::Attr::BASE.type);
        }
        else if (isT2AirConstructor) {
            // Advanced air constructors must be able to take expansion and
            // advanced-economy tasks instead of all becoming base energizers.
            unit.DelAttribute(Unit::Attr::BASE.type);
        }

	}

    void Air_BuilderAiTaskAdded(IUnitTask@ task) {
        GenericHelpers::LogUtil("[Air_BuilderAiTaskAdded] called for task", 3);
    }

    void Air_BuilderAiTaskRemoved(IUnitTask@ task, bool done) {
        if (task !is null && task is g_airCommanderWindTask) {
            @g_airCommanderWindTask = null;
        }
        if (task !is null && task is g_airStrategicFocusTask) {
            @g_airStrategicFocusTask = null;
            g_airStrategicFocusLeaderId = -1;
        }
    }

    void Air_BuilderAiUnitRemoved(CCircuitUnit@ unit, Unit::UseAs usage)
    {
        if (unit !is null && unit.circuitDef !is null
            && UnitHelpers::IsCommander(unit.circuitDef)) {
            @g_airCommanderWindTask = null;
        }
        if (unit !is null && unit.id == g_airStrategicFocusLeaderId) {
            @g_airStrategicFocusTask = null;
            g_airStrategicFocusLeaderId = -1;
        }
    }

    /******************************************************************************

    BUILDER LOGIC

    ******************************************************************************/

    IUnitTask@ Air_T1Constructor_AiMakeTask(CCircuitUnit@ u) {
        // Snapshot economy
        //float mi = Global::Economy::MetalIncome;
        //float ei = Global::Economy::EnergyIncome;
		float mi = Economy::GetMinMetalIncomeLast10s();
		float ei = Economy::GetMinEnergyIncomeLast10s();

        AIFloat3 conLocation = u.GetPos(ai.frame);
        string unitSide = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        if (u is Builder::primaryT1AirConstructor) {

            // Consider upgrading to a T2 Aircraft Plant if economy and prerequisites allow
            //if (!Builder::IsT2AirPlantQueued) {
                int t2AirPlantCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2AircraftPlants());
                bool hasPrimaryT1AirPlant = (Factory::primaryT1AirPlant !is null);
                if (EconomyHelpers::ShouldBuildT2AircraftPlant(
                    /*mi*/ mi,
                    /*ei*/ ei,
                    /*metalCurrent*/ aiEconomyMgr.metal.current,
                    /*requiredMetalIncome*/ Global::RoleSettings::Air::RequiredMetalIncomeForT2AircraftPlant,
                    /*requiredMetalCurrent*/ Global::RoleSettings::Air::RequiredMetalCurrentForT2AircraftPlant,
                    /*requiredEnergyIncome*/ Global::RoleSettings::Air::RequiredEnergyIncomeForT2AircraftPlant,
                    /*constructorDef*/ u.circuitDef,
                    /*t2AirPlantCount*/ t2AirPlantCount,
                    /*maxAllowed*/ Global::RoleSettings::Air::MaxT2AircraftPlants
                ) && hasPrimaryT1AirPlant) {
                    AIFloat3 anchor = Factory::GetT1AirPlantPos();
                    IUnitTask@ tT2Air = Builder::EnqueueT2AirPlant(unitSide, anchor, SQUARE_SIZE * 30, 600 * SECOND);
                    if (tT2Air !is null) return Air_SetStrategicFocus(u, tT2Air);
                }
                // Reserve-trigger: if metal reserves exceed 1300 and we have zero T2 air plants, force-queue one
                // regardless of income thresholds. Avoid duplicate enqueue if a build is already queued.
                if (hasPrimaryT1AirPlant && t2AirPlantCount <= 0 && aiEconomyMgr.metal.current > 1300.0f) {
                    AIFloat3 anchor2 = Factory::GetT1AirPlantPos();
                    IUnitTask@ tForceT2 = Builder::EnqueueT2AirPlant(unitSide, anchor2, SQUARE_SIZE * 40, 600 * SECOND);
                    if (tForceT2 !is null) return Air_SetStrategicFocus(u, tForceT2);
                }
           // }

            // Build Energy Converter?
            if (EconomyHelpers::ShouldBuildT1EnergyConverter(
                /*metalIncome*/ mi,
                /*energyIncome*/ ei,
                /*energyCurrent*/ aiEconomyMgr.energy.current,
                /*energyStorage*/ aiEconomyMgr.energy.storage,
                /*untilMetalIncome*/ Global::RoleSettings::Air::BuildT1ConvertersUntilMetalIncome,
                /*minEnergyIncome*/ Global::RoleSettings::Air::BuildT1ConvertersMinimumEnergyIncome,
                /*minEnergyCurrentPercent*/ Global::RoleSettings::Air::BuildT1ConvertersMinimumEnergyCurrentPercent
            )) {
                IUnitTask@ tConv = Builder::EnqueueT1EnergyConverter(unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 30);
                if (tConv !is null) return Air_SetStrategicFocus(u, tConv);
            }

            // Build regular solar?
            if (EconomyHelpers::ShouldBuildT1Solar(
                /*energyIncome*/ ei,
                /*minEnergyIncome*/ Global::RoleSettings::Air::SolarEnergyIncomeMinimum
            )) {
                IUnitTask@ tSolar = Builder::EnqueueT1Solar(u.id, unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 30);
                if (tSolar !is null) return Air_SetStrategicFocus(u, tSolar);
            }

            // Build a T1 nano caretaker if under desired target (income-based) or reserves allow
            float energyPercent = (aiEconomyMgr.energy.storage > 0.0f)
                ? (aiEconomyMgr.energy.current / aiEconomyMgr.energy.storage)
                : 0.0f;

            // Only build nanos if we have a preferred factory to anchor around
            if (Factory::GetPreferredFactory() !is null && EconomyHelpers::ShouldBuildT1Nano(
                ei,
                mi,
                Global::RoleSettings::Air::NanoEnergyPerUnit,
                Global::RoleSettings::Air::NanoMetalPerUnit,
                Global::RoleSettings::Air::NanoMaxCount,
                aiEconomyMgr.metal.current,
                Global::RoleSettings::Air::NanoBuildWhenOverMetal,
                energyPercent
            )) {
                // Centralized selection with per-factory nano caps and prioritization
                CCircuitUnit@ targetFactory = Factory::SelectFactoryNeedingNano();
                if (targetFactory !is null) {
                    IUnitTask@ tNano = Factory::EnqueueNanoForFactory(targetFactory, Task::Priority::NORMAL);
                    if (tNano !is null) return Air_SetStrategicFocus(u, tNano);
                }
            }

            // Build advanced T1 solar using Air predicate
            // Compute current T2 air-related counts
            array<string> t2AirCons; t2AirCons = { "armaca", "coraca", "legaca" };
            int t2ConstructionAircraftCount = UnitDefHelpers::SumUnitDefCounts(t2AirCons);
            array<string> t2AirPlants = UnitHelpers::GetAllT2AircraftPlants();
            int t2AircraftPlantCount = UnitDefHelpers::SumUnitDefCounts(t2AirPlants);

            const bool advancedSolarTimingReady =
                ai.frame >= Global::RoleSettings::Air::AdvancedSolarEarliestSeconds * SECOND
                && mi >= Global::RoleSettings::Air::AdvancedSolarMinimumMetalIncome
                && aiEconomyMgr.metal.current >= Global::RoleSettings::Air::AdvancedSolarMinimumMetalCurrent
                && !aiEconomyMgr.isEnergyFull
                && !Air_HasCommanderWindOpportunity(unitSide);
            if (advancedSolarTimingReady && EconomyHelpers::ShouldBuildT1AdvancedSolar(
                /*energyIncome*/ ei,
                /*metalIncome*/ mi,
                /*energyIncomeMinimumThreshold*/ Global::RoleSettings::Air::AdvancedSolarEnergyIncomeMinimum,
                /*energyIncomeMaximumThreshold*/ Global::RoleSettings::Air::AdvancedSolarEnergyIncomeMaximum,
                /*t2ConstructorCount*/ t2ConstructionAircraftCount,
                /*t2FactoryCount*/ t2AircraftPlantCount,
                /*isT2FactoryQueued*/ Factory::IsT2AirPlantBuildQueued(),
                /*enableT2ProgressGate*/ true,
                /*metalIncomeFallbackMinimum*/ 6.0f
            )) {
                IUnitTask@ tAdvSolar = Builder::EnqueueT1AdvancedSolar(u.id, unitSide, conLocation, SQUARE_SIZE * 32, SECOND * 30);
                if (tAdvSolar !is null) return Air_SetStrategicFocus(u, tAdvSolar);
            } 
        }

        IUnitTask@ defaultTask = Builder::MakeDefaultTaskWithLog(u.id, "AIR strategic");
        return Air_SetStrategicFocus(u, defaultTask);
    }


    /******************************************************************************

    ROLE CONFIGURATION

    ******************************************************************************/
   

    bool Air_RoleMatch(AiRole preferredMapRole, const string &in side, const AIFloat3& in pos, const string &in defaultStartFactory) {
        bool match = false;

        if (preferredMapRole == AiRole::AIR) match = true;
       
        if (match) { 
            GenericHelpers::LogUtil("[RoleMatch] AIR", 2); 
        }

        return match;
    }

    void Register() {
        if (RoleConfigs::Get(AiRole::AIR) !is null) return;
        RoleConfig@ cfg = RoleConfig(AiRole::AIR, cast<MainUpdateDelegate@>(@Air_MainUpdate));

        @cfg.InitHandler = cast<InitDelegate@>(@Air_Init);

        @cfg.AiIsSwitchTimeHandler = cast<AiIsSwitchTimeDelegate@>(@Air_AiIsSwitchTime);
        @cfg.AiIsSwitchAllowedHandler = cast<AiIsSwitchAllowedDelegate@>(@Air_AiIsSwitchAllowed);
        @cfg.MakeSwitchIntervalHandler = cast<MakeSwitchIntervalDelegate@>(@Air_MakeSwitchInterval);

        @cfg.BuilderAiMakeTaskHandler = cast<AiMakeTaskDelegate@>(@Air_BuilderAiMakeTask);
        @cfg.FactoryAiMakeTaskHandler = cast<AiMakeTaskDelegate@>(@Air_FactoryAiMakeTask);
        
        @cfg.BuilderAiUnitAdded = cast<AiUnitAddedDelegate@>(@Air_BuilderAiUnitAdded);
        @cfg.BuilderAiUnitRemoved = cast<AiUnitRemovedDelegate@>(@Air_BuilderAiUnitRemoved);

        @cfg.BuilderAiTaskAddedHandler = cast<AiTaskAddedDelegate@>(@Air_BuilderAiTaskAdded);
        @cfg.BuilderAiTaskRemovedHandler = cast<AiTaskRemovedDelegate@>(@Air_BuilderAiTaskRemoved);

        @cfg.SelectFactoryHandler = cast<SelectFactoryDelegate@>(@Air_SelectFactoryHandler);
        @cfg.EconomyUpdateHandler = cast<EconomyUpdateDelegate@>(@Air_EconomyUpdate);

        @cfg.AiIsAirValidHandler = cast<AiIsAirValidDelegate@>(@Air_AiIsAirValid);
        @cfg.RoleMatchHandler = cast<RoleMatchDelegate@>(@Air_RoleMatch);

        RoleConfigs::Register(cfg);
    }
}