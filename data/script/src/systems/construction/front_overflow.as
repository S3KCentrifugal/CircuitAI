// FRONT energy overflow into metal (owner, 2026-10-31; Front::OverflowConverters, on in experimental_balanced).
// Played (AI 13, Crimson Bay): rezzed fusions filled the energy bank from 6:00 to the end, 1,800-2,500 E/s
// went unused and metal stalled 783 s, but not one T2 converter went up: the eco ladder only asked for one
// at the very end of its work (after the reactor and HelpFrame), from its 2-4 "ladder" T2 constructors, one
// at a time, and both were held on mex upgrades or on a starving advanced fusion the whole game.
//   - Overflow: the energy bank at Front::OverflowBankPercent or more, or income beating the pull by
//     Front::OverflowSpareEnergy, for Front::OverflowSeconds. While it lasts, any FRONT T2 constructor asking
//     for work (before the eco ladder) builds T2 converters, up to Front::OverflowParallel unfinished at a
//     time (one per spare converter draw, at least one while the bank is full), up to
//     Front::OverflowMaxConverters. Every Front::OverflowPullSeconds one T2 constructor that only helps
//     (FrontMexUp::Helper) is moved onto a converter when none is going up.
//   - Mexes first: while the bank is full and our T1 mexes are not all upgraded, a T2 constructor asking for
//     work takes an open mex upgrade (FrontMexUp) before converters and the ladder's reactor work.
//   - Blocks: converters go in gap-free Front::OverflowBlockCols x Front::OverflowBlockRows rectangles
//     (4x4 footprints at a 32-elmo pitch, nothing between rows or columns), sited behind the eco anchor away
//     from the map centre, every cell buildable and no surface threat at the block when it is chosen; one
//     block is filled before the next is chosen. Each order keeps to its cell (siteRadius) or is dropped.
//   - Build power: T2 labs and plants recruit extra T2 constructors on top of the profile minimum, 1-3 for
//     a lasting overflow (Front::OverflowExtraT2*) and up to Front::MexUpExtraT2Max while T1 mexes of ours
//     wait for an upgrade; T2 bot labs also make up to Front::MexUpExtraAssistMax fast-assist bots
//     (Butler, Twitcher, Proteus), which help our mex upgrade frames, then our converter frames.
// Measured whatever the setting (Front::OverflowLog): once a minute
//   [FRONT][Overflow] min N | E +income pull bank/storage | full Xs | over E | conv ... | M +income
// "over" is the energy above a full bank (income beyond the pull while the bank is at 98%+), which is
// shared to allies or lost.
namespace FrontOverflow {
    bool On() { return Global::RoleSettings::Front::OverflowConverters && Global::AISettings::Role == AiRole::FRONT; }
    bool LogOn() { return Global::RoleSettings::Front::OverflowLog && Global::AISettings::Role == AiRole::FRONT; }

