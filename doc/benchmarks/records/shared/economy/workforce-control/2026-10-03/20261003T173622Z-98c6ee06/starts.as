// Controlled start/role fixture; no economy gifts.
namespace MetalFixture {
StartSpot@[] spots = {
StartSpot(AIFloat3(2400, 0, 850), AiRole::TECH, false),
StartSpot(AIFloat3(4700, 0, 2500), AiRole::AIR, false),
StartSpot(AIFloat3(9650, 0, 11400), AiRole::TECH, false),
StartSpot(AIFloat3(7350, 0, 9750), AiRole::AIR, false)
};
dictionary limits;
MapConfig config = MapConfig("Full Metal Plate 1.7", limits, spots, null);
}
