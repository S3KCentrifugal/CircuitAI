// TECH air squads (owner, 2026-11-18): when TECH is maxed on metal and the metal ping-pong guard is on.
#include "../../define.as"
#include "../../global.as"
#include "../../task.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/construction/guard_helpers.as"
#include "../team/team_economy.as"

/******************************************************************************

TECH AIR SQUADS

"Overflow": our metal bank is at AirSquadsMetalFill of storage or more AND
AI-to-AI donations are paused (TeamEconomy::aiSharePaused, owner 2026-10-24:
every allied AI at 80%+ metal, so donating would only bounce metal between
full AIs). While it holds, the T1 and T2 air plants build two reserved squads
(one recruit per plant at a time, ahead of the normal plant rows):

1. T3 RECLAIM SQUAD (T3SquadT1 T1 + T3SquadT2 T2 air constructors). Called the
   first time T3Unstick finds one of our T3s stuck during an overflow
   (StuckT3). Its only job, for the rest of the game, is the reclaims around
   stuck T3s (T3Unstick::SquadTask): every blocker of a running round, the
   normal list plus fusion reactors of all three factions (own, and allied
   SMRTBARb ones given through AllyClear with a ".s" key), and past TECH's
   bank gate (TechReclaim::Allowed defers every reclaim whose refund will not
   fit the bank, i.e. all of them when the bank is full; the squad takes them
   and the refund may overflow - owner's call). Energy storage and natively
   protected defs are never reclaimed. With nothing to reclaim it waits.
   While the squad is on, a T3 gets up to T3SquadMaxRounds rounds.

2. GANTRY GUARD (GantryGuardPerGantry per finished gantry of ours, T1 and T2
   air constructors mixed as the two plants fill it). Each member guards
   (assists) the gantry with the fewest guards and stays on it; when its
   gantry goes it moves to another with room, else waits.

Members are claimed only as fresh units out of a plant where a recruit of
ours ended (by producer id and tier, one unit per recruit, within 90 s);
recruits running and unexpired claims count as on the way. Losses are
replaced until twice a squad's size has joined. Neither squad is ever released. Production stops while the
overflow does not hold; the members keep their jobs.

Cost: Work is O(running blockers + allied grants) for squad 1, O(gantries)
for squad 2 (the gantry list is refreshed every 10 s, one pass over our
units). FactoryMakeTask O(plants). No per-frame work.

******************************************************************************/
namespace TechAirSquads {

    final class Rec {
        IUnitTask@ task;
        int squad = 0;   // 1 reclaim, 2 gantry guard
        bool t2 = false;
    }
    final class Claim {
        int until = -1;
        int squad = 0;
        bool t2 = false;
    }
    // A recruit task ends when the frame starts, not when the constructor is out (played 11-18: the plant
    // asked again ~3 s after each order). Each ended recruit leaves a claim this long for its unit.
    const int ClaimSeconds = 90;

    array<int> t3T1;             // squad 1 members by tier
    array<int> t3T2;
    array<int> guards;           // squad 2 members
    dictionary guardOf;          // member id -> gantry id
    dictionary guardCount;       // gantry id -> members on it
    dictionary recs;             // plant id -> Rec@ (one recruit of ours per plant)
    dictionary claims;           // plant id -> array<Claim@>@ (ended recruits: their fresh units are ours, oldest first)
    array<int> asked;            // air constructors already judged
    bool t3Wanted = false;
    int madeT3T1 = 0, madeT3T2 = 0, madeGuards = 0;
    bool wasOverflow = false;
    int lastLog = -100000;

    array<int> gantries;         // our finished gantries
    int gantryFrame = -100000;

    bool On() { return Global::AISettings::Role == AiRole::TECH && Global::RoleSettings::Tech::AirSquadsEnabled; }
    string Side() { return Global::AISettings::Side; }
    void Log(const string &in s) { GenericHelpers::LogUtil("[AirSquads] " + s, 1); }

    bool Overflow()
    {
        if (!On()) return false;
        const float stor = aiEconomyMgr.metal.storage;
        if (stor <= 0.0f) return false;
        const bool full = aiEconomyMgr.metal.current / stor >= Global::RoleSettings::Tech::AirSquadsMetalFill;
        const bool now = full && TeamEconomy::aiSharePaused;
        if (now != wasOverflow) {
            wasOverflow = now;
            Log("overflow " + (now ? "ON" : "off") + ": metal " + int(aiEconomyMgr.metal.current) + "/" + int(stor)
                + ", AI-to-AI donations " + (TeamEconomy::aiSharePaused ? "paused" : "running")
                + "; T3 squad " + T3SquadSize() + ", gantry guard " + guards.length() + "/" + GuardTarget());
        }
        return now;
    }

