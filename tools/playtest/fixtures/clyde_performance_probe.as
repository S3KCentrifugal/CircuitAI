namespace ClydePerfProbe {
    bool done = false, cancelNext = false;
    int samples = 0;
    void Check(const string& in key, bool pass) {
        AiLog("[ClydePerfProbe] " + (pass ? "PASS " : "FAIL ") + key);
    }
    bool OnAdded(IUnitTask@ task) {
        if (!cancelNext) return false;
        cancelNext = false;
        int reason = 0;
        IUnitTask@ nested = aiBuilderMgr.EnqueueReserved(TaskB::Common(Task::BuildType::ENERGY,
            Task::Priority::NORMAL, ai.GetCircuitDef("armsolar"), AIFloat3(), 0.0f, true, SECOND), 0, reason);
        Check("nested-rejection", nested is null && reason == 1);
        aiBuilderMgr.AbortTask(task);
        return true;
    }
    void Tick() {
        if (done || ai.frame < 10 * SECOND) return;
        array<Id>@ all = ai.GetOwnedUnitIds();
        bool equal = true;
        for (uint i = 0; i < all.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(all[i]);
            if (u is null) continue;
            array<Id> indexed, oracle;
            ai.GetOwnedUnitIdsForDef(u.circuitDef, indexed);
            for (uint j = 0; j < all.length(); ++j) {
                CCircuitUnit@ other = ai.GetTeamUnit(all[j]);
                if (other !is null && other.circuitDef is u.circuitDef) oracle.insertLast(all[j]);
            }
            if (indexed.length() != oracle.length()) equal = false;
            else for (uint j = 0; j < indexed.length(); ++j) if (indexed[j] != oracle[j]) equal = false;
        }
        Check("owned-index", equal);
        ++samples;
        if (samples < 3) return;
        done = true;
        CCircuitUnit@ commander = Builder::GetCommander();
        CCircuitDef@ radar = ai.GetCircuitDef("armrad");
        if (commander is null || radar is null) { Check("fixture", false); return; }
        AIFloat3 origin = commander.GetPos(ai.frame), site;
        bool found = false;
        for (int ring = 2; ring < 14 && !found; ++ring) {
            for (int k = 0; k < 8 && !found; ++k) {
                site = aiTerrainMgr.CanonicalBuildPosition(radar,
                    AIFloat3(origin.x + cos(k * 0.7854f) * ring * 64, 0, origin.z + sin(k * 0.7854f) * ring * 64), 0);
                found = aiTerrainMgr.CanReserveBuilding(radar, site, 0);
            }
        }
        Check("fixture", found && radar.IsBuildAllowed());
        if (!found) return;
        const int before = aiTerrainMgr.GetReservationCount(radar);
        int reason = -1;
        IUnitTask@ task = aiBuilderMgr.EnqueueReserved(TaskB::Common(Task::BuildType::RADAR,
            Task::Priority::NORMAL, radar, site, 0.0f, true, 120 * SECOND), 0, reason);
        Check("commit", task !is null && reason == 0);
        if (task !is null) aiBuilderMgr.AbortTask(task);
        Check("cancel-release", aiTerrainMgr.GetReservationCount(radar) == before);
        cancelNext = true;
        @task = aiBuilderMgr.EnqueueReserved(TaskB::Common(Task::BuildType::RADAR,
            Task::Priority::NORMAL, radar, site, 0.0f, true, 120 * SECOND), 0, reason);
        Check("callback-rollback", !cancelNext && task is null && reason == 4
            && aiTerrainMgr.GetReservationCount(radar) == before);
        AiLog("[ClydePerfProbe] complete");
    }
}
