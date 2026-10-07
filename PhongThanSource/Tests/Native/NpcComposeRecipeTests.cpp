#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
#include "../../Sources/Core/Src/PhongThanComposeRecipe.h"
int main(int argc,char**argv)
{
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;
    if(!packs.Open("\\package.ini"))return 3;g_SetPakFileMode(1);
    KTabFile table;
    if(!table.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_gui_ze_biao.txt"))return 4;
    PhongThanRecipeItem item;
    assert(PhongThanParseRecipeItem("3.29.0.2",item) && item.quantity==2);
    assert(!PhongThanParseRecipeItem("3.29.0.2147483648",item));
    assert(!PhongThanParseRecipeItem("3.29.0.-1",item));
    assert(!PhongThanParseRecipeItem("3.29.0.2extra",item));
    KTabFile costs,materials;int money=-1;
    assert(costs.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_jin_qian_xu_qiu.txt"));
    assert(materials.Load("\\settings\\item\\001\\material.txt"));
    int parsed=0,basic=0,ready=0,groupNotQuantity=0;bool found83=false;
    for(int row=2;row<=table.GetHeight();++row){
        PhongThanComposeRecipe r;
        if(!PhongThanReadComposeRecipe(table,row,r))continue;
        ++parsed;if(PhongThanIsBasicMaterialRecipe(r)){
            ++basic;
            const bool hasCost=PhongThanReadComposeCost(costs,r.id,1,money);
            if(!hasCost)printf("DEFER missing authoritative cost recipe=%d\n",r.id);
            int outputs=0;
            for(int m=2;m<=materials.GetHeight();++m){int detail=-1;materials.GetInteger(m,3,-1,&detail);
                if(detail==r.output.detail){int width=0,height=0;materials.GetInteger(m,6,0,&width);materials.GetInteger(m,7,0,&height);assert(width>0 && height>0);++outputs;}}
            assert(outputs==1);
            if(hasCost)++ready;
        }
        if(r.group!=r.output.quantity)++groupNotQuantity;
        if(r.id==83){assert(r.attributeId==0 && r.group==1 && r.inputs[0].quantity==2 && r.output.quantity==1 && r.output.detail==30);found83=true;}
    }
    assert(found83 && basic>0 && groupNotQuantity>0);
    assert(PhongThanReadComposeCost(costs,83,1,money) && money==400);
    assert(PhongThanReadComposeCost(costs,84,1,money) && money==800);
    assert(!PhongThanReadComposeCost(costs,83,0,money));
    assert(!PhongThanReadComposeCost(costs,83,16,money));
    assert(!PhongThanReadComposeCost(costs,9999999,1,money));
    printf("PASS NPC_COMPOSE_SCHEMA parsed=%d deterministic_material=%d with_cost=%d group_differs_quantity=%d\n",parsed,basic,ready,groupNotQuantity);
    return 0;
}
