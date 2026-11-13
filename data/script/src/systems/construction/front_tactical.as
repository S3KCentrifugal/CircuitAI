// FRONT tactical launchers against enemy heavy turret clusters (owner, 2026-11-02; Front::Tactical).
//
// Owner: "If the enemy team has at least 2 pulsars or bulwarks or bastions within 700 elmos of each other
// (any type or combination), and if a single FRONT has living mexes or porc within 2250 elmos of a
// pulsar/bulwark/bastion, then task t2 cons assisted by t1 cons to build the special tactical unit
// (paralyzer, catalyst, and perdition) at the edge of its weapon range of the pulsars/bulwarks/bastions if
// the front has at least 150 minimum metal per second last 10 seconds and 5000 energy per second. Each
// front can build 1 of its special tactical unit per bastion/pulsar/bulwark it sees, with each built just
// barely in range of a different bastion/pulsar/bulwark. Use ghost images to calculate the range."
//
// Targets (TacticalTargets): Pulsar armanni, Bulwark cordoom, Bastion legbastion. Known from the shared
// battle snapshot: identified ground contacts in radar / LOS now, plus the ghost images (identified
// structures out of radar and LOS whose spot was not seen empty). Positions are the image's position.
//
// Gate (all of them):
//  - cluster: two known targets (any mix) within TacticalClusterRadius (700) of each other, anywhere;
//  - near us: the target has one of our living, finished mexes or static land guns ("porc") within
//    TacticalFrontRadius (2250). Only such targets get a launcher ("it sees");
//  - economy: 10 s minimum metal income >= TacticalMinMetalIncome (90, was 150 to 2026-11-13; the artillery rules below:
//    TacticalArtiMinMetalIncome, 65) and energy income >=
//    TacticalMinEnergyIncome (5000).
//
// Launcher (TacticalUnits): Paralyzer armemp, Catalyst cortron, Perdition legperdition; a builder takes its
// own faction's first, then any other it can build (traded constructors).
//
// Legion (owner, 2026-11-13; TacticalCatalystTrade): Perditions lacked the damage to kill the heavy turrets.
// A Legion FRONT builds TacticalLegionPerditions (1) Perdition and asks a Cortex FRONT ally for a T2
// constructor (team/catalyst_trade.as); that constructor builds a Catalyst in range of every heavy turret
// (each on its own: with two turrets, one Catalyst in range of each), with no reach limit, guarding the
// Perdition's builder while that order is open. Perditions and Catalysts are matched to targets each on their
// own. No Cortex FRONT ally, or no donor answering: the Perdition cap lifts (the old behaviour).
//
// Heavy static artillery (owner, 2026-11-13; TacticalArtiTargets: Persecutor cortoast, Rattlesnake armamb,
// Eviscerator legacluster), known the same way, at the same TacticalClusterRadius. The 2-porc rule above comes
// first: while two heavy turrets are clustered anywhere it alone runs, and artillery near a heavy turret is left
// to it. Otherwise (BuildSlots):
//  (a) a heavy turret with artillery near it: the full set (TacticalSetSize launchers; a Legion FRONT trading for
//      Catalysts: 1 Perdition + 2 Catalysts), each in range of both;
//  (b) two artillery with no heavy turret near: one launcher in range of both;
//  (c) three or more artillery with no heavy turret near: the full set, each in range of a different pair.
// Each is a slot holding two targets, covered by one launcher of any kind; the site keeps the farther target
// just in range and stays LauncherGap from our launchers (so a set fans out by the +-20 degree turns). Firing:
// launcher_priority lists the artillery as primary, so two Catalysts / Perditions on one fire a synced volley.
//
// One per target: each of our launchers (finished or framed) is matched to one target in its range, the
// one it is nearest to being out of range of (the one it was placed for); a target with no launcher
// matched is open. TacticalMax caps the total standing.
//
// Site: from the target toward our nearest mex / porc within TacticalFrontRadius of it, at the launcher's
// range less TacticalRangeMargin, then pulled in until the height-aware range (aiBattle.EffectiveRange,
// measured from the site to the image) still holds the target with half that margin to spare. A site within
// EdgeGap of a map edge is never used (a clamped point was out of range and never got a constructor, B13):
// the direction is turned by +-20, 40, 60, 80 degrees, then the same directions are walked in down to
// ShortestRangeShare of the range; with none the target is held. Built with TacticalShake of room, small
// enough that the frame stays in range. An order no constructor took within UnmannedSeconds (the placing
// T2 is assigned to it) is aborted as a fail.
//
// Builders: FRONT constructors that can build the launcher (T2), idle / guarding / assisting within
// TacticalReach of the site, or walking to an unframed build within TacticalTakeRadius; one order at a
// time, a second constructor that can build it may join. T1 constructors help (TacticalAssistT1 at most,
// within TacticalAssistReach, never the commander group's seat): they guard the T2 constructor until the
// frame stands, then repair the frame. Update (from Front_EconomyUpdate, every PullSeconds) pulls the
// nearest free / takeable T1s onto the order with AssignTask: only seats 0 and 1 reach AssistPull from
// AiMakeTask, and native re-asks busy builders only now and then, so asked-for help alone never came
// (fixture run 2026-11-02: 6 launchers, 0 T1 helpers). A helper's guard is returned unchanged on a re-ask.
// An order that dies without a launcher holds that target FailHoldSeconds x fails; three in a row,
// TargetHoldSeconds. Every failed order is logged.
//
// Firing is native: the launchers are role "super" statics and CSuperTask aims them.
// Cost: the battle snapshot's ground contacts and ghosts plus one owned-unit scan every TacticalScanSeconds
// while on; O(t^2) over the t known targets. Log [FRONT][Tactical].
namespace FrontTactical {
    const int OrderTimeoutSeconds = 240;
    const int FailHoldSeconds = 30;
    const int TargetHoldSeconds = 240;
    const int AssistGuardSeconds = 60;
    const int PullSeconds = 2;
    const int UnmannedSeconds = 30;      // an order no constructor took by then is aborted as a fail (B13)
    const int FrameDeadlineSeconds = 180; // an order with no frame by then is aborted as a fail
    const float BadSiteRadius = 160.0f;  // a new site keeps this far from a site an order died on
    const uint MaxBadSites = 32;
    const float EdgeGap = 96.0f;       // a site stands this far inside every map edge
    const float ShortestRangeShare = 0.7f;
    const float LauncherGap = 112.0f;  // a new site keeps this far from our launchers
    const int DiagSeconds = 30;

    class Target {
        string key;
        string defName;
        AIFloat3 pos;
        bool ghost = false;
        AIFloat3 asset;        // our nearest mex / porc (valid when near)
        float assetDist = -1.0f;
        bool covered = false;
        bool catCovered = false;   // a Catalyst stands in range of it (Legion trade mode)
        bool perdCovered = false;  // a Perdition stands in range of it (Legion trade mode)
        // artillery rules (slots): a launcher must hold pos and pos2 both; one launcher of any kind covers it
        bool has2 = false;
        AIFloat3 pos2;
        bool single = false;
        string rule = "porc";
    }

