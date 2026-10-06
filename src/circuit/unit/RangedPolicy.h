#ifndef CIRCUIT_RANGED_POLICY_H
#define CIRCUIT_RANGED_POLICY_H

namespace circuit {
// JSON owns policy. The RANGED attribute is the only admission switch; these
// values do not change legacy siege, squad, naval, air or specialist owners.
struct RangedPolicy {
    enum class Mode { PRECISION, SKIRMISH, BOMBARDMENT, CARRIER };
    Mode mode = Mode::SKIRMISH;
    float rangeFraction = .95f;
    float spacing = 96.f;
    float safetyMargin = 48.f;
    float hysteresis = 48.f;
    float reactionSeconds = 1.f;
    float targetHysteresis = 1.2f;
    float sensorOffset = 160.f;
    float cloakReserve = 3.f;
    float repairedTargetPenalty = .25f;
    float splashWeight = .5f;
    bool cloakOnReload = false;
    bool allowMobile = true;
    bool allowStatic = true;
    bool preferHeavy = false;
    bool preferScreen = true;
    bool allowRadar = true;
    bool advanceUnknownRadar = true;
    bool stageWhenBlocked = false; // opt-in: deploy outside coverage if no firing band fits
};
}
#endif
