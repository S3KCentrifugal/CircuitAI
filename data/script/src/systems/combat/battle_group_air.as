#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"

// D-509: anti-air escorts for the battle groups. Policy here, mechanism in the
// native battle group controller (src/circuit/control/group/
// BattleGroupController.cpp, AirRequest; the formula in
// src/circuit/control/kernel/AirDefence.h): when armed enemy air is near a
// group with an "air" rank, the group needs enough escorts to shoot it down
// within air_kill_seconds, and a lab that can build an admitted type (the T1
// anti-air bot of its faction) starts one while the shortfall is not covered
// by escorts already assigned, spare or queued and being built. The escorts
// ride behind the screen under the escort controller.
//
// Called from Factory::AiMakeTask before the optional producers (spam and the
// role's own handler), after obligations (ferries, donations, recovery).
// Cost: one native call per factory decision, O(rank types + factory tasks).
namespace BattleGroupAir {
    IUnitTask@ Produce(CCircuitUnit@ factory) {
        if(!Global::Military::BattleGroupAirEnabled || factory is null) return null;
        CCircuitDef@ def=aiMilitaryMgr.BattleGroupAirRequest(factory);
        if(def is null) return null;
        GenericHelpers::LogUtil("[BattleGroupAir] "+factory.circuitDef.GetName()+"("+factory.id+") builds "+def.GetName(),1);
        return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER,Task::Priority::HIGH,def,factory.GetPos(ai.frame),64.f));
    }
}