    CCircuitDef@ ConvDef() { return ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side)); }
    const float ConvDraw = 600.0f;      // armmmkr / cormmkr / legadveconv energyconv_capacity
    const float ConvMetal = 10.34f;     // 600 * 0.01724

    // ---- overflow state ----------------------------------------------------------------------------
    int overflowSince = -1;     // first frame of the current overflow, -1 when none
    bool BankFull(float pct)
    {
        return aiEconomyMgr.energy.storage > 0.0f && aiEconomyMgr.energy.current >= aiEconomyMgr.energy.storage * pct;
    }
    float Spare() { return aiEconomyMgr.energy.income - aiEconomyMgr.energy.pull; }
    bool Overflowing()
    {
        if (aiEconomyMgr.isEnergyStalling) return false;
        return BankFull(Global::RoleSettings::Front::OverflowBankPercent) || Spare() >= Global::RoleSettings::Front::OverflowSpareEnergy;
    }
    int OverflowFor() { return overflowSince < 0 ? 0 : (ai.frame - overflowSince) / SECOND; }
    bool Active() { return On() && FrontEcoLadder::FirstFusionStands() && OverflowFor() >= Global::RoleSettings::Front::OverflowSeconds; }

    int Pending()
    {
        CCircuitDef@ d = ConvDef();
        return d is null ? 0 : aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::CONVERT), d) + aiBuilderMgr.GetUnfinishedCount(d);
    }
    // converters wanted under construction now
    int Allowed()
    {
        if (!Active()) return 0;
        CCircuitDef@ d = ConvDef();
        if (d is null || d.count >= Global::RoleSettings::Front::OverflowMaxConverters) return 0;
        int n = int(Spare() / ConvDraw);
        if (BankFull(Global::RoleSettings::Front::OverflowBankPercent)) n = AiMax(n, Global::RoleSettings::Front::OverflowFullBankParallel);
        return AiMin(Global::RoleSettings::Front::OverflowParallel, n);
    }
    // the ladder's cap on the converter def (native included): what stands plus what we may start
    int CapTarget()
    {
        CCircuitDef@ d = ConvDef();
        if (!On() || d is null) return 0;
        return AiMin(Global::RoleSettings::Front::OverflowMaxConverters, d.count + AiMax(0, Allowed() - aiBuilderMgr.GetUnfinishedCount(d)));
    }

    // ---- blocks ------------------------------------------------------------------------------------
    array<AIFloat3> cells;      // the current block's cells, filled in order
    array<int> cellState;       // 0 open, 1 ordered, 2 done/occupied, 3 failed
    array<IUnitTask@> cellTasks;
    int blocks = 0;
    int blockRetry = -1;
    AIFloat3 blockCentre(-1.0f, 0.0f, -1.0f);
    array<AIFloat3> allCells;   // every block's cells, for the log's placement check

    float Snap(float v) { return float(int(v / 16.0f)) * 16.0f; }   // even 4x4 footprints sit on 16-elmo lines

    bool CellsFit(CCircuitDef@ d, const AIFloat3 &in c, array<AIFloat3>@ fitCells)
    {
        const int cols = Global::RoleSettings::Front::OverflowBlockCols, rows = Global::RoleSettings::Front::OverflowBlockRows;
        const float pitch = 32.0f;
        fitCells.resize(0);
        // The whole block and the converter's block-map yard round it free of every structure and yard (arm C,
        // 2026-10-31): experimental_balanced block_map.json gives converters yard [8, 8] (64 elmo a side) that
        // no other structure may stand in, and a 16-elmo look at each cell centre missed it - 68 of 118 cell
        // orders on Forge aborted "no site within 24". Own converters ignore each other, so only the outside
        // edge needs the margin.
        const float margin = Global::RoleSettings::Front::OverflowBlockMargin;
        const AIFloat3 mid(Snap(c.x), 0.0f, Snap(c.z));
        if (aiTerrainMgr.BuildableFraction(d, mid, float(cols) * pitch * 0.5f + margin, float(rows) * pitch * 0.5f + margin, 0) < 1.0f) return false;
        for (int r = 0; r < rows; ++r) {
            for (int k = 0; k < cols; ++k) {
                const AIFloat3 p(Snap(c.x) + (float(k) - float(cols - 1) * 0.5f) * pitch, 0.0f, Snap(c.z) + (float(r) - float(rows - 1) * 0.5f) * pitch);
                if (aiTerrainMgr.BuildableFraction(d, p, 15.0f, 15.0f, 0) < 1.0f) return false;
                fitCells.insertLast(p);
            }
        }
        // no surface threat at the block
        return aiBattle.SurfThreat(c) <= Global::RoleSettings::Front::OverflowMaxThreat;
    }

    array<AIFloat3> givenUp;    // centres of blocks given up: not chosen again
    bool NearGivenUp(const AIFloat3 &in p)
    {
        for (uint i = 0; i < givenUp.length(); ++i) if (MapHelpers::SqDist(p, givenUp[i]) < 128.0f * 128.0f) return true;
        return false;
    }

    // Candidates: rings round the eco anchor, the side away from the map centre first
    bool ChooseBlock(CCircuitDef@ d)
    {
        if (ai.frame < blockRetry) return false;
        const AIFloat3 anchor = FrontEcoLadder::Anchor();
        const float w = float(aiTerrainMgr.GetTerrainWidth()), h = float(aiTerrainMgr.GetTerrainHeight());
        const AIFloat3 centre(w * 0.5f, 0.0f, h * 0.5f);
        float bx = anchor.x - centre.x, bz = anchor.z - centre.z;
        const float bl = sqrt(bx * bx + bz * bz);
        if (bl > 1.0f) { bx /= bl; bz /= bl; } else { bx = 1.0f; bz = 0.0f; }
        array<AIFloat3> fit;
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bestScore = -1.0e9f;
        array<AIFloat3> bestCells;
        const array<float> rings = {0.0f, 160.0f, 320.0f, 480.0f, 640.0f, 800.0f, 1000.0f, 1200.0f};
        for (uint ri = 0; ri < rings.length(); ++ri) {
            const int spokes = rings[ri] <= 0.0f ? 1 : 12;
            for (int a = 0; a < spokes; ++a) {
                const float ang = 6.2831853f * float(a) / float(spokes);
                const AIFloat3 p = FrontEcoLadder::Clamped(anchor.x + cos(ang) * rings[ri], anchor.z + sin(ang) * rings[ri]);
                // away from the centre, then near the anchor; never nearer the centre than the start by more than 200
                const float back = (p.x - centre.x) * bx + (p.z - centre.z) * bz;
                const float startBack = (Global::Map::StartPos.x - centre.x) * bx + (Global::Map::StartPos.z - centre.z) * bz;
                if (back < startBack - 200.0f) continue;
                const float score = back - 0.5f * rings[ri];
                if (score <= bestScore || NearGivenUp(p)) continue;
                if (!CellsFit(d, p, fit)) continue;
                bestScore = score; best = p; bestCells = fit;
            }
            if (best.x >= 0.0f && ri >= 2) break;   // good enough: no need to walk further out
        }
        if (best.x < 0.0f) {
            blockRetry = ai.frame + 60 * SECOND;
            GenericHelpers::LogUtil("[FRONT][Overflow] no " + Global::RoleSettings::Front::OverflowBlockCols + "x" + Global::RoleSettings::Front::OverflowBlockRows
                + " converter block fits round the eco anchor " + int(anchor.x) + "," + int(anchor.z) + "; retry in 60 s", 1);
            return false;
        }
        cells = bestCells;
        cellState.resize(cells.length()); cellTasks.resize(cells.length());
        for (uint i = 0; i < cells.length(); ++i) { cellState[i] = 0; @cellTasks[i] = null; }
        blockCentre = best; blocks++; failsHere = 0;
        for (uint i = 0; i < cells.length(); ++i) allCells.insertLast(cells[i]);
        GenericHelpers::LogUtil("[FRONT][Overflow] converter block " + blocks + " at " + int(best.x) + "," + int(best.z) + " ("
            + Global::RoleSettings::Front::OverflowBlockCols + "x" + Global::RoleSettings::Front::OverflowBlockRows + ", eco anchor "
            + int(anchor.x) + "," + int(anchor.z) + ")", 1);
        return true;
    }

    // A cell's converter: ours standing or framed on it
    bool Occupied(CCircuitDef@ d, const AIFloat3 &in p)
    {
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef !is d) continue;
            if (MapHelpers::SqDist(u.GetPos(ai.frame), p) <= 12.0f * 12.0f) return true;
        }
        return false;
    }

    void RefreshCells(CCircuitDef@ d)
    {
        for (uint i = 0; i < cells.length(); ++i) {
            if (cellState[i] == 1) {
                if (cellTasks[i] !is null && !cellTasks[i].IsDead()) continue;
                // the order ended: built, framed, or failed
                cellState[i] = Occupied(d, cells[i]) ? 2 : 3;
                @cellTasks[i] = null;
                if (cellState[i] == 3) { blockFails++; failsHere++; }
            }
        }
        // a block whose cells keep failing is given up: base structures came into its yard after it was chosen
        if (failsHere >= Global::RoleSettings::Front::OverflowBlockFailLimit && OpenCell() >= 0) {
            int dropped = 0;
            for (uint i = 0; i < cells.length(); ++i) if (cellState[i] == 0) { cellState[i] = 3; dropped++; }
            givenUp.insertLast(blockCentre);
            GenericHelpers::LogUtil("[FRONT][Overflow] converter block " + blocks + " given up after " + failsHere
                + " failed cells (" + dropped + " not ordered)", 1);
        }
    }
    int blockFails = 0;
    int failsHere = 0;      // failed cells in the current block
    int OpenCell()
    {
        for (uint i = 0; i < cells.length(); ++i) if (cellState[i] == 0) return int(i);
        return -1;
    }
    bool BlockFinished()
    {
        for (uint i = 0; i < cells.length(); ++i) if (cellState[i] <= 1) return false;
        return true;
    }

    IUnitTask@ OrderCell(CCircuitUnit@ u, CCircuitDef@ d, const string &in why)
    {
        RefreshCells(d);
        if (cells.length() == 0 || (OpenCell() < 0 && BlockFinished())) {
            if (!ChooseBlock(d)) return null;
        }
        const int i = OpenCell();
        if (i < 0) return null;   // the rest of the block is ordered
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::CONVERT, Task::Priority::HIGH, d, cells[i], 0.0f, true, 180 * SECOND));
        if (t is null) { cellState[i] = 3; blockFails++; failsHere++; return null; }
        IBuilderTask@ bt = cast<IBuilderTask>(t);
        if (bt !is null) bt.siteRadius = 24.0f;   // its own cell or nothing
        cellState[i] = 1; @cellTasks[i] = t;
        ordered++;
        GenericHelpers::LogUtil("[FRONT][Overflow] T2 converter " + (d.count + Pending()) + " in block " + blocks + " cell " + (i + 1) + "/" + cells.length()
            + " at " + int(cells[i].x) + "," + int(cells[i].z) + " by " + u.circuitDef.GetName() + " " + u.id + " (" + why + ")"
            + " | E +" + int(aiEconomyMgr.energy.income) + " pull " + int(aiEconomyMgr.energy.pull)
            + " bank " + int(aiEconomyMgr.energy.current) + "/" + int(aiEconomyMgr.energy.storage) + " for " + OverflowFor() + " s", 1);
        return t;
    }
    int ordered = 0;

    // ---- builder work ------------------------------------------------------------------------------
    bool IsAssistBot(CCircuitUnit@ u)
    {
        return u !is null && u.circuitDef !is null && UnitHelpers::GetAllFastAssistBots().find(u.circuitDef.GetName()) >= 0;
    }
    int T1MexesLeft() { return FrontEcoLadder::Done(FrontEcoLadder::MexName()); }

    // Front_BuilderAiMakeTask, before the eco ladder
    IUnitTask@ Work(CCircuitUnit@ u)
    {
        if (!On() || u is null || u.circuitDef is null || UnitHelpers::IsCommander(u.circuitDef)) return null;
        if (IsAssistBot(u)) return Assist(u);
        if (!FrontMexUp::IsT2Constructor(u) || LolCannon::IsCrew(u.id)) return null;
        // mexes first while energy is not what we lack
        if (Global::RoleSettings::Front::OverflowMexFirst && BankFull(Global::RoleSettings::Front::OverflowBankPercent) && T1MexesLeft() > 0) {
            IUnitTask@ up = FrontMexUp::Upgrade(u, "mexes before more energy (bank full)");
            if (up !is null) return up;
        }
        CCircuitDef@ d = ConvDef();
        if (d is null || !u.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) return null;
        if (Pending() >= Allowed()) return null;
        return OrderCell(u, d, "asked for work");
    }

    // fast-assist bots: our mex upgrade frames, then our converter frames
    IUnitTask@ Assist(CCircuitUnit@ u)
    {
        const AIFloat3 p = u.GetPos(ai.frame);
        CCircuitDef@ moho = ai.GetCircuitDef(UnitHelpers::GetT2MexNameForSide(Global::AISettings::Side));
        CCircuitUnit@ f = null;
        if (moho !is null && aiBuilderMgr.GetUnfinishedCount(moho) > 0) @f = aiBuilderMgr.FindUnfinishedNear(p, 3000.0f, moho);
        CCircuitDef@ d = ConvDef();
        if (f is null && d !is null && aiBuilderMgr.GetUnfinishedCount(d) > 0) @f = aiBuilderMgr.FindUnfinishedNear(p, 3000.0f, d);
        if (f is null) return null;
        return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, f, 60 * SECOND));
    }

    // one helper a pull onto a converter when none is going up
    int lastPull = -100000;
    void Pull()
    {
        if (!Active() || ai.frame - lastPull < Global::RoleSettings::Front::OverflowPullSeconds * SECOND) return;
        lastPull = ai.frame;
        CCircuitDef@ d = ConvDef();
        if (d is null || !d.IsAvailable(ai.frame) || Pending() > 0 || Allowed() <= 0) return;
        array<int>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (!FrontMexUp::IsT2Constructor(u) || LolCannon::IsCrew(u.id) || !u.circuitDef.CanBuild(d)) continue;
            if (!FrontMexUp::Helper(u) || FrontMexUp::PulledRecently(u.id)) continue;
            IUnitTask@ t = OrderCell(u, d, "left a helper's job");
            if (t is null) return;
            FrontMexUp::Pulled(u.id);
            aiBuilderMgr.AssignTask(u, t);
            return;
        }
    }

    // ---- extra T2 constructors (Front_FactoryAiMakeTask) -------------------------------------------
    int lastRecruit = -100000;
    int ExtraForOverflow()
    {
        if (!Active() || OverflowFor() < Global::RoleSettings::Front::OverflowExtraT2Seconds) return 0;
        const float over = AiMax(0.0f, Spare() - Global::RoleSettings::Front::OverflowSpareEnergy);
        return AiMin(Global::RoleSettings::Front::OverflowExtraT2Max, 1 + int(over / Global::RoleSettings::Front::OverflowExtraT2Spare));
    }
    int ExtraForMexes()
    {
        const int left = T1MexesLeft();
        return left <= 0 ? 0 : AiMin(Global::RoleSettings::Front::MexUpExtraT2Max, left);
    }
    IUnitTask@ Recruit(CCircuitUnit@ lab, const string &in labName, const string &in side)
    {
        if (!On() || lab is null) return null;
        const bool bot = UnitHelpers::IsT2BotLab(labName), veh = UnitHelpers::IsT2VehicleLab(labName);
        if (!bot && !veh) return null;
        if (ai.frame - lastRecruit < Global::RoleSettings::Front::OverflowRecruitSeconds * SECOND) return null;
        const int base = Global::RoleSettings::Front::MinT2BotConstructorCount + Global::RoleSettings::Front::MinT2VehicleConstructorCount;
        const int forOverflow = ExtraForOverflow(), forMexes = ExtraForMexes();
        const int want = base + AiMax(forOverflow, forMexes);
        const int have = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors())
            + UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2VehicleConstructors());
        string name = "";
        string why = "";
        if (have < want) {
            array<string> names = bot ? UnitHelpers::GetT2BotConstructors(side) : UnitHelpers::GetT2VehicleConstructors(side);
            if (names.length() > 0) name = names[0];
            why = "T2 constructors " + have + " of " + want + " (overflow +" + forOverflow + ", T1 mexes left " + T1MexesLeft() + ")";
        } else if (bot && forMexes > 0) {
            const int assists = UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllFastAssistBots());
            if (assists < Global::RoleSettings::Front::MexUpExtraAssistMax) {
                array<string> names = UnitHelpers::GetFastAssistBots(side);
                if (names.length() > 0) name = names[0];
                why = "assist bots " + assists + " of " + Global::RoleSettings::Front::MexUpExtraAssistMax + " for " + T1MexesLeft() + " T1 mexes";
            }
        }
        if (name.length() == 0) return null;
        CCircuitDef@ def = ai.GetCircuitDef(name);
        if (def is null || !def.IsAvailable(ai.frame) || !lab.circuitDef.CanBuild(def)) return null;
        IUnitTask@ t = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::HIGH, def, lab.GetPos(ai.frame), 64.f));
        if (t is null) return null;
        lastRecruit = ai.frame;
        recruits++;
        GenericHelpers::LogUtil("[FRONT][Overflow] " + labName + " " + lab.id + " recruits " + name + ": " + why, 1);
        return t;
    }
    int recruits = 0;

    // ---- update and measurement (Front_EconomyUpdate) ---------------------------------------------
    int lastUpdate = -1;
    int minuteFrom = 0;
    float fullSeconds = 0.0f, overE = 0.0f;
    float totalFull = 0.0f, totalOver = 0.0f;
    int minutes = 0;
    void Update()
    {
        if (!LogOn() && !On()) return;
        const int dt = lastUpdate < 0 ? 0 : AiMin(ai.frame - lastUpdate, 10 * SECOND);
        lastUpdate = ai.frame;
        if (Overflowing()) { if (overflowSince < 0) overflowSince = ai.frame; }
        else overflowSince = -1;
        const float sec = float(dt) / float(SECOND);
        if (BankFull(0.98f)) {
            fullSeconds += sec;
            overE += AiMax(0.0f, Spare()) * sec;
        }
        if (On()) {
            CCircuitDef@ d = ConvDef();
            if (d !is null) RefreshCells(d);
            Pull();
        }
        if (ai.frame - minuteFrom >= 60 * SECOND) {
            minutes++;
            totalFull += fullSeconds; totalOver += overE;
            if (LogOn()) Report();
            fullSeconds = 0.0f; overE = 0.0f; minuteFrom = ai.frame;
        }
    }
    // finished T2 converters: on a block cell (within 4 elmo), near one (within 32: built off its cell), elsewhere
    string Placement(CCircuitDef@ d)
    {
        if (d is null) return "";
        int on = 0, near = 0, away = 0;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef !is d || u.GetBuildProgress() < 1.0f) continue;
            const AIFloat3 p = u.GetPos(ai.frame);
            float best = 1.0e9f;
            for (uint k = 0; k < allCells.length(); ++k) best = AiMin(best, MapHelpers::SqDist(p, allCells[k]));
            if (best <= 4.0f * 4.0f) on++; else if (best <= 32.0f * 32.0f) near++; else away++;
        }
        return " | placed " + on + " on cell " + near + " off cell " + away + " outside blocks";
    }
    void Report()
    {
        CCircuitDef@ d = ConvDef();
        const int standing = d is null ? 0 : d.count - aiBuilderMgr.GetUnfinishedCount(d);
        const int framed = d is null ? 0 : aiBuilderMgr.GetUnfinishedCount(d);
        const int queued = d is null ? 0 : aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::CONVERT), d);
        int inBlocks = 0;
        for (uint i = 0; i < cells.length(); ++i) if (cellState[i] == 2) inBlocks++;
        GenericHelpers::LogUtil("[FRONT][Overflow] min " + minutes + " | E +" + int(aiEconomyMgr.energy.income) + " pull " + int(aiEconomyMgr.energy.pull)
            + " bank " + int(aiEconomyMgr.energy.current) + "/" + int(aiEconomyMgr.energy.storage)
            + " | full " + int(fullSeconds) + " s, over " + int(overE) + " E (" + int(overE / 60.0f) + "/s)"
            + " | total full " + int(totalFull) + " s, over " + int(totalOver) + " E"
            + " | T2 conv " + standing + " standing " + framed + " framed " + queued + " queued (+" + int(float(standing) * ConvMetal) + " M/s)"
            + " | blocks " + blocks + " (" + inBlocks + " of " + cells.length() + " in the last, " + blockFails + " cells failed, " + ordered + " ordered)" + Placement(d)
            + " | fusions " + FrontEcoLadder::Fusions() + " adv " + FrontEcoLadder::AdvFusions() + (FrontEcoLadder::FirstFusionStands() ? " (first fusion stands)" : "")
            + " own " + FrontEcoLadder::Done(UnitHelpers::GetFusionNameForSide(Global::AISettings::Side))
            + " geo " + FrontEcoLadder::Equivalents(FrontEcoLadder::GeoLike, "", true)
            + " | T2 ctors " + (UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2BotConstructors()) + UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllT2VehicleConstructors()))
            + " assist " + UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllFastAssistBots()) + " recruited " + recruits
            + " | mexes T1 " + T1MexesLeft() + " T2 " + FrontEcoLadder::Total(UnitHelpers::GetT2MexNameForSide(Global::AISettings::Side))
            + " | M +" + int(Economy::GetMinMetalIncomeLast10s()) + " bank " + int(aiEconomyMgr.metal.current)
            + (On() ? " | overflow " + OverflowFor() + " s" : " | converters off"), 1);
    }
}
