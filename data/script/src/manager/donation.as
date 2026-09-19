// T2 constructor hand-out from the TECH role to its closest allies.
#include "../define.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/map_helpers.as"
#include "roster.as"
#include "widget_link.as"
#include "ferry.as"

/******************************************************************************

T2 CONSTRUCTOR DONATION

A TECH instance reaches T2 long before its allies. It keeps the first
KeepCount T2 constructors for itself and then gives the next N it builds
away, one per build, each to the closest allied BARb that has not received one
yet (closest by start position from the team roster; allies without a roster
entry come last, and with no roster at all the lead team is used).

N is drawn once, when the first T2 constructor appears, from a decreasing
distribution over 1..MaxCount clipped to the number of allies:

    weight(k) = Decay^(k-1)          k = 1 .. min(MaxCount, allies)
    P(k)      = weight(k) / sum

so one constructor is the most likely outcome and the largest count the
least; with Decay 0.6 and seven allies P(1) ~ 0.41 and P(7) ~ 0.02. The
draw uses AiRandom, the AI's own generator. An ally that already received a
constructor is skipped until everyone has one, so N never exceeds the team
size and each donation goes to a different teammate as long as N <= allies.

Transfers use ai.GiveUnits, which detaches the unit from every task on the
donor before the engine moves it; the recipient adopts it through its normal
unit-given path. This replaces the old rule "give the third T2 constructor to
the lead team".

******************************************************************************/
namespace Team {
namespace Donation {
    int built = 0;             // T2 constructors this instance has produced
    int planned = -1;          // donations still to make; -1 = not drawn yet
    int given = 0;
    // team id string -> count, read and written as int64 (see D-019) and
    // ALWAYS read through Count() below. Two rules of the dictionary add-on
    // bit this table, one after the other:
    //   1. set(string, int) stores INT64 and get(string, int&out) cannot read
    //      it back - every count read as 0, closest ally got everything.
    //   2. get(key, int64&out c) on a key that does not exist returns false
    //      and leaves c UNDEFINED: an &out argument is an uninitialised
    //      temporary copied back regardless of the return value, so the
    //      "= 0" initialiser is overwritten with junk. Every count read as
    //      ~1e6+, PickRecipient never chose anyone, and no constructor was
    //      ever donated or ferried.
    // Never trust an &out after a failed get: check exists() first.
    dictionary givenTo;

    int64 Count(int teamId)
    {
        const string key = "" + teamId;
        if (!givenTo.exists(key)) return 0;
        int64 c = 0;
        givenTo.get(key, c);
        return c;
    }

    void Bump(int teamId)
    {
        givenTo.set("" + teamId, Count(teamId) + 1);
    }

    // How many to donate: one draw from the decreasing distribution, clipped to the allies.
    int DrawCount(int allies)
    {
        int maxCount = Global::RoleSettings::Tech::T2DonationMax;
        if (allies < maxCount) maxCount = allies;
        if (maxCount <= 0) return 0;
        const float decay = Global::RoleSettings::Tech::T2DonationDecay;
        array<float> weights(maxCount);
        float sum = 0.0f;
        float w = 1.0f;
        for (int k = 0; k < maxCount; ++k) {
            weights[k] = w;
            sum += w;
            w *= decay;
        }
        int roll = AiRandom(0, 999);
        if (roll < 0) roll = 0;
        if (roll > 999) roll = 999;
        const float target = (float(roll) + 0.5f) / 1000.0f * sum;
        float acc = 0.0f;
        for (int k = 0; k < maxCount; ++k) {
            acc += weights[k];
            if (target < acc) return k + 1;
        }
        return maxCount;
    }

    // Allies ordered by distance of their announced start from ours; unknown ones last.
    array<int> AlliesByDistance()
    {
        array<int> ordered;
        array<float> dist;
        array<int> allies = Team::Roster::AllyTeamIds();
        for (uint i = 0; i < allies.length(); ++i) {
            Team::Roster::Entry@ e = Team::Roster::Get(allies[i]);
            const float d = (e is null) ? 1e30f : MapHelpers::SqDist(Global::Map::StartPos, e.startPos);
            uint pos = 0;
            while (pos < dist.length() && dist[pos] <= d) ++pos;
            ordered.insertAt(pos, allies[i]);
            dist.insertAt(pos, d);
        }
        return ordered;
    }

