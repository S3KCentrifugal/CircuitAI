// Lifecycle-owned losses. Queue + unfinished counts prevent parallel labs
// producing the same replacement. Completed replacements remain TECH-owned.
namespace EngineeringReplacements {
    class Need { int def=-1,count=0; }
    array<Need@> needs;
    int nextEmergency=0;
    bool emergency=true;
    bool BaseEmergency() {
        if(ai.frame>=nextEmergency) {
            nextEmergency=ai.frame+SECOND;
            emergency=aiBattle.KnownEnemyNear(Global::Map::StartPos,
                Global::RoleSettings::Tech::AllyRange,30);
        }
        return emergency;
    }
    void Lost(int def) {
        for(uint i=0;i<needs.length();++i) if(needs[i].def==def) {++needs[i].count;return;}
        Need@ need=Need();need.def=def;need.count=1;needs.insertLast(need);
    }
    bool Claim(CCircuitUnit@ unit) {
        if(unit is null) return false;
        for(uint i=0;i<needs.length();++i) if(needs[i].def==unit.circuitDef.id && needs[i].count>0) {
            --needs[i].count;return true;
        }
        return false;
    }
    IUnitTask@ Recruit(CCircuitUnit@ factory) {
        if(!FrontlineEngineering::active || BaseEmergency() || !UnitHelpers::IsT2BotLab(factory.circuitDef.GetName())) return null;
        for(uint i=0;i<needs.length();++i) {
            Need@ need=needs[i];
            CCircuitDef@ def=ai.GetCircuitDef(need.def);
            if(def is null || !def.IsBuildAllowed() || !factory.circuitDef.CanBuild(def)) continue;
            const int pending=aiFactoryMgr.GetPendingRecruitCount(def)+aiBuilderMgr.GetUnfinishedCount(def);
            if(need.count<=pending) continue;
            if(def.maxThisUnit<def.count+need.count) def.maxThisUnit=def.count+need.count;
            if(def.IsAvailable(ai.frame)) return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,
                Task::Priority::HIGH,def,factory.GetPos(ai.frame),64));
        }
        return null;
    }
}
