// Air emergency defense (owner, 2026-11-12).
//
// AIR side: while AirBaseResponse has a base contact (its gunship "emergency"),
// Announce() broadcasts "airemg|on|x|z" (on start, when the spot moves, every
// RefreshSeconds) and "airemg|off" when the contact ends.
//
// FRONT side: each FRONT keeps one emergency per AIR team. When a new one
// starts (or the spot jumps more than AirEmergencyDefenseNewSite), the
// AirEmergencyDefenseFronts FRONTs whose start positions are nearest the spot
// take it (the same roster and ranking on every FRONT, ties to the lower team
// id). Their non-spam T1/T2 land labs make one fast-defense unit per ask
// (FactoryMakeTask, before every other FRONT provider); the units join a ground
// CRouteTask that moves to a point AirEmergencyDefenseApproach short of the
// spot and patrols between it and the spot (the gunship group's move/patrol
// shape). When the emergency ends the labs fall back to their normal providers
// on their next ask (each recruit is one unit, nothing is aborted) and the
// squad keeps patrolling the spot. A later emergency near a standing squad
// reuses that squad.
//
// Cost: no per-frame work and no tick. Messages: one per AIR per
// RefreshSeconds while a contact lasts. FRONT work is O(emergencies + squads)
// per factory/military ask, both bounded (AIR teams, MaxSquads).
// Null safety: every unit, def, task and roster entry is checked at use; a
// role switch away from FRONT stops production at once (the role check is per
// ask) and leaves the squads patrolling; a lost factory's owed count is pruned.
namespace AirEmergencyDefense {
    const string MSG = "airemg";
    const int RefreshSeconds = 3;

    /************************************************************************
     AIR side
     ************************************************************************/
    bool announced = false;
    AIFloat3 announcedAt(-1.0f, 0.0f, -1.0f);
    int announcedFrame = -100000;

    void Announce(bool contact, const AIFloat3 &in site)
    {
        if (Global::AISettings::Role != AiRole::AIR) return;
        if (!contact) {
            if (!announced) return;
            announced = false;
            AiSendMessage(MSG + "|off");
            GenericHelpers::LogUtil("[AIR][AirEmergency] over: FRONT defense told", 1);
            return;
        }
        if (site.x < 0.0f) return;
        const bool moved = !announced || MapHelpers::SqDist(site, announcedAt)
            > Global::RoleSettings::Front::AirEmergencyDefenseRerouteDistance * Global::RoleSettings::Front::AirEmergencyDefenseRerouteDistance;
        if (!moved && ai.frame - announcedFrame < RefreshSeconds * SECOND) return;
        if (!announced) GenericHelpers::LogUtil("[AIR][AirEmergency] on at (" + int(site.x) + "," + int(site.z) + "): FRONT defense called", 1);
        announced = true; announcedAt = site; announcedFrame = ai.frame;
        AiSendMessage(MSG + "|on|" + int(site.x) + "|" + int(site.z));
    }

    /************************************************************************
     FRONT side
     ************************************************************************/
    class Emergency {
        int airTeam = -1;
        int serial = 0;
        AIFloat3 site;
        int lastOn = -100000;
        bool mine = false;
        bool over = false;
    }
    class Squad {
        int serial = 0;
        AIFloat3 site;
        CRouteTask@ task;
        array<int> members;
        bool patrolOnly = false;   // its emergency ended: left on patrol
        // defense report (owner 2026-11-12), reset for each emergency the squad answers
        int airTeam = -1;
        int startFrame = -1, endFrame = -1, firstArrival = -1, lastReport = -100000;
        int joined = 0, lost = 0, arrived = 0;
        float enemyStart = -1.0f, enemyPeak = 0.0f, enemyNow = 0.0f;
        bool finalDone = true;
    }
    // Report sampling (CheckOrphaned, every 30 frames, throttled to ReportSampleSeconds):
    // O(squads * (members + ground contacts)), only while a squad is reporting.
    const int ReportSampleSeconds = 2;
    const int ReportEverySeconds = 10;
    const int ReportAfterSeconds = 60;       // keeps sampling this long after the emergency ends
    const float ReportArriveRadius = 600.0f; // a member this near the spot counts as there
    const float ReportEnemyRadius = 800.0f;  // enemy ground metal this near the spot
    int reportSampled = -100000;
    dictionary emergencies;        // AIR team id string -> Emergency@
    array<Squad@> squads;
    dictionary owed;               // factory id string -> squad serial
    dictionary owedCount;          // factory id string -> recruits still to come
    dictionary turn;               // factory id string -> next index into AirEmergencyDefenseUnits
    dictionary memberOf;           // unit id string -> squad serial
    int nextSerial = 1;

