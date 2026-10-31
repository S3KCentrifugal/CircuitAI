#pragma once
// D-388: per-unit controller state, keyed by engine unit id.
//
// Entries are kept in ascending id order: controllers visit their units in the
// same order the legacy std::map did, so tick order, shared-reserve
// accumulation and first-commander choices are unchanged by the port.
// Each state lives in its own heap block so a State& stays valid while other
// units attach or detach (controller code holds State& across callbacks).
// Costs: Find O(log n) binary search; Attach/Detach O(n) element moves; n is
// the controller's own population (commanders: one to a few per AI). A
// population controller would add an index map; see unit-controller-
// architecture.md section 4. Tests: tests/control_core_test.cpp.

#include <algorithm>
#include <memory>
#include <vector>

namespace circuit::control {

template <class T>
class CSlotStore {
public:
	struct Entry {
		int id;
		std::unique_ptr<T> value;
	};

	// Returns the existing state, or a fresh one.
	T& Attach(int id) {
		auto it = Lower(id);
		if (it != entries.end() && it->id == id) return *it->value;
		it = entries.insert(it, Entry{id, std::make_unique<T>()});
		return *it->value;
	}

	bool Detach(int id) {
		auto it = Lower(id);
		if (it == entries.end() || it->id != id) return false;
		entries.erase(it);
		return true;
	}

	T* Find(int id) {
		auto it = Lower(id);
		return (it != entries.end() && it->id == id) ? it->value.get() : nullptr;
	}
	const T* Find(int id) const {
		auto it = std::lower_bound(entries.begin(), entries.end(), id,
			[](const Entry& e, int key) { return e.id < key; });
		return (it != entries.end() && it->id == id) ? it->value.get() : nullptr;
	}
	bool Contains(int id) const { return Find(id) != nullptr; }
	std::size_t Size() const { return entries.size(); }
	bool Empty() const { return entries.empty(); }

	// Ascending id order. Do not Attach or Detach while iterating.
	typename std::vector<Entry>::iterator begin() { return entries.begin(); }
	typename std::vector<Entry>::iterator end() { return entries.end(); }
	typename std::vector<Entry>::const_iterator begin() const { return entries.begin(); }
	typename std::vector<Entry>::const_iterator end() const { return entries.end(); }

private:
	typename std::vector<Entry>::iterator Lower(int id) {
		return std::lower_bound(entries.begin(), entries.end(), id,
			[](const Entry& e, int key) { return e.id < key; });
	}
	std::vector<Entry> entries;
};

} // namespace circuit::control
