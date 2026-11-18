#ifndef CIRCUIT_UNIT_OWNED_DEFINITION_INDEX_H
#define CIRCUIT_UNIT_OWNED_DEFINITION_INDEX_H

#include <cstdint>
#include <map>
#include <set>

namespace circuit {
// Derived membership only. Completion, health, position and task ownership are
// deliberately live reads. Buckets survive becoming empty so death/rebirth of
// the same definition cannot reuse a previous revision. Rebuilt through normal
// registration on load. Ordered IDs match CCircuitAI::teamUnits traversal.
class OwnedDefinitionIndex {
public:
    void Insert(int definition, int unit) {
        auto& bucket = buckets[definition];
        if (bucket.ids.insert(unit).second) ++bucket.revision;
    }
    void Erase(int definition, int unit) {
        auto found = buckets.find(definition);
        if (found != buckets.end() && found->second.ids.erase(unit)) ++found->second.revision;
    }
    const std::set<int>& Ids(int definition) const {
        static const std::set<int> empty;
        const auto found = buckets.find(definition);
        return found == buckets.end() ? empty : found->second.ids;
    }
    std::uint64_t Revision(int definition) const {
        const auto found = buckets.find(definition);
        return found == buckets.end() ? 0 : found->second.revision;
    }
private:
    struct Bucket { std::set<int> ids; std::uint64_t revision = 0; };
    // O(log D + log U_d) mutation, O(U + D) memory; no per-frame rebuild.
    std::map<int, Bucket> buckets;
};
}
#endif
