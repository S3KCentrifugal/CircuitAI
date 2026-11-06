#pragma once
#include <cmath>

namespace circuit::movement_destination {
// Query only the destination's cells. Layout reservations and building yards
// are not physical obstacles: the caller supplies its live-footprint predicate.
template<class Blocked>
bool Free(float x,float z,float half,int cellSize,int width,int height,Blocked blocked)
{
    if(!std::isfinite(x)||!std::isfinite(z)||!std::isfinite(half)||half<=0
        ||cellSize<=0||width<=0||height<=0||x-half<0||z-half<0
        ||x+half>float(width)*cellSize||z+half>float(height)*cellSize)return false;
    const int x1=int(std::floor((x-half)/cellSize)),z1=int(std::floor((z-half)/cellSize));
    const int x2=int(std::ceil((x+half)/cellSize)),z2=int(std::ceil((z+half)/cellSize));
    for(int row=z1;row<z2;++row)for(int col=x1;col<x2;++col)
        if(blocked(col,row))return false;
    return true;
}
}