    // Closest ally that has received the fewest constructors so far.
    int PickRecipient()
    {
        array<int> ordered = AlliesByDistance();
        if (ordered.length() == 0) {
            const int leader = ai.GetLeadTeamId();
            return (leader == ai.teamId) ? -1 : leader;
        }
        int best = -1;
        int64 bestCount = 1000000;
        for (uint i = 0; i < ordered.length(); ++i) {
            const int64 c = Count(ordered[i]);
            if (c < bestCount) { bestCount = c; best = ordered[i]; }   // ties keep the closer one
        }
        GenericHelpers::LogUtil("[Team][Donation] PickRecipient -> team " + best + " (count " + bestCount
            + " of " + ordered.length() + " allies)", 1);
        return best;
    }

    // Builder::AiUnitAdded of the TECH role: called for every finished builder.
    void OnConstructorBuilt(CCircuitUnit@ unit)
    {
        if (unit is null || unit.circuitDef is null) return;
        if (!Team::IsT2Constructor(unit.circuitDef)) return;
        ++built;
        // Level 1 on purpose: LOG_LEVEL is 1 in define.as, so anything at 2
        // never reaches the log. Four T2 constructors were built in one game
        // and the log could not say whether this ran four times, twice, or
        // once - every branch below except the give itself was level 2.
        GenericHelpers::LogUtil("[Team][Donation] T2 constructor #" + built + ": " + unit.circuitDef.GetName()
            + "(" + unit.id + ") planned=" + planned + " given=" + given
            + " keep=" + Global::RoleSettings::Tech::T2DonationKeepCount, 1);

        if (planned < 0) {
            const int allies = int(Team::Roster::AllyTeamIds().length());
            planned = DrawCount(allies);
            GenericHelpers::LogUtil("[Team][Donation] Plan: keep " + Global::RoleSettings::Tech::T2DonationKeepCount
                + ", donate " + planned + " of the following T2 constructors (allies=" + allies + ")", 1);
        }
        // Say why nothing happens. A finished T2 constructor standing next to
        // an idle ferry transport looks like a broken pickup; the first
        // KeepCount are simply ours, and after the plan is met the rest are too.
        if (built <= Global::RoleSettings::Tech::T2DonationKeepCount) {
            GenericHelpers::LogUtil("[Team][Donation] keeping " + unit.circuitDef.GetName() + " (built "
                + built + " of keep " + Global::RoleSettings::Tech::T2DonationKeepCount
                + "; donations start at #" + (Global::RoleSettings::Tech::T2DonationKeepCount + 1) + ")", 1);
            return;
        }
        if (given >= planned) {
            GenericHelpers::LogUtil("[Team][Donation] keeping " + unit.circuitDef.GetName()
                + " (plan met: " + given + "/" + planned + ")", 1);
            return;
        }

        const int recipient = PickRecipient();
        // Every path into PickRecipient already excludes our own team - AllyTeamIds
        // filters it and the lead-team fallback returns -1 - but a gift to
        // ourselves would silently consume a donation slot, so assert it here
        // rather than trust three call sites to stay correct.
        if (recipient == ai.teamId) {
            GenericHelpers::LogUtil("[Team][Donation] BUG: recipient resolved to our own team "
                + recipient + "; keeping the constructor", 1);
            return;
        }
        if (recipient < 0) {
            GenericHelpers::LogUtil("[Team][Donation] No recipient (no allies or we lead alone); keeping " + unit.circuitDef.GetName(), 1);
            return;
        }
        const string name = unit.circuitDef.GetName();
        const int unitId = unit.id;

        // Fly it if a ferry is free. Team::Ferry hands the unit over itself
        // once the drop lands, so the accounting below still runs exactly
        // once either way. A refusal - no transport yet, one already in the
        // air, the transport dead - falls through to the walk.
        {
            Team::Roster::Entry@ e = Team::Roster::Get(recipient);
            if (e !is null && Team::Ferry::TryCarry(unit, recipient, e.startPos)) {
                ++given;
                Bump(recipient);
                GenericHelpers::LogUtil("[Team][Donation] " + name + "(" + unitId
                    + ") being ferried to team " + recipient, 1);
                return;
            }
        }

        array<CCircuitUnit@> give(1);
        @give[0] = unit;   // valid handle this frame
        ai.GiveUnits(give, recipient);
        ++given;
        Bump(recipient);
        GenericHelpers::LogUtil("[Team][Donation] Gave " + name + " (id=" + unitId + ") to team " + recipient
            + " (" + given + "/" + planned + ")", 1);
        WidgetLink::Send("donation", name + "|" + recipient + "|" + given + "|" + planned);
    }
}  // namespace Donation
}  // namespace Team
