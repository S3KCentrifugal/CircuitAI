// D-431: the worker pool's queue policy (scheduler/JobQueue.h): fairness across
// owners, priority newest-first before normal oldest-first, background only
// while idle, coalescing keys, unregister drops an owner's jobs.
#include "scheduler/JobQueue.h"

#include <cassert>
#include <cstdio>
#include <string>
#include <vector>

using namespace circuit::jobs;
using Queue = CJobQueue<std::string, int>;

namespace {
std::vector<std::string> Drain(Queue& q) {
	std::vector<std::string> out;
	int owner; std::string job;
	while (q.Pop(owner, job)) out.push_back(std::to_string(owner) + ":" + job);
	return out;
}
}

int main() {
	{  // Unknown owner is refused; registered owners accept.
		Queue q;
		assert(!q.Push(1, "a", Lane::NORMAL));
		q.Register(1); q.Register(1);
		assert(q.Owners() == 1 && q.Push(1, "a", Lane::NORMAL) && q.Size() == 1);
		assert(Drain(q) == std::vector<std::string>{"1:a"});
		assert(q.Empty());
	}
	{  // Round robin: one owner's burst does not starve the other.
		Queue q; q.Register(1); q.Register(2);
		for (int i = 0; i < 4; ++i) q.Push(1, "p" + std::to_string(i), Lane::NORMAL);
		q.Push(2, "x", Lane::NORMAL);
		const auto order = Drain(q);
		assert(order[0] == "1:p0" && order[1] == "2:x" && order[2] == "1:p1" && order.size() == 5);
	}
	{  // Priority is newest first and precedes every normal job; normal is oldest first.
		Queue q; q.Register(1); q.Register(2);
		q.Push(1, "n1", Lane::NORMAL); q.Push(2, "n2", Lane::NORMAL);
		q.Push(1, "old", Lane::PRIORITY); q.Push(1, "new", Lane::PRIORITY);
		const auto order = Drain(q);
		assert((order == std::vector<std::string>{"1:new", "1:old", "1:n1", "2:n2"}) || (order == std::vector<std::string>{"1:new", "1:old", "2:n2", "1:n1"}));
	}
	{  // Background waits for every foreground job of every owner.
		Queue q; q.Register(1); q.Register(2);
		q.Push(1, "bg", Lane::BACKGROUND);
		q.Push(2, "n", Lane::NORMAL);
		q.Push(2, "p", Lane::PRIORITY);
		const auto order = Drain(q);
		assert((order == std::vector<std::string>{"2:p", "2:n", "1:bg"}));
	}
	{  // Coalescing: a second queued job with the same key is dropped; after a pop the key is free again.
		Queue q; q.Register(1);
		const auto k = Key("threat");
		assert(k != 0 && Key("threat") == k && Key("enemy") != k);
		assert(q.Push(1, "t1", Lane::PRIORITY, k));
		assert(!q.Push(1, "t2", Lane::PRIORITY, k));
		assert(q.Push(1, "e", Lane::PRIORITY, Key("enemy")));
		assert(q.Size() == 2);
		int owner; std::string job;
		assert(q.Pop(owner, job) && job == "e");   // newest priority first
		assert(q.Pop(owner, job) && job == "t1");
		assert(q.Push(1, "t3", Lane::PRIORITY, k) && q.Size() == 1);
		q.Register(2);
		assert(q.Push(2, "t-other", Lane::PRIORITY, k));  // keys are per owner
	}
	{  // Unregister drops the owner's jobs and keeps the cursor valid.
		Queue q; q.Register(1); q.Register(2); q.Register(3);
		q.Push(1, "a", Lane::NORMAL); q.Push(2, "b", Lane::NORMAL); q.Push(2, "b2", Lane::BACKGROUND); q.Push(3, "c", Lane::NORMAL);
		int owner; std::string job;
		assert(q.Pop(owner, job) && owner == 1);
		assert(q.Unregister(2) == 2 && q.Size() == 1 && q.Owners() == 2);
		assert(q.Unregister(9) == 0);
		assert(Drain(q) == std::vector<std::string>{"3:c"});
		q.Push(3, "d", Lane::NORMAL);
		q.Clear();
		assert(q.Empty() && q.Owners() == 0);
	}
	std::puts("job queue: fairness, lanes, coalescing and unregister PASS");
	return 0;
}
