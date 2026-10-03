// Read-only combat observer, appended only to staged experimental main.as.
namespace AirArenaProbe {
    int serial = 0;
    int lastCommitment = -100000;
    bool rosterReported = false;
    bool active = false, t1 = false, responding = false;
    CAirWaveTask@ observed = null;
    void Tick()
    {
        if (ai.teamId > 1 || Global::AISettings::Role != AiRole::AIR) return;
        if (ai.teamId == 0 && !rosterReported && AirOperations::rosterReady) {
            rosterReported = true;
            GenericHelpers::LogUtil("[AirArenaProbe] T3 roster=" + AirOperations::groundHeavyDefs.length()
                + " shiva=" + AirOperations::groundHeavyDefs.find("corshiva")
                + " telchine=" + AirOperations::groundHeavyDefs.find("legamph")
                + " home=" + int(Global::Map::StartPos.x) + "," + int(Global::Map::StartPos.z), 1);
        }
        if (ai.teamId == 1) {
            if (AirScreen::responding != responding) {
                responding = AirScreen::responding;
                WidgetLink::Send("arena", "response|" + ai.frame + "|" + (responding ? "1" : "0"));
            }
            return;
        }
        CAirWaveTask@ wave = cast<CAirWaveTask>(AirWaves::waveTask);
        const bool second = wave !is null && !wave.IsDead();
        // Evaluation can launch the next sortie in the same role update.
        // Retain the observed task identity instead of testing the new task.
        if (active && observed !is null && observed.IsDead()) {
            const bool done = t1 ? AirRaids::wave !is observed
                : AirWaves::lastWaveEvaluated || (AirWaves::waveTask !is null && AirWaves::waveTask !is observed);
            if (done) {
                WidgetLink::Send("arena", "end|" + serial + "|" + ai.frame + "|" + AirWaves::learnedResistance);
                active = false; @observed = null;
            }
        }
        if (!active && (second || (AirRaids::wave !is null && !AirRaids::wave.IsDead()))) {
            t1 = !second;
            if (t1) @wave = AirRaids::wave;
            const dictionary@ cohort = t1 ? @AirRaids::cohort : @AirWaves::evaluationCohort;
            array<string>@ ids = cohort.getKeys();
            if (ids.length() == 0) return;
            ids.sortAsc();
            string members;
            for (uint i = 0; i < ids.length(); ++i) members += (i == 0 ? "" : ",") + ids[i];
            active = true; ++serial;
            @observed = wave;
            WidgetLink::Send("arena", "launch|" + serial + "|" + ai.frame + "|" + wave.GetStrikeTargetId()
                + "|" + AirWaves::learnedResistance + "|" + members);
        }
        if (active && observed !is null && !observed.IsDead() && ai.frame-lastCommitment >= 10*SECOND) {
            lastCommitment = ai.frame;
            int live = 0, owned = 0;
            array<string>@ escorts = AirOperations::escorts.getKeys();
            for (uint i = 0; i < escorts.length(); ++i) {
                IUnitTask@ owner;
                CCircuitUnit@ unit = ai.GetTeamUnit(parseInt(escorts[i]));
                if (unit is null || !AirOperations::escorts.get(escorts[i], @owner) || owner !is observed) continue;
                ++live;
                if (unit.task is owner) ++owned;
            }
            WidgetLink::Send("arena", "commitment|" + serial + "|" + live + "|" + owned
                + "|" + AirScreen::IntrusionCost() + "|" + observed.GetState());
        }
    }
}
