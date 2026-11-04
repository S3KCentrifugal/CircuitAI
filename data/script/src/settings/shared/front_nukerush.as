// Front nukerush (owner, 2026-11-03). One draw at game start for the whole ally
// team (aiMilitaryMgr.AllyTeamRoll, the first allied BARb to ask draws it);
// policy in systems/team/front_nukerush.as. Off (0) unless a profile sets it;
// experimental_balanced / _hard / _terrible set 0.20.
namespace Global {
namespace FrontNukeRush {
    float Chance = 0.0f;
    // the silo gate for every FRONT and AIR (and TECH's income gate): the 10 s
    // minimum incomes, and game time for FRONT / AIR (TECH: its first gantry)
    float MetalIncome = 115.0f;
    float EnergyIncome = 2000.0f;
    int MinSeconds = 20 * 60;
    int Limit = 6;                      // silos per AI from this program
    // owner 2026-11-04: each finished advanced fusion of ours allows AfusSilos more,
    // the first AfusFree AFUS adding none
    int AfusSilos = 2;
    int AfusFree = 0;
    // owner 2026-11-04: the team's first overnuke salvo (3+ silos) rolls
    // FirstSalvoMin..FirstSalvoMax launches; later targets keep behaviour.json's roll
    int FirstSalvoMin = 8;
    int FirstSalvoMax = 14;
    // a silo block stands no further toward the nearest enemy start than this
    // share of the way there from our own start
    float MaxForwardShare = 0.45f;
    // block shapes, cols x rows, fewest patches first: one 3x2 block holds all 6
    array<int> Shapes = { 3, 2,  2, 2,  2, 1,  1, 1 };
    // T3 rush TECH: silos only once its gantries have made this many units
    int TechT3RushUnits = 10;
    // AIR scouts (10 T1 + 3 radar, ungated, drafting the built ones first) when
    // the overnuke begins and after every finished salvo; false: only the
    // overnuke's every-10-launches scouting
    bool RoundScouts = true;
}
}
