#include <windows.h>
#include <assert.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
#include "KPakFile.h"
#include "../../Headers/PhongThanEquipmentPresentation.h"
#include "../../Headers/PhongThanUpgradePower.h"
#include "../../Sources/Core/Src/PhongThanUpgradeTables.h"
enum { item_equip=0,equip_meleeweapon=0,equip_rangeweapon=1,equip_armor=2 };
struct Equipment { int m_nBasePowerKind,m_nBasePower; };
static Equipment tableData;
struct Generator { const Equipment* CatalogEquipment(int,int) const{return &tableData;} } ItemGen;
typedef Equipment KBASICPROP_EQUIPMENT;
struct KItem {
    struct {int nUpgradeLvl,nUpgradeRule;}m_CommonAttrib;
    int detail,base,magic,power;
    int GetGenre()const{return item_equip;}
    int GetDetailType()const{return detail;}
    int GetRow()const{return 0;}
    int GetBasePower()const{return base;}
    int GetMagicPower()const{return magic;}
    BOOL GetUpgradePower(int& out)const{out=power;return TRUE;}
};
#include "../../Sources/Core/Src/PhongThanEquipmentTooltip.inl"

static void VerifySpr(char* path,int width,int height,int frames)
{
    SPROFFS* offsets=NULL;SPRHEAD* head=SprGetHeader(path,offsets);
    assert(head && head->Width==width && head->Height==height && head->Frames==frames);
    if(!offsets)for(int n=0;n<frames;++n){SPRFRAME* frame=SprGetFrame(head,n);assert(frame);SprReleaseFrame(frame);}
    SprReleaseHeader(head);
}
int main(int argc,char** argv)
{
    assert(argc==2 && SetCurrentDirectoryA(argv[1]));
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList pak;assert(pak.Open("\\package.ini"));g_pPakList=&pak;g_SetPakFileMode(1);
    VerifySpr(PT_VNG_STAR_STRIP,208,11,1);VerifySpr(PT_VNG_STAR_FRAME12,172,17,89);
    VerifySpr(PT_VNG_EQUIP_FX_ROOT "tou.spr",68,68,20);
    VerifySpr(PT_VNG_EQUIP_FX_ROOT "shen.spr",66,98,20);
    VerifySpr(PT_VNG_EQUIP_FX_ROOT "yao.spr",66,45,20);
    VerifySpr(PT_VNG_EQUIP_FX_ROOT "fabao.spr",34,34,20);
    char path[128];assert(PhongThanBigItemPath("\\spr\\item\\equip\\\xD2\xC2\xB7\xFE" "11.spr",false,path,sizeof(path)));
    VerifySpr(path,64,96,1);
    assert(PhongThanBigItemPath("\\spr\\item\\weapen\\\xD5\xB6\xBD\xAB\xB5\xB6.spr",false,path,sizeof(path)));
    VerifySpr(path,66,98,1);
    assert(!PhongThanBigItemPath("x.spr",false,path,4));assert(!PhongThanBigItemPath("x.txt",false,path,128));
    for(int s=1;s<=12;++s){assert(PhongThanStarCount(480+s)==s);assert(PhongThanStarWidth(s)>0);}
    assert(!PhongThanStarCount(480) && !PhongThanStarCount(493));
    KItem item;ZeroMemory(&item,sizeof(item));char line[256];
    PhongThanUpgradeDescription(item,line);assert(!line[0]);
    item.m_CommonAttrib.nUpgradeLvl=3;item.m_CommonAttrib.nUpgradeRule=1;
    PhongThanUpgradeDescription(item,line);assert(strstr(line,"STCB 3") && strstr(line,"0,255,255"));
    item.m_CommonAttrib.nUpgradeRule=33;
    PhongThanUpgradeDescription(item,line);assert(strstr(line,"h\xE1" "a s\xB8t 3") && !strstr(line,"STCB"));
    item.m_CommonAttrib.nUpgradeRule=9;
    PhongThanUpgradeDescription(item,line);assert(strstr(line,"L\xABi s\xB8t 3") && !strstr(line,"STCB"));
    item.detail=equip_armor;item.m_CommonAttrib.nUpgradeRule=1012;
    PhongThanUpgradeDescription(item,line);assert(strstr(line,"tinh l\xF9" "c 3"));
    item.m_CommonAttrib.nUpgradeRule=0;PhongThanUpgradeDescription(item,line);assert(strstr(line,"(ch\xAD" "a"));
    int total=0;tableData.m_nBasePowerKind=PT_POWER_SCALAR;tableData.m_nBasePower=270;
    item.magic=0;item.power=13;assert(PhongThanKnownTooltipPower(item,total) && total==283);
    item.power=0;assert(PhongThanKnownTooltipPower(item,total) && total==270);
    tableData.m_nBasePowerKind=PT_POWER_PAIR;item.base=0;assert(!PhongThanKnownTooltipPower(item,total));
    assert(!PhongThanSumKnownItemPower(INT_MAX,1,0,total));
    g_pPakList=NULL;pak.Close();
    puts("PASS equipment presentation: original big SPR, aura, star/frame PAK decoding, 0/3/12 star bounds, labels, scalar power and unknown-pair guard.");
    return 0;
}