    bool Enabled() { return Global::RoleSettings::Front::AirEmergencyDefense; }
    int EndFrames() { return AiMax(1, Global::RoleSettings::Front::AirEmergencyDefenseEndSeconds) * SECOND; }

    // Ends an emergency whose AIR has gone quiet (lazy: read on every ask).
    bool Live(Emergency@ e)
    {
        if (e is null) return false;
        if (!e.over && ai.frame - e.lastOn >= EndFrames()) {
            e.over = true;
            if (e.mine) {
                Squad@ s = SquadBySerial(e.serial);
                if (s !is null) { s.patrolOnly = true; if (s.endFrame < 0) s.endFrame = ai.frame; }
                GenericHelpers::LogUtil("[FRONT][AirEmergency] AIR team " + e.airTeam + " emergency " + e.serial
                    + " over: labs back to normal, squad " + (s is null ? 0 : int(s.members.length()))
                    + " units left on patrol at (" + int(e.site.x) + "," + int(e.site.z) + ")", 1);
            }
        }
        return !e.over;
    }

    Squad@ SquadBySerial(int serial)
    {
        for (uint i = 0; i < squads.length(); ++i)
            if (squads[i] !is null && squads[i].serial == serial) return squads[i];
        return null;
    }

    // Is this FRONT among the nearest AirEmergencyDefenseFronts FRONT starts to the spot?
    bool Nearest(const AIFloat3 &in site, string &out picked)
    {
        picked = "";
        if (Global::AISettings::Role != AiRole::FRONT) return false;
        array<int> teams;
        array<float> dists;
        teams.insertLast(ai.teamId); dists.insertLast(MapHelpers::SqDist(site, Global::Map::StartPos));
        array<Team::Roster::Entry@>@ fronts = Team::Roster::WithRole(AiRole::FRONT);
        for (uint i = 0; fronts !is null && i < fronts.length(); ++i) {
            Team::Roster::Entry@ e = fronts[i];
            if (e is null || e.teamId == ai.teamId || teams.find(e.teamId) >= 0) continue;
            if (!TeamEconomy::Alive(e.teamId)) continue;
            teams.insertLast(e.teamId); dists.insertLast(MapHelpers::SqDist(site, e.startPos));
        }
        const float mine = dists[0];
        int rank = 0;
        for (uint i = 1; i < teams.length(); ++i)
            if (dists[i] < mine || (dists[i] == mine && teams[i] < ai.teamId)) ++rank;
        // the picked teams, for the log (selection sort over at most 16 allies)
        array<bool> used(teams.length(), false);
        const int want = AiMax(1, Global::RoleSettings::Front::AirEmergencyDefenseFronts);
        for (int n = 0; n < want && n < int(teams.length()); ++n) {
            int best = -1;
            for (uint i = 0; i < teams.length(); ++i) {
                if (used[i]) continue;
                if (best < 0 || dists[i] < dists[best] || (dists[i] == dists[best] && teams[i] < teams[best])) best = int(i);
            }
            if (best < 0) break;
            used[best] = true;
            picked += (picked == "" ? "" : ",") + teams[best];
        }
        return rank < want;
    }

