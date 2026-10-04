// Isolated fixture only; stage explicitly. No production include.
namespace AirWorkforceProbe {
    bool adopted = false, supplied = false;
    bool legacy = false, blocked = false, relocated = false, cancelled = false;
    int blockedSlot = -1, guardFrame = -1;
    array<int> guarded;
    bool guardsChecked = false;
    int playerWorker = -1, playerFrame = -1;
    bool playerChecked = false;
    void Tick() {
        if (ai.teamId != 0 || !AirEconomy::Active()) return;
        if (!adopted && ai.frame >= 20 * SECOND && AirEcoLayout::modules.length() > 0) {
            adopted = true;
            const int first = AirEcoLayout::modules[0].slots[0];
            const uint support = AirEcoLayout::modules[0].support.length();
            AirEcoLayout::Init();
            const bool same = support == uint(Global::RoleSettings::Air::EcoSupportSlots)
                && AirEcoLayout::modules.length() > 0 && AirEcoLayout::modules[0].slots[0] == first
                && AirEcoLayout::modules[0].support.length() == support;
            GenericHelpers::LogUtil("[WorkforceProbe] " + (same ? "PASS" : "FAIL") + " named-state adoption support=" + support, 1);
        }
        if (!supplied && ai.frame >= 120 * SECOND) {
            supplied = true;
            int count = 0;
            for (uint i = 0; i < AirLayout::bays.length(); ++i) {
                AirLayout::Bay@ bay = AirLayout::bays[i];
                if (!UnitHelpers::IsT2AircraftPlant(bay.defName) || bay.slot < 0) continue;
                if (count >= (AirWorkforceFixtureSix ? 6 : 1)) break;
                const AIFloat3 pos = aiTerrainMgr.GetReservationPos(bay.slot);
                WidgetLink::Send("workforceprobe", "give|" + bay.defName + "|" + pos.x + "|" + pos.z);
                ++count;
            }
            GenericHelpers::LogUtil("[WorkforceProbe] requested planned T2 labs=" + count, 1);
        }
        if (AirWorkforceFixtureLifecycle) Lifecycle();
        if (ai.frame % (10 * SECOND) < SECOND) {
            GenericHelpers::LogUtil("[WorkforceProbe] shortage=" + int(AirWorkforce::shortage)
                + " room=" + int(AirWorkforce::Room(false)) + "/" + int(AirWorkforce::Room(true))
                + " outstanding=" + int(AirWorkforce::committedM) + "/" + int(AirWorkforce::committedE)
                + " mobile=" + int(AirWorkforce::mobile) + " ecoStatic=" + int(AirWorkforce::economicStatic), 1);
        }
    }
    void Lifecycle() {
        if (playerFrame < 0 && ai.frame >= 330 * SECOND) {
            array<Id>@ ids = ai.GetOwnedUnitIds();
            for (uint i = 0; i < ids.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
                if (u is null || !UnitHelpers::IsAirConstructor(u.circuitDef) || u.GetBuildProgress() < 1) continue;
                if (ai.UnitControl(u, false)) { playerWorker = u.id; playerFrame = ai.frame; break; }
            }
        }
        if (!playerChecked && playerFrame >= 0 && ai.frame >= playerFrame + 10 * SECOND) {
            playerChecked = true;
            CCircuitUnit@ u = ai.GetTeamUnit(playerWorker);
            const bool held = u !is null && u.task !is null && u.task.GetType() == int(Task::Type::PLAYER)
                && !AirWorkforce::IdleWorker(u);
            GenericHelpers::LogUtil("[WorkforceProbe] " + (held ? "PASS" : "FAIL") + " player worker unavailable and ownership preserved", 1);
            if (u !is null) ai.UnitControl(u, true);
        }
        if (!legacy && ai.frame >= 30 * SECOND && AirEcoLayout::modules.length() >= 2) {
            legacy = true;
            AirEcoLayout::Module@ m = AirEcoLayout::modules[1];
            const int original = m.slots[0], zone = m.zone;
            for (uint i = 0; i < m.support.length(); ++i) aiTerrainMgr.ReleasePersistentBuilding(m.support[i]);
            aiTerrainMgr.SetLayoutInt(m.key + ".schema", 1);
            aiTerrainMgr.SetLayoutInt(m.key + ".supportCount", 0);
            AirEcoLayout::Init();
            @m = AirEcoLayout::modules[1];
            GenericHelpers::LogUtil("[WorkforceProbe] " + (m.slots.length() == 9 && m.slots[0] == original
                && m.zone == zone && m.support.length() == 0 ? "PASS" : "FAIL") + " old nine-slot adoption", 1);
        }
        if (!blocked && ai.frame >= 40 * SECOND && AirEcoLayout::modules.length() > 0) {
            AirEcoLayout::Module@ m = AirEcoLayout::modules[0];
            if (!m.started && m.support.length() > 0) {
                blocked = true; blockedSlot = m.slots[0];
                const AIFloat3 pos = aiTerrainMgr.GetReservationPos(m.support[0]);
                WidgetLink::Send("workforceprobe", "give|armdrag|" + pos.x + "|" + pos.z);
            }
        }
        if (blocked && !relocated && ai.frame >= 50 * SECOND) {
            AirEcoLayout::Module@ m = AirEcoLayout::Activate(AirEcoLayout::modules[0]);
            if (m !is null && m.slots.length() > 0 && m.slots[0] != blockedSlot) {
                relocated = true;
                GenericHelpers::LogUtil("[WorkforceProbe] PASS blocked support relocates unused module", 1);
            }
        }
        if (!cancelled && ai.frame >= 180 * SECOND) {
            for (uint i = 0; i < AirBuild::projects.length(); ++i) {
                IBuilderTask@ t = cast<IBuilderTask>(AirBuild::projects[i]);
                if (t is null || t.IsDead() || t.target !is null || t.GetBuildType() != int(Task::BuildType::NANO)) continue;
                AirBuild::CancelUnstarted(t); cancelled = true;
                GenericHelpers::LogUtil("[WorkforceProbe] PASS cancelled unframed support", 1);
                break;
            }
        }
        if (guardFrame < 0 && ai.frame >= 240 * SECOND && Factory::primaryT1AirPlant !is null) {
            array<Id>@ ids = ai.GetOwnedUnitIds();
            for (int tier = 1; tier <= 2; ++tier) for (uint i = 0; i < ids.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
                if (u is null || !UnitHelpers::IsAirConstructor(u.circuitDef)
                    || u.GetBuildProgress() < 1 || UnitHelpers::GetConstructorTier(u.circuitDef) != tier) continue;
                IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Guard(Task::Priority::HIGH, Factory::primaryT1AirPlant, false, 60 * SECOND));
                aiBuilderMgr.AssignTask(u, t); guarded.insertLast(u.id); break;
            }
            if (guarded.length() == 2) guardFrame = ai.frame;
        }
        if (!guardsChecked && guardFrame >= 0 && ai.frame >= guardFrame + 5 * SECOND) {
            guardsChecked = true; bool clean = true;
            for (uint i = 0; i < guarded.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(guarded[i]);
                IBuilderTask@ t = u is null ? null : cast<IBuilderTask>(u.task);
                if (u is null || (t !is null && t.GetBuildType() == int(Task::BuildType::GUARD))) clean = false;
            }
            GenericHelpers::LogUtil("[WorkforceProbe] " + (clean ? "PASS" : "FAIL") + " both tiers released idle guards", 1);
        }
    }
}
