#include "../../helpers/construction/support_site_helpers.as"

// FRONT gantry caretakers (owner, 2026-11-12; Front::GantryCaretakers*). Played (Tartarus Steppes on
// GreenParrots, 2026-11-11): FRONT T3 gantries finished with few construction turrets and added the
// rest slowly. FRONT's T1 constructors are seated (FrontConstructors) and answer only their seat's work,
// so no turret provider ever reached them; the native assist and Front_TryBuildNano added one now and
// then. Now, as TECH's t3rush gantry cluster does (tech_gantry.as T3RushTurret / SupportOrder):
//   - the moment a land gantry of ours is framed it rolls GantryCaretakersMin..Max turrets and reserves a
//     turret block behind it (native ReserveNanoBlockAt with the gantry's real facing, the biggest full
//     block that holds the roll, else the fullest partial one; layout is opened only for the reservation,
//     as FrontSiloGrid / FrontLabPorc do). Orders are pinned to the block's slots; past the block (or with
//     no block) they fall back to an engine-sited turret beside the gantry;
//   - FRONT requisitions up to GantryCaretakerCons T1 constructors at high priority (nearest first, within
//     GantryCaretakerReach; busy ones too, except a constructor on a factory frame, a retreat, a player or
//     external order, or a tactical / agitator crew) with aiBuilderMgr.AssignTask: each gets a turret order
//     (up to GantryCaretakerParallel open), else helps a turret frame of the block;
//   - a requisitioned constructor asking again (native re-evaluation) keeps our task; one between tasks gets
//     the next; when the complement stands, or the gantry is gone, it is dropped from the list and goes
//     back to the idle pool (our open orders aborted only if the gantry died).
// Null guards: every unit is held by id and resolved with ai.GetTeamUnit at each use; every task handle is
// checked for null / IsDead before it is assigned, compared or aborted; a cast to IBuilderTask is checked.
// Cost: while a gantry of ours exists and is short, one owned-unit scan every GantryCaretakerScanSeconds
// (units x 1 def compare, then turrets x gantries + factories); once complete every RecheckSeconds and at
// the +2 / +5 minute logs. Requisition walks the scan's T1 constructors (tens). Gantries are 1-2 per FRONT.
// Log [FRONT][GantryNano]: per gantry at its finish, +2 min and +5 min the standing count (the owner's test).
namespace FrontGantryNanos {
    const int RecheckSeconds = 30;
    const int OrderTimeoutSeconds = 120;
    const int HelpTimeoutSeconds = 30;
    const int OrphanSeconds = 5;       // an order with nobody on it this long after it was handed out is free to take
    const int FallbackFailLimit = 6;   // pinned orders dying unframed in a row before engine-sited turrets

    // block shapes tried, biggest useful first (cols, rows); rows stay within a turret's reach of the gantry
    const array<int> Shapes = { 5, 3, 7, 2, 4, 4, 6, 3, 8, 2, 4, 3, 6, 2, 3, 3, 5, 2, 4, 2, 3, 2 };

    bool On() {
        return Global::AISettings::Role == AiRole::FRONT && Global::RoleSettings::Front::GantryCaretakersMax > 0;
    }

    class Gantry {
        int id = -1;
        string defName;
        AIFloat3 pos;
        int facing = 0;
        int want = 0;
        int group = 0;          // turret block (0: none, engine-sited turrets)
        int held = 0;           // slots the block holds
        int standing = 0;       // last scan
        int framed = 0;
        int seenFrame = -1;
        int finishFrame = -1;   // first scan that saw it finished
        int completeFrame = -1;
        int fails = 0;          // our orders that died unframed in a row
        bool alive = true;
        bool log0 = false, log2 = false, log5 = false;
    }
    array<Gantry@> gantries;

    // our turret orders (each for one gantry, maybe pinned to a slot) and frame-repair tasks
    array<IUnitTask@> orders;
    array<int> orderGantry;
    array<int> orderGiven;      // constructors each order has been handed to
    array<int> orderFrame;      // last frame each order was handed out (AssignTask lands its unit a frame later)
    array<IUnitTask@> helps;
    array<int> helpGantry;
    // requisitioned constructors, by id
    array<int> cons;

    CCircuitDef@ nanoDef = null;
    array<CCircuitDef@> gantryDefs;
    array<CCircuitUnit@> scanNanos;   // reused by Scan
    array<int> scanCons;              // T1 constructors seen by the last scan
    int lastScan = -100000;
    int lastLog = -100000;

