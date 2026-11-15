typedef int Id;
class CCircuitDef {
    string name;
    uint64 revision = 0;
    array<Id> units;
}
class InventoryHost {
    array<CCircuitDef@> definitions;
    CCircuitDef@ GetCircuitDef(const string& in name) {
        for (uint i = 0; i < definitions.length(); ++i)
            if (definitions[i].name == name) return definitions[i];
        return null;
    }
    uint64 GetOwnedDefinitionRevision(CCircuitDef@ def) { return def is null ? 0 : def.revision; }
    void GetOwnedUnitIdsForDef(CCircuitDef@ def, array<Id>& inout ids) {
        ids.resize(0);
        if (def !is null) ids = def.units;
    }
}
InventoryHost ai;
namespace UnitHelpers {
    string GetT1NanoNameForSide(const string& in side) { return side + "nano"; }
    string GetAdvFusionNameForSide(const string& in side) { return side + "fusion"; }
    string GetT1AirConstructorNameForSide(const string& in side) { return side + "constructor"; }
    array<string> GetAllT2AircraftPlants() { return { "plant" }; }
}

void test_inventory_mutation_and_retained_snapshot() {
    ai.definitions.resize(0);
    CCircuitDef a, b;
    a.name = "a"; b.name = "b";
    a.units = { 4, 9 }; b.units = { 2, 7 };
    ai.definitions.insertLast(a); ai.definitions.insertLast(b);
    AirInventory::Group group;
    group.Configure({ "a", "b", "missing" });
    array<Id>@ before = group.Read();
    Check(before.length() == 4);
    Check(before[0] == 2 && before[1] == 4 && before[2] == 7 && before[3] == 9);
    Check(before is group.Read()); // no allocation on unchanged membership
    a.units = { 3, 9 }; ++a.revision;
    array<Id>@ after = group.Read();
    Check(after !is before && after[1] == 3);
    Check(before[1] == 4); // reentrant refresh never mutates outer reader
    a.units.resize(0); ++a.revision;
    @after = group.Read(); Check(after.length() == 2);
    a.units = { 4 }; ++a.revision; // reused unit ID after ownership loss
    @after = group.Read(); Check(after.length() == 3 && after[1] == 4);
    group.Configure({ "b", "b", "" });
    @after = group.Read(); Check(after.length() == 2 && after[1] == 7);
}
