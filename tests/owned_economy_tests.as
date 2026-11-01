// Production helper with engine-boundary stubs; no duplicated selection logic.
typedef int Id;
class AIFloat3 {
    float x, y, z;
    AIFloat3() { x=0; y=0; z=0; }
    AIFloat3(float a,float b,float c) { x=a; y=b; z=c; }
}
namespace MapHelpers {
    float SqDist(const AIFloat3& in a,const AIFloat3& in b) {
        return (a.x-b.x)*(a.x-b.x)+(a.z-b.z)*(a.z-b.z);
    }
}
class CCircuitDef {
    string name;
    float extract=0;
    bool mobile=false;
    string GetName() const { return name; }
    float GetExtractsMetal() const { return extract; }
    bool IsMobile() const { return mobile; }
    bool CanBuild(const CCircuitDef@ other) const { return mobile && other !is null; }
}
class CCircuitUnit {
    int id;
    CCircuitDef@ circuitDef;
    AIFloat3 pos;
    float progress=1;
    AIFloat3 GetPos(int frame) const { return pos; }
    float GetBuildProgress() const { return progress; }
}
class FakeAI {
    int frame=0, enumerations=0;
    uint revision=0;
    array<CCircuitUnit@> units;
    uint GetOwnedUnitRevision() const { return revision; }
    array<Id>@ GetOwnedUnitIds() {
        ++enumerations;
        array<Id> ids;
        for(uint i=0;i<units.length();++i) if(units[i] !is null) ids.insertLast(int(i));
        return ids;
    }
    CCircuitUnit@ GetTeamUnit(int id) { return id>=0 && uint(id)<units.length() ? units[id] : null; }
    CCircuitDef@ GetCircuitDef(const string& in name) {
        for(uint i=0;i<units.length();++i) if(units[i] !is null && units[i].circuitDef.name==name) return units[i].circuitDef;
        return null;
    }
}
FakeAI ai;
void ResetOwned() {
    ai.units.resize(0); ai.enumerations=0; ++ai.revision;
    OwnedEconomy::initialized=false; OwnedEconomy::workerTargetName="";
}
CCircuitUnit@ AddOwned(string name,float extract,float x,bool mobile=false) {
    CCircuitUnit unit; CCircuitDef def;
    def.name=name; def.extract=extract; def.mobile=mobile;
    @unit.circuitDef=def; unit.id=int(ai.units.length()); unit.pos=AIFloat3(x,0,0);
    ai.units.insertLast(unit); ++ai.revision;
    return unit;
}
void test_owned_upgrade_filters_and_stable_nearest_tie() {
    ResetOwned();
    CCircuitUnit@ worker=AddOwned("worker",0,0,true);
    CCircuitUnit@ upgraded=AddOwned("moho",2,1);
    CCircuitUnit@ unfinished=AddOwned("mex",1,2); unfinished.progress=0.9f;
    CCircuitUnit@ nearest=AddOwned("mex",1,10);
    AddOwned("mex",1,-10); AddOwned("mex",1,100);
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),20) is nearest);
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),5) is null);
    Check(OwnedEconomy::NearestUpgradeTarget(null,upgraded.circuitDef,AIFloat3(),20) is null);
    Check(OwnedEconomy::NearestUpgradeTarget(worker,null,AIFloat3(),20) is null);
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),0) is null);
}
void test_owned_cache_membership_invalidates_but_completion_and_position_are_live() {
    ResetOwned();
    CCircuitUnit@ worker=AddOwned("worker",0,0,true);
    CCircuitUnit@ upgraded=AddOwned("moho",2,1);
    CCircuitUnit@ mex=AddOwned("mex",1,2); mex.progress=0.5f;
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),20) is null);
    mex.progress=1;
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),20) is mex);
    mex.pos.x=30;
    Check(OwnedEconomy::NearestUpgradeTarget(worker,upgraded.circuitDef,AIFloat3(),20) is null);
    Check(ai.enumerations==1);
    @ai.units[mex.id]=null; ++ai.revision;
    Check(OwnedEconomy::Extractors().length()==1);
    Check(ai.enumerations==2);
}
void test_owned_subsets_and_worker_target_cache() {
    ResetOwned();
    CCircuitUnit@ geo=AddOwned("corgeo",0,0);
    CCircuitUnit@ worker=AddOwned("worker",0,0,true);
    AddOwned("mex",1,10);
    Check(OwnedEconomy::Geothermal().length()==1);
    Check(OwnedEconomy::Workers(geo.circuitDef).length()==1);
    Check(OwnedEconomy::Workers(geo.circuitDef)[0]==worker.id);
    Check(ai.enumerations==2);
    Check(OwnedEconomy::Workers(null).length()==0);
    Check(ai.enumerations==3);
}
