namespace LandSiegeMath {
    // Pure policy: no clock, callbacks or allocation. Income drives the
    // mid/late-game ramp; elapsed time alone must not bankrupt a weak economy.
    float Budget(float income, float minimumIncome, float fullIncome,
        float staticMetal, float armyMetal, float responseRatio,
        float earlyShare, float lateShare, float teamFactor)
    {
        if (income < minimumIncome || staticMetal <= 0 || armyMetal <= 0
            || teamFactor <= 0) return 0;
        float ramp = fullIncome > minimumIncome ?
            (income - minimumIncome) / (fullIncome - minimumIncome) : 1;
        if (ramp < 0) ramp = 0;
        if (ramp > 1) ramp = 1;
        const float threatBudget = staticMetal * responseRatio / teamFactor;
        const float armyBudget = armyMetal * (earlyShare + (lateShare - earlyShare) * ramp);
        return threatBudget < armyBudget ? threatBudget : armyBudget;
    }
    bool CanAdd(float budget, float committed, float cost)
    {
        // No rounding-up exception: a single expensive siege unit may not
        // consume the screen's budget, even if none has been built yet.
        return cost > 0 && committed + cost <= budget;
    }
}
