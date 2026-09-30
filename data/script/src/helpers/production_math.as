// Pure, role-neutral arithmetic. No engine calls, settings or mutable state.
namespace ProductionMath {
    bool Valid(float value) { return value >= 0.0f && value < 1.0e12f; }
    float Rate(float work, float power, float warmGap)
    {
        if (!Valid(work) || work <= 0.0f || !Valid(power) || power <= 0.0f || !Valid(warmGap)) return 0.0f;
        return power / (work + warmGap * power);
    }
    float FundedRate(float rate, float metalCost, float energyCost, float metal, float energy)
    {
        if (!Valid(rate) || !Valid(metal) || !Valid(energy) || !Valid(metalCost) || !Valid(energyCost)) return 0.0f;
        if (metalCost > 0.0f && rate * metalCost > metal) rate = metal / metalCost;
        if (energyCost > 0.0f && rate * energyCost > energy) rate = energy / energyCost;
        return rate;
    }
    // Costs and work are totals over a count-weighted batch, not averaged rates.
    float BatchRate(float work, float power, float warmGap, int count)
    {
        if (count <= 0) return 0.0f;
        return Rate(work, power, warmGap * float(count));
    }
    bool Funded(float bank, float income, float reserve, float committed, float cost, float seconds)
    {
        if (!Valid(bank) || !Valid(income) || !Valid(reserve) || !Valid(committed) || !Valid(cost) || !Valid(seconds)) return false;
        return bank + income * seconds >= reserve + committed + cost;
    }
    // Smallest usable support allocation; pending support is future capacity.
    int SupportTarget(float work, float factoryPower, float nanoPower, float gap, float wantedRate, int cap)
    {
        if (!Valid(work) || work <= 0.0f || !Valid(factoryPower) || !Valid(nanoPower) || !Valid(gap)
            || !Valid(wantedRate) || wantedRate <= 0.0f || nanoPower <= 0.0f || cap <= 0) return 0;
        for (int n = 0; n < cap; ++n)
            if (Rate(work, factoryPower + float(n) * nanoPower, gap) >= wantedRate) return n;
        return cap;
    }
    // Two five-wide banks, two rows deep. No turret lies in the aircraft pad.
    float BayAcross(int slot, float factoryHalf, float nanoWidth, float gap)
    {
        const int bank = slot / 10;
        const int row = (slot % 10) / 5;
        return (bank == 0 ? -1.0f : 1.0f) * (factoryHalf + gap + nanoWidth * (0.5f + float(row)));
    }
    float BayAlong(int slot, float nanoWidth) { return float((slot % 10) % 5 - 2) * nanoWidth; }
    bool Inside(float x, float z, float width, float height, float margin)
    {
        return Valid(x) && Valid(z) && Valid(width) && Valid(height) && Valid(margin)
            && x < width && z < height
            && x >= margin && z >= margin && x <= width - margin && z <= height - margin;
    }
    bool CapacityReady(int count, int ceiling, int stableFrames, int requiredFrames, float bank, float cost)
    {
        return count >= 0 && count < ceiling && stableFrames >= requiredFrames && requiredFrames >= 0
            && Valid(bank) && Valid(cost) && bank >= cost;
    }
}
