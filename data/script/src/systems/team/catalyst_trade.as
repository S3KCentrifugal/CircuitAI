// Catalyst trade (owner, 2026-11-13; Front::TacticalCatalystTrade): a Legion FRONT on its anti-porc
// step asks a Cortex FRONT ally for a T2 constructor, and builds Catalysts with it.
//
// Owner: "legion's antiporc perdition does not have enough damage to kill the pulsars/bastions/bulwarks
// it is intended to be used against. We are changing to trade cortex units and build a perdition and 2
// catalysts instead of 2 perditions." Uses the request shape of the T2 constructor donation
// (donation.as) and the recovery hand-over (builder_recovery.as): one request, one donor, one gift.
//
// Requester (Legion FRONT, FrontTactical::NeedCatalysts: the tactical gate is open, a heavy turret near
// our mexes / porc has no Catalyst in range, and we own no constructor that can build one):
//   barbcat|req|<token>|x|z   broadcast; every Cortex FRONT ally answers
//   barbcat|offer|<token>|<idle 1/0>   (it has a spare idle T2 constructor now / a T2 lab to build one)
//   barbcat|none|<token>      (neither)
// After TacticalTradeOfferSeconds the requester takes an idle offer first, then the nearest start, and
// sends barbcat|accept|<token> to that one team. With no offer at all (or no Cortex FRONT on the team) the
// Perdition cap lifts for TacticalTradeFallbackSeconds: the old two-Perdition behaviour (FrontTactical).
// An accepted request with no constructor after TacticalTradeDeliverSeconds is cancelled, that donor is
// skipped for TacticalTradeRetrySeconds x 3, and the request is asked again. A received constructor that
// dies while Catalysts are still wanted is asked for again the same way (after TacticalTradeRetrySeconds).
//
// Donor (Cortex FRONT): on accept it gives an idle T2 constructor (finished, Free, on no tactical / agitator
// / commander-group / lolcannon work) when it keeps TacticalTradeDonorKeep others; else its next T2 lab
// production cycle builds one (corack / coracv, a short cap lease as in builder_recovery.as) and that one
// is given. barbcat|sent|<token>|<id> tells the requester. Gifts go through ai.GiveUnits from Update,
// after a null / dead / unfinished check on the unit; a dead gift or a dead order re-orders.
//
// The traded constructor (its id comes with "sent"; IsTraded) is driven by FrontTactical::TradedWork,
// ahead of every other FRONT builder rung and skipped by the lolcannon crew: no reach limit for it, it
// guards the open order's builder while another launcher is being built, takes the next Catalyst order the
// moment that ends, and waits where it stands while Catalysts are wanted but no order can be placed yet.
//
// Cost: messages per request episode only (a handful per anti-porc step). Update every 2 s: O(1) for the
// requester (FrontTactical's own 5 s scan counts the Catalyst builders); the donor scans its owned units
// only while it owes a constructor (at most one obligation per requesting ally). Log [Team][CatalystTrade].
namespace Team { namespace CatalystTrade {
    const string MSG = "barbcat";
    const int UpdateSeconds = 2;

    // ---- requester
    int state = 0;             // 0 idle, 1 collecting offers, 2 accepted, waiting for the constructor
    int token = -1;
    int askFrame = -1;
    int acceptFrame = -1;
    int donor = -1;
    int nextAsk = 0;
    int fallbackUntil = -1;
    bool hadBuilder = false;   // our traded constructor arrived (its loss is logged and asked for again)
    int needLost = -1;         // when Catalysts stopped being wanted (-1: wanted)
    array<int> traded;         // ids of the constructors donors sent us (unit ids survive GiveUnits)
    array<int> tradedAt;       // ... and the frame each "sent" arrived
    AIFloat3 askSite;
    array<int> offerTeam;
    array<int> offerIdle;
    dictionary avoidUntil;     // donor team id string -> frame (int64; read only after exists())

    // ---- donor
    class Obligation {
        int team = -1, token = -1, since = -1;
        int factory = -1, definition = -1, gift = -1;
        int savedCap = -1, openedCap = -1;
        IUnitTask@ order;
    }
    array<Obligation@> owed;
    int lastUpdate = -100000;

