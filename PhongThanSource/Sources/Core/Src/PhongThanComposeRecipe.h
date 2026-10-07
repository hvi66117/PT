#ifndef PHONGTHAN_COMPOSE_RECIPE_H
#define PHONGTHAN_COMPOSE_RECIPE_H
#include "KTabFile.h"
#include <stdio.h>
#include <string.h>

// The original 19-column VNG table. Column 2 is NOT a price and column 15
// is NOT an output quantity. Quantity belongs to the fourth tuple component.
enum PhongThanComposeColumn {
    PT_RC_ID=1, PT_RC_ATTRIBUTE_ID=2, PT_RC_INPUT_COUNT=3,
    PT_RC_FIRST_INPUT=4, PT_RC_OUTPUT=14, PT_RC_GROUP=15,
    PT_RC_TYPE=16, PT_RC_CHANCE=17, PT_RC_REQUIRED_RECIPE=18, PT_RC_NOTE=19
};
struct PhongThanRecipeItem { int genre,detail,part,quantity; unsigned int upgradeMask; };
struct PhongThanComposeRecipe {
    int id,attributeId,inputCount,group,type,chance;
    PhongThanRecipeItem inputs[10],output;
    char requiredRecipe[128];
};
inline bool PhongThanRecipeNumber(const char*& p,int& result)
{
    if(*p<'0' || *p>'9')return false;
    result=0;
    do {
        const int digit=*p++-'0';
        if(result>(2147483647-digit)/10)return false;
        result=result*10+digit;
    }while(*p>='0' && *p<='9');
    return true;
}
inline bool PhongThanParseRecipeItem(const char* text,PhongThanRecipeItem& item)
{
    const char* p=text;
    item.upgradeMask=0;
    if(!(PhongThanRecipeNumber(p,item.genre) && *p++=='.' &&
        PhongThanRecipeNumber(p,item.detail) && *p++=='.' &&
        PhongThanRecipeNumber(p,item.part) && *p++=='.' &&
        PhongThanRecipeNumber(p,item.quantity) && item.quantity>0 && item.quantity<=10000))return false;
    // Original rule notes explicitly identify (3,4,5) as attempts 4/5/6.
    // Bracket qualifiers and other extensions are not silently discarded.
    if(*p=='('){
        ++p;
        do {int level=0;if(!PhongThanRecipeNumber(p,level) || level>15)return false;
            item.upgradeMask|=1u<<level;
            if(*p==')'){++p;break;}if(*p++!=',')return false;
        }while(*p);
        if(p==text || p[-1]!=')')return false;
    }
    return !*p;
}
inline bool PhongThanReadComposeRecipe(KTabFile& table,int row,PhongThanComposeRecipe& r)
{
    memset(&r,0,sizeof(r));
    if(row<2 || row>table.GetHeight() || table.GetWidth()!=19)return false;
    table.GetInteger(row,PT_RC_ID,0,&r.id);
    table.GetInteger(row,PT_RC_ATTRIBUTE_ID,0,&r.attributeId);
    table.GetInteger(row,PT_RC_INPUT_COUNT,0,&r.inputCount);
    table.GetInteger(row,PT_RC_GROUP,0,&r.group);
    table.GetInteger(row,PT_RC_TYPE,0,&r.type);
    table.GetInteger(row,PT_RC_CHANCE,-1,&r.chance);
    table.GetString(row,PT_RC_REQUIRED_RECIPE,"",r.requiredRecipe,sizeof(r.requiredRecipe));
    if(r.id<=0 || r.inputCount<1 || r.inputCount>10 || r.chance<0 || r.chance>100)return false;
    char text[128];
    for(int i=0;i<r.inputCount;++i){
        table.GetString(row,PT_RC_FIRST_INPUT+i,"",text,sizeof(text));
        if(!PhongThanParseRecipeItem(text,r.inputs[i]))return false;
    }
    table.GetString(row,PT_RC_OUTPUT,"",text,sizeof(text));
    return PhongThanParseRecipeItem(text,r.output);
}
inline bool PhongThanIsBasicMaterialRecipe(const PhongThanComposeRecipe& r)
{
    // Preserve the reviewed basic workstation scope. Higher groups represent
    // other workflows; decoding them is not authorization to bypass their rules.
    if(r.type!=6 || r.group!=1 || r.attributeId || r.chance!=100 || r.requiredRecipe[0] ||
       r.output.genre!=3 || r.output.part || r.output.upgradeMask || r.output.quantity<1 || r.output.quantity>64)return false;
    for(int i=0;i<r.inputCount;++i)
        if(r.inputs[i].genre!=3 || r.inputs[i].part || r.inputs[i].upgradeMask)return false;
    return true;
}
inline bool PhongThanReadComposeCost(KTabFile& table,int recipeId,int attempt,int& money)
{
    money=0;
    if(recipeId<=0 || attempt<1 || attempt>15 || table.GetWidth()!=16)return false;
    char key[24],value[32];sprintf(key,"%d",recipeId);
    const int row=table.FindRow(key);
    if(row<2)return false;
    table.GetString(row,attempt+1,"",value,sizeof(value));
    const char* p=value;
    return PhongThanRecipeNumber(p,money) && !*p;
}
#endif
