// T2 constructor hand-out from the TECH role to its closest allies.
#include "../define.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/map_helpers.as"
#include "roster.as"
#include "widget_link.as"

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
    dictionary givenTo;        // team id string -> int count

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
        int bestCount = 1000000;
        for (uint i = 0; i < ordered.length(); ++i) {
            int c = 0;
            givenTo.get("" + ordered[i], c);
            if (c < bestCount) { bestCount = c; best = ordered[i]; }   // ties keep the closer one
        }
        return best;
    }

    // Builder::AiUnitAdded of the TECH role: called for every finished builder.
    void OnConstructorBuilt(CCircuitUnit@ unit)
    {
        if (unit is null || unit.circuitDef is null) return;
        if (!Team::IsT2Constructor(unit.circuitDef)) return;
        ++built;

        if (planned < 0) {
            const int allies = int(Team::Roster::AllyTeamIds().length());
            planned = DrawCount(allies);
            GenericHelpers::LogUtil("[Team][Donation] Plan: keep " + Global::RoleSettings::Tech::T2DonationKeepCount
                + ", donate " + planned + " of the following T2 constructors (allies=" + allies + ")", 1);
        }
        if (built <= Global::RoleSettings::Tech::T2DonationKeepCount) return;
        if (given >= planned) return;

        const int recipient = PickRecipient();
        if (recipient < 0) {
            GenericHelpers::LogUtil("[Team][Donation] No recipient (no allies or we lead alone); keeping " + unit.circuitDef.GetName(), 2);
            return;
        }
        const string name = unit.circuitDef.GetName();
        const int unitId = unit.id;
        array<CCircuitUnit@> give(1);
        @give[0] = unit;   // valid handle this frame
        ai.GiveUnits(give, recipient);
        ++given;
        int c = 0;
        givenTo.get("" + recipient, c);
        givenTo.set("" + recipient, c + 1);
        GenericHelpers::LogUtil("[Team][Donation] Gave " + name + " (id=" + unitId + ") to team " + recipient
            + " (" + given + "/" + planned + ")", 1);
        WidgetLink::Send("donation", name + "|" + recipient + "|" + given + "|" + planned);
    }
}  // namespace Donation
}  // namespace Team
