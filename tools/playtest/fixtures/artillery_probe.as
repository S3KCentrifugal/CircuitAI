// Stage only: include from a test profile main.as and call Tick from AiUpdate.
#include "src/task.as"
namespace ArtilleryProbe {
    bool Aim(const string& in data) {
        array<string>@ parts = data.split("|");
        if (parts.length() != 2 || parts[0] != "artillery-aim") return false;
        CCircuitUnit@ unit = ai.GetTeamUnit(int(parseInt(parts[1])));
        IFighterTask@ fighter = unit is null ? null : cast<IFighterTask>(unit.task);
        CSuperTask@ task = fighter is null ? null : cast<CSuperTask>(fighter);
        if (task is null) AiLog("[ArtilleryProbe] FAIL no cannon task");
        else {
            task.SetTargetPos(AIFloat3(2000,0,6900));
            AiLog("[ArtilleryProbe] aiming " + unit.circuitDef.GetName());
        }
        return true;
    }
    bool done = false;
    void Tick() {
        if (done || ai.frame < 1200) return;
        done = true;
        int passed = 0, present = 0;
        for (uint i = 0; i < ArtilleryPolicy::ForbiddenT1.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(ArtilleryPolicy::ForbiddenT1[i]);
            if (d is null) continue;
            present++;
            const int oldLimit = d.maxThisUnit;
            d.maxThisUnit = 1000;
            IUnitTask@ task = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE,
                Task::Priority::NORMAL, d, AIFloat3(1500,0,9500), 16, true, 900));
            if (!d.IsBuildAllowed() && !d.IsAvailable(ai.frame) && task is null) passed++;
            d.maxThisUnit = oldLimit;
        }
        AiLog("[ArtilleryProbe] " + (passed == present && present >= 2 ? "PASS" : "FAIL") + " veto " + passed + " of " + present + " present definitions");
        const array<string> allowed = {"armamb", "cortoast", "legacluster", "armbrtha", "corint", "leglrpc", "armvulc", "corbuzz", "legstarfall"};
        for (uint i = 0; i < allowed.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(allowed[i]);
            if (d !is null && !d.IsBuildAllowed()) AiLog("[ArtilleryProbe] FAIL permitted artillery " + allowed[i]);
        }
    }
}
