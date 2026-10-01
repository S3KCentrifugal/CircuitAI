// Pure placement geometry, shared by policy and the standalone AS tests.
namespace PlacementMath {
    bool FootprintIntersectsCircle(float x, float z, float halfX, float halfZ,
        float centreX, float centreZ, float radius)
    {
        if (halfX < 0.0f || halfZ < 0.0f || radius < 0.0f) return true;
        float dx = x - centreX;
        float dz = z - centreZ;
        if (dx < 0.0f) dx = -dx;
        if (dz < 0.0f) dz = -dz;
        dx = dx > halfX ? dx - halfX : 0.0f;
        dz = dz > halfZ ? dz - halfZ : 0.0f;
        return dx * dx + dz * dz <= radius * radius;
    }
}
