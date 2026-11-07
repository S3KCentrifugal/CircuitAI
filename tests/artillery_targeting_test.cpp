// D-493: the artillery fire-control rules (src/circuit/control/kernel/ArtilleryTargeting.h),
// one test per owner rule.
#include "control/kernel/ArtilleryTargeting.h"
#include <cstdio>
#include <string>
#include <vector>
using namespace circuit::artillery;

static int failures = 0;
static void Check(bool ok, const std::string& what)
{
	if (!ok) { ++failures; std::printf("FAIL: %s\n", what.c_str()); }
}

static DefFacts Nano() { DefFacts d; d.assist = true; return d; }
static DefFacts Rez() { DefFacts d; d.mobile = true; d.resurrect = true; d.costM = 120; return d; }
static DefFacts Tank(float cost, bool heavy = false) { DefFacts d; d.mobile = true; d.costM = cost; d.heavyRole = heavy; d.range = 400; return d; }
static DefFacts Turret(float range) { DefFacts d; d.range = range; d.costM = 300; return d; }
static DefFacts Factory() { DefFacts d; d.assist = true; d.buildOptions = true; return d; }

static void SupportBeforeEverything()
{
	Check(Classify(Nano(), 600) == Kind::Support, "a construction turret is support");
	Check(Classify(Rez(), 600) == Kind::Support, "a resurrection bot is support");
	Check(Classify(Factory(), 600) != Kind::Support, "a factory is not a construction turret");
	Check(Classify(Turret(1245), 600) == Kind::Static, "an armed structure is static");
	Check(Classify(DefFacts{}, 600) == Kind::None, "an unarmed structure is none");
	const std::vector<Contact> c = {{1, Kind::Static, 1600, 100}, {2, Kind::Heavy, 400, 50}, {3, Kind::Support, 0, 900}};
	Check(Choose(-1, c) == 2, "support is chosen over heavy and static");
}

static void HeavyOnlyWithinHalfRange()
{
	const float gun = 1380.f;
	Check(InReach({1, Kind::Heavy, 400, 600.f * 600.f}, gun, .5f), "a heavy at 600 is within half of 1380");
	Check(!InReach({1, Kind::Heavy, 400, 800.f * 800.f}, gun, .5f), "a heavy at 800 is not");
	Check(InReach({1, Kind::Static, 400, 1300.f * 1300.f}, gun, .5f), "a static at 1300 is in reach");
}

static void SpamNeverChosen()
{
	Check(Classify(Tank(50), 600) == Kind::None, "a cheap mobile unit is spam: never a target");
	Check(Classify(Tank(50, true), 600) == Kind::Heavy, "the heavy role makes it heavy");
	Check(Classify(Tank(900), 600) == Kind::Heavy, "cost at or over heavy_cost makes it heavy");
	Check(Classify(Tank(900), 0) == Kind::None, "heavy_cost 0: only the heavy role counts");
	Check(!InReach({1, Kind::None, 0, 0}, 1380, .5f), "a none contact is never in reach");
}

static void LongestRangeStaticFirst()
{
	const std::vector<Contact> c = {{1, Kind::Static, 430, 100}, {2, Kind::Static, 1245, 1000000}, {3, Kind::Static, 800, 10}};
	Check(Choose(-1, c) == 1, "the longest-range static first, however far");
	const std::vector<Contact> tie = {{1, Kind::Static, 800, 900}, {2, Kind::Static, 800, 100}};
	Check(Choose(-1, tie) == 1, "equal range: the nearer");
}

static void StaticKeptUntilDead()
{
	const std::vector<Contact> c = {{7, Kind::Static, 430, 100}, {8, Kind::Static, 1245, 100}};
	Check(Choose(7, c) == 0, "a static aim is kept while it lives, even with a longer-range static in reach");
	const std::vector<Contact> gone = {{8, Kind::Static, 1245, 100}};
	Check(Choose(7, gone) == 0, "once it is gone the next static is taken");
}

static void HigherKindPreempts()
{
	const std::vector<Contact> c = {{7, Kind::Static, 1245, 100}, {9, Kind::Support, 0, 100}};
	Check(Choose(7, c) == 1, "support preempts a static aim");
	const std::vector<Contact> h = {{9, Kind::Support, 0, 100}, {4, Kind::Heavy, 400, 100}};
	Check(Choose(9, h) == 0, "a heavy does not preempt support");
	Check(AimChangeAllowed(true, Kind::Static, Kind::Support), "INV-265: static to support is lawful");
	Check(!AimChangeAllowed(true, Kind::Static, Kind::Static), "INV-265: static to another static while the first is in reach is not");
	Check(AimChangeAllowed(false, Kind::Static, Kind::Static), "INV-265: after the first is gone it is");
}

static void NoneReleasesToEngine()
{
	Check(Choose(7, {}) == -1, "nothing in reach: release to engine targeting");
}

static void CrowdingHoldsTheBlock()
{
	Check(!Crowded(1, 0, 2), "one gun: build");
	Check(Crowded(2, 0, 2), "two guns, no statics: hold");
	Check(Crowded(2, 2, 2), "two guns, two statics: hold");
	Check(!Crowded(2, 3, 2), "more statics than guns: more are called for");
	Check(!Crowded(9, 0, 0), "max 0 turns the rule off");
}

static void PopupClosesUnderFire()
{
	Check(CloseUnderFire(Kind::Static, false), "a structure aim is dropped under fire it cannot answer");
	Check(CloseUnderFire(Kind::None, false), "an idle gun stays closed");
	Check(!CloseUnderFire(Kind::Static, true), "an attacker in reach is answered");
	Check(!CloseUnderFire(Kind::Support, false), "a support aim keeps the gun open");
	Check(!CloseUnderFire(Kind::Heavy, false), "a heavy aim keeps the gun open");
}

int main()
{
	SupportBeforeEverything();
	HeavyOnlyWithinHalfRange();
	SpamNeverChosen();
	LongestRangeStaticFirst();
	StaticKeptUntilDead();
	HigherKindPreempts();
	NoneReleasesToEngine();
	CrowdingHoldsTheBlock();
	PopupClosesUnderFire();
	if (failures > 0) { std::printf("artillery_targeting_test: %d failure(s)\n", failures); return 1; }
	std::printf("artillery_targeting_test: OK\n");
	return 0;
}