    bool Enabled() { return Global::RoleSettings::Front::Tactical && Global::RoleSettings::Front::TacticalCatalystTrade; }
    bool IsFront() { return Global::AISettings::Role == AiRole::FRONT; }
    bool IsRequester() { return Enabled() && IsFront() && Global::AISettings::Side == "legion"; }
    bool IsDonor() { return Enabled() && IsFront() && Global::AISettings::Side == "cortex"; }

    void Reset() {
        state = 0; token = -1; askFrame = -1; acceptFrame = -1; donor = -1; nextAsk = 0; fallbackUntil = -1;
        hadBuilder = false; needLost = -1; traded.resize(0); tradedAt.resize(0); offerTeam.resize(0); offerIdle.resize(0); avoidUntil.deleteAll();
        for (uint i = 0; i < owed.length(); ++i) ReleaseCap(owed[i]);
        owed.resize(0); lastUpdate = -100000;
    }

    void Log(const string &in text) { GenericHelpers::LogUtil("[Team][CatalystTrade] " + text, 1); }

    // Cortex FRONT allies (not us) in the roster
    array<Team::Roster::Entry@> CortexFronts() {
        array<Team::Roster::Entry@> found;
        array<Team::Roster::Entry@>@ fronts = Team::Roster::WithRole(AiRole::FRONT);
        if (fronts is null) return found;
        for (uint i = 0; i < fronts.length(); ++i) {
            Team::Roster::Entry@ e = fronts[i];
            if (e is null || e.teamId == ai.teamId || e.side != "cortex" || !Team::IsAlly(e.teamId)) continue;
            found.insertLast(e);
        }
        return found;
    }

    // FrontTactical: true while a Legion FRONT may build its old second Perdition (no Cortex FRONT ally to
    // trade with, or the last request found no donor)
    bool Fallback() {
        if (!IsRequester()) return true;
        if (ai.frame < fallbackUntil) return true;
        return FrontTactical::catBuilders == 0 && state == 0 && CortexFronts().length() == 0;
    }

    bool Avoided(int team) {
        const string k = "" + team;
        if (!avoidUntil.exists(k)) return false;
        int64 until = 0;
        avoidUntil.get(k, until);
        return ai.frame < until;
    }

    void Ask(const AIFloat3 &in site) {
        array<Team::Roster::Entry@> fronts = CortexFronts();
        if (fronts.length() == 0) {
            if (fallbackUntil <= ai.frame) Log("no Cortex FRONT ally; the second Perdition stays allowed");
            fallbackUntil = ai.frame + Global::RoleSettings::Front::TacticalTradeFallbackSeconds * SECOND;
            nextAsk = ai.frame + Global::RoleSettings::Front::TacticalTradeRetrySeconds * SECOND;
            return;
        }
        token = ai.frame; askFrame = ai.frame; askSite = site; state = 1;
        offerTeam.resize(0); offerIdle.resize(0);
        AiSendMessage(MSG + "|req|" + token + "|" + int(site.x) + "|" + int(site.z));
        Log("asked " + fronts.length() + " Cortex FRONT allies for a T2 constructor (Catalysts at (" + int(site.x) + "," + int(site.z) + "))");
    }

    void Choose() {
        int best = -1, bestIdle = -1;
        float bestSq = 1e30f;
        for (uint i = 0; i < offerTeam.length(); ++i) {
            if (Avoided(offerTeam[i])) continue;
            Team::Roster::Entry@ e = Team::Roster::Get(offerTeam[i]);
            const float sq = (e is null) ? 1e29f : MapHelpers::SqDist(e.startPos, askSite);
            if (offerIdle[i] > bestIdle || (offerIdle[i] == bestIdle && sq < bestSq)) {
                best = offerTeam[i]; bestIdle = offerIdle[i]; bestSq = sq;
            }
        }
        if (best < 0) {
            state = 0;
            fallbackUntil = ai.frame + Global::RoleSettings::Front::TacticalTradeFallbackSeconds * SECOND;
            nextAsk = ai.frame + Global::RoleSettings::Front::TacticalTradeRetrySeconds * SECOND;
            Log("no Cortex FRONT can give a T2 constructor (" + offerTeam.length() + " offers); the second Perdition is allowed for "
                + Global::RoleSettings::Front::TacticalTradeFallbackSeconds + " s");
            return;
        }
        donor = best; state = 2; acceptFrame = ai.frame;
        AiSendMessage(MSG + "|accept|" + token, donor);
        Log("team " + donor + " gives the T2 constructor (" + (bestIdle > 0 ? "idle now" : "next T2 lab cycle") + ")");
    }