    int T3SquadSize() { return int(t3T1.length() + t3T2.length()); }
    bool Owns(int id) { return t3T1.find(id) >= 0 || t3T2.find(id) >= 0 || guards.find(id) >= 0; }

    // T3Unstick (StartRound, Tick): one of our T3s is stuck. True while the reclaim squad's rules apply.
    bool StuckT3(CCircuitUnit@ u)
    {
        if (!On()) return false;
        if (!t3Wanted && Overflow()) {
            t3Wanted = true;
            Log("a stuck " + (u is null ? "T3" : u.circuitDef.GetName() + " " + u.id) + " during the overflow calls the T3 reclaim squad ("
                + Global::RoleSettings::Tech::T3SquadT1 + " T1 + " + Global::RoleSettings::Tech::T3SquadT2 + " T2 air constructors)");
        }
        return t3Wanted && (T3SquadSize() > 0 || Overflow());
    }

    // ------------------------------------------------------------------ gantries

    void RefreshGantries()
    {
        if (ai.frame - gantryFrame < 10 * SECOND) return;
        gantryFrame = ai.frame;
        gantries.resize(0);
        array<Id>@ own = ai.GetOwnedUnitIds();
        for (uint i = 0; i < own.length(); ++i) {
            CCircuitUnit@ g = ai.GetTeamUnit(own[i]);
            if (!ai.IsOwnedUnit(g) || g.circuitDef.IsMobile() || !UnitHelpers::IsGantryLab(g.circuitDef.GetName())) continue;
            if (g.GetBuildProgress() < 1.0f) continue;
            gantries.insertLast(g.id);
        }
    }
    int GuardTarget() { return int(gantries.length()) * AiMax(0, Global::RoleSettings::Tech::GantryGuardPerGantry); }
    int CountOn(int gid) { int n = 0; guardCount.get("" + gid, n); return n; }
    void Unassign(int id)
    {
        int gid = -1;
        if (!guardOf.get("" + id, gid)) return;
        guardOf.delete("" + id);
        const int n = CountOn(gid) - 1;
        if (n > 0) guardCount.set("" + gid, n); else guardCount.delete("" + gid);
    }

    IUnitTask@ GuardWork(CCircuitUnit@ u)
    {
        RefreshGantries();
        int gid = -1;
        guardOf.get("" + u.id, gid);
        CCircuitUnit@ g = (gid >= 0) ? ai.GetTeamUnit(gid) : null;
        if (gid >= 0 && (!ai.IsOwnedUnit(g) || gantries.find(gid) < 0)) { Unassign(u.id); gid = -1; @g = null; }
        if (gid < 0) {
            const int cap = AiMax(1, Global::RoleSettings::Tech::GantryGuardPerGantry);
            int best = -1, bestN = cap;
            for (uint i = 0; i < gantries.length(); ++i) {
                const int n = CountOn(gantries[i]);
                if (n < bestN) { bestN = n; best = gantries[i]; }
            }
            if (best < 0) return aiBuilderMgr.Enqueue(TaskB::Wait(5 * SECOND));
            @g = ai.GetTeamUnit(best);
            if (!ai.IsOwnedUnit(g)) return aiBuilderMgr.Enqueue(TaskB::Wait(2 * SECOND));
            gid = best;
            guardOf.set("" + u.id, gid);
            guardCount.set("" + gid, CountOn(gid) + 1);
            Log(u.circuitDef.GetName() + " " + u.id + " guards gantry " + g.circuitDef.GetName() + " " + gid + " (" + CountOn(gid) + " on it)");
        }
        IUnitTask@ t = GuardHelpers::AssignWorkerGuard(u, g, Task::Priority::HIGH, true,
            int(Global::RoleSettings::Tech::GantryGuardSeconds) * SECOND);
        if (t is null || t.IsDead()) return aiBuilderMgr.Enqueue(TaskB::Wait(3 * SECOND));
        return t;
    }

    // ------------------------------------------------------------------ members

    bool IsT1Air(CCircuitUnit@ u) { return u.circuitDef.GetName() == UnitHelpers::GetT1AirConstructorNameForSide(Side()); }
    bool IsT2Air(CCircuitUnit@ u) { return u.circuitDef.GetName() == UnitHelpers::GetT2AirConstructorNameForSide(Side()); }

