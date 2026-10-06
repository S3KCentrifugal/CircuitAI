// Pure recovery admission rules: no engine callbacks, scans or unit orders.
namespace RecoveryMath {
    bool NeedsRequest(int constructors, bool hadConstructor, bool commanderAlive,
                      bool commanderCounts, int frame, int openingGrace) {
        if (constructors > 0 || (commanderCounts && commanderAlive)) return false;
        return hadConstructor || (!commanderAlive && frame >= openingGrace);
    }
    bool Due(int now, int previous, int interval) {
        return previous < 0 || now - previous >= interval;
    }
    bool AcceptEpisode(int token, int lastCancelled) {
        return token >= 0 && token > lastCancelled;
    }
}
