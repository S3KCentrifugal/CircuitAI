// Pure roster policy, independent of managers, unit IDs and engine callbacks.
namespace CommanderGroupMath {
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
