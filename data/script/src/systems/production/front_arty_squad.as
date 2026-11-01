// Owner (2026-10-20): FRONT T2 artillery squad. On the T2 vehicle plant's roll (FrontTankMass), a
// VehicleT2ArtySquadChance hit (instead of the Bull/Tiger/Prometheus wave) queues one faction squad:
//   Armada: 1 Starlight (lead), 2 Bulls, 3 Mausers, 1 Ambassador, 1 Umbra, 1 Prophet, 1 Shredder
//   Cortex: 2 Quakers (lead), 3 Banishers, 1 Negotiator, 1 Obscurer, 1 Omen, 1 Fury
//   Legion: 3 Cleavers (lead), 2 Prometheus, 2 Medusas, 1 Boreas, 1 Cicero, 1 Pheme, 1 Charon (owner, 2026-10-20)
// A faction's bots, if any are listed, come from a finished T2 bot lab of ours; without one the
// roll becomes a normal tank wave. Every member is enumerated as it comes out and held at the plant
// until the squad is complete (or ArtySquadGatherSeconds pass). Then the lead unit (the first living
// member of the lead type, else the longest-ranged member) walks toward the nearest known enemy and
// stops once that enemy is inside ArtySquadRangeFraction of its range, never closing further; it also
// waits for members straggling past ArtySquadCohesion. Everyone else follows ArtySquadFollowBehind
// behind it. All members are on hold position and fire at will, so they shoot what comes into range
// without chasing. Only units made by the squad's own plant (or its bot lab) are claimed; a member pulled
// onto another task (not retreat or player) is put back on the squad's route, and only members on the
// squad's routes count for cohesion. The lead waits at most ArtySquadStragglerSeconds, then advances anyway.
// Escorts (jammer, radar, AA) never lead. Hooks as FrontWaveEscort; log [FRONT][ArtySquad].
// Owner (2026-10-31): T2 bot lab squads, all from one finished T2 bot lab (BotRoll, called from that lab's
// MakeTask). While a lab stands, every T2BotSquadIntervalSeconds, T2BotSquadChance for one squad, the heavy
// or the artillery one (T2BotSquadArtyShare), each with a radar bot, two jammer bots and a flak bot:
//   Armada heavy: 2 Fatboy, 3 Welder, 2 Gunslinger        Armada arty: 2 Fatboy, 4 Sharpshooter, 1 Welder
//   Cortex heavy: 5 Mammoth                              Cortex arty: 10 Sheldon, 3 Sumo
//   Legion heavy: 3 Incinerator                          Legion arty: 5 Arquebus, 5 Thanatos, 3 Hoplite, 1 Incinerator
//   support: Armada Compass/2 Smuggler/Archangel, Cortex Augur/2 Deceiver/Manticore, Legion Euclid/2 Tiresias/Aquilon
// Owner (2026-11-01): Armada light artillery bot squad, T2BotSquadLightShare of Armada's artillery rolls:
//   3 Gunslinger, 5 Recluse, with a Compass, 2 Smugglers and 2 Archangels
// They move and fight as the vehicle squad, except the lead is the longest-ranged member (ties: the slowest),
// and the squad keeps the slowest member's pace through the cohesion wait. Log [FRONT][ArtySquad] ... bot squad.
namespace FrontArtySquad {
    const int OPEN = 2;
    class Squad {
        int id;
        int factoryId;
        int botLabId;
        int started;
        int deadline;
        int leadDefId;          // -1: the longest-ranged member leads (bot squads)
        string label;           // "artillery squad" or "<kind> bot squad", for the log
        array<int> slots;       // def ids still to come out
        array<int> members;
        array<int> fireSent;    // frame each member last got fire at will, parallel to members
        array<int> joined;      // frame each member joined, parallel to members (survival log)
        array<AIFloat3> slotSent;   // slot last sent to the member's own route, parallel to members (x < 0: none)
        bool leadHeavy;         // no artillery left: a heavy leads and the screen route is unused
        int leader;
        bool released;
        CRouteTask@ leadRoute;
        CRouteTask@ followRoute;
        CRouteTask@ frontRoute;     // heavies and anti-spam, ArtySquadHeavyAhead in front of the lead
        AIFloat3 frontGoal;
        AIFloat3 leadGoal;
        AIFloat3 followGoal;
        int nextLog;
        int waitSince;          // frame the lead began waiting for stragglers, -1 when not waiting
        int paceSince;          // frame the lead began pacing for a member short of its place, -1 when not
    }
    array<Squad@> squads;
    int nextSquadId = 1;
    int nextUpdate = 0;

    bool Enabled() { return Global::RoleSettings::Front::VehicleT2ArtySquadChance > 0.0f; }

    bool IsEscort(const string &in n) {
        return n == "armjam" || n == "armseer" || n == "armyork" || n == "coreter" || n == "corvrad" || n == "corsent"
            || n == "legavjam" || n == "legavrad" || n == "legvflak"
            // T2 bot lab support (owner, 2026-10-31): radar, jammer, flak bots
            || n == "armmark" || n == "armaser" || n == "armaak" || n == "corvoyr" || n == "corspec" || n == "coraak"
            || n == "legaradk" || n == "legajamk" || n == "legadvaabot";
    }

