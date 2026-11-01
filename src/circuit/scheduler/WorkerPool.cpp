#include "scheduler/WorkerPool.h"
#include "scheduler/Scheduler.h"
#include "util/Utils.h"
#include "util/Profiler.h"

#include "angelscript/include/angelscript.h"

#include <algorithm>
#include <chrono>

namespace circuit {

namespace {
constexpr int MAX_JOB_THREADS = 8;
}

CWorkerPool& CWorkerPool::Instance()
{
	static CWorkerPool pool;
	return pool;
}

void CWorkerPool::Acquire(const std::shared_ptr<CScheduler>& owner)
{
	std::unique_lock<spring::mutex> lock(mutex);
	if (instances == 0) {
		const int cores = int(spring::thread::hardware_concurrency());
		maxThreads = utils::clamp(cores - 1, 2, MAX_JOB_THREADS);
	}
	++instances;
	owners[owner.get()] = owner;
	queue.Register(owner.get());
	if (!running.load()) StartThreads();
}

void CWorkerPool::Release(CScheduler* owner)
{
	std::unique_lock<spring::mutex> lock(mutex);
	if (owners.find(owner) == owners.end()) return;
	if (instances <= 1) {
		queue.Unregister(owner);
		owners.erase(owner);
		instances = 0;
		StopThreads();  // releases the lock while joining
		return;
	}
	// Park every worker, drop this owner's queued jobs, resume. A job that is
	// running finishes before its worker parks, so none of this owner's jobs
	// runs once this returns.
	++pauseId;
	pauseCount = threads.size();
	cond.notify_all();
	pauseCV.wait(lock, [this] { return pauseCount == 0; });
	queue.Unregister(owner);
	owners.erase(owner);
	--instances;
	++pauseId;
	proceedCV.notify_all();
}

bool CWorkerPool::Push(CScheduler* owner, SWorkItem item, jobs::Lane lane, std::uint64_t key)
{
	std::unique_lock<spring::mutex> lock(mutex);
	const bool queued = queue.Push(owner, std::move(item), lane, key);
	if (queued) {
		queuedMax = std::max(queuedMax, queue.Size());
		lock.unlock();
		cond.notify_one();
	}
	return queued;
}

std::size_t CWorkerPool::Queued()
{
	std::lock_guard<spring::mutex> lock(mutex);
	return queue.Size();
}

std::size_t CWorkerPool::QueuedMax()
{
	std::lock_guard<spring::mutex> lock(mutex);
	const std::size_t value = queuedMax;
	queuedMax = queue.Size();
	return value;
}

void CWorkerPool::StartThreads()
{
	// Called with the mutex held.
	running = true;
	threads.reserve(maxThreads);
	for (int i = 0; i < maxThreads; ++i) threads.emplace_back(&CWorkerPool::WorkerThread, this, i);
}

void CWorkerPool::StopThreads()
{
	// Called with the mutex held by Release; workers need it to leave their wait.
	running = false;
	cond.notify_all();
	proceedCV.notify_all();
	std::vector<spring::thread> joining;
	joining.swap(threads);
	mutex.unlock();
	for (spring::thread& t : joining) if (t.joinable()) t.join();
	mutex.lock();
	queue.Clear();
	owners.clear();
	pauseCount = 0;
}

void CWorkerPool::WorkerThread(int num)
{
#ifdef CIRCUIT_PROFILING
	tracy::SetThreadName(utils::int_to_string(num, "AI job %i").c_str());  // 15 chars max
#endif
	std::unique_lock<spring::mutex> lock(mutex);
	int seenPause = pauseId;
	while (running.load()) {
		cond.wait(lock, [&] { return !running.load() || seenPause != pauseId || !queue.Empty(); });
		if (!running.load()) break;
		if (seenPause != pauseId) {  // parking for an owner's release
			const int pid = pauseId;
			seenPause = pid + 1;
			if (--pauseCount == 0) pauseCV.notify_all();
			proceedCV.wait(lock, [&] { return pid != pauseId || !running.load(); });
			continue;
		}
		CScheduler* owner = nullptr;
		SWorkItem item;
		if (!queue.Pop(owner, item)) continue;
		TracyPlot("AI Jobs", (int64_t)queue.Size());
		const auto found = owners.find(owner);
		std::shared_ptr<CScheduler> scheduler = found == owners.end() ? nullptr : found->second.lock();
		lock.unlock();
		if (scheduler != nullptr && scheduler->IsRunning()) {
			const auto start = std::chrono::steady_clock::now();
			std::shared_ptr<IMainJob> onComplete = item.job->Run(num);
			const double ms = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - start).count();
			scheduler->WorkerCompleted(item.name, ms, onComplete);
		}
		item.job.reset();
		scheduler.reset();
		lock.lock();
	}
	lock.unlock();
	asThreadCleanup();
}

} // namespace circuit
