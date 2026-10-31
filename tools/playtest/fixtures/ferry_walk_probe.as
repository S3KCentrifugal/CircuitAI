namespace FerryWalkProbe {
    int phase = 0;
    array<int> workers;
    array<AIFloat3> starts;
    void Check(const string& in name, bool pass) {
        AiLog("[FerryWalk] " + (pass ? "PASS " : "FAIL ") + name);
    }
    void Tick() {
        if (ai.teamId != 0) return;
        if (phase == 0 && ai.frame >= 30 * SECOND) {
            phase = 1;
            array<int>@ ids = ai.GetOwnedUnitIds();
            for (uint i = 0; i < ids.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
                if (u !is null && u.circuitDef.GetName() == "armack") {
                    workers.insertLast(u.id); starts.insertLast(u.GetPos(ai.frame));
                }
            }
            Check("fixture", workers.length() == 3);
            if (workers.length() != 3) return;
            for (uint i = 0; i < workers.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(workers[i]);
                const float distance = i == 0 ? 250.0f : (i == 1 ? 650.0f : 2200.0f);
                AIFloat3 dest = starts[i]; dest.x += distance;
                Team::Ferry::dropOverrides.set("" + u.id, dest);
                if (i == 0) {
                    Check("near_skips_transport", !Team::Ferry::TryCarry(u, 1, dest, true));
                }
                Team::Ferry::queuedCargo.insertLast(u.id);
                Team::Ferry::queuedRecipient.insertLast(1);
                IUnitTask@ logistics = Team::Ferry::GiftTask(u);
                if (logistics !is null && logistics !is u.task) aiBuilderMgr.AssignTask(u, logistics);
                Check("retains_wait_" + i, Team::Ferry::GiftTask(u) is logistics);
            }
            Team::Ferry::GiveQueuedArrivals();
            Check("near_transferred", ai.GetTeamUnit(workers[0]) is null);
        }
        if (phase == 1 && ai.frame >= 40 * SECOND) {
            phase = 2;
            CCircuitUnit@ u = ai.GetTeamUnit(workers[2]);
            Check("walks_before_transport", u !is null && MapHelpers::SqDist(u.GetPos(ai.frame), starts[2]) > 100.0f * 100.0f);
        }
        if (phase == 2 && ai.frame >= 49 * SECOND) {
            phase = 3;
            Check("walking_arrival_transferred", ai.GetTeamUnit(workers[1]) is null);
        }
        if (phase == 3 && ai.frame >= 60 * SECOND) {
            phase = 4;
            Check("pickup_en_route", Team::Ferry::cargoId == workers[2]
                && Team::Ferry::TaskOf(Team::Ferry::Transport()) !is null);
            AiLog("[FerryWalk] complete");
        }
    }
}
