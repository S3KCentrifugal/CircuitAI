// D-489 (owner, 2026-11-07): TECH's surplus seats. Played: the eco player sat on a
// full metal bank and a full energy bank at once, with T1 constructors at base,
// free construction-turret slots and free advanced-converter slots.
//
// Turret seat (owner, 2026-11-07): whenever the metal bank holds SurplusSeatMetalBank
// (1000) and energy is not low (stalling, or the bank under SurplusSeatLowEnergyShare
// of storage), one T1 constructor at base builds only construction turrets on
// the economy cluster's free slots, one more than the resource cap allows at a
// time (D-097's cap otherwise holds every turret behind the frames in flight).
//
// Converter seat: while energy floats (TechChain::EnergyBankFloats) one T2
// constructor at base builds only advanced energy converters. Converter admission
// refuses every converter while metal is full (EcoPlanner METAL_FULL) or the spare
// energy does not fund another (CAPACITY). Metal is worth more than energy and spare
// metal goes to the team (owner), so for this seat and D-107's converter aircraft,
// which is the seat when alive, those tests and the parallel and income tests are
// waived: it fills every free advanced-converter slot while energy is in excess.
//
// A seat is claimed on an ordinary work ask (tech_rules.as rows seat.turret and
// seat.converter, after keep.current, so paid construction is never dropped) and
// released when its holder dies or leaves base, when the surplus has been gone
// SurplusSeatReleaseSeconds, or when it finds nothing to build or assist (then no
// claim for SurplusSeatRetrySeconds). Cost: O(1) per ask; the placement is the
// existing layout query the other turret and converter rows already make. Seats
// are not saved: after a load the next ask reclaims them from live state.
//
// D-493: the rules are pure in helpers/math/surplus_seat_math.as (tested); the
// energy test is the shared one (aiEconomyMgr.IsEnergyLow). This file only reads
// the live facts and makes the engine calls.
#include "../../helpers/math/surplus_seat_math.as"
namespace TechSurplusSeats {
    class Seat {
        string name;
        int id;               // the holder, -1 when vacant
        int lastSurplus;      // last frame the seat's surplus held
        int retry;            // no claim before this frame
        int idleSince;        // frame the holder was first seen idle, -1 when busy
        int handedFrame;      // last frame the seat handed its holder an order (diagnosis, KI-771)
        int handedType;       // that order's task type, -1 none
        string handedDef;     // its build definition, if any
        int fallbackHolder;   // INV-260: the holder of the last idle fallback ...
        int fallbackFrame;    // ... and its frame
        Seat(const string &in n)
        {
            name = n; id = -1; lastSurplus = -1; retry = 0; idleSince = -1;
            handedFrame = -1; handedType = -1; handedDef = ""; fallbackHolder = -1; fallbackFrame = -1;
        }
    }
    Seat@ turret = Seat("turret");
    Seat@ converter = Seat("converter");

    bool Enabled()
    {
        return Global::RoleSettings::Tech::SurplusSeatsEnabled && Global::AISettings::Role == AiRole::TECH;
    }

    // A turret drains energy too: none while energy is low (the shared rule).
    bool MetalSurplus()
    {
        return SurplusSeatMath::MetalSurplus(aiEconomyMgr.metal.current, Global::RoleSettings::Tech::SurplusSeatMetalBank,
            aiEconomyMgr.IsEnergyLow(Global::RoleSettings::Tech::SurplusSeatLowEnergyShare));
    }

    // Excess energy: the bank floating (TechChain::EnergyBankFloats) or at
    // SurplusSeatEnergyShare of storage (played, b52: the seat was released with the bank at 95 %).
    bool EnergySurplus()
    {
        return SurplusSeatMath::EnergyExcess(aiEconomyMgr.isEnergyStalling, TechChain::EnergyBankFloats(),
            aiEconomyMgr.energy.current, aiEconomyMgr.energy.storage, Global::RoleSettings::Tech::SurplusSeatEnergyShare);
    }