    array<CCircuitDef@> launchers;
    array<CCircuitDef@> targetDefs;
    array<CCircuitDef@> artiDefs;  // TacticalArtiTargets: Persecutor, Rattlesnake, Eviscerator
    array<Target@> targets;    // the slots: one launcher each
    array<Target@> heavy;      // known enemy heavy turrets this scan
    array<Target@> artis;      // known enemy heavy static artillery this scan
    array<AIFloat3> launcherPos;   // our launchers (finished or framed) at the last scan
    string lastRules = "";
    array<AIFloat3> assets;    // our living finished mexes and static land guns
    int standing = 0;
    int perdStanding = 0;      // our Perditions (finished or framed)
    int catBuilders = 0;       // our finished mobile constructors that can build a Catalyst (a traded Cortex T2)
    CCircuitDef@ catDef;       // Catalyst cortron
    CCircuitDef@ perdDef;      // Perdition legperdition
    IUnitTask@ catGuard;       // the traded constructor guarding the open order's builder
    int tradedWantedAt = -1;   // when a traded constructor last had a Catalyst to build (TradedWork)
    array<int> staged;         // traded constructors that reached our start (TradedWork), newest last, at most 16
    IUnitTask@ stageTask;      // the walk to our start
    const float StageRadius = 1200.0f;
    bool cluster = false;
    int lastScan = -100000;
    bool defsDone = false;

    IUnitTask@ order;
    string orderKey = "";
    AIFloat3 orderSite;
    IUnitTask@ assist;         // the repair of the order's frame, shared by the T1 helpers
    array<int> helpers;        // T1 constructors on the order, with when their guard / repair is due again
    array<int> helperUntil;
    array<IUnitTask@> helperTask;  // the guard / repair each helper was given
    array<string> announced;   // "G" / "R" + helper id already logged for this order
    int lastPull = -100000;
    int orderFrame = 0;        // when the order was placed
    int orderBy = -1;          // the T2 constructor that placed it
    array<AIFloat3> badSites;  // sites orders died on, oldest first (at most MaxBadSites)
    bool orderManned = false;  // a constructor was on it once
    dictionary diagAt;         // helper skip reason -> frame it may print again
    dictionary fails;          // target key -> fails in a row
    dictionary holds;          // target key -> frame the hold ends
    string lastWhy = "";

    bool On() { return Global::RoleSettings::Front::Tactical && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        launchers.resize(0); targetDefs.resize(0); targets.resize(0); assets.resize(0);
        artiDefs.resize(0); heavy.resize(0); artis.resize(0); launcherPos.resize(0); lastRules = "";
        placedAt.resize(0); placedKey.resize(0);
        standing = 0; perdStanding = 0; catBuilders = 0; cluster = false; lastScan = -100000; defsDone = false;
        @catDef = null; @perdDef = null; @catGuard = null; tradedWantedAt = -1; staged.resize(0); @stageTask = null;
        Team::CatalystTrade::Reset();
        @order = null; orderKey = ""; @assist = null;
        helpers.resize(0); helperUntil.resize(0); helperTask.resize(0);
        fails.deleteAll(); holds.deleteAll(); diagAt.deleteAll(); badSites.resize(0);
        lastWhy = ""; lastPull = -100000;
    }

    void Defs() {
        if (defsDone) return;
        defsDone = true;
        const array<string>@ l = Global::RoleSettings::Front::TacticalUnits;
        for (uint i = 0; i < l.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(l[i]); if (d !is null) launchers.insertLast(d); }
        const array<string>@ t = Global::RoleSettings::Front::TacticalTargets;
        for (uint i = 0; i < t.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(t[i]); if (d !is null) targetDefs.insertLast(d); }
        const array<string>@ a = Global::RoleSettings::Front::TacticalArtiTargets;
        for (uint i = 0; i < a.length(); ++i) { CCircuitDef@ d = ai.GetCircuitDef(a[i]); if (d !is null) artiDefs.insertLast(d); }
        @catDef = ai.GetCircuitDef("cortron");
        @perdDef = ai.GetCircuitDef("legperdition");
    }

    // Legion trade mode (owner, 2026-11-13; Front::TacticalCatalystTrade): a Legion FRONT builds one Perdition
    // (TacticalLegionPerditions) and, with a Cortex T2 constructor traded to it (team/catalyst_trade.as), a
    // Catalyst in range of every heavy turret it sees: Perditions alone could not kill a Pulsar / Bulwark /
    // Bastion. Perditions and Catalysts are matched to targets each on their own. With no Cortex FRONT to
    // trade with (CatalystTrade::Fallback) the Perdition cap lifts: the old one-Perdition-per-target behaviour.
    bool LegionMode() {
        return On() && Global::RoleSettings::Front::TacticalCatalystTrade && Global::AISettings::Side == "legion"
            && catDef !is null && perdDef !is null;
    }
    bool IsOpen(Target@ t, bool cat, bool perd) {
        if (t.assetDist < 0.0f) return false;
        if (t.single) return !t.covered;
        if (cat) return !t.catCovered;
        if (perd) return !t.perdCovered;
        return !t.covered;
    }

    // Team::CatalystTrade (Legion FRONT): Catalysts wanted and nothing of ours can build one. `at` = the open
    // heavy turret nearest our mexes / porc.
    bool NeedCatalysts(AIFloat3 &out at) {
        at = AIFloat3(-1.0f, 0.0f, -1.0f);
        if (!LegionMode() || FrontRecovery::Active()) return false;
        Refresh();
        if (catBuilders > 0 || targets.length() == 0 || standing >= Global::RoleSettings::Front::TacticalMax) return false;
        if (Gate(LowestNeed(true, false)) != "") return false;
        float best = 1e30f;
        for (uint i = 0; i < targets.length(); ++i) {
            if (!IsOpen(targets[i], true, false) || !MetalOk(targets[i]) || targets[i].assetDist >= best) continue;
            best = targets[i].assetDist; at = targets[i].pos;
        }
        if (at.x >= 0.0f) tradedWantedAt = ai.frame;   // the gift we ask for is held on arrival (TradedWork)
        return at.x >= 0.0f;
    }

    bool IsLauncher(const CCircuitDef@ d) {
        for (uint i = 0; i < launchers.length(); ++i) if (launchers[i] is d) return true;
        return false;
    }
    bool IsTargetDef(int defId) {
        for (uint i = 0; i < targetDefs.length(); ++i) if (int(targetDefs[i].id) == defId) return true;
        return false;
    }
    bool IsArtiDef(int defId) {
        for (uint i = 0; i < artiDefs.length(); ++i) if (int(artiDefs[i].id) == defId) return true;
        return false;
    }

