// Supplied income snapshots, real cross-AI donation request/ack and admission hooks.
namespace FrontTechGateProbe {
    int step = 0;
    void Check(const string& in name, bool pass) {
        AiLog("[FrontTechGate] " + (pass ? "PASS " : "FAIL ") + name);
    }
    void Income(float value) {
        Economy::_metalMin10s.frames.resize(0);
        Economy::_metalMin10s.values.resize(0);
        Economy::_metalMin10s.head = 0;
        Economy::_metalMin10s.push(ai.frame, value, 10 * SECOND);
    }
    void Tick() {
        Global::AISettings::Role = ai.teamId == 0 ? AiRole::FRONT : AiRole::TECH;
        if (ai.teamId != 0 || ai.frame < 20 * SECOND || step == 2) return;
        if (step == 0) {
            Income(20);
            Check("no_plan_default", Team::Donation::FrontFactoryAllowed());
            Team::Roster::Entry@ donor = Team::Roster::Entry();
            donor.teamId = 1; donor.role = AiRole::TECH;
            Team::Roster::entries.set("1", @donor);
            Check("request_sent", Team::Donation::RequestConstructor("front gate fixture"));
            step = 1;
            return;
        }
        if (!Team::Donation::HasConstructorPlan()) return;
        Income(39.99f);
        Check("acknowledged_plan_blocks", !Team::Donation::FrontFactoryAllowed());
        Check("bot_fast_track_blocked", Builder::EnqueueT2BotLabIfNeeded("armada", Global::Map::StartPos, 64, SECOND) is null);
        Check("vehicle_fast_track_blocked", Builder::EnqueueT2VehiclePlant("armada", Global::Map::StartPos, 64, SECOND) is null);
        bool assist = true;
        Check("native_switch_blocked", !RoleFront::Front_AiIsSwitchAllowed(ai.GetCircuitDef("armalab"), 1.e9f, 1, 1.e9f, assist) && !assist);
        Income(40);
        Check("exact_40_admitted", Team::Donation::FrontFactoryAllowed()
            && RoleFront::Front_AiIsSwitchAllowed(ai.GetCircuitDef("armalab"), 1.e9f, 1, 1.e9f, assist));
        Team::Donation::HandleMessage("barbdon|sent|123", 1);
        Team::Donation::constructorPlanned = false;
        Team::Donation::planLoaded = false; // reload the same persisted state used by save/load
        Income(20);
        Check("permanent_after_sent_and_reload", !Team::Donation::FrontFactoryAllowed());
        Global::AISettings::Role = AiRole::SUPPORT;
        Check("other_role_unchanged", Team::Donation::FrontFactoryAllowed());
        Global::AISettings::Role = AiRole::FRONT;
        step = 2;
        AiLog("[FrontTechGate] complete");
    }
}
