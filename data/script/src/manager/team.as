#include "../global.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/generic_helpers.as"

namespace Team {
    // Count of T2 constructors ever produced by TECH role (bots/vehicles; include T2 air explicitly)
    int T2CtorEverBuilt = 0;
    // Ensure we donate only once per game
    bool DonatedThird = false;

    // Return true if the def represents a T2 constructor (land or air)
    bool IsT2Constructor(const CCircuitDef @d) {
        if (d is null) return false;
        // Tier via helper (bots/vehicles)
        int tier = UnitHelpers::GetConstructorTier(d);
        if (tier == 2) return true;
        // Air constructors: infer T2 by explicit names
        const string n = d.GetName();
        // T2 air constructors (BAR): armaca/coraca/legaca
        if (UnitHelpers::IsAirConstructor(d)) {
            if (n == "armaca" || n == "coraca" || n == "legaca") return true;
        }
        return false;
    }

    // Attempt to donate a unit to the lead team; logs and guards
    void TryDonate(CCircuitUnit @u) {
        if (u is null) return;
        const int leader = ai.GetLeadTeamId();
        if (ai.teamId == leader) {
            GenericHelpers::LogUtil("[Team] We are the leader team; skip donation for unit id=" + u.id, 3);
            return; // no-op when this AI is the leader
        }

        array<CCircuitUnit @> give(1);
        @give[0] = u; // valid handle this frame
        ai.GiveUnits(give, leader);
        GenericHelpers::LogUtil("[Team] Transferred unit id=" + u.id + " to team " + leader, 2);
    }

    void CheckDonation(CCircuitUnit @unit) {
        if (unit is null) return;
        const CCircuitDef @d = unit.circuitDef;
        if (d is null) return;

        if (IsT2Constructor(d)) {
            // Assuming this is called from Tech_BuilderAiUnitAdded where we might want to disable assist
            // But disabling assist is factory manager logic.
            // The original code did: aiFactoryMgr.isAssistRequired = false;
            // We will leave that side effect in the caller or handle it here if we can access aiFactoryMgr.
            // Since aiFactoryMgr is likely a global or member of the main script class, we might not have access here easily without passing it.
            // However, for now, we will just handle the donation logic.
            
            T2CtorEverBuilt += 1;
            GenericHelpers::LogUtil("[Team] T2 constructor observed (" + d.GetName() + ") count=" + T2CtorEverBuilt + " id=" + unit.id, 3);

            if (!DonatedThird && T2CtorEverBuilt == 3) {
                DonatedThird = true; // lock before attempt to avoid re-entry
                GenericHelpers::LogUtil("[Team] Triggering donation of 3rd T2 constructor (id=" + unit.id + ")", 2);
                TryDonate(unit);
            }
        }
    }

    /******************************************************************************

    ORPHAN RESCUE

    An allied BARb that has lost its commander and every constructor cannot
    rebuild: under deathmode "com" the team stays alive (only the whole ally
    team's last commander ends it), so its buildings and army sit idle forever.
    The orphaned AI asks its allies, one at a time, for a T1 constructor; a
    donor with spare build power hands one over with ai.GiveUnits. The receiver
    adopts it through the normal EVENT_UNIT_GIVEN -> Builder::AiUnitAdded path and,
    with factoryCount == 0, native UpdateFactoryTasks treats the next factory as
    a start factory built where the constructor stands.

    Messaging is in-process (AiSendMessage reaches BARb instances on the same
    ally team only); human allies and other AIs never see it. BAR applies a
    temporary build-speed debuff to shared builders and, with the
    disable_unit_sharing mod option, silently refuses the transfer - the
    orphan then keeps asking at OrphanRequestIntervalFrames, which is cheap.

    CCircuitUnit handles are not ref-counted (see builder.as); the registry
    stores unit ids and reacquires live units with ai.GetTeamUnit(id).

    ******************************************************************************/
    namespace Orphan {
        const string RequestMessage = "need_builder";
        const int RequestIntervalFrames = 20 * SECOND;   // between requests to successive allies
        const int DonateCooldownFrames = 60 * SECOND;    // per requesting team, on the donor
        const uint MinWorkersToDonate = 3;               // donor keeps at least two builders
        const int MinFramesBeforeRequest = 60 * SECOND;  // never fire during the opening

        int lastRequestFrame = -1;
        uint nextAllyIdx = 0;
        dictionary lastDonateFrameByTeam;                // key: requesting team id -> int frame
    }

    // Live T1 constructors of this team, key: id string -> int id. Maintained by
    // Builder::AiUnitAdded / AiUnitRemoved.
    dictionary t1ConstructorIds;

    void RegisterT1Constructor(CCircuitUnit @unit) {
        if (unit is null) return;
        t1ConstructorIds.set("" + unit.id, int(unit.id));
    }