    // where our launchers were built for which slot (finished orders), newest last, at most 32
    array<AIFloat3> placedAt;
    array<string> placedKey;
    string PlacedKey(const AIFloat3 &in p) {
        for (int i = int(placedAt.length()) - 1; i >= 0; --i)
            if (MapHelpers::SqDist(p, placedAt[i]) <= 96.0f * 96.0f) return placedKey[i];
        return "";
    }

    string Key(const AIFloat3 &in p) { return "" + int(p.x / 32.0f) + "_" + int(p.z / 32.0f); }

    void AddTarget(array<Target@>@ list, const AIFloat3 &in p, int defId, bool ghost) {
        for (uint i = 0; i < list.length(); ++i)
            if (MapHelpers::SqDist(list[i].pos, p) <= 48.0f * 48.0f) return;   // the same structure
        Target@ t = Target();
        t.key = Key(p); t.pos = p; t.ghost = ghost;
        CCircuitDef@ d = ai.GetCircuitDef(defId);
        t.defName = (d is null) ? ("def " + defId) : d.GetName();
        list.insertLast(t);
    }
    void Collect(int defId, const AIFloat3 &in p, bool ghost) {
        if (IsTargetDef(defId)) AddTarget(heavy, p, defId, ghost);
        else if (IsArtiDef(defId)) AddTarget(artis, p, defId, ghost);
    }

    // Launchers in a full set: TacticalSetSize, +1 for a Legion FRONT trading for Catalysts (1 Perdition + 2 Catalysts)
    int SetSize() {
        int n = Global::RoleSettings::Front::TacticalSetSize;
        if (LegionMode() && !Team::CatalystTrade::Fallback()) ++n;
        return AiMax(1, n);
    }

    // A slot one launcher must hold both a and b from; key stable across scans
    Target@ PairSlot(Target@ a, Target@ b, const string &in rule, int k) {
        Target@ t = Target();
        t.pos = a.pos; t.has2 = true; t.pos2 = b.pos; t.single = true; t.rule = rule;
        t.ghost = a.ghost || b.ghost;
        t.defName = a.defName + "+" + b.defName;
        t.key = ((a.key < b.key) ? (a.key + "+" + b.key) : (b.key + "+" + a.key)) + "#" + k;
        return t;
    }

    // The slots (owner, 2026-11-13). Two heavy turrets within TacticalClusterRadius (anywhere): every heavy
    // turret is a slot of its own (the 2-porc rule, first over all) and artillery near one is left to it.
    // Otherwise:
    //  (a) a heavy turret with artillery within the radius: SetSize slots, each holding the turret and its
    //      nearest artillery;
    //  artillery with no heavy turret within the radius, grouped by the radius (linked):
    //  (b) two: one slot holding both;
    //  (c) three or more: SetSize slots, each holding a different pair (nearest pairs first).
    // O(h x a + a^2) per scan.
    void BuildSlots() {
        targets.resize(0);
        const float cr = Global::RoleSettings::Front::TacticalClusterRadius;
        const float cr2 = cr * cr;
        if (cluster) for (uint i = 0; i < heavy.length(); ++i) targets.insertLast(heavy[i]);
        if (artis.length() == 0) return;
        const int set = SetSize();
        array<bool> nearHeavy(artis.length(), false);
        for (uint a = 0; a < artis.length(); ++a)
            for (uint h = 0; h < heavy.length() && !nearHeavy[a]; ++h)
                nearHeavy[a] = MapHelpers::SqDist(artis[a].pos, heavy[h].pos) <= cr2;
        if (!cluster) {
            for (uint h = 0; h < heavy.length(); ++h) {
                int best = -1;
                float bestSq = cr2;
                for (uint a = 0; a < artis.length(); ++a) {
                    const float sq = MapHelpers::SqDist(artis[a].pos, heavy[h].pos);
                    if (sq <= bestSq) { bestSq = sq; best = int(a); }
                }
                if (best < 0) continue;
                for (int k = 0; k < set; ++k) targets.insertLast(PairSlot(heavy[h], artis[best], "porc+arti", k));
            }
        }
        // artillery groups with no heavy turret near
        array<int> group(artis.length(), -1);
        int groups = 0;
        for (uint a = 0; a < artis.length(); ++a) {
            if (nearHeavy[a] || group[a] >= 0) continue;
            group[a] = groups;
            array<uint> stack = { a };
            while (stack.length() > 0) {
                const uint c = stack[stack.length() - 1];
                stack.removeLast();
                for (uint b = 0; b < artis.length(); ++b) {
                    if (nearHeavy[b] || group[b] >= 0 || MapHelpers::SqDist(artis[c].pos, artis[b].pos) > cr2) continue;
                    group[b] = groups;
                    stack.insertLast(b);
                }
            }
            ++groups;
        }
        for (int g = 0; g < groups; ++g) {
            array<int> m;
            for (uint a = 0; a < artis.length(); ++a) if (group[a] == g) m.insertLast(int(a));
            if (m.length() < 2) continue;
            if (m.length() == 2) { targets.insertLast(PairSlot(artis[m[0]], artis[m[1]], "arti pair", 0)); continue; }
            // every pair in the group, nearest first; the first SetSize
            array<int> pa, pb;
            array<float> pd;
            for (uint i = 0; i < m.length(); ++i)
                for (uint j = i + 1; j < m.length(); ++j) {
                    const float sq = MapHelpers::SqDist(artis[m[i]].pos, artis[m[j]].pos);
                    uint k = 0;
                    while (k < pd.length() && pd[k] <= sq) ++k;
                    pa.insertAt(k, m[i]); pb.insertAt(k, m[j]); pd.insertAt(k, sq);
                }
            for (uint k = 0; k < pd.length() && int(k) < set; ++k)
                targets.insertLast(PairSlot(artis[pa[k]], artis[pb[k]], "arti group", 0));
        }
    }

    // The launcher's range to a target at `to` when standing at `from` (height aware)
    float RangeAt(const CCircuitDef@ d, const AIFloat3 &in from, const AIFloat3 &in to) {
        const float r = aiBattle.EffectiveRange(d, from, to);
        return (r > 0.0f) ? r : d.GetMaxRange();
    }

