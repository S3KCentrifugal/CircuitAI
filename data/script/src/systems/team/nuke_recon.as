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
        AiSendMessage("nukerecon|first|early",provider);  // AIR builds the package and holds it until the call below
        earlyFrame=ai.frame;
        GenericHelpers::LogUtil("[TECH][NukeRecon] early call silo frame="+frame.id+" built="+int(frame.GetBuildProgress()*100.0f)+"% AIR="+provider,1);
    }
    // The completion call (owner 2026-11-06): the moment the first silo is
    // finished TECH asks AIR to build 10 T1 + 10 radar planes (radar with a T2
    // plant) and send them across, each type spread evenly over the map's width,
    // one waypoint at the far buildable edge and back (AirScoutSweep::Urgent
    // BUILD). The half-stockpile call then only sends a package still forming
    // with what it has, so it crosses before the first missile.
    int doneFrame=-1;
    void Tick() {
        NukeScoutProbe::TechTick();
        if (sent || Global::AISettings::Role!=AiRole::TECH || ai.frame-checked<SECOND) return;
        checked=ai.frame;
        Early();
        CCircuitUnit@ silo=ai.GetTeamUnit(siloId);
        if (silo is null) { siloId=-1; completed=-1; return; }
        const int provider=LolCannonRecon::Provider(AiRole::AIR);
        if (provider<0) return; // late AIR announcements retry, no broadcast storm
        if (doneFrame<0) {
            AiSendMessage("nukerecon|first|done",provider);
            doneFrame=ai.frame;
            GenericHelpers::LogUtil("[TECH][NukeRecon] silo finished silo="+siloId+" AIR="+provider+": 10 T1 + 10 radar across",1);
        }
        const int halfSeconds=silo.circuitDef.GetName()=="armsilo" ? 60 : 90;
        if (ai.frame-completed<halfSeconds*SECOND && silo.GetStockpile()==0) return;
        AiSendMessage("nukerecon|first|release",provider);
        sent=true; sentFrame=ai.frame;
        GenericHelpers::LogUtil("[TECH][NukeRecon] nominal half stockpile silo="+siloId+" AIR="+provider+" seconds="+halfSeconds+": a forming package flies now",1);
    }
    bool Handle(const string &in msg,int fromTeamId) {
        if (msg.findFirst("nukerecon|wave|")==0) {
            // nukerecon|wave|x|z|spread (owner 2026-11-06): every 3rd launch of an ally, a
            // fresh 10 T1 + 10 radar wave across the map (NukeLaunchRecon)
            array<string>@ parts=msg.split("|");
            if (parts.length()<5 || !AirEconomy::Active()) return true;
            if (fromTeamId!=ai.teamId && Team::Roster::Get(fromTeamId) is null) return true;
            AirScoutSweep::Nuked(AIFloat3(parseFloat(parts[2]),0,parseFloat(parts[3])),parseFloat(parts[4]));
            AirScoutSweep::Wave("every 3rd launch from "+fromTeamId);
            return true;
        }
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
        if (msg.findFirst("nukerecon|overnuke|")==0) {
            // nukerecon|overnuke|x|z|spread|round (front nukerush, OvernukeRecon::Rounds): any rostered
            // ally's overnuke began or finished a salvo; draft the built scouts there now, owe the rest
            array<string>@ parts=msg.split("|");
            if (parts.length()<5 || !AirEconomy::Active()) return true;
            if (fromTeamId!=ai.teamId && Team::Roster::Get(fromTeamId) is null) return true;
            const AIFloat3 at(parseFloat(parts[2]),0,parseFloat(parts[3]));
            const float spread=parseFloat(parts[4]);
            AirScoutSweep::Nuked(at,spread);
            AirScoutSweep::Urgent(at,spread);
            GenericHelpers::LogUtil("[AIR][ScoutSweep] overnuke request from "+fromTeamId+(parts.length()>=6 ? " round "+parts[5] : "")
                +" at=("+int(at.x)+","+int(at.z)+") spread="+int(spread),1);
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
            const string kind=parts.length()==3 ? parts[2] : "";
            if (kind=="done") AirScoutSweep::Wave("silo finished TECH="+fromTeamId);   // 10 T1 + 10 radar across, built first
            else if (kind=="release") AirScoutSweep::Release();                      // the half-stockpile call
            // nukerecon|first|early: the silo-frame call; the package is held until the half-stockpile call
            else AirScoutSweep::Urgent(at,spread,kind=="early");
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
        if (length<1.0f) {
            // Same axis as AirScoutSweep::Plan: with no enemy script starts (lobby games,
            // Pawn Retreat 11-04 and Rosetta 11-06) the enemy is the mirrored start,
            // never home itself, which left a zero axis and logged furthest=0% for ever.
            home=AirScoutSweep::Mean(Lanes::ScriptStarts(false),Global::Map::StartPos);
            const AIFloat3 enemy=AirScoutSweep::Mean(Lanes::ScriptStarts(true),AirScreen::Enemy(home));
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
// AIR for a 10 T1 + 10 radar wave across the map (owner 2026-11-06; was 3 radar at the spot), ungated. With no AIR, TECH builds them
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
        // owner 2026-11-06: every 3rd launch, whatever the silo count, a fresh wave across the map
        const bool scout = launches % Every == 0;
        const int air = (Global::AISettings::Role == AiRole::AIR) ? ai.teamId : LolCannonRecon::Provider(AiRole::AIR);
        if (air < 0) {
            if (scout) LolCannonRecon::Send(Global::RoleSettings::Air::ScoutSweepT1Count, Global::RoleSettings::Air::NukeScoutRadarCount, at, spread, "nuke launch " + launches);
            return;
        }
        const string msg = "nukerecon|" + (scout ? "wave" : "launch") + "|" + int(at.x) + "|" + int(at.z) + "|" + int(spread);
        GenericHelpers::LogUtil("[NukeRecon] launch " + launches + " at (" + int(at.x) + "," + int(at.z) + ") told AIR=" + air
            + (scout ? ": a 10 T1 + 10 radar wave across the map asked" : ""), 1);
        if (air == ai.teamId) NukeRecon::Handle(msg, ai.teamId);
        else AiSendMessage(msg, air);
    }
}

// Overnuke scouting (owner 2026-10-28). With 3+ silos every silo fires at one
// target (CSuperTask::SelectNuclearTarget); every 10th launch at it the engine
// raises its scout count and we ask AIR for the lolcannon-style package: each
// plane to its own point spread over the blast, not all onto the centre
// (LolCannonRecon::Route). Any role that owns silos asks; AIR flies it.
//
// Overnuke rounds (owner 2026-11-06): every time a salvo is fully launched and the
// next target starts stocking, the AI whose silo began the target asks AIR for a
// scout package across the map (C++ GetOvernukeRounds). The request is
// nukerecon|overnuke|x|z|spread|round: AIR drafts its built scouts at once and
// owes the rest, ungated, as for TECH's nuke rush call (AirScoutSweep::Urgent);
// with no AIR, TECH builds them (LolCannonRecon::Send). The overnuke's start
// (round 1) called one too only under the front nukerush team roll (2026-11-03),
// removed with it (owner 2026-11-08).
namespace OvernukeRecon {
    const int T1Scouts = 10;
    int RadarScouts() { return Global::RoleSettings::Air::NukeScoutRadarCount; }  // owner 2026-11-06: 10 (was 3)
    int seen = 0, checked = -SECOND, seenRounds = 0;
    void Rounds() {
        const int rounds = aiMilitaryMgr.GetOvernukeRounds();
        if (rounds <= seenRounds) return;
        seenRounds = rounds;
        // owner 2026-11-06: a full salvo out (round 2 on: every silo emptied, the next
        // target stocks) always calls a wave at once; the start (round 1) asked only under
        // the front nukerush roll, removed 2026-11-08
        if (rounds < 2) return;
        const AIFloat3 at = aiMilitaryMgr.GetOvernukePos();
        if (at.x < 0.0f) return;
        const float spread = aiMilitaryMgr.GetOvernukeRadius();
        const string why = rounds == 1 ? "overnuke begins" : "overnuke round " + rounds + ": the last salvo is out, the next stocks";
        const int air = (Global::AISettings::Role == AiRole::AIR) ? ai.teamId : LolCannonRecon::Provider(AiRole::AIR);
        if (air < 0) { LolCannonRecon::Send(T1Scouts, RadarScouts(), at, spread, "nukerush " + why); return; }
        const string msg = "nukerecon|overnuke|" + int(at.x) + "|" + int(at.z) + "|" + int(spread) + "|" + rounds;
        GenericHelpers::LogUtil("[NukeRush] " + why + " at (" + int(at.x) + "," + int(at.z) + "): AIR=" + air + " asked to scout across the map", 1);
        if (air == ai.teamId) NukeRecon::Handle(msg, ai.teamId);
        else AiSendMessage(msg, air);
    }
    void Tick() {
        if (ai.frame - checked < SECOND) return;
        checked = ai.frame;
        Rounds();
        const int scouts = aiMilitaryMgr.GetOvernukeScouts();
        if (scouts <= seen) return;
        seen = scouts;
        const AIFloat3 at = aiMilitaryMgr.GetOvernukePos();
        if (at.x < 0.0f) return;
        LolCannonRecon::Send(T1Scouts, RadarScouts(), at, aiMilitaryMgr.GetOvernukeRadius(), "overnuke");
    }
}
