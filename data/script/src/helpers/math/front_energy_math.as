namespace FrontEnergyMath {
    bool AdvancedAllowed(float metal, float energy, float minimumMetal, float minimumEnergy) {
        return metal >= minimumMetal && energy >= minimumEnergy;
    }
    bool NormalAllowed(float metal, float energy, bool energyNeeded,
        float minimumMetal, float minimumEnergy, float maximumEnergy, bool advancedAllowed) {
        return energyNeeded && metal > minimumMetal && energy > minimumEnergy
            && (!advancedAllowed || energy < maximumEnergy);
    }
    int AdmissionCap(bool allowed, int configuredCap) { return allowed ? configuredCap : 0; }
}
