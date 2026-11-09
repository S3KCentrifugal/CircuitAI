#pragma once
#include <array>
#include <cstdint>
#include <unordered_set>
#include <vector>
namespace circuit {
// Reused presence-only set. Common engine IDs use direct bits; unusual/negative
// IDs retain exact semantics in overflow. Clear touches only written words.
// Does not reorder/deduplicate the source iteration. Test: performance_helpers.
class IdMembership {
public:
    void Clear() { for(auto i:touched) bits[i]=0;touched.clear();overflow.clear(); }
    void Add(int id) {
        if(id<0 || id>=65536) {overflow.insert(id);return;}
        const auto word=unsigned(id)/64;const auto mask=uint64_t{1}<<(id%64);
        if(!bits[word]) touched.push_back(word);
        bits[word]|=mask;
    }
    bool Contains(int id) const {
        if(id<0 || id>=65536) return overflow.find(id)!=overflow.end();
        return (bits[unsigned(id)/64]&(uint64_t{1}<<(id%64)))!=0;
    }
private:
    std::array<uint64_t,1024> bits{};
    std::vector<unsigned> touched;
    std::unordered_set<int> overflow;
};
}
