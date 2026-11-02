#pragma once
// D-431: the worker pool's queue policy, engine-free (tests/job_queue_test.cpp).
//
// One queue per owner (a scheduler, one per AI) with three lanes. A pop walks
// the owners round robin so one AI's burst of path queries cannot starve the
// others: first the PRIORITY lane of every owner (newest first, as the old
// single deque's push-front gave), then the NORMAL lane of every owner (oldest
// first), and BACKGROUND only while no owner holds foreground work (the old
// "yields queue priority to pathfinding" rule). An optional coalescing key
// keeps at most one queued job per key per owner: a second update enqueued
// while the first still waits is dropped, so a slow pool shortens the update
// rate instead of growing the queue. Running jobs are not tracked here.
//
// Costs: push O(1) (a key check is a hash lookup), pop O(owners) in the worst
// case, unregister O(jobs of that owner). No locking: the pool wraps it.
#include <cstddef>
#include <cstdint>
#include <deque>
#include <unordered_set>
#include <utility>
#include <vector>

namespace circuit::jobs {

enum class Lane : int { PRIORITY = 0, NORMAL = 1, BACKGROUND = 2 };
constexpr int LANES = 3;

// A stable id for a coalescing key, from a literal: FNV-1a, computed at compile time.
constexpr std::uint64_t Key(const char* text) {
	std::uint64_t hash = 1469598103934665603ull;
	for (; *text != '\0'; ++text) hash = (hash ^ static_cast<unsigned char>(*text)) * 1099511628211ull;
	return hash == 0 ? 1 : hash;
}

template <class Job, class Owner>
class CJobQueue {
public:
	void Register(const Owner& owner) {
		if (Find(owner) != nullptr) return;
		owners.push_back(OwnerQueue{owner, {}, {}});
	}
	// Drops every queued job of the owner. Returns how many were dropped.
	std::size_t Unregister(const Owner& owner) {
		for (std::size_t i = 0; i < owners.size(); ++i) {
			if (!(owners[i].owner == owner)) continue;
			std::size_t dropped = 0;
			for (auto& lane : owners[i].lanes) dropped += lane.size();
			count -= dropped;
			owners.erase(owners.begin() + static_cast<std::ptrdiff_t>(i));
			if (cursor > i) --cursor;
			return dropped;
		}
		return 0;
	}
	// False when the owner is unknown or a job with this key already waits.
	bool Push(const Owner& owner, Job job, Lane lane, std::uint64_t key = 0) {
		OwnerQueue* q = Find(owner);
		if (q == nullptr) return false;
		if (key != 0 && !q->keys.insert(key).second) return false;
		q->lanes[int(lane)].push_back(Entry{std::move(job), key});
		++count;
		return true;
	}
	// The next job in the policy's order; false when nothing waits.
	bool Pop(Owner& owner, Job& job) {
		if (owners.empty() || count == 0) return false;
		if (PopLane(Lane::PRIORITY, true, owner, job)) return true;
		if (PopLane(Lane::NORMAL, false, owner, job)) return true;
		return PopLane(Lane::BACKGROUND, false, owner, job);
	}
	std::size_t Size() const { return count; }
	bool Empty() const { return count == 0; }
	std::size_t Owners() const { return owners.size(); }
	void Clear() { owners.clear(); count = 0; cursor = 0; }

private:
	struct Entry { Job job; std::uint64_t key; };
	struct OwnerQueue {
		Owner owner;
		std::deque<Entry> lanes[LANES];
		std::unordered_set<std::uint64_t> keys;
	};
	OwnerQueue* Find(const Owner& owner) {
		for (auto& q : owners) if (q.owner == owner) return &q;
		return nullptr;
	}
	bool PopLane(Lane lane, bool newestFirst, Owner& owner, Job& job) {
		const std::size_t n = owners.size();
		for (std::size_t step = 0; step < n; ++step) {
			const std::size_t i = (cursor + step) % n;
			auto& q = owners[i].lanes[int(lane)];
			if (q.empty()) continue;
			Entry& entry = newestFirst ? q.back() : q.front();
			owner = owners[i].owner;
			job = std::move(entry.job);
			if (entry.key != 0) owners[i].keys.erase(entry.key);
			if (newestFirst) q.pop_back(); else q.pop_front();
			--count;
			cursor = (i + 1) % n;  // the next pop starts after the served owner
			return true;
		}
		return false;
	}

	std::vector<OwnerQueue> owners;
	std::size_t count = 0, cursor = 0;
};

} // namespace circuit::jobs
