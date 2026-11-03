namespace FrontConstructorMath {
    const int SUPPORT=0, EXPANSION=1, COMMANDER=2, ENERGY=3;
    int Missing(const array<int>& in seats) {
        if(seats.length()!=4) return -1;
        if(seats[ENERGY]<0) return ENERGY;
        if(seats[SUPPORT]<0) return SUPPORT;
        if(seats[EXPANSION]<0) return EXPANSION;
        if(seats[COMMANDER]<0) return COMMANDER;
        return -1;
    }
    bool RecruitAllowed(int seat,bool previouslyFilled,bool expansionQueued,bool commanderEnabled) {
        if(seat<0 || seat>3) return false;
        if(previouslyFilled) return true;
        if(seat==EXPANSION) return expansionQueued;
        if(seat==COMMANDER) return commanderEnabled;
        return true;
    }
    bool OpeningDone(const array<bool>& in filled) {
        return filled.length()==4 && filled[SUPPORT] && filled[ENERGY];
    }
    // 0: factory assistance, 1: complete the turret, 2: lane duty.
    // The opening turret's completion is the only release (C7).
    int CommanderPhase(bool turretPresent, float progress) {
        if(turretPresent && progress>=1.f) return 2;
        return turretPresent ? 1 : 0;
    }
}
