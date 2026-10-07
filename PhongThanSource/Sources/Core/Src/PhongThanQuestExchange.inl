// Shared server transaction for trusted NPC Lua. A quest phase is a compare-
// and-set guard; no requirement is destroyed until all rewards fit in F4.
#ifdef _SERVER
struct PhongThanQuestExchangeRow { PhongThanQuestItemTuple item;int count; };
static bool PhongThanReadQuestExchangeRows(Lua_State* L,int index,
    PhongThanQuestExchangeRow* rows,int& count)
{
    if(!Lua_IsTable(L,index))return false;
    count=Lua_GetN(L,index);if(count<0 || count>16)return false;
    const int top=Lua_GetTopIndex(L);
    for(int i=0;i<count;++i){
        Lua_RawGetI(L,index,i+1);const int row=Lua_GetTopIndex(L);
        if(!Lua_IsTable(L,row)){Lua_SetTopIndex(L,top);return false;}
        int values[7];bool valid=true;
        for(int j=0;j<7;++j){
            Lua_RawGetI(L,row,j+1);double v=Lua_ValueToNumber(L,-1);
            if(!Lua_IsNumber(L,-1) || v<0 || v>2147483647.0 || v!=(int)v)valid=false;
            values[j]=valid?(int)v:0;Lua_Pop(L,1);
        }
        if(!valid || values[6]<1 || values[6]>10000 ||
           !PhongThanDecodeQuestItemTuple(values[0],values[1],values[2],values[3],values[4],values[5],rows[i].item))
        {Lua_SetTopIndex(L,top);return false;}
        rows[i].count=values[6];Lua_Pop(L,1);
    }
    return true;
}

static int PhongThanQuestExchange(int player,int task,int expected,int next,
    PhongThanQuestExchangeRow* needs,int needCount,
    PhongThanQuestExchangeRow* rewards,int rewardCount)
{
    if(player<=0 || player>=MAX_PLAYER || task<0 || task>=MAX_TASK || expected==next ||
       needCount<0 || needCount>16 || rewardCount<0 || rewardCount>16 ||
       Player[player].m_cTask.GetSaveVal(task)!=expected ||
       Player[player].GetLockState() || Player[player].CheckTrading())return 0;
    KItemList& bag=Player[player].m_ItemList;
    struct Take {int index,quantity,stack;ItemPos position;bool changed;} take[64];
    int takeCount=0;
    for(int n=0;n<needCount;++n){
        int left=needs[n].count;
        PlayerItem* owned=bag.GetFirstItem();
        while(owned && left>0){
            int index=owned->nIdx;
            if(owned->nPlace==pos_equiproom && index>0 && index<MAX_ITEM && Item[index].GetID() &&
               PhongThanQuestItemMatches(Item[index],needs[n].item) && !Item[index].GetLock()->IsLock()){
                int slot=-1;for(int j=0;j<takeCount;++j)if(take[j].index==index)slot=j;
                int used=slot<0?0:take[slot].quantity;
                int available=Item[index].GetStackNum()-used;
                if(available>0){
                    if(slot<0){
                        if(takeCount==64)return 0;slot=takeCount++;
                        take[slot].index=index;take[slot].quantity=0;
                        take[slot].stack=Item[index].GetStackNum();take[slot].changed=false;
                        take[slot].position.nPlace=owned->nPlace;take[slot].position.nX=owned->nX;take[slot].position.nY=owned->nY;
                    }
                    int amount=available<left?available:left;take[slot].quantity+=amount;left-=amount;
                }
            }
            owned=bag.GetNextItem();
        }
        if(left)return 0;
    }
    int created[64],createdCount=0;bool success=true;
    for(int r=0;r<rewardCount && success;++r){
        if(rewards[r].count>64-createdCount){success=false;break;}
        for(int j=0;j<rewards[r].count;++j){
            const PhongThanQuestItemTuple& t=rewards[r].item;
            int levels[MAX_ITEM_MAGICLEVEL];ZeroMemory(levels,sizeof(levels));
            int index=ItemSet.Add(t.genre,t.series,t.level,t.luck,t.detail,t.particular,levels,g_SubWorldSet.GetGameVersion());
            if(index<=0){success=false;break;}
            created[createdCount++]=index;
            if(!PhongThanQuestItemMatches(Item[index],t) || Item[index].GetWidth()<=0 || Item[index].GetHeight()<=0)
            {success=false;break;}
        }
    }
    int i;
    // Detach (do not destroy) inputs so their space can be used for rewards.
    // All failure paths restore the same object IDs and original cells.
    for(i=0;i<takeCount && success;++i){
        Take& input=take[i];
        if(input.quantity==input.stack){if(!bag.Remove(input.index)){success=false;break;}}
        else {Item[input.index].SetStackNum(input.stack-input.quantity);bag.SyncItem(input.index);}
        input.changed=true;
    }
    for(i=0;i<createdCount && success;++i){
        ItemPos pos;
        if(!bag.SearchPosition(Item[created[i]].GetWidth(),Item[created[i]].GetHeight(),&pos,true) ||
           !bag.Add(created[i],pos.nPlace,pos.nX,pos.nY,false)){success=false;break;}
    }
    if(success){
        Player[player].m_cTask.SetSaveVal(task,next,TRUE);
        for(i=0;i<takeCount;++i)if(take[i].quantity==take[i].stack)ItemSet.Remove(take[i].index);
        return 1;
    }
    for(i=0;i<createdCount;++i){if(bag.FindSame(created[i]))bag.Remove(created[i]);ItemSet.Remove(created[i]);}
    for(i=0;i<takeCount;++i)if(take[i].changed){
        Take& input=take[i];
        if(input.quantity==input.stack){
            if(!bag.Add(input.index,input.position.nPlace,input.position.nX,input.position.nY,false))
                g_DebugLog("[QuestExchange] restore invariant failed player=%d task=%d item=%d",player,task,input.index);
        }else{Item[input.index].SetStackNum(input.stack);bag.SyncItem(input.index);}
    }
    return 0;
}

int LuaQuestExchange(Lua_State* L)
{
    int result=0;const int player=GetPlayerIndex(L);
    if(player>0 && Lua_GetTopIndex(L)==5){
        int args[3];bool valid=true;
        for(int i=0;i<3;++i){double v=Lua_ValueToNumber(L,i+1);
            if(!Lua_IsNumber(L,i+1) || v<0 || v>2147483647.0 || v!=(int)v)valid=false;
            args[i]=valid?(int)v:0;}
        PhongThanQuestExchangeRow needs[16],rewards[16];int needCount=0,rewardCount=0;
        if(valid && PhongThanReadQuestExchangeRows(L,4,needs,needCount) && PhongThanReadQuestExchangeRows(L,5,rewards,rewardCount))
            result=PhongThanQuestExchange(player,args[0],args[1],args[2],needs,needCount,rewards,rewardCount);
    }
    Lua_PushNumber(L,result);return 1;
}
#endif
