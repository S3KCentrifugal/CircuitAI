// Lolcannon site clearing (owner, 2026-11-18): the lolcannon crew reclaims our own
// T1 eco and T1/T1.5 porc and AA (and asks the allied SMRTBARbs for theirs) off a
// blocked cannon site behind the front, so more and nearer sites can be used.
#include "../../define.as"
#include "../../global.as"
#include "../../task.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../world/lanes.as"
#include "../world/porc_front_line.as"
#include "../team/ally_clear.as"
#include "../combat/t3_unstick.as"

/******************************************************************************

LOLCANNON CLEAR

Played (VENGEANCE infolog 11-18, team 8 legstarfall): every candidate within
reach was "on ally layouts, reservations or structures" (45 of 384) or scored
below SiteMinScore (21 scored, 0 tried) because our own base stood on it; after
six failed searches the site went 8769 from home, two back levels out.

Now LolCannon::Plan() (lolcannon.as) keeps up to ClearProbes candidates that
were refused only for what stands on them (the cannon footprint not free, the
ground score below SiteMinScore while the ground itself is flat enough, the
cannon not reserving, or turrets short), nearest home first. When no free site
is found (TECH), or the first free-looking one stands ClearPreferElmos (500) further
from home than the nearest kept one, LolCannon::PickClear takes the first of
them that

  - stands behind the front line: our porc front line (PorcFrontLine,
    systems/world/porc_front_line.as, shared with FRONT gantry clearing: the
    furthest-forward point toward the enemy where our defensive buildings
    have stood 2+ minutes, measured within 3000 of the site) at least
    ClearFrontMargin (0) behind it; with no defensive building of ours near
    it, the line drawn ClearFrontShare (0.5) of the way from the enemy start
    to the allied start nearest it;
  - holds only structures of ours of the allowed kinds (Kind) inside the
    site's rectangle (the cannon, the turret block and the storage strip, both
    hands, as LolCannon::GroundScore measures it), one to ClearMaxBlockers of
    them and at most ClearMaxMetal; or none of ours at all (the allied
    SMRTBARbs are asked, once per site);

and only while fewer than ClearMaxCannons lolcannons stand on our ally team
(ai.AlliedFinishedCount, every SMRTBARb on it, us included) and fewer than
ClearMaxRounds rounds were run for this cannon.

Allowed (Kind): Global::Team::AllyClearPorc (T1 and T1.5 porc and AA: LLT,
Beamer/HLLT, HLT, Claw/Maw/Dragon's Breath, the T1 and T1.5 AA, Hive),
Global::LolCannon::ClearExtraKinds (the T1 plasma batteries Gauntlet,
Agitator, Amputator) and Global::Team::AllyClearEco (wind, solar, T1
converter) except energy storage; DeepKind: ClearDeepKinds (T2 pop-up porc
Pit Bull / Viper / Chimera, heavy pop-up artillery Rattlesnake / Persecutor /
Eviscerator, and T1 construction turrets that stand beside our porc, never
a factory's nor a finished lolcannon's block). Whoever placed them, TECH's
weapon clusters included (roles/tech/tech_weapons.as kill zones and coast).
Owner, 2026-11-18: porc on the front line is never reclaimed; porc, AA and
plasma batteries go only Global::PorcFrontLine::BehindMargin (500) or more
behind the porc line at their own spot, the deep kinds only ClearDeepMargin
(1500) or more behind it, and with no line known near them they stay
(LineKeeps). Never (Critical, logged by kind): fusions and advanced fusions,
antinukes, long-range AA, tactical and EMP launchers, nukes, long-range
plasma, lolcannons, factories, energy storage; every other structure (heavy
porc, T2 flak, mexes, radar ...) is not on the list and keeps the site.

The round (LolCannon phase CLEAR, before BUILD): one native reclaim per
blocker (T3Unstick's path: TaskB::Reclaim HIGH, ClearRoundSeconds),
construction turrets in reach pulled on every 10 s (TurretsOnReclaim), the
crews recruited as for BUILD and each crew member handed the nearest blocker
with fewer than ClearCrewPerBlocker on it (CrewTask); the allied SMRTBARbs
are asked through Team::AllyClear with an "lc." key over the same rectangle
and give what passes Kind on their side (trade, then reclaim). When the
blockers are gone (or ClearRoundSeconds pass) the open reclaims are aborted,
each gone blocker leaves TECH's plans (T3Unstick::AddCleared, so a weapon
cluster does not put it back) and LolCannon tries the site again (TrySite);
a site still blocked is dropped (Failed) and the search runs again at once.
Units are held as handles for identity and checked with ai.IsOwnedUnit
before use; tasks are checked for null / IsDead before being returned,
compared or aborted. Dictionary ints are int64 (an int out-arg is garbage on
a miss).

Log [LolCannon][Clear]: pick (with what was kept elsewhere), round (each
blocker), crew, end (gone / still standing), and the totals. TECH's reclaims
carry source "lolcannon" in the [RECLAIM] audit line (reclaim_policy.as).

Cost: only when a search found no free site: one pass over our units into a
256-elmo cell index, then O(structures in the cells) per kept candidate, at
most ClearProbes. A round is O(blockers) per second and per crew ask.

******************************************************************************/
namespace LolCannonClear {
    const float Cell = 256.0f;

