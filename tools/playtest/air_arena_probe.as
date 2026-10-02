// Read-only combat observer, appended only to staged experimental main.as.
namespace AirArenaProbe {
    int serial = 0;
    bool active = false, t1 = false, responding = false;
    CAirWaveTask@ observed = null;
    void Tick()
    {
        if (ai.teamId > 1 || Global::AISettings::Role != AiRole::AIR) return;
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
    }
}
