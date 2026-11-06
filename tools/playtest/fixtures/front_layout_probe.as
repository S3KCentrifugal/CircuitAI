// Supplied placement fixture only. Leaves production sources untouched.
namespace FrontLayoutProbe {
    IUnitTask@ construction;
    bool started=false;
    IUnitTask@ Make(CCircuitUnit@ unit) {
        if(ai.teamId!=0 || !unit.circuitDef.IsRoleAny(Unit::Role::COMM.mask)
            || !Global::Map::HasStart) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        if(construction !is null && !construction.IsDead()) return construction;
        if(started) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        started=true;
        const string side=Global::AISettings::Side;
        const bool tactical=Global::AISettings::Role==AiRole::TACTICAL;
        const string name=tactical?UnitHelpers::GetT1HoverPlantForSide(side):UnitHelpers::GetT1BotLabForSide(side);
        // This fixture disables the normal FRONT economy hook (and hence its
        // lane publisher). Supply a real terrain route, not an unvalidated line.
        array<AIFloat3>@ lane=aiBattle.GetTerrainRoute(Global::Map::StartPos,LayoutHelpers::TerrainCentre(),tactical?Lanes::HOVER:Lanes::BOT,1.f,1.f,0.f,0.f);
        if(lane !is null && lane.length()>1) aiTerrainMgr.SetFactoryLane(ai.teamId,lane);
        if(tactical) TacticalLayout::Plan(name,unit.GetPos(ai.frame));
        else FrontLayout::Plan(name,side);
        CCircuitDef@ def=ai.GetCircuitDef(name);
        GenericHelpers::LogUtil("[FrontLayoutTest] supplied immediate factory intent with three-second preference",1);
        @construction=aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::HIGH,def,unit.GetPos(ai.frame),null,0.f));
        return construction;
    }
}