    // Never cleared (owner, 2026-11-18): advanced fusions, antinukes, long-range AA, tactical / EMP
    // launchers, nukes, long-range plasma and lolcannons (as FrontGantryClear::CriticalNames).
    // Fusions, energy storage and factories are tested by helper.
    const array<string> CriticalNames = {
        "armafus", "corafus", "legafus",
        "armamd", "corfmd", "legabm",
        "armmercury", "corscreamer", "leglraa",
        "armemp", "cortron", "legperdition",
        "armsilo", "corsilo", "legsilo",
        "armbrtha", "corint", "leglrpc", "armvulc", "corbuzz", "legstarfall" };

    bool On() { return Global::LolCannon::ClearSites; }
    void Log(const string &in s) { GenericHelpers::LogUtil("[LolCannon][Clear] " + s, 1); }
    string At(const AIFloat3 &in p) { return "(" + int(p.x) + ", " + int(p.z) + ")"; }

    // ------------------------------------------------------------------ the rules

    float Half(const CCircuitDef@ d)   // footprint cells are 16 elmos; return half in elmos
    {
        if (d is null) return 0.0f;
        return float(AiMax(d.GetFootprintX(), d.GetFootprintZ())) * SQUARE_SIZE;
    }
    bool IsFactory(const string &in n)
    {
        return UnitHelpers::IsT1BotLab(n) || UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT1VehicleLab(n) || UnitHelpers::IsT2VehicleLab(n)
            || UnitHelpers::IsT1AircraftPlant(n) || UnitHelpers::IsT2AircraftPlant(n) || UnitHelpers::IsGantryLab(n)
            || UnitHelpers::IsT1HoverPlant(n) || UnitHelpers::IsFloatingHoverPlant(n);
    }
    // "" when the structure is not one of the owner's never-reclaim kinds
    string Critical(const string &in n)
    {
        if (UnitHelpers::IsAnyFusionReactor(n)) return "fusion";
        if (CriticalNames.find(n) >= 0) return "critical";
        if (UnitHelpers::IsEnergyStorage(n)) return "energy storage";
        if (IsFactory(n)) return "factory";
        return "";
    }
    // The kinds a lolcannon site may be cleared of: T1/T1.5 porc and AA, T1 eco (no energy storage).
    // O(list length); also judges allied buildings for an "lc." request (ally_clear.as).
    bool Kind(const string &in n)
    {
        if (Critical(n).length() > 0) return false;
        return Global::Team::AllyClearPorc.find(n) >= 0 || Global::Team::AllyClearEco.find(n) >= 0
            || Global::LolCannon::ClearExtraKinds.find(n) >= 0;
    }
    // ... and, on a site well behind the front line (ClearDeepMargin past the line), the commander group's
    // construction turrets and T2 pop-up porc and heavy pop-up artillery (owner, 2026-11-18): Global::LolCannon::
    // ClearDeepKinds (Pit Bull, Viper, Chimera; Rattlesnake, Persecutor, Eviscerator; T1 construction turrets)
    bool DeepKind(const string &in n)
    {
        if (Critical(n).length() > 0) return false;
        return Global::LolCannon::ClearDeepKinds.find(n) >= 0;
    }
    // Porc (and pop-up artillery): what the porc front line protects (PorcFrontLine)
    bool IsPorcKind(const string &in n)
    {
        return Global::Team::AllyClearPorc.find(n) >= 0 || Global::LolCannon::ClearExtraKinds.find(n) >= 0
            || (Global::LolCannon::ClearDeepKinds.find(n) >= 0 && !UnitHelpers::IsT1Nano(n));
    }
    // What an "lc." request may hand over (ally_clear.as, requester side: the kinds only)
    bool KeyKind(const string &in key, const string &in n) { return Kind(n) || DeepKind(n); }

