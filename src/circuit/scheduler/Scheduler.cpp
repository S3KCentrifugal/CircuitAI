/*
 * Scheduler.cpp
 *
 *  Created on: Aug 28, 2014
 *      Author: rlcevg
 */

#include "scheduler/Scheduler.h"
#include "scheduler/WorkerPool.h"
#include "util/Utils.h"
#include "util/Data.h"
#include "util/Performance.h"
#include "util/Profiler.h"
#include "CircuitAI.h"
#include "Log.h"

#include <algorithm>
#include <cstdlib>

namespace circuit {

CScheduler::CScheduler()
		: lastFrame(0)
		, isProcessing(false)
{
	isRunning = true;
	if (const char* budget = std::getenv("CIRCUIT_FINISH_BUDGET")) finishBudget = std::max(0, std::atoi(budget));
}

CScheduler::~CScheduler()
{
	Release();
}

void CScheduler::ProcessInit()
{
	for (auto& task : initTasks) {
		task->Run();
	}
//	initTasks.clear();
	if (auto owner = self.lock()) CWorkerPool::Instance().Acquire(owner);
}

void CScheduler::ProcessRelease()
{
	for (auto& task : releaseTasks) {
		task->Run();
	}

	Release();
}

void CScheduler::Release()
{
	if (!isRunning) {
		return;
	}
	isRunning = false;
	CWorkerPool::Instance().Release(this);
	finishTasks.Clear();
}

int CScheduler::GetMaxWorkThreads()
{
	return CWorkerPool::Instance().Threads();
}

void CScheduler::ProcessJobs(int frame)
{
	isProcessing = true;
	lastFrame = frame;

	// Process once tasks
	std::list<OnceTask>::iterator ionce = onceTasks.begin();
	while (ionce != onceTasks.end()) {
		if (ionce->frame <= frame) {
			ionce->task->Run();
			ionce = onceTasks.erase(ionce);  // alternatively, onceTasks.erase(iter++);
		} else {
			++ionce;
		}
	}

	// Process repeat tasks
	for (auto& container : repeatTasks) {
		if (frame - container.lastFrame >= container.frameInterval) {
			container.task->Run();
			container.lastFrame = frame;
		}
	}

	// Process onComplete from parallel tasks. Every completion lands this
	// frame unless a finish budget was set explicitly; the burst size is the
	// telemetry that says whether a budget would ever matter.
	std::size_t processed = 0;
	CMultiQueue<FinishTask>::ProcessFunction process = [&processed](FinishTask& item) {
		item.task->Run();
		++processed;
	};
	if (finishBudget <= 0) {
		finishTasks.PopAndProcessAll(process);
	} else {
		while (processed < std::size_t(finishBudget) && finishTasks.PopAndProcess(process)) {}
		finishCarried = std::max(finishCarried, finishTasks.Size());
	}
	finishBurstMax = std::max(finishBurstMax, processed);

	// Update task queues
	if (!removeTasks.empty()) {
		for (auto& task : removeTasks) {
			onceTasks.remove({task, 0});
			repeatTasks.remove({task, 0, 0});
		}
		removeTasks.clear();
	}

	isProcessing = false;
}

bool CScheduler::RunParallelJob(const std::shared_ptr<IThreadJob>& task, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {task, name}, jobs::Lane::NORMAL, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

bool CScheduler::RunBackgroundJob(const std::shared_ptr<IThreadJob>& task, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {task, name}, jobs::Lane::BACKGROUND, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

bool CScheduler::RunPriorityJob(const std::shared_ptr<IThreadJob>& task, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {task, name}, jobs::Lane::PRIORITY, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

void CScheduler::WorkerCompleted(const char* name, double ms, const std::shared_ptr<IMainJob>& onComplete)
{
	if (onComplete != nullptr) finishTasks.PushBack(onComplete);
	if (!performance::enabled) return;
	std::lock_guard<spring::mutex> lock(statsMutex);
	WorkerStat& stat = workerStats[name];
	++stat.calls;
	stat.total += ms;
	stat.maximum = std::max(stat.maximum, ms);
}

void CScheduler::FlushWorkerStats(CCircuitAI* ai)
{
	if (!performance::enabled) return;
	std::map<const char*, WorkerStat> stats;
	{
		std::lock_guard<spring::mutex> lock(statsMutex);
		stats.swap(workerStats);
	}
	for (const auto& [name, stat] : stats) {
		ai->LOG("[PerfWorker] team=%i frame=%i job=%s calls=%llu total_ms=%.3f max_ms=%.3f",
			ai->GetTeamId(), ai->GetLastFrame(), name, static_cast<unsigned long long>(stat.calls), stat.total, stat.maximum);
	}
	ai->LOG("[PerfWorker] team=%i frame=%i finish_burst_max=%u finish_carried_max=%u coalesced=%llu pool_threads=%i pool_queued_max=%u",
		ai->GetTeamId(), ai->GetLastFrame(), unsigned(finishBurstMax), unsigned(finishCarried),
		static_cast<unsigned long long>(coalesced), CWorkerPool::Instance().Threads(), unsigned(CWorkerPool::Instance().QueuedMax()));
	finishBurstMax = 0; finishCarried = 0; coalesced = 0;
}

void CScheduler::RemoveJob(const std::shared_ptr<IMainJob>& task)
{
	if (isProcessing) {
		removeTasks.push_back(task);
	} else {
		onceTasks.remove({task, 0});
		repeatTasks.remove({task, 0, 0});
	}
}

void CScheduler::RemoveReleaseJob(const std::shared_ptr<IMainJob>& task)
{
	utils::really_remove(releaseTasks, task);
}

} // namespace circuit
