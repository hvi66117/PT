#ifndef PHONGTHAN_UPGRADE_POWER_H
#define PHONGTHAN_UPGRADE_POWER_H
#include <limits.h>
// Each source cell is the contribution of that successful enhancement step.
// Do not use the cell at level N as the cumulative contribution.
inline bool PhongThanSumUpgradePower(const int* steps, int count, int level, int& total)
{
    total=0;
    if(level<0 || level>count || (!steps && level))return false;
    for(int n=0;n<level;++n){
        if(steps[n]<0 || total>INT_MAX-steps[n]){total=0;return false;}
        total+=steps[n];
    }
    return true;
}
#endif
