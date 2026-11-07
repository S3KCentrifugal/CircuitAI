// D-474: the constructor brace rules (src/circuit/control/kernel/ConstructorBrace.h).
#include "control/kernel/ConstructorBrace.h"
#include <cassert>
#include <cmath>
#include <iostream>
using namespace circuit::brace;

static bool Near(float a, float b) { return std::fabs(a - b) < 0.01f; }

static void DirectionTests()
{
	// A known attacker sets the direction.
	Point d = ThreatDirection({0, 0}, true, {0, 500}, {0, -1000});
	assert(Near(d.x, 0) && Near(d.z, 1));
	// No attacker: the enemy is ahead of the base.
	d = ThreatDirection({1000, 0}, false, {}, {0, 0});
	assert(Near(d.x, 1) && Near(d.z, 0));
	// An attacker on top of the constructor gives no direction: fall back to the base.
	d = ThreatDirection({1000, 0}, true, {1000, 0}, {0, 0});
	assert(Near(d.x, 1));
	// Constructor on the base, no attacker: a fixed direction, never zero.
	d = ThreatDirection({0, 0}, false, {}, {0, 0});
	assert(Near(Length(d), 1));
}

static void PlanTests()
{
	const Point toward{0, 1};
	// Straight back 100 elmos.
	Point r = RetreatPoint({0, 0}, toward, 100, 0);
	assert(Near(r.x, 0) && Near(r.z, -100));
	// Side candidates keep the distance and never move toward the threat.
	for (int i = 0; i < RETREAT_CANDIDATES; ++i) {
		r = RetreatPoint({0, 0}, toward, 100, i);
		assert(Near(Length(r), 100));
		assert(r.z <= 0.01f);
	}
	// The site is ahead of the retreat point, toward the threat.
	r = RetreatPoint({0, 0}, toward, 100, 0);
	const Point s = SitePoint(r, toward, 80);
	assert(Near(s.z, -20) && s.z > r.z);
}

static void OffsetTests()
{
	// Wanted offset inside the limits stands.
	assert(Near(SiteOffset(80, 40, 200), 80));
	// Too close to the builder: pushed out to the clearance.
	assert(Near(SiteOffset(10, 40, 200), 40));
	// Beyond reach: pulled in to 0.9 of the build range.
	assert(Near(SiteOffset(300, 40, 200), 180));
	// Clearance beyond reach: the reach wins (no walking back in).
	assert(Near(SiteOffset(80, 300, 200), 180));
}

static void GateTests()
{
	Gate g;
	g.enabled = true; g.land = true; g.health = 0.9f; g.retreat = 0.5f; g.frame = 1000; g.cooldown = 150;
	assert(Starts(g));
	// The retreat threshold supersedes the brace.
	g.health = 0.5f; assert(!Starts(g));
	g.health = 0.3f; assert(!Starts(g));
	g.health = 0.9f;
	// Air or sea constructors never brace.
	g.land = false; assert(!Starts(g)); g.land = true;
	// Already retreating or already bracing.
	g.retreating = true; assert(!Starts(g)); g.retreating = false;
	g.bracing = true; assert(!Starts(g)); g.bracing = false;
	// Cooldown since the last brace.
	g.lastStart = 900; assert(!Starts(g));
	g.lastStart = 850; assert(Starts(g));
	// Disabled.
	g.enabled = false; assert(!Starts(g));
}

int main()
{
	DirectionTests();
	PlanTests();
	OffsetTests();
	GateTests();
	std::cout << "constructor_brace_test: OK" << std::endl;
	return 0;
}
