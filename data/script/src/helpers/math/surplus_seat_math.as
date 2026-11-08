// D-489 / D-493: the surplus seats' claim, hold and release rules, pure (no
// managers, unit ids or engine calls). TechSurplusSeats feeds it the live facts.
// Tests: tests/surplus_seat_math_tests.as.
namespace SurplusSeatMath {
    const int NONE = 0;              // not seated and no claim
    const int CLAIM = 1;             // the asker takes the free seat
    const int HOLD = 2;              // the asker keeps its seat
    const int RELEASE_SURPLUS = 3;   // the surplus has been gone longer than the grace
    const int RELEASE_INELIGIBLE = 4;// the holder left base, retreats or was taken

    // holder: the asker holds the seat. taken: another unit holds it.
    // lastSurplus: last frame the surplus held. retryUntil: no claim before it.
    int Decide(bool holder, bool taken, bool eligible, bool surplus, int frame, int lastSurplus,
        int retryUntil, int graceFrames)
    {
        if (holder) {
            if (!eligible) return RELEASE_INELIGIBLE;
            if (!surplus && frame - lastSurplus > graceFrames) return RELEASE_SURPLUS;
            return HOLD;
        }
        if (taken || !surplus || frame < retryUntil || !eligible) return NONE;
        return CLAIM;
    }

    // A holder idle this long never took the order it was handed: the seat is freed.
    bool IdleRelease(int idleSince, int frame, int releaseFrames)
    {
        return idleSince >= 0 && releaseFrames > 0 && frame - idleSince >= releaseFrames;
    }

    // INV-260: the idle fallback firing again for the same holder within the
    // retry window means the cause was not fixed.
    bool FallbackRepeated(int lastFallbackHolder, int lastFallbackFrame, int holder, int frame, int windowFrames)
    {
        return lastFallbackHolder >= 0 && lastFallbackHolder == holder && frame - lastFallbackFrame < windowFrames;
    }

    // The converter admission waiver: only the seat's holder, only while energy is in excess.
    bool ConverterWaived(bool holder, bool energyExcess)
    {
        return holder && energyExcess;
    }

    // Metal surplus for the turret seat: the bank holds `bank`, energy not low.
    bool MetalSurplus(float metal, float bank, bool energyLow)
    {
        return !energyLow && bank > 0.0f && metal >= bank;
    }

    // Energy in excess for the converter seat: not stalling, and floating or the bank at `share`.
    bool EnergyExcess(bool stalling, bool floating, float current, float storage, float share)
    {
        if (stalling) return false;
        return floating || (storage > 0.0f && share > 0.0f && current >= storage * share);
    }
}
