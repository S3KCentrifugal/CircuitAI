// Membership snapshots only; completion, position, retirement and task state
// remain live. A retained array is never mutated when a later ask refreshes it,
// so synchronous callbacks cannot invalidate an outer decision's iteration.
namespace AirInventory {
    class Group {
        array<string> names;
        array<uint64> versions;
        array<Id>@ snapshot;

        void Configure(const array<string>& in roster) {
            names.resize(0);
            for (uint i = 0; i < roster.length(); ++i)
                if (roster[i].length() > 0 && names.find(roster[i]) < 0) names.insertLast(roster[i]);
            versions.resize(0);
            @snapshot = null;
        }

        array<Id>@ Read() {
            bool changed = snapshot is null || versions.length() != names.length();
            if (versions.length() != names.length()) versions.resize(names.length());
            for (uint i = 0; i < names.length(); ++i) {
                const uint64 version = ai.GetOwnedDefinitionRevision(ai.GetCircuitDef(names[i]));
                if (versions[i] != version) changed = true;
                versions[i] = version;
            }
            if (changed) {
                array<Id>@ next = array<Id>();
                array<Id> members;
                for (uint i = 0; i < names.length(); ++i) {
                    ai.GetOwnedUnitIdsForDef(ai.GetCircuitDef(names[i]), members);
                    for (uint j = 0; j < members.length(); ++j) next.insertLast(members[j]);
                }
                // Preserve global unit-ID order across factions, including gifts.
                next.sortAsc();
                @snapshot = next;
            }
            return snapshot;
        }
    }
    Group nanos, advancedPlants, advancedFusions, constructors;
    bool configured = false;
    void Configure() {
        if (configured) return;
        array<string> nanoNames, fusionNames, constructorNames;
        array<string> sides = { "armada", "cortex", "legion" };
        for (uint i = 0; i < sides.length(); ++i) {
            nanoNames.insertLast(UnitHelpers::GetT1NanoNameForSide(sides[i]));
            fusionNames.insertLast(UnitHelpers::GetAdvFusionNameForSide(sides[i]));
            constructorNames.insertLast(UnitHelpers::GetT1AirConstructorNameForSide(sides[i]));
        }
        nanos.Configure(nanoNames);
        advancedPlants.Configure(UnitHelpers::GetAllT2AircraftPlants());
        advancedFusions.Configure(fusionNames);
        constructors.Configure(constructorNames);
        configured = true;
    }
}
