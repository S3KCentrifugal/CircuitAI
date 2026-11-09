// Isolated integration observer. Never included by deployed policy.
namespace OrdinaryLayoutProbe {
    int phase = 0;
    void Check(bool ok, const string &in label) {
        GenericHelpers::LogUtil("[OrdinaryLayoutProbe] " + (ok ? "PASS " : "FAIL ") + label, 1);
    }
    void Tick() {
        if (Global::AISettings::Role != AiRole::FRONT && Global::AISettings::Role != AiRole::TACTICAL) return;
        if (phase >= 2 || ai.frame < (phase == 0 ? 1800 : 5400)) return;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef.IsMobile()) continue;
            const string name = u.circuitDef.GetName();
            // Starter factories are non-resource sites and have substantial footprints.
            if (name != "corlab" && name != "armlab" && name != "leglab"
                && name != "corvp" && name != "armvp" && name != "legvp"
                && name != "corhp" && name != "armhp" && name != "leghp") continue;
            const string role = Global::AISettings::Role == AiRole::FRONT ? "FRONT" : "TACTICAL";
            Check(!aiTerrainMgr.IsLayoutEnabled(), role + " native placement retained");
            const AIFloat3 pos = u.GetPos(ai.frame);
            AiSendMessage("ordinaryprobe|" + role + "|" + phase + "|" + pos.x + "|" + pos.z);
            ++phase;
            return;
        }
    }
    void Message(const string &in text) {
        if (text.substr(0, 14) != "ordinaryprobe|") return;
        array<string>@ p = text.split("|");
        if (p.length() != 5) return;
        CCircuitDef@ wall = ai.GetCircuitDef("armdrag");
        const AIFloat3 pos(parseFloat(p[3]), 0.0f, parseFloat(p[4]));
        Check(wall !is null && aiTerrainMgr.IsAllyLayoutBlocked(wall, pos, 0),
            p[1] + " shared footprint phase=" + p[2]);
    }
}