    bool AtBase(CCircuitUnit@ u)
    {
        const float r = Global::RoleSettings::Tech::SurplusSeatBaseRadius;
        return MapHelpers::SqDist(u.GetPos(ai.frame), Layout::BaseCentre()) <= r * r;
    }

    // Free to be seated: a finished, owned, ordinary constructor at base that no
    // other dedication holds (Air Foundry, ferry, frontline engineering, the
    // commander and sea builders are refused by TechGrowth::Available).
    bool Eligible(Seat@ s, CCircuitUnit@ u)
    {
        if (u is null || !TechGrowth::Available(u) || !AtBase(u)) return false;
        if (TechGrowth::Dedicated(u)) return false;
        if (TechBuild::IsDedicatedAirCon(u)) return false;
        Seat@ other = (s is turret) ? converter : turret;
        return u.id != other.id;
    }

    void Release(Seat@ s, const string &in why, bool retry)
    {
        if (s.id < 0) return;
        GenericHelpers::LogUtil("[TECH][Seat] " + s.name + " seat released by " + s.id + ": " + why + " (D-489)", 1);
        s.id = -1;
        s.idleSince = -1;
        if (retry) s.retry = ai.frame + Global::RoleSettings::Tech::SurplusSeatRetrySeconds * SECOND;
    }

    // True when u holds (or now claims) the seat (SurplusSeatMath::Decide).
    bool Admit(Seat@ s, CCircuitUnit@ u, bool surplus)
    {
        if (surplus) s.lastSurplus = ai.frame;
        if (s.id >= 0 && s.id != u.id && !Eligible(s, ai.GetTeamUnit(s.id))) Release(s, "holder gone or away", false);
        const int decision = SurplusSeatMath::Decide(s.id == u.id, s.id >= 0 && s.id != u.id, Eligible(s, u), surplus,
            ai.frame, s.lastSurplus, s.retry, Global::RoleSettings::Tech::SurplusSeatReleaseSeconds * SECOND);
        if (decision == SurplusSeatMath::RELEASE_INELIGIBLE) { Release(s, "left base or taken", false); return false; }
        if (decision == SurplusSeatMath::RELEASE_SURPLUS) { Release(s, "surplus over", false); return false; }
        if (decision == SurplusSeatMath::HOLD) return true;
        if (decision != SurplusSeatMath::CLAIM) return false;
        s.id = u.id;
        s.idleSince = -1;
        GenericHelpers::LogUtil("[TECH][Seat] " + u.circuitDef.GetName() + " " + u.id + " holds the " + s.name
            + " seat: metal " + int(aiEconomyMgr.metal.current) + "/" + int(aiEconomyMgr.metal.storage)
            + " energy " + int(aiEconomyMgr.energy.current) + "/" + int(aiEconomyMgr.energy.storage) + " (D-489)", 1);
        return true;
    }

    // Records what the seat handed its holder (KI-771 diagnosis) and returns it.
    IUnitTask@ Hand(Seat@ s, IUnitTask@ t)
    {
        if (t is null) return null;
        s.handedFrame = ai.frame;
        s.handedType = t.GetType();
        IBuilderTask@ b = cast<IBuilderTask>(t);
        s.handedDef = (b is null || b.buildDef is null) ? "" : b.buildDef.GetName();
        return t;
    }

