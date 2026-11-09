#include "../../helpers/math/front_energy_math.as"

// Native energy thresholds are preferences, including its last-hope fallback.
// Availability caps provide a hard FRONT-only admission floor before selection.
namespace FrontEnergy {
    class Gate {
        CCircuitDef@ definition; // immutable identity, owned by this AI for its lifetime
        string name;
        int configured = 0;
        int applied = 0;
    }
    array<Gate@> gates;
    bool loaded = false;

    bool AdvancedAllowed(float metal, float energy) {
        return FrontEnergyMath::AdvancedAllowed(metal, energy,
            Global::RoleSettings::Front::MinimumMetalIncomeForAFUS,
            Global::RoleSettings::Front::MinimumEnergyIncomeForAFUS);
    }
    void Release() {
        for (uint i = 0; i < gates.length(); ++i) {
            Gate@ gate = gates[i];
            if (gate.definition.maxThisUnit == gate.applied)
                gate.definition.maxThisUnit = gate.configured;
        }
        gates.resize(0);
        loaded = false;
    }
    void Update(bool mapLimitsApplied = false) {
        if (Global::AISettings::Role != AiRole::FRONT) return;
        if (!loaded) {
            // Three faction definitions, resolved once. Covers gifted builders too.
            const array<string> names = {"armafus", "corafus", "legafus"};
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitDef@ definition = ai.GetCircuitDef(names[i]);
                if (definition is null) continue;
                Gate@ gate = Gate();
                @gate.definition = definition;
                gate.name = names[i];
                gate.configured = definition.maxThisUnit;
                gate.applied = gate.configured;
                gates.insertLast(gate);
            }
            loaded = true;
        }
        const bool allowed = AdvancedAllowed(Economy::GetMinMetalIncomeLast10s(), Economy::GetMinEnergyIncomeLast10s());
        // Fixed three-entry pass at existing economy/builder hooks, no army scan.
        // Honor cap changes from map/role limits. Release before role restoration.
        for (uint i = 0; i < gates.length(); ++i) {
            Gate@ gate = gates[i];
            if ((mapLimitsApplied && Global::Map::Config.UnitLimits.exists(gate.name))
                || gate.definition.maxThisUnit != gate.applied)
                gate.configured = gate.definition.maxThisUnit;
            const int cap = FrontEnergyMath::AdmissionCap(allowed, gate.configured);
            if (gate.definition.maxThisUnit != cap) gate.definition.maxThisUnit = cap;
            gate.applied = cap;
        }
    }
}