    // Owner (2026-10-31): heavies and anti-spam screen in front of the artillery
    bool IsHeavy(const string &in n) {
        return n == "armfboy" || n == "armbull" || n == "leginc" || n == "legaheattank" || n == "legstr" || n == "armmav"
            || n == "armzeus" || n == "correap" || n == "corsumo" || n == "corcan";
    }

    string ClassOf(const string &in n) {
        if (IsEscort(n)) return "support";
        return IsHeavy(n) ? "heavy" : "arty";
    }

    bool BotEnabled() { return Global::RoleSettings::Front::T2BotSquadChance > 0.0f; }

    // Owner (2026-10-31): T2 bot lab squads; arty false = the heavy squad, light (Armada) = the light artillery
    // squad. Unit ids from Beyond-All-Reason unitdefs.
    array<string> BotComposition(const string &in side, bool arty, bool light = false) {
        array<string> n;
        array<string> support;
        if (side == "armada") {
            support = array<string> = {"armmark", "armaser", "armaser", "armaak"};   // Compass, 2 Smuggler, Archangel
            if (arty && light) {
                support.insertLast("armaak");                                         // a second Archangel
                for (int i = 0; i < 3; ++i) n.insertLast("armmav");                   // Gunslinger
                for (int i = 0; i < 5; ++i) n.insertLast("armsptk");                  // Recluse
            } else if (arty) n = array<string> = {"armfboy", "armfboy", "armsnipe", "armsnipe", "armsnipe", "armsnipe", "armzeus"};
            else n = array<string> = {"armfboy", "armfboy", "armzeus", "armzeus", "armzeus", "armmav", "armmav"};   // Fatboy, Welder, Gunslinger
        } else if (side == "cortex") {
            support = array<string> = {"corvoyr", "corspec", "corspec", "coraak"};   // Augur, 2 Deceiver, Manticore
            if (arty) {
                for (int i = 0; i < 10; ++i) n.insertLast("cormort");                 // Sheldon
                for (int i = 0; i < 3; ++i) n.insertLast("corcan");                   // Sumo (corcan's BAR name)
            } else {
                for (int i = 0; i < 5; ++i) n.insertLast("corsumo");                  // Mammoth
            }
        } else if (side == "legion") {
            support = array<string> = {"legaradk", "legajamk", "legajamk", "legadvaabot"};   // Euclid, 2 Tiresias, Aquilon
            if (arty) {
                for (int i = 0; i < 5; ++i) n.insertLast("legsrail");                 // Arquebus
                for (int i = 0; i < 5; ++i) n.insertLast("leghrk");                   // Thanatos
                for (int i = 0; i < 3; ++i) n.insertLast("legstr");                   // Hoplite
                n.insertLast("leginc");                                               // Incinerator
            } else {
                for (int i = 0; i < 3; ++i) n.insertLast("leginc");                   // Incinerator
            }
        } else return n;
        // support first, so it is out before the main units and the squad leaves together
        array<string> all = support;
        for (uint i = 0; i < n.length(); ++i) all.insertLast(n[i]);
        return all;
    }

    int nextBotRoll = -1;

    bool BotGathering() {
        for (uint i = 0; i < squads.length(); ++i)
            if (squads[i].botLabId >= 0 && squads[i].botLabId == squads[i].factoryId && !squads[i].released) return true;
        return false;
    }

    // T2 bot lab MakeTask (FRONT): every T2BotSquadIntervalSeconds while a finished T2 bot lab stands,
    // T2BotSquadChance for one squad; returns the lab's first recruit, or null
    IUnitTask@ BotRoll(CCircuitUnit@ u, const string &in side) {
        if (!BotEnabled() || u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f) return null;
        const int interval = AiMax(1, Global::RoleSettings::Front::T2BotSquadIntervalSeconds) * SECOND;
        if (nextBotRoll < 0) {
            nextBotRoll = ai.frame + interval;
            GenericHelpers::LogUtil("[FRONT][ArtySquad] T2 bot lab " + u.id + " stands: first bot squad roll at " + (nextBotRoll / SECOND) + " s", 1);
            return null;
        }
        if (ai.frame < nextBotRoll || BotGathering()) return null;   // one bot squad gathers at a time
        nextBotRoll = ai.frame + interval;
        const float chance = AiMin(1.0f, Global::RoleSettings::Front::T2BotSquadChance);
        // AiDice's rare -1 endpoint counts as a miss (KI-628)
        const array<float> hit = {AiMax(0.0f, 1.0f - chance), chance};
        if (chance < 1.0f && AiDice(hit) != 1) {
            GenericHelpers::LogUtil("[FRONT][ArtySquad] bot squad roll missed at lab " + u.id + "; next at " + (nextBotRoll / SECOND) + " s", 1);
            return null;
        }
        const float share = AiMax(0.0f, AiMin(1.0f, Global::RoleSettings::Front::T2BotSquadArtyShare));
        const array<float> kind = {1.0f - share, share};
        const bool arty = AiDice(kind) == 1;
        bool light = false;
        if (arty && side == "armada") {   // only Armada has a light artillery squad (owner, 2026-11-01)
            const float ls = AiMax(0.0f, AiMin(1.0f, Global::RoleSettings::Front::T2BotSquadLightShare));
            const array<float> lk = {1.0f - ls, ls};
            light = AiDice(lk) == 1;
        }
        IUnitTask@ first = Queue(u, null, side, BotComposition(side, arty, light), -1,
            light ? "light artillery bot squad" : (arty ? "artillery bot squad" : "heavy bot squad"),
            Global::RoleSettings::Front::T2BotSquadGatherSeconds);
        if (first !is null) GenericHelpers::LogUtil("[FRONT][ArtySquad] bot squad roll hit at lab " + u.id + "; next at " + (nextBotRoll / SECOND) + " s", 1);
        return first;
    }

