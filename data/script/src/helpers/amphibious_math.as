// Pure wave policy, shared by the runtime controller and standalone tests.
namespace AmphibiousMath {
    bool Scope(bool tech, bool air, bool experimental) { return experimental && (tech || air); }
    bool Gathered(int alive, int arrived, float fraction) {
        return alive > 0 && arrived > 0 && float(arrived) >= float(alive) * fraction;
    }
    bool Release(int alive, int arrived, int target, int minimum, int age, int timeout, float fraction) {
        return alive >= minimum && (alive >= target || age >= timeout) && Gathered(alive, arrived, fraction);
    }
    bool Secured(int alive, int arrived, float fraction, bool contact, int quietFrames, int requiredFrames) {
        return !contact && quietFrames >= requiredFrames && Gathered(alive, arrived, fraction);
    }
    bool Landing(bool crossedWater, float height) { return crossedWater && height >= 0.0f; }
    bool MayAdvance(bool assembling, bool secured) { return assembling || secured; }
    float TargetScore(bool raider, bool economy, float cost, float distance, float threat) {
        return (raider && economy ? 4.0f : 1.0f) * cost / (1.0f + distance / 800.0f + threat);
    }
}