    bool HandleMessage(const string &in msg, int fromTeamId)
    {
        array<string>@ p = msg.split("|");
        if (p.length() < 2 || p[0] != MSG) return false;
        if (!Enabled() || Global::AISettings::Role != AiRole::FRONT) return true;
        const string key = "" + fromTeamId;
        Emergency@ e = null;
        emergencies.get(key, @e);
        if (p[1] == "off") {
            // ends EndSeconds after the last "on" at most, 4 s from now at least
            if (e !is null && !e.over) e.lastOn = AiMin(e.lastOn, ai.frame - EndFrames() + 4 * SECOND);
            return true;
        }
        if (p[1] != "on" || p.length() < 4) return true;
        const AIFloat3 site(float(parseInt(p[2])), 0.0f, float(parseInt(p[3])));
        if (site.x < 0.0f || site.z < 0.0f) return true;
        const float far = Global::RoleSettings::Front::AirEmergencyDefenseNewSite;
        const bool fresh = e is null || !Live(e) || MapHelpers::SqDist(site, e.site) > far * far;
        if (fresh) {
            if (e !is null && !e.over) { e.lastOn = -100000; Live(e); }   // the old spot's emergency ends here
            @e = Emergency();
            e.airTeam = fromTeamId; e.serial = nextSerial++; e.site = site; e.lastOn = ai.frame;
            string picked;
            e.mine = Nearest(site, picked);
            emergencies.set(key, @e);
            GenericHelpers::LogUtil("[FRONT][AirEmergency] AIR team " + fromTeamId + " emergency " + e.serial + " at ("
                + int(site.x) + "," + int(site.z) + "): nearest FRONTs " + picked
                + (e.mine ? " - this FRONT's labs switch to fast defense" : " - not this FRONT"), 1);
            if (e.mine) Join(e);
            return true;
        }
        e.lastOn = ai.frame;
        const float reroute = Global::RoleSettings::Front::AirEmergencyDefenseRerouteDistance;
        if (MapHelpers::SqDist(site, e.site) > reroute * reroute) {
            e.site = site;
            Squad@ s = e.mine ? SquadBySerial(e.serial) : null;
            if (s !is null) { s.site = site; Route(s); }
        }
        return true;
    }

    // The emergency's squad: a standing squad near the spot, else a new one.
    Squad@ Join(Emergency@ e)
    {
        if (e is null) return null;
        Squad@ s = SquadBySerial(e.serial);
        if (s !is null) return s;
        const float merge = Global::RoleSettings::Front::AirEmergencyDefenseSquadMerge;
        for (uint i = 0; i < squads.length(); ++i) {
            Squad@ old = squads[i];
            if (old is null || MapHelpers::SqDist(old.site, e.site) > merge * merge) continue;
            GenericHelpers::LogUtil("[FRONT][AirEmergency] emergency " + e.serial + " reuses squad " + old.serial
                + " (" + old.members.length() + " units) patrolling (" + int(old.site.x) + "," + int(old.site.z) + ")", 1);
            if (!old.finalDone) Final(old);
            old.serial = e.serial; old.site = e.site; old.patrolOnly = false;
            StartReport(old, e);
            Route(old);
            return old;
        }
        Prune();
        @s = Squad();
        s.serial = e.serial; s.site = e.site;
        StartReport(s, e);
        squads.insertLast(s);
        return s;
    }

    /************************************************************************
     Defense report (owner 2026-11-12): how well each emergency was defended.
     [FRONT][AirEmergency][Report] lines: every ReportEverySeconds while the
     emergency is on, then one "final" line ReportAfterSeconds after it ends.
     Enemy metal = enemy ground contacts (units and structures) this AI knows
     within ReportEnemyRadius of the spot. AIR's gunships fight there too, so a
     cleared spot is not credited to the squad alone; arrival, losses and
     presence are the squad's own numbers.
     ************************************************************************/
    void StartReport(Squad@ s, Emergency@ e)
    {
        s.airTeam = e.airTeam; s.startFrame = ai.frame; s.endFrame = -1; s.firstArrival = -1;
        s.lastReport = ai.frame; s.joined = 0; s.lost = 0; s.arrived = 0;
        s.enemyStart = EnemyMetal(s.site); s.enemyPeak = s.enemyStart; s.enemyNow = s.enemyStart;
        s.finalDone = false;
    }

    float EnemyMetal(const AIFloat3 &in site)
    {
        float metal = 0.0f;
        const float r2 = ReportEnemyRadius * ReportEnemyRadius;
        const int contacts = aiBattle.GetGroundContactCount();
        for (int i = 0; i < contacts; ++i) {
            if (MapHelpers::SqDist(site, aiBattle.GetGroundContactPos(i)) > r2) continue;
            const CCircuitDef@ d = ai.GetCircuitDef(aiBattle.GetGroundContactDefId(i));
            if (d !is null) metal += d.costM;
        }
        return metal;
    }

