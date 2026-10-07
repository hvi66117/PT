#include "PhongThanComposeRecipe.h"
#include "PhongThanXichTungTu.h"
#ifndef PHONGTHAN_MATERIAL_ONLY_TEST
#include "PhongThanEquipmentCompose.inl"
#endif

// Same item objects are restored to the same build slots on any failure.
// Never charge money or destroy inputs until every output has been placed.
static int PhongThanCommitMaterialCompose(int player,const int* inputs,
    const PhongThanComposeRecipe& recipe,int money)
{
    int outputs[64],created=0;
    bool detached[9];ZeroMemory(detached,sizeof(detached));
    int result=PT_COMPOSE_TABLE_ERROR;
    bool valid=true;
    for(int i=0;i<recipe.output.quantity;++i)
    {
        int levels[MAX_ITEM_MAGICLEVEL];ZeroMemory(levels,sizeof(levels));
        int index=ItemSet.Add(item_materials,0,0,0,recipe.output.detail,0,levels,g_SubWorldSet.GetGameVersion());
        if(index<=0){valid=false;break;}
        outputs[created++]=index;
        if(Item[index].GetGenre()!=item_materials || Item[index].GetDetailType()!=recipe.output.detail ||
           Item[index].GetParticular()!=0 || Item[index].GetStackNum()!=1 ||
           Item[index].GetWidth()<=0 || Item[index].GetHeight()<=0){valid=false;break;}
    }
    int slot;
    for(slot=0;slot<9 && valid;++slot)if(inputs[slot])
    {
        if(!Player[player].m_ItemList.Remove(inputs[slot])){valid=false;break;}
        detached[slot]=true;
    }
    for(int j=0;j<created && valid;++j)
    {
        ItemPos position;
        if(!Player[player].m_ItemList.SearchPosition(Item[outputs[j]].GetWidth(),Item[outputs[j]].GetHeight(),&position,true) ||
           !Player[player].m_ItemList.Add(outputs[j],position.nPlace,position.nX,position.nY,false))
        {valid=false;result=PT_COMPOSE_NO_ROOM;break;}
    }
    if(valid && !Player[player].Pay(money)){valid=false;result=PT_COMPOSE_NO_MONEY;}
    if(valid)
    {
        for(slot=0;slot<9;++slot)if(inputs[slot])ItemSet.Remove(inputs[slot]);
        return PT_COMPOSE_OK;
    }
    for(int k=0;k<created;++k)
    {
        if(Player[player].m_ItemList.FindSame(outputs[k]))Player[player].m_ItemList.Remove(outputs[k]);
        ItemSet.Remove(outputs[k]);
    }
    for(slot=0;slot<9;++slot)if(detached[slot])
        if(!Player[player].m_ItemList.Add(inputs[slot],pos_builditem,slot,0,false))
            g_DebugLog("[XichTungTu] compose restore invariant player=%d slot=%d",player,slot);
    return result;
}
static void PhongThanProcessCompose(int player,const PHONGTHAN_COMPOSE_COMMAND* command)
{
    PHONGTHAN_COMPOSE_RESULT reply;
    ZeroMemory(&reply,sizeof(reply));
    PhongThanInitializeWireHeader(&reply.Header,PHONGTHAN_COMPOSE_RESPONSE,sizeof(reply),PHONGTHAN_WIRE_FLAG_RESPONSE,0);
    const int actor=Player[player].m_nIndex;
    if(actor<=0 || actor>=MAX_NPC)return;
    const int world=Npc[actor].m_SubWorldIndex;
    if(world<0 || world>=MAX_SUBWORLD)return;
    reply.MapId=SubWorld[world].m_SubWorldID;reply.EntityId=Npc[actor].m_dwID;
    reply.Result=PT_COMPOSE_NOT_NEAR_NPC;
    const int npc=Player[player].m_nLastNpcIndex;
    if(command->MapId==reply.MapId && npc>0 && npc<MAX_NPC &&
       Npc[npc].m_SubWorldIndex==world && Npc[npc].m_RegionIndex>=0 &&
       PhongThanIsXichTungTu(reply.MapId,Npc[npc].m_NpcSettingIdx,Npc[npc].m_ActionScriptID) &&
       NpcSet.GetDistance(actor,npc)<=Npc[npc].m_DialogRadius*2)
    {
        reply.Result=PT_COMPOSE_LOCKED;
        if(!Player[player].GetLockState() && !Player[player].CheckTrading())
        {
            int indexes[9],listIndexes[9],details[9],counts[9],count=0;
            bool valid=true,stale=false,hasEquipment=false,onlyMaterials=true;
            for(int i=0;i<9;++i)
            {
                indexes[i]=Player[player].m_ItemList.GetBuildItem(i);
                listIndexes[i]=0;
                if(!indexes[i]){if(command->Items[i])stale=true;continue;}
                if(indexes[i]<=0 || indexes[i]>=MAX_ITEM){valid=false;continue;}
                listIndexes[i]=Player[player].m_ItemList.FindSame(indexes[i]);
                if(!listIndexes[i] || listIndexes[i]>=MAX_PLAYER_ITEM ||
                   Player[player].m_ItemList.m_Items[listIndexes[i]].nPlace!=pos_builditem ||
                   Player[player].m_ItemList.m_Items[listIndexes[i]].nX!=i)
                {valid=false;continue;}
                KItem& item=Item[indexes[i]];
                if(item.GetGenre()!=item_materials || item.GetParticular()!=0)onlyMaterials=false;
#ifndef PHONGTHAN_MATERIAL_ONLY_TEST
                if(item.GetGenre()==item_equip)hasEquipment=true;
#endif
                if(item.GetID()!=command->Items[i])stale=true;
                const int stack=item.GetStackNum();
                if(!item.GetID() ||
#ifdef PHONGTHAN_MATERIAL_ONLY_TEST
                   item.GetGenre()!=item_materials || item.GetParticular()!=0 ||
#else
                   (item.GetGenre()!=item_equip && item.GetGenre()!=item_materials && item.GetGenre()!=item_ibitem) ||
#endif
                   stack<1 || stack>10000 ||
                   item.GetLock()->IsLock() || item.GetLockTrade() || item.IsTemp())valid=false;
                int key=-1;
                for(int j=0;j<count;++j)if(details[j]==item.GetDetailType())key=j;
                if(key<0){key=count++;details[key]=item.GetDetailType();counts[key]=0;}
                counts[key]+=stack;
            }
            reply.Result=stale?PT_COMPOSE_STALE:PT_COMPOSE_INVALID_ITEMS;
            if(valid && !stale && count)
            {
                static KTabFile recipes,costs;
                static bool loaded=false;
                if(!loaded)loaded=recipes.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_gui_ze_biao.txt") &&
                    costs.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_jin_qian_xu_qiu.txt");
                reply.Result=loaded?PT_COMPOSE_NO_RECIPE:PT_COMPOSE_TABLE_ERROR;
#ifndef PHONGTHAN_MATERIAL_ONLY_TEST
                if(loaded && hasEquipment)
                    reply.Result=PhongThanEquipmentCompose(player,indexes,recipes,costs,reply.RecipeId);
#endif
                for(int row=2;loaded && !hasEquipment && onlyMaterials && row<=recipes.GetHeight();++row)
                {
                    PhongThanComposeRecipe recipe;
                    if(!PhongThanReadComposeRecipe(recipes,row,recipe) || !PhongThanIsBasicMaterialRecipe(recipe))continue;
                    int need[10],qty[10];
                    for(int j=0;j<recipe.inputCount;++j){need[j]=recipe.inputs[j].detail;qty[j]=recipe.inputs[j].quantity;}
                    if(!PhongThanComposeCountsEqual(details,counts,count,need,qty,recipe.inputCount))continue;
                    int money=0;
                    if(!PhongThanReadComposeCost(costs,recipe.id,1,money))
                    {reply.Result=PT_COMPOSE_NO_COST;break;}
                    if(Player[player].m_ItemList.GetEquipmentMoney()<money)
                    {reply.Result=PT_COMPOSE_NO_MONEY;break;}
                    const int d=recipe.output.detail;
                    reply.Result=PhongThanCommitMaterialCompose(player,indexes,recipe,money);
                    if(reply.Result!=PT_COMPOSE_OK)break;
                    reply.OutputDetail=d;
                    reply.RecipeId=recipe.id;
                    break;
                }
            }
        }
    }
    g_pServer->SendData(Player[player].m_nNetConnectIdx,&reply,sizeof(reply));
}