    void Cancel(const string &in why) {
        if (state == 2 && donor >= 0) AiSendMessage(MSG + "|cancel|" + token, donor);
        if (state != 0) Log("request " + token + " closed: " + why);
        state = 0; donor = -1;
    }

    // FrontTactical::TradedWork: a constructor a donor sent us for Catalysts
    bool IsTraded(int id) { return traded.find(id) >= 0; }

    void RequesterUpdate() {
        if (!IsRequester()) return;
        // the hand-over lands up to a second after "sent" (headless 2026-11-13: 21 frames), so a gift is
        // forgotten only once it is gone 30 s after it was sent
        for (int i = int(traded.length()) - 1; i >= 0; --i)
            if (ai.frame - tradedAt[i] > 30 * SECOND && ai.GetTeamUnit(traded[i]) is null) { traded.removeAt(uint(i)); tradedAt.removeAt(uint(i)); }
        AIFloat3 site;
        const bool need = FrontTactical::NeedCatalysts(site);
        if (FrontTactical::catBuilders > 0) {
            if (state == 2) { Log("traded T2 constructor arrived from team " + donor); hadBuilder = true; }
            if (state != 0) { state = 0; donor = -1; }
            needLost = -1;
            return;
        }
        // catBuilders is only counted while heavy turrets are known (FrontTactical::Scan)
        if (hadBuilder && FrontTactical::targets.length() > 0) {
            hadBuilder = false;
            Log("our traded Catalyst constructor is gone" + (need ? "; asking again in " + Global::RoleSettings::Front::TacticalTradeRetrySeconds + " s" : ""));
            nextAsk = ai.frame + Global::RoleSettings::Front::TacticalTradeRetrySeconds * SECOND;
        }
        if (!need) {
            // the gate (income) flickers: an accepted request survives TacticalTradeRetrySeconds without need
            if (needLost < 0) needLost = ai.frame;
            if (state == 1 || (state == 2 && ai.frame - needLost >= Global::RoleSettings::Front::TacticalTradeRetrySeconds * SECOND))
                Cancel("no Catalyst wanted for " + (ai.frame - needLost) / SECOND + " s");
            if (state != 2) return;
        } else needLost = -1;
        if (state == 1 && ai.frame - askFrame >= Global::RoleSettings::Front::TacticalTradeOfferSeconds * SECOND) { Choose(); return; }
        if (state == 2 && ai.frame - acceptFrame >= Global::RoleSettings::Front::TacticalTradeDeliverSeconds * SECOND) {
            avoidUntil.set("" + donor, int64(ai.frame + 3 * Global::RoleSettings::Front::TacticalTradeRetrySeconds * SECOND));
            Cancel("team " + donor + " sent nothing in " + Global::RoleSettings::Front::TacticalTradeDeliverSeconds + " s");
            nextAsk = ai.frame;
            return;
        }
        if (state == 0 && ai.frame >= nextAsk) Ask(site);
    }

    // ---- donor side
    CCircuitDef@ CatalystDef() { return ai.GetCircuitDef("cortron"); }

    bool Busy(CCircuitUnit@ u) {
        return FrontTactical::Owns(u) || FrontAgitator::OnOrder(u) || CommanderGroup::Owns(u.id) || LolCannon::IsCrew(u.id);
    }

