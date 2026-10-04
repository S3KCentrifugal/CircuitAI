// Controlled start/role fixture; no economy gifts.
namespace MetalFixture {
StartSpot@[] spots = {
StartSpot(AIFloat3(1900, 0, 5400), AiRole::TECH, false),
StartSpot(AIFloat3(2037, 0, 10300), AiRole::AIR, false),
StartSpot(AIFloat3(15100, 0, 9200), AiRole::TECH, false),
StartSpot(AIFloat3(14440, 0, 5084), AiRole::AIR, false)
};
dictionary limits;
MapConfig config = MapConfig("Nine_Metal_Islands_V1", limits, spots, null);
}
