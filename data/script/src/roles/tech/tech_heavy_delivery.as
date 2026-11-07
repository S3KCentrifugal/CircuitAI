#include "../../helpers/math/transport_math.as"
#include "tech_delivery_front.as"

namespace TechHeavyDelivery {
    class Delivery {
        int unitId = -1;
        int recipient = -1;
        int carrier = -1;
        int nextRouteAttempt = 0;
        bool removed = false;
        bool giving = false;
        bool landed = false;
        int nextFrontPlan = 0;
        int nextFlightAttempt = 0;
        int nextRefusalLog = 0;
        AIFloat3 frontDestination = AIFloat3(-1,0,-1);
        array<AIFloat3> frontRoute;
        AIFloat3 destination = AIFloat3(-1.0f, 0.0f, -1.0f);
        CRouteTask@ route;
    }
    dictionary deliveries; // unit ID -> Delivery@; bounded by the finite batch

    float ArrivalRadius() {
        return Global::RoleSettings::Tech::HeavyDeliveryFrontEnabled
            ? Global::RoleSettings::Tech::HeavyDeliveryFrontRadius : Global::RoleSettings::Tech::HeavyDeliveryArrivalRadius;
    }
    AIFloat3 ArrivalAnchor(int unitId, int recipient) {
        if (!Global::RoleSettings::Tech::HeavyDeliveryFrontEnabled)
            return Team::Roster::DeliveryAnchor(Team::Roster::Get(recipient));
        Delivery@ delivery;
        if (!deliveries.get(""+unitId,@delivery) || delivery is null || delivery.recipient!=recipient)
            return AIFloat3(-1,0,-1);
        // No front drop yet: walk toward the recipient rather than hold at the
        // factory (Carrot Mountains 2026-11-01, ~2 min idle). Flights still
        // wait for a planned front drop; see Update.
        if (delivery.frontDestination.x < 0.0f && Global::RoleSettings::Tech::HeavyDeliveryWalkWithoutFront)
            return Team::Roster::DeliveryAnchor(Team::Roster::Get(recipient));
        return delivery.frontDestination;
    }

    void Removed(CCircuitUnit@ unit) {
        if (unit is null) return;
        Delivery@ delivery;
        if (deliveries.get("" + unit.id, @delivery) && delivery !is null && !delivery.giving)
            delivery.removed = true; // invalidate before a globally reused unit ID can be observed
    }

