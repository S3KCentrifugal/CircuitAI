#ifndef CIRCUIT_UTIL_BOUNDED_VECTOR_CACHE_H
#define CIRCUIT_UTIL_BOUNDED_VECTOR_CACHE_H

#include <map>
#include <memory>
#include <vector>
#include <utility>

namespace circuit {
// Immutable leases survive invalidation/reentrant queries. Limits bound retained
// cache memory; active callers own their ordinary query result independently.
template<class T> class VectorLease {
public:
    VectorLease() : value(Empty()) {}
    VectorLease(std::vector<T>&& elements) : value(std::make_shared<const std::vector<T>>(std::move(elements))) {}
    explicit VectorLease(std::shared_ptr<const std::vector<T>> value) : value(std::move(value)) {}
    auto begin() const { return value->begin(); }
    auto end() const { return value->end(); }
    bool empty() const { return value->empty(); }
    std::size_t size() const { return value->size(); }
    const T& operator[](std::size_t i) const { return (*value)[i]; }
private:
    static std::shared_ptr<const std::vector<T>> Empty() {
        static const auto empty = std::make_shared<const std::vector<T>>();
        return empty;
    }
    std::shared_ptr<const std::vector<T>> value;
};

template<class Key, class T, std::size_t MaxEntries, std::size_t MaxElements>
class BoundedVectorCache {
public:
    using Value = std::shared_ptr<const std::vector<T>>;
    Value Find(const Key& key) const {
        auto found = entries.find(key);
        return found == entries.end() ? nullptr : found->second;
    }
    Value Insert(const Key& key, std::vector<T>&& elements) {
        auto value = std::make_shared<const std::vector<T>>(std::move(elements));
        if (value->capacity() > MaxElements) return value;
        // Bounded whole-cache eviction avoids an LRU allocation/mutation on
        // every hit. Oversized results are returned but never retained.
        if (entries.size() >= MaxEntries || count + value->capacity() > MaxElements) Clear();
        auto inserted = entries.emplace(key, value);
        if (inserted.second) count += value->capacity();
        return inserted.first->second;
    }
    void Clear() { entries.clear(); count = 0; }
    std::size_t Size() const { return entries.size(); }
private:
    std::map<Key, Value> entries;
    std::size_t count = 0;
};
}
#endif
