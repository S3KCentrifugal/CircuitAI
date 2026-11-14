#pragma once
// D-514: the rezzer unit controller (type "rezzer"): the resurrection bots
// (Lazarus, Graverobber, Legion's) that serve a battle group as its repair
// crew. A bot is leased only while a group is short of crew
// (CBattleGroupController::WantsCrew); the group decides which group it serves
// and its station, crew_behind elmos behind the screen. This controller picks
// the work, in order:
//
//   1. the group's member on its repair trip (CBattleGroupController::Rotate);
//   2. the most damaged group member under member_health within member_radius
//      of the station;
//   3. the most damaged other friendly unit under ally_health within
//      ally_radius of the station;
//   4. a wreck within recovery_radius of the station: reclaim while metal is
//      low, resurrect (buildings too: a jammer a Juno deleted) while metal is
//      plentiful and energy is not low (control/kernel/RepairCrew.h);
//   5. walk to the station.
//
// One and two are checked on every decision and take the bot off anything
// else; three and four scan the engine at most every scan_seconds and run to
// the end of their order. A bot left with no group for release_seconds goes
// back to ordinary builder work.
//
// Cost: once per DECISION_SLICE frames per bot: O(1) for the trip, O(M) over
// the group's health snapshot (no engine read), and every scan_seconds one
// friendly-unit query and one feature query bounded by their radii. At most
// one order per decision, none while the current order still applies.
#include "control/core/CommandWriter.h"
#include "control/core/UnitController.h"

#include "AIFloat3.h"

#include <cstddef>
#include <unordered_map>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class IUnitTask;

struct RezzerConfig {
    float arrival = 48.f;        // arrival: elmos; no new station move while the station is this close to the last one sent
    float moveSeconds = 20.f;    // move_seconds: lifetime of one move order
    float orderSeconds = 30.f;   // order_seconds: lifetime of one repair, reclaim or resurrect order
    float log = 0.f;             // log: REZZER: lines on each new piece of work
    float releaseSeconds = 15.f; // release_seconds: a bot with no group this long goes back to builder work
    float memberHealth = .98f;   // member_health: a group member under this fraction is repaired
    float memberRadius = 350.f;  // member_radius: elmos from the station a member is repaired within
    float allyHealth = .9f;      // ally_health: another friendly unit under this fraction is repaired
    float allyRadius = 500.f;    // ally_radius: elmos from the station
    float recoveryRadius = 600.f;// recovery_radius: elmos from the station a wreck is reclaimed or resurrected within
    float rezMetal = .5f;        // rez_metal: metal storage fraction from which it resurrects instead of reclaiming
    float rezEnergy = .3f;       // rez_energy: energy storage fraction a resurrection needs
    float scanSeconds = 2.f;     // scan_seconds: least seconds between two scans for allies or wrecks
};
struct RezzerState : control::ControlledState {
    enum class Work { NONE, STATION, TRIP, MEMBER, ALLY, RECLAIM, RESURRECT };
    IUnitTask* lease = nullptr;  // the lease; dereferenced (Handover) only while it is still the unit's task
    Work work = Work::NONE;
    int target = -1;             // the unit repaired or the feature worked on
    bool hasOrder = false;       // the order for `work` is still running (cleared on idle)
    springai::AIFloat3 sent;     // the last station a move was sent to
    int group = -1;
    int alone = -1;              // the frame it last lost its group (-1: has one)
    int nextScan = -1;
};

class CRezzerController final : public CUnitControllerBase<RezzerConfig, RezzerState> {
public:
    using State = RezzerState;
    explicit CRezzerController(CCircuitAI* ai);
    ~CRezzerController() override;

    // IUnitController
    const char* Name() const override { return "rezzer"; }
    void Attach(CCircuitUnit* unit) override;
    void Detach(int unitId) override;
    bool Owns(CCircuitUnit* unit) const override;
    void Update() override;
    void Idle(int unitId) override;
    void MoveFailed(int unitId) override;
    void Leased(CCircuitUnit* unit, IUnitTask* task) override;
    void RestoreAfterLease(CCircuitUnit* unit, int fireState, int moveState) override;

    // The builder manager asks here before any script policy: a lease while a
    // battle group is short of crew, else null. O(1).
    IUnitTask* MakeLease(CCircuitUnit* unit);
    bool Bound(int defId) const { return PresetForDef(defId) >= 0; }

private:
    void OnPresetAssigned(int defId, int preset) override;
    void Tick(CCircuitUnit* unit, State& s, int frame);
    void Repair(CCircuitUnit* unit, State& s, int targetId, State::Work work, int frame);
    int FindAlly(CCircuitUnit* unit, const springai::AIFloat3& station) const;
    bool Recover(CCircuitUnit* unit, State& s, const springai::AIFloat3& station, int frame);
    void ToStation(CCircuitUnit* unit, State& s, const springai::AIFloat3& station, int frame);
    void Unclaim(int unitId, State& s);

    CCircuitAI* ai;
    CCommandWriter writer;
    std::size_t cursor = 0;
    std::unordered_map<int, int> claims;  // feature id -> the bot working it (no two bots on one wreck)
};

} // namespace circuit