    void Sample(Squad@ s)
    {
        int there = 0;
        const float r2 = ReportArriveRadius * ReportArriveRadius;
        for (uint k = 0; k < s.members.length(); ++k) {
            CCircuitUnit@ u = ai.GetTeamUnit(s.members[k]);
            if (u !is null && MapHelpers::SqDist(u.GetPos(ai.frame), s.site) <= r2) ++there;
        }
        s.arrived = there;
        if (there > 0 && s.firstArrival < 0) {
            s.firstArrival = ai.frame;
            GenericHelpers::LogUtil("[FRONT][AirEmergency][Report] squad " + s.serial + ": first unit at the spot +"
                + (ai.frame - s.startFrame) / SECOND + " s", 1);
        }
        s.enemyNow = EnemyMetal(s.site);
        if (s.enemyNow > s.enemyPeak) s.enemyPeak = s.enemyNow;
    }

    void Final(Squad@ s)
    {
        s.finalDone = true;
        const int end = s.endFrame >= 0 ? s.endFrame : ai.frame;
        const bool cleared = s.enemyNow <= AiMax(50.0f, s.enemyPeak * 0.1f);
        GenericHelpers::LogUtil("[FRONT][AirEmergency][Report] final squad " + s.serial + " AIR team " + s.airTeam
            + " at (" + int(s.site.x) + "," + int(s.site.z) + "): emergency " + (end - s.startFrame) / SECOND + " s"
            + ", first arrival " + (s.firstArrival < 0 ? "never" : ("+" + (s.firstArrival - s.startFrame) / SECOND + " s"))
            + ", joined " + s.joined + ", lost " + s.lost + ", alive " + s.members.length() + ", at spot " + s.arrived
            + ", enemy metal start " + int(s.enemyStart) + " peak " + int(s.enemyPeak) + " now " + int(s.enemyNow)
            + ", cleared " + (cleared ? "yes" : "no"), 1);
    }

    // Team::CheckOrphaned (every 30 frames)
    void Tick()
    {
        if (squads.length() == 0 || ai.frame - reportSampled < ReportSampleSeconds * SECOND) return;
        reportSampled = ai.frame;
        // emergencies end lazily; read them so endFrame is set on time
        if (emergencies.getSize() > 0) {
            array<string>@ keys = emergencies.getKeys();
            for (uint i = 0; i < keys.length(); ++i) {
                Emergency@ e = null;
                if (emergencies.get(keys[i], @e) && e !is null) Live(e);
            }
        }
        for (uint i = 0; i < squads.length(); ++i) {
            Squad@ s = squads[i];
            if (s is null || s.finalDone) continue;
            for (int k = int(s.members.length()) - 1; k >= 0; --k)
                if (ai.GetTeamUnit(s.members[k]) is null) { memberOf.delete("" + s.members[k]); s.members.removeAt(k); ++s.lost; }
            Sample(s);
            if (s.endFrame >= 0 && ai.frame - s.endFrame >= ReportAfterSeconds * SECOND) { Final(s); continue; }
            if (s.endFrame < 0 && ai.frame - s.lastReport >= ReportEverySeconds * SECOND) {
                s.lastReport = ai.frame;
                GenericHelpers::LogUtil("[FRONT][AirEmergency][Report] squad " + s.serial + " +" + (ai.frame - s.startFrame) / SECOND
                    + " s: alive " + s.members.length() + ", at spot " + s.arrived + ", lost " + s.lost
                    + ", enemy metal near " + int(s.enemyNow) + " (peak " + int(s.enemyPeak) + ")", 1);
            }
        }
    }

