// Battle squad lanes (owner 2026-11-25). Policy: systems/combat/battle_squads.as.
// Every squad attacks down its own AI's lane (Military::AiGroundObjective). Every
// LaneCheckSeconds it sums, along the rest of the D-127 ground lane it stands on and
// within LaneWidth of it, the enemy's armed metal (seen army x1, seen and ghost land
// porc x LaneStaticWeight) against its own value plus our other squads on that lane.
// Below LaneSwitchBelow it moves to the other lane whose ratio is best, preferring
// one where our squads already fight, if that ratio is at least LaneSwitchGain times
// better and reaches LaneSwitchMin; it attacks down that lane for at least
// LaneHoldSeconds, then returns to its own lane once that lane's ratio reaches LaneSwitchBack.
namespace Global {
namespace BattleSquads {
    bool LaneSwitch = true;
    int LaneCheckSeconds = 10;
    float LaneWidth = 900.0f;
    float LaneStaticWeight = 1.5f;
    float LaneSwitchBelow = 0.5f;
    float LaneSwitchGain = 1.5f;
    float LaneSwitchMin = 0.6f;
    float LaneFriendBonus = 1.25f;
    int LaneHoldSeconds = 120;
    float LaneSwitchBack = 1.0f;
}
}
