#include "KCore.h"
#include "KPakList.h"
#include "KBasPropTbl.h"
#include "PhongThanStarterBag.h"
#include "PhongThanStarterBagProperty.h"
#include "PhongThanUiProtocol.h"
#include "PhongThanScriptWire.h"
#include <stdio.h>

// Real table loader, with no world/network/player startup required.
class CatalogAccess {
public:
    KLibOfBPT lib;
    const KLibOfBPT& Catalog() const { return lib; }
    const KBASICPROP_EQUIPMENT* CatalogEquipment(int kind, int row) const {
        switch(kind) {
        case 0:return lib.GetMeleeWeaponRecord(row);case 1:return lib.GetRangeWeaponRecord(row);
        case equip_armor:return lib.GetArmorRecord(row);case equip_helm:return lib.GetHelmRecord(row);
        case equip_boots:return lib.GetBootRecord(row);case equip_belt:return lib.GetBeltRecord(row);
        case equip_amulet:return lib.GetAmuletRecord(row);case equip_ring:return lib.GetRingRecord(row);
        case 8:return lib.GetCuffRecord(row);case 9:return lib.GetPendantRecord(row);
        case 10:return lib.GetHorseRecord(row);default:return NULL;}
    }
    int CatalogEquipmentCount(int kind) const {
        switch(kind) {
        case 0:return lib.GetMeleeWeaponRecordNumber();case 1:return lib.GetRangeWeaponRecordNumber();
        case equip_armor:return lib.GetArmorRecordNumber();case equip_helm:return lib.GetHelmRecordNumber();
        case equip_boots:return lib.GetBootRecordNumber();case equip_belt:return lib.GetBeltRecordNumber();
        case equip_amulet:return lib.GetAmuletRecordNumber();case equip_ring:return lib.GetRingRecordNumber();
        case 8:return lib.GetCuffRecordNumber();case 9:return lib.GetPendantRecordNumber();
        case 10:return lib.GetHorseRecordNumber();default:return 0;}
    }
} ItemGen;
#include "PhongThanItemPickerCatalog.h"
#define CHECK(x) do { if(!(x)){printf("FAIL line=%d %s\n",__LINE__,#x);return 1;} }while(0)
int main(int argc,char**argv)
{
    if(argc!=2 && argc!=3)return 2;
    g_SetRootPath(NULL);KPakList packs;CHECK(packs.Open("\\package.ini"));g_pPakList=&packs;g_SetPakFileMode(1);
    CHECK(ItemGen.lib.Init());CHECK(!ItemGen.lib.GetMagicScript(PHONGTHAN_STARTER_BAG_ID));
    if(argc==3){int found=0;for(int i=0;i<ItemGen.lib.GetMagicScriptRecordNumber()&&found<8;i++){
        const KBASICPROP_MAGICSCRIPT*p=ItemGen.lib.MagicScriptAt(i);if(!p||!strstr(p->m_szName,"T\xF3i"))continue;
        SPROFFS*o=NULL;SPRHEAD*h=SprGetHeader((char*)p->m_szImageName,o);if(h){printf("BAG_ICON id=%d name=%s path=%s\n",p->m_nDetailType,p->m_szName,p->m_szImageName);SprReleaseHeader(h);found++;}}
        g_pPakList=NULL;return 0;}
    const KBASICPROP_MAGICSCRIPT* bag=PhongThanStarterBagProperty(ItemGen.lib);CHECK(bag && bag->m_nDetailType==61000);
    SPROFFS* offsets=NULL;SPRHEAD* sprite=SprGetHeader((char*)bag->m_szImageName,offsets);CHECK(sprite);SprReleaseHeader(sprite);
    KIniFile ui;CHECK(ui.LoadPakEntry(0x5F7D8300UL));const char* sections[]={"Main","OkBtn","CancelBtn"};
    for(int i=0;i<3;i++){char path[256];CHECK(ui.GetString(sections[i],"Image","",path,sizeof(path)));sprite=SprGetHeader(path,offsets);CHECK(sprite);SprReleaseHeader(sprite);}
    PTB_Record record;CHECK(!PTB_Resolve(0,61000,record));CHECK(!PTB_Resolve(1,0,record));CHECK(!PTB_Resolve(1,999999,record));CHECK(!PTB_Resolve(-1,1,record));
    PHONGTHAN_UI_NUMBER_REQUEST r;memset(&r,0,sizeof(r));PhongThanInitializeWireHeader(&r.Header,PHONGTHAN_MSG_UI_NUMBER_INPUT,sizeof(r),PHONGTHAN_WIRE_FLAG_REQUEST,0);
    r.MapId=1052;r.DialogToken=7;r.Value=999999;CHECK(PhongThanValidateNumberRequest(&r,sizeof(r)));
    r.Value=1000000;CHECK(!PhongThanValidateNumberRequest(&r,sizeof(r)));r.Value=-1;CHECK(PhongThanValidateNumberRequest(&r,sizeof(r)));
    r.DialogToken=0;CHECK(!PhongThanValidateNumberRequest(&r,sizeof(r)));CHECK(!PhongThanValidateNumberRequest(&r,sizeof(r)-1));
    KPhongThanScriptAction action;memset(&action,0,sizeof(action));action.Operation=PHONGTHAN_SCRIPT_SHOW;action.View=UI_NUMBER_INPUT;
    action.ServerOwned=1;action.MapId=1052;action.DialogToken=8;strcpy(action.Content,"Nhap ID");action.ContentLength=7;
    char wire[512];unsigned bytes=PhongThanBuildScriptPacket(action,wire,sizeof(wire));CHECK(bytes);
    KPhongThanScriptAction copy;CHECK(PhongThanReadScriptPacket(wire,bytes,&copy));CHECK(copy.View==UI_NUMBER_INPUT&&copy.DialogToken==8);
    FILE* out=fopen(argv[1],"wb");CHECK(out);
    fprintf(out,"Nhom\tMaNhap\tLoaiMa\tTenVatPham\tBang\tDongFile\n");
    const char* names[]={"MagicScript","Vu khi gan","Vu khi xa","Giap","Nhan","Day chuyen","Giay","That lung","Mu","Ho uyen","Boi","Thu cuoi","Ky tran cac","Nguyen lieu","Nhiem vu"};
    const char* files[]={"magicscript","meleeweapon","rangeweapon","armor","ring","amulet","boot","belt","helm","cuff","pendant","horse","ibitem","material","questkey"};
    int total=0,skipped=0;
    for(int cat=0;cat<15;cat++){
        int count=cat==0?ItemGen.lib.GetMagicScriptRecordNumber():cat<=11?ItemGen.CatalogEquipmentCount(cat-1):cat==12?ItemGen.lib.GetIBItemRecordNumber():cat==13?ItemGen.lib.GetMaterialRecordNumber():ItemGen.lib.GetQuestRecordNumber();
        int emitted=0;
        for(int row=0;row<count;row++){
            int key=row+1;
            if(cat==0){const KBASICPROP_MAGICSCRIPT*p=ItemGen.lib.MagicScriptAt(row);if(!p)continue;key=p->m_nDetailType;if(ItemGen.lib.GetMagicScript(key)!=p){skipped++;continue;}}
            if(cat==13){const KBASICPROP_EVENTITEM*p=ItemGen.lib.MaterialAt(row);if(!p)continue;key=p->m_nDetailType;}
            if(cat==14){const KBASICPROP_QUEST*p=ItemGen.lib.QuestAt(row);if(!p)continue;key=p->m_nDetailType;}
            if(!PTB_Resolve(cat,key,record)){skipped++;continue;}
            char name[128];PTB_Name(record.name,name,sizeof(name));
            fprintf(out,"%s\t%d\t%s\t%s\t%s.txt\t%d\n",names[cat],key,cat==0||cat>=13?"ID":"STT",name,files[cat],row+2);emitted++;total++;
        }
        printf("CATALOG group=%s valid=%d rows=%d\n",files[cat],emitted,count);
        CHECK(emitted > 0);
    }
    fclose(out);g_pPakList=NULL;printf("PASS bag definition, original VNG input SPRs, input wire bounds/roundtrip, catalog entries=%d omitted_invalid_or_duplicate=%d\n",total,skipped);
    return 0;
}