    // Drops dead members; forgets (and aborts) empty finished squads over the cap.
    void Prune()
    {
        for (uint i = 0; i < squads.length(); ++i) {
            Squad@ s = squads[i];
            if (s is null) continue;
            for (int k = int(s.members.length()) - 1; k >= 0; --k) {
                CCircuitUnit@ u = ai.GetTeamUnit(s.members[k]);
                if (u is null || u.task !is s.task) { memberOf.delete("" + s.members[k]); s.members.removeAt(k); }
            }
        }
        // finished squads with nobody left go; over the cap, the oldest finished
        // ones are forgotten (their units keep patrolling on their own task)
        for (int i = int(squads.length()) - 1; i >= 0; --i) {
            Squad@ s = squads[i];
            if (s !is null && (!s.finalDone || !(s.patrolOnly && s.members.length() == 0))) continue;
            if (s !is null && s.task !is null && !s.task.IsDead()) s.task.Abort();
            squads.removeAt(i);
        }
        for (uint i = 0; i < squads.length() && int(squads.length()) > Global::RoleSettings::Front::AirEmergencyDefenseMaxSquads; ) {
            if (squads[i].patrolOnly && squads[i].finalDone) {
                for (uint k = 0; k < squads[i].members.length(); ++k) memberOf.delete("" + squads[i].members[k]);
                squads.removeAt(i);
            } else ++i;
        }
        array<string>@ keys = owed.getKeys();
        for (uint i = 0; i < keys.length(); ++i)
            if (ai.GetTeamUnit(parseInt(keys[i])) is null) { owed.delete(keys[i]); owedCount.delete(keys[i]); turn.delete(keys[i]); }
    }

    // move to the approach point, then patrol between it and the spot
    array<AIFloat3> Points(const AIFloat3 &in site)
    {
        const AIFloat3 home = Global::Map::StartPos;
        const float d = sqrt(MapHelpers::SqDist(site, home));
        const float a = AiMin(Global::RoleSettings::Front::AirEmergencyDefenseApproach, d * 0.5f);
        AIFloat3 near = site;
        if (d > 1.0f) { near.x += (home.x - site.x) / d * a; near.z += (home.z - site.z) / d * a; }
        near.x = AiMax(64.0f, AiMin(float(AiTerrainWidth()) - 64.0f, near.x));
        near.z = AiMax(64.0f, AiMin(float(AiTerrainHeight()) - 64.0f, near.z));
        AIFloat3 at = site;
        at.x = AiMax(64.0f, AiMin(float(AiTerrainWidth()) - 64.0f, at.x));
        at.z = AiMax(64.0f, AiMin(float(AiTerrainHeight()) - 64.0f, at.z));
        array<AIFloat3> route = {near, at};
        return route;
    }

    void Route(Squad@ s)
    {
        if (s is null || s.task is null || s.task.IsDead()) return;
        s.task.SetRoute(Points(s.site));
    }

    CRouteTask@ EnsureTask(Squad@ s)
    {
        if (s is null) return null;
        if (s.task !is null && !s.task.IsDead()) return s.task;
        @s.task = cast<CRouteTask>(cast<IFighterTask>(aiMilitaryMgr.Enqueue(TaskF::Route())));
        if (s.task is null) return null;
        s.task.SetLanes(5, 80.0f, 1.0f);
        s.task.SetPatrol(true);
        s.task.SetRoute(Points(s.site));
        return s.task;
    }

