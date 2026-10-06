// Pure policy, no engine calls. D-216; tested at activation/release boundaries.
namespace SpamMath {
    bool Funded(float metal, float energy, bool energyEmpty, bool metalFull,
        float bank, float minMetal, float minEnergy, float floatMetal, float minBank,
        bool active, float release)
    {
        if (energyEmpty) return false;
        const float fraction = active ? release : 1.0f;
        return energy >= minEnergy * fraction
            && (metal >= minMetal * fraction || (metalFull && bank >= minBank && metal >= floatMetal));
    }
    int Labs(float metal, float minimum, float step, int cap)
    {
        if (metal < minimum || step <= 0.0f || cap <= 0) return 0;
        const int n = 1 + int((metal - minimum) / step);
        return n < cap ? n : cap;
    }
}
