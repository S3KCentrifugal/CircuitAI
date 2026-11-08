// D-495: when the FRONT commander group may build T1 static artillery
// (src/circuit/control/kernel/ArtilleryT1Gate.h), one test per owner rule.
#include "control/kernel/ArtilleryT1Gate.h"
#include <cstdio>
#include <string>
#include <vector>
using namespace circuit::artillery_t1;

static int failures = 0;
static void Check(bool ok, const std::string& what)
{
	if (!ok) { ++failures; std::printf("FAIL: %s\n", what.c_str()); }
}

constexpr float GAIN = .6f, MARGIN = 64.f, MOBILE = 820.f, VALUE = 1.f, CLUSTER = 400.f;
constexpr float GAUNTLET_RANGE = 1220.f, GAUNTLET_COST = 1250.f;

static Contact Static(int id, float x, float z, float range, float cost, float y = 0.f, bool gun = false)
{
	Contact c; c.id = id; c.pos = {x, z}; c.range = range; c.costM = cost; c.elevation = y; c.t1Gun = gun; c.seen = true;
	return c;
}

static void CounterBatteryNeedsOurStructureNear()
{
	const Contact gun = Static(1, 0, 0, 1245, 1300, 0, true);
	const std::vector<Contact> e = {gun};
	Check(Justify(gun, e, true, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::Counter,
		"an enemy T1 gun near one of our structures is a counter-battery target");
	Check(Justify(gun, e, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) != Case::Counter,
		"an enemy T1 gun with none of our structures near is not");
}

static void AmputatorTakesNoCounterBattery()
{
	const Contact gun = Static(1, 0, 0, 1245, 1300, 0, true);
	const std::vector<Contact> e = {gun};
	// counterAllowed false (the Amputator): only the siege case remains, and a
	// lone 1300-metal gun out-ranging mobile artillery is worth the gun's metal.
	Check(Justify(gun, e, true, false, 0, GAIN, MOBILE, 850.f, VALUE, CLUSTER) == Case::Siege,
		"without counter-battery the enemy gun is still a siege target on value");
	Check(Justify(gun, e, true, false, 0, GAIN, MOBILE, 1400.f, VALUE, CLUSTER) == Case::None,
		"and not when it is worth less than the gun");
}

static void SiegeOnlyWhatMobileArtilleryCannotReach()
{
	// Three HLTs (620 range, 440 metal) on level ground: Mausers (820) out-range them.
	const std::vector<Contact> flat = {Static(1, 0, 0, 620, 440), Static(2, 100, 0, 620, 440), Static(3, 0, 100, 620, 440)};
	Check(Justify(flat[0], flat, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::None,
		"a level HLT line is mobile artillery's work");
	// The same line 400 elmos above our front: 620 + 0.6 x 400 = 860 >= 820.
	std::vector<Contact> high = flat;
	for (auto& c : high) c.elevation = 400.f;
	Check(Justify(high[0], high, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::Siege,
		"an HLT line on high ground is a siege target");
}

static void SiegeNeedsValue()
{
	std::vector<Contact> one = {Static(1, 0, 0, 620, 440, 400)};
	Check(Justify(one[0], one, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::None,
		"one HLT on a hill (440 metal) is not worth a 1250-metal gun");
	one.push_back(Static(2, 300, 0, 620, 440, 400));
	one.push_back(Static(3, 0, 300, 620, 440, 400));
	Check(Justify(one[0], one, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::Siege,
		"three of them within the cluster radius are");
	one[2].pos = {0, 900};
	Check(Justify(one[0], one, false, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::None,
		"a structure beyond the cluster radius does not count");
}

static void UnseenTargetsAreIgnored()
{
	Contact gun = Static(1, 0, 0, 1245, 1300, 0, true);
	gun.seen = false;
	const std::vector<Contact> e = {gun};
	Check(Justify(gun, e, true, true, 0, GAIN, MOBILE, GAUNTLET_COST, VALUE, CLUSTER) == Case::None,
		"a target out of sight and radar is not a target");
}

static void SiteMustReachTheTarget()
{
	const Contact target = Static(1, 0, 0, 1245, 1300);
	Check(Reaches({1100, 0}, 0, target, GAUNTLET_RANGE, GAIN, MARGIN), "1100 elmos away on level ground reaches");
	Check(!Reaches({1200, 0}, 0, target, GAUNTLET_RANGE, GAIN, MARGIN), "1200 does not, inside the margin");
	Check(Reaches({1250, 0}, 200, target, GAUNTLET_RANGE, GAIN, MARGIN), "1250 does from 200 elmos above (1220 + 120 - 64)");
	Check(!Reaches({1250, 0}, 0, target, GAUNTLET_RANGE, GAIN, MARGIN), "1250 does not on level ground");
	Check(!Reaches({1000, 0}, -400, target, GAUNTLET_RANGE, GAIN, MARGIN), "1000 does not from 400 below (1220 - 240 - 64)");
}

static void SiteOutsideEveryKnownWeapon()
{
	const std::vector<Contact> e = {Static(1, 0, 0, 620, 440), Static(2, 0, 2000, 1390, 2500)};
	Check(!Covered({1100, 0}, 0, e, GAIN, MARGIN), "a site out of the HLT's and the Persecutor's reach is clear");
	Check(Covered({650, 0}, 0, e, GAIN, MARGIN), "a site 650 from an HLT is covered (620 + margin)");
	Check(Covered({0, 700}, 0, e, GAIN, MARGIN), "a site 1300 from a Persecutor is covered");
	Check(!Covered({1100, 0}, 0, {Static(3, 0, 0, 0, 100)}, GAIN, MARGIN), "an unarmed structure covers nothing");
}

static void CounterBatteryIsAnEvenDuel()
{
	const Contact gauntlet = Static(1, 0, 0, 1220, 1250, 0, true);
	const Contact agitator = Static(2, 0, 0, 1245, 1300, 0, true);
	const std::vector<Contact> g = {gauntlet}, a = {agitator};
	// Without the duel rule a gun of equal range always covers the site.
	Check(Covered({1100, 0}, 0, g, GAIN, MARGIN), "an equal gun covers every site that reaches it");
	Check(!Covered({1100, 0}, 0, g, GAIN, MARGIN, DuelIgnore(Case::Counter, 0, 1220, gauntlet, GAIN)),
		"a Gauntlet may duel a Gauntlet on level ground");
	Check(DuelIgnore(Case::Counter, 0, 1220, agitator, GAIN) < 0, "a Gauntlet does not duel an Agitator on level ground");
	Check(DuelIgnore(Case::Counter, 50, 1220, agitator, GAIN) == 2, "it does from 50 elmos above (1250 against 1215)");
	Check(DuelIgnore(Case::Siege, 0, 1220, gauntlet, GAIN) < 0, "the siege case never ignores a weapon");
	const std::vector<Contact> both = {gauntlet, Static(3, 700, 0, 620, 440)};
	Check(Covered({1100, 0}, 0, both, GAIN, MARGIN, 1), "another weapon still covers the site in a duel (an HLT 400 away)");
}

static void RangeAdjustsForHeight()
{
	Check(RangeAt(1220, GAIN, 100, 0) == 1280.f, "100 elmos above adds 60");
	Check(RangeAt(1220, GAIN, 0, 100) == 1160.f, "100 elmos below takes 60");
	Check(RangeAt(100, GAIN, 0, 1000) == 0.f, "never negative");
}

static void CapPerAi()
{
	Check(UnderCap(0, 2) && UnderCap(1, 2), "under two guns, another may go up");
	Check(!UnderCap(2, 2), "two guns are the cap");
	Check(!UnderCap(0, 0), "cap 0 builds none");
}

int main()
{
	CounterBatteryNeedsOurStructureNear();
	AmputatorTakesNoCounterBattery();
	SiegeOnlyWhatMobileArtilleryCannotReach();
	SiegeNeedsValue();
	UnseenTargetsAreIgnored();
	SiteMustReachTheTarget();
	SiteOutsideEveryKnownWeapon();
	CounterBatteryIsAnEvenDuel();
	RangeAdjustsForHeight();
	CapPerAi();
	if (failures == 0) std::printf("artillery_t1_gate_test: all passed\n");
	return failures == 0 ? 0 : 1;
}
