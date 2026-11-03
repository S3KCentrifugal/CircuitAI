// Front nukerush (owner, 2026-11-03). One 20% draw at game start for the whole
// ally team (aiMilitaryMgr.AllyTeamRoll: the first allied BARb to ask draws it,
// every ally reads the same answer; Global::FrontNukeRush::Chance, 0 = off).
// When it is on:
// - every FRONT and AIR builds nuclear silos one at a time, from MinSeconds of
//   game time while the 10 s minimum incomes stay at or above MetalIncome and
//   EnergyIncome, up to Limit, in tight blocks side by side (FrontSiloGrid, the
//   FRONT silo grid: as few blocks as fit, 3x2 first), no further toward the
//   nearest enemy start than MaxForwardShare of the way there, on ground the
//   TECH / AIR layouts and lab corridors have not reserved (CanReserveArea);
// - TECH builds them the same way, on the same income gate, once its first
//   gantry is finished (t3rush plan: once its gantries have made TechT3RushUnits);
// - the overnuke (3+ finished silos across every allied BARb, C++
//   CSuperTask::SelectNuclearTarget) asks AIR for a scout package across the map
//   when it begins, and again every time a salvo is fully launched and the next
//   target starts stocking (OvernukeRecon::Rounds, team/nuke_recon.as).
// Log [NukeRush].
namespace FrontNukeRush {
    int state = -1;          // -1 not drawn yet, 0 off, 1 on
    int techGantryUnits = 0; // TECH: finished units whose def one of our gantries builds
    int techOpenFrame = -1;  // TECH: the frame the gantry gate opened
    int nextHeldLog = -100000;

    bool On()
    {
        if (state < 0) {
            const float chance = Global::FrontNukeRush::Chance;
            state = (chance > 0.0f && aiMilitaryMgr.AllyTeamRoll("front_nukerush", chance)) ? 1 : 0;
            GenericHelpers::LogUtil("[NukeRush] team roll " + int(chance * 100.0f + 0.5f) + "%: " + (state == 1 ? "ON" : "off"), 1);
        }
        return state == 1;
    }

    // the game-start draw, before any constructor asks
    void Tick() { On(); }

    int FinishedGantries()
    {
        int done = 0;
        array<string> names = UnitHelpers::GetAllLandGantries();
        array<string> water = UnitHelpers::GetAllWaterGantries();
        for (uint i = 0; i < water.length(); ++i) names.insertLast(water[i]);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null) done += d.count - aiBuilderMgr.GetUnfinishedCount(d);
        }
        return done;
    }

    // TECH's military unit-added hook: count what our gantries made
    void TechUnitAdded(CCircuitUnit@ u)
    {
        if (state != 1 || Global::AISettings::Role != AiRole::TECH || u is null || u.circuitDef is null) return;
        array<string> names = UnitHelpers::GetAllLandGantries();
        array<string> water = UnitHelpers::GetAllWaterGantries();
        for (uint i = 0; i < water.length(); ++i) names.insertLast(water[i]);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ g = ai.GetCircuitDef(names[i]);
            if (g is null || g.count <= 0 || !g.CanBuild(u.circuitDef)) continue;
            ++techGantryUnits;
            if (techGantryUnits == Global::FrontNukeRush::TechT3RushUnits)
                GenericHelpers::LogUtil("[NukeRush] TECH gantries made " + techGantryUnits + " units", 1);
            return;
        }
    }

    // TECH: may the silo grid order? (after the first finished gantry; t3rush: its first units)
    bool TechOpen()
    {
        if (techOpenFrame >= 0) return true;
        const bool t3 = TechPlan::plan == "t3rush";
        string why = "";
        if (FinishedGantries() < 1) why = "no finished gantry";
        else if (t3 && techGantryUnits < Global::FrontNukeRush::TechT3RushUnits)
            why = "t3rush: " + techGantryUnits + " of " + Global::FrontNukeRush::TechT3RushUnits + " gantry units";
        if (why.length() > 0) {
            if (ai.frame - nextHeldLog >= 60 * SECOND) {
                nextHeldLog = ai.frame;
                GenericHelpers::LogUtil("[NukeRush] TECH silos held: " + why, 1);
            }
            return false;
        }
        techOpenFrame = ai.frame;
        GenericHelpers::LogUtil("[NukeRush] TECH silos open" + (t3 ? " (t3rush, " + techGantryUnits + " gantry units)" : " (first gantry finished)"), 1);
        return true;
    }
}
