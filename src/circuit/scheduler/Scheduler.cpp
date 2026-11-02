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
		, isRunning(true)
{
	if (const char* budget = std::getenv("CIRCUIT_FINISH_BUDGET")) finishBudget = std::max(0, std::atoi(budget));
}

CScheduler::~CScheduler()
{
	Release();
}

void CScheduler::ProcessInit()
{
	for (auto& job : initJobs) {
		job->Run();
	}
//	initJobs.clear();
	if (auto owner = self.lock()) CWorkerPool::Instance().Acquire(owner);
}

void CScheduler::ProcessRelease()
{
	for (auto& job : releaseJobs) {
		job->Run();
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
	finishJobs.Clear();
}

int CScheduler::GetMaxWorkThreads()
{
	return CWorkerPool::Instance().Threads();
}

void CScheduler::ProcessJobs(int frame)
{
	isProcessing = true;
	lastFrame = frame;

	// Process once jobs
	std::list<OnceJob>::iterator ionce = onceJobs.begin();
	while (ionce != onceJobs.end()) {
		if (ionce->frame <= frame) {
			ionce->job->Run();
			ionce = onceJobs.erase(ionce);  // alternatively, onceJobs.erase(iter++);
		} else {
			++ionce;
		}
	}

	// Process repeat jobs
	for (auto& container : repeatJobs) {
		if (frame - container.lastFrame >= container.frameInterval) {
			container.job->Run();
			container.lastFrame = frame;
		}
	}

	// Process onComplete from parallel jobs. Every completion lands this
	// frame unless a finish budget was set explicitly; the burst size is the
	// telemetry that says whether a budget would ever matter.
	std::size_t processed = 0;
	CMultiQueue<FinishJob>::ProcessFunction process = [&processed](FinishJob& item) {
		item.job->Run();
		++processed;
	};
	if (finishBudget <= 0) {
		finishJobs.PopAndProcessAll(process);
	} else {
		while (processed < std::size_t(finishBudget) && finishJobs.PopAndProcess(process)) {}
		finishCarried = std::max(finishCarried, finishJobs.Size());
	}
	finishBurstMax = std::max(finishBurstMax, processed);

	// Update job queues
	if (!removeJobs.empty()) {
		for (auto& job : removeJobs) {
			onceJobs.remove({job, 0});
			repeatJobs.remove({job, 0, 0});
		}
		removeJobs.clear();
	}

	isProcessing = false;
}

bool CScheduler::RunParallelJob(const std::shared_ptr<IThreadJob>& job, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {job, name}, jobs::Lane::NORMAL, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

bool CScheduler::RunBackgroundJob(const std::shared_ptr<IThreadJob>& job, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {job, name}, jobs::Lane::BACKGROUND, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

bool CScheduler::RunPriorityJob(const std::shared_ptr<IThreadJob>& job, const char* name, std::uint64_t key)
{
	const bool queued = CWorkerPool::Instance().Push(this, {job, name}, jobs::Lane::PRIORITY, key);
	if (!queued && key != 0) ++coalesced;
	return queued;
}

void CScheduler::WorkerCompleted(const char* name, double ms, const std::shared_ptr<IMainJob>& onComplete)
{
	if (onComplete != nullptr) finishJobs.PushBack(onComplete);
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

void CScheduler::RemoveJob(const std::shared_ptr<IMainJob>& job)
{
	if (isProcessing) {
		removeJobs.push_back(job);
	} else {
		onceJobs.remove({job, 0});
		repeatJobs.remove({job, 0, 0});
	}
}

void CScheduler::RemoveReleaseJob(const std::shared_ptr<IMainJob>& job)
{
	utils::really_remove(releaseJobs, job);
}

} // namespace circuit
