#ifndef CIRCUIT_RESOURCE_METALFIELD_H
#define CIRCUIT_RESOURCE_METALFIELD_H

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <map>
#include <unordered_map>
#include <vector>

namespace circuit::metal_field {

// Engine-independent facts and claim arithmetic. Positions are engine-snapped
// world coordinates; results are additional M/s, never legacy SMetal scores.
class Grid {
public:
    bool Init(int width, int height, float scale, const std::vector<short>& bytes) {
        if (width <= 0 || height <= 0 || !std::isfinite(scale) || scale <= 0
            || bytes.size() != std::size_t(width) * std::size_t(height)) return false;
        columns = width; rows = height; metalScale = scale; raw = bytes;
        return true;
    }
    bool Ready() const { return !raw.empty(); }
    float Amount(int cell) const { return float(raw[cell]) * metalScale; }
    int Columns() const { return columns; }
    int Rows() const { return rows; }
    bool BroadField(float radius) const {
        if (!Ready() || radius <= 0) return false;
        std::vector<bool> seen(raw.size(), false);
        std::vector<int> queue;
        // BAR joins touching positive strips, then rejects a component whose
        // bounding box exceeds six extraction radii. Ignore the border samples.
        for (int z = 1; z < rows - 1; ++z) for (int x = 1; x < columns - 1; ++x) {
            const int start = z * columns + x;
            if (seen[start] || raw[start] <= 0) continue;
            queue.clear(); queue.push_back(start); seen[start] = true;
            int minX = x, maxX = x, minZ = z, maxZ = z;
            for (std::size_t at = 0; at < queue.size(); ++at) {
                const int cx = queue[at] % columns, cz = queue[at] / columns;
                minX = std::min(minX, cx); maxX = std::max(maxX, cx);
                minZ = std::min(minZ, cz); maxZ = std::max(maxZ, cz);
                if ((maxX - minX) * 16 > radius * 6 || (maxZ - minZ) * 16 > radius * 6) return true;
                for (int dz = -1; dz <= 1; ++dz) for (int dx = -1; dx <= 1; ++dx) {
                    const int nx = cx + dx, nz = cz + dz;
                    if (nx < 1 || nz < 1 || nx >= columns - 1 || nz >= rows - 1) continue;
                    const int cell = nz * columns + nx;
                    if (!seen[cell] && raw[cell] > 0) { seen[cell] = true; queue.push_back(cell); }
                }
            }
        }
        return false;
    }
    // Charge every tested cell, including cells outside the disk. An incomplete
    // query is never interpreted as exhausted ground or a zero-yield site.
    bool Cells(float x, float z, float radius, int& budget, std::vector<int>& cells) const {
        cells.clear();
        if (!Ready() || !std::isfinite(x) || !std::isfinite(z) || !std::isfinite(radius)
            || radius <= 0 || x < 0 || z < 0 || x >= columns * 16 || z >= rows * 16) return false;
        const int x0 = int(std::floor(std::max(0.f, (x - radius) / 16)));
        const int x1 = int(std::floor(std::min(float(columns - 1), (x + radius) / 16)));
        const int z0 = int(std::floor(std::max(0.f, (z - radius) / 16)));
        const int z1 = int(std::floor(std::min(float(rows - 1), (z + radius) / 16)));
        for (int cz = z0; cz <= z1; ++cz) for (int cx = x0; cx <= x1; ++cx) {
            if (budget-- <= 0) { cells.clear(); return false; }
            const float dx = (cx + .5f) * 16 - x, dz = (cz + .5f) * 16 - z;
            if (dx * dx + dz * dz < radius * radius) cells.push_back(cz * columns + cx);
        }
        return true;
    }
    float Isolated(const std::vector<int>& cells, float depth) const {
        float sum = 0;
        for (int cell : cells) sum += Amount(cell) * depth;
        return sum;
    }
private:
    int columns = 0, rows = 0;
    float metalScale = 0;
    std::vector<short> raw;
};

using Key = std::uint64_t;
constexpr Key UnitBit = Key{1} << 63;
constexpr int SiteTagV1 = -2; // saved legacy spot index remains unchanged
inline Key UnitKey(int id) { return UnitBit | static_cast<std::uint32_t>(id); }

class Claims {
public:
    struct Record {
        int owner = -1, targetId = -1;
        float x = 0, z = 0, radius = 0, depth = 0;
        std::vector<int> cells;
    };
    Key Allocate(int owner) {
        return (Key(static_cast<std::uint32_t>(owner)) << 32) | ++serials[owner];
    }
    bool Upsert(Key key, const Record& r, const Grid& grid, int& budget) {
        if (!key || !std::isfinite(r.depth) || r.depth <= 0) return false;
        auto old = records.find(key);
        if (old != records.end() && old->second.owner == r.owner
            && old->second.targetId == r.targetId && old->second.x == r.x
            && old->second.z == r.z && old->second.radius == r.radius
            && old->second.depth == r.depth) return true;
        Record next = r;
        if (!grid.Cells(r.x, r.z, r.radius, budget, next.cells)) return false;
        if (r.targetId >= 0 && !TargetAvailable(r.targetId, key)) return false;
        Erase(key);
        for (int cell : next.cells) layers[cell][key] = next.depth;
        records.emplace(key, std::move(next));
        if (r.targetId >= 0) upgrades[r.targetId] = key;
        if (!(key & UnitBit)) serials[r.owner] = std::max(serials[r.owner], std::uint32_t(key));
        ++revision;
        return true;
    }
    void Erase(Key key) {
        const auto it = records.find(key);
        if (it == records.end()) return;
        for (int cell : it->second.cells) {
            auto layer = layers.find(cell);
            if (layer == layers.end()) continue;
            layer->second.erase(key);
            if (layer->second.empty()) layers.erase(layer);
        }
        if (it->second.targetId >= 0) upgrades.erase(it->second.targetId);
        records.erase(it);
        ++revision;
    }
    bool TargetAvailable(int id, Key self = 0) const {
        const auto it = upgrades.find(id);
        return it == upgrades.end() || it->second == self;
    }
    float Marginal(const Grid& grid, const std::vector<int>& cells, float depth, Key self = 0) const {
        float sum = 0;
        for (int cell : cells) {
            float prior = 0;
            const auto layer = layers.find(cell);
            if (layer != layers.end()) for (const auto& entry : layer->second)
                if (entry.first != self) prior = std::max(prior, entry.second);
            sum += grid.Amount(cell) * std::max(0.f, depth - prior);
        }
        return sum;
    }
    bool Owns(Key key, int owner) const {
        const auto it = records.find(key);
        return it != records.end() && it->second.owner == owner;
    }
    const std::map<Key, Record>& Records() const { return records; }
    std::uint64_t Revision() const { return revision; }
    int observedFrame = -1;
private:
    std::map<Key, Record> records;
    std::unordered_map<int, std::map<Key, float>> layers;
    std::unordered_map<int, Key> upgrades;
    std::map<int, std::uint32_t> serials;
    std::uint64_t revision = 0;
};
}
#endif
