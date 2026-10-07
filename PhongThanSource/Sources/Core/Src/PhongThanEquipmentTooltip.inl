#include "../../../Headers/PhongThanEquipmentText.h"
#include "../../../Headers/PhongThanPowerExpression.h"
#include <map>
#include <string>

static const char* PhongThanUpgradeRuleLabel(int rule)
{
    static std::map<int,std::string> labels;
    std::map<int,std::string>::iterator known=labels.find(rule);
    if(known!=labels.end())return known->second.c_str();
    const char* professions[]={"jia_shi","shu_shi","yi_ren"};
    const char* parts[]={"wu_qi","kui_jia","tou_kui","xie_zi","yao_dai","pi_feng"};
    for(int p=0;p<3;++p)for(int part=0;part<6;++part)
    {
        char path[180];sprintf(path,"\\settings\\item\\001\\%s_%s_sheng_ji_shu_zhi_biao.txt",professions[p],parts[part]);
        KTabFile table;if(!table.Load(path) || table.GetWidth()<18)continue;
        for(int row=2;row<=table.GetHeight();++row)
        {
            int id=0;table.GetInteger(row,1,0,&id);if(id!=rule)continue;
            char label[128];table.GetString(row,18,"",label,sizeof(label));
            const char* clean=label;while(*clean=='#' || *clean=='$')++clean;
            labels[rule]=clean;return labels[rule].c_str();
        }
    }
    labels[rule]="";return labels[rule].c_str();
}

static void PhongThanUpgradeDescription(const KItem& item,char* out)
{
    out[0]=0;
    int level=item.m_CommonAttrib.nUpgradeLvl;
    if(item.GetGenre()!=item_equip || level<1 || level>12)return;
    const char* format=PT_TEXT_UNKNOWN_UPGRADE;
    bool specificWeaponLabel=false;
    PhongThanUpgradeStat deltas[20];int count=0;
    if(PhongThanLoadUpgradeDeltas(item.m_CommonAttrib.nUpgradeRule,level,deltas,count))
    {
        bool raisesLevel=false,physical=false,fire=false;
        for(int i=0;i<count;++i)
        {
            if((deltas[i].type==36 || deltas[i].type==219) && deltas[i].delta>0)raisesLevel=true;
            if((deltas[i].type==28 || deltas[i].type==29) && deltas[i].delta>0)physical=true;
            if(deltas[i].type==122 && deltas[i].delta>0)fire=true;
        }
        if(item.GetDetailType()==equip_meleeweapon || item.GetDetailType()==equip_rangeweapon)
        {
            specificWeaponLabel=fire || physical;
            format=fire && !physical?PT_TEXT_FIRE_UPGRADE:(physical?PT_TEXT_PHYS_UPGRADE:PT_TEXT_UNKNOWN_UPGRADE);
        }
        else format=raisesLevel?PT_TEXT_UPGRADE:PT_TEXT_REFINED;
    }
    char label[192];sprintf(label,format,level);
    // Read the VNG label for defense/life/lightning/cold/earth/etc. Do not
    // mislabel every non-physical weapon as fire or physical damage.
    if(item.m_CommonAttrib.nUpgradeRule>0 && !specificWeaponLabel)
    {
        const char* source=PhongThanUpgradeRuleLabel(item.m_CommonAttrib.nUpgradeRule);
        if(*source)sprintf(label,"%s %d l\xC7n",source,level);
    }
    sprintf(out,"<color=0,255,255>%s<color=255,255,255>\n",label);
}

static bool PhongThanKnownTooltipPower(const KItem& item,int& total)
{
    const KBASICPROP_EQUIPMENT* data=ItemGen.CatalogEquipment(item.GetDetailType(),item.GetRow());
    if(!data)return false;
    int base=item.GetBasePower(),upgrade=0;
    // A persisted positive evaluated score is usable. An unevaluated *a,b*
    // is not zero and must not be guessed as a sum, mean, or random interval.
    if(data->m_nBasePowerKind==PT_POWER_SCALAR)base=data->m_nBasePower;
    else if(base<=0)return false;
    if(!item.GetUpgradePower(upgrade))return false;
    return PhongThanSumKnownItemPower(base,item.GetMagicPower(),upgrade,total);
}
