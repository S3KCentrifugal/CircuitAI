// Air transport ferry: AIR builds a transport for TECH, TECH flies donations.
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/map_helpers.as"
#include "roster.as"
#include "widget_link.as"

/******************************************************************************

TRANSPORT FERRY

A donated T2 constructor used to walk to its new owner: 410-470 metal of
unescorted builder crossing a contested map. This flies it instead.

The protocol is three messages over AiSendMessage, the channel the roster
already uses. It is deliberately not ai.CallUI - that is a one-way mirror to
the local LuaUI for display and never reaches another AI, so it cannot carry
coordination.

    barbferry|req|<x>|<z>     TECH -> all, when it starts its first T2 lab.
                              Carries TECH's base position so AIR need not
                              have seen TECH's roster line yet.
    barbferry|ack             AIR  -> TECH, "I am building one for you".
    barbferry|give|<unitId>   AIR  -> TECH, "it is over your base and yours".

Sequence, in the order the units actually move:

  1. TECH starts its first T2 lab   -> broadcast req
  2. AIR takes the request          -> the next air factory task is a
                                       transport, ahead of everything else
  3. transport finishes             -> AIR flies it to TECH's base itself,
                                       still owning it, so the hand-over
                                       happens where TECH wants the unit
  4. transport arrives              -> ai.GiveUnits to TECH, send give
  5. TECH receives it               -> CFerryTask holds it at TECH's base and
                                       it is never an army unit, because
                                       ROLE_TYPE(TRANS) now maps to FERRY in
                                       CMilitaryManager::DefaultMakeTask
  6. TECH donates a constructor     -> ferry.SetCargo(unit, recipient base):
                                       pick up, fly, drop
  7. the drop lands                 -> TECH gives the constructor to the
                                       recipient and the transport flies home

Every failure path falls back to the old behaviour - give the constructor and
let it walk - so a ferry that cannot be built, is shot down, or fails to lift
its cargo costs time, never the donation.

See doc/transport-ferry.md.

******************************************************************************/
namespace Team {
namespace Ferry {

    const string MSG = "barbferry";

    // CFerryTask::EState. Mirrored rather than registered as an enum: only the
    // two terminal values matter to policy.
    const int StateIdle = 0;
    const int StateDone = 5;
    const int StateFailed = 6;

    // ---- AIR side
    bool requestPending = false;   // a TECH asked and we have not delivered
    int  requestTeam = -1;
    AIFloat3 requestPos;
    int  orderedFrame = -1;        // a Recruit task is queued; do not queue more
    int  buildingId = -1;          // transport we are flying to TECH
    bool announced = false;

    // ---- TECH side
    bool requestSent = false;      // one-shot: only the first T2 lab asks
    int  transportId = -1;         // our ferry transport, once received
    int  cargoId = -1;             // constructor in flight
    int  cargoRecipient = -1;

    bool IsEnabled() { return Global::Ferry::Enabled; }

    string TransportForSide(const string &in side)
    {
        string name = "";
        Global::Ferry::TransportBySide.get(side, name);
        return name;
    }

    // The CFerryTask a transport carries. Every TRANS-role unit gets one from
    // CMilitaryManager::DefaultMakeTask, so this is null only before the unit
    // has been given a task, or after it died.
    CFerryTask@ TaskOf(CCircuitUnit@ u)
    {
        if (u is null || u.task is null) return null;
        IFighterTask@ ft = cast<IFighterTask>(u.task);
        if (ft is null) return null;
        return cast<CFerryTask>(ft);
    }

    CCircuitUnit@ Transport()
    {
        return (transportId < 0) ? null : ai.GetTeamUnit(transportId);
    }

    /**************************************************************************
     TECH: ask, once, when the first T2 lab goes down.
     Called from Builder::AiTaskAdded, which sees every role's build tasks.
     **************************************************************************/
    void OnT2LabStarted()
    {
        if (!IsEnabled() || requestSent) return;
        if (Global::AISettings::Role != AiRole::TECH) return;
        requestSent = true;
        const AIFloat3 p = Global::Map::StartPos;
        AiSendMessage(MSG + "|req|" + int(p.x) + "|" + int(p.z));
        GenericHelpers::LogUtil("[Ferry] TECH: requested a transport (first T2 lab started)", 1);
        WidgetLink::Send("ferry", "req|" + int(p.x) + "|" + int(p.z));
    }

