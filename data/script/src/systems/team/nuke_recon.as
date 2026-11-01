// TECH's first completed silo requests one allied AIR reconnaissance package.
// The external AI ABI has a stockpile count but no fractional build progress.
// Use the owner's nominal half-stockpile timer from completion: 60s Armada,
// 90s Cortex/Legion (BAR stockpiletime=120/180/180, firing reloadtime=30).
// Resource starvation can delay the actual missile beyond this nominal point.
// The request carries the silo's latest aim (owner 2026-10-28) and AIR flies it
// at once, T1 scouts only before its T2 plant (AirScoutSweep::Urgent).
namespace NukeRecon {
    int siloId=-1, completed=-1, checked=-SECOND;
    bool sent=false;
    void Finished(CCircuitUnit@ u) {
        if (sent || (siloId>=0 && ai.GetTeamUnit(siloId) !is null)
            || Global::AISettings::Role!=AiRole::TECH || u is null || u.GetBuildProgress()<1.0f) return;
        const string name=u.circuitDef.GetName();
        if (name!="armsilo" && name!="corsilo" && name!="legsilo") return;
        siloId=u.id; completed=ai.frame;
    }
    void Tick() {
        if (sent || Global::AISettings::Role!=AiRole::TECH || ai.frame-checked<SECOND) return;
        checked=ai.frame;
        CCircuitUnit@ silo=ai.GetTeamUnit(siloId);
        if (silo is null) { siloId=-1; completed=-1; return; }
        const int halfSeconds=silo.circuitDef.GetName()=="armsilo" ? 60 : 90;
        if (ai.frame-completed<halfSeconds*SECOND && silo.GetStockpile()==0) return;
        array<Team::Roster::Entry@>@ allies=Team::Roster::WithRole(AiRole::AIR);
        int provider=-1;
        for(uint i=0;i<allies.length();++i) if(provider<0 || allies[i].teamId<provider) provider=allies[i].teamId;
        if (provider<0) return; // late AIR announcements retry, no broadcast storm
        const AIFloat3 at=aiMilitaryMgr.GetNuclearAim();
        const string where=(at.x<0.0f) ? "" : "|"+int(at.x)+"|"+int(at.z)+"|"+int(aiMilitaryMgr.GetNuclearAimRadius());
        AiSendMessage("nukerecon|first"+where,provider);
        sent=true;
        GenericHelpers::LogUtil("[TECH][NukeRecon] nominal half stockpile silo="+siloId+" AIR="+provider+" seconds="+halfSeconds
            +(at.x<0.0f ? " aim=none" : " aim=("+int(at.x)+","+int(at.z)+")"),1);
    }
    bool Handle(const string &in msg,int fromTeamId) {
        if (msg.findFirst("nukerecon|launch|")==0 || msg.findFirst("nukerecon|scout|")==0) {
            // nukerecon|launch|x|z|spread: an ally's nuke went there (the owed rush package's target);
            // nukerecon|scout|x|z|spread: 10 T1 + 3 radar there now, ungated (NukeLaunchRecon)
            array<string>@ parts=msg.split("|");
            if (parts.length()<5 || !AirEconomy::Active()) return true;
            if (fromTeamId!=ai.teamId && Team::Roster::Get(fromTeamId) is null) return true;
            const AIFloat3 at(parseFloat(parts[2]),0,parseFloat(parts[3]));
            const float spread=parseFloat(parts[4]);
            AirScoutSweep::Nuked(at,spread);
            if (parts[1]=="scout") {
                AirScoutSweep::Request(Global::RoleSettings::Air::ScoutSweepT1Count,Global::RoleSettings::Air::NukeScoutRadarCount,at,spread,true);
                GenericHelpers::LogUtil("[AIR][ScoutSweep] nuked-spot request from "+fromTeamId+" at=("+int(at.x)+","+int(at.z)+") spread="+int(spread),1);
            }
            return true;
        }
        if (msg.findFirst("nukerecon|first")!=0) return false;
        Team::Roster::Entry@ sender=Team::Roster::Get(fromTeamId);
        if (sender !is null && sender.role==AiRole::TECH && AirEconomy::Active()) {
            // nukerecon|first[|x|z|spread]: without an aim the package sweeps the lanes
            array<string>@ parts=msg.split("|");
            AIFloat3 at(-1,0,-1);
            float spread=0.0f;
            if (parts.length()>=5) { at=AIFloat3(parseFloat(parts[2]),0,parseFloat(parts[3])); spread=parseFloat(parts[4]); }
            AirScoutSweep::Urgent(at,spread);
            GenericHelpers::LogUtil("[AIR][ScoutSweep] nuke request TECH="+fromTeamId+" at=("+int(at.x)+","+int(at.z)+") spread="+int(spread),1);
        }
        return true;
    }
}

