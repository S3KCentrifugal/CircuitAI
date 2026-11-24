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
//
// T3 response (owner, 2026-11-24; AirEmergencyDefenseT3*). An answering AI's
// finished land T3 gantries build Razorbacks / Demons / Praetorians
// (GantryMakeTask, before the gantry's normal providers) for the squad. TECH
// answers as well: every TECH with a finished gantry whose start is within
// AirEmergencyDefenseTechRadius of the spot (TechTakes) sends its standing heavy
// T3s once (SendHeavies: Thor, Titan, Juggernaut, Sol Invictus not already in a
// squad, a held heavy wave, a heavy delivery, a retreat or a player order) and
// keeps them, and the gantry products, on patrol like FRONT squads. TECH has no
// hand-off: it never sends "airemg|pass". Heavies are tracked by id from
// Military::AiUnitAdded (bounded by the heavies alive), so sending is O(heavies)
// once per answered emergency.
namespace AirEmergencyDefense {
    const string MSG = "airemg";
    const int RefreshSeconds = 3;

    bool IsTech() { return Global::AISettings::Role == AiRole::TECH; }
    string Tag() { return IsTech() ? "[TECH][AirEmergency]" : "[FRONT][AirEmergency]"; }
    bool T3Enabled() { return Global::RoleSettings::Front::AirEmergencyDefenseT3; }
    // The roles that answer an emergency: FRONT, and TECH when the T3 response is on.
    bool Answers() { return Global::AISettings::Role == AiRole::FRONT || (IsTech() && T3Enabled()); }

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
        int started = -1;          // owner 2026-11-14: this FRONT stops after TimeoutSeconds of constant emergency
        bool timedOut = false;
        // owner 2026-11-14: FRONTs that cannot reach the spot pass it on; every FRONT
        // re-ranks without them, so the next nearest takes it (same list on every FRONT)
        array<int> passed;
        dictionary reach;          // unit def name -> bool, from this FRONT's labs to the spot (static, once per def)
        bool handedOver = false;   // this FRONT passed it on
    }
    // Cooldown zones (owner 2026-11-14): after this FRONT's response ends (or times
    // out), it ignores new emergencies within CooldownRadius of the spot for
    // CooldownSeconds. At most one zone per answered emergency, pruned on read.
    class Cooldown { AIFloat3 site; int until = -1; }
    array<Cooldown@> cooldowns;
    void AddCooldown(const AIFloat3 &in site)
    {
        const int until = ai.frame + AiMax(0, Global::RoleSettings::Front::AirEmergencyDefenseCooldownSeconds) * SECOND;
        const float r = Global::RoleSettings::Front::AirEmergencyDefenseCooldownRadius;
        for (uint i = 0; i < cooldowns.length(); ++i)
            if (MapHelpers::SqDist(cooldowns[i].site, site) <= r * r * 0.25f) { cooldowns[i].until = AiMax(cooldowns[i].until, until); return; }
        Cooldown@ c = Cooldown(); c.site = site; c.until = until;
        cooldowns.insertLast(c);
    }
    // seconds of cooldown left at site, 0 when none
    int CoolingFor(const AIFloat3 &in site)
    {
        int left = 0;
        const float r = Global::RoleSettings::Front::AirEmergencyDefenseCooldownRadius;
        for (int i = int(cooldowns.length()) - 1; i >= 0; --i) {
            if (cooldowns[i].until <= ai.frame) { cooldowns.removeAt(i); continue; }
            if (MapHelpers::SqDist(cooldowns[i].site, site) <= r * r) left = AiMax(left, (cooldowns[i].until - ai.frame) / SECOND);
        }
        return left;
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
        // owner 2026-11-12: big attacks get groups, not a trickle. Units wait on
        // `rally` (hold at a point toward home) and move to `task` together.
        CRouteTask@ rally;
        AIFloat3 rallyAt(-1.0f, 0.0f, -1.0f);
        array<int> waiting;
        int waitSince = -1;
        int groups = 0;
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
                AddCooldown(e.site);   // counted from the end, also after a timeout
                if (!e.timedOut)
                    GenericHelpers::LogUtil(Tag() + " AIR team " + e.airTeam + " emergency " + e.serial
                        + " over: labs back to normal, squad " + (s is null ? 0 : int(s.members.length()))
                        + " units left on patrol at (" + int(e.site.x) + "," + int(e.site.z) + "), cooldown "
                        + Global::RoleSettings::Front::AirEmergencyDefenseCooldownSeconds + " s", 1);
            }
        }
        // a constant emergency: this FRONT stops sending after TimeoutSeconds; the squad stays on patrol
        if (!e.over && e.mine && !e.timedOut && e.started >= 0
            && ai.frame - e.started >= AiMax(1, Global::RoleSettings::Front::AirEmergencyDefenseTimeoutSeconds) * SECOND) {
            e.timedOut = true;
            Squad@ s = SquadBySerial(e.serial);
            if (s !is null) { s.patrolOnly = true; if (s.endFrame < 0) s.endFrame = ai.frame; }
            GenericHelpers::LogUtil(Tag() + " AIR team " + e.airTeam + " emergency " + e.serial
                + " timed out after " + (ai.frame - e.started) / SECOND + " s: labs back to normal, squad "
                + (s is null ? 0 : int(s.members.length())) + " units left on patrol at (" + int(e.site.x) + "," + int(e.site.z)
                + "); no new response here until " + Global::RoleSettings::Front::AirEmergencyDefenseCooldownSeconds
                + " s after it ends", 1);
        }
        return !e.over;
    }

    Emergency@ EmergencyBySerial(int serial)
    {
        array<string>@ keys = emergencies.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            Emergency@ e = null;
            if (emergencies.get(keys[i], @e) && e !is null && e.serial == serial) return e;
        }
        return null;
    }

    Squad@ SquadBySerial(int serial)
    {
        for (uint i = 0; i < squads.length(); ++i)
            if (squads[i] !is null && squads[i].serial == serial) return squads[i];
        return null;
    }

    // Is this FRONT among the nearest AirEmergencyDefenseFronts FRONT starts to the spot?
    bool Nearest(const AIFloat3 &in site, string &out picked, const array<int> &in excluded)
    {
        picked = "";
        if (Global::AISettings::Role != AiRole::FRONT) return false;
        array<int> teams;
        array<float> dists;
        teams.insertLast(ai.teamId); dists.insertLast(MapHelpers::SqDist(site, Global::Map::StartPos));
        array<Team::Roster::Entry@>@ fronts = Team::Roster::WithRole(AiRole::FRONT);
        for (uint i = 0; fronts !is null && i < fronts.length(); ++i) {
            Team::Roster::Entry@ e = fronts[i];
            if (e is null || e.teamId == ai.teamId || teams.find(e.teamId) >= 0 || excluded.find(e.teamId) >= 0) continue;
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

    // This FRONT was picked (first, or after another FRONT passed): answer, or pass
    // it on when it is cooling down here or none of its labs' units can reach the spot.
    void Answer(Emergency@ e, const string &in takeover)
    {
        const int cooling = CoolingFor(e.site);
        // cooling down: sit this one out, no hand-off (handing it on made the answer hop across
        // every FRONT on repeat scout pokes: 84 hand-offs in one Flats and Forests game)
        if (cooling > 0) {
            e.mine = false; e.handedOver = true;
            GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + (IsTech() ? ": this TECH" : ": this FRONT") + " is cooling down here ("
                + cooling + " s left), not answering", 1);
            return;
        }
        string why;
        if (IsTech()) { TechAnswer(e, takeover); return; }
        if (!CanHelp(e, why)) { Decline(e, why); return; }
        GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + ": this FRONT's labs switch to fast defense"
            + (takeover == "" ? "" : " (" + takeover + ")") + "; " + why
            + (T3Enabled() && StandingGantries() > 0 ? "; " + StandingGantries() + " T3 gantry(s) build the T3 response" : ""), 1);
        Join(e);
    }

    /************************************************************************
     T3 response (owner, 2026-11-24)
     ************************************************************************/
    dictionary heavyIds;   // unit id string -> true: our standing heavy T3s (TECH), from Military::AiUnitAdded

    bool StandingGantry(CCircuitUnit@ f)
    {
        return f !is null && f.circuitDef !is null && !Lifecycle::IsRetiring(f) && f.GetBuildProgress() >= 1.0f
            && UnitHelpers::IsGantryLab(f.circuitDef.GetName());
    }

    // finished T3 gantries (land or water) of this AI: O(factories)
    int StandingGantries()
    {
        int n = 0;
        for (uint i = 0; i < Factory::factoryList.length(); ++i)
            if (StandingGantry(Factory::factoryList[i])) ++n;
        return n;
    }

    // TECH: answer when a gantry stands and the spot is near enough to this TECH's start.
    bool TechTakes(const AIFloat3 &in site, string &out why)
    {
        why = "";
        if (!IsTech() || !T3Enabled()) return false;
        const int gantries = StandingGantries();
        if (gantries == 0) { why = "no finished T3 gantry"; return false; }
        const float r = Global::RoleSettings::Front::AirEmergencyDefenseTechRadius;
        const float d = sqrt(MapHelpers::SqDist(site, Global::Map::StartPos));
        if (r > 0.0f && d > r) { why = "spot " + int(d) + " elmo from our start (over " + int(r) + ")"; return false; }
        why = gantries + " T3 gantry(s), spot " + int(d) + " elmo from our start";
        return true;
    }

    void TechAnswer(Emergency@ e, const string &in takeover)
    {
        Squad@ s = Join(e);
        if (s is null) return;
        const int sent = SendHeavies(e, s);
        GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + ": this TECH answers"
            + (takeover == "" ? "" : " (" + takeover + ")") + "; " + sent + " heavy T3(s) sent, "
            + StandingGantries() + " gantry(s) build the T3 response", 1);
    }

    // Military::AiUnitAdded (every role; only TECH records)
    void UnitAdded(CCircuitUnit@ u)
    {
        if (!IsTech() || u is null || u.circuitDef is null) return;
        if (Global::RoleSettings::Front::AirEmergencyDefenseTechHeavies.find(u.circuitDef.GetName()) >= 0)
            heavyIds.set("" + u.id, true);
    }

    // A heavy another owner holds right now, or that must not be pulled.
    string HeavyBusy(CCircuitUnit@ u)
    {
        IUnitTask@ t = u.task;
        if (t !is null && (t.IsExternalControlled() || t.GetType() == int(Task::Type::PLAYER))) return "player order";
        if (t !is null && t.GetType() == int(Task::Type::RETREAT)) return "retreating";
        if (TechHeavyDelivery::deliveries.exists("" + u.id)) return "heavy delivery";
        if (HeavyWave::active) {
            const int m = HeavyWave::members.find(u.id);
            if (m >= 0 && m < int(HeavyWave::departed.length()) && !HeavyWave::departed[m]) return "held heavy wave";
        }
        return "";
    }

    // Send this TECH's standing heavies (not in a squad yet) to the squad, once per answer.
    int SendHeavies(Emergency@ e, Squad@ s)
    {
        if (heavyIds.getSize() == 0) return 0;
        CRouteTask@ task = EnsureTask(s);
        if (task is null) return 0;
        int sent = 0, skipped = 0;
        string skips = "";
        array<string>@ keys = heavyIds.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(parseInt(keys[i]));
            if (u is null || u.circuitDef is null) { heavyIds.delete(keys[i]); continue; }
            if (memberOf.exists(keys[i])) continue;   // already patrolling an emergency spot: stays there
            string why = HeavyBusy(u);
            if (why == "" && !aiTerrainMgr.CanTraverse(u.circuitDef, u.GetPos(ai.frame), e.site)) why = "cannot reach";
            if (why != "") { ++skipped; if (skipped <= 4) skips += (skips == "" ? "" : ", ") + u.circuitDef.GetName() + " " + u.id + " " + why; continue; }
            if (!aiMilitaryMgr.TransferUnit(u, task)) continue;
            s.members.insertLast(u.id);
            memberOf.set(keys[i], s.serial);
            if (!s.finalDone) ++s.joined;
            u.SetFireState(2);
            ++sent;
            GenericHelpers::LogUtil(Tag() + " squad " + s.serial + ": heavy " + u.circuitDef.GetName() + " " + u.id
                + " sent to (" + int(e.site.x) + "," + int(e.site.z) + ") (" + s.members.length() + ")", 1);
        }
        if (skipped > 0)
            GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + ": " + skipped + " heavy(s) kept back: " + skips, 1);
        return sent;
    }

    // Factory::AiMakeTask (FRONT and TECH, before the gantry's normal providers): a T3 recruit, or null.
    IUnitTask@ GantryMakeTask(CCircuitUnit@ f)
    {
        if (!Enabled() || !T3Enabled() || !Answers() || emergencies.getSize() == 0) return null;
        if (!StandingGantry(f)) return null;
        Emergency@ e = ActiveFor(f.GetPos(ai.frame));
        if (e is null) return null;
        const array<string>@ names = @Global::RoleSettings::Front::AirEmergencyDefenseT3Units;
        CCircuitDef@ def = null;
        for (uint n = 0; n < names.length() && def is null; ++n) {
            CCircuitDef@ d = ai.GetCircuitDef(names[n]);
            if (d is null || !f.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) continue;
            if (!Reachable(e, f, d)) continue;
            @def = d;
        }
        if (def is null) return null;
        if (Join(e) is null) return null;
        IUnitTask@ task = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH,
            def, f.GetPos(ai.frame), 64.f), true);
        if (task is null) return null;
        const string key = "" + f.id;
        int prior = -1, count = 0;
        if (owed.get(key, prior) && prior == e.serial) owedCount.get(key, count); else count = 0;
        owed.set(key, e.serial); owedCount.set(key, count + 1);
        GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + ": gantry " + f.circuitDef.GetName() + " " + f.id
            + " makes " + def.GetName(), 1);
        return task;
    }

    // Stop answering and tell every FRONT; the next nearest one takes it.
    void Decline(Emergency@ e, const string &in why)
    {
        e.mine = false; e.handedOver = true;
        if (e.passed.find(ai.teamId) < 0) e.passed.insertLast(ai.teamId);
        Squad@ s = SquadBySerial(e.serial);
        if (s !is null) { s.patrolOnly = true; if (s.endFrame < 0) s.endFrame = ai.frame; }
        if (!IsTech()) AiSendMessage(MSG + "|pass|" + e.airTeam + "|" + int(e.site.x) + "|" + int(e.site.z));   // FRONT hand-off only
        GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + " at (" + int(e.site.x) + "," + int(e.site.z)
            + (IsTech() ? ") dropped: " : ") passed on: ") + why + (s is null ? "" : "; squad " + s.members.length() + " units left on patrol"), 1);
    }

    // airemg|pass|<air team>|x|z from a FRONT that cannot answer
    void Passed(const array<string>@ p, int fromTeamId)
    {
        if (p.length() < 5) return;
        Emergency@ e = null;
        if (!emergencies.get(p[2], @e) || e is null || !Live(e)) return;
        const AIFloat3 site(float(parseInt(p[3])), 0.0f, float(parseInt(p[4])));
        const float far = Global::RoleSettings::Front::AirEmergencyDefenseNewSite;
        if (MapHelpers::SqDist(site, e.site) > far * far) return;   // an older spot of that AIR
        if (e.passed.find(fromTeamId) < 0) e.passed.insertLast(fromTeamId);
        if (fromTeamId == ai.teamId || e.mine || e.handedOver || e.timedOut) return;
        string picked;
        if (!Nearest(e.site, picked, e.passed)) return;
        e.mine = true; e.started = ai.frame;
        Answer(e, "team " + fromTeamId + " passed it on; nearest now " + picked);
    }

    // Can a fast-defense unit from one of this FRONT's labs get to the spot?
    // Static movement-area test per unit def (cached on the emergency): the spot,
    // or a point ReachRadius around it, in the same area as the lab. O(labs x
    // defs x 9) area lookups once per emergency, no path query.
    const float ReachRadius = 300.0f;
    bool Reachable(Emergency@ e, CCircuitUnit@ lab, CCircuitDef@ d)
    {
        bool ok = false;
        if (e.reach.get(d.GetName(), ok)) return ok;
        const AIFloat3 from = lab.GetPos(ai.frame);
        ok = aiTerrainMgr.CanTraverse(d, from, e.site);
        for (int k = 0; k < 8 && !ok; ++k) {
            const float a = float(k) * 0.785398f;
            AIFloat3 p = e.site;
            p.x = AiMax(16.0f, AiMin(float(AiTerrainWidth()) - 16.0f, p.x + cos(a) * ReachRadius));
            p.z = AiMax(16.0f, AiMin(float(AiTerrainHeight()) - 16.0f, p.z + sin(a) * ReachRadius));
            ok = aiTerrainMgr.CanTraverse(d, from, p);
        }
        e.reach.set(d.GetName(), ok);
        return ok;
    }

    bool EmergencyLab(CCircuitUnit@ f)
    {
        if (f is null || f.circuitDef is null || Lifecycle::IsRetiring(f) || EdgeLanes::IsEdgeLab(f)) return false;
        const string n = f.circuitDef.GetName();
        return UnitHelpers::IsT1BotLab(n) || UnitHelpers::IsT1VehicleLab(n) || UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT2VehicleLab(n);
    }

    bool CanHelp(Emergency@ e, string &out why)
    {
        const array<string>@ names = @Global::RoleSettings::Front::AirEmergencyDefenseUnits;
        int labs = 0, cant = 0;
        string ok = "";
        for (uint i = 0; i < Factory::factoryList.length(); ++i) {
            CCircuitUnit@ f = Factory::factoryList[i];
            if (!EmergencyLab(f)) continue;
            bool any = false, buildable = false;
            for (uint n = 0; n < names.length() && !any; ++n) {
                CCircuitDef@ d = ai.GetCircuitDef(names[n]);
                if (d is null || !f.circuitDef.CanBuild(d)) continue;
                buildable = true;
                any = Reachable(e, f, d);
            }
            if (!buildable) continue;
            ++labs;
            if (any) ok += (ok == "" ? "" : ",") + f.circuitDef.GetName(); else ++cant;
        }
        if (labs == 0) { why = "no T1/T2 land lab"; return false; }
        if (ok == "") { why = "no unit from its " + labs + " lab(s) can reach the spot"; return false; }
        why = "reach from " + ok + (cant > 0 ? " (" + cant + " lab(s) cannot reach)" : "");
        return true;
    }

    bool HandleMessage(const string &in msg, int fromTeamId)
    {
        array<string>@ p = msg.split("|");
        if (p.length() < 2 || p[0] != MSG) return false;
        if (!Enabled() || !Answers()) return true;
        if (p[1] == "pass") { if (!IsTech()) Passed(p, fromTeamId); return true; }
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
            e.airTeam = fromTeamId; e.serial = nextSerial++; e.site = site; e.lastOn = ai.frame; e.started = ai.frame;
            string picked;
            e.mine = IsTech() ? TechTakes(site, picked) : Nearest(site, picked, e.passed);
            emergencies.set(key, @e);
            GenericHelpers::LogUtil(Tag() + " AIR team " + fromTeamId + " emergency " + e.serial + " at ("
                + int(site.x) + "," + int(site.z) + "): " + (IsTech() ? picked : "nearest FRONTs " + picked)
                + (e.mine ? (IsTech() ? " - this TECH answers" : " - this FRONT answers") : (IsTech() ? " - not this TECH" : " - not this FRONT")), 1);
            if (e.mine) Answer(e, "");
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
            GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + " reuses squad " + old.serial
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
        s.groups = 0; s.rallyAt = AIFloat3(-1.0f, 0.0f, -1.0f);   // re-picked (and the rally re-routed) on the next big join
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
            GenericHelpers::LogUtil(Tag() + "[Report] squad " + s.serial + ": first unit at the spot +"
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
        GenericHelpers::LogUtil(Tag() + "[Report] final squad " + s.serial + " AIR team " + s.airTeam
            + " at (" + int(s.site.x) + "," + int(s.site.z) + "): emergency " + (end - s.startFrame) / SECOND + " s"
            + ", first arrival " + (s.firstArrival < 0 ? "never" : ("+" + (s.firstArrival - s.startFrame) / SECOND + " s"))
            + ", joined " + s.joined + ", lost " + s.lost + ", alive " + s.members.length() + ", at spot " + s.arrived
            + ", enemy metal start " + int(s.enemyStart) + " peak " + int(s.enemyPeak) + " now " + int(s.enemyNow)
            + ", cleared " + (cleared ? "yes" : "no") + ", groups " + s.groups, 1);
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
            ReleaseGroup(s);
            // owner 2026-11-14: units out but none ever got to the spot (terrain the static test missed): pass it on
            // (not TECH: its heavies walk far and slowly, and TECH has no hand-off)
            if (!IsTech() && !s.patrolOnly && s.firstArrival < 0 && s.joined >= Global::RoleSettings::Front::AirEmergencyDefenseStuckUnits
                && ai.frame - s.startFrame >= AiMax(1, Global::RoleSettings::Front::AirEmergencyDefenseStuckSeconds) * SECOND) {
                Emergency@ e = EmergencyBySerial(s.serial);
                if (e !is null && e.mine && !e.over)
                    Decline(e, s.joined + " units sent, none reached the spot in " + (ai.frame - s.startFrame) / SECOND + " s");
            }
            if (s.endFrame >= 0 && ai.frame - s.endFrame >= ReportAfterSeconds * SECOND) { Final(s); continue; }
            if (s.endFrame < 0 && ai.frame - s.lastReport >= ReportEverySeconds * SECOND) {
                s.lastReport = ai.frame;
                GenericHelpers::LogUtil(Tag() + "[Report] squad " + s.serial + " +" + (ai.frame - s.startFrame) / SECOND
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
                if (u is null || (u.task !is s.task && (s.rally is null || u.task !is s.rally))) {
                    memberOf.delete("" + s.members[k]); s.members.removeAt(k);
                }
            }
        }
        // finished squads with nobody left go; over the cap, the oldest finished
        // ones are forgotten (their units keep patrolling on their own task)
        for (int i = int(squads.length()) - 1; i >= 0; --i) {
            Squad@ s = squads[i];
            if (s !is null && (!s.finalDone || !(s.patrolOnly && s.members.length() == 0))) continue;
            if (s !is null && s.task !is null && !s.task.IsDead()) s.task.Abort();
            if (s !is null && s.rally !is null && !s.rally.IsDead()) s.rally.Abort();
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
            if (!emergencies.get(keys[i], @e) || e is null || !e.mine || !Live(e) || e.timedOut) continue;
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
            if (!Reachable(e, f, d)) continue;   // owner 2026-11-14: e.g. vehicles below a bot-only plateau
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
        GenericHelpers::LogUtil(Tag() + " emergency " + e.serial + ": " + fname + " " + f.id
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
            const string uname = u.circuitDef.GetName();
            if (Global::RoleSettings::Front::AirEmergencyDefenseUnits.find(uname) < 0
                && Global::RoleSettings::Front::AirEmergencyDefenseT3Units.find(uname) < 0) return null;
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
            // a big attack: wait for the group at the rally point
            const bool big = !s.patrolOnly && s.enemyPeak >= Global::RoleSettings::Front::AirEmergencyDefenseGroupMetal;
            CRouteTask@ rally = big ? EnsureRally(s) : null;
            if (rally !is null) {
                if (s.waiting.length() == 0) s.waitSince = ai.frame;
                s.waiting.insertLast(u.id);
            }
            GenericHelpers::LogUtil(Tag() + " squad " + s.serial + ": " + u.circuitDef.GetName() + " " + u.id
                + " joins (" + s.members.length() + ")" + (s.patrolOnly ? ", emergency over: straight to patrol"
                : (rally !is null ? ", big attack (" + int(s.enemyPeak) + " metal): waits at the rally, " + s.waiting.length() + " waiting" : "")), 1);
        }
        if (s.waiting.find(u.id) >= 0) {
            CRouteTask@ rally = EnsureRally(s);
            if (rally !is null) return rally;
            s.waiting.removeAt(s.waiting.find(u.id));
        }
        return task;
    }

    // The rally point: GroupRally short of the spot toward this FRONT's start (at most 60% of the way).
    CRouteTask@ EnsureRally(Squad@ s)
    {
        if (s is null) return null;
        if (s.rallyAt.x < 0.0f) {
            const AIFloat3 home = Global::Map::StartPos;
            const float d = sqrt(MapHelpers::SqDist(s.site, home));
            const float a = AiMin(Global::RoleSettings::Front::AirEmergencyDefenseGroupRally, d * 0.6f);
            AIFloat3 p = s.site;
            if (d > 1.0f) { p.x += (home.x - s.site.x) / d * a; p.z += (home.z - s.site.z) / d * a; }
            p.x = AiMax(64.0f, AiMin(float(AiTerrainWidth()) - 64.0f, p.x));
            p.z = AiMax(64.0f, AiMin(float(AiTerrainHeight()) - 64.0f, p.z));
            s.rallyAt = p;
            if (s.rally !is null && !s.rally.IsDead()) { array<AIFloat3> pts = {p}; s.rally.SetRoute(pts); }
        }
        if (s.rally !is null && !s.rally.IsDead()) return s.rally;
        @s.rally = cast<CRouteTask>(cast<IFighterTask>(aiMilitaryMgr.Enqueue(TaskF::Route())));
        if (s.rally is null) return null;
        s.rally.SetTraversal(false, 96.0f, false);
        s.rally.SetLanes(5, 80.0f, 1.0f);
        array<AIFloat3> pts = {s.rallyAt};
        s.rally.SetRoute(pts);
        return s.rally;
    }

    // Tick: send the waiting group in once it is assembled and strong enough,
    // after GroupMaxWaitSeconds, or when the emergency is over.
    void ReleaseGroup(Squad@ s)
    {
        if (s is null || s.waiting.length() == 0) return;
        int assembled = 0;
        float metal = 0.0f;
        const float r = Global::RoleSettings::Front::AirEmergencyDefenseGroupRadius;
        for (int k = int(s.waiting.length()) - 1; k >= 0; --k) {
            CCircuitUnit@ u = ai.GetTeamUnit(s.waiting[k]);
            if (u is null || s.rally is null || u.task !is s.rally) { s.waiting.removeAt(k); continue; }
            if (MapHelpers::SqDist(u.GetPos(ai.frame), s.rallyAt) <= r * r) { ++assembled; metal += u.circuitDef.costM; }
        }
        if (s.waiting.length() == 0) { s.waitSince = -1; return; }
        const int age = ai.frame - s.waitSince;
        string why = "";
        if (s.patrolOnly) why = "emergency over";
        else if (age >= AiMax(1, Global::RoleSettings::Front::AirEmergencyDefenseGroupMaxWaitSeconds) * SECOND) why = "deadline";
        else if (assembled >= Global::RoleSettings::Front::AirEmergencyDefenseGroupMin
            && metal >= Global::RoleSettings::Front::AirEmergencyDefenseGroupCostRatio * s.enemyNow) why = "assembled";
        if (why == "") return;
        CRouteTask@ task = EnsureTask(s);
        if (task is null) return;
        int sent = 0;
        for (uint k = 0; k < s.waiting.length(); ++k) {
            CCircuitUnit@ u = ai.GetTeamUnit(s.waiting[k]);
            if (u !is null && aiMilitaryMgr.TransferUnit(u, task)) ++sent;
        }
        s.waiting.resize(0); s.waitSince = -1;
        if (sent > 0) ++s.groups;
        GenericHelpers::LogUtil(Tag() + " squad " + s.serial + ": group " + s.groups + " of " + sent
            + " goes in (" + assembled + " at the rally, " + int(metal) + " metal vs enemy " + int(s.enemyNow)
            + ", waited " + age / SECOND + " s, " + why + ")", 1);
    }

    void UnitRemoved(CCircuitUnit@ u)
    {
        if (u !is null && heavyIds.getSize() > 0) heavyIds.delete("" + u.id);
        if (u is null || memberOf.getSize() == 0) return;
        const string ukey = "" + u.id;
        int serial = -1;
        if (!memberOf.get(ukey, serial)) return;
        memberOf.delete(ukey);
        Squad@ s = SquadBySerial(serial);
        if (s is null) return;
        const int k = s.members.find(u.id);
        if (k >= 0) { s.members.removeAt(k); if (!s.finalDone) ++s.lost; }
        const int w = s.waiting.find(u.id);
        if (w >= 0) s.waiting.removeAt(w);
    }
}