    bool Steered(IUnitTask@ t)
    {
        return t !is null && !t.IsDead() && (t.IsExternalControlled() || t.GetType() == int(Task::Type::PLAYER)
            || t.GetType() == int(Task::Type::RETREAT));
    }
    // Held by a program that owns it outright: never claimed
    bool OwnedElsewhere(CCircuitUnit@ u)
    {
        const int id = u.id;
        if (TechBuild::IsDedicatedAirCon(u) || EarlyMexUpgraders::IsClaimed(id) || TechGantryCrew::crewId == id) return true;
        if (LolCannon::IsCrew(id) || LrpcBlock::IsCrew(id) || TechAirFoundry::Owns(id) || TechFlank::Owns(u) || CommanderGroup::Owns(id)) return true;
        if (Team::Ferry::IsGift(id) || Team::Recovery::IsGift(id)) return true;
        if ((Builder::primaryT2AirConstructor !is null && Builder::primaryT2AirConstructor.id == id)
            || (Builder::secondaryT2AirConstructor !is null && Builder::secondaryT2AirConstructor.id == id)) return true;
        return false;
    }

    void Forget(int id)
    {
        int i = t3T1.find(id); if (i >= 0) { t3T1.removeAt(i); Log("T3 squad T1 " + id + " lost (" + T3SquadSize() + " left)"); }
        i = t3T2.find(id); if (i >= 0) { t3T2.removeAt(i); Log("T3 squad T2 " + id + " lost (" + T3SquadSize() + " left)"); }
        i = guards.find(id); if (i >= 0) { guards.removeAt(i); Unassign(id); }
        i = asked.find(id); if (i >= 0) asked.removeAt(i);
    }
    // manager/builder.as AiUnitRemoved
    void UnitRemoved(CCircuitUnit@ u) { if (u !is null) Forget(u.id); }

    void Status()
    {
        if (ai.frame - lastLog < 60 * SECOND || (!t3Wanted && guards.length() == 0 && !wasOverflow)) return;
        lastLog = ai.frame;
        Log("status: overflow " + (wasOverflow ? "on" : "off") + ", T3 squad " + t3T1.length() + " T1 + " + t3T2.length()
            + " T2 (wanted " + (t3Wanted ? "yes" : "no") + "), gantry guard " + guards.length() + "/" + GuardTarget()
            + " on " + gantries.length() + " gantries; made " + madeT3T1 + "/" + madeT3T2 + "/" + madeGuards);
    }

    // manager/builder.as AiMakeTask (TECH), right after the early mex upgraders.
    // keep: stay on the current task (the caller returns u.task).
    IUnitTask@ Work(CCircuitUnit@ u, bool &out keep)
    {
        keep = false;
        if (!On() || u is null || u.circuitDef is null) return null;
        const bool air2 = IsT2Air(u), air1 = IsT1Air(u);
        if (!air1 && !air2) return null;
        Status();
        const int id = u.id;
        if (!Owns(id)) {
            if (asked.find(id) >= 0) return null;
            asked.insertLast(id);
            // our recruit at its plant finished (the plant may not have asked again yet), or did within 20 s
            const string pk = "" + u.GetProducerId();
            Settle(pk);
            array<Claim@>@ list = null;
            if (!claims.get(pk, @list) || list is null) return null;
            int squad = 0;
            while (list.length() > 0 && squad == 0) {
                if (ai.frame <= list[0].until && list[0].t2 == air2) squad = list[0].squad;
                list.removeAt(0);   // used, expired or for the other tier
            }
            if (squad == 0 || OwnedElsewhere(u) || Steered(u.task)) return null;
            if (squad == 1 && int(air2 ? t3T2.length() : t3T1.length())
                    >= (air2 ? Global::RoleSettings::Tech::T3SquadT2 : Global::RoleSettings::Tech::T3SquadT1)) squad = 2;
            if (squad == 1) { if (air2) { t3T2.insertLast(id); madeT3T2++; } else { t3T1.insertLast(id); madeT3T1++; } }
            else { guards.insertLast(id); madeGuards++; }
            Log(u.circuitDef.GetName() + " " + id + " joins the " + (squad == 1 ? "T3 reclaim squad (" + t3T1.length() + " T1, " + t3T2.length() + " T2)"
                : "gantry guard (" + guards.length() + ")"));
        }
        if (Steered(u.task)) { keep = true; return null; }
        IUnitTask@ w = null;
        if (guards.find(id) >= 0) @w = GuardWork(u);
        else {
            @w = T3Unstick::SquadTask(u);
            if (w is null) @w = aiBuilderMgr.Enqueue(TaskB::Wait(5 * SECOND));
        }
        @u = ai.GetTeamUnit(id);   // Enqueue may dispatch callbacks: read the unit again by id
        if (u is null) { Forget(id); return null; }
        if (w !is null && w is u.task) { keep = true; return null; }
        return w;
    }

