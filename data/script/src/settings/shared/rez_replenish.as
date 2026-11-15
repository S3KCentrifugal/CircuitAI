// Rez bot replenishment and sharing (owner, 2026-10-26; systems/production/rez_replenish.as).
// Off by default; experimental_balanced/main.as turns it on. The [RezRep] stat lines are
// written whatever Enabled says, so a baseline game logs the same numbers.
namespace Global {
namespace RezReplenish {
        // A T1 bot lab of this AI keeps the rez bot count (armrectr / cornecro / legrezbot,
        // finished plus in production) at the target while the alive mobile army - every
        // finished mobile unit that is not a constructor, rez bot or commander (no build
        // power) - is worth more than ArmyMinMetal.
        bool Enabled = false;
        float ArmyMinMetal = 1200.0f;
        // Flat target (Scale = false).
        int Target = 11;
        // Scale = true: the target is the last ScaleTargets entry whose ScaleArmy entry the
        // army exceeds (both ascending, same length; the first ScaleArmy should be ArmyMinMetal).
        bool Scale = false;
        // Owner (2026-11-07): from 2500 to 10000 army metal, in 500-metal buckets, the target is
        // floor(25% of the bucket's army metal / 130), the metal cost of armrectr / cornecro / legrezbot.
        // Below 2500 the old first tier stays: 3 rez bots above 1200. Above 10000 it stays at 19.
        // Static values (worked out once here, not per lookup):
        //   army >   1200 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 8500 9000 9500 10000
        //   rez       3    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18   19
        // (was 1200/1500/2000/2500/3000/3500/4000/6000/9000/12000 -> 3/4/5/6/8/10/12/15/18/20)
        array<float> ScaleArmy = {1200.0f, 2500.0f, 3000.0f, 3500.0f, 4000.0f, 4500.0f, 5000.0f, 5500.0f, 6000.0f,
            6500.0f, 7000.0f, 7500.0f, 8000.0f, 8500.0f, 9000.0f, 9500.0f, 10000.0f};
        array<int> ScaleTargets = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19};
        // 0 = off. N > 0: after N rez bot orders in a row a lab lets one build of its own production
        // through (unless fewer than InterleaveCriticalBelow rez bots are left), so a big deficit does
        // not stall constructors, openers and the army. Untested in games.
        int RezPerNormalBuild = 0;
        int InterleaveCriticalBelow = 2;
        // Rez bot orders still waiting for the lab to start them; at most this many at a time
        // across all our labs, and an order not started within OrderTimeoutSeconds is forgotten.
        int MaxOrdersInFlight = 2;
        // TECH and SUPPORT build their T1 bot lab as a throwaway opening lab and retire it at T2:
        // no replenishment and no donations from them unless this is set.
        bool IncludeTechSupport = false;
        int OrderTimeoutSeconds = 60;
        // A T1 bot lab Spam runs as a repeating pump never asks for a new task; while rez bots
        // are short, end one pump's repeat (at most once per lab per ReleaseSpacingSeconds) so the
        // lab takes the rez bot order and then returns to spam.
        bool ReleaseSpamLabs = true;
        int ReleaseSpacingSeconds = 20;
        // Owner (2026-10-27): once Spam pumps any of this AI's T1 bot labs, build no more rez bots at
        // all (no orders, no release - it overrides ReleaseSpamLabs - and the rez bot defs capped at 0).
        bool StopRezWhenSpam = false;
        // Owner (2026-10-27): done with rez bots from this metal income (m/s, 10 s minimum; 0 = off)
        // or this many minutes after the AI's first T2 factory finished (0 = off): no orders, no
        // Spam-lab take-back, no gifts or requests, rez bot defs capped at 0. Sticky = stays cut.
        float CutoffMetalIncome = 0.0f;
        float CutoffMinutesAfterT2 = 0.0f;
        bool CutoffSticky = true;
        // The income has to stay at or above CutoffMetalIncome this long (played: reclaim spikes put
        // two AIs over 65 m/s for 10 s at minute 2.7 while the sustained income was ~22).
        float CutoffIncomeSeconds = 60.0f;

