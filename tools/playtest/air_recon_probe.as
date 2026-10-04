// Test-only introspection, no orders or production changes.
namespace AirReconProbe {
    const bool clusters = false;
    bool supplied = false;
    int sampled = -100000;
    dictionary phases;
    void Tick()
    {
        if (ai.teamId != 0 || !AirEconomy::Active()) return;
        if (clusters && !supplied && ai.frame > 15*SECOND) {
            AirLayout::Bay@ candidate=AirLayout::Reserve(ai.GetCircuitDef(UnitHelpers::GetT2AirPlantForSide(Global::AISettings::Side)), Global::Map::StartPos);
            const int selected=candidate is null ? -1 : candidate.cluster;
            if (selected >= 0) {
                supplied=true;
                for (uint i=0;i<AirLayout::bays.length();++i) {
                    AirLayout::Bay@ b=AirLayout::bays[i]; if (b.cluster!=selected) continue;
                    AIFloat3 p=aiTerrainMgr.GetReservationPos(b.slot);
                    WidgetLink::Send("reconprobe", "give|"+b.defName+"|"+p.x+"|"+p.z);
                    for (uint n=0;n<b.nanos.length();++n) {
                        p=aiTerrainMgr.GetReservationPos(b.nanos[n]);
                        WidgetLink::Send("reconprobe", "give|"+UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side)+"|"+p.x+"|"+p.z);
                    }
                }
            }
        }
        array<string>@ ids=AirRecon::waiting.getKeys();
        for (uint i=0;i<ids.length();++i) {
            int slot=-1; AirRecon::waiting.get(ids[i],slot);
            if (slot<0 || slot>=int(AirRecon::slots.length()) || phases.exists(ids[i])) continue;
            const AIFloat3 p=AirRecon::slots[slot];
            WidgetLink::Send("reconprobe", "stage|"+ids[i]+"|"+p.x+"|"+p.z+"|"+AirRecon::spacing);
            phases.set(ids[i],"stage");
        }
        @ids=AirRecon::sweeping.getKeys();
        for (uint i=0;i<ids.length();++i) {
            string old; phases.get(ids[i],old);
            const string phase=AirRecon::surveying.exists(ids[i]) ? "survey" : "sweep";
            if (old==phase) continue;
            AIFloat3 p; AirRecon::destinations.get(ids[i],p);
            WidgetLink::Send("reconprobe", phase+"|"+ids[i]+"|"+p.x+"|"+p.z+"|"+AirRecon::spacing);
            phases.set(ids[i],phase);
        }
        if (ai.frame-sampled<30*SECOND) return;
        sampled=ai.frame;
        if (clusters && supplied) {
            AirEconomy::RefreshSupport();
            int labs=0, nanos=0, complete=0;
            for (uint i=0;i<AirLayout::bays.length() && i<AirEconomy::nanoCount.length();++i) {
                if (AirLayout::bays[i].factoryId<0 || !UnitHelpers::IsT2AircraftPlant(AirLayout::bays[i].defName)) continue;
                ++labs; nanos+=AirEconomy::nanoCount[i]; if(AirEconomy::nanoCount[i]>=20) ++complete;
            }
            GenericHelpers::LogUtil("[AirReconProbe] compound labs="+labs+" nanos="+nanos+" fullySupported="+complete,1);
        }
        CCircuitDef@ d=ai.GetCircuitDef(AirRecon::Name(Global::AISettings::Side));
        GenericHelpers::LogUtil("[AirReconProbe] waiting="+AirRecon::waiting.getSize()+" sweeping="+AirRecon::sweeping.getSize()
            +" surveying="+AirRecon::surveying.getSize()+" productionTarget="+AirRecon::ProductionTarget(d),1);
    }
}