    /**************************************************************************
     AIR: take the request, build the transport ahead of everything else.
     **************************************************************************/
    // Factory::AiMakeTask asks here before the role handler, the same way it
    // asks Spam. Returns null unless we owe someone a transport.
    IUnitTask@ FactoryMakeTask(CCircuitUnit@ factory)
    {
        if (!IsEnabled() || !requestPending || buildingId >= 0) return null;
        if (Global::AISettings::Role != AiRole::AIR) return null;
        if (factory is null || factory.circuitDef is null) return null;
        // One transport, not one per poll. The factory asks for a task every
        // time it goes idle, and buildingId is only set once the unit *exists*
        // - so without this latch every poll between the order and the unit
        // popping queued another transport, and the air plant built nothing
        // else for the rest of the game. Re-armed only if the order produced
        // nothing within OrderTimeoutSeconds (factory died, def disabled).
        if (orderedFrame >= 0) {
            if ((ai.frame - orderedFrame) < int(Global::Ferry::OrderTimeoutSeconds) * SECOND) {
                return null;
            }
            GenericHelpers::LogUtil("[Ferry] AIR: transport order timed out; re-ordering", 2);
            orderedFrame = -1;
        }
        // Only the air plant builds it. Both the light and heavy transports
        // come from the T1 plant, so this never waits on T2.
        if (factory.circuitDef.GetName() != UnitHelpers::GetT1AirPlantForSide(Global::AISettings::Side)) return null;

        const string name = TransportForSide(Global::AISettings::Side);
        if (name.length() == 0) return null;
        CCircuitDef@ d = ai.GetCircuitDef(name);
        if (d is null || !d.IsAvailable(ai.frame)) {
            GenericHelpers::LogUtil("[Ferry] AIR: '" + name + "' unavailable; cannot fill the request", 2);
            return null;
        }

        if (!announced) {
            announced = true;
            AiSendMessage(MSG + "|ack", requestTeam);
        }
        orderedFrame = ai.frame;
        GenericHelpers::LogUtil("[Ferry] AIR: ordered one " + name + " for team " + requestTeam, 1);
        return aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER, Task::Priority::NOW,
                d, factory.GetPos(ai.frame), 64.f));
    }

    // Military::AiUnitAdded. Two cases: AIR's new transport, and the one TECH
    // receives from AIR.
    // True for a unit we should treat as the ferry transport. The role tag is
    // the primary test, but a def missing its "transport" tag in behaviour.json
    // is exactly the failure that sent the first transports to the front, so
    // the configured name counts too: Global::Ferry::TransportBySide is the
    // single place that decides what the ferry is.
    bool IsFerryTransport(const CCircuitDef@ d)
    {
        if (d is null) return false;
        if (d.IsRoleAny(Unit::Role::TRANS.mask)) return true;
        return d.GetName() == TransportForSide(Global::AISettings::Side);
    }

    void OnUnitAdded(CCircuitUnit@ unit)
    {
        if (!IsEnabled() || unit is null || unit.circuitDef is null) return;
        if (!IsFerryTransport(unit.circuitDef)) return;

        if (Global::AISettings::Role == AiRole::AIR) {
            if (requestPending && buildingId < 0) {
                buildingId = unit.id;
                orderedFrame = -1;   // the order produced its unit
                // Fly it over before handing it across. A unit given at our own
                // base would have to cross the map under TECH's control with no
                // task that knows where to send it.
                CFerryTask@ t = TaskOf(unit);
                if (t !is null) t.SetHoldPos(requestPos);
                GenericHelpers::LogUtil("[Ferry] AIR: transport " + unit.id + " built, flying to ("
                    + int(requestPos.x) + "," + int(requestPos.z) + ")", 1);
            }
            return;
        }
        if (Global::AISettings::Role == AiRole::TECH && transportId < 0) {
            transportId = unit.id;
            CFerryTask@ t = TaskOf(unit);
            if (t !is null) t.SetHoldPos(Global::Map::StartPos);
            GenericHelpers::LogUtil("[Ferry] TECH: transport " + unit.id + " received and reserved", 1);
            WidgetLink::Send("ferry", "have|" + unit.id);
        }
    }

    void OnUnitRemoved(CCircuitUnit@ unit)
    {
        if (unit is null) return;
        if (unit.id == buildingId) {
            buildingId = -1;
            orderedFrame = -1;   // shot down in transit: the request is still owed
        }
        if (unit.id == transportId) {
            transportId = -1;
            GenericHelpers::LogUtil("[Ferry] TECH: transport lost; donations walk again", 2);
        }
    }

    /**************************************************************************
     TECH: fly a donation instead of walking it.
     **************************************************************************/
    // True when the ferry took the job. False means "walk it", and the caller
    // donates immediately exactly as it did before.
    bool TryCarry(CCircuitUnit@ cargo, int recipient, const AIFloat3 &in dropPos)
    {
        if (!IsEnabled() || cargo is null || recipient < 0) return false;
        if (cargoId >= 0) return false;              // one run at a time
        CCircuitUnit@ t = Transport();
        if (t is null) return false;
        CFerryTask@ task = TaskOf(t);
        if (task is null) return false;
        if (!task.SetCargo(cargo.id, dropPos)) return false;
        cargoId = cargo.id;
        cargoRecipient = recipient;
        GenericHelpers::LogUtil("[Ferry] TECH: carrying " + cargo.id + " to team " + recipient
            + " at (" + int(dropPos.x) + "," + int(dropPos.z) + ")", 1);
        WidgetLink::Send("ferry", "carry|" + cargo.id + "|" + recipient);
        return true;
    }

    // Hand the cargo over and release the transport. `delivered` distinguishes
    // a flown delivery from a fallback, for the log only - the constructor
    // changes hands either way.
    void _Finish(bool delivered)
    {
        CCircuitUnit@ cargo = (cargoId < 0) ? null : ai.GetTeamUnit(cargoId);
        if (cargo !is null && cargoRecipient >= 0 && cargoRecipient != ai.teamId) {
            array<CCircuitUnit@> give(1);
            @give[0] = cargo;
            ai.GiveUnits(give, cargoRecipient);
            GenericHelpers::LogUtil("[Ferry] TECH: " + (delivered ? "delivered" : "fell back, gave")
                + " constructor " + cargoId + " to team " + cargoRecipient, 1);
            WidgetLink::Send("ferry", (delivered ? "done|" : "fallback|") + cargoId + "|" + cargoRecipient);
        }
        cargoId = -1;
        cargoRecipient = -1;
        CFerryTask@ task = TaskOf(Transport());
        if (task !is null) task.Reset();   // sends it home
    }

    /**************************************************************************
     Tick. Main::AiUpdate, every 30 frames.
     **************************************************************************/
    void Update()
    {
        if (!IsEnabled()) return;

        // AIR: has the transport reached TECH's base? Hand it over there.
        if (buildingId >= 0 && requestPending) {
            CCircuitUnit@ t = ai.GetTeamUnit(buildingId);
            if (t is null) {
                buildingId = -1;
                announced = false;
            } else if (MapHelpers::SqDist(t.GetPos(ai.frame), requestPos)
                       < Global::Ferry::ArriveRadius * Global::Ferry::ArriveRadius) {
                array<CCircuitUnit@> give(1);
                @give[0] = t;
                ai.GiveUnits(give, requestTeam);
                AiSendMessage(MSG + "|give|" + buildingId, requestTeam);
                GenericHelpers::LogUtil("[Ferry] AIR: transport " + buildingId
                    + " arrived and transferred to team " + requestTeam, 1);
                WidgetLink::Send("ferry", "gave|" + buildingId + "|" + requestTeam);
                requestPending = false;
                buildingId = -1;
            }
        }

        // TECH: poll the run.
        if (cargoId >= 0) {
            CFerryTask@ task = TaskOf(Transport());
            if (task is null) {
                _Finish(false);   // transport died mid-run; walk the rest
                return;
            }
            const int st = task.GetState();
            if (st == StateDone) {
                _Finish(true);
            } else if (st == StateFailed) {
                _Finish(false);
            }
        }
    }

    /**************************************************************************
     Messages. Team::HandleMessage routes here.
     **************************************************************************/
    bool HandleMessage(const string &in msg, int fromTeamId)
    {
        if (!IsEnabled()) return false;
        array<string>@ p = msg.split("|");
        if (p.length() < 2 || p[0] != MSG) return false;

        if (p[1] == "req") {
            if (Global::AISettings::Role != AiRole::AIR) return true;
            if (requestPending || buildingId >= 0) return true;   // already committed
            requestTeam = fromTeamId;
            requestPos = Global::Map::StartPos;
            if (p.length() >= 4) {
                requestPos = AIFloat3(parseFloat(p[2]), 0.f, parseFloat(p[3]));
            }
            // Prefer the roster's own position when we have it: the sender's
            // message may predate a start-position correction.
            Team::Roster::Entry@ e = Team::Roster::Get(fromTeamId);
            if (e !is null) requestPos = e.startPos;
            requestPending = true;
            announced = false;
            GenericHelpers::LogUtil("[Ferry] AIR: request from team " + fromTeamId
                + " at (" + int(requestPos.x) + "," + int(requestPos.z) + ")", 1);
            return true;
        }
        if (p[1] == "ack") {
            GenericHelpers::LogUtil("[Ferry] TECH: team " + fromTeamId + " is building our transport", 2);
            return true;
        }
        if (p[1] == "give") {
            GenericHelpers::LogUtil("[Ferry] TECH: team " + fromTeamId + " transferred transport "
                + (p.length() >= 3 ? p[2] : "?"), 2);
            return true;   // OnUnitAdded does the reserving
        }
        return false;
    }

}  // namespace Ferry
}  // namespace Team
