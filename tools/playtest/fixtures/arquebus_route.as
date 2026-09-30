// Test-only: hard profile main includes this file. No production assignments changed.
#include "src/task.as"
namespace Military {
    IUnitTask@ AiMakeTask(CCircuitUnit@ u) {
        if (u.circuitDef.GetName() != "legsrail") return aiMilitaryMgr.DefaultMakeTask(u);
        const AIFloat3 p = u.GetPos(ai.frame);
        const float direction = p.z > float(AiTerrainHeight()) * 0.5f ? -1.0f : 1.0f;
        array<AIFloat3> route = {p, AIFloat3(p.x,p.y,p.z + direction*600.0f),
            AIFloat3(p.x,p.y,p.z + direction*1600.0f),
            AIFloat3(p.x,p.y,p.z + direction*2200.0f)};
        IUnitTask@ task = aiMilitaryMgr.Enqueue(TaskF::Route());
        IFighterTask@ fighter = cast<IFighterTask>(task);
        CRouteTask@ lane = fighter is null ? null : cast<CRouteTask>(fighter);
        if (lane is null) return null;
        lane.SetTraversal(true,48.0f,true);
        lane.SetRoute(route);
        AiLog("[Arquebus] route assigned team=" + ai.teamId + " unit=" + u.id);
        return task;
    }
}