        // Owner (2026-10-28): a second T1 bot lab, the rez lab. Spam, its vision, pressure, scouting and
        // defence come before rez bots, so once Spam pumps the first T1 bot lab of an AI that started on
        // a bot lab, no pump is taken back for rez bots (ReleaseSpamLabs is ignored) and the builders add
        // one more T1 bot lab. That lab keeps the rez bot stock, gifts to vehicle-plant allies included.
        // With the stock full it waits; from SpamFillIncomeRatio x the income at which the first lab
        // started spamming it pumps spam too, on the first lab's lane (repeat order, same calculated
        // path: Spam::laneLead), until a rez bot is short or the income falls under
        // SpamFillReleaseFraction of that bar. Sharing then runs by start factory: AIs that started on a
        // bot lab give, AIs that started on a vehicle plant ask (a vehicle AI's own spam bot lab no
        // longer turns it into a donor).
        bool SecondLab = false;
        float SpamFillIncomeRatio = 1.5f;
        float SpamFillReleaseFraction = 0.85f;
        // a builder starts the lab only from this bank (0: any; played 2026-10-28: a pumping lab keeps the
        // bank under 300, and 1,600 asks were refused for 6 minutes while the rez stock fell 20 -> 6)
        float SecondLabMinMetalBank = 0.0f;
        int SecondLabRetrySeconds = 30;         // between build orders while none stands or is queued
        float SecondLabRingStep = 450.0f;       // placement rings around the first lab: 1, 2, 3 x this

        // Sharing: an AI with a T1 bot lab gives rez bots to allied BARb AIs that have a vehicle
        // plant and no T1 bot lab. Such an AI asks (AiSendMessage "barbrez|req") by its OWN alive army:
        //   army above RequestMinArmy (1200):          fewer than RequestBelow (3) -> ask to reach RequestUpTo (6)
        //   army at or above RequestHighArmy (23400):  fewer than RequestHighBelow (6) -> ask to reach RequestHighUpTo (9)
        // (owner, 2026-11-07: 9 rez bots x 130 metal = 1170 = 5% of a 23400 army). Once it has asked it
        // keeps asking every RequestCooldownSeconds until it holds the level it asked for.
        // The bot-lab AI remembers every request but builds and gives toward one only as far as ITS OWN
        // alive army allows (owner, 2026-11-07): a requester is filled up to 3 rez bots once the donor's
        // army is above the donor's own 3-rez-bot tier, up to 6 above its 6 tier and up to 9 above its
        // 9 tier (GiftTierLevels / GiftTierDonorArmy, from the ScaleArmy table above: 1200 / 3500 / 5000).
        // With an army below 1200 a donor builds and gives nothing. It hands each one over with
        // ai.GiveUnits as it finishes, keeping at least max(own target, ShareKeepMin).
        bool ShareEnabled = false;
        int RequestBelow = 3;
        int RequestUpTo = 6;
        float RequestMinArmy = 1200.0f;
        float RequestHighArmy = 23400.0f;
        int RequestHighBelow = 6;
        int RequestHighUpTo = 9;
        array<int> GiftTierLevels = {3, 6, 9};
        array<float> GiftTierDonorArmy = {1200.0f, 3500.0f, 5000.0f};
        int RequestCooldownSeconds = 60;
        int RequestExpirySeconds = 240;   // the donor forgets a request not renewed for this long
        int ShareKeepMin = 2;
        int ShareMaxOutstanding = 18;     // rez bots a donor remembers for all requesters together (was 8)
        int GiftSpacingSeconds = 4;
        int AnnounceSeconds = 60;         // bot-lab AIs announce themselves to allies this often

        // Stat line period ([RezRep] stat ...).
        int LogSeconds = 30;
    }
}