    // An idle Cortex T2 constructor we can spare (TacticalTradeDonorKeep others stay), or null
    CCircuitUnit@ PickIdle() {
        CCircuitDef@ cat = CatalystDef();
        if (cat is null) return null;
        int total = 0;
        CCircuitUnit@ pick = null;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || !u.circuitDef.IsMobile() || u.GetBuildProgress() < 1.0f) continue;
            if (UnitHelpers::IsCommander(u.circuitDef) || !u.circuitDef.CanBuild(cat) || IsGift(u.id)) continue;
            ++total;
            if (pick is null && FrontFactoryNanos::Free(u) && !Busy(u)) @pick = u;
        }
        return (total > Global::RoleSettings::Front::TacticalTradeDonorKeep) ? pick : null;
    }

    // A finished T2 lab of ours that builds a Cortex T2 constructor
    bool HasLab() {
        array<Id>@ ids = ai.GetOwnedUnitIds();
        array<string> names = { "corack", "coracv" };
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || u.circuitDef.IsMobile() || u.GetBuildProgress() < 1.0f) continue;
            for (uint n = 0; n < names.length(); ++n) {
                CCircuitDef@ d = ai.GetCircuitDef(names[n]);
                if (d !is null && u.circuitDef.CanBuild(d)) return true;
            }
        }
        return false;
    }

    bool IsGift(int id) {
        for (uint i = 0; i < owed.length(); ++i) if (owed[i].gift == id) return true;
        return false;
    }

    int Find(int team) {
        for (uint i = 0; i < owed.length(); ++i) if (owed[i].team == team) return int(i);
        return -1;
    }

    void ReleaseCap(Obligation@ o) {
        if (o.definition < 0) return;
        CCircuitDef@ d = ai.GetCircuitDef(o.definition);
        if (d !is null && d.maxThisUnit == o.openedCap) d.maxThisUnit = o.savedCap;   // only our own lease
        o.openedCap = -1;
    }

    void Drop(uint i, const string &in why) {
        Obligation@ o = owed[i];
        ReleaseCap(o);
        Log("owed constructor for team " + o.team + " dropped: " + why);
        owed.removeAt(i);
    }

    // The gift changes hands: only a living, finished unit of ours
    bool Give(Obligation@ o, CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f || !Team::IsAlly(o.team)) return false;
        const int id = u.id;
        const string name = u.circuitDef.GetName();
        array<CCircuitUnit@> give = { u };
        ai.GiveUnits(give, o.team);
        AiSendMessage(MSG + "|sent|" + o.token + "|" + id, o.team);
        Log("gave " + name + " " + id + " to team " + o.team + " for its Catalysts");
        WidgetLink::Send("donation", name + "|" + o.team);
        return true;
    }

    void DonorUpdate() {
        for (int i = int(owed.length()) - 1; i >= 0; --i) {
            Obligation@ o = owed[i];
            if (!IsDonor()) { Drop(uint(i), "no longer a Cortex FRONT"); continue; }
            if (ai.frame - o.since >= Global::RoleSettings::Front::TacticalTradeDeliverSeconds * SECOND) { Drop(uint(i), "timed out"); continue; }
            if (o.gift >= 0) {
                CCircuitUnit@ g = ai.GetTeamUnit(o.gift);
                if (g is null) { Log("gift " + o.gift + " for team " + o.team + " died before the hand-over; ordering again"); o.gift = -1; continue; }
                if (Give(o, g)) owed.removeAt(uint(i));
                continue;
            }
            CCircuitUnit@ idle = PickIdle();
            if (idle !is null && Give(o, idle)) { ReleaseCap(o); owed.removeAt(uint(i)); continue; }
            if (o.order !is null && (o.order.IsDead() || ai.GetTeamUnit(o.factory) is null)) {
                ReleaseCap(o); @o.order = null; o.factory = -1; o.definition = -1;
            }
        }
    }

    // Factory::AiMakeTask (FRONT): a T2 lab builds the owed constructor in its next production cycle
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory) {
        if (!IsDonor() || factory is null || factory.circuitDef is null || owed.length() == 0) return null;
        for (uint i = 0; i < owed.length(); ++i) if (owed[i].order !is null) return null;   // one at a time
        Obligation@ o = null;
        for (uint i = 0; i < owed.length() && o is null; ++i) if (owed[i].gift < 0) @o = owed[i];
        if (o is null) return null;
        array<string> names = { "corack", "coracv" };
        CCircuitDef@ product = null;
        for (uint n = 0; n < names.length() && product is null; ++n) {
            CCircuitDef@ d = ai.GetCircuitDef(names[n]);
            if (d !is null && factory.circuitDef.CanBuild(d)) @product = d;
        }
        if (product is null || !product.IsBuildAllowed()) return null;
        o.definition = product.id; o.savedCap = product.maxThisUnit;
        o.openedCap = AiMax(product.maxThisUnit, product.count + 1);
        product.maxThisUnit = o.openedCap;
        if (!product.IsAvailable(ai.frame)) { ReleaseCap(o); o.definition = -1; return null; }
        @o.order = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH,
            product, factory.GetPos(ai.frame), 64.0f));
        if (o.order is null) { ReleaseCap(o); o.definition = -1; return null; }
        o.factory = factory.id;
        Log("ordered " + product.GetName() + " in " + factory.circuitDef.GetName() + " " + factory.id + " for team " + o.team);
        return o.order;
    }

    // Builder::AiUnitAdded: the owed constructor out of our lab becomes the gift (given from Update)
    void OnUnitAdded(CCircuitUnit@ unit) {
        if (unit is null || unit.circuitDef is null || owed.length() == 0) return;
        for (uint i = 0; i < owed.length(); ++i) {
            Obligation@ o = owed[i];
            if (o.gift >= 0 || o.order is null || o.factory != unit.GetProducerId() || o.definition != int(unit.circuitDef.id)) continue;
            o.gift = unit.id;
            ReleaseCap(o);
            @o.order = null;
            Log("built " + unit.circuitDef.GetName() + " " + unit.id + " for team " + o.team);
            return;
        }
    }

    // Front_EconomyUpdate
    void Update() {
        if (!Enabled() || !IsFront()) return;
        if (ai.frame - lastUpdate < UpdateSeconds * SECOND) return;
        lastUpdate = ai.frame;
        RequesterUpdate();
        if (owed.length() > 0) DonorUpdate();
    }

    // Team::HandleMessage, both sides
    bool HandleMessage(const string &in msg, int from) {
        if (msg.findFirst(MSG + "|") != 0) return false;
        array<string>@ p = msg.split("|");
        if (p.length() < 3 || from == ai.teamId) return true;
        const int tok = int(parseInt(p[2]));
        const string verb = p[1];
        if (verb == "req") {
            if (!IsDonor()) return true;
            const bool idle = PickIdle() !is null;
            const bool lab = idle || HasLab();
            AiSendMessage(MSG + (lab ? "|offer|" + tok + "|" + (idle ? 1 : 0) : "|none|" + tok), from);
            Log("team " + from + " asks for a T2 constructor: " + (idle ? "idle one to spare" : (lab ? "our T2 lab can build one" : "none to give")));
            return true;
        }
        if (verb == "accept") {
            if (!IsDonor()) { AiSendMessage(MSG + "|none|" + tok, from); return true; }
            const int at = Find(from);
            if (at >= 0) { owed[at].token = tok; owed[at].since = ai.frame; return true; }
            Obligation@ o = Obligation();
            o.team = from; o.token = tok; o.since = ai.frame;
            owed.insertLast(o);
            Log("owe team " + from + " a T2 constructor");
            CCircuitUnit@ idle = PickIdle();
            if (idle !is null && Give(o, idle)) owed.removeAt(owed.length() - 1);
            return true;
        }
        if (verb == "cancel") {
            const int at = Find(from);
            if (at >= 0 && owed[at].token == tok) {
                CCircuitUnit@ g = (owed[at].gift >= 0) ? ai.GetTeamUnit(owed[at].gift) : null;
                Drop(uint(at), "cancelled by team " + from + (g !is null ? " (the built constructor stays ours)" : ""));
            }
            return true;
        }
        if (!IsRequester() || tok != token) return true;
        if (verb == "offer" && state == 1 && p.length() >= 4) {
            if (offerTeam.find(from) < 0) { offerTeam.insertLast(from); offerIdle.insertLast(int(parseInt(p[3]))); }
            return true;
        }
        if (verb == "none") return true;
        if (verb == "sent") {
            if (p.length() >= 4 && traded.find(int(parseInt(p[3]))) < 0) { traded.insertLast(int(parseInt(p[3]))); tradedAt.insertLast(ai.frame); }
            Log("team " + from + " sent constructor " + (p.length() >= 4 ? p[3] : "?")); return true; }
        return true;
    }
} }