    // Queue a squad's members at lab u (and optional botLab); returns u's first recruit, null when nothing is buildable
    IUnitTask@ Queue(CCircuitUnit@ u, CCircuitUnit@ botLab, const string &in side, const array<string> &in names,
                     int leadDefId, const string &in label, int gatherSeconds) {
        Squad@ s = Squad();
        s.id = nextSquadId++; s.factoryId = u.id; s.started = ai.frame; s.leadDefId = leadDefId; s.label = label;
        s.deadline = ai.frame + AiMax(1, gatherSeconds) * SECOND;
        s.leader = -1; s.released = false; s.nextLog = 0; s.waitSince = -1; s.paceSince = -1;
        s.botLabId = botLab is null ? (leadDefId < 0 ? u.id : -1) : botLab.id;
        s.leadGoal = u.GetPos(ai.frame); s.followGoal = s.leadGoal; s.frontGoal = s.leadGoal; s.leadHeavy = false;
        string queued = "", skipped = "";
        IUnitTask@ first = null;
        const AIFloat3 pos = u.GetPos(ai.frame);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(names[i]);
            if (def is null || !u.circuitDef.CanBuild(def) || !def.IsAvailable(ai.frame)) {
                skipped += (skipped == "" ? "" : ", ") + names[i];
                continue;
            }
            IUnitTask@ r = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, def, pos, 64.f));
            if (r is null) { skipped += (skipped == "" ? "" : ", ") + names[i]; continue; }
            if (first is null) @first = r;
            s.slots.insertLast(def.id);
            queued += (queued == "" ? "" : ", ") + names[i];
        }
        if (first is null) {
            GenericHelpers::LogUtil("[FRONT][ArtySquad] no " + label + " member buildable at factory " + u.id
                + (skipped == "" ? "" : " (" + skipped + ")"), 1);
            return null;
        }
        squads.insertLast(s);
        GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + " (" + label + ") at factory " + u.id + " (" + side + "): queued " + queued
            + (skipped == "" ? "" : "; unavailable " + skipped), 1);
        return first;
    }

    // [lead, ...rest] from the vehicle plant; bots (Legion) from a T2 bot lab
    void Composition(const string &in side, array<string> &out vehicles, array<string> &out bots, string &out lead) {
        vehicles.resize(0); bots.resize(0);
        if (side == "armada") {
            lead = "armmanni";
            vehicles = array<string> = {"armmanni", "armbull", "armbull", "armmart", "armmart", "armmart", "armmerl", "armjam", "armseer", "armyork"};
        } else if (side == "cortex") {
            lead = "cormart";
            vehicles = array<string> = {"cormart", "cormart", "corban", "corban", "corban", "corvroc", "coreter", "corvrad", "corsent"};
        } else if (side == "legion") {
            lead = "legamcluster";
            vehicles = array<string> = {"legamcluster", "legamcluster", "legamcluster", "legaheattank", "legaheattank", "legmed", "legmed", "legavroc", "legavjam", "legavrad", "legvflak"};
        } else lead = "";
    }

    CCircuitUnit@ FinishedLab(const string &in name) {
        array<string>@ keys = Factory::allFactories.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null || f.GetBuildProgress() < 1.0f) continue;
            if (f.circuitDef.GetName() == name) return f;
        }
        return null;
    }

    bool Gathering(int factoryId) {
        for (uint i = 0; i < squads.length(); ++i)
            if (squads[i].factoryId == factoryId && !squads[i].released) return true;
        return false;
    }

    // Queue the squad at plant u; returns the plant's first recruit, null when the squad can't be built
    IUnitTask@ Begin(CCircuitUnit@ u, const string &in side, int gatherSeconds) {
        if (!Enabled() || u is null || u.circuitDef is null) return null;
        array<string> vehicles, bots; string lead;
        Composition(side, vehicles, bots, lead);
        CCircuitDef@ leadDef = ai.GetCircuitDef(lead);
        if (leadDef is null || vehicles.length() == 0) return null;
        CCircuitUnit@ botLab = null;
        if (bots.length() > 0) {
            @botLab = FinishedLab(side == "legion" ? "legalab" : "");
            if (botLab is null) {
                GenericHelpers::LogUtil("[FRONT][ArtySquad] " + side + " squad needs a finished T2 bot lab; none, rolling a tank wave instead", 1);
                return null;
            }
        }
        Squad@ s = Squad();
        s.id = nextSquadId++; s.factoryId = u.id; s.started = ai.frame; s.leadDefId = leadDef.id; s.label = "artillery squad";
        s.deadline = ai.frame + AiMax(1, gatherSeconds) * SECOND;
        s.leader = -1; s.released = false; s.nextLog = 0; s.waitSince = -1; s.paceSince = -1;
        s.botLabId = botLab is null ? -1 : botLab.id;
        s.leadGoal = u.GetPos(ai.frame); s.followGoal = s.leadGoal; s.frontGoal = s.leadGoal; s.leadHeavy = false;
        string queued = "", skipped = "";
        IUnitTask@ first = null;
        array<string> names;
        array<bool> fromBotLab;
        for (uint i = 0; i < bots.length(); ++i) { names.insertLast(bots[i]); fromBotLab.insertLast(true); }
        for (uint i = 0; i < vehicles.length(); ++i) { names.insertLast(vehicles[i]); fromBotLab.insertLast(false); }
        {
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitUnit@ lab = fromBotLab[i] ? botLab : u;
                if (lab is null) continue;
                const AIFloat3 pos = lab.GetPos(ai.frame);
                CCircuitDef@ def = ai.GetCircuitDef(names[i]);
                if (def is null || !lab.circuitDef.CanBuild(def) || !def.IsAvailable(ai.frame)) {
                    skipped += (skipped == "" ? "" : ", ") + names[i];
                    continue;
                }
                IUnitTask@ r = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, def, pos, 64.f));
                if (r is null) { skipped += (skipped == "" ? "" : ", ") + names[i]; continue; }
                if (first is null && lab is u) @first = r;
                s.slots.insertLast(def.id);
                queued += (queued == "" ? "" : ", ") + names[i];
            }
        }
        if (first is null) {
            GenericHelpers::LogUtil("[FRONT][ArtySquad] no squad vehicle buildable at factory " + u.id + "; rolling a tank wave instead", 1);
            return null;
        }
        if (s.slots.find(leadDef.id) < 0) {
            GenericHelpers::LogUtil("[FRONT][ArtySquad] squad lead '" + lead + "' unavailable at roll; members queued anyway: " + queued, 1);
        }
        squads.insertLast(s);
        GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + " at factory " + u.id + " (" + side + "): queued " + queued
            + (skipped == "" ? "" : "; unavailable " + skipped), 1);
        return first;
    }

    // Military UnitAdded: enumerate a squad member (returns true when claimed)
    bool UnitAdded(CCircuitUnit@ unit) {
        if (unit is null || unit.circuitDef is null) return false;
        for (uint i = 0; i < squads.length(); ++i) {
            Squad@ s = squads[i];
            if (s.members.find(unit.id) >= 0) return true;
            if (s.released || unit.GetProductionFrame() < s.started) continue;
            const int producer = unit.GetProducerId();
            if (producer != s.factoryId && (s.botLabId < 0 || producer != s.botLabId)) continue;
            const int slot = s.slots.find(unit.circuitDef.id);
            if (slot < 0) continue;
            s.slots.removeAt(slot);
            s.members.insertLast(unit.id); s.fireSent.insertLast(-100000); s.joined.insertLast(ai.frame);
            s.slotSent.insertLast(AIFloat3(-1.0f, 0.0f, -1.0f));
            GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + ": member " + s.members.length() + " " + unit.circuitDef.GetName()
                + " " + unit.id + " (" + ClassOf(unit.circuitDef.GetName()) + ")"
                + (s.slots.length() == 0 ? "; squad complete" : ", " + s.slots.length() + " to come"), 1);
            return true;
        }
        return false;
    }

    Squad@ SquadOf(int unitId) {
        for (uint i = 0; i < squads.length(); ++i)
            if (squads[i].members.find(unitId) >= 0) return squads[i];
        return null;
    }

    CRouteTask@ NewRoute(const AIFloat3 &in at) {
        CRouteTask@ r = cast<CRouteTask>(cast<IFighterTask>(aiMilitaryMgr.Enqueue(TaskF::Route())));
        if (r is null) return null;
        r.SetTraversal(false, 96.0f, false);
        r.SetHoldPosition(true);   // never chase: they fire at will on what comes into range
        const array<AIFloat3> points = {at};
        r.SetRoute(points);
        return r;
    }

    void ForgetSlots(Squad@ s) {
        for (uint k = 0; k < s.slotSent.length(); ++k) s.slotSent[k] = AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    bool EnsureRoutes(Squad@ s) {
        if (s.leadRoute is null || s.leadRoute.IsDead()) @s.leadRoute = NewRoute(s.leadGoal);
        if (s.followRoute is null || s.followRoute.IsDead()) { @s.followRoute = NewRoute(s.followGoal); ForgetSlots(s); }
        if (s.frontRoute is null || s.frontRoute.IsDead()) { @s.frontRoute = NewRoute(s.frontGoal); ForgetSlots(s); }
        return s.leadRoute !is null && s.followRoute !is null && s.frontRoute !is null;
    }

    // The route a member belongs on: the lead's, the heavy screen's (ahead of an artillery lead), or the pack's
    IUnitTask@ WantedRoute(Squad@ s, CCircuitUnit@ m) {
        if (m.id == s.leader) return cast<IUnitTask>(s.leadRoute);
        if (!s.leadHeavy && m.circuitDef !is null && IsHeavy(m.circuitDef.GetName())) return cast<IUnitTask>(s.frontRoute);
        return cast<IUnitTask>(s.followRoute);
    }

    // Military MakeTask
    IUnitTask@ MilitaryTask(CCircuitUnit@ unit) {
        if (unit is null) return null;
        Squad@ s = SquadOf(unit.id);
        if (s is null || !EnsureRoutes(s)) return null;
        const int k = s.members.find(unit.id);
        if (k >= 0) { unit.SetFireState(OPEN); s.fireSent[k] = ai.frame; }
        return WantedRoute(s, unit);
    }

    void UnitRemoved(CCircuitUnit@ unit) {
        if (unit is null) return;
        for (uint i = 0; i < squads.length(); ++i) {
            const int k = squads[i].members.find(unit.id);
            if (k < 0) continue;
            Squad@ s = squads[i];
            const string n = unit.circuitDef is null ? "?" : unit.circuitDef.GetName();
            // test log (owner, 2026-10-31): survival of artillery vs heavies/anti-spam vs support
            GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + ": lost " + n + " " + unit.id + " (" + ClassOf(n) + ") after "
                + ((ai.frame - s.joined[k]) / SECOND) + " s" + (s.released ? " in the field" : " at the lab"), 1);
            s.members.removeAt(k); s.fireSent.removeAt(k); s.joined.removeAt(k); s.slotSent.removeAt(k);
            if (s.leader == unit.id) s.leader = -1;
            return;
        }
    }

    void TaskRemoved(IUnitTask@ task) {
        for (uint i = 0; i < squads.length(); ++i) {
            if (squads[i].leadRoute !is null && cast<IUnitTask>(squads[i].leadRoute) is task) @squads[i].leadRoute = null;
            if (squads[i].followRoute !is null && cast<IUnitTask>(squads[i].followRoute) is task) @squads[i].followRoute = null;
            if (squads[i].frontRoute !is null && cast<IUnitTask>(squads[i].frontRoute) is task) @squads[i].frontRoute = null;
        }
    }

    // "heavy N/M arty N/M support N/M" alive of joined so far
    string Census(Squad@ s) {
        int h = 0, a = 0, e = 0;
        for (uint k = 0; k < s.members.length(); ++k) {
            CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
            if (m is null || m.circuitDef is null) continue;
            const string c = ClassOf(m.circuitDef.GetName());
            if (c == "heavy") ++h; else if (c == "support") ++e; else ++a;
        }
        return "heavy " + h + ", arty " + a + ", support " + e;
    }

    void Release(uint index, const string &in why) {
        Squad@ s = squads[index];
        squads.removeAt(index);
        GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + " " + why + ": " + s.members.length() + " member(s) back to normal orders ("
            + Census(s) + ")", 1);
        if (s.leadRoute !is null && !s.leadRoute.IsDead()) s.leadRoute.Abort();
        if (s.followRoute !is null && !s.followRoute.IsDead()) s.followRoute.Abort();
        if (s.frontRoute !is null && !s.frontRoute.IsDead()) s.frontRoute.Abort();
    }

    // The nearest known enemy to `from` (ground contacts, else the nearest enemy group)
    bool NearestEnemy(const AIFloat3 &in from, AIFloat3 &out pos) {
        float best = -1.0f;
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            const float d = MapHelpers::SqDist(from, p);
            if (best < 0.0f || d < best) { best = d; pos = p; }
        }
        if (best >= 0.0f) return true;
        const AIFloat3 g = aiEnemyMgr.GetNearestGroupPos(from, 0.0f);
        if (g.x >= 0.0f) { pos = g; return true; }
        return false;
    }

    AIFloat3 Clamp(float x, float z) {
        const float m = 64.0f;
        return AIFloat3(AiMax(m, AiMin(float(AiTerrainWidth()) - m, x)), 0.0f, AiMax(m, AiMin(float(AiTerrainHeight()) - m, z)));
    }

    // Re-route r to goal once it moved repath from current; returns the route's goal
    AIFloat3 SetGoal(CRouteTask@ r, const AIFloat3 &in current, const AIFloat3 &in goal, float repath) {
        if (r is null || r.IsDead() || MapHelpers::SqDist(current, goal) < repath * repath) return current;
        const array<AIFloat3> points = {goal};
        r.SetRoute(points);
        return goal;
    }

    bool OnRoute(Squad@ s, CCircuitUnit@ m) {
        return m.task !is null && ((s.leadRoute !is null && cast<IUnitTask>(s.leadRoute) is m.task)
            || (s.followRoute !is null && cast<IUnitTask>(s.followRoute) is m.task)
            || (s.frontRoute !is null && cast<IUnitTask>(s.frontRoute) is m.task));
    }

    // Pick the lead: first living member of the lead type, else the longest-ranged artillery member (ties: the
    // slowest); heavies and anti-spam lead only a squad without artillery (owner, 2026-10-31)
    void ChooseLeader(Squad@ s) {
        int pick = -1; float range = -1.0f, speed = 0.0f; int rank = -1;   // rank 2 lead type, 1 artillery, 0 heavy
        for (uint k = 0; k < s.members.length(); ++k) {
            CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
            if (m is null || m.circuitDef is null || IsEscort(m.circuitDef.GetName())) continue;
            const int rk = m.circuitDef.id == s.leadDefId ? 2 : (IsHeavy(m.circuitDef.GetName()) ? 0 : 1);
            const float r = m.circuitDef.GetMaxRange();
            const float sp = m.circuitDef.GetSpeed();
            if (rk > rank || (rk == rank && (r > range || (r == range && sp < speed)))) {
                pick = m.id; range = r; speed = sp; rank = rk;
            }
        }
        s.leadHeavy = rank == 0;
        ForgetSlots(s);   // members change routes: every slot is re-sent
        if (pick == s.leader) return;
        s.leader = pick;
        CCircuitUnit@ l = ai.GetTeamUnit(pick);
        if (l is null || !EnsureRoutes(s)) return;
        // everyone on a squad route moves to the route of its place (the new lead takes the lead route)
        for (uint k = 0; k < s.members.length(); ++k) {
            CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
            if (m is null || !OnRoute(s, m)) continue;
            IUnitTask@ want = WantedRoute(s, m);
            if (m.task !is want) aiMilitaryMgr.TransferUnit(m, want);
        }
        GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + ": lead " + l.circuitDef.GetName() + " " + pick
            + " range " + int(l.circuitDef.GetMaxRange()) + (s.leadHeavy ? " (no artillery: heavies lead)" : ""), 1);
    }

    // Owner (2026-10-31): spacing. Each member's own place relative to the lead's goal, as (forward, side):
    // heavies in a line abreast ArtySquadHeavyAhead in front of the frontmost artillery or support place (the lead
    // counts at 0; owner 2026-11-01: 100-120 elmos ahead of artillery and utility), ArtySquadHeavySpacing apart; the other artillery
    // (and heavies when a heavy leads) on a ring of ArtySquadPackRadius over the sides and back (60..300 degrees,
    // a second ring 1.35x out for every other unit of a pack above 8); support on a ring of ArtySquadFollowBehind
    // behind (135..225 degrees). O(members) per update; a place is re-sent only once it moved ArtySquadRepath.
    void Places(Squad@ s, array<float> &out fo, array<float> &out so, float &out heavyLine) {
        const uint n = s.members.length();
        fo.resize(n); so.resize(n);
        int nh = 0, na = 0, ne = 0;
        array<int> cls(n);   // 0 front heavy, 1 pack, 2 support, -1 lead or gone
        for (uint k = 0; k < n; ++k) {
            fo[k] = 0.0f; so[k] = 0.0f; cls[k] = -1;
            CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
            if (m is null || m.circuitDef is null || m.id == s.leader) continue;
            const string nm = m.circuitDef.GetName();
            if (IsEscort(nm)) { cls[k] = 2; ++ne; }
            else if (!s.leadHeavy && IsHeavy(nm)) { cls[k] = 0; ++nh; }
            else { cls[k] = 1; ++na; }
        }
        const float ahead = Global::RoleSettings::Front::ArtySquadHeavyAhead;
        const float gap = Global::RoleSettings::Front::ArtySquadHeavySpacing;
        const float ring = Global::RoleSettings::Front::ArtySquadPackRadius;
        const float back = Global::RoleSettings::Front::ArtySquadFollowBehind;
        const float PI = 3.14159f;
        int ih = 0, ia = 0, ie = 0;
        float front = 0.0f;   // the frontmost artillery/support place (the lead at 0)
        for (uint k = 0; k < n; ++k) {
            if (cls[k] == 1) {
                const float a = PI * (1.0f / 3.0f + (4.0f / 3.0f) * (na > 1 ? float(ia) / float(na - 1) : 0.5f));
                const float r = ring * (na > 8 && (ia % 2) == 1 ? 1.35f : 1.0f);
                ++ia;
                fo[k] = cos(a) * r; so[k] = sin(a) * r;
            } else if (cls[k] == 2) {
                const float a = PI * (0.75f + 0.5f * (ne > 1 ? float(ie) / float(ne - 1) : 0.5f)); ++ie;
                fo[k] = cos(a) * back; so[k] = sin(a) * back;
            }
            if (cls[k] == 1 || cls[k] == 2) front = AiMax(front, fo[k]);
        }
        heavyLine = front + ahead;
        for (uint k = 0; k < n; ++k) {
            if (cls[k] != 0) continue;
            fo[k] = heavyLine; so[k] = (float(ih) - float(nh - 1) * 0.5f) * gap; ++ih;
        }
    }

    // Test log (owner, 2026-11-01): how far the rearmost heavy walks in front of the frontmost artillery/support
    // member, along the advance; -1 without both
    float HeavyGap(Squad@ s, CCircuitUnit@ l, float dx, float dz) {
        if (s.leadHeavy) return -1.0f;
        const AIFloat3 lp = l.GetPos(ai.frame);
        float heavy = 1e9f, back = 0.0f;   // the lead is artillery: it counts at 0
        bool any = false;
        for (uint k = 0; k < s.members.length(); ++k) {
            CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
            if (m is null || m.circuitDef is null || m.id == l.id || !OnRoute(s, m)) continue;
            const AIFloat3 mp = m.GetPos(ai.frame);
            const float f = (mp.x - lp.x) * dx + (mp.z - lp.z) * dz;
            if (IsHeavy(m.circuitDef.GetName())) { heavy = AiMin(heavy, f); any = true; }
            else back = AiMax(back, f);
        }
        return any ? heavy - back : -1.0f;
    }

    // AiUpdate
    // Owner (2026-10-31): formation. Heavies and anti-spam (IsHeavy) walk ArtySquadHeavyAhead in front of an
    // artillery lead to take the hits; the rest of the artillery and the support space out around it (Places). The lead (longest-ranged artillery) advances in steps of ArtySquadPaceStep, the next step only once every
    // member on the squad's routes is within ArtySquadPaceTolerance of its place, so the squad moves at its slowest
    // member's speed; it stops at ArtySquadRangeFraction of its range from the nearest known enemy.
    void Update() {
        if (squads.length() == 0 || ai.frame < nextUpdate) return;
        nextUpdate = ai.frame + AiMax(1, Global::RoleSettings::Front::ArtySquadUpdateSeconds) * SECOND;
        const int resend = 15 * SECOND;
        for (int i = int(squads.length()) - 1; i >= 0; --i) {
            Squad@ s = squads[i];
            // prune and keep everyone on fire at will
            int armed = 0;
            for (int k = int(s.members.length()) - 1; k >= 0; --k) {
                CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
                if (m is null) { s.members.removeAt(uint(k)); s.fireSent.removeAt(uint(k)); s.joined.removeAt(uint(k)); s.slotSent.removeAt(uint(k)); continue; }
                if (ai.frame - s.fireSent[k] >= resend) { m.SetFireState(OPEN); s.fireSent[k] = ai.frame; }
                if (!IsEscort(m.circuitDef.GetName())) ++armed;
            }
            if (!s.released) {
                if (s.slots.length() > 0 && ai.frame < s.deadline) continue;   // still gathering at the plant
                s.released = true;
                GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + " departs with " + s.members.length() + " member(s) ("
                    + Census(s) + ")" + (s.slots.length() > 0 ? " (" + s.slots.length() + " never came, gather deadline)" : ""), 1);
                s.slots.resize(0);
            }
            if (armed == 0) { Release(i, s.members.length() == 0 ? "was destroyed" : "lost its combat units"); continue; }
            if (s.leader < 0 || ai.GetTeamUnit(s.leader) is null) ChooseLeader(s);
            CCircuitUnit@ l = ai.GetTeamUnit(s.leader);
            if (l is null || !EnsureRoutes(s)) continue;
            if (!OnRoute(s, l) && l.task !is null && l.task.GetType() != int(Task::Type::PLAYER)
                && l.task.GetType() != int(Task::Type::RETREAT) && !l.task.IsExternalControlled())
                aiMilitaryMgr.TransferUnit(l, cast<IUnitTask>(s.leadRoute));
            const AIFloat3 lp = l.GetPos(ai.frame);
            AIFloat3 enemy;
            const bool known = NearestEnemy(lp, enemy);
            // advance direction: toward the enemy, else away from home
            float dx = known ? enemy.x - lp.x : lp.x - Global::Map::StartPos.x;
            float dz = known ? enemy.z - lp.z : lp.z - Global::Map::StartPos.z;
            float len = sqrt(dx * dx + dz * dz);
            if (len < 1.0f) { dx = 1.0f; dz = 0.0f; len = 1.0f; }
            dx /= len; dz /= len;
            array<float> fo, so;
            float heavyLine;
            Places(s, fo, so, heavyLine);
            // pace: how far behind its place (relative to the lead's goal) is the slowest member; a member another
            // controller took is put back on its route
            const float goalAhead = (s.leadGoal.x - lp.x) * dx + (s.leadGoal.z - lp.z) * dz;
            float lag = AiMax(0.0f, goalAhead);
            string lagName = l.circuitDef.GetName() + " " + l.id;
            float far = 0.0f;
            string farName = "";
            int pulled = 0;
            for (uint k = 0; k < s.members.length(); ++k) {
                CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
                if (m is null || m.id == l.id) continue;
                if (!OnRoute(s, m)) {
                    if (m.task is null || m.task.GetType() == int(Task::Type::PLAYER)
                        || m.task.GetType() == int(Task::Type::RETREAT) || m.task.IsExternalControlled()) continue;
                    if (aiMilitaryMgr.TransferUnit(m, WantedRoute(s, m))) { ++pulled; s.slotSent[k] = AIFloat3(-1.0f, 0.0f, -1.0f); }
                    continue;
                }
                const AIFloat3 mp = m.GetPos(ai.frame);
                const float d = lp.distance2D(mp);
                if (d > far) { far = d; farName = m.circuitDef.GetName() + " " + m.id; }
                const float place = goalAhead + fo[k];
                const float behind = place - ((mp.x - lp.x) * dx + (mp.z - lp.z) * dz);
                if (behind > lag) { lag = behind; lagName = m.circuitDef.GetName() + " " + m.id; }
            }
            if (pulled > 0) GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + ": " + pulled + " member(s) put back on the squad route", 1);
            const float range = l.circuitDef.GetMaxRange() * Global::RoleSettings::Front::ArtySquadRangeFraction;
            AIFloat3 goal = s.leadGoal;
            string state = "hold";
            if (!known) { state = "no enemy known"; goal = lp; }
            else {
                const float d = lp.distance2D(enemy);
                const bool straggling = far > Global::RoleSettings::Front::ArtySquadCohesion;
                if (!straggling) s.waitSince = -1;
                else if (s.waitSince < 0) s.waitSince = ai.frame;
                const bool waitOver = straggling
                    && ai.frame - s.waitSince >= AiMax(0, Global::RoleSettings::Front::ArtySquadStragglerSeconds) * SECOND;
                // a member that cannot reach its place (terrain, a blocked slot) holds the pace at most ArtySquadPaceWaitSeconds
                const bool lagging = lag > Global::RoleSettings::Front::ArtySquadPaceTolerance;
                if (!lagging) s.paceSince = -1;
                else if (s.paceSince < 0) s.paceSince = ai.frame;
                if (d <= range) { state = "in range " + int(d); goal = lp; }
                else if (straggling && !waitOver) state = "waits for stragglers " + int(far) + " (" + farName + ")";
                else if (lagging && !waitOver
                         && ai.frame - s.paceSince < AiMax(0, Global::RoleSettings::Front::ArtySquadPaceWaitSeconds) * SECOND)
                    state = "paces for " + lagName + " " + int(lag) + " behind";
                else {
                    // the next step toward the point at `range` from the enemy
                    const float step = AiMin(d - range, AiMax(1.0f, Global::RoleSettings::Front::ArtySquadPaceStep));
                    goal = Clamp(lp.x + dx * step, lp.z + dz * step);
                    state = "advances, enemy at " + int(d) + (straggling ? ", stragglers left behind " + int(far) + " (" + farName + ")" : "");
                }
            }
            s.leadGoal = SetGoal(s.leadRoute, s.leadGoal, goal, Global::RoleSettings::Front::ArtySquadRepath);
            // every member to its own place around the lead's goal (heavies ahead, the pack around, support behind)
            const float repath = Global::RoleSettings::Front::ArtySquadRepath;
            s.frontGoal = Clamp(s.leadGoal.x + dx * heavyLine, s.leadGoal.z + dz * heavyLine);   // new members' first goal
            s.followGoal = s.leadGoal;
            for (uint k = 0; k < s.members.length(); ++k) {
                CCircuitUnit@ m = ai.GetTeamUnit(s.members[k]);
                if (m is null || m.id == l.id || m.task is null) continue;
                CRouteTask@ r = cast<CRouteTask>(cast<IFighterTask>(WantedRoute(s, m)));
                if (r is null || m.task !is cast<IUnitTask>(r)) continue;
                const AIFloat3 slot = Clamp(s.leadGoal.x + dx * fo[k] - dz * so[k], s.leadGoal.z + dz * fo[k] + dx * so[k]);
                if (s.slotSent[k].x >= 0.0f && MapHelpers::SqDist(s.slotSent[k], slot) < repath * repath) continue;
                const array<AIFloat3> points = {slot};
                if (r.SetUnitRoute(m, points, 48.0f)) s.slotSent[k] = slot;
            }
            if (ai.frame >= s.nextLog) {
                s.nextLog = ai.frame + 20 * SECOND;
                GenericHelpers::LogUtil("[FRONT][ArtySquad] squad " + s.id + ": lead " + s.leader + " at (" + int(lp.x) + ", " + int(lp.z)
                    + ") " + state + ", " + s.members.length() + " member(s) (" + Census(s) + "), farthest " + int(far)
                    + (s.leadHeavy ? "" : ", heavy line " + int(heavyLine) + " gap " + int(HeavyGap(s, l, dx, dz))), 1);
            }
        }
    }

    void Load() {
        for (int i = int(squads.length()) - 1; i >= 0; --i) Release(uint(i), "reset on load");
        nextUpdate = 0;
        nextBotRoll = -1;
    }
}