    void Reset() {
        gantries.resize(0); orders.resize(0); orderGantry.resize(0); orderGiven.resize(0); orderFrame.resize(0);
        helps.resize(0); helpGantry.resize(0); cons.resize(0); scanCons.resize(0); scanNanos.resize(0);
        @nanoDef = null; gantryDefs.resize(0); lastScan = -100000;
    }

    void Defs() {
        if (nanoDef !is null) return;
        @nanoDef = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        array<string> names = UnitHelpers::GetAllLandGantries();
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null) gantryDefs.insertLast(d);
        }
    }

    int GantryCount() {
        int n = 0;
        for (uint i = 0; i < gantryDefs.length(); ++i) n += gantryDefs[i].count;
        return n;
    }

    Gantry@ Find(int id) {
        for (uint i = 0; i < gantries.length(); ++i) if (gantries[i].id == id) return gantries[i];
        return null;
    }

    bool Live(IUnitTask@ t) { return t !is null && !t.IsDead(); }
    int LiveOrders(int gid) {
        int n = 0;
        for (uint i = 0; i < orders.length(); ++i) if (orderGantry[i] == gid && Live(orders[i])) ++n;
        return n;
    }
    // turrets standing, framed or ordered by us (an order of ours that has framed is one of the frames)
    int Committed(Gantry@ g) { return g.standing + AiMax(g.framed, LiveOrders(g.id)); }
    bool Short(Gantry@ g) { return g.alive && (g.standing < g.want); }

    bool IsOurs(IUnitTask@ t) {
        if (!Live(t)) return false;
        for (uint i = 0; i < orders.length(); ++i) if (orders[i] is t) return true;
        for (uint i = 0; i < helps.length(); ++i) if (helps[i] is t) return true;
        return false;
    }
    bool IsCon(int id) { return cons.find(id) >= 0; }
    void Release(int id, const string &in why) {
        const int k = cons.find(id);
        if (k < 0) return;
        cons.removeAt(k);
        GenericHelpers::LogUtil("[FRONT][GantryNano] constructor " + id + " back to the idle pool: " + why, 1);
    }

    string Clock(int frame) { return FrontEcoLadder::Clock(frame); }

    // ------------------------------------------------------------ block

    void ReleaseBlock(int group) {
        if (group <= 0) return;
        const int zone = aiTerrainMgr.GetGroupZone(group);
        if (zone > 0) aiTerrainMgr.ReleaseZone(zone); else aiTerrainMgr.ReleaseGroup(group);
    }

    // The biggest full block behind the gantry that holds g.want, else the fullest partial one
    void Reserve(Gantry@ g, CCircuitUnit@ unit) {
        if (g is null || unit is null || unit.circuitDef is null || nanoDef is null) return;
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            GenericHelpers::LogUtil("[FRONT][GantryNano] the profile's layout gate is closed: engine-sited turrets for gantry " + g.id, 1);
            return;
        }
        int best = 0, bestN = 0, bestC = 0, bestR = 0;
        for (uint s = 0; s + 1 < Shapes.length(); s += 2) {
            const int c = Shapes[s], r = Shapes[s + 1];
            if (c * r < g.want && bestN >= g.want) continue;
            const int grp = aiTerrainMgr.ReserveNanoBlockAt(nanoDef, unit.circuitDef, g.pos, g.facing, c, r, 0);
            const int n = grp > 0 ? aiTerrainMgr.GetGroupCount(grp, false) : 0;
            if (n > bestN) {
                if (best > 0) ReleaseBlock(best);
                best = grp; bestN = n; bestC = c; bestR = r;
                if (n >= g.want) break;   // the first (biggest useful) shape that holds the roll
            } else if (grp > 0) ReleaseBlock(grp);
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        g.group = best; g.held = bestN;
        GenericHelpers::LogUtil("[FRONT][GantryNano] " + g.defName + " " + g.id + " at (" + int(g.pos.x) + ", " + int(g.pos.z) + ") facing " + g.facing
            + ": " + g.want + " caretakers; " + (best > 0 ? "turret block " + bestC + "x" + bestR + " holds " + bestN
                + (bestN < g.want ? " (the rest engine-sited)" : "") : "no turret block (engine-sited turrets)"), 1);
    }

    // ------------------------------------------------------------ scan

    void Scan() {
        lastScan = ai.frame;
        for (uint i = 0; i < gantries.length(); ++i) { gantries[i].alive = false; gantries[i].standing = 0; gantries[i].framed = 0; }
        scanNanos.resize(0); scanCons.resize(0);
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (d is nanoDef) { scanNanos.insertLast(u); continue; }
            if (d.IsMobile()) {
                if (!UnitHelpers::IsCommander(d) && UnitHelpers::GetConstructorTier(d) == 1 && nanoDef !is null && d.CanBuild(nanoDef))
                    scanCons.insertLast(u.id);
                continue;
            }
            bool isGantry = false;
            for (uint k = 0; k < gantryDefs.length() && !isGantry; ++k) isGantry = (d is gantryDefs[k]);
            if (!isGantry) continue;
            Gantry@ g = Find(u.id);
            if (g is null) {
                @g = Gantry();
                g.id = u.id; g.defName = d.GetName(); g.pos = u.GetPos(ai.frame);
                g.facing = aiTerrainMgr.GetBuildingFacing(u);
                if (g.facing < 0 || g.facing > 3) g.facing = 0;
                const int lo = AiMax(1, Global::RoleSettings::Front::GantryCaretakersMin);
                const int hi = AiMax(lo, Global::RoleSettings::Front::GantryCaretakersMax);
                g.want = AiMax(lo, AiMin(hi, AiRandom(lo, hi)));
                g.seenFrame = ai.frame;
                gantries.insertLast(g);
                Reserve(g, u);
            }
            g.alive = true;
            if (g.finishFrame < 0 && u.GetBuildProgress() >= 1.0f) g.finishFrame = ai.frame;
        }
        // each turret goes to its nearest gantry within reach, unless another factory is nearer
        const float r = Global::RoleSettings::Front::GantryCaretakerRadius;
        for (uint n = 0; n < scanNanos.length(); ++n) {
            const AIFloat3 p = scanNanos[n].GetPos(ai.frame);
            Gantry@ best = null;
            float bestSq = r * r;
            for (uint i = 0; i < gantries.length(); ++i) {
                if (!gantries[i].alive) continue;
                const float sq = MapHelpers::SqDist(p, gantries[i].pos);
                if (sq <= bestSq) { bestSq = sq; @best = gantries[i]; }
            }
            if (best is null) continue;
            bool other = false;
            for (uint f = 0; f < Factory::factoryList.length() && !other; ++f) {
                CCircuitUnit@ fac = Factory::factoryList[f];
                if (fac is null || Find(fac.id) !is null) continue;
                other = MapHelpers::SqDist(p, fac.GetPos(ai.frame)) < bestSq;
            }
            if (other) continue;
            if (scanNanos[n].GetBuildProgress() < 1.0f) best.framed++; else best.standing++;
        }
        scanNanos.resize(0);   // no handles kept past this frame
        // dead gantries: abort their open work (the constructors fall idle), free the block, forget them
        for (int i = int(gantries.length()) - 1; i >= 0; --i) {
            Gantry@ g = gantries[i];
            if (g.alive) { Report(g); continue; }
            for (uint k = 0; k < orders.length(); ++k) if (orderGantry[k] == g.id && Live(orders[k])) aiBuilderMgr.AbortTask(orders[k]);
            for (uint k = 0; k < helps.length(); ++k) if (helpGantry[k] == g.id && Live(helps[k])) aiBuilderMgr.AbortTask(helps[k]);
            ReleaseBlock(g.group);
            GenericHelpers::LogUtil("[FRONT][GantryNano] " + g.defName + " " + g.id + " is gone; its turret work ends", 1);
            gantries.removeAt(i);
        }
        Prune();
    }

    void Prune() {
        for (int i = int(orders.length()) - 1; i >= 0; --i)
            if (!Live(orders[i])) { orders.removeAt(i); orderGantry.removeAt(i); orderGiven.removeAt(i); orderFrame.removeAt(i); }
        for (int i = int(helps.length()) - 1; i >= 0; --i)
            if (!Live(helps[i])) { helps.removeAt(i); helpGantry.removeAt(i); }
        // a requisitioned constructor that is dead, or was moved off our work onto something else
        for (int i = int(cons.length()) - 1; i >= 0; --i) {
            CCircuitUnit@ u = ai.GetTeamUnit(cons[i]);
            if (u is null) { cons.removeAt(i); continue; }
            IUnitTask@ t = u.task;
            if (t is null || t.IsDead() || IsOurs(t)) continue;
            const int type = t.GetType();
            if (type == int(Task::Type::IDLE) || type == int(Task::Type::NIL) || type == int(Task::Type::WAIT)) continue;
            IBuilderTask@ b = cast<IBuilderTask>(t);
            Release(cons[i], "moved to other work (task type " + type + (b is null ? "" : ", build type " + b.GetBuildType()) + ")");
        }
        bool any = false;
        for (uint i = 0; i < gantries.length() && !any; ++i) any = Short(gantries[i]);
        if (!any) while (cons.length() > 0) Release(cons[cons.length() - 1], "every gantry has its caretakers");
    }

    // the owner's test: standing turrets at the gantry's finish, +2 min and +5 min; and when complete
    void Report(Gantry@ g) {
        if (g.completeFrame < 0 && g.standing >= g.want) {
            g.completeFrame = ai.frame;
            GenericHelpers::LogUtil("[FRONT][GantryNano] " + g.defName + " " + g.id + " complete: " + g.standing + "/" + g.want + " turrets at " + Clock(ai.frame)
                + (g.finishFrame >= 0 ? " (" + ((ai.frame - g.finishFrame) / SECOND) + " s after its finish)" : " (before its finish)"), 1);
        }
        if (g.finishFrame < 0) return;
        const int after = ai.frame - g.finishFrame;
        string tag = "";
        if (!g.log0) { g.log0 = true; tag = "at finish"; }
        else if (!g.log2 && after >= 120 * SECOND) { g.log2 = true; tag = "+2 min"; }
        else if (!g.log5 && after >= 300 * SECOND) { g.log5 = true; tag = "+5 min"; }
        if (tag.length() == 0) return;
        GenericHelpers::LogUtil("[FRONT][GantryNano] " + g.defName + " " + g.id + " " + tag + " (" + Clock(ai.frame) + "): "
            + g.standing + "/" + g.want + " turrets standing, " + g.framed + " framed, " + LiveOrders(g.id) + " ordered, "
            + cons.length() + " constructors requisitioned | M +" + int(Economy::GetMinMetalIncomeLast10s()) + " bank " + int(aiEconomyMgr.metal.current), 1);
    }

    bool ReportDue() {
        for (uint i = 0; i < gantries.length(); ++i) {
            Gantry@ g = gantries[i];
            if (g.finishFrame < 0) continue;
            const int after = ai.frame - g.finishFrame;
            if ((!g.log2 && after >= 120 * SECOND) || (!g.log5 && after >= 300 * SECOND)) return true;
        }
        return false;
    }

    // ------------------------------------------------------------ work

    // A T1 constructor FRONT may requisition: idle or busy, but not on a factory frame, retreating, under a
    // player's or an external order, or one of the tactical / agitator crews
    bool Eligible(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null || nanoDef is null) return false;
        if (UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 1 || !u.circuitDef.CanBuild(nanoDef)) return false;
        if (Team::Ferry::IsGift(u.id) || Team::Recovery::IsGift(u.id)) return false;
        if (FrontTactical::Owns(u) || FrontAgitator::OnOrder(u) || CommanderGroup::Owns(u.id)) return false;
        IUnitTask@ t = u.task;
        if (t is null || t.IsDead()) return true;
        if (t.IsExternalControlled() || t.GetType() == int(Task::Type::PLAYER) || t.GetType() == int(Task::Type::RETREAT)) return false;
        IBuilderTask@ b = cast<IBuilderTask>(t);
        if (b !is null && !b.IsDead() && b.target !is null && Task::BuildType(b.GetBuildType()) == Task::BuildType::FACTORY) return false;
        return true;
    }

    IUnitTask@ Track(IUnitTask@ t, Gantry@ g) {
        if (t is null || g is null) return null;
        orders.insertLast(t); orderGantry.insertLast(g.id); orderGiven.insertLast(1); orderFrame.insertLast(ai.frame);
        Builder::MarkNanoEnqueued();
        return t;
    }

    // The next turret work at gantry g for constructor u: an order of ours nobody is on, a new order (a free
    // block slot, else engine-sited), or a turret frame to help
    IUnitTask@ Next(CCircuitUnit@ u, Gantry@ g) {
        if (u is null || u.circuitDef is null || g is null || !g.alive || nanoDef is null) return null;
        for (uint i = 0; i < orders.length(); ++i) {
            if (orderGantry[i] != g.id || !Live(orders[i])) continue;
            if (ai.frame - orderFrame[i] < OrphanSeconds * SECOND) continue;   // just handed out: its unit may not be on it yet
            array<CCircuitUnit@>@ on = orders[i].GetUnits();
            if (on !is null && on.length() > 0) continue;
            if (orderGiven[i] >= 2) { aiBuilderMgr.AbortTask(orders[i]); continue; }   // left twice: its site is bad
            orderGiven[i]++; orderFrame[i] = ai.frame;
            return orders[i];
        }
        if (Committed(g) < g.want && LiveOrders(g.id) < AiMax(1, Global::RoleSettings::Front::GantryCaretakerParallel)) {
            // the energy-based turret cap is raised by Cap at the next economy update; until then by one
            if (nanoDef.maxThisUnit >= 0 && nanoDef.count >= nanoDef.maxThisUnit) nanoDef.maxThisUnit = nanoDef.count + 1;
            if (nanoDef.IsAvailable(ai.frame)) {
                const int slot = (g.group > 0 && g.fails < FallbackFailLimit) ? SupportSites::Nearest(u, nanoDef, g.group, g.pos) : -1;
                if (slot >= 0) {
                    const AIFloat3 at = aiTerrainMgr.GetReservationPos(slot);
                    IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO, Task::Priority::HIGH, nanoDef, at, 0.0f, true, OrderTimeoutSeconds * SECOND));
                    if (t !is null && !AiPinReservation(t, slot)) { aiBuilderMgr.AbortTask(t); @t = null; }
                    if (t !is null) {
                        GenericHelpers::LogUtil("[FRONT][GantryNano] turret " + (Committed(g) + 1) + "/" + g.want + " for " + g.defName + " " + g.id
                            + " on block slot " + slot + " by " + u.circuitDef.GetName() + " " + u.id, 2);
                        return Track(t, g);
                    }
                }
                // no block, the block full or refused, or its orders keep dying: an engine-sited turret beside the gantry
                if (g.group <= 0 || slot < 0 || g.fails >= FallbackFailLimit) {
                    IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO, Task::Priority::HIGH, nanoDef, g.pos,
                        SQUARE_SIZE * 24, true, OrderTimeoutSeconds * SECOND));
                    if (t !is null) {
                        GenericHelpers::LogUtil("[FRONT][GantryNano] turret " + (Committed(g) + 1) + "/" + g.want + " for " + g.defName + " " + g.id
                            + " engine-sited by " + u.circuitDef.GetName() + " " + u.id, 2);
                        return Track(t, g);
                    }
                }
            }
        }
        CCircuitUnit@ frame = aiBuilderMgr.FindUnfinishedNear(g.pos, Global::RoleSettings::Front::GantryCaretakerRadius, nanoDef);
        if (frame is null) return null;
        IUnitTask@ r = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, frame, HelpTimeoutSeconds * SECOND));
        if (r !is null && helps.findByRef(r) < 0) { helps.insertLast(r); helpGantry.insertLast(g.id); }
        return r;
    }

    // the short gantry nearest u within reach
    Gantry@ NearestShort(CCircuitUnit@ u) {
        if (u is null) return null;
        const AIFloat3 p = u.GetPos(ai.frame);
        const float reach = Global::RoleSettings::Front::GantryCaretakerReach;
        Gantry@ best = null;
        float bestSq = reach * reach;
        for (uint i = 0; i < gantries.length(); ++i) {
            Gantry@ g = gantries[i];
            if (!Short(g)) continue;
            const float sq = MapHelpers::SqDist(p, g.pos);
            if (sq <= bestSq) { bestSq = sq; @best = g; }
        }
        return best;
    }

    // builder.as AiMakeTask, first in the FRONT block: a requisitioned constructor keeps our task (native
    // re-evaluation), or between tasks gets the next one; none left: it goes back to the idle pool
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || !IsCon(u.id)) return null;
        if (IsOurs(u.task)) return u.task;
        if (FrontRecovery::Active()) { Release(u.id, "the base is being retaken"); return null; }
        IUnitTask@ t = Next(u, NearestShort(u));
        if (t is null) Release(u.id, "no turret work left in reach");
        return t;
    }

    // Front_MainUpdate, every second: refresh, then requisition constructors for short gantries
    void Tick() {
        if (!On()) return;
        Defs();
        if (nanoDef is null || gantryDefs.length() == 0) return;
        if (gantries.length() == 0 && GantryCount() == 0) return;
        bool open = GantryCount() != int(gantries.length());
        for (uint i = 0; i < gantries.length() && !open; ++i) open = Short(gantries[i]);
        const int every = (open ? AiMax(1, Global::RoleSettings::Front::GantryCaretakerScanSeconds) : RecheckSeconds) * SECOND;
        if (ai.frame - lastScan < every && !ReportDue()) return;
        Scan();
        if (open) Requisition();
    }

    void Requisition() {
        if (FrontRecovery::Active()) return;
        const int maxCons = AiMax(0, Global::RoleSettings::Front::GantryCaretakerCons);
        for (uint gi = 0; gi < gantries.length(); ++gi) {
            Gantry@ g = gantries[gi];
            if (!Short(g)) continue;
            int guard = 0;
            while (int(cons.length()) < maxCons && int(cons.length()) < g.want - g.standing && guard++ < maxCons) {
                // the nearest eligible constructor not yet ours
                int pick = -1;
                float bestSq = Global::RoleSettings::Front::GantryCaretakerReach * Global::RoleSettings::Front::GantryCaretakerReach;
                for (uint i = 0; i < scanCons.length(); ++i) {
                    if (IsCon(scanCons[i])) continue;
                    CCircuitUnit@ c = ai.GetTeamUnit(scanCons[i]);
                    if (c is null || !Eligible(c) || IsOurs(c.task)) continue;
                    const float sq = MapHelpers::SqDist(c.GetPos(ai.frame), g.pos);
                    if (sq > bestSq || !aiTerrainMgr.CanReachAt(c, g.pos, Global::RoleSettings::Front::GantryCaretakerRadius)) continue;
                    bestSq = sq; pick = scanCons[i];
                }
                if (pick < 0) break;
                CCircuitUnit@ u = ai.GetTeamUnit(pick);
                if (u is null) break;
                IUnitTask@ was = u.task;
                const string wasName = (was is null || was.IsDead()) ? "idle" : ("task type " + was.GetType());
                IUnitTask@ t = Next(u, g);
                if (!Live(t)) break;   // nothing to hand out at this gantry now
                aiBuilderMgr.AssignTask(u, t);
                cons.insertLast(pick);
                if (ai.frame - lastLog >= 5 * SECOND) {
                    lastLog = ai.frame;
                    CCircuitUnit@ again = ai.GetTeamUnit(pick);   // re-resolved: AssignTask may have changed its state
                    GenericHelpers::LogUtil("[FRONT][GantryNano] requisitioned " + (again is null || again.circuitDef is null ? "?" : again.circuitDef.GetName())
                        + " " + pick + " (" + wasName + ") for " + g.defName + " " + g.id + ": " + g.standing + "/" + g.want + " standing, "
                        + g.framed + " framed, " + LiveOrders(g.id) + " ordered, " + cons.length() + " constructors", 1);
                }
            }
        }
    }

    // Front_IncomeNanoLimits: the turret cap, raised by the turrets the gantries still need
    int Cap(int energyCap) {
        if (!On() || nanoDef is null) return energyCap;
        int missing = 0;
        for (uint i = 0; i < gantries.length(); ++i)
            if (gantries[i].alive) missing += AiMax(0, gantries[i].want - gantries[i].standing - gantries[i].framed);
        return missing > 0 ? AiMax(energyCap, nanoDef.count + missing) : energyCap;
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        for (uint i = 0; i < orders.length(); ++i) {
            if (orders[i] !is task) continue;
            Gantry@ g = Find(orderGantry[i]);
            if (g !is null) {
                if (done) g.fails = 0;
                else if (++g.fails == FallbackFailLimit)
                    GenericHelpers::LogUtil("[FRONT][GantryNano] " + g.fails + " turret orders for " + g.defName + " " + g.id
                        + " ended unframed in a row: engine-sited turrets from now", 1);
            }
            orders.removeAt(i); orderGantry.removeAt(i); orderGiven.removeAt(i); orderFrame.removeAt(i);
            return;
        }
        for (uint i = 0; i < helps.length(); ++i)
            if (helps[i] is task) { helps.removeAt(i); helpGantry.removeAt(i); return; }
    }
}