// Scouting where our nukes land (owner 2026-10-31). Every launch tells the
// allied AIR where it went (the owed rush package flies there); with fewer
// silos than an overnuke needs, every NukeLaunchRecon::Every-th launch also asks
// AIR for 10 T1 + 3 radar at that spot, ungated. With no AIR, TECH builds them
// (LolCannonRecon::Send). Any role that owns silos runs it.
namespace NukeLaunchRecon {
    const int Every = 3, OvernukeSilos = 3;  // behaviour.json nuclear.overnuke_silos default
    int seen = 0, checked = -SECOND;
    int Silos() {
        int count = 0;
        const array<string> names = {"armsilo", "corsilo", "legsilo"};
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(names[i]);
            if (def !is null) count += def.count;
        }
        return count;
    }
    void Tick() {
        if (ai.frame - checked < SECOND) return;
        checked = ai.frame;
        const int launches = aiMilitaryMgr.GetNuclearLaunches();
        if (launches <= seen) return;
        seen = launches;
        const AIFloat3 at = aiMilitaryMgr.GetNuclearLaunchPos();
        if (at.x < 0.0f) return;
        const float spread = aiMilitaryMgr.GetNuclearLaunchRadius();
        const bool scout = launches % Every == 0 && Silos() < OvernukeSilos;
        const int air = (Global::AISettings::Role == AiRole::AIR) ? ai.teamId : LolCannonRecon::Provider(AiRole::AIR);
        if (air < 0) {
            if (scout) LolCannonRecon::Send(Global::RoleSettings::Air::ScoutSweepT1Count, Global::RoleSettings::Air::NukeScoutRadarCount, at, spread, "nuke launch " + launches);
            return;
        }
        const string msg = "nukerecon|" + (scout ? "scout" : "launch") + "|" + int(at.x) + "|" + int(at.z) + "|" + int(spread);
        GenericHelpers::LogUtil("[NukeRecon] launch " + launches + " at (" + int(at.x) + "," + int(at.z) + ") told AIR=" + air
            + (scout ? ": 10 T1 + 3 radar asked" : ""), 1);
        if (air == ai.teamId) NukeRecon::Handle(msg, ai.teamId);
        else AiSendMessage(msg, air);
    }
}

// Overnuke scouting (owner 2026-10-28). With 3+ silos every silo fires at one
// target (CSuperTask::SelectNuclearTarget); every 10th launch at it the engine
// raises its scout count and we ask AIR for the lolcannon-style package: each
// plane to its own point spread over the blast, not all onto the centre
// (LolCannonRecon::Route). Any role that owns silos asks; AIR flies it.
namespace OvernukeRecon {
    const int T1Scouts = 10, RadarScouts = 3;
    int seen = 0, checked = -SECOND;
    void Tick() {
        if (ai.frame - checked < SECOND) return;
        checked = ai.frame;
        const int scouts = aiMilitaryMgr.GetOvernukeScouts();
        if (scouts <= seen) return;
        seen = scouts;
        const AIFloat3 at = aiMilitaryMgr.GetOvernukePos();
        if (at.x < 0.0f) return;
        LolCannonRecon::Send(T1Scouts, RadarScouts, at, aiMilitaryMgr.GetOvernukeRadius(), "overnuke");
    }
}
