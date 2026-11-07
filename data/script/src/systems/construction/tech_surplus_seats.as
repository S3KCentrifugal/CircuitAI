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
namespace TechSurplusSeats {
    class Seat {
        string name;
        int id;            // the holder, -1 when vacant
        int lastSurplus;   // last frame the seat's surplus held
        int retry;         // no claim before this frame
        int idleSince;     // INV-260: frame the holder was first seen idle, -1 when busy
        Seat(const string &in n) { name = n; id = -1; lastSurplus = -1; retry = 0; idleSince = -1; }
    }
    Seat@ turret = Seat("turret");
    Seat@ converter = Seat("converter");

    bool Enabled()
    {
        return Global::RoleSettings::Tech::SurplusSeatsEnabled && Global::AISettings::Role == AiRole::TECH;
    }

    bool EnergyLow()
    {
        const float storage = aiEconomyMgr.energy.storage;
        return aiEconomyMgr.isEnergyStalling
            || (storage > 0.0f && aiEconomyMgr.energy.current < storage * Global::RoleSettings::Tech::SurplusSeatLowEnergyShare);
    }

    // A turret drains energy too: none while energy is low.
    bool MetalSurplus()
    {
        return !EnergyLow() && aiEconomyMgr.metal.current >= Global::RoleSettings::Tech::SurplusSeatMetalBank;
    }

    // Excess energy: the bank floating (TechChain::EnergyBankFloats) or at
    // SurplusSeatEnergyShare of storage (played, b52: the seat was released with the bank at 95 %).
    bool EnergySurplus()
    {
        if (aiEconomyMgr.isEnergyStalling) return false;
        const float storage = aiEconomyMgr.energy.storage;
        return TechChain::EnergyBankFloats()
            || (storage > 0.0f && aiEconomyMgr.energy.current >= storage * Global::RoleSettings::Tech::SurplusSeatEnergyShare);
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

    // True when u holds (or now claims) the seat.
    bool Admit(Seat@ s, CCircuitUnit@ u, bool surplus)
    {
        if (surplus) s.lastSurplus = ai.frame;
        if (s.id >= 0 && s.id != u.id && !Eligible(s, ai.GetTeamUnit(s.id))) Release(s, "holder gone or away", false);
        if (s.id == u.id) {
            if (!Eligible(s, u)) { Release(s, "left base or taken", false); return false; }
            if (ai.frame - s.lastSurplus > Global::RoleSettings::Tech::SurplusSeatReleaseSeconds * SECOND) {
                Release(s, "surplus over", false);
                return false;
            }
            return true;
        }
        if (s.id >= 0 || !surplus || ai.frame < s.retry || !Eligible(s, u)) return false;
        s.id = u.id;
        s.idleSince = -1;
        GenericHelpers::LogUtil("[TECH][Seat] " + u.circuitDef.GetName() + " " + u.id + " holds the " + s.name
            + " seat: metal " + int(aiEconomyMgr.metal.current) + "/" + int(aiEconomyMgr.metal.storage)
            + " energy " + int(aiEconomyMgr.energy.current) + "/" + int(aiEconomyMgr.energy.storage) + " (D-489)", 1);
        return true;
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
        return t;
    }

    // D-107's converter aircraft is the converter seat while it stands.
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
        return t;
    }

    // EcoPlanner::TechConversionAdmission: the metal-full, capacity, parallel and income
    // tests are waived for the converter seat and D-107's converter aircraft while energy is in excess.
    bool ConverterSeatWaived(CCircuitUnit@ worker)
    {
        if (!Enabled() || worker is null || !EnergySurplus()) return false;
        return worker.id == converter.id || worker.id == TechBuild::airConvId;
    }

    // From Invariants::Tick. INV-260: a held seat's holder is never idle for
    // SurplusSeatIdleSeconds (a seat with nothing to do is released at once).
    void Check(Seat@ s)
    {
        if (s.id < 0) { s.idleSince = -1; return; }
        CCircuitUnit@ u = ai.GetTeamUnit(s.id);
        // A holder lost, retreating or sent away is vacated here, not on the next
        // ask of another constructor (played, b52: a retreating holder kept the seat).
        if (!Eligible(s, u)) { Release(s, "holder gone, retreating or away", false); return; }
        const bool idle = u.task is null || u.task.GetType() == int(Task::Type::IDLE);
        if (!idle) { s.idleSince = -1; return; }
        if (s.idleSince < 0) s.idleSince = ai.frame;
        // An order the holder never takes up (played, b52: a turret seat holder idle
        // after a failed move while asks kept returning an order it could not join)
        // frees the seat, which waits SurplusSeatRetrySeconds before the next claim.
        else if (ai.frame - s.idleSince >= Global::RoleSettings::Tech::SurplusSeatIdleReleaseSeconds * SECOND) {
            Release(s, "holder idle " + int((ai.frame - s.idleSince) / SECOND) + " s: its order was not taken", true);
            return;
        }
        if (s.idleSince >= 0 && ai.frame - s.idleSince >= Global::RoleSettings::Tech::SurplusSeatIdleSeconds * SECOND)
            Invariants::Violation("INV-260", s.name, "the " + s.name + " seat holder " + s.id + " has been idle "
                + int((ai.frame - s.idleSince) / SECOND) + " s (D-489)");
    }
    void Tick()
    {
        if (!Enabled()) return;
        Check(turret);
        Check(converter);
    }
}
