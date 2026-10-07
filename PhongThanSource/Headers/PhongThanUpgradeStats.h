#ifndef PHONGTHAN_UPGRADE_STATS_H
#define PHONGTHAN_UPGRADE_STATS_H
#include <limits.h>

struct PhongThanUpgradeStat { int type; int delta; };
// Table is a KTabFile-compatible view. Rule must come from an established
// upgrade operation; never substitute item row, EquipID, SetID or profession.
template<class Table>
bool PhongThanReadUpgradeStats(Table& table, int rule, int level,
    PhongThanUpgradeStat* output, int capacity, int& count)
{
    count=0;
    if(rule<=0 || level<0 || level>15 || !output || capacity<=0)return false;
    if(!level)return true;
    // Name/default-rule columns must never be treated as numeric step columns.
    if(table.GetWidth()<level+3)return false;
    bool found=false;
    for(int row=2;row<=table.GetHeight();++row){
        int id=0,type=0;
        if(!table.GetInteger(row,1,0,&id) || id!=rule)continue;
        found=true;
        if(!table.GetInteger(row,2,0,&type) || type<=0)return false;
        for(int prior=0;prior<count;++prior)if(output[prior].type==type)return false;
        if(count>=capacity)return false;
        int total=0;
        for(int step=0;step<level;++step){
            int value=0;
            if(!table.GetInteger(row,step+3,0,&value))return false;
            if((value>0 && total>INT_MAX-value) || (value<0 && total<INT_MIN-value))return false;
            total+=value;
        }
        output[count].type=type;output[count++].delta=total;
    }
    return found;
}
#endif
