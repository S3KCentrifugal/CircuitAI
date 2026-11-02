// TECH's first completed silo requests one allied AIR reconnaissance package.
// The external AI ABI has a stockpile count but no fractional build progress.
// Use the owner's nominal half-stockpile timer from completion: 60s Armada,
// 90s Cortex/Legion (BAR stockpiletime=120/180/180, firing reloadtime=30).
// Resource starvation can delay the actual missile beyond this nominal point.
// The request carries the silo's latest aim (owner 2026-10-28) and AIR flies it
// at once, T1 scouts only before its T2 plant (AirScoutSweep::Urgent).
namespace NukeRecon {
    int siloId=-1, completed=-1, checked=-SECOND, sentFrame=-1, earlyFrame=-1;
    bool sent=false;
    void Finished(CCircuitUnit@ u) {
        if (sent || (siloId>=0 && ai.GetTeamUnit(siloId) !is null)
            || Global::AISettings::Role!=AiRole::TECH || u is null || u.GetBuildProgress()<1.0f) return;
        const string name=u.circuitDef.GetName();
        if (name!="armsilo" && name!="corsilo" && name!="legsilo") return;
        siloId=u.id; completed=ai.frame;
    }
    // The early call (owner 2026-11-02): at 13:10 on All That Glitters the
    // half-stockpile call left AIR 70 s; a base under attack drafted 3 fighters
    // and the owed package formed for 6 minutes. Once the first silo frame is
    // NukeScoutSiloProgress built (~4 min before the first launch) AIR drafts and
    // builds across to the enemy bases; the half-stockpile call then redrafts.
    void Early() {
        if (earlyFrame>=0 || siloId>=0 || Global::RoleSettings::Tech::NukeScoutSiloProgress>1.0f) return;
        CCircuitDef@ def=ai.GetCircuitDef(TechChain::DefFor("silo"));
        if (def is null || def.count<=0) return;
        CCircuitUnit@ frame=aiBuilderMgr.FindUnfinishedNear(Layout::BaseCentre(),Global::RoleSettings::Tech::ChainAssistRadius,def);
        if (frame is null || frame.GetBuildProgress()<Global::RoleSettings::Tech::NukeScoutSiloProgress) return;
        const int provider=LolCannonRecon::Provider(AiRole::AIR);
        if (provider<0) return;
        AiSendMessage("nukerecon|first",provider);
        earlyFrame=ai.frame;
        GenericHelpers::LogUtil("[TECH][NukeRecon] early call silo frame="+frame.id+" built="+int(frame.GetBuildProgress()*100.0f)+"% AIR="+provider,1);
    }
    void Tick() {
        NukeScoutProbe::TechTick();
        if (sent || Global::AISettings::Role!=AiRole::TECH || ai.frame-checked<SECOND) return;
        checked=ai.frame;
        Early();
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
        sent=true; sentFrame=ai.frame;
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
        if (msg.findFirst("nukerecon|probe|")==0) {
            // nukerecon|probe|event: TECH's silo stocked or fired; AIR logs its scouts' reach
            array<string>@ parts=msg.split("|");
            if (parts.length()>=3) AirScoutSweep::ProbeReport(parts[2],fromTeamId);
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

// Nuke scout probe (owner 2026-11-02): when TECH's first silo first holds a
// missile and when it first fires, TECH logs its own scouts' reach and asks the
// allied AIR to log how far the nuke scout package got (AirScoutSweep::Probe*).
// Reach is the percent of the way from our start centroid to the enemy's.
namespace NukeScoutProbe {
    int stockFrame=-1, launchFrame=-1, checked=-SECOND;
    AIFloat3 home(-1,0,-1), axis(0,0,0);
    float length=0.0f;
    float Progress(const AIFloat3 &in p) {
        if (home.x<0.0f) {
            home=AirScoutSweep::Mean(Lanes::ScriptStarts(false),Global::Map::StartPos);
            const AIFloat3 enemy=AirScoutSweep::Mean(Lanes::ScriptStarts(true),home);
            length=sqrt((enemy.x-home.x)*(enemy.x-home.x)+(enemy.z-home.z)*(enemy.z-home.z));
            if (length>=1.0f) axis=AIFloat3((enemy.x-home.x)/length,0,(enemy.z-home.z)/length);
        }
        if (length<1.0f) return 0.0f;
        return 100.0f*((p.x-home.x)*axis.x+(p.z-home.z)*axis.z)/length;
    }
    string Clock(int frame) {
        if (frame<0) return "never";
        const int s=frame/SECOND;
        return ""+(s/60)+":"+((s%60)<10 ? "0" : "")+(s%60);
    }
    void Report(const string &in ev) {
        const string scout=UnitHelpers::GetT1AirScoutForSide(Global::AISettings::Side);
        float best=-1000.0f; int alive=0;
        array<Id>@ ids=ai.GetOwnedUnitIds();
        for (uint i=0;i<ids.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef.GetName()!=scout || u.GetBuildProgress()<1.0f) continue;
            ++alive; best=AiMax(best,Progress(u.GetPos(ai.frame)));
        }
        const int air=LolCannonRecon::Provider(AiRole::AIR);
        GenericHelpers::LogUtil("[TECH][NukeScout] "+ev+" at "+Clock(ai.frame)+" silo="+NukeRecon::siloId
            +" AIR early call "+Clock(NukeRecon::earlyFrame)+" half-stockpile call "+(NukeRecon::sent ? Clock(NukeRecon::sentFrame) : "not sent")
            +" TECH scouts="+alive+(alive>0 ? " now "+int(best)+"%" : "")+" AIR="+air,1);
        if (air>=0) AiSendMessage("nukerecon|probe|"+ev,air);
    }
    void TechTick() {
        if (Global::AISettings::Role!=AiRole::TECH || launchFrame>=0 || ai.frame-checked<SECOND) return;
        checked=ai.frame;
        const bool fired=aiMilitaryMgr.GetNuclearLaunches()>0;
        CCircuitUnit@ silo=ai.GetTeamUnit(NukeRecon::siloId);
        if (stockFrame<0 && (fired || (silo !is null && silo.GetStockpile()>=1))) { stockFrame=ai.frame; Report("stock1"); }
        if (fired) { launchFrame=ai.frame; Report("launch1"); }
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
