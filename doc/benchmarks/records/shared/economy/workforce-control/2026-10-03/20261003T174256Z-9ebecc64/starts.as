// Controlled start/role fixture; no economy gifts.
namespace MetalFixture {
StartSpot@[] spots = {
StartSpot(AIFloat3(1000, 0, 250), AiRole::TECH, false),
StartSpot(AIFloat3(1000, 0, 900), AiRole::AIR, false),
StartSpot(AIFloat3(12300, 0, 250), AiRole::TECH, false),
StartSpot(AIFloat3(12300, 0, 900), AiRole::AIR, false)
};
dictionary limits;
MapConfig config = MapConfig("SpeedMetal BAR V2", limits, spots, null);
}
