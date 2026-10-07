static bool PhongThanUpgradeItemMatches(int index,const PhongThanRecipeItem& wanted)
{
    KItem& item=Item[index];
    int level=item.m_CommonAttrib.nUpgradeLvl;
    return item.GetGenre()==wanted.genre && item.GetDetailType()==wanted.detail &&
        item.GetParticular()==wanted.part && level>=0 && level<=15 &&
        (!wanted.upgradeMask || (wanted.upgradeMask&(1u<<level)));
}

// Recipes own the full source identities, quantities, attribute-rule ID and fee.
// The first input/output is the same equipment object, not a newly rolled item.
static int PhongThanEquipmentCompose(int player,const int* indexes,
    KTabFile& recipes,KTabFile& costs,int& recipeId)
{
    for(int row=2;row<=recipes.GetHeight();++row)
    {
        PhongThanComposeRecipe recipe;
        if(!PhongThanReadComposeRecipe(recipes,row,recipe) || recipe.group!=1 ||
           (recipe.type!=1 && recipe.type!=7) || recipe.requiredRecipe[0] ||
           recipe.inputs[0].genre!=item_equip || recipe.inputs[0].quantity!=1 ||
           recipe.output.genre!=item_equip || recipe.output.quantity!=1 ||
           recipe.output.detail!=recipe.inputs[0].detail || recipe.output.part!=recipe.inputs[0].part ||
           recipe.output.upgradeMask)continue;
        int remaining[9],main=-1;
        for(int s=0;s<9;++s){remaining[s]=indexes[s]?Item[indexes[s]].GetStackNum():0;
            if(indexes[s] && main<0 && PhongThanUpgradeItemMatches(indexes[s],recipe.inputs[0]))main=s;}
        if(main<0)continue;
        --remaining[main];bool matched=true;
        for(int n=1;n<recipe.inputCount;++n)
        {
            int left=recipe.inputs[n].quantity;
            for(int k=0;k<9 && left>0;++k)if(remaining[k]>0 && PhongThanUpgradeItemMatches(indexes[k],recipe.inputs[n]))
            {int take=remaining[k]<left?remaining[k]:left;remaining[k]-=take;left-=take;}
            if(left){matched=false;break;}
        }
        for(int rest=0;rest<9;++rest)if(remaining[rest])matched=false;
        if(!matched)continue;
        recipeId=recipe.id;
        KItem original=Item[indexes[main]],updated=original;
        const int oldLevel=original.m_CommonAttrib.nUpgradeLvl;
        const int oldRule=original.m_CommonAttrib.nUpgradeRule;
        const bool restore=recipe.type==7;
        if(restore && (!oldLevel || recipe.attributeId || recipe.chance!=100))continue;
        if(!restore && (oldLevel>=12 || (!recipe.inputs[0].upgradeMask && oldLevel>=9)))continue;
        if(!restore && oldLevel && !oldRule)return PT_COMPOSE_UPGRADE_RULE_MISSING;
        if(!restore && oldRule && oldRule!=recipe.attributeId)return PT_COMPOSE_UPGRADE_MODE_MIX;
        int money=0;
        if(!PhongThanReadComposeCost(costs,recipe.id,restore?1:oldLevel+1,money))return PT_COMPOSE_NO_COST;
        if(Player[player].m_ItemList.GetEquipmentMoney()<money)return PT_COMPOSE_NO_MONEY;
        int chance=100;
        if(!restore)
        {
            // Column 17 is the recipe's explicit percentage. Zero delegates
            // to the per-equipment step table; nonzero overrides that table.
            // Keep the installed PAK values even where a newer web guide differs.
            chance=recipe.chance;
            if(!recipe.chance)
            {
                static KTabFile rates;static bool loaded=false;
                if(!loaded)loaded=rates.Load("\\settings\\item\\001\\zhuang_bei_sheng_ji_ji_shuai_biao.txt");
                char* key=NULL;
                switch(original.GetDetailType()){
                    case equip_meleeweapon:key="meleeweapon";break;case equip_armor:key="armor";break;
                    case equip_helm:key="helm";break;case equip_boots:key="boot";break;
                    case equip_belt:key="belt";break;case equip_pendant:key="pendant";break;
                }
                if(!loaded || !key || !rates.GetInteger(rates.FindRow(key),oldLevel+2,-1,&chance) || chance<0 || chance>100)return PT_COMPOSE_TABLE_ERROR;
            }
            if(oldLevel<3 && chance<100)return PT_COMPOSE_TABLE_ERROR;
            if(!updated.ApplyUpgradeState(PhongThanEncodeUpgradeState(oldLevel+1,recipe.attributeId)))return PT_COMPOSE_TABLE_ERROR;
        }
        else if(!updated.ApplyUpgradeState(0))return PT_COMPOSE_TABLE_ERROR;
        // All possible surviving outcomes must be constructible before rolling.
        KItem failed=original;
        if(!restore && chance<100 && oldLevel<6 && !failed.ApplyUpgradeState(PhongThanEncodeUpgradeState(3,oldRule)))return PT_COMPOSE_TABLE_ERROR;
        ItemPos destination;
        if(!Player[player].m_ItemList.SearchPosition(original.GetWidth(),original.GetHeight(),&destination,true))return PT_COMPOSE_NO_ROOM;
        const bool success=restore || chance==100 || (int)g_Random(100)<chance;
        const bool destroyed=!success && oldLevel>=6 && oldLevel<9;
        int result=restore?PT_COMPOSE_RESTORE_OK:PT_COMPOSE_UPGRADE_OK;
        if(!success){result=oldLevel<6?PT_COMPOSE_FAILED_LEVEL3:(destroyed?PT_COMPOSE_FAILED_LOST:PT_COMPOSE_FAILED_RESET);
            if(oldLevel>=9 && !failed.ApplyUpgradeState(0))return PT_COMPOSE_TABLE_ERROR;}
        bool detached[9];ZeroMemory(detached,sizeof(detached));bool valid=true;
        for(int slot=0;slot<9;++slot)if(indexes[slot])
        {if(!Player[player].m_ItemList.Remove(indexes[slot])){valid=false;break;}detached[slot]=true;}
        bool placed=false;
        if(valid && !destroyed)
        {
            Item[indexes[main]]=success?updated:failed;
            placed=Player[player].m_ItemList.Add(indexes[main],destination.nPlace,destination.nX,destination.nY,false)!=0;
            if(!placed)valid=false;
        }
        if(valid && !Player[player].Pay(money))valid=false;
        if(valid)
        {
            for(int consumed=0;consumed<9;++consumed)if(indexes[consumed] && (consumed!=main || destroyed))ItemSet.Remove(indexes[consumed]);
            g_DebugLog("[XichTungTu] equipment player=%d recipe=%d level=%d chance=%d result=%d",player,recipe.id,oldLevel,chance,result);
#ifndef PHONGTHAN_EQUIPMENT_COMPOSE_TEST
            FILE* audit=fopen("xich_tung_tu_diag.log","a");
            if(audit){fprintf(audit,"player=%d item=%lu recipe=%d from=%d rule=%d chance=%d fee=%d result=%d\n",player,(unsigned long)original.GetID(),recipe.id,oldLevel,recipe.attributeId,chance,money,result);fclose(audit);}
#endif
            return result;
        }
        if(placed)Player[player].m_ItemList.Remove(indexes[main]);
        Item[indexes[main]]=original;
        for(int back=0;back<9;++back)if(detached[back])
            if(!Player[player].m_ItemList.Add(indexes[back],pos_builditem,back,0,false))g_DebugLog("[XichTungTu] restore build slot failed");
        return PT_COMPOSE_TABLE_ERROR;
    }
    return PT_COMPOSE_NO_RECIPE;
}
