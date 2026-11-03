#include "../../helpers/construction/guard_helpers.as"

// Air Foundry owns a bounded completion-order cohort, not all air builders.
// Lifecycle updates and lookups are O(configured seats, at most 64); no
// polling, army scans, or borrowed native handles are retained. Seats are
// saved as named layout state, so the cohort survives a save/load (C6).
namespace TechAirFoundry {
    const string SeatKey = "tech.air_foundry.seat.";
    array<int> seats;
    array<string> eligible;
    bool loaded = false;

    void Configure() {
        const int count = AiMax(0, AiMin(64, int(aiSetupMgr.ConfigFloat(
            "tech_production/air_foundry_count", float(Global::RoleSettings::Tech::AirFactoryAssistCount)))));
        Global::RoleSettings::Tech::AirFactoryAssistCount = count;
        seats.resize(count);
        for (uint i = 0; i < seats.length(); ++i) seats[i] = -1;
        eligible = UnitHelpers::GetAllT1AirConstructors();
        loaded = false;
    }
    void Save(uint seat) { aiTerrainMgr.SetLayoutInt(SeatKey + seat, seats[seat]); }
    // Re-admit saved members that still stand, once, after the layout state
    // is available. A missing or lost unit leaves its seat for the next one.
    void Load() {
        if (loaded) return;
        loaded = true;
        for (uint i = 0; i < seats.length(); ++i) {
            CCircuitUnit@ unit = ai.GetTeamUnit(aiTerrainMgr.GetLayoutInt(SeatKey + i, -1));
            seats[i] = (unit !is null && eligible.find(unit.circuitDef.GetName()) >= 0) ? unit.id : -1;
            Save(i);
        }
    }
    int Count() {
        Load();
        int n = 0;
        for (uint i = 0; i < seats.length(); ++i) if (seats[i] >= 0) ++n;
        return n;
    }
    bool Owns(int id) {
        if (Global::AISettings::Role != AiRole::TECH || id < 0) return false;
        Load();
        return seats.find(id) >= 0;
    }
    void Added(CCircuitUnit@ unit) {
        if (unit is null || Owns(unit.id) || unit.GetBuildProgress() < 1.f
            || Team::Ferry::IsGift(unit.id)) return;
        if (eligible.find(unit.circuitDef.GetName()) < 0) return;
        for (uint i = 0; i < seats.length(); ++i) {
            if (seats[i] >= 0) continue;
            seats[i] = unit.id;
            Save(i);
            GenericHelpers::LogUtil("[TechAirFoundry] admitted unit=" + unit.id + " seat=" + i, 1);
            return;
        }
    }
    void Removed(CCircuitUnit@ unit) {
        if (unit is null) return;
        Load();
        const int seat = seats.find(unit.id);
        if (seat < 0) return;
        seats[seat] = -1;
        Save(uint(seat));
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
