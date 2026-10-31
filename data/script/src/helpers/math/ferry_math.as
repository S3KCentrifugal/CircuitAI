// Logistics decisions only; distances are horizontal squared elmos.
namespace FerryMath {
    bool Arrived(float distanceSq, float radius) {
        return radius > 0.0f && distanceSq >= 0.0f && distanceSq <= radius * radius;
    }
}
