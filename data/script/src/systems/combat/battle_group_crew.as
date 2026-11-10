#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"

// D-514: the repair crew of the battle groups. Policy here, mechanism in the
// native battle group controller (src/circuit/control/group/
// BattleGroupController.cpp, CrewRequest; the formula in
// src/circuit/control/kernel/RepairCrew.h): a group with a "repair" rank needs
// one resurrection bot per per_units screen and support members, and a lab
// that can build an admitted type starts one while the shortfall is not
// covered by bots already assigned, spare or queued and being built. The bots
// serve the group under the rezzer controller.
//
// Called from Factory::AiMakeTask right after the anti-air escorts.
// Cost: one native call per factory decision, O(rank types + factory tasks).
namespace BattleGroupCrew {
    IUnitTask@ Produce(CCircuitUnit@ factory) {
        if(!Global::Military::BattleGroupCrewEnabled || factory is null) return null;
        CCircuitDef@ def=aiMilitaryMgr.BattleGroupCrewRequest(factory);
        if(def is null) return null;
        GenericHelpers::LogUtil("[BattleGroupCrew] "+factory.circuitDef.GetName()+"("+factory.id+") builds "+def.GetName(),1);
        return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,Task::Priority::HIGH,def,factory.GetPos(ai.frame),64.f));
    }
}
