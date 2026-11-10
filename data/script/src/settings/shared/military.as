// Shared defaults; existing Global namespaces are retained for callers.
namespace Global {
namespace Military {
        float AggressionAutoWeight = 0.25f;
        float AttackWaitSeconds = 180.0f;
        float AttackScale = 0.8f;
        // D-214: funded land siege before ordinary FRONT combat selection.
        // Shares limit dedicated bombardment investment, leaving a mobile screen.
        bool LandSiegeEnabled = true;
        float LandSiegeMinMetal = 40.0f;
        float LandSiegeMinEnergy = 800.0f;
        float LandSiegeFullMetal = 120.0f;
        float LandSiegeResponseRatio = 1.25f;
        float LandSiegeEarlyShare = 0.20f;
        float LandSiegeLateShare = 0.35f;
        // D-501, D-502: battle group size policy (systems/combat/battle_group_size.as).
        // Twelve screens, one more per 300 metal of army, between 8 and 32 (the
        // template's size_max still bounds a merge); re-evaluated every 10 s.
        // D-502 raised it from 6 + army / 400 in 3..24: groups stayed small.
        bool BattleGroupSizeEnabled = true;
        float BattleGroupSizeBase = 12.0f;
        float BattleGroupSizePerMetal = 0.00333f;
        int BattleGroupSizeMin = 8;
        int BattleGroupSizeMax = 32;
        float BattleGroupSizePeriodSeconds = 10.0f;
        array<string> BattleGroupSizeFamilies = {"t1_cortex_group", "t1_bot_group"};
        // D-509: a lab starts the anti-air escort the battle groups are short of
        // (systems/combat/battle_group_air.as; how many is native, the
        // template's "air" rank and air_* levers in behaviour.json).
        bool BattleGroupAirEnabled = true;
        // D-514: a lab starts the resurrection bot the battle groups are short of
        // (systems/combat/battle_group_crew.as; how many is native, the
        // template's "repair" rank and crew levers in behaviour.json).
        bool BattleGroupCrewEnabled = true;
        // D-502: FRONT's ground objective stays this far down the lane past the
        // commander (manager/military.as AiGroundObjective); 0: off.
        float BattleGroupLeadDistance = 400.0f;
        // D-505: FRONT's ground objective walks past the lane's advance limit
        // (enemy defences); the battle group's assessment decides each fight.
        // false: the D-354 limit bounds the goal as before.
        bool BattleGroupPushPastLimit = true;
    }
}
