#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"

// D-501 (battle-group-composition-proposal.md, phase 4): how many screens a
// battle group aims for. Policy lives here, mechanism in the native group
// registry (src/circuit/control/group/GroupRegistry.h): a group below its
// target walks to the nearest compatible group and merges with it, a group
// above the template's size_max splits. A small army fields small groups that
// cover more ground; a large army fields fewer, larger ones.
//
//   target = clamp(BattleGroupSizeBase + armyCost * BattleGroupSizePerMetal,
//                  BattleGroupSizeMin, BattleGroupSizeMax)
//
// Shared by every role that fields Thugs or Maces, not FRONT only. A profile
// opts in by calling Update() from its AiUpdate (experimental_balanced does);
// a template that does not exist refuses the lever, which is harmless.
// Cost: one comparison per AiUpdate; SetOption only when the target changes.
namespace BattleGroupSize {
    int applied=-1;
    int nextFrame=0;

    int Target(float armyCost) {
        const float raw=Global::Military::BattleGroupSizeBase+armyCost*Global::Military::BattleGroupSizePerMetal;
        const float lo=float(Global::Military::BattleGroupSizeMin), hi=float(Global::Military::BattleGroupSizeMax);
        return int(raw<lo?lo:(raw>hi?hi:raw));
    }

    void Update() {
        if(!Global::Military::BattleGroupSizeEnabled || ai.frame<nextFrame) return;
        nextFrame=ai.frame+int(Global::Military::BattleGroupSizePeriodSeconds*SECOND);
        const int target=Target(aiMilitaryMgr.armyCost);
        if(target==applied) return;
        applied=target;
        bool any=false;
        const array<string>@ families=Global::Military::BattleGroupSizeFamilies;
        for(uint i=0;i<families.length();++i) any=aiControllers.SetOption(families[i],"size_target",float(target)) || any;
        if(any) GenericHelpers::LogUtil("[BattleGroupSize] target="+target+" army="+int(aiMilitaryMgr.armyCost),1);
    }
}
