#include "PhongThanUpgradeTables.h"

static bool PhongThanApplyOneUpgradeDelta(KItemNormalAttrib* base,KItemNormalAttrib* require,
    KItemNormalAttrib* magic,int type,int delta,unsigned int& baseMask,unsigned int& requireMask)
{
    if(!delta)return true;
    KItemNormalAttrib* target=NULL;
    const bool requirement=(type>=magic_requirestr && type<=magic_requiremenpai) || type==magic_requiregdlevel;
    if(requirement)
    {
        for(int r=0;r<6;++r)if(require[r].nAttribType==type){target=&require[r];break;}
        if(!target)for(int e=0;e<6;++e)if(!require[e].nAttribType){target=&require[e];requireMask|=1u<<e;break;}
    }
    else
    {
        for(int b=0;b<MAX_ITEM_BASEATTRIB;++b)if(base[b].nAttribType==type){target=&base[b];break;}
        if(!target)for(int m=0;m<MAX_ITEM_NORMAL_MAGICATTRIB;++m)if(magic[m].nAttribType==type){target=&magic[m];break;}
        // Upgrade deltas are never written into inactive set-bonus slots.
        if(!target)for(int empty=0;empty<5;++empty)if(!base[empty].nAttribType){target=&base[empty];baseMask|=1u<<empty;break;}
    }
    if(!target || type<=0 || type>=magic_normal_end)return false;
    int old=target->nAttribType?target->nValue[0]:0;
    if((delta>0 && old>INT_MAX-delta) || (delta<0 && old<INT_MIN-delta))return false;
    if(!target->nAttribType)ZeroMemory(target,sizeof(*target));
    target->nAttribType=type;target->nValue[0]=old+delta;
    return true;
}

BOOL KItem::ApplyUpgradeState(int state)
{
    int level=0,rule=0;
    if(!PhongThanDecodeUpgradeState(state,level,rule) || GetGenre()!=item_equip)return FALSE;
    PhongThanUpgradeStat before[20],after[20];int beforeCount=0,afterCount=0;
    if(m_CommonAttrib.nUpgradeRule && m_CommonAttrib.nUpgradeLvl &&
       !PhongThanLoadUpgradeDeltas(m_CommonAttrib.nUpgradeRule,m_CommonAttrib.nUpgradeLvl,before,beforeCount))return FALSE;
    if(rule && level && !PhongThanLoadUpgradeDeltas(rule,level,after,afterCount))return FALSE;
    KItemNormalAttrib base[MAX_ITEM_BASEATTRIB],require[6],magic[MAX_ITEM_MAGICATTRIB];
    unsigned int baseMask=m_CommonAttrib.nUpgradeAddedBaseMask,requireMask=m_CommonAttrib.nUpgradeAddedRequireMask;
    memcpy(base,m_aryBaseAttrib,sizeof(base));memcpy(require,m_aryRequireAttrib,sizeof(require));memcpy(magic,m_aryMagicAttrib,sizeof(magic));
    for(int i=0;i<beforeCount;++i)
        if(before[i].delta==INT_MIN || !PhongThanApplyOneUpgradeDelta(base,require,magic,before[i].type,-before[i].delta,baseMask,requireMask))return FALSE;
    // Remove only slots created by this upgrade layer. Original zero-valued
    // properties and all set properties remain intact after restoration.
    for(int b=0;b<MAX_ITEM_BASEATTRIB;++b)if((baseMask&(1u<<b)) && !base[b].nValue[0]){ZeroMemory(&base[b],sizeof(base[b]));baseMask&=~(1u<<b);}
    for(int r=0;r<6;++r)if((requireMask&(1u<<r)) && !require[r].nValue[0]){ZeroMemory(&require[r],sizeof(require[r]));requireMask&=~(1u<<r);}
    for(int j=0;j<afterCount;++j)
        if(!PhongThanApplyOneUpgradeDelta(base,require,magic,after[j].type,after[j].delta,baseMask,requireMask))return FALSE;
    memcpy(m_aryBaseAttrib,base,sizeof(base));memcpy(m_aryRequireAttrib,require,sizeof(require));memcpy(m_aryMagicAttrib,magic,sizeof(magic));
    m_CommonAttrib.nUpgradeLvl=level;m_CommonAttrib.nUpgradeRule=rule;
    m_CommonAttrib.nUpgradeAddedBaseMask=baseMask;m_CommonAttrib.nUpgradeAddedRequireMask=requireMask;
    return TRUE;
}
