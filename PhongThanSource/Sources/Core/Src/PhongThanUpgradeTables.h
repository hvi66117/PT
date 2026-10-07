#ifndef PHONGTHAN_UPGRADE_TABLES_H
#define PHONGTHAN_UPGRADE_TABLES_H
#include "KTabFile.h"
#include "../../../Headers/PhongThanUpgradeStats.h"
#include <vector>

struct PhongThanUpgradeRuleEntry { int rule,type,step[15]; };
inline bool PhongThanLoadUpgradeDeltas(int rule,int level,PhongThanUpgradeStat* out,int& count)
{
    static bool loaded=false;
    static std::vector<PhongThanUpgradeRuleEntry> records;
    if(!loaded)
    {
        const char* professions[]={"jia_shi","shu_shi","yi_ren"};
        const char* parts[]={"wu_qi","kui_jia","tou_kui","xie_zi","yao_dai","pi_feng"};
        std::vector<PhongThanUpgradeRuleEntry> candidate;
        for(int p=0;p<3;++p)for(int part=0;part<6;++part)
        {
            char path[180];sprintf(path,"\\settings\\item\\001\\%s_%s_sheng_ji_shu_zhi_biao.txt",professions[p],parts[part]);
            KTabFile table;if(!table.Load(path) || table.GetWidth()<18)return false;
            for(int row=2;row<=table.GetHeight();++row)
            {
                PhongThanUpgradeRuleEntry entry;ZeroMemory(&entry,sizeof(entry));
                if(!table.GetInteger(row,1,0,&entry.rule) || entry.rule<=0)continue;
                if(!table.GetInteger(row,2,0,&entry.type) || entry.type<=0)return false;
                for(int step=0;step<15;++step)
                    if(!table.GetInteger(row,step+3,0,&entry.step[step]))return false;
                bool same=false;
                for(unsigned int k=0;k<candidate.size();++k)
                    if(candidate[k].rule==entry.rule && candidate[k].type==entry.type)
                    {
                        if(memcmp(candidate[k].step,entry.step,sizeof(entry.step)))return false;
                        same=true;break;
                    }
                if(!same)candidate.push_back(entry);
            }
        }
        records.swap(candidate);loaded=true;
    }
    count=0;
    if(rule<=0 || level<0 || level>15)return false;
    for(unsigned int i=0;i<records.size();++i)if(records[i].rule==rule)
    {
        if(count>=20)return false;
        int sum=0;
        for(int s=0;s<level;++s)
        {
            int delta=records[i].step[s];
            if((delta>0 && sum>INT_MAX-delta) || (delta<0 && sum<INT_MIN-delta))return false;
            sum+=delta;
        }
        out[count].type=records[i].type;out[count++].delta=sum;
    }
    return count>0;
}
#endif