    Delivery@ Record(int index, int unitId) {
        Delivery@ delivery;
        if (deliveries.get("" + unitId, @delivery) && delivery !is null) return delivery;
        @delivery = Delivery();
        delivery.unitId = unitId;
        delivery.recipient = aiTerrainMgr.GetLayoutInt(TechHeavyRush::StateKey + "recipient." + index, -1);
        delivery.carrier = aiTerrainMgr.GetLayoutInt(TechHeavyRush::StateKey + "carrier." + index, -1);
        deliveries.set("" + unitId, @delivery);
        return delivery;
    }
    bool Controlled(CCircuitUnit@ unit) {
        return unit.task !is null && (unit.task.GetType() == int(Task::Type::PLAYER)
            || unit.task.IsExternalControlled());
    }
    void ReleaseRoute(Delivery@ delivery) {
        // Ordinary factory routes intentionally outlive their assignees. This
        // per-cargo route does not: call only after transfer to a ferry, gift,
        // or removal, so empty tasks cannot accumulate in native update lists.
        if (delivery.route !is null && !delivery.route.IsDead()) delivery.route.Abort();
        @delivery.route = null;
    }
    IUnitTask@ WalkTask(CCircuitUnit@ unit, Delivery@ delivery) {
        if (delivery.recipient < 0) return null;
        const AIFloat3 anchor = ArrivalAnchor(unit.id,delivery.recipient);
        if (anchor.x < 0.0f) return null;
        const bool live = delivery.route !is null && !delivery.route.IsDead();
        const float moved = Global::RoleSettings::Tech::HeavyDeliveryDestinationMove;
        // A small commander displacement may still leave the old endpoint
        // outside the gift radius. Preserve productive travel, but reconsider
        // an exhausted route instead of parking forever at its former anchor.
        if (live && MapHelpers::SqDist(anchor, delivery.destination) < moved * moved
            && (!delivery.route.IsAtEnd(unit) || TransportMath::Arrived(
                MapHelpers::SqDist(unit.GetPos(ai.frame), anchor),
                ArrivalRadius(), false))) return delivery.route;
        if (ai.frame < delivery.nextRouteAttempt) return live ? delivery.route : null;
        delivery.nextRouteAttempt = ai.frame + int(Global::RoleSettings::Tech::HeavyDeliveryRouteRetrySeconds * SECOND);
        const AIFloat3 destination = aiTerrainMgr.FindSafeDropSpot(unit, anchor,
            ArrivalRadius() * 0.5f,
            Global::Ferry::DropSurfaceThreat, Global::Ferry::DropAirThreat);
        if (destination.x < 0.0f || !aiTerrainMgr.CanReachAtSafe(unit, destination,
            ArrivalRadius())) return live ? delivery.route : null;
        if (!live) {
            IUnitTask@ task = aiMilitaryMgr.Enqueue(TaskF::Route());
            @delivery.route = cast<CRouteTask>(cast<IFighterTask>(task));
            if (delivery.route is null) return null;
            delivery.route.SetTraversal(false, ArrivalRadius() * 0.25f, false);
        }
        const array<AIFloat3> points = {destination};
        delivery.route.SetRoute(points); // one engine MOVE; Recoil handles terrain routing
        delivery.destination = anchor;
        GenericHelpers::LogUtil("[HeavyDelivery] walk cargo=" + unit.id + " recipient=" + delivery.recipient
            + " anchor=" + int(anchor.x) + "," + int(anchor.z), 1);
        return delivery.route;
    }
    IUnitTask@ MilitaryTask(CCircuitUnit@ unit) {
        if (!TechHeavyRush::Selected() || unit is null) return null;
        Delivery@ delivery;
        if (!deliveries.get("" + unit.id, @delivery) || delivery is null || delivery.removed || delivery.giving) return null;
        // A native military cargo hold remains exclusive until the carrier has
        // safely unloaded or failed. Never replace it with a builder task.
        if (delivery.carrier >= 0 && unit.task !is null && !unit.task.IsDead()) return unit.task;
        IUnitTask@ task = WalkTask(unit, delivery);
        if (task !is null) return task;
        // Waiting for a safe anchor/transport still belongs to logistics.
        // A route at the current position is a quiet military hold, not a raid.
        if (delivery.route is null || delivery.route.IsDead()) {
            IUnitTask@ holding = aiMilitaryMgr.Enqueue(TaskF::Route());
            @delivery.route = cast<CRouteTask>(cast<IFighterTask>(holding));
            if (delivery.route !is null) {
                const array<AIFloat3> points = {unit.GetPos(ai.frame)};
                delivery.route.SetRoute(points);
            }
        }
        return delivery.route;
    }
    // Diagnostics: SetCargoRoute refuses silently. Log why a cargo walks instead
    // of flying, at most once per retry interval per cargo (bounded batch).
    void LogRefusal(Delivery@ delivery, CCircuitUnit@ unit, const string& in why) {
        if (ai.frame < delivery.nextRefusalLog) return;
        delivery.nextRefusalLog = ai.frame + int(Global::RoleSettings::Tech::HeavyDeliveryRouteRetrySeconds * SECOND);
        GenericHelpers::LogUtil("[HeavyDelivery] walk-not-fly cargo=" + unit.id + " " + why, 1);
    }
    // The same corridor test native SetCargoRoute applies first to each leg.
    // A leg over the limit is not proof of refusal (native may detour), but
    // a covered carrier or pickup end is (native refuses a covered origin).
    string RouteThreat(CCircuitUnit@ aircraft, CCircuitUnit@ cargo, const array<AIFloat3>& in route) {
        if (aircraft is null || cargo is null) return "carrier gone";
        const float pad = Global::RoleSettings::Tech::HeavyDeliveryAirPadding;
        const AIFloat3 from = aircraft.GetPos(ai.frame), pickup = cargo.GetPos(ai.frame);
        string text = "limit=" + Global::RoleSettings::Tech::HeavyDeliveryAirThreat
            + " carrierAt=" + int(from.x) + "," + int(from.z)
            + " carrier=" + aiBattle.AirThreatAlong(from, from, pad)
            + " pickup=" + aiBattle.AirThreatAlong(pickup, pickup, pad)
            + " toPickup=" + aiBattle.AirThreatAlong(from, pickup, pad) + " legs=";
        AIFloat3 previous = pickup;
        for (uint i = 0; i < route.length(); ++i) {
            text += (i > 0 ? "/" : "") + aiBattle.AirThreatAlong(previous, route[i], pad);
            previous = route[i];
        }
        return text;
    }
    void Finish(int index, Delivery@ delivery, const string& in outcome) {
        ReleaseRoute(delivery);
        aiTerrainMgr.SetLayoutInt(TechHeavyRush::StateKey + "sent." + index, 1);
        GenericHelpers::LogUtil("[HeavyDelivery] " + outcome + " cargo=" + delivery.unitId
            + " recipient=" + delivery.recipient, 1);
        deliveries.delete("" + delivery.unitId); // release route handle on gift/death
    }
    void Update(int index, int unitId) {
        Delivery@ delivery = Record(index, unitId);
        if (delivery.removed) { Finish(index, delivery, "lost"); return; }
        CCircuitUnit@ unit = ai.GetTeamUnit(unitId);
        if (unit is null) {
            // GiveUnits removes local ownership before the engine callback. Wait
            // for engine confirmation instead of mistaking this interval for death.
            const int owner = ai.GetFriendlyUnitTeam(unitId);
            if (owner == ai.teamId && delivery.giving) return;
            Finish(index, delivery, owner == delivery.recipient && owner >= 0 ? "confirmed" : "lost");
            return;
        }
        if (Controlled(unit)) return;
        if (delivery.recipient < 0 || Team::Roster::Get(delivery.recipient) is null) {
            delivery.recipient = TechHeavyRush::Recipient();
            aiTerrainMgr.SetLayoutInt(TechHeavyRush::StateKey + "recipient." + index, delivery.recipient);
        }
        const bool forward = Global::RoleSettings::Tech::HeavyDeliveryFrontEnabled;
        if (forward && delivery.carrier<0 && !delivery.landed && ai.frame>=delivery.nextFrontPlan) {
            delivery.nextFrontPlan=ai.frame+int(Global::RoleSettings::Tech::HeavyDeliveryRouteRetrySeconds*SECOND);
            array<AIFloat3> path; AIFloat3 destination;
            if (TechDeliveryFront::Plan(unit,path,destination)) {
                delivery.frontRoute=path; delivery.frontDestination=destination;
            } else if (delivery.frontDestination.x < 0.0f)
                GenericHelpers::LogUtil("[HeavyDelivery] no front drop cargo=" + unit.id + ": "
                    + TechDeliveryFront::failure, 1);
        }
        const AIFloat3 anchor = ArrivalAnchor(unit.id,delivery.recipient);
        if (delivery.carrier >= 0) {
            CCircuitUnit@ aircraft = ai.GetTeamUnit(delivery.carrier);
            if (aircraft !is null && Controlled(aircraft)) return; // player took over the aircraft, possibly with cargo aboard
            CFerryTask@ carrier = Team::Ferry::TaskOf(aircraft);
            if (carrier !is null && carrier.GetCargoId() == unitId && Team::HeavyTransport::Busy(carrier)) return;
            if (carrier !is null && carrier.GetCargoId() == unitId && carrier.GetState() == Team::Ferry::StateDone)
                delivery.landed = true;
            // D-318: a terminal/released balanced flight finishes on the
            // ground, including failed-flight landing recovery. The pool may
            // already have reset FAILED after native cleared its cargo ID.
            // Re-loading here repeated the same refused drop in the live game.
            if (forward) delivery.landed = true;
            // Terminal ferry states guarantee release from the aircraft. A dead
            // carrier is also terminal; never reset another cargo's native task.
            delivery.carrier = -1;
            aiTerrainMgr.SetLayoutInt(TechHeavyRush::StateKey + "carrier." + index, -1);
            if (carrier !is null && carrier.GetCargoId() == unitId) carrier.Reset();
            @delivery.route = null;
        }
        // The walking fallback anchor is a staging point, not the gift spot.
        if (anchor.x >= 0.0f && (!forward || delivery.frontDestination.x >= 0.0f) && TransportMath::Arrived(MapHelpers::SqDist(unit.GetPos(ai.frame), anchor),
            ArrivalRadius(), false)) {
            if (!Invariants::HeavyDeliveryArrival(unit, delivery.recipient, delivery.carrier)) return;
            delivery.giving = true;
            array<CCircuitUnit@> gift = {unit};
            GenericHelpers::LogUtil("[HeavyDelivery] arrived cargo=" + unit.id + " recipient=" + delivery.recipient
                + " distance=" + int(sqrt(MapHelpers::SqDist(unit.GetPos(ai.frame), anchor))), 1);
            ai.GiveUnits(gift, delivery.recipient);
            return;
        }
        // A forward flight needs a planned front drop, never the walking fallback anchor.
        const bool flightReady = !forward || (delivery.frontDestination.x >= 0.0f && delivery.frontRoute.length() > 0);
        const int available = delivery.landed || !flightReady ? -1 : Team::HeavyTransport::Available(unit);
        if (available >= 0 && anchor.x >= 0.0f && (!forward || ai.frame>=delivery.nextFlightAttempt)) {
            delivery.nextFlightAttempt=ai.frame+int(Global::RoleSettings::Tech::HeavyDeliveryRouteRetrySeconds*SECOND);
            CFerryTask@ carrier = Team::Ferry::TaskOf(ai.GetTeamUnit(available));
            const AIFloat3 drop = forward ? anchor : aiTerrainMgr.FindSafeDropSpot(unit, anchor, Global::Ferry::SafeDropRadius,
                Global::Ferry::DropSurfaceThreat, Global::Ferry::DropAirThreat);
            if (drop.x >= 0.0f && (forward ? carrier.SetCargoRoute(unitId,delivery.frontRoute,
                Global::Ferry::DropSurfaceThreat,Global::RoleSettings::Tech::HeavyDeliveryAirThreat,
                Global::RoleSettings::Tech::HeavyDeliveryAirPadding,
                Global::RoleSettings::Tech::HeavyDeliveryBlockedSeconds) : carrier.SetCargo(unitId, drop,
                Global::Ferry::DropSurfaceThreat, Global::Ferry::DropAirThreat))) {
                delivery.carrier = available;
                aiTerrainMgr.SetLayoutInt(TechHeavyRush::StateKey + "carrier." + index, available);
                ReleaseRoute(delivery);
                GenericHelpers::LogUtil("[HeavyDelivery] fly cargo=" + unitId + " carrier=" + available
                    + " recipient=" + delivery.recipient, 1);
                return;
            }
            if (forward && drop.x >= 0.0f) LogRefusal(delivery, unit, "route refused "
                + RouteThreat(ai.GetTeamUnit(available), unit, delivery.frontRoute));
        } else if (available < 0 && !delivery.landed && flightReady && anchor.x >= 0.0f)
            LogRefusal(delivery, unit, "no free carrier " + Team::HeavyTransport::Describe(unit));
        IUnitTask@ walking = MilitaryTask(unit);
        if (walking !is null && unit.task !is walking) aiMilitaryMgr.TransferUnit(unit, walking);
    }
}
