/*
 * Scheduler.h
 *
 *  Created on: Aug 28, 2014
 *      Author: rlcevg
 *
 * D-431: per-AI job timing and completion queue; the process-wide worker
 * pool lives in scheduler/WorkerPool.h. Every parallel job may carry a name
 * (telemetry) and a coalescing key (at most one queued per key per AI).
 */

#ifndef SRC_CIRCUIT_UTIL_SCHEDULER_H_
#define SRC_CIRCUIT_UTIL_SCHEDULER_H_

#include "scheduler/JobQueue.h"
#include "scheduler/SchedulerJob.h"
#include "util/MultiQueue.h"
#include "util/Defines.h"

#include <atomic>
#include <cstdint>
#include <list>
#include <map>
#include <memory>
#include <vector>

namespace circuit {

class CCircuitAI;

class CScheduler final {
public:
	CScheduler();
	~CScheduler();

	void Init(const std::shared_ptr<CScheduler>& thisPtr) { self = thisPtr; }
	void ProcessInit();
	void ProcessRelease();

private:
	void Release();

public:
	template<typename _Callable, typename... _Args>
	static std::shared_ptr<IMainJob> GameJob(_Callable&& __f, _Args&&... __args) {
		return _M_make_game_routine(std::bind(std::forward<_Callable>(__f), std::forward<_Args>(__args)...));
	}
	template<typename _Callable, typename... _Args>
	static std::shared_ptr<IMainJob> PathedJob(const std::shared_ptr<IPathQuery>& query, _Callable&& __f, _Args&&... __args) {
		return _M_make_pathed_routine(query, std::bind(std::forward<_Callable>(__f),
				std::placeholders::_1, std::forward<_Args>(__args)...));
	}
	template<typename _Callable, typename... _Args>
	static std::shared_ptr<IThreadJob> WorkJob(_Callable&& __f, _Args&&... __args) {
		return _M_make_work_routine(std::bind(std::forward<_Callable>(__f), std::forward<_Args>(__args)...));
	}
	template<typename _Callable, typename... _Args>
	static std::shared_ptr<IThreadJob> PathJob(const std::shared_ptr<IPathQuery>& query, _Callable&& __f, _Args&&... __args) {
		return _M_make_path_routine(query, std::bind(std::forward<_Callable>(__f),
				std::placeholders::_1, std::placeholders::_2, std::forward<_Callable>(__args)...));
	}

	/*
	 * Add job at specified frame, or execute immediately at next frame
	 */
	void RunJobAt(const std::shared_ptr<IMainJob>& job, int frame = 0) {
		onceJobs.push_back({job, frame});
	}

	/*
	 * Add job at frame relative to current frame
	 */
	void RunJobAfter(const std::shared_ptr<IMainJob>& job, int frame = 0) {
		onceJobs.push_back({job, lastFrame + frame});
	}

	/*
	 * Add job at specified interval
	 */
	void RunJobEvery(const std::shared_ptr<IMainJob>& job, int frameInterval = FRAMES_PER_SEC, int frameOffset = 0) {
		repeatJobs.push_back({job, frameInterval, lastFrame - frameInterval + frameOffset});
	}

	/*
	 * Process queued jobs at specified frame
	 */
	void ProcessJobs(int frame);

	/*
	 * Run concurrent job, finalize on success at main thread. `name` is a
	 * string literal for telemetry; a non-zero `key` keeps at most one queued
	 * job with that key for this AI (the second is dropped, returns false).
	 */
	bool RunParallelJob(const std::shared_ptr<IThreadJob>& job, const char* name = "job", std::uint64_t key = 0);
	// Infrequent strategic analysis yields queue priority to unit pathfinding.
	// This does not preempt a running job; callers must bound/coalesce requests.
	bool RunBackgroundJob(const std::shared_ptr<IThreadJob>& job, const char* name = "background", std::uint64_t key = 0);
	/*
	 * Same as RunParallelJob but served before every normal job, newest first
	 */
	bool RunPriorityJob(const std::shared_ptr<IThreadJob>& job, const char* name = "priority", std::uint64_t key = 0);

	/*
	 * Remove scheduled job from queue
	 */
	void RemoveJob(const std::shared_ptr<IMainJob>& job);

	/*
	 * Run job on init. Not affected by RemoveJob
	 */
	void RunOnInit(std::shared_ptr<IMainJob>&& job) {
		initJobs.push_back(job);
	}

	/*
	 * Run job on release
	 */
	void RunOnRelease(const std::shared_ptr<IMainJob>& job) {
		releaseJobs.push_back(job);
	}

	/*
	 * Remove job from on-release queue
	 */
	void RemoveReleaseJob(const std::shared_ptr<IMainJob>& job);

	static int GetMaxWorkThreads();

	// Worker side (CWorkerPool): a job of this AI finished on a worker.
	bool IsRunning() const { return isRunning.load(); }
	void WorkerCompleted(const char* name, double ms, const std::shared_ptr<IMainJob>& onComplete);
	// Once a minute with CIRCUIT_PERF_PHASES: per-job worker time, the finish
	// burst high-water mark and the pool's queue depth, as [PerfWorker] lines.
	void FlushWorkerStats(CCircuitAI* ai);
	// Completions applied per frame; 0 (default) applies all of them. A bound
	// delays reactions by a frame under bursts, so it is an explicit choice
	// (CIRCUIT_FINISH_BUDGET), never a default.
	void SetFinishBudget(int count) { finishBudget = count; }

private:
	std::weak_ptr<CScheduler> self;
	int lastFrame;
	bool isProcessing;  // regular IMainJob

	std::atomic<bool> isRunning;  // parallel

	struct BaseContainer {
		BaseContainer(const std::shared_ptr<IMainJob>& job) : job(job) {}
		std::shared_ptr<IMainJob> job;
		bool operator==(const BaseContainer& other) const {
			return job == other.job;
		}
	};
	struct OnceJob: public BaseContainer {
		OnceJob(const std::shared_ptr<IMainJob>& job, int frame)
			: BaseContainer(job), frame(frame) {}
		int frame;
	};
	std::list<OnceJob> onceJobs;

	struct RepeatJob: public BaseContainer {
		RepeatJob(const std::shared_ptr<IMainJob>& job, int frameInterval, int lastFrame)
			: BaseContainer(job), frameInterval(frameInterval), lastFrame(lastFrame) {}
		int frameInterval;
		int lastFrame;
	};
	std::list<RepeatJob> repeatJobs;

	std::vector<std::shared_ptr<IMainJob>> removeJobs;

	struct FinishJob: public BaseContainer {
		FinishJob(const std::shared_ptr<IMainJob>& job)
			: BaseContainer(job) {}
	};
	CMultiQueue<FinishJob> finishJobs;  // CWorkJob.onComplete
	int finishBudget = 0;
	std::size_t finishBurstMax = 0, finishCarried = 0;

	// Worker telemetry, written by workers under its own lock, read on flush.
	struct WorkerStat { std::uint64_t calls = 0; double total = 0, maximum = 0; };
	spring::mutex statsMutex;
	std::map<const char*, WorkerStat> workerStats;
	std::uint64_t coalesced = 0;

	std::vector<std::shared_ptr<IMainJob>> initJobs;
	std::vector<std::shared_ptr<IMainJob>> releaseJobs;
};

} // namespace circuit

#endif // SRC_CIRCUIT_UTIL_SCHEDULER_H_