    // Owner, 2026-11-18: "leave alive all porc on the front line, the furthest forward that defensive buildings
    // are alive and have been alive more than 2 minutes; only reclaim the left-behind porc 500+ behind that".
    // A building of a clearable kind at p: "" when it may go, else why it stays. Porc and pop-up artillery must be
    // Global::PorcFrontLine::BehindMargin (500) behind our porc line there (PorcFrontLine::Behind; no line near
    // it: kept); the deep kinds (T2 pop-up porc and artillery, construction turrets) ClearDeepMargin behind it.
    // Eco is judged by the site alone. O(defensive buildings) per porc building asked (PorcFrontLine::LineAt).
    string LineKeeps(const string &in n, const AIFloat3 &in p)
    {
        const bool deep = !Kind(n) && DeepKind(n);
        if (!deep && !IsPorcKind(n)) return "";
        bool known = false;
        const float b = PorcFrontLine::Behind(p, known);
        if (!known) return "no porc front line near it (kept)";
        const float need = deep ? Global::LolCannon::ClearDeepMargin : Global::PorcFrontLine::BehindMargin;
        if (b >= need) return "";
        return (b < 0.0f ? "on the front line, " + int(-b) + " ahead of" : "front porc, " + int(b) + " behind")
            + " the porc line (needs " + int(need) + ")";
    }
    // Owner side of an "lc." request (ally_clear.as): our own building u, judged against our own porc line
    bool AllyGive(CCircuitUnit@ u)
    {
        if (!ai.IsOwnedUnit(u) || u.circuitDef is null) return false;
        const string n = u.circuitDef.GetName();
        return (Kind(n) || DeepKind(n)) && LineKeeps(n, u.GetPos(ai.frame)).length() == 0;
    }
    // 1 clearable on any site behind the front line, 2 only on a deep one, 0 kept (why says what)
    int Judge(CCircuitUnit@ u, string &out why)
    {
        why = "";
        if (!ai.IsOwnedUnit(u) || u.circuitDef is null || u.circuitDef.IsMobile()) { why = "gone"; return 0; }
        const string n = u.circuitDef.GetName();
        const string crit = Critical(n);
        if (crit.length() > 0) { why = crit; return 0; }
        if (aiBuilderMgr.IsReclaimProtected(u.circuitDef)) { why = "protected"; return 0; }
        if (Kind(n)) return 1;
        if (DeepKind(n)) return 2;
        why = "not on the list";
        return 0;
    }

    // Lolcannons standing on our ally team (every SMRTBARb on it, us included). O(3).
    int CannonsStanding()
    {
        int n = 0;
        const array<string> guns = { "armvulc", "corbuzz", "legstarfall" };
        for (uint i = 0; i < guns.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(guns[i]);
            if (d !is null) n += ai.AlliedFinishedCount(d);
        }
        return n;
    }

    // How far behind the front line the site p stands, against the enemy start `target`: behind our porc front
    // line (PorcFrontLine::Behind) where one is known; else (no defensive building of ours near it) behind the
    // line drawn ClearFrontShare of the way from that start to the allied start nearest it. >= 0: our side.
    float SiteBehind(const AIFloat3 &in p, const AIFloat3 &in target, string &out how)
    {
        bool known = false;
        const float b = PorcFrontLine::Behind(p, known);
        how = known ? "porc line" : "no porc line near, midpoint";
        return known ? b : FrontDepth(p, target);
    }
    float FrontDepth(const AIFloat3 &in p, const AIFloat3 &in target)
    {
        const array<AIFloat3> allies = Lanes::AllyStarts();
        if (allies.length() == 0) return -1.0e9f;
        float best = 1.0e30f;
        for (uint i = 0; i < allies.length(); ++i) best = AiMin(best, allies[i].SqDistance2D(target));
        return p.distance2D(target) - sqrt(best) * Global::LolCannon::ClearFrontShare;
    }