    void UnregisterT1Constructor(CCircuitUnit @unit) {
        if (unit is null) return;
        t1ConstructorIds.delete("" + unit.id);
    }

    bool _IsTrackedLeader(CCircuitUnit @u) {
        return (Builder::commander is u)
            || (Builder::primaryT1BotConstructor is u) || (Builder::secondaryT1BotConstructor is u)
            || (Builder::primaryT1VehConstructor is u) || (Builder::secondaryT1VehConstructor is u)
            || (Builder::primaryT1AirConstructor is u) || (Builder::secondaryT1AirConstructor is u)
            || (Builder::primaryT1SeaConstructor is u)
            || (Builder::tacticalBotConstructor is u) || (Builder::tacticalVehConstructor is u)
            || (Builder::tacticalAirConstructor is u) || (Builder::tacticalSeaConstructor is u)
            || (Builder::tacticalHoverConstructor is u);
    }

    // A live T1 constructor this AI can spare: not the commander, not a tracked
    // primary/secondary/tactical leader. Prefers land constructors (bot/vehicle)
    // since the receiver has to rebuild a land base; falls back to any T1 constructor.
    CCircuitUnit @FindSpareT1Constructor() {
        CCircuitUnit @fallback = null;
        array<string>@ keys = t1ConstructorIds.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            int id = 0;
            if (!t1ConstructorIds.get(keys[i], id)) continue;
            CCircuitUnit @u = ai.GetTeamUnit(id);
            if (u is null) { t1ConstructorIds.delete(keys[i]); continue; }   // died without a removal callback
            if (_IsTrackedLeader(u)) continue;
            const CCircuitDef @d = u.circuitDef;
            if (d is null) continue;
            if (UnitHelpers::IsT1BotConstructor(d.GetName()) || UnitHelpers::GetT1VehicleConstructors("").find(d.GetName()) >= 0) {
                return u;
            }
            if (fallback is null) @fallback = u;
        }
        return fallback;
    }

    // Orphan side. Called from Main::AiUpdate (every 30 frames).
    void CheckOrphaned() {
        if (ai.frame < Orphan::MinFramesBeforeRequest) return;
        if (aiBuilderMgr.GetWorkerCount() > 0 || Builder::commander !is null) {
            Orphan::lastRequestFrame = -1;
            return;
        }
        if (Orphan::lastRequestFrame >= 0 && (ai.frame - Orphan::lastRequestFrame) < Orphan::RequestIntervalFrames) return;

        array<Id>@ teams = ai.GetTeamIds();   // this ally team, including us
        if (teams is null || teams.length() <= 1) return;
        // Round-robin over allies; skip ourselves without burning the interval.
        for (uint tries = 0; tries < teams.length(); ++tries) {
            Id target = teams[Orphan::nextAllyIdx++ % teams.length()];
            if (int(target) == ai.teamId) continue;
            AiSendMessage(Orphan::RequestMessage, int(target));
            Orphan::lastRequestFrame = ai.frame;
            GenericHelpers::LogUtil("[Team][Orphan] No commander and no constructors; asked team " + target + " for a T1 constructor", 1);
            return;
        }
    }

    // Donor side. Called from Main::AiMessage for every message from an allied BARb.
    void HandleMessage(const string &in msg, int fromTeamId) {
        if (msg != Orphan::RequestMessage) return;
        if (fromTeamId == ai.teamId) return;

        int last = -1;
        if (Orphan::lastDonateFrameByTeam.get("" + fromTeamId, last) && (ai.frame - last) < Orphan::DonateCooldownFrames) {
            GenericHelpers::LogUtil("[Team][Orphan] Request from team " + fromTeamId + " within cooldown; ignored", 3);
            return;
        }
        if (aiBuilderMgr.GetWorkerCount() < Orphan::MinWorkersToDonate) {
            GenericHelpers::LogUtil("[Team][Orphan] Team " + fromTeamId + " needs a constructor but we have only "
                + aiBuilderMgr.GetWorkerCount() + " workers; declined", 2);
            return;
        }
        CCircuitUnit @spare = FindSpareT1Constructor();
        if (spare is null) {
            GenericHelpers::LogUtil("[Team][Orphan] Team " + fromTeamId + " needs a constructor but we have no spare T1; declined", 2);
            return;
        }
        const string name = (spare.circuitDef is null) ? "?" : spare.circuitDef.GetName();
        const Id spareId = spare.id;
        array<CCircuitUnit @> give(1);
        @give[0] = spare;   // valid handle this frame
        ai.GiveUnits(give, fromTeamId);
        Orphan::lastDonateFrameByTeam.set("" + fromTeamId, int(ai.frame));
        GenericHelpers::LogUtil("[Team][Orphan] Donated " + name + " (id=" + spareId + ") to orphaned team " + fromTeamId, 1);
    }
}
