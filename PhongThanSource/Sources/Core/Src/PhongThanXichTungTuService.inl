// Include after the quest transaction and original NPC Lua API definitions.
#include "PhongThanXichTungTu.h"
static bool PhongThanNearXichTungTu(int player)
{
    if(player<=0 || player>=MAX_PLAYER)return false;
    const int actor=Player[player].m_nIndex,npc=Player[player].m_nLastNpcIndex;
    if(actor<=0 || actor>=MAX_NPC || npc<=0 || npc>=MAX_NPC)return false;
    const int world=Npc[actor].m_SubWorldIndex;
    return world>=0 && world<MAX_SUBWORLD && Npc[npc].m_SubWorldIndex==world &&
        Npc[actor].m_RegionIndex>=0 && Npc[npc].m_RegionIndex>=0 &&
        PhongThanIsXichTungTu(SubWorld[world].m_SubWorldID,
            Npc[npc].m_NpcSettingIdx,Npc[npc].m_ActionScriptID) &&
        Npc[npc].m_DialogRadius>0 && NpcSet.GetDistance(actor,npc)<=Npc[npc].m_DialogRadius*2;
}

// Result: 1 success, 0 inventory/generation failure, -1 too far, -2 locked,
// -3 insufficient credit. Rules from original change(): 10 credit -> material82.
int LuaXichTungTuService(Lua_State* L)
{
    const int player=GetPlayerIndex(L);
    int result=-1;
    if(PhongThanNearXichTungTu(player) && Lua_GetTopIndex(L)==1 && Lua_IsNumber(L,1))
    {
        result=-2;
        if(!Player[player].GetLockState() && !Player[player].CheckTrading())
        {
            const int operation=(int)Lua_ValueToNumber(L,1);
            if(operation==0){LuaEnchaseItem(L);result=1;}
            else if(operation==1)
            {
                PhongThanMigrateCreditToRepute(player);	// engine2:D2 credit = danh vong (task 210)
                const int credit=Player[player].m_cTask.GetSaveVal(PT_CREDIT_TASK);
                result=-3;
                if(credit>=10)
                {
                    PhongThanQuestExchangeRow reward;
                    // material.txt has no Level column: runtime material level is 0.
                    PhongThanDecodeQuestItemTuple(3,82,0,0,0,0,reward.item);
                    reward.count=1;
                    result=PhongThanQuestExchange(player,PT_CREDIT_TASK,
                        credit,credit-10,NULL,0,&reward,1);
                }
            }
            else result=0;
        }
    }
    Lua_PushNumber(L,result);
    return 1;
}
