#include "circuit/task/static/EnemyReclaimPolicy.h"
#include <iostream>
#include <limits>

int main()
{
	using namespace circuit::enemy_reclaim;
	int failures = 0, checks = 0;
	auto check = [&](bool pass, const char* name) { ++checks; if (!pass) { ++failures; std::cerr << name << '\n'; } };
	check(EligibleTurret(false, true, true, true, false), "standard and extra static reclaimers qualify");
	check(!EligibleTurret(true, true, true, true, false), "mobile constructors retain their policy");
	check(!EligibleTurret(false, false, true, true, false), "non-assist factories excluded");
	check(!EligibleTurret(false, true, false, true, false), "cannot reclaim excluded");
	check(!EligibleTurret(false, true, true, false, false), "unfinished turret excluded");
	check(!EligibleTurret(false, true, true, true, true), "player control respected");
	check(EligibleTarget(true, true, true, true, false), "visible hostile reclaimable unit qualifies");
	check(!EligibleTarget(false, true, true, true, false), "fog contact excluded");
	check(!EligibleTarget(true, false, true, true, false), "captured allied or neutral unit excluded");
	check(!EligibleTarget(true, true, false, true, false), "unreclaimable excluded");
	check(!EligibleTarget(true, true, true, false, false), "dead target excluded");
	check(!EligibleTarget(true, true, true, true, true), "game exclusion respected");
	check(InRange(420.f * 420.f, 400.f, 20.f), "target radius included at engine boundary");
	check(!InRange(421.f * 421.f, 400.f, 20.f), "never chase beyond reach");
	check(InRange(510.f * 510.f, 500.f, 20.f), "extra turret uses actual larger reach");
	check(!InRange(510.f * 510.f, 400.f, 20.f), "ordinary turret cannot use extra reach");
	check(!InRange(-1.f, 400.f, 20.f), "invalid distance fails closed");
	check(!InRange(std::numeric_limits<float>::quiet_NaN(), 400.f, 20.f), "NaN fails closed");
	check(!InRange(1.f, std::numeric_limits<float>::infinity(), 20.f), "infinite range fails closed");
	check(!InRange(1.f, 400.f, -1.f), "invalid radius fails closed");
	std::cout << checks << " enemy reclaim policy checks; " << failures << " failures\n";
	return failures != 0;
}
