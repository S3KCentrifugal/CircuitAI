// Pure roster policy, independent of managers, unit IDs and engine callbacks.
namespace CommanderGroupMath {
    // Admission only. Existing pull includes current work; do not clamp a
    // deficit away or spend protected reserves. Constant work, no allocation.
    bool ReplacementResource(float bank,float reserve,float income,float pull,float cost,float seconds) {
        if(!(bank>=0 && bank<1.e12f && reserve>=0 && reserve<1.e12f
            && income>=0 && income<1.e12f && pull>=0 && pull<1.e12f
            && cost>=0 && cost<1.e12f && seconds>0 && seconds<1.e12f)) return false;
        return bank>=reserve && bank-reserve+(income-pull)*seconds>=cost;
    }
    bool DecoyIncome(float metal,float energy,float minMetal,float minEnergy) {
        return minMetal>=0 && minEnergy>=0 && metal>=minMetal && energy>=minEnergy;
    }
    int DesiredT2(int previous,float metal,float energy,float firstMetal,float firstEnergy,
        float secondMetal,float secondEnergy,float thirdMetal,float thirdEnergy) {
        int desired=previous;
        if(metal>=firstMetal && energy>=firstEnergy && desired<1) desired=1;
        if(metal>=secondMetal && energy>=secondEnergy && desired<2) desired=2;
        if(metal>=thirdMetal && energy>=thirdEnergy && desired<3) desired=3;
        return desired<0?0:(desired>3?3:desired);
    }
    // A missing economy worker receives the next T2 completion before new
    // frontline seats. Existing frontline workers never change seats on loss.
    int Admission(bool economyPresent,const array<int>& in seats,int desired) {
        if(!economyPresent) return -2;
        for(int i=0;i<desired && i<3 && i<int(seats.length());++i) if(seats[i]<0) return i;
        return -1;
    }
}