    // ------------------------------------------------------------------ production

    // A plant's ended recruit becomes a pending claim. O(1).
    void Settle(const string &in key)
    {
        Rec@ r = null;
        if (!recs.get(key, @r) || r is null || (r.task !is null && !r.task.IsDead())) return;
        array<Claim@>@ list = null;
        if (!claims.get(key, @list) || list is null) { @list = array<Claim@>(); claims.set(key, @list); }
        Claim c;
        c.until = ai.frame + ClaimSeconds * SECOND;
        c.squad = r.squad;
        c.t2 = r.t2;
        list.insertLast(c);
        recs.delete(key);
    }

    // Recruits running plus unexpired claims for a squad (and tier for squad 1). O(plants x claims), a handful.
    int InFlight(int squad, bool t2)
    {
        int n = 0;
        array<string>@ keys = recs.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            Rec@ r = null;
            if (!recs.get(keys[i], @r) || r is null || r.task is null || r.task.IsDead()) continue;
            if (r.squad == squad && (squad == 2 || r.t2 == t2)) ++n;
        }
        array<string>@ ckeys = claims.getKeys();
        for (uint i = 0; i < ckeys.length(); ++i) {
            array<Claim@>@ list = null;
            if (!claims.get(ckeys[i], @list) || list is null) continue;
            for (uint j = 0; j < list.length(); ++j)
                if (ai.frame <= list[j].until && list[j].squad == squad && (squad == 2 || list[j].t2 == t2)) ++n;
        }
        return n;
    }

    // manager/factory.as AiMakeTask (TECH), after TechGantryCrew
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory)
    {
        if (!On() || factory is null || factory.circuitDef is null) return null;
        const string fac = factory.circuitDef.GetName();
        const bool t2 = UnitHelpers::IsT2AircraftPlant(fac);
        if (!t2 && !UnitHelpers::IsT1AircraftPlant(fac)) return null;
        const string key = "" + factory.id;
        Settle(key);
        Rec@ r = null;
        if (recs.get(key, @r) && r !is null) return null;   // ours still running
        if (!Overflow()) return null;
        RefreshGantries();
        int squad = 0;
        if (t3Wanted) {
            const int want = t2 ? Global::RoleSettings::Tech::T3SquadT2 : Global::RoleSettings::Tech::T3SquadT1;
            const int have = int(t2 ? t3T2.length() : t3T1.length());
            const int made = t2 ? madeT3T2 : madeT3T1;
            if (have + InFlight(1, t2) < want && made < 2 * want) squad = 1;
        }
        if (squad == 0) {
            const int want = GuardTarget();
            if (want > 0 && int(guards.length()) + InFlight(2, false) < want && madeGuards < 2 * want) squad = 2;
        }
        if (squad == 0) return null;
        CCircuitDef@ d = ai.GetCircuitDef(t2 ? UnitHelpers::GetT2AirConstructorNameForSide(UnitHelpers::GetSideForUnitName(fac))
                                             : UnitHelpers::GetT1AirConstructorNameForSide(UnitHelpers::GetSideForUnitName(fac)));
        if (d is null || !factory.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame) || (d.maxThisUnit >= 0 && d.count >= d.maxThisUnit)) return null;
        IUnitTask@ t = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, d, factory.GetPos(ai.frame), 64.f));
        if (t is null || t.IsDead()) return null;
        Rec nr;
        @nr.task = t;
        nr.squad = squad;
        nr.t2 = t2;
        recs.set(key, @nr);
        Log(fac + " " + factory.id + " builds " + d.GetName() + " for the " + (squad == 1
            ? "T3 reclaim squad (" + T3SquadSize() + " of " + (Global::RoleSettings::Tech::T3SquadT1 + Global::RoleSettings::Tech::T3SquadT2) + ")"
            : "gantry guard (" + guards.length() + " of " + GuardTarget() + ")"));
        return t;
    }
}  // namespace TechAirSquads
