// Component cost only: ordered membership lookup, not engine callbacks/FPS.
#include "unit/OwnedDefinitionIndex.h"
#include <array>
#include <chrono>
#include <cstdint>
#include <iostream>
#include <map>

int main() {
    constexpr int teams = 16, population = 4000, definitions = 100, queries = 1000;
    std::array<std::map<int, int>, teams> units;
    std::array<circuit::OwnedDefinitionIndex, teams> indexes;
    for (int team = 0; team < teams; ++team) for (int id = 0; id < population; ++id) {
        units[team][id] = id % definitions;
        indexes[team].Insert(id % definitions, id);
    }
    std::uint64_t expected = 0;
    std::cout << "{\"teams\":16,\"population_per_team\":4000,\"queries_per_team\":1000,\"samples\":[";
    for (int round = 0; round < 4; ++round) {
        const bool indexed = round == 1 || round == 2;
        std::uint64_t checksum = 0;
        auto start = std::chrono::steady_clock::now();
        for (int q = 0; q < queries; ++q) for (int team = 0; team < teams; ++team) {
            if (indexed) {
                for (int id : indexes[team].Ids(q % definitions)) checksum += id;
            } else {
                for (auto [id, def] : units[team]) if (def == q % definitions) checksum += id;
            }
        }
        const double milliseconds = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - start).count();
        if (round == 0) expected = checksum;
        if (checksum != expected) return 1;
        if (round) std::cout << ',';
        std::cout << "{\"indexed\":" << (indexed ? "true" : "false") << ",\"ms\":" << milliseconds << ",\"checksum\":" << checksum << '}';
    }
    std::cout << "]}\n";
}
