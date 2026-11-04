namespace FrontConstructorMath {
    const int SUPPORT=0, EXPANSION=1, COMMANDER=2, ENERGY=3, CONVERTER=4;
    const int SEATS=5;
    // Admission order: energy, support, expansion, commander, then (D-463)
    // the converter seat, which exists only while converterWanted.
    int Missing(const array<int>& in seats, bool converterWanted) {
        if(int(seats.length())!=SEATS) return -1;
        if(seats[ENERGY]<0) return ENERGY;
        if(seats[SUPPORT]<0) return SUPPORT;
        if(seats[EXPANSION]<0) return EXPANSION;
        if(seats[COMMANDER]<0) return COMMANDER;
        if(converterWanted && seats[CONVERTER]<0) return CONVERTER;
        return -1;
    }
    // A released converter seat is never refilled, even after a loss.
    bool RecruitAllowed(int seat,bool previouslyFilled,bool expansionQueued,bool commanderEnabled,bool converterWanted) {
        if(seat<0 || seat>=SEATS) return false;
        if(seat==CONVERTER) return converterWanted;
        if(previouslyFilled) return true;
        if(seat==EXPANSION) return expansionQueued;
        if(seat==COMMANDER) return commanderEnabled;
        return true;
    }
    bool OpeningDone(const array<bool>& in filled) {
        return int(filled.length())==SEATS && filled[SUPPORT] && filled[ENERGY];
    }
    // 0: factory assistance, 1: complete the turret, 2: lane duty.
    // The opening turret's completion is the only release (C7).
    int CommanderPhase(bool turretPresent, float progress) {
        if(turretPresent && progress>=1.f) return 2;
        return turretPresent ? 1 : 0;
    }
    // D-463 energy seat: duty holds while energy income is at or below the
    // release; wind duty needs the map's average wind strictly above the bar.
    bool EnergyHeld(float energyIncome,float release) { return energyIncome<=release; }
    bool Windy(float windMin,float windMax,float minimumAverage) {
        return (windMin+windMax)*0.5f>minimumAverage;
    }
    // D-463 geothermal back-off: a failed order waits retry x fails frames;
    // after `attempts` failures the seat stops trying geothermal.
    bool GeoAllowed(int fails,int attempts,int frame,int retryFrame) {
        return fails<attempts && frame>=retryFrame;
    }
    int GeoBackoffFrames(int fails,int retryFrames) { return (fails>0 ? fails : 0)*(retryFrames>0 ? retryFrames : 0); }
    // D-463 converter seat: wanted on a normal map with converters allowed,
    // until metal income first exceeds the release (one-way).
    bool ConverterWanted(bool enabled,bool metalMap,bool convertersAllowed,bool released) {
        return enabled && !metalMap && convertersAllowed && !released;
    }
    bool ConverterReleases(float metalIncome,float release) { return metalIncome>release; }
    // Order the next converter only with energy to spare: storage at least
    // this full and no energy stall.
    bool ConverterFunded(float energyCurrent,float energyStorage,float fill,bool stalling) {
        return !stalling && energyStorage>0.f && energyCurrent>=energyStorage*fill;
    }
    // A dense block is kept when at least this share of its slots reserved.
    bool BlockAccepted(int placed,int cols,int rows,float minimumFill) {
        const int slots=cols*rows;
        return slots>0 && placed>0 && float(placed)>=float(slots)*minimumFill;
    }
}