    // The live emergency of this FRONT nearest to pos, null when none.
    Emergency@ ActiveFor(const AIFloat3 &in pos)
    {
        if (emergencies.getSize() == 0) return null;
        Emergency@ best = null;
        float bestSq = 1e30f;
        array<string>@ keys = emergencies.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            Emergency@ e = null;
            if (!emergencies.get(keys[i], @e) || e is null || !e.mine || !Live(e)) continue;
            const float sq = MapHelpers::SqDist(pos, e.site);
            if (sq < bestSq) { bestSq = sq; @best = e; }
        }
        return best;
    }

    // Labs that belong to another owner right now: spam pumps, the edge lab,
    // the opener, and gathering T2 squads/waves (they claim by producer and def).
    bool Busy(CCircuitUnit@ f)
    {
        const string key = "" + f.id;
        if (EdgeLanes::IsEdgeLab(f) || Spam::repeatTask.exists(key)) return true;
        if (Spam::active && Spam::SpamUnitFor(f.circuitDef).length() > 0) return true;
        if (FrontOpener::OwnsFactory(f)) return true;
        for (uint i = 0; i < FrontArtySquad::squads.length(); ++i) {
            FrontArtySquad::Squad@ s = FrontArtySquad::squads[i];
            if (s !is null && !s.released && (s.factoryId == f.id || s.botLabId == f.id)) return true;
        }
        for (uint i = 0; i < FrontWaveEscort::waves.length(); ++i) {
            FrontWaveEscort::Wave@ w = FrontWaveEscort::waves[i];
            if (w !is null && w.factoryId == f.id && int(w.tanks.length()) < w.expected) return true;
        }
        return false;
    }

    // Factory::AiMakeTask (FRONT, first): one fast-defense recruit, or null.
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ f)
    {
        if (!Enabled() || Global::AISettings::Role != AiRole::FRONT || emergencies.getSize() == 0) return null;
        if (f is null || f.circuitDef is null || Lifecycle::IsRetiring(f)) return null;
        const string fname = f.circuitDef.GetName();
        const bool t1 = UnitHelpers::IsT1BotLab(fname) || UnitHelpers::IsT1VehicleLab(fname);
        const bool t2 = UnitHelpers::IsT2BotLab(fname) || UnitHelpers::IsT2VehicleLab(fname);
        if (!t1 && !t2) return null;
        Emergency@ e = ActiveFor(f.GetPos(ai.frame));
        if (e is null || Busy(f)) return null;
        const array<string>@ names = @Global::RoleSettings::Front::AirEmergencyDefenseUnits;
        if (names is null || names.length() == 0) return null;
        const string key = "" + f.id;
        int start = 0;
        turn.get(key, start);
        CCircuitDef@ def = null;
        for (uint n = 0; n < names.length() && def is null; ++n) {
            const uint i = (uint(AiMax(0, start)) + n) % names.length();
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d is null || !f.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) continue;
            @def = d;
            turn.set(key, int((i + 1) % names.length()));
        }
        if (def is null) return null;
        if (Join(e) is null) return null;
        IUnitTask@ task = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH,
            def, f.GetPos(ai.frame), 64.f));
        if (task is null) return null;
        int prior = -1, count = 0;
        if (owed.get(key, prior) && prior == e.serial) owedCount.get(key, count); else count = 0;
        owed.set(key, e.serial); owedCount.set(key, count + 1);
        GenericHelpers::LogUtil("[FRONT][AirEmergency] emergency " + e.serial + ": " + fname + " " + f.id
            + " makes " + def.GetName(), 1);
        return task;
    }

    // Military::AiMakeTask (first after the commander group): a unit from an
    // emergency recruit joins its squad, and a squad member keeps its task.
    IUnitTask@ MilitaryMakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        if (owed.getSize() == 0 && memberOf.getSize() == 0) return null;
        const string ukey = "" + u.id;
        int serial = -1;
        if (!memberOf.get(ukey, serial)) {
            const string fkey = "" + u.GetProducerId();
            int count = 0;
            if (!owed.get(fkey, serial) || !owedCount.get(fkey, count) || count <= 0) return null;
            if (Global::RoleSettings::Front::AirEmergencyDefenseUnits.find(u.circuitDef.GetName()) < 0) return null;
            owedCount.set(fkey, count - 1);
            if (count - 1 <= 0) { owed.delete(fkey); owedCount.delete(fkey); }
            // a T2 squad or wave already claimed it: theirs
            if (FrontArtySquad::SquadOf(u.id) !is null || FrontWaveEscort::EscortWave(u.id) !is null) return null;
        }
        Squad@ s = SquadBySerial(serial);
        CRouteTask@ task = EnsureTask(s);
        if (task is null) { memberOf.delete(ukey); return null; }
        if (s.members.find(u.id) < 0) {
            s.members.insertLast(u.id);
            if (!s.finalDone) ++s.joined;
            memberOf.set(ukey, s.serial);
            u.SetFireState(2);
            GenericHelpers::LogUtil("[FRONT][AirEmergency] squad " + s.serial + ": " + u.circuitDef.GetName() + " " + u.id
                + " joins (" + s.members.length() + ")" + (s.patrolOnly ? ", emergency over: straight to patrol" : ""), 1);
        }
        return task;
    }

    void UnitRemoved(CCircuitUnit@ u)
    {
        if (u is null || memberOf.getSize() == 0) return;
        const string ukey = "" + u.id;
        int serial = -1;
        if (!memberOf.get(ukey, serial)) return;
        memberOf.delete(ukey);
        Squad@ s = SquadBySerial(serial);
        if (s is null) return;
        const int k = s.members.find(u.id);
        if (k >= 0) { s.members.removeAt(k); if (!s.finalDone) ++s.lost; }
    }
}
