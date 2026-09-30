// Staged test instrumentation only; never included by deployed policy.
namespace AlliedProbe {
    bool sent = false, checked = false;
    int airIndex = -1, techIndex = -1, oldSlot = -1, sentFrame = -1;
    AIFloat3 oldPos;
    void Check(bool ok, const string &in label)
    {
        GenericHelpers::LogUtil("[LayoutProbe] " + (ok ? "PASS " : "FAIL ") + label, 1);
    }
    void Message(const string &in text)
    {
        if (text.substr(0, 12) != "layoutprobe|") return;
        array<string>@ p = text.split("|");
        if (p.length() != 5) return;
        CCircuitDef@ d = ai.GetCircuitDef(p[1]);
        AIFloat3 at(parseFloat(p[2]), 0.0f, parseFloat(p[3]));
        const int facing = parseInt(p[4]);
        Check(d !is null && aiTerrainMgr.IsAllyLayoutBlocked(d, at, facing)
            && !aiTerrainMgr.CanReserveBuilding(d, at, facing), "reciprocal exclusion team=" + ai.teamId);
        Check(aiTerrainMgr.ReservePersistentBuilding(d, at, facing) < 0, "foreign reservation refused team=" + ai.teamId);
    }
    void Tick()
    {
        if (!sent && ai.frame >= 1800) {
            string name;
            int facing = 0;
            if (Global::AISettings::Role == AiRole::AIR) {
                for (uint i = 0; i < AirLayout::bays.length(); ++i) {
                    if (AirLayout::bays[i].started || !UnitHelpers::IsT2AircraftPlant(AirLayout::bays[i].defName)) continue;
                    airIndex = int(i); oldSlot = AirLayout::bays[i].slot; oldPos = AirLayout::bays[i].centre;
                    name = AirLayout::bays[i].defName; facing = AirLayout::bays[i].facing; break;
                }
            } else if (Global::AISettings::Role == AiRole::TECH) {
                for (uint i = 0; i < TechFactories::clusters.length(); ++i) {
                    if (!TechFactories::clusters[i].ahead || TechFactories::clusters[i].labRes < 0) continue;
                    techIndex = int(i); oldSlot = TechFactories::clusters[i].labRes; oldPos = TechFactories::clusters[i].pos;
                    name = TechFactories::clusters[i].defName; facing = TechFactories::clusters[i].facing; break;
                }
            }
            if (oldSlot < 0) return;
            sent = true; sentFrame = ai.frame;
            AiSendMessage("layoutprobe|" + name + "|" + oldPos.x + "|" + oldPos.z + "|" + facing);
            CCircuitDef@ wall = ai.GetCircuitDef("armdrag");
            Check(!aiTerrainMgr.CanReserveBuilding(wall, oldPos, facing), "own defense excluded team=" + ai.teamId);
            // Lua supplies a physical blocker, bypassing AI reservations like a human.
            WidgetLink::Send("layoutprobe", "block|" + oldPos.x + "|" + oldPos.z);
        }
        if (sent && !checked && ai.frame >= sentFrame + 300) {
            checked = true;
            Check(!aiTerrainMgr.IsReservationBuildable(oldSlot), "physical blocker observed team=" + ai.teamId);
            if (airIndex >= 0) {
                AirLayout::Bay@ bay = AirLayout::Activate(AirLayout::bays[airIndex]);
                Check(bay !is null && bay.slot != oldSlot && MapHelpers::SqDist(bay.centre, oldPos) > 1.0f,
                    "AIR relocated unused cluster");
                if (AirLayout::bays.length() > 0 && AirLayout::bays[0].started) {
                    const int first = AirLayout::bays[0].slot;
                    AirLayout::Activate(AirLayout::bays[0]);
                    Check(AirLayout::bays[0].slot == first, "AIR active cluster stayed fixed");
                }
            }
            if (techIndex >= 0) {
                TechFactories::Cluster@ c = TechFactories::ReadyCluster(TechFactories::clusters[techIndex]);
                Check(c !is null && c.labRes != oldSlot && MapHelpers::SqDist(c.pos, oldPos) > 1.0f,
                    "TECH relocated unused cluster");
                if (c !is null) {
                    const int id = aiTerrainMgr.NextSlotAny(c.nanoGroup, c.pos);
                    IUnitTask@ task = TechFactories::OrderPinned(null, Task::BuildType::NANO, TechFactories::Nano(), id, "test activation");
                    const int first = c.labRes;
                    TechFactories::Cluster@ locked = TechFactories::ReadyCluster(c);
                    Check(task !is null && locked !is null && locked.started && locked.labRes == first,
                        "TECH claimed cluster stayed fixed");
                    if (task !is null) aiBuilderMgr.AbortTask(task);
                }
            }
            Check(aiTerrainMgr.GetReservationState(oldSlot) < 0, "old reservation released team=" + ai.teamId);
        }
    }
}
