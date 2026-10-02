// Controlled physical obstruction after a T2 lab has started, not policy code.
namespace AirSupportProbe {
    int bayIndex = -1, blocked = -1, labSlot = -1;
    int originalPins = 0;
    AIFloat3 blockedPos;
    bool checked = false;
    void Tick()
    {
        if (ai.teamId != 0 || Global::AISettings::Role != AiRole::AIR || ai.frame < 600) return;
        if (blocked < 0) {
            for (uint b = 0; b < AirLayout::bays.length(); ++b) {
                AirLayout::Bay@ bay = AirLayout::bays[b];
                if (bay.factoryId < 0 || !UnitHelpers::IsT2AircraftPlant(bay.defName)) continue;
                for (int n = int(bay.nanos.length()) - 1; n >= 0; --n) {
                    if (aiTerrainMgr.GetReservationState(bay.nanos[n]) != 0) continue;
                    bayIndex = int(b); blocked = bay.nanos[n]; labSlot = bay.slot;
                    originalPins = int(bay.nanos.length());
                    const AIFloat3 pos = aiTerrainMgr.GetReservationPos(blocked);
                    blockedPos = pos;
                    WidgetLink::Send("layoutprobe", "block|" + pos.x + "|" + pos.z);
                    GenericHelpers::LogUtil("[AirSupportProbe] requested physical support blocker bay=" + b + " slot=" + blocked, 1);
                    return;
                }
            }
        } else if (!checked && (aiTerrainMgr.GetReservationState(blocked) == 4 || aiTerrainMgr.GetReservationState(blocked) < 0)
            && bayIndex < int(AirEconomy::nanoCount.length()) && AirEconomy::nanoCount[bayIndex] >= 20) {
            checked = true;
            CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
            const bool fixed = AirLayout::bays[bayIndex].slot == labSlot
                && int(AirLayout::bays[bayIndex].nanos.length()) > originalPins
                && !aiTerrainMgr.CanReserveBuilding(nano, blockedPos, AirLayout::bays[bayIndex].facing);
            GenericHelpers::LogUtil("[AirSupportProbe] " + (fixed ? "PASS" : "FAIL")
                + " twenty completed support turrets despite physical blocker; original lab fixed", 1);
        }
    }
}
