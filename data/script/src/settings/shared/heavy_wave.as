// Heavy T3 wave hold (owner, 2026-11-16). Policy: systems/production/heavy_wave.as.
// TECH and FRONT gantries. After the first FirstHeavies heavies (Titan armbanth,
// Juggernaut corkorg, Sol Invictus legeheatraymech) come out of our gantries, a
// RollChance roll; then one every RollIntervalSeconds. A hit builds WaveSize of
// the heavy back to back (no Titan/Thor/Vanguard, Juggernaut/Catapult or
// Sol/Astraeus rotation), holds them at the gantry and launches them as one
// attack wave. The late size: LateWaveSize once the game is LateMinutes<Role> old
// AND our 10 s minimum metal income (Economy::GetMinMetalIncomeLast10s, i.e. the
// income stayed at or above it for 10 s in a row) reaches LateIncome<Role>.
namespace Global {
namespace HeavyWave {
    bool Enabled = true;
    int FirstHeavies = 3;
    float RollChance = 0.5f;
    int RollIntervalSeconds = 300;
    int WaveSize = 3;
    int LateWaveSize = 5;
    int LateMinutesTech = 45;
    float LateIncomeTech = 600.0f;
    int LateMinutesFront = 40;
    float LateIncomeFront = 250.0f;
    // the hold's deadline from the hit: per wave unit (a wave launches with what it has then)
    int GatherSecondsPerUnit = 240;
    // the held units wait this far from the gantry towards the nearest enemy start (off its exit)
    float RallyOffset = 300.0f;
    // Owner 2026-11-24: the wave is a native battle squad (behaviour.json "squad_formations" t3_heavy):
    // held at the rally until the last unit is out or the deadline, then down the lane with the battle
    // group's orders, merges and break-up. False (or no template) keeps the native gather + ATTACK squad.
    bool BattleSquad = true;
}
}