    // ------------------------------------------------------------------ state

    int roundsThisCannon = 0;        // reset by NewCannon (a cannon finished or planned afresh)
    bool active = false;
    AIFloat3 site(-1.0f, 0.0f, -1.0f);
    int facing = 0;
    int startIndex = -1;             // LolCannon's candidate start (its siteTarget once found)
    AIFloat3 target(-1.0f, 0.0f, -1.0f);
    AIFloat3 rectCentre;
    float rectHX = 0.0f, rectHZ = 0.0f;
    // One lease owns the whole clearing rectangle; the scoped slot holds the
    // gun as soon as its footprint is free. Never dispatch builds until handoff.
    int clearingZone = 0, earlyGun = -1, nextReserve = 0;
    const CCircuitDef@ clearingGun = null;
    void ReleaseProtection()
    {
        if (clearingZone > 0) aiTerrainMgr.ReleaseZone(clearingZone);
        clearingZone = 0; earlyGun = -1; @clearingGun = null;
    }
    void TryReserveEarly()
    {
        if (clearingZone <= 0 || earlyGun >= 0 || clearingGun is null || ai.frame < nextReserve) return;
        nextReserve = ai.frame + 2 * SECOND;
        earlyGun = aiTerrainMgr.ReserveClearingBuilding(clearingGun, site, facing, clearingZone);
        if (earlyGun >= 0) Log("cannon footprint reserved early at " + At(site) + " (" + earlyGun + "), clearing lease " + clearingZone);
    }
    int roundStart = -1;
    int lastPull = -100000;
    int nextLog = 0;
    string allyKey = "";
    array<int> blockers;
    array<AIFloat3> blockerAt;
    array<float> blockerHalf;
    array<string> blockerName;
    dictionary blockerUnit;          // id -> CCircuitUnit@ (identity of the round's blocker)
    dictionary reclaimTask;          // id -> IUnitTask@
    array<AIFloat3> failed;          // sites still blocked after a round (for this cannon)
    // totals for the report
    int nPicks = 0, nRounds = 0, nCleared = 0, nBlocked = 0, nReclaimed = 0;

    bool Active() { return active; }
    bool Allowed(const string &in n) { return Kind(n) || DeepKind(n); }   // a round's blockers were judged by Assess
    bool Failed(const AIFloat3 &in p)
    {
        for (uint i = 0; i < failed.length(); ++i) if (p.SqDistance2D(failed[i]) < 300.0f * 300.0f) return true;
        return false;
    }
    // A search may keep blocked candidates for Pick (cheap gate, read once per Plan)
    bool MayClear()
    {
        return On() && !active && roundsThisCannon < Global::LolCannon::ClearMaxRounds
            && CannonsStanding() < Global::LolCannon::ClearMaxCannons;
    }
    // A cannon finished, or the program ended: the next cannon gets its own rounds and failures
    void NewCannon()
    {
        ReleaseProtection();
        roundsThisCannon = 0;
        failed.resize(0);
    }

    // ------------------------------------------------------------------ the index

    array<CCircuitUnit@> sUnit;
    array<AIFloat3> sPos;
    array<float> sHalf, sCost;
    array<int> sOk;                  // Judge: 1 Kind, 2 DeepKind, 0 kept (LineKeeps may still keep a 1 or 2)
    array<bool> sLined;              // LineKeeps already applied
    array<string> sWhy;
    dictionary grid;                 // "cx:cz" -> array<int>@
    int indexFrame = -1;

