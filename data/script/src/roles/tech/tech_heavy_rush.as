#include "../../global.as"
#include "../../helpers/math/heavy_rush_math.as"
#include "../../systems/team/donation.as"

// A finite production obligation, independent of SPAM_RUSH. Only one lab and
// one recruit task belong to this controller. Existing economy update cadence
// services a bounded retained-unit ledger; no per-frame army census or command resend.
namespace TechHeavyRush {
    const string StateKey = "tech.heavy.";
    int completed = 0;
    int targetCount = -1;
    int labId = -1;
    int orderedFrame = -1;
    IUnitTask@ recruit;
    int nextTrace = 0;
    int nextRoute = 0;
    int engineUnitLimit = 0;
    int priorProductionLimit = -1;

    bool Selected() {
        return Global::AISettings::Role == AiRole::TECH
            && Global::RoleSettings::Tech::HeavyRushEnabled
            && Global::RoleSettings::Tech::HasStrategy(Strategy::T2_RUSH);
    }
    int TargetCount() {
        // O(1) cached read in production/retirement predicates. Persist before
        // enqueueing so role reinitialization cannot reroll an active batch.
        // Only the first selected rush consumes RNG; fixed bounds consume none.
        if (targetCount < 0) {
            targetCount = aiTerrainMgr.GetLayoutInt(StateKey + "target-count", -1);
            if (targetCount < 0) {
                const int minimumCount = AiMax(1, Global::RoleSettings::Tech::HeavyRushCountMin);
                const int maximumCount = AiMax(minimumCount, Global::RoleSettings::Tech::HeavyRushCountMax);
                targetCount = minimumCount == maximumCount ? minimumCount : AiRandom(minimumCount, maximumCount);
                aiTerrainMgr.SetLayoutInt(StateKey + "target-count", targetCount);
                GenericHelpers::LogUtil("[TECH][HeavyRush] target=" + targetCount
                    + " bounds=" + minimumCount + "-" + maximumCount, 1);
            }
        }
        return targetCount;
    }
    bool Pending() { return Selected() && completed < TargetCount(); }
    void Init() {
        completed = aiTerrainMgr.GetLayoutInt(StateKey + "completed", 0);
        targetCount = aiTerrainMgr.GetLayoutInt(StateKey + "target-count", -1);
        if (Selected()) TargetCount();
        labId = aiTerrainMgr.GetLayoutInt(StateKey + "lab", -1);
        orderedFrame = aiTerrainMgr.GetLayoutInt(StateKey + "ordered", -1);
        nextRoute = 0;
        retained.resize(0);
        routeFactories.resize(0);
        // The "gift." key name predates D-449 and is kept for saved games.
        for (int index = 0; index < completed; ++index) {
            const int id = aiTerrainMgr.GetLayoutInt(StateKey + "gift." + index, -1);
            if (ai.GetTeamUnit(id) !is null) Retain(id);
        }
        priorProductionLimit = aiTerrainMgr.GetLayoutInt(StateKey + "production-limit", -1);
        @recruit = null;
        CCircuitDef@ definition = ai.GetCircuitDef(UnitName());
        engineUnitLimit = aiTerrainMgr.GetLayoutInt(StateKey + "unit-limit", -1);
        if (engineUnitLimit < 0) {
            engineUnitLimit = definition is null ? 0 : definition.maxThisUnit;
            aiTerrainMgr.SetLayoutInt(StateKey + "unit-limit", engineUnitLimit);
        }
    }
    bool SiloReady() {
        if (TechPlan::Choose() != "nuke" && !TechChain::NukeRush()) return true;
        if (aiTerrainMgr.GetLayoutInt(StateKey + "silo-completed", 0) != 0) return true;
        CCircuitDef@ silo = ai.GetCircuitDef(TechChain::DefFor("silo"));
        const bool ready = silo !is null && silo.count - aiBuilderMgr.GetUnfinishedCount(silo) > 0;
        if (ready) aiTerrainMgr.SetLayoutInt(StateKey + "silo-completed", 1);
        return ready;
    }
    bool ProtectLab(int id) {
        // Before selecting a producer, retain the primary lab for this batch.
        // The nuke-specific refund caller explicitly overrides this protection.
        return Pending() && (labId < 0 || id == labId);
    }
    string UnitName() {
        string name;
        if (!Global::RoleSettings::Tech::HeavyRushUnits.get(Global::AISettings::Side, name)) return "";
        return name;
    }
    void Blocked(const string& in reason) {
        if (ai.frame < nextTrace) return;
        nextTrace = ai.frame + 30 * SECOND;
        GenericHelpers::LogUtil("[TECH][HeavyRush] waiting: " + reason + "; completed=" + completed, 1);
    }
    bool RequiresFusion() {
        CCircuitDef@ fusion = ai.GetCircuitDef(TechChain::DefFor("fusion"));
        const int completedFusions = fusion is null ? 0 : fusion.count - aiBuilderMgr.GetUnfinishedCount(fusion);
        return HeavyRushMath::RequiresFusion(Pending(), completedFusions, LocalGeothermal::Output(),
            Global::RoleSettings::Tech::HeavyRushStableEnergy);
    }
    bool Affordable(CCircuitDef@ definition) {
        if (!SiloReady()) { Blocked("completed silo"); return false; }
        if (RequiresFusion()) { Blocked("stable fusion/geothermal power"); return false; }
        if (!MetalEconomy::Active()) {
            const AIFloat3 mex = Economy::MexTracker::GetNearestNonUpgradedMexInRange(
                Global::Map::StartPos, Global::Map::StartPos, Global::RoleSettings::Tech::OpeningMexRadius);
            if (mex.x >= 0.0f) { Blocked("home mex upgrades"); return false; }
        }
        const float horizon = Global::RoleSettings::Tech::HeavyRushBudgetSeconds;
        const float share = Global::RoleSettings::Tech::HeavyRushIncomeShare;
        const float converterUsage = ai.GetTeamRulesParam("mmUse", 0.0f);
        float usage = TeamEconomy::OwnEnergy(TeamEconomy::USAGE);
        // Keep the original first-missile funding priority. Outside that
        // window, admit against actual non-converter consumption, not the
        // hypothetical pull of all idle/underfunded construction power.
        if (TechChain::nukeFundingSilo >= 0) usage = AiMax(usage, aiEconomyMgr.energy.pull);
        const float availableEnergy = HeavyRushMath::AvailableEnergy(aiEconomyMgr.energy.income,
            usage, converterUsage, Global::RoleSettings::Tech::HeavyRushEnergyMargin);
        const float metalIncome = Economy::GetMinMetalIncomeLast10s();
        const bool funded = HeavyRushMath::CanFund(definition.costM, definition.costE,
            metalIncome, availableEnergy, aiEconomyMgr.metal.current, aiEconomyMgr.energy.current,
            horizon, share, Global::RoleSettings::Tech::HeavyRushMetalIncome);
        if (!funded) Blocked("income/energy budget");
        return funded;
    }
    IUnitTask@ Produce(CCircuitUnit@ factory) {
        if (AiPerfEnabled) AiPerfBeginLabel("tech-heavy-production");
        IUnitTask@ result = ProduceImpl(factory);
        if (AiPerfEnabled) AiPerfEndLabel();
        return result;
    }
    IUnitTask@ ProduceImpl(CCircuitUnit@ factory) {
        if (!Pending() || factory is null || !UnitHelpers::IsT2BotLab(factory.circuitDef.GetName())) return null;
        if (labId >= 0 && ai.GetTeamUnit(labId) is null) labId = -1;
        if (labId < 0) {
            labId = factory.id;
            aiTerrainMgr.SetLayoutInt(StateKey + "lab", labId);
        }
        if (factory.id != labId) return null;
        // Preserve the existing high-bank constructor expansion before taking
        // the lab for combat. This is bounded by T2BotConstructorCap, unlike
        // discretionary fast-assist production whose target grows with income.
        const int builderCount = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors(), true);
        if (aiEconomyMgr.metal.storage > 0.0f
            && aiEconomyMgr.metal.current > aiEconomyMgr.metal.storage * Global::RoleSettings::Tech::T2ConstructorBankShare
            && builderCount < Global::RoleSettings::Tech::T2BotConstructorCap) return null;
        // Essential own constructors precede the heavy batch, like requested
        // constructor donations handled by the factory adapter before this role.
        array<string> constructors = UnitHelpers::GetT2BotConstructors(Global::AISettings::Side);
        if (constructors.length() > 0) {
            CCircuitDef@ builder = ai.GetCircuitDef(constructors[0]);
            const int wanted = Global::RoleSettings::Tech::MinimumT2ConstructorBots;
            if (builder !is null && TechEconomyMath::WorkforceNeeded(builder.count, aiFactoryMgr.GetPendingRecruitCount(builder), wanted)) {
                if (builder.maxThisUnit < wanted) builder.maxThisUnit = wanted;
                return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH,
                    builder, factory.GetPos(ai.frame), 64.f));
            }
        }
        CCircuitDef@ definition = ai.GetCircuitDef(UnitName());
        if (definition is null || !factory.circuitDef.CanBuild(definition) || engineUnitLimit <= 0) {
            Blocked("available heavy unit");
            return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        }
        if (recruit !is null && !recruit.IsDead()) return recruit;
        if (aiFactoryMgr.GetPendingRecruitCount(definition) > 0 || !Affordable(definition))
            return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        if (priorProductionLimit < 0) {
            priorProductionLimit = definition.maxThisUnit;
            aiTerrainMgr.SetLayoutInt(StateKey + "production-limit", priorProductionLimit);
        }
        if (definition.maxThisUnit <= definition.count) definition.maxThisUnit = AiMin(engineUnitLimit, definition.count + 1);
        if (!definition.IsAvailable(ai.frame)) return aiFactoryMgr.Enqueue(TaskS::Wait(false, 3 * SECOND));
        @recruit = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::NORMAL,
            definition, factory.GetPos(ai.frame), 64.f));
        if (recruit !is null) {
            orderedFrame = ai.frame;
            aiTerrainMgr.SetLayoutInt(StateKey + "ordered", orderedFrame);
            GenericHelpers::LogUtil("[TECH][HeavyRush] recruit " + UnitName() + " number=" + (completed + 1), 1);
        }
        return recruit;
    }
    bool IsBatchProduction(CCircuitUnit@ unit) {
        return Pending() && unit !is null && unit.circuitDef.GetName() == UnitName()
            && unit.GetProducerId() == labId && orderedFrame >= 0 && unit.GetProductionFrame() >= orderedFrame;
    }
    bool OnFinished(CCircuitUnit@ unit) {
        if (Owns(unit)) return true;
        if (!IsBatchProduction(unit)) return false;
        // Persistent per-budget-slot identity survives reassignment and duplicate
        // callbacks. The ledger grows with configured batch size, not army size.
        for (int index = 0; index < completed; ++index)
            if (aiTerrainMgr.GetLayoutInt(StateKey + "gift." + index, -1) == unit.id) return true;
        aiTerrainMgr.SetLayoutInt(StateKey + "gift." + completed, unit.id);
        Retain(unit.id);
        ++completed;
        aiTerrainMgr.SetLayoutInt(StateKey + "completed", completed);
        // Release only the definition limit this finite controller borrowed.
        // Retained combat units do not justify another production slot.
        if (!Pending() && priorProductionLimit >= 0) {
            CCircuitDef@ definition = ai.GetCircuitDef(UnitName());
            if (definition !is null) definition.maxThisUnit = priorProductionLimit;
        }
        orderedFrame = -1;
        aiTerrainMgr.SetLayoutInt(StateKey + "ordered", -1);
        @recruit = null;
        GenericHelpers::LogUtil("[TECH][HeavyRush] completed " + completed + "/" + TargetCount(), 1);
        return true; // route assignment is deferred past native UnitAdded assignment
    }
    // B7: retained heavies and their cached spam factory, in parallel arrays
    // bounded by the configured batch size (a few units), so lookups are a
    // short linear scan with no string keys. Routing searches only registered
    // spam factories on assignment/recovery, never the army. IDs only.
    array<int> retained;
    array<int> routeFactories;
    void Retain(int id) {
        if (id < 0 || retained.find(id) >= 0) return;
        retained.insertLast(id);
        routeFactories.insertLast(-1);
    }
    bool Owns(CCircuitUnit@ unit) {
        return Selected() && unit !is null && retained.find(unit.id) >= 0;
    }
    void Removed(CCircuitUnit@ unit) {
        if (unit is null) return;
        const int index = retained.find(unit.id);
        if (index < 0) return;
        retained.removeAt(uint(index));
        routeFactories.removeAt(uint(index));
    }
    IUnitTask@ MilitaryTask(CCircuitUnit@ unit) {
        if (!Owns(unit) || EdgeLanes::IsReleased(unit)) return null;
        if (unit.task !is null && (unit.task.IsExternalControlled()
            || unit.task.GetType() == int(Task::Type::PLAYER)
            || unit.task.GetType() == int(Task::Type::RETREAT))) return unit.task;
        const uint index = uint(retained.find(unit.id));
        const int factoryId = routeFactories[index];
        CCircuitUnit@ factory = Spam::routeByFactory.exists("" + factoryId) ? ai.GetTeamUnit(factoryId) : null;
        if (factory is null) {
            @factory = Spam::_NearestSpamFactory(unit.GetPos(ai.frame));
            if (factory is null) return null;
            routeFactories[index] = factory.id;
        }
        return Spam::RouteFor(factory);
    }
    void Tick() {
        if (!Selected() || nextRoute >= completed) return;
        // Completion callback precedes native assignment. Attach afterward on
        // the existing economy cadence; wait for a spam route without donating.
        while (nextRoute < completed) {
            const int id = aiTerrainMgr.GetLayoutInt(StateKey + "gift." + nextRoute, -1);
            CCircuitUnit@ unit = ai.GetTeamUnit(id);
            if (unit !is null && !EdgeLanes::IsReleased(unit)) {
                IUnitTask@ task = MilitaryTask(unit);
                if (task is null) return;
                if (unit.task !is task) aiMilitaryMgr.TransferUnit(unit, task);
                GenericHelpers::LogUtil("[TECH][HeavyRush] retained cargo=" + id + " spam route assigned", 1);
            }
            ++nextRoute;
        }
    }
}
