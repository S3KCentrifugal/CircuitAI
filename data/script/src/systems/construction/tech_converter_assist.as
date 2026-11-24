// TECH converter assist and pacing (owner 2026-11-23). Played (Smolders headless, 6 games): TECH's energy
// bank was full from ~18:00 and 50-70% of its energy went to allies by 22:00, with 0-4 converters, while
// up to 61 T1 air constructors (D-103) idled: the converter picker has nothing for a T1 builder past +18
// metal (advanced converters need a T2 builder), so they only ever helped through assist.any's short reach.
//
// Assist (rule air.convert.assist): while energy floats, an air constructor that holds no dedicated role
// helps the nearest unfinished advanced converter of ours within AirConverterAssistRadius, at most
// AirConverterAssistPerFrame per frame, on a short repair (the timeout brings it back to ask).
//
// Pacing (ConverterHandoffProgress > 0): TECH's converter worker (the D-489 seat, the D-107 converter
// aircraft, the growth converter worker or the defence crew) leaves a converter frame that is at least
// that far along and has ConverterHandoffMinAssist air helpers, and lays down the next one, so one T2
// constructor drops frames and the air constructors finish them. Off (0): one frame at a time, as before.
// Cost: O(frames we track, a handful) per ask; one FindUnfinishedNear per assisting ask.
namespace TechConverterAssist {
    array<int> frames;     // converter frames with air helpers sent to them
    array<int> helpers;    // ... how many, counted when sent (pruned when the frame is done or gone)
    array<int> sentFrame;  // ... last frame one was sent (a count older than the assist timeout is stale)
    int lastLog = -100000;

    CCircuitDef@ Def() { return ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side)); }
    bool On() { return Global::AISettings::Role == AiRole::TECH && Global::RoleSettings::Tech::AirConverterAssist; }

    void Prune() {
        const int stale = (Global::RoleSettings::Tech::AirConverterAssistSeconds + 5) * SECOND;
        for (int i = int(frames.length()) - 1; i >= 0; --i) {
            CCircuitUnit@ f = ai.GetTeamUnit(frames[i]);
            if (f is null || f.GetBuildProgress() >= 1.0f || ai.frame - sentFrame[i] > stale) {
                frames.removeAt(i); helpers.removeAt(i); sentFrame.removeAt(i);
            }
        }
    }
    int Helpers(int frameId) {
        const int i = frames.find(frameId);
        return i < 0 ? 0 : helpers[i];
    }
    void Count(int frameId) {
        int i = frames.find(frameId);
        if (i < 0) { frames.insertLast(frameId); helpers.insertLast(0); sentFrame.insertLast(ai.frame); i = int(frames.length()) - 1; }
        helpers[i] = helpers[i] + 1;
        sentFrame[i] = ai.frame;
    }
    // The converter frame a builder is repairing or building, if any
    CCircuitUnit@ OnConverter(CCircuitUnit@ u, CCircuitDef@ d) {
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        if (cur is null || cur.IsDead() || cur.target is null || d is null) return null;
        if (cur.target.circuitDef is null || cur.target.circuitDef.id != d.id || cur.target.GetBuildProgress() >= 1.0f) return null;
        return cur.target;
    }

    // Rule air.convert.assist (tech_rules.as)
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || !UnitHelpers::IsAirConstructor(u.circuitDef)) return null;
        if (TechBuild::IsDedicatedAirCon(u) || TechAirFoundry::Owns(u.id)) return null;
        if (!TechChain::EnergyBankFloats() || aiEconomyMgr.isEnergyStalling) return null;
        CCircuitDef@ d = Def();
        if (d is null) return null;
        if (OnConverter(u, d) !is null) return u.task;
        Prune();
        CCircuitUnit@ f = aiBuilderMgr.FindUnfinishedNear(u.GetPos(ai.frame), Global::RoleSettings::Tech::AirConverterAssistRadius, d);
        if (f is null || Helpers(f.id) >= Global::RoleSettings::Tech::AirConverterAssistPerFrame) return null;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, f, Global::RoleSettings::Tech::AirConverterAssistSeconds * SECOND));
        if (t is null) return null;
        Count(f.id);
        if (ai.frame - lastLog >= 30 * SECOND) {
            lastLog = ai.frame;
            GenericHelpers::LogUtil("[TECH][ConvAssist] " + u.circuitDef.GetName() + " " + u.id + " assists converter frame " + f.id
                + " (" + int(f.GetBuildProgress() * 100) + "%, helpers " + Helpers(f.id) + ")", 1);
        }
        return t;
    }

    bool ConverterWorker(CCircuitUnit@ u) {
        return u !is null && (TechSurplusSeats::ConverterWorker(u) || TechDefenceCrew::Owns(u.id));
    }
    // manager/builder.as AiMakeTask (TECH), before keep.current: the converter worker hands a far-along,
    // helped frame to the air constructors and lays down the next one
    IUnitTask@ Pace(CCircuitUnit@ u) {
        if (!On() || Global::RoleSettings::Tech::ConverterHandoffProgress <= 0.0f || u is null || u.circuitDef is null) return null;
        if (!ConverterWorker(u) || !TechChain::EnergyBankFloats() || aiEconomyMgr.isEnergyStalling) return null;
        CCircuitDef@ d = Def();
        CCircuitUnit@ f = OnConverter(u, d);
        if (f is null) return null;
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        if (cur is null || Task::BuildType(cur.GetBuildType()) != Task::BuildType::CONVERT) return null;
        Prune();
        if (f.GetBuildProgress() < Global::RoleSettings::Tech::ConverterHandoffProgress
            || Helpers(f.id) < Global::RoleSettings::Tech::ConverterHandoffMinAssist) return null;
        const int id = u.id;
        const int fid = f.id;
        const int pct = int(f.GetBuildProgress() * 100);
        aiBuilderMgr.AbortTask(u.task);
        @u = ai.GetTeamUnit(id);
        if (u is null) return null;
        IUnitTask@ t = TechBuild::BuildByLayout(u, d.GetName(), Task::BuildType::CONVERT);
        GenericHelpers::LogUtil("[TECH][ConvAssist] converter worker " + id + " hands frame " + fid + " (" + pct + "%, "
            + Helpers(fid) + " air helpers) on and " + (t is null ? "finds no next site" : "lays down the next"), 1);
        return t;
    }
}
