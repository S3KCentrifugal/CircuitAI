#pragma once
// D-432: the backline unit controller (type "backline"), the rear member's
// own mind in a line: Aggravator, Rocketeer. It leases a unit exactly as the
// skirmisher controller does (the shared engagement opens on the lease and
// closes on its end) and, before each engagement decision, writes a
// backline::Directive the engagement reads: the station behind the paired
// screen cohort, the job's target weights, the step-between-shots window and
// a tuck point when a short-range hostile has leaked round the screen. The
// levers a backline preset may carry are its own; another job's levers
// (poke, sustained rush, press, fire line, cloak, commander focus) are
// refused at load (unit/RangedPolicyParse.cpp, the forbidden list).
#include "control/core/CommandWriter.h"
#include "control/core/UnitController.h"
#include "control/kernel/BacklineStation.h"
#include "control/unit/DisengageRule.h"
#include "task/fighter/RangedWorld.h"
#include "unit/RangedPolicy.h"

#include <cstddef>
#include <memory>
#include <string>
#include <vector>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class CRangedEngagement;
class IUnitTask;

struct BacklineConfig {
    RangedPolicy policy;
    float screenRadius = 900.f;     // screen_radius: how far the paired screen may be to station on it
    float staticBonus = 1.5f;       // static_bonus
    float beyondScreenBonus = 1.3f; // beyond_screen_bonus
    float fastTargetSpeed = 70.f;   // fast_target_speed (elmos per second)
    float fastTargetPenalty = .3f;  // fast_target_penalty
    float selfDefenceRadius = 250.f;// self_defence_radius
    float selfDefenceBonus = 4.f;   // self_defence_bonus
    float moveAfterShot = 1.f;      // move_after_shot: reposition only in the reload window
    float aimHoldSeconds = .8f;     // aim_hold_seconds: hold still this long before a shot is due
    float leakRadius = 350.f;       // leak_radius: a short-range hostile this close with no screen between
    float leakCorridor = 96.f;      // leak_corridor: a screen member within this of the hostile-hull segment blocks the leak
    float tuckCount = 2.f;          // tuck_count: screen members to tuck behind
    float tuckOffset = 96.f;        // tuck_offset: elmos beyond them
    float tuckSeconds = 8.f;        // tuck_seconds: how long a tuck outlives its last sighting
    float log = 1.f;                // log: BACKLINE: lines on station and tuck changes
    // D-433
    float stationSlack = 48.f;      // station_slack: elmos inside its own band the hull stands
    float noScreen = 1.f;           // no_screen: 0 hold, 1 the nearest outranging allied static, 2 the cohort's rally point
    float noScreenSeconds = 6.f;    // no_screen_seconds: keep the last station this long while the screen regroups
};
struct BacklineState : control::ControlledState {
    std::unique_ptr<CRangedEngagement> engagement;
    IUnitTask* lease = nullptr;  // address only, compared never dereferenced
    int lastTaskType = -1;
    int leases = 0;
    backline::Directive directive;
    int tuckUntil = -1, tuckThreat = -1;
    int lastLogFrame = -10000;
    bool loggedStation = false;
    // D-433
    int lastScreenFrame = -1;
    bool lastStationSet = false;
    ranged::Point lastStation{0.f, 0.f};
    bool noScreenActive = false;
    disengage_rule::Memory disengage;
};

class CBacklineController final : public CUnitControllerBase<BacklineConfig, BacklineState> {
public:
    using State = BacklineState;
    explicit CBacklineController(CCircuitAI* ai);
    ~CBacklineController() override;

    // IUnitController
    const char* Name() const override { return "backline"; }
    int ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) override;
    void BindDef(int defId, int preset) override;
    bool SetOption(const std::string& name, float value) override;
    bool SetPresetOption(const std::string& preset, const std::string& name, float value) override;
    void Attach(CCircuitUnit* unit) override;
    void Detach(int unitId) override;
    bool Owns(CCircuitUnit* unit) const override;
    void Update() override;
    void Damaged(CCircuitUnit* unit) override;
    void MoveFailed(int unitId) override;
    void Idle(int unitId) override;
    void Leased(CCircuitUnit* unit, IUnitTask* task) override;
    void RestoreAfterLease(CCircuitUnit* unit, int fireState, int moveState) override;

    IUnitTask* MakeLease(CCircuitUnit* unit);
    bool Bound(int defId) const { return PresetForDef(defId) >= 0; }
    // Read by CRangedEngagement::UpdateCohort for a hull this controller runs; null otherwise.
    const backline::Directive* DirectiveFor(int unitId) const;
    int Leases() const { return leasesOpened; }
    int Tucks() const { return tucksStarted; }
    int NoScreens() const { return noScreensTaken; }

private:
    void OnPresetAssigned(int defId, int preset) override;
    void Publish(int defId, int preset);
    void Tick(CCircuitUnit* unit, State& s, int frame);
    void Decide(CCircuitUnit* unit, State& s, int frame);
    void CloseEngagement(CCircuitUnit* unit, State& s, bool commands);

    CCircuitAI* ai;
    CCommandWriter writer;
    std::size_t cursor = 0;
    std::vector<int> nearby;                 // reused query buffer
    std::vector<ranged::Point> screenPoints; // reused per decision
    std::vector<CRangedWorld::StaticPost> statics; // D-433: reused, only while no screen is paired
    std::vector<backline::Post> posts;
    int leasesOpened = 0, tucksStarted = 0, noScreensTaken = 0;
    bool trace = false;
};

} // namespace circuit
