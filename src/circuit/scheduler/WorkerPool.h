#pragma once
// D-431: the process-wide worker pool, extracted from CScheduler's static
// members. One pool serves every AI instance in the process: clamp(cores - 1,
// 2, 8) threads over one CJobQueue (scheduler/JobQueue.h) that keeps a lane
// per owner and serves owners round robin, so one AI's burst of path queries
// cannot starve another's threat update. A job returns its completion to the
// owning scheduler's finish queue, which that AI drains inside its own frame:
// no engine wrapper, unit, task or script is ever touched on a worker.
//
// Lifetime: the first scheduler to Acquire starts the threads, the last to
// Release stops and joins them. Releasing one owner parks every worker, drops
// that owner's queued jobs and resumes the rest, so a job's raw `this` cannot
// outlive its AI (a running job always finishes before the park completes).
// Telemetry: each completion's wall time is handed to the owner with the
// job's name (CIRCUIT_PERF_PHASES, [PerfWorker] lines).
#include "scheduler/JobQueue.h"
#include "scheduler/SchedulerJob.h"

#include "System/Threading/SpringThreading.h"

#include <atomic>
#include <cstddef>
#include <cstdint>
#include <memory>
#include <unordered_map>
#include <vector>

namespace circuit {

class CScheduler;

struct SWorkItem {
	std::shared_ptr<IThreadJob> job;
	const char* name = "job";  // a string literal; never freed
};

class CWorkerPool final {
public:
	static CWorkerPool& Instance();

	void Acquire(const std::shared_ptr<CScheduler>& owner);
	void Release(CScheduler* owner);
	// False when the owner is not registered or a queued job already carries `key`.
	bool Push(CScheduler* owner, SWorkItem item, jobs::Lane lane, std::uint64_t key);

	// Fixed from construction (see the constructor): safe to size per-thread
	// state from before the first Acquire.
	int Threads() const { return maxThreads; }
	std::size_t Queued();
	std::size_t QueuedMax();  // high-water mark since the last call (telemetry)

private:
	CWorkerPool();
	void StartThreads();
	void StopThreads();
	void WorkerThread(int num);

	using Queue = jobs::CJobQueue<SWorkItem, CScheduler*>;
	spring::mutex mutex;
	spring::condition_variable_any cond, pauseCV, proceedCV;
	Queue queue;
	std::unordered_map<CScheduler*, std::weak_ptr<CScheduler>> owners;
	std::vector<spring::thread> threads;
	std::atomic<bool> running{false};
	int maxThreads = 2;
	unsigned instances = 0;
	int pauseId = 0;
	std::size_t pauseCount = 0;
	std::size_t queuedMax = 0;
};

} // namespace circuit