    string CellKey(int cx, int cz) { return "" + cx + ":" + cz; }
    // One pass over our structures. O(our units); once per Pick.
    void Index()
    {
        if (indexFrame == ai.frame) return;
        indexFrame = ai.frame;
        sUnit.resize(0); sPos.resize(0); sHalf.resize(0); sCost.resize(0); sOk.resize(0); sWhy.resize(0); sLined.resize(0);
        grid.deleteAll();
        array<Id>@ own = ai.GetOwnedUnitIds();
        for (uint i = 0; i < own.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(own[i]);
            if (!ai.IsOwnedUnit(u) || u.circuitDef is null || u.circuitDef.IsMobile()) continue;
            string why;
            const int ok = Judge(u, why);
            const int k = int(sUnit.length());
            sUnit.insertLast(u);
            const AIFloat3 p = u.GetPos(ai.frame);
            sPos.insertLast(p);
            const float h = Half(u.circuitDef);
            sHalf.insertLast(h);
            sCost.insertLast(u.circuitDef.costM);
            sOk.insertLast(ok);
            sLined.insertLast(false);
            sWhy.insertLast(ok == 1 ? "" : u.circuitDef.GetName() + " " + why);
            const int x0 = int((p.x - h) / Cell), x1 = int((p.x + h) / Cell);
            const int z0 = int((p.z - h) / Cell), z1 = int((p.z + h) / Cell);
            for (int cx = x0; cx <= x1; ++cx) for (int cz = z0; cz <= z1; ++cz) {
                const string key = CellKey(cx, cz);
                array<int>@ list = null;
                if (!grid.get(key, @list) || list is null) { @list = array<int>(); grid.set(key, @list); }
                list.insertLast(k);
            }
        }
        // Construction turrets count only as the commander group's porc turrets: one beside our porc or pop-up
        // artillery (within NanoPorcRadius) and not beside a factory (a factory's cluster) nor round a
        // lolcannon this program built (its own turret block). O(nanos x structures in their cells).
        array<int> near;
        const float r = NanoPorcRadius;
        for (uint k = 0; k < sUnit.length(); ++k) {
            if (sOk[k] != 2 || !UnitHelpers::IsT1Nano(sUnit[k].circuitDef.GetName())) continue;
            string why = "";
            for (uint g = 0; g < keepAround.length() && why.length() == 0; ++g)
                if (sPos[k].SqDistance2D(keepAround[g]) < 900.0f * 900.0f) why = "a lolcannon's turret block";
            bool porc = false;
            if (why.length() == 0) {
                Blockers(sPos[k], r, r, near);
                for (uint i = 0; i < near.length() && why.length() == 0; ++i) {
                    if (!ai.IsOwnedUnit(sUnit[near[i]])) continue;
                    const string n = sUnit[near[i]].circuitDef.GetName();
                    if (IsFactory(n)) why = "a factory's turret";
                    else if (Global::Team::AllyClearPorc.find(n) >= 0 || Global::LolCannon::ClearExtraKinds.find(n) >= 0
                        || (DeepKind(n) && !UnitHelpers::IsT1Nano(n))) porc = true;
                }
                if (why.length() == 0 && !porc) why = "not beside our porc";
            }
            if (why.length() == 0) continue;
            sOk[k] = 0;
            sWhy[k] = sUnit[k].circuitDef.GetName() + " " + why;
        }
    }
    const float NanoPorcRadius = 400.0f;
    array<AIFloat3> keepAround;      // LolCannon's finished cannons (doneSites): their turret blocks are kept
    // Our structures overlapping the rectangle (each once). O(structures in its cells).
    void Blockers(const AIFloat3 &in c, float hx, float hz, array<int>@ res)
    {
        res.resize(0);
        const int x0 = int((c.x - hx) / Cell), x1 = int((c.x + hx) / Cell);
        const int z0 = int((c.z - hz) / Cell), z1 = int((c.z + hz) / Cell);
        for (int cx = x0; cx <= x1; ++cx) for (int cz = z0; cz <= z1; ++cz) {
            array<int>@ list = null;
            if (!grid.get(CellKey(cx, cz), @list) || list is null) continue;
            for (uint i = 0; i < list.length(); ++i) {
                const int k = list[i];
                if (abs(sPos[k].x - c.x) >= hx + sHalf[k] || abs(sPos[k].z - c.z) >= hz + sHalf[k]) continue;
                if (res.find(k) < 0) res.insertLast(k);
            }
        }
    }

