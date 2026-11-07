namespace RushBootstrapMath {
    bool Needed(int completed,int queued,int unfinished,int required) {
        return required>0 && completed<required && queued==0 && unfinished==0;
    }
    bool Prefer(float distanceSquared,bool idle,float otherDistanceSquared,bool otherIdle,float localRadius) {
        // Locality first, then idle over discretionary assistance, then travel.
        const bool local=distanceSquared<=localRadius*localRadius;
        const bool otherLocal=otherDistanceSquared<=localRadius*localRadius;
        if(local!=otherLocal) return local;
        if(idle!=otherIdle) return idle;
        return distanceSquared<otherDistanceSquared;
    }
    bool Stalled(int frame,int progressFrame,int timeout) {
        return timeout>0 && frame-progressFrame>=timeout;
    }
}