    void Scan() {
        lastScan = ai.frame;
        targets.resize(0); heavy.resize(0); artis.resize(0); launcherPos.resize(0);
        assets.resize(0); standing = 0; perdStanding = 0; catBuilders = 0; cluster = false;
        // enemy heavy turrets and heavy static artillery: seen now, then ghost images
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i) Collect(aiBattle.GetGroundContactDefId(i), aiBattle.GetGroundContactPos(i), false);
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i) Collect(aiBattle.GetGhostDefId(i), aiBattle.GetGhostPos(i), true);
        const float cr = Global::RoleSettings::Front::TacticalClusterRadius;
        for (uint i = 0; i < heavy.length() && !cluster; ++i)
            for (uint j = i + 1; j < heavy.length() && !cluster; ++j)
                cluster = MapHelpers::SqDist(heavy[i].pos, heavy[j].pos) <= cr * cr;
        BuildSlots();
        if (targets.length() == 0) { lastRules = ""; return; }
        // ours: mexes / porc, and the launchers
        array<AIFloat3> lpos;
        array<const CCircuitDef@> ldef;
        const bool legion = LegionMode();
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            const CCircuitDef@ d = u.circuitDef;
            if (IsLauncher(d)) {
                ++standing; if (d is perdDef) ++perdStanding;
                lpos.insertLast(u.GetPos(ai.frame)); ldef.insertLast(d); launcherPos.insertLast(u.GetPos(ai.frame));
                continue;
            }
            if (d.IsMobile()) {
                // Legion FRONTs only; one native CanBuild per mobile unit per TacticalScanSeconds while targets are known
                if (legion && u.GetBuildProgress() >= 1.0f && d.CanBuild(catDef) && !UnitHelpers::IsCommander(d)) ++catBuilders;
                continue;
            }
            if (u.GetBuildProgress() < 1.0f) continue;
            if (d.GetExtractsMetal() <= 0.0f && !d.HasSurfToLand()) continue;
            assets.insertLast(u.GetPos(ai.frame));
        }
        const float fr = Global::RoleSettings::Front::TacticalFrontRadius;
        for (uint i = 0; i < targets.length(); ++i) {
            Target@ t = targets[i];
            float best = fr * fr;
            for (uint a = 0; a < assets.length(); ++a) {
                float sq = MapHelpers::SqDist(t.pos, assets[a]);
                if (t.has2) sq = AiMin(sq, MapHelpers::SqDist(t.pos2, assets[a]));
                if (sq <= best) { best = sq; t.asset = assets[a]; t.assetDist = sqrt(sq); }
            }
        }
        // the artillery rules in force, logged when they change
        string rules = "";
        int artiSlots = 0;
        for (uint i = 0; i < targets.length(); ++i) {
            if (!targets[i].single) continue;
            ++artiSlots;
            if (rules.findFirst(targets[i].rule) < 0) rules += (rules == "" ? "" : ", ") + targets[i].rule;
        }
        if (artiSlots > 0) rules = "" + artiSlots + " artillery slots (" + rules + "); " + heavy.length() + " heavy turrets, " + artis.length() + " artillery known";
        if (rules != lastRules) {
            lastRules = rules;
            if (rules != "") GenericHelpers::LogUtil("[FRONT][Tactical] " + rules, 1);
        }
        // one launcher per target: greedy over every in-range (launcher, target) pair, targets near our mexes /
        // porc first, then the pair nearest to losing range. Launcher by launcher let one "cover" a far target
        // with nothing of ours near it and left its own open (fixture g12: 4 Catalysts on one Pulsar).
        // O(l x t) pairs, sorted by insertion; l <= TacticalMax, t the known heavy turrets.
        // Legion trade mode matches Perditions and Catalysts again, each kind on its own (at most 3 passes).
        Match(lpos, ldef, null, 0);
        if (legion) { Match(lpos, ldef, catDef, 1); Match(lpos, ldef, perdDef, 2); }
        if (order !is null && order.IsDead()) @order = null;
    }

    // kind 0: covered (every launcher); 1: catCovered (only `only` = Catalysts); 2: perdCovered (Perditions)
    void Match(array<AIFloat3>@ lpos, array<const CCircuitDef@>@ ldef, const CCircuitDef@ only, int kind) {
        array<int> pl, pt;
        array<float> ps;
        for (uint l = 0; l < lpos.length(); ++l) {
            if (only !is null && !(ldef[l] is only)) continue;
            for (uint i = 0; i < targets.length(); ++i) {
                if (kind != 0 && targets[i].single) continue;   // artillery slots: one launcher of any kind
                float s = RangeAt(ldef[l], lpos[l], targets[i].pos) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], targets[i].pos));
                if (targets[i].has2)
                    s = AiMin(s, RangeAt(ldef[l], lpos[l], targets[i].pos2) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], targets[i].pos2)));
                if (s < 0.0f) continue;
                const float key = s + ((targets[i].assetDist >= 0.0f) ? 0.0f : 1e6f);
                uint k = 0;
                while (k < ps.length() && ps[k] <= key) ++k;
                pl.insertAt(k, int(l)); pt.insertAt(k, int(i)); ps.insertAt(k, key);
            }
        }
        array<bool> used(lpos.length(), false);
        // a launcher first takes the artillery slot it was built for, while it still holds it: a launcher in
        // range of all three of a tight group was matched to the other pair, and the next one went up for the
        // same pair as it (headless f, 2026-11-13)
        if (kind == 0) {
            for (uint l = 0; l < lpos.length(); ++l) {
                const string key = PlacedKey(lpos[l]);
                if (key == "") continue;
                for (uint i = 0; i < targets.length(); ++i) {
                    Target@ t = targets[i];
                    if (!t.single || t.covered || t.key != key) continue;
                    float s = RangeAt(ldef[l], lpos[l], t.pos) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], t.pos));
                    if (t.has2) s = AiMin(s, RangeAt(ldef[l], lpos[l], t.pos2) + 32.0f - sqrt(MapHelpers::SqDist(lpos[l], t.pos2)));
                    if (s < 0.0f) continue;
                    t.covered = true; used[l] = true;
                    break;
                }
            }
        }
        for (uint k = 0; k < ps.length(); ++k) {
            Target@ t = targets[pt[k]];
            const bool already = (kind == 1) ? t.catCovered : ((kind == 2) ? t.perdCovered : t.covered);
            if (used[uint(pl[k])] || already) continue;
            used[uint(pl[k])] = true;
            if (kind == 1) t.catCovered = true; else if (kind == 2) t.perdCovered = true; else t.covered = true;
        }
    }

    void Refresh() {
        Defs();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::TacticalScanSeconds * SECOND) Scan();
    }

    // One line per key per DiagSeconds (LOG_LEVEL is 1, so level 2 never prints)
    void RateLog(const string &in key, const string &in text) {
        int until = 0;
        if (diagAt.get(key, until) && ai.frame < until) return;
        diagAt.set(key, ai.frame + DiagSeconds * SECOND);
        GenericHelpers::LogUtil("[FRONT][Tactical] " + text, 1);
    }
    // why a T1 constructor did not help
    void Diag(const string &in reason, const string &in detail) { RateLog("helper " + reason, "helper skip (" + reason + "): " + detail); }

    string TaskText(CCircuitUnit@ u) {
        if (u.task is null || u.task.IsDead()) return "no task";
        IBuilderTask@ b = cast<IBuilderTask>(u.task);
        return "task type " + int(u.task.GetType()) + (b is null ? "" : " build " + int(b.GetBuildType()) + (b.target is null ? "" : " framed"));
    }

    void ClearHelpers() { helpers.resize(0); helperUntil.resize(0); helperTask.resize(0); announced.resize(0); }

    void Why(const string &in why) {
        // a changed reason prints, at most once per DiagSeconds per kind ("waiting", "cap")
        if (why == lastWhy) return;
        lastWhy = why;
        const int colon = why.findFirst(":");
        RateLog(colon > 0 ? why.substr(0, colon) : why, why);
    }

    // Front_BuilderAiTaskRemoved
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        if (assist is task) { @assist = null; return; }
        if (catGuard is task) { @catGuard = null; return; }
        if (order !is task) return;
        @order = null; @assist = null;
        ClearHelpers();
        lastScan = -100000;
        const string key = orderKey;
        if (done) {
            fails.delete(key);
            placedAt.insertLast(orderSite); placedKey.insertLast(key);
            if (placedAt.length() > 32) { placedAt.removeAt(0); placedKey.removeAt(0); }
            GenericHelpers::LogUtil("[FRONT][Tactical] built against target at " + key, 1);
            return;
        }
        int n = 0;
        if (!fails.get(key, n)) n = 0;   // an &out argument is junk when the key is missing
        ++n;
        GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + key + " died with no launcher (fail " + n + " in a row); site ("
            + int(orderSite.x) + "," + int(orderSite.z) + ") avoided from now on", 1);
        if (badSites.length() >= MaxBadSites) badSites.removeAt(0);
        badSites.insertLast(orderSite);
        if (n >= 3) {
            holds.set(key, ai.frame + TargetHoldSeconds * SECOND);
            fails.delete(key);
            GenericHelpers::LogUtil("[FRONT][Tactical] three orders against target " + key + " died with no launcher; holding it " + TargetHoldSeconds + " s", 1);
        } else {
            fails.set(key, n);
            holds.set(key, ai.frame + FailHoldSeconds * n * SECOND);
        }
    }

    CCircuitDef@ LauncherFor(CCircuitUnit@ u) {
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ other = null;
        for (uint i = 0; i < launchers.length(); ++i) {
            if (!u.circuitDef.CanBuild(launchers[i])) continue;
            if (UnitHelpers::GetSideForUnitName(launchers[i].GetName()) == side) return launchers[i];
            if (other is null) @other = launchers[i];
        }
        return other;
    }

    // A site an order died on (no constructor, no frame): the next site is looked for elsewhere
    bool NearBadSite(const AIFloat3 &in p) {
        for (uint i = 0; i < badSites.length(); ++i) if (MapHelpers::SqDist(p, badSites[i]) <= BadSiteRadius * BadSiteRadius) return true;
        // a launcher of ours already stands there (an artillery set: the next one turns aside)
        for (uint i = 0; i < launcherPos.length(); ++i) if (MapHelpers::SqDist(p, launcherPos[i]) <= LauncherGap * LauncherGap) return true;
        return false;
    }

    // The slot's anchor: its target, or the middle of its pair
    AIFloat3 Anchor(Target@ t) {
        if (!t.has2) return t.pos;
        return AIFloat3((t.pos.x + t.pos2.x) * 0.5f, 0.0f, (t.pos.z + t.pos2.z) * 0.5f);
    }

    // The point from the slot's anchor along (dx, dz) where the farther of its targets is r0 away, pulled in
    // until the height-aware range holds every target with half the margin to spare; never below rMin (when < 0:
    // at most 4 range fits); x < 0 when none, or it leaves the map (EdgeGap from every edge; a clamped point was
    // not where the range was measured, B13), or a failed site / our launcher stands there
    AIFloat3 TrySite(CCircuitDef@ d, Target@ t, float dx, float dz, float r0, float rMin) {
        const float margin = Global::RoleSettings::Front::TacticalRangeMargin;
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        const AIFloat3 m = Anchor(t);
        // a pair: the half-vector h from the middle; the farther target is r0 away at r = -|u.h| + sqrt((u.h)^2 - h.h + r0^2)
        const float hx = t.pos.x - m.x, hz = t.pos.z - m.z;
        const float uh = abs(dx * hx + dz * hz), hh = hx * hx + hz * hz;
        float r = (hh > 0.0f && uh * uh - hh + r0 * r0 > 0.0f) ? (sqrt(uh * uh - hh + r0 * r0) - uh) : r0;
        const float rMin_ = (rMin >= 0.0f) ? AiMax(0.0f, rMin - (r0 - r)) : rMin;   // the walk-in floor, measured like r
        for (int it = 0; it < 16 && (rMin_ >= 0.0f || it < 4); ++it) {
            if (r < 300.0f || (rMin_ >= 0.0f && r < rMin_)) break;
            const AIFloat3 p(m.x + dx * r, 0.0f, m.z + dz * r);
            if (p.x < EdgeGap || p.z < EdgeGap || p.x > w - EdgeGap || p.z > h - EdgeGap || NearBadSite(p)) {
                if (rMin_ < 0.0f) break;   // the first pass keeps the range; the second walks in
                r -= 64.0f;
                continue;
            }
            // the worst overshoot over the slot's targets
            float worst = AiMax(0.0f, sqrt(MapHelpers::SqDist(p, t.pos)) - (RangeAt(d, p, t.pos) - margin * 0.5f));
            if (t.has2) worst = AiMax(worst, sqrt(MapHelpers::SqDist(p, t.pos2)) - (RangeAt(d, p, t.pos2) - margin * 0.5f));
            if (worst <= 0.0f) return p;
            r -= AiMax(64.0f, worst + margin * 0.5f);
        }
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    // Just inside the launcher's range of t, on the side of our nearest mex / porc; when that leaves the map,
    // the direction turned by +-20, 40, 60, 80 degrees (nearest first); then the same directions down to
    // ShortestRangeShare of the range; x < 0 when there is none (the target is held)
    AIFloat3 Site(CCircuitDef@ d, Target@ t) {
        const AIFloat3 m = Anchor(t);
        float dx = t.asset.x - m.x, dz = t.asset.z - m.z;
        float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) { dx = Global::Map::StartPos.x - m.x; dz = Global::Map::StartPos.z - m.z; len = sqrt(dx * dx + dz * dz); }
        if (len < 1.0f) return AIFloat3(-1.0f, 0.0f, -1.0f);
        dx /= len; dz /= len;
        float range = aiBattle.MainRange(d);
        if (range <= 0.0f) range = d.GetMaxRange();
        const float r0 = range - Global::RoleSettings::Front::TacticalRangeMargin;
        for (int pass = 0; pass < 2; ++pass) {
            for (int k = 0; k < 9; ++k) {
                const float deg = (k == 0) ? 0.0f : 20.0f * float((k + 1) / 2) * ((k % 2 == 1) ? 1.0f : -1.0f);
                const float a = deg * 3.14159265f / 180.0f;
                const float c = cos(a), s = sin(a);
                const AIFloat3 p = TrySite(d, t, dx * c - dz * s, dx * s + dz * c, r0, pass == 0 ? -1.0f : range * ShortestRangeShare);
                if (p.x >= 0.0f) return p;
            }
        }
        return AIFloat3(-1.0f, 0.0f, -1.0f);
    }

    // "" when the gate is open, else why not
    // Metal gate of a slot (owner, 2026-11-13): the artillery rules open at TacticalArtiMinMetalIncome (+65),
    // the 2-porc rule at TacticalMinMetalIncome (+90)
    float MinMetal(Target@ t) {
        return t.single ? Global::RoleSettings::Front::TacticalArtiMinMetalIncome : Global::RoleSettings::Front::TacticalMinMetalIncome;
    }
    bool MetalOk(Target@ t) { return Economy::GetMinMetalIncomeLast10s() >= MinMetal(t); }
    // the lowest metal gate among the open slots
    float LowestNeed(bool cat, bool perd) {
        float need = Global::RoleSettings::Front::TacticalMinMetalIncome;
        for (uint i = 0; i < targets.length(); ++i) if (IsOpen(targets[i], cat, perd)) need = AiMin(need, MinMetal(targets[i]));
        return need;
    }

    string Gate(float need = -1.0f) {
        if (need < 0.0f) need = Global::RoleSettings::Front::TacticalMinMetalIncome;
        if (targets.length() == 0) return "no two known enemy heavy turrets, or heavy turret and heavy artillery, or two heavy artillery within "
            + int(Global::RoleSettings::Front::TacticalClusterRadius) + " of each other";
        const float mi = Economy::GetMinMetalIncomeLast10s();
        if (mi < need)
            return "10 s minimum metal income +" + int(mi) + " under +" + int(need);
        const float ei = aiEconomyMgr.energy.income;
        if (ei < Global::RoleSettings::Front::TacticalMinEnergyIncome)
            return "energy income +" + int(ei) + " under +" + int(Global::RoleSettings::Front::TacticalMinEnergyIncome);
        return "";
    }

    // Front_BuilderAiMakeTask: a constructor that can build the launcher takes (or joins) the order;
    // a T1 constructor that reaches here (air) helps
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || FrontRecovery::Active()) return null;
        if (order !is null && !order.IsDead() && (u.task is order || (assist !is null && u.task is assist))) return u.task;
        if (UnitHelpers::IsCommander(u.circuitDef) || LolCannon::IsCrew(u.id)) return null;
        Refresh();
        CCircuitDef@ d = LauncherFor(u);
        if (d is null) {
            if (UnitHelpers::GetConstructorTier(u.circuitDef) == 1) return Help(u);
            return null;
        }
        const bool legion = LegionMode();
        const bool cat = legion && d is catDef;     // the traded Cortex constructor: Catalysts
        const bool perd = legion && d is perdDef;   // our own Legion T2: one Perdition
        if (cat && catGuard !is null && !catGuard.IsDead() && u.task is catGuard) return catGuard;
        if (order !is null && !order.IsDead()) {
            IBuilderTask@ b = cast<IBuilderTask>(order);
            array<CCircuitUnit@>@ on = order.GetUnits();
            if ((on is null || on.length() < 2) && b !is null && b.buildDef !is null && u.circuitDef.CanBuild(b.buildDef)
                && FrontFactoryNanos::Free(u) && (cat || MapHelpers::SqDist(u.GetPos(ai.frame), b.GetBuildPos()) <= 2000.0f * 2000.0f))
                return order;
            // the traded constructor helps build the other launcher, then takes the next Catalyst order
            if (cat && b !is null && (b.buildDef is null || !u.circuitDef.CanBuild(b.buildDef))) return CatGuard(u, on);
            return null;
        }
        if (targets.length() == 0) return null;
        int open = 0;
        for (uint i = 0; i < targets.length(); ++i) if (IsOpen(targets[i], cat, perd)) ++open;
        if (open == 0) return null;
        if (standing >= Global::RoleSettings::Front::TacticalMax) { Why("cap reached: " + standing + " standing"); return null; }
        if (perd && perdStanding >= Global::RoleSettings::Front::TacticalLegionPerditions && !Team::CatalystTrade::Fallback()) {
            Why("perdition cap: " + perdStanding + " Perdition(s) standing; Catalysts from a traded Cortex T2 constructor cover the rest");
            return null;
        }
        const string gate = Gate(LowestNeed(cat, perd));
        if (gate != "") { Why("waiting: " + gate + " (" + open + " heavy turrets near our mexes / porc)"); return null; }
        const bool free = FrontFactoryNanos::Free(u);
        if (!free && !FrontFactoryNanos::Takeable(u)) return null;
        // the traded constructor stands wherever its donor handed it over: no reach limit
        const float reach = cat ? 1e9f : (free ? Global::RoleSettings::Front::TacticalReach : Global::RoleSettings::Front::TacticalTakeRadius);
        const AIFloat3 wp = u.GetPos(ai.frame);
        // nearest our mexes / porc first
        array<int> order_;
        for (uint i = 0; i < targets.length(); ++i) {
            if (!IsOpen(targets[i], cat, perd)) continue;
            uint at = 0;
            while (at < order_.length() && targets[order_[at]].assetDist <= targets[i].assetDist) ++at;
            order_.insertAt(at, int(i));
        }
        for (uint k = 0; k < order_.length(); ++k) {
            Target@ t = targets[order_[k]];
            int until = -1;
            if (holds.get(t.key, until) && ai.frame < until) continue;
            if (!MetalOk(t)) continue;   // a 2-porc slot under +90 while an artillery slot (+65) is open
            const AIFloat3 site = Site(d, t);
            if (site.x < 0.0f) { holds.set(t.key, ai.frame + FailHoldSeconds * SECOND); continue; }
            if (MapHelpers::SqDist(wp, site) > reach * reach) continue;
            if (!aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance())) continue;
            if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
            if (!d.IsAvailable(ai.frame)) return null;
            @order = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, site,
                Global::RoleSettings::Front::TacticalShake, true, OrderTimeoutSeconds * SECOND));
            if (order is null) { holds.set(t.key, ai.frame + FailHoldSeconds * SECOND); continue; }
            orderKey = t.key; orderSite = site; @assist = null;
            ClearHelpers(); lastPull = -100000;
            orderFrame = ai.frame; orderBy = u.id; orderManned = false;
            lastWhy = "";
            GenericHelpers::LogUtil("[FRONT][Tactical] " + u.circuitDef.GetName() + " " + u.id + " orders " + d.GetName() + " at (" + int(site.x) + ","
                + int(site.z) + "), " + int(sqrt(MapHelpers::SqDist(site, t.pos))) + " from " + (t.ghost ? "ghost of " : "") + t.defName + " at ("
                + int(t.pos.x) + "," + int(t.pos.z) + ") (range " + int(RangeAt(d, site, t.pos)) + ")"
                + (t.has2 ? (" and " + int(sqrt(MapHelpers::SqDist(site, t.pos2))) + " from (" + int(t.pos2.x) + "," + int(t.pos2.z) + ") (range "
                    + int(RangeAt(d, site, t.pos2)) + "), rule " + t.rule + " slot " + t.key) : "")
                + "; our mex / porc " + int(t.assetDist)
                + " from it; mi +" + int(Economy::GetMinMetalIncomeLast10s()) + ", ei +" + int(aiEconomyMgr.energy.income) + "; " + standing
                + " standing, " + open + " heavy turrets open", 1);
            return order;
        }
        return null;
    }

    // Legion trade mode: while the open order is another launcher (the Perdition) the traded Cortex constructor
    // guards that order's builder, so it walks to the anti-porc site at once and helps; Update aborts the guard
    // when the order ends, and the re-ask takes the next Catalyst order
    IUnitTask@ CatGuard(CCircuitUnit@ u, array<CCircuitUnit@>@ on) {
        if (on is null || on.length() == 0 || on[0] is null || on[0] is u) return null;
        @catGuard = aiBuilderMgr.Enqueue(TaskB::Guard(Task::Priority::HIGH, on[0], true, AssistGuardSeconds * SECOND));
        if (catGuard !is null)
            RateLog("catguard", "traded " + u.circuitDef.GetName() + " " + u.id + " guards " + on[0].circuitDef.GetName() + " " + on[0].id
                + " on the open order against " + orderKey + " until its Catalyst order");
        return catGuard;
    }

    // Builder AiMakeTask, before every other FRONT rung: a constructor traded to us for Catalysts
    // (Team::CatalystTrade::IsTraded) works only on them while a heavy turret near our mexes / porc has no
    // Catalyst; when no order can be placed yet (gate closed, another launcher's order without a builder) it
    // waits where it stands. Without this native and ForwardGeo took it at once (headless Tartar 2026-11-13:
    // corack 10747 walked to a forward geo vent and died before the gate opened). Null: free for other work.
    IUnitTask@ TradedWork(CCircuitUnit@ u) {
        if (!LegionMode() || u is null || u.circuitDef is null || !Team::CatalystTrade::IsTraded(u.id)) return null;
        if (FrontRecovery::Active() || !(LauncherFor(u) is catDef)) return null;
        if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
            || u.task.GetType() == int(Task::Type::RETREAT))) return u.task;
        Refresh();
        bool wanted = (order !is null && !order.IsDead() && u.task is order);
        for (uint i = 0; i < targets.length() && !wanted; ++i) wanted = IsOpen(targets[i], true, false);
        // the known turrets come and go between scans (out of radar, a ghost cleared): it stays held
        // TacticalTradeDeliverSeconds after Catalysts were last wanted (headless 2026-11-13: a gift that arrived
        // in such a gap was taken by FrontRadar and the lolcannon crew)
        if (wanted) tradedWantedAt = ai.frame;
        else if (tradedWantedAt < 0 || ai.frame - tradedWantedAt > Global::RoleSettings::Front::TacticalTradeDeliverSeconds * SECOND) return null;
        if (!(u.task is order) && staged.find(u.id) < 0) {
            // first through our own start: the straight walk from the donor's base to the site went past the
            // heavy turrets themselves (headless 2026-11-13: 5 of 6 gifts died 500-700 from a Pulsar on the way)
            if (MapHelpers::SqDist(u.GetPos(ai.frame), Global::Map::StartPos) > StageRadius * StageRadius) {
                if (stageTask !is null && !stageTask.IsDead() && u.task is stageTask) return stageTask;
                @stageTask = aiBuilderMgr.Enqueue(TaskB::Patrol(Task::Priority::HIGH, Global::Map::StartPos, 30 * SECOND));
                RateLog("stage", "traded " + u.circuitDef.GetName() + " " + u.id + " walks to our start first ("
                    + int(sqrt(MapHelpers::SqDist(u.GetPos(ai.frame), Global::Map::StartPos))) + " away)");
                return stageTask;
            }
            staged.insertLast(u.id);
            if (staged.length() > 16) staged.removeAt(0);
        }
        IUnitTask@ t = Work(u);
        if (t !is null) return t;
        return aiBuilderMgr.Enqueue(TaskB::Wait(2 * SECOND));
    }

    // A T1 constructor helps the order: guard its T2 constructor until the frame stands, then repair the frame
    IUnitTask@ Help(CCircuitUnit@ u) {
        if (order is null || order.IsDead()) return null;
        if (assist !is null && !assist.IsDead() && u.task is assist) return assist;
        IBuilderTask@ b = cast<IBuilderTask>(order);
        if (b is null) return null;
        PruneHelpers();
        const int at = helpers.find(u.id);
        // a re-ask of a helper still on its guard keeps it (a new guard each ask churned tasks)
        if (at >= 0 && b.target is null && helperTask[at] !is null && !helperTask[at].IsDead() && u.task is helperTask[at]) return u.task;
        if (at < 0 && int(helpers.length()) >= Global::RoleSettings::Front::TacticalAssistT1) return null;
        if (at < 0 && !FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) {
            Diag("busy", u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id) + ", " + TaskText(u));
            return null;
        }
        const float reach = Global::RoleSettings::Front::TacticalAssistReach;
        AIFloat3 site = orderSite;
        if (b.target !is null) site = b.target.GetPos(ai.frame);
        const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), site);
        if (sq > reach * reach) {
            Diag("far", u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id) + " " + int(sqrt(sq)) + " from the site (reach " + int(reach) + ")");
            return null;
        }
        if (!aiTerrainMgr.CanReachAt(u, site, u.circuitDef.GetBuildDistance() + 200.0f)) {
            Diag("unreachable", u.circuitDef.GetName() + " " + u.id + " cannot reach the site");
            return null;
        }
        IUnitTask@ t = null;
        int secs = AssistGuardSeconds;
        if (b.target !is null) {
            if (assist is null || assist.IsDead()) @assist = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, b.target, 120 * SECOND));
            @t = assist;
            secs = 120;
        } else {
            array<CCircuitUnit@>@ on = order.GetUnits();
            if (on is null || on.length() == 0) { Diag("no T2 yet", "the order has no constructor to guard"); return null; }
            @t = aiBuilderMgr.Enqueue(TaskB::Guard(Task::Priority::HIGH, on[0], true, AssistGuardSeconds * SECOND));
        }
        if (t is null) return null;
        // one line per helper per order and per kind of help (a re-pull after its guard expires is silent)
        const string kind = (b.target !is null) ? "R" : "G";
        if (announced.find(kind + u.id) < 0) {
            announced.insertLast(kind + u.id);
            GenericHelpers::LogUtil("[FRONT][Tactical] T1 " + u.circuitDef.GetName() + " " + u.id + " seat " + FrontConstructors::Seat(u.id)
                + (b.target !is null ? " repairs the launcher frame" : " guards the launcher's constructor") + ", " + int(sqrt(sq)) + " from the site ("
                + (at < 0 ? helpers.length() + 1 : helpers.length()) + " of " + Global::RoleSettings::Front::TacticalAssistT1 + ")", 1);
        }
        if (at < 0) { helpers.insertLast(u.id); helperUntil.insertLast(ai.frame + secs * SECOND); helperTask.insertLast(t); }
        else { helperUntil[at] = ai.frame + secs * SECOND; @helperTask[at] = t; }
        return t;
    }

    void PruneHelpers() {
        for (int i = int(helpers.length()) - 1; i >= 0; --i)
            if (ai.GetTeamUnit(helpers[i]) is null || ai.frame >= helperUntil[i]) { helpers.removeAt(i); helperUntil.removeAt(i); helperTask.removeAt(i); }
    }

    // Front_EconomyUpdate: while an order is open, every PullSeconds the nearest T1 constructors that are free
    // or walking to an unframed build (never one on its own framed build, the commander group's seat, the
    // lolcannon crew) within TacticalAssistReach are given Help() until TacticalAssistT1 help; a helper native
    // swapped off is given its help again. Cost: one owned-unit scan per PullSeconds while an order is open,
    // O(units + T1s x helpers).
    void Update() {
        if (catGuard !is null && (catGuard.IsDead() || order is null || order.IsDead())) {
            // the order the traded constructor guarded ended: free it for the next Catalyst order
            IUnitTask@ g = catGuard;
            @catGuard = null;
            if (!g.IsDead()) aiBuilderMgr.AbortTask(g);
        }
        if (!On() || order is null || order.IsDead() || FrontRecovery::Active()) return;
        if (ai.frame - lastPull < PullSeconds * SECOND) return;
        lastPull = ai.frame;
        IBuilderTask@ b = cast<IBuilderTask>(order);
        if (b is null) return;
        // B13: native may leave the order with nobody on it; the constructor that placed it takes it, and an
        // order nobody took within UnmannedSeconds is aborted as a fail (it sat its whole 240 s timeout)
        // a manned order whose frame never stood (g10: a T2 and three guards on one for 14 min, the
        // order's own timeout never fired) is aborted at FrameDeadlineSeconds and counted as a fail
        if (b.target is null && ai.frame - orderFrame >= FrameDeadlineSeconds * SECOND) {
            GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + orderKey + " had no frame after " + FrameDeadlineSeconds + " s; aborted", 1);
            IUnitTask@ dead = order;
            aiBuilderMgr.AbortTask(dead);
            if (order is dead) TaskRemoved(dead, false);
            return;
        }
        if (!orderManned) {
            array<CCircuitUnit@>@ on = order.GetUnits();
            if (on !is null && on.length() > 0) orderManned = true;
            else if (ai.frame - orderFrame >= UnmannedSeconds * SECOND) {
                GenericHelpers::LogUtil("[FRONT][Tactical] order against target " + orderKey + " had no constructor after " + UnmannedSeconds + " s; aborted", 1);
                IUnitTask@ dead = order;
                aiBuilderMgr.AbortTask(dead);
                if (order is dead) TaskRemoved(dead, false);   // count the fail when the abort did not call back
                return;
            } else {
                CCircuitUnit@ by = ai.GetTeamUnit(orderBy);
                if (by !is null && !(by.task is order) && (FrontFactoryNanos::Free(by) || FrontFactoryNanos::Takeable(by))) {
                    aiBuilderMgr.AssignTask(by, order);
                    RateLog("assign", by.circuitDef.GetName() + " " + by.id + " assigned to its unmanned order against " + orderKey);
                }
            }
        }
        PruneHelpers();
        const int want = Global::RoleSettings::Front::TacticalAssistT1;
        AIFloat3 site = orderSite;
        if (b.target !is null) site = b.target.GetPos(ai.frame);
        const float reach = Global::RoleSettings::Front::TacticalAssistReach;
        array<CCircuitUnit@> cand;
        array<float> candSq;
        int t1 = 0, group = 0, framed = 0, busy = 0, far = 0;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 1) continue;
            if (u.GetBuildProgress() < 1.0f || LauncherFor(u) !is null) continue;
            ++t1;
            const int at = helpers.find(u.id);
            if (at >= 0 && (u.task is helperTask[at] || (assist !is null && u.task is assist))) continue;   // helping
            if (FrontConstructors::Seat(u.id) == 2 || CommanderGroup::Owns(u.id) || LolCannon::IsCrew(u.id)) { ++group; continue; }
            if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
                || u.task.GetType() == int(Task::Type::RETREAT))) { ++busy; continue; }
            IBuilderTask@ cur = cast<IBuilderTask>(u.task);
            if (cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR)) { ++framed; continue; }
            if (!FrontFactoryNanos::Free(u) && !FrontFactoryNanos::Takeable(u)) { ++busy; continue; }
            const float sq = MapHelpers::SqDist(u.GetPos(ai.frame), site);
            if (sq > reach * reach) { ++far; continue; }
            uint k = 0;
            while (k < candSq.length() && candSq[k] <= sq) ++k;
            cand.insertAt(k, u); candSq.insertAt(k, sq);
        }
        int pulled = 0;
        for (uint k = 0; k < cand.length(); ++k) {
            CCircuitUnit@ u = cand[k];
            if (helpers.find(u.id) < 0 && int(helpers.length()) >= want) break;
            IUnitTask@ t = Help(u);
            if (t is null || u.task is t) continue;
            aiBuilderMgr.AssignTask(u, t);
            ++pulled;
        }
        if (int(helpers.length()) < want && pulled == 0)
            Diag("none free", "" + helpers.length() + " of " + want + " helping; " + t1 + " T1s: " + group + " commander group / crew, " + framed
                + " on their own framed build, " + busy + " busy, " + far + " beyond " + int(reach) + ", " + cand.length() + " near and free");
    }

    // Builder AiMakeTask, first for every FRONT constructor: one on the order (or a T1 on its repair) keeps it.
    // Without this a re-ask of the T2 went to other rungs, the order lost its only unit and died
    // (fixture g12: 9 Perdition orders died 0.5-20 s after their T2 took them).
    bool Owns(CCircuitUnit@ u) {
        if (!On() || u is null || u.task is null || u.task.IsDead()) return false;
        return (order !is null && !order.IsDead() && u.task is order) || (assist !is null && !assist.IsDead() && u.task is assist)
            || (catGuard !is null && !catGuard.IsDead() && u.task is catGuard);
    }

    // Builder AiMakeTask, before the FRONT T1 seats route to native work: the base / expansion /
    // unseated T1 constructors help while an order is open (never the commander group's seat 2,
    // never one finishing a framed build of its own)
    IUnitTask@ AssistPull(CCircuitUnit@ u) {
        if (!On() || u is null || u.circuitDef is null || order is null || order.IsDead()) return null;
        if (FrontRecovery::Active() || u.GetBuildProgress() < 1.0f) return null;
        if (FrontConstructors::Seat(u.id) == 2) return null;
        if (u.task !is null && (u.task.IsExternalControlled() || u.task.GetType() == int(Task::Type::PLAYER)
            || u.task.GetType() == int(Task::Type::RETREAT))) return null;
        IBuilderTask@ cur = cast<IBuilderTask>(u.task);
        if (cur !is null && !cur.IsDead() && cur.target !is null && cur.GetBuildType() < int(Task::BuildType::REPAIR)
            && !(assist !is null && u.task is assist)) return null;
        if (LauncherFor(u) !is null) return null;
        return Help(u);
    }
}
