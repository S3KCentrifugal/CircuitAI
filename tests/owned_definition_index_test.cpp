#include "unit/OwnedDefinitionIndex.h"
#include "util/BoundedVectorCache.h"
#include <cassert>
#include <map>
#include <random>
#include <vector>

int main() {
    circuit::OwnedDefinitionIndex index;
    std::map<int, int> units;
    std::mt19937 random(91);
    // Creation, gifts, destruction, duplicate events and reused IDs. Compare
    // complete order to the old global map filter after every mutation.
    for (int step = 0; step < 10000; ++step) {
        int id = random() % 300, def = random() % 12;
        auto old = units.find(id);
        if (old != units.end()) {
            index.Erase(old->second, id);
            units.erase(old);
        }
        if (random() % 3) {
            units[id] = def;
            index.Insert(def, id);
            auto revision = index.Revision(def);
            index.Insert(def, id);
            assert(index.Revision(def) == revision);
        }
        for (int d = 0; d < 12; ++d) {
            std::set<int> oracle;
            for (auto [u, definition] : units) if (d == definition) oracle.insert(u);
            assert(index.Ids(d) == oracle);
        }
    }
    assert(index.Ids(-1).empty() && index.Revision(-1) == 0);
    circuit::BoundedVectorCache<int, int, 2, 8> cache;
    auto first = cache.Insert(1, {4, 3, 2});
    circuit::VectorLease<int> lease(first);
    assert(cache.Find(1) == first && lease[0] == 4);
    cache.Insert(2, {1});
    cache.Insert(3, {7}); // capacity eviction; existing readers stay valid
    assert(!cache.Find(1) && lease[2] == 2);
    cache.Clear();
    assert(cache.Size() == 0 && lease.size() == 3);
    auto large = cache.Insert(4, std::vector<int>(9, 5));
    assert(large->size() == 9 && !cache.Find(4));
    cache.Insert(5, {});
    assert(cache.Find(5) && cache.Find(5)->empty());
}