    // ------------------------------------------------------------------ pick and start

    // Pick counters of the last call (the "no clearable site" line)
    int pTested = 0, pFront = 0, pKept = 0, pMany = 0, pAllyOnly = 0;
    string pFirstKept = "";
    int pKeptShown = 0;

    // Is candidate p (facing f, rectangle c/hx/hz, against `tgt`) clearable? -1 kept, -2 front, -3 too many,
    // -4 ally-only already asked; else the number of our blockers (0: ask the allies only). Needs Index().
    int Assess(const AIFloat3 &in p, const AIFloat3 &in tgt, const AIFloat3 &in c, float hx, float hz, array<int>@ hit, float &out metal)
    {
        metal = 0.0f;
        string how;
        if (SiteBehind(p, tgt, how) < Global::LolCannon::ClearFrontMargin) return -2;
        Blockers(c, hx, hz, hit);
        for (uint i = 0; i < hit.length(); ++i) {
            const int k = hit[i];
            if (sOk[k] > 0 && !sLined[k]) {
                // the porc front line, once per structure per Index (cached)
                sLined[k] = true;
                const string keep = LineKeeps(sUnit[k].circuitDef.GetName(), sPos[k]);
                if (keep.length() > 0) { sOk[k] = 0; sWhy[k] = sUnit[k].circuitDef.GetName() + " " + keep; }
            }
            if (sOk[k] == 0) {
                // the first kept structure of up to 4 candidates, for the "no clearable site" line
                if (pKeptShown < 4) { pFirstKept += (pKeptShown > 0 ? "; " : "") + sWhy[k] + " at " + At(sPos[k]); ++pKeptShown; }
                return -1;
            }
            metal += sCost[k];
        }
        if (int(hit.length()) > Global::LolCannon::ClearMaxBlockers || metal > Global::LolCannon::ClearMaxMetal) return -3;
        return int(hit.length());
    }

    // TECH's [RECLAIM] audit names the source "lolcannon" (reclaim_policy.as Audit) - only for a refund that
    // fits the bank: an attributed reclaim that overflows is INV-209; past the gate it stays "native", as
    // T3Unstick's ungated reclaims do (owner, 2026-11-18: the site's reclaims ignore TECH's bank gate)
    void Attribute(CCircuitUnit@ b)
    {
        if (Global::AISettings::Role != AiRole::TECH || !ai.IsOwnedUnit(b)) return;
        string why;
        if (!TechReclaim::Fits(b, why)) return;
        TechReclaim::lastSource = "lolcannon";
        TechReclaim::lastTarget = b.id;
    }

