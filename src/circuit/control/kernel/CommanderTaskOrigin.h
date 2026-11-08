#pragma once
// D-490 / D-493: where a commander's task came from decides whether it is the
// commander's own construction (never swapped for another build task) or an
// assist (broken off when energy is low). Engine free; the commander
// controller records the origin when it makes or hands out the task.
// Tests: tests/commander_task_origin_test.cpp.

namespace circuit::commander {

enum class TaskOrigin : int {
	None = 0,  // not made by the controller (a default or script task)
	Ladder,    // the commander's own work ladder (FrontWork / record)
	Group,     // a group construction the commander started
	Solar,     // the emergency solar
	Assist,    // an assist: group assist, a joined job, an adopted project, the assist rungs
};

// construction: a build task with a definition, before repair in the build types.
// soleWorker: the commander is the task's only assignee (the fallback for None).
inline bool OwnConstruction(TaskOrigin origin, bool construction, bool soleWorker)
{
	if (!construction) return false;
	switch (origin) {
		case TaskOrigin::Ladder:
		case TaskOrigin::Group:
		case TaskOrigin::Solar:  return true;
		case TaskOrigin::Assist: return false;
		case TaskOrigin::None:   return soleWorker;
	}
	return false;
}

// repairOfFrame: a repair of an unfinished structure; guard: a guard task.
inline bool Assisting(TaskOrigin origin, bool construction, bool soleWorker, bool repairOfFrame, bool guard)
{
	if (OwnConstruction(origin, construction, soleWorker)) return false;
	return origin == TaskOrigin::Assist || repairOfFrame || guard || construction;
}

} // namespace circuit::commander