    IUnitTask@ TurretWork(CCircuitUnit@ u)
    {
        if (!Enabled() || u is null || UnitHelpers::GetConstructorTier(u.circuitDef) != 1) return null;
        const string name = UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side);
        CCircuitDef@ nano = ai.GetCircuitDef(name);
        if (nano is null || !nano.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(nano)) return null;
        if (!Admit(turret, u, MetalSurplus())) return null;
        string why;
        const int budget = AiMax(Layout::TurretsAllowed(why), Layout::TurretsInFlight() + 1);
        IUnitTask@ t = Layout::NanoTask(u, Task::Priority::HIGH, budget);
        if (t is null) @t = TechBuild::AssistNearestOf(u, name);
        if (t is null) Release(turret, "no free turret slot", true);
        return Hand(turret, t);
    }

    // The D-107 converter aircraft is the converter seat while it stands.
    bool AirConverterServes() { return ai.GetTeamUnit(TechBuild::airConvId) !is null; }

    IUnitTask@ ConverterWork(CCircuitUnit@ u)
    {
        if (!Enabled() || u is null || UnitHelpers::GetConstructorTier(u.circuitDef) < 2) return null;
        const string name = UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side);
        CCircuitDef@ def = ai.GetCircuitDef(name);
        if (def is null || !u.circuitDef.CanBuild(def)) return null;
        if (converter.id != u.id && AirConverterServes()) return null;
        if (!Admit(converter, u, EnergySurplus())) return null;
        TechBuild::LiftCapForRole(name);
        IUnitTask@ t = TechBuild::BuildByLayout(u, name, Task::BuildType::CONVERT);
        if (t is null) {
            const EcoPlanner::ConversionReason reason = EcoPlanner::TechConversionAdmission(def, u);
            if (reason == EcoPlanner::PENDING) @t = TechBuild::AssistNearestOf(u, name);
            if (t is null) Release(converter, "nothing to build: " + EcoPlanner::ConversionReasonName(reason), true);
        }
        return Hand(converter, t);
    }

    // EcoPlanner::TechConversionAdmission: the metal-full, capacity, parallel and income
    // tests are waived for the converter seat and the D-107 converter aircraft while energy is in excess.
    bool ConverterSeatWaived(CCircuitUnit@ worker)
    {
        if (!Enabled() || worker is null) return false;
        return SurplusSeatMath::ConverterWaived(worker.id == converter.id || worker.id == TechBuild::airConvId, EnergySurplus());
    }

    // From Invariants::Tick. A holder lost, retreating or sent away is vacated
    // here (played, b52). A holder idle SurplusSeatIdleReleaseSeconds never took
    // the order it was handed: the seat is freed and the order logged (KI-771).
    // INV-260 (D-493): that fallback never fires twice in a row for the same
    // holder within the retry window, which would mean the cause is still there.
    void Check(Seat@ s)
    {
        if (s.id < 0) { s.idleSince = -1; return; }
        CCircuitUnit@ u = ai.GetTeamUnit(s.id);
        if (!Eligible(s, u)) { Release(s, "holder gone, retreating or away", false); return; }
        const bool idle = u.task is null || u.task.GetType() == int(Task::Type::IDLE);
        if (!idle) { s.idleSince = -1; return; }
        if (s.idleSince < 0) { s.idleSince = ai.frame; return; }
        if (!SurplusSeatMath::IdleRelease(s.idleSince, ai.frame, Global::RoleSettings::Tech::SurplusSeatIdleReleaseSeconds * SECOND)) return;
        const int window = Global::RoleSettings::Tech::SurplusSeatRetrySeconds * SECOND;
        if (SurplusSeatMath::FallbackRepeated(s.fallbackHolder, s.fallbackFrame, s.id, ai.frame, window))
            Invariants::Violation("INV-260", s.name, "the " + s.name + " seat idle fallback fired twice for holder " + s.id
                + " within " + Global::RoleSettings::Tech::SurplusSeatRetrySeconds + " s (D-493)");
        s.fallbackHolder = s.id; s.fallbackFrame = ai.frame;
        const string handed = s.handedFrame < 0 ? "nothing handed" : ("handed type " + s.handedType + " " + s.handedDef
            + " " + int((ai.frame - s.handedFrame) / SECOND) + " s ago");
        Release(s, "holder idle " + int((ai.frame - s.idleSince) / SECOND) + " s: its order was not taken (" + handed + ")", true);
    }
    void Tick()
    {
        if (!Enabled()) return;
        Check(turret);
        Check(converter);
    }
}