    // Start a round on p: our blockers reclaimed, the allies asked. False: nothing could be ordered or asked.
    bool Start(const AIFloat3 &in p, int f, int s, const AIFloat3 &in tgt, const AIFloat3 &in c, float hx, float hz,
        const array<int> &in hit, const string &in why, const CCircuitDef@ gun)
    {
        Release(false);
        ReleaseProtection();
        site = p; facing = f; startIndex = s; target = tgt;
        rectCentre = c; rectHX = hx; rectHZ = hz;
        if (Global::AISettings::Role == AiRole::TECH) {
            // Admission precedes Enqueue: callbacks can assign new construction.
            clearingZone = aiTerrainMgr.ReserveClearingZone(c, 0, hx, hz);
            if (clearingZone <= 0) { Log("site " + At(site) + ": clearing lease refused; existing plans kept"); return false; }
            @clearingGun = gun;
            nextReserve = ai.frame;
            TryReserveEarly();
        }
        const int timeout = Global::LolCannon::ClearRoundSeconds * SECOND;
        string list = "";
        float metal = 0.0f;
        for (uint i = 0; i < hit.length(); ++i) {
            CCircuitUnit@ b = sUnit[hit[i]];
            if (!ai.IsOwnedUnit(b)) continue;
            const int bid = b.id;
            const string name = b.circuitDef.GetName();
            // owner, 2026-11-18 (as T3Unstick): past TECH's bank gate, never an energy storage (Kind keeps those)
            if (!Allowed(name) || aiBuilderMgr.IsReclaimProtected(b.circuitDef)) { list += " " + name + "(kept)"; continue; }
            Attribute(b);   // the [RECLAIM] audit line
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, b, timeout));
            if (t is null || t.IsDead()) { list += " " + name + "(no task)"; continue; }
            @b = ai.GetTeamUnit(bid);   // Enqueue may dispatch callbacks: read the blocker again by id
            if (!ai.IsOwnedUnit(b)) { aiBuilderMgr.AbortTask(t); continue; }
            const string key = "" + bid;
            blockers.insertLast(bid);
            blockerAt.insertLast(b.GetPos(ai.frame));
            blockerHalf.insertLast(Half(b.circuitDef));
            blockerName.insertLast(name);
            blockerUnit.set(key, @b);
            reclaimTask.set(key, @t);
            metal += b.circuitDef.costM;
            bool lk = false;
            const float behind = IsPorcKind(name) || DeepKind(name) ? PorcFrontLine::Behind(blockerAt[blockerAt.length() - 1], lk) : 0.0f;
            list += " " + name + " " + bid + (Kind(name) ? "" : "(deep)") + (lk ? "(+" + int(behind) + ")" : "");
        }
        ++roundsThisCannon; ++nRounds;
        allyKey = "lc." + ai.teamId + "." + nRounds;
        const bool asked = Team::AllyClear::Hold(allyKey, rectCentre, rectHX, rectHZ);
        if (blockers.length() == 0 && !asked) {
            ReleaseProtection();
            failed.insertLast(site);
            Log("site " + At(site) + ": nothing could be ordered and no allied SMRTBARb to ask; dropped");
            return false;
        }
        active = true;
        roundStart = ai.frame;
        lastPull = -100000;
        nextLog = ai.frame + 30 * SECOND;
        Log("round " + roundsThisCannon + " of " + Global::LolCannon::ClearMaxRounds + " at " + At(site) + " facing " + facing
            + " (" + why + "): reclaiming " + blockers.length() + " (" + int(metal) + " M) [" + list + " ]"
            + (asked ? ", allied SMRTBARbs asked (" + allyKey + ")" : ""));
        return true;
    }

    // Abort the round's reclaims still open (their builders go idle) and forget its blockers
    void Release(bool abort)
    {
        for (uint i = 0; i < blockers.length(); ++i) {
            IUnitTask@ t = null;
            if (abort && reclaimTask.get("" + blockers[i], @t) && t !is null && !t.IsDead()) aiBuilderMgr.AbortTask(t);
        }
        blockers.resize(0); blockerAt.resize(0); blockerHalf.resize(0); blockerName.resize(0);
        blockerUnit.deleteAll();
        reclaimTask.deleteAll();
    }

    CCircuitUnit@ Live(int id)
    {
        CCircuitUnit@ b = null;
        if (!blockerUnit.get("" + id, @b) || !ai.IsOwnedUnit(b)) return null;
        return b;
    }

    // ------------------------------------------------------------------ the round

    // True while the round still has work (live blockers, or the allies' answer / gifts), within ClearRoundSeconds
    bool Busy()
    {
        if (!active) return false;
        if (ai.frame - roundStart >= Global::LolCannon::ClearRoundSeconds * SECOND) return false;
        for (uint i = 0; i < blockers.length(); ++i) if (Live(blockers[i]) !is null) return true;
        return Team::AllyClear::Busy(allyKey);
    }

    // Every second from LolCannon's CLEAR phase: turrets in reach onto the open reclaims every 10 s,
    // a short progress line every 30 s. O(blockers).
    void Tick(int crew)
    {
        if (!active) return;
        TryReserveEarly();
        if (ai.frame - lastPull >= 10 * SECOND) {
            lastPull = ai.frame;
            for (uint i = 0; i < blockers.length(); ++i)
                if (Live(blockers[i]) !is null) aiBuilderMgr.TurretsOnReclaim(blockers[i], Global::T3Unstick::TurretMargin, true, false);
        }
        if (ai.frame < nextLog) return;
        nextLog = ai.frame + 30 * SECOND;
        int left = 0, workers = 0;
        for (uint i = 0; i < blockers.length(); ++i) {
            if (Live(blockers[i]) is null) continue;
            ++left;
            IUnitTask@ t = null;
            if (reclaimTask.get("" + blockers[i], @t) && t !is null && !t.IsDead()) workers += int(t.GetUnits().length());
        }
        Log("round at " + At(site) + ": " + left + " of " + blockers.length() + " blockers left, " + workers + " unit(s) reclaiming, crew "
            + crew + ", " + ((ai.frame - roundStart) / SECOND) + "/" + Global::LolCannon::ClearRoundSeconds + " s"
            + (Team::AllyClear::Busy(allyKey) ? ", allied gifts pending" : ""));
    }

    // The round is over (Busy false, or LolCannon gives it up): open reclaims aborted, gone blockers
    // leave TECH's plans. Returns what still stands ("" none).
    string End(const string &in why)
    {
        string left = "";
        int gone = 0;
        for (uint i = 0; i < blockers.length(); ++i) {
            CCircuitUnit@ b = Live(blockers[i]);
            if (b !is null) { left += " " + blockerName[i] + " " + blockers[i]; continue; }
            ++gone;
            T3Unstick::AddCleared(blockerAt[i], blockerHalf[i], "lolcannon site blocker " + blockerName[i] + " " + blockers[i]);
        }
        nReclaimed += gone;
        Log("round at " + At(site) + " ended (" + why + ") after " + ((ai.frame - roundStart) / SECOND) + " s: " + gone + " of "
            + blockers.length() + " blockers gone" + (left.length() > 0 ? ", still standing [" + left + " ]" : ""));
        Release(true);
        active = false;
        return left;
    }
    // LolCannon tried the cleared site: it holds now, or not (dropped for this cannon)
    void Result(bool ok)
    {
        ReleaseProtection();
        if (ok) { ++nCleared; Log("site " + At(site) + " reserved after clearing | picks " + nPicks + ", rounds " + nRounds
            + ", cleared " + nCleared + ", still blocked " + nBlocked + ", blockers reclaimed " + nReclaimed); return; }
        ++nBlocked;
        failed.insertLast(site);
        Log("site " + At(site) + " still not reservable after clearing; dropped (" + nBlocked + " so far)");
    }

    // A lolcannon crew member in CLEAR: the nearest live blocker with fewer than ClearCrewPerBlocker on its
    // reclaim (re-enqueued when its task died), else a building an ally gave us. Null: nothing to do.
    IUnitTask@ CrewTask(CCircuitUnit@ u)
    {
        if (!active || !ai.IsOwnedUnit(u)) return null;
        const int cap = AiMax(1, Global::LolCannon::ClearCrewPerBlocker);
        const AIFloat3 upos = u.GetPos(ai.frame);
        CCircuitUnit@ best = null;
        float bestSq = 1.0e30f;
        for (uint i = 0; i < blockers.length(); ++i) {
            CCircuitUnit@ b = Live(blockers[i]);
            if (b is null || b is u) continue;
            IUnitTask@ live = null;
            if (reclaimTask.get("" + b.id, @live) && Team::AllyClear::LiveReclaim(live, b)) {
                if (live is u.task) return live;   // already on it
                if (int(live.GetUnits().length()) >= cap) continue;
            }
            const float sq = upos.SqDistance2D(b.GetPos(ai.frame));
            if (sq < bestSq) { bestSq = sq; @best = b; }
        }
        if (best is null) return Team::AllyClear::BuilderTask(u);
        const int bid = best.id, uid = u.id;
        IUnitTask@ live = null;
        if (reclaimTask.get("" + bid, @live) && Team::AllyClear::LiveReclaim(live, best)) return live;
        if (!Allowed(best.circuitDef.GetName())) return null;
        Attribute(best);
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, best, Global::LolCannon::ClearRoundSeconds * SECOND));
        if (t is null || t.IsDead()) return null;
        @best = ai.GetTeamUnit(bid);
        if (!ai.IsOwnedUnit(best)) { aiBuilderMgr.AbortTask(t); return null; }
        reclaimTask.set("" + bid, @t);
        @u = ai.GetTeamUnit(uid);
        return ai.IsOwnedUnit(u) ? t : null;
    }
}  // namespace LolCannonClear
