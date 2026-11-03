#include "../../helpers/construction/guard_helpers.as"

// Air Foundry owns a bounded completion-order cohort, not all air builders.
// Lifecycle updates are O(configured seats); task lookup is O(1). No polling,
// army scans, or borrowed native handles are retained.
namespace TechAirFoundry {
    dictionary members;
    array<int> seats;
    void Configure() {
        const int count = AiMax(0, AiMin(64, int(aiSetupMgr.ConfigFloat(
            "tech_production/air_foundry_count", float(Global::RoleSettings::Tech::AirFactoryAssistCount)))));
        Global::RoleSettings::Tech::AirFactoryAssistCount = count;
        seats.resize(count);
        for (uint i = 0; i < seats.length(); ++i) seats[i] = -1;
        members.deleteAll();
    }
    bool Owns(int id) { return Global::AISettings::Role == AiRole::TECH && members.exists("" + id); }
    void Added(CCircuitUnit@ unit) {
        if (unit is null || Owns(unit.id) || unit.GetBuildProgress() < 1.f
            || Team::Ferry::IsGift(unit.id)) return;
        const string name = unit.circuitDef.GetName();
        if (name != "armca" && name != "corca" && name != "legca") return;
        for (uint i = 0; i < seats.length(); ++i) {
            if (seats[i] >= 0) continue;
            seats[i] = unit.id;
            members.set("" + unit.id, int(i));
            GenericHelpers::LogUtil("[TechAirFoundry] admitted unit=" + unit.id + " seat=" + i, 1);
            return;
        }
    }
    void Removed(CCircuitUnit@ unit) {
        int seat = -1;
        if (unit is null || !members.get("" + unit.id, seat)) return;
        seats[seat] = -1;
        members.delete("" + unit.id);
    }
    IUnitTask@ Work(CCircuitUnit@ unit) {
        if (unit is null || !Owns(unit.id)) return null;
        if (unit.task !is null && (unit.task.IsExternalControlled() || unit.task.IsEnemyReclaim()
            || unit.task.GetType() == int(Task::Type::PLAYER)
            || unit.task.GetType() == int(Task::Type::RETREAT))) return unit.task;
        // Reacquire the factory by id; the shared registry owns replacement.
        if (Factory::primaryT1AirPlant is null) return null;
        CCircuitUnit@ factory = ai.GetTeamUnit(Factory::primaryT1AirPlant.id);
        if (factory is null || factory.GetBuildProgress() < 1.f) return null;
        return GuardHelpers::AssignWorkerGuard(unit, factory, Task::Priority::HIGH, true, 30 * SECOND);
    }
}
