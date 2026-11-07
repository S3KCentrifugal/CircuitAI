// D-493: own construction against assisting (src/circuit/control/kernel/CommanderTaskOrigin.h).
#include "control/kernel/CommanderTaskOrigin.h"
#include "resource/EnergyState.h"
#include <cstdio>
#include <string>
using namespace circuit::commander;
using circuit::economy::EnergyState;

static int failures = 0;
static void Check(bool ok, const std::string& what)
{
	if (!ok) { ++failures; std::printf("FAIL: %s\n", what.c_str()); }
}

static void OwnOriginsFinishTheirBuild()
{
	Check(OwnConstruction(TaskOrigin::Ladder, true, false), "a ladder build is own, even when a constructor joined it");
	Check(OwnConstruction(TaskOrigin::Group, true, false), "a group build the commander started is own");
	Check(OwnConstruction(TaskOrigin::Solar, true, true), "the emergency solar is own");
	Check(!OwnConstruction(TaskOrigin::Ladder, false, true), "a repair or reclaim is never own construction");
}

static void AssistIsNeverOwn()
{
	Check(!OwnConstruction(TaskOrigin::Assist, true, true), "an assist stays an assist, even alone on the task");
	Check(Assisting(TaskOrigin::Assist, true, true, false, false), "a joined job is assisting");
}

static void UnknownFallsBackToSoleWorker()
{
	Check(OwnConstruction(TaskOrigin::None, true, true), "an unrecorded build worked alone is own");
	Check(!OwnConstruction(TaskOrigin::None, true, false), "an unrecorded build someone else works is not");
	Check(Assisting(TaskOrigin::None, true, false, false, false), "and it is assisting");
}

static void RepairsAndGuardsAreAssists()
{
	Check(Assisting(TaskOrigin::None, false, true, true, false), "a repair of another's frame is assisting");
	Check(Assisting(TaskOrigin::None, false, true, false, true), "a guard is assisting");
	Check(!Assisting(TaskOrigin::None, false, true, false, false), "a plain non-construction task is not");
}

static void EnergyLowIsOneRule()
{
	EnergyState s; s.storage = 1000; s.current = 150;
	Check(circuit::economy::EnergyLow(s, .2f), "15 % is under a 20 % share");
	s.current = 250;
	Check(!circuit::economy::EnergyLow(s, .2f), "25 % is not");
	s.stalling = true;
	Check(circuit::economy::EnergyLow(s, .2f), "stalling is low whatever the bank");
	s.stalling = false; s.storage = 0;
	Check(!circuit::economy::EnergyLow(s, .2f), "no storage and no stall is not low");
	s.storage = 1000; s.current = 0;
	Check(!circuit::economy::EnergyLow(s, 0.f), "share 0: only a stall counts");
	Check(circuit::economy::BankShare(s) == 0.f, "empty bank share");
}

int main()
{
	OwnOriginsFinishTheirBuild();
	AssistIsNeverOwn();
	UnknownFallsBackToSoleWorker();
	RepairsAndGuardsAreAssists();
	EnergyLowIsOneRule();
	if (failures > 0) { std::printf("commander_task_origin_test: %d failure(s)\n", failures); return 1; }
	std::printf("commander_task_origin_test: OK\n");
	return 0;
}
