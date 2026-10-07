#include "KCore.h"
#include "KPakList.h"
#include "../../Headers/PhongThanCharacter.h"
#define private public
#include "KItem.h"
#undef private
#include <assert.h>
// Isolated objects, using the production KItem layout and upgrade method.
KItem::KItem(){ZeroMemory(this,sizeof(*this));}
KItem::~KItem(){}
KPakList* g_pPakList=NULL;
#include "../../Sources/Core/Src/PhongThanItemUpgrade.inl"
int main(int argc,char**argv)
{
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;
    assert(packs.Open("\\package.ini"));g_pPakList=&packs;g_SetPakFileMode(1);
    int level,rule;
    assert(PhongThanDecodeUpgradeState(12,level,rule) && level==12 && rule==0);
    assert(!PhongThanDecodeUpgradeState(0x41000101,level,rule));
    assert(!PhongThanDecodeUpgradeState(0x40000110,level,rule));
    KItem item;
    item.m_CommonAttrib.nItemGenre=item_equip;
    item.m_aryBaseAttrib[0].nAttribType=28;item.m_aryBaseAttrib[0].nValue[0]=100;
    item.m_aryBaseAttrib[1].nAttribType=29;item.m_aryBaseAttrib[1].nValue[0]=200;
    item.m_aryRequireAttrib[0].nAttribType=36;item.m_aryRequireAttrib[0].nValue[0]=50;
    item.m_aryMagicAttrib[MAX_ITEM_NORMAL_MAGICATTRIB].nAttribType=magic_lifemax_v;
    item.m_aryMagicAttrib[MAX_ITEM_NORMAL_MAGICATTRIB].nValue[0]=999;
    assert(item.ApplyUpgradeState(PhongThanEncodeUpgradeState(3,1)));
    assert(item.m_aryBaseAttrib[0].nValue[0]==130 && item.m_aryBaseAttrib[1].nValue[0]==230 && item.m_aryRequireAttrib[0].nValue[0]==62);
    assert(item.ApplyUpgradeState(PhongThanEncodeUpgradeState(3,1)) && item.m_aryBaseAttrib[0].nValue[0]==130);
    assert(item.ApplyUpgradeState(PhongThanEncodeUpgradeState(4,1)) && item.m_aryBaseAttrib[0].nValue[0]==145);
    int saved=item.GetUpgradeState();assert(PhongThanDecodeUpgradeState(saved,level,rule) && level==4 && rule==1);
    PHONGTHAN_CHARACTER_ITEM_RECORD disk;ZeroMemory(&disk,sizeof(disk));disk.UpgradeLevel=saved;
    unsigned char bytes[sizeof(disk)];memcpy(bytes,&disk,sizeof(disk));ZeroMemory(&disk,sizeof(disk));memcpy(&disk,bytes,sizeof(disk));
    assert(PhongThanDecodeUpgradeState(disk.UpgradeLevel,level,rule) && level==4 && rule==1);
    KItem restored;restored.m_CommonAttrib.nItemGenre=item_equip;
    restored.m_aryBaseAttrib[0].nAttribType=28;restored.m_aryBaseAttrib[0].nValue[0]=100;
    restored.m_aryBaseAttrib[1].nAttribType=29;restored.m_aryBaseAttrib[1].nValue[0]=200;
    restored.m_aryRequireAttrib[0].nAttribType=36;restored.m_aryRequireAttrib[0].nValue[0]=50;
    assert(restored.ApplyUpgradeState(saved) && restored.m_aryBaseAttrib[0].nValue[0]==145);
    assert(item.ApplyUpgradeState(0) && item.m_aryBaseAttrib[0].nValue[0]==100 && item.m_aryRequireAttrib[0].nValue[0]==50);
    assert(item.m_aryMagicAttrib[MAX_ITEM_NORMAL_MAGICATTRIB].nValue[0]==999);
    assert(!item.ApplyUpgradeState(PhongThanEncodeUpgradeState(1,65535)) && item.m_aryBaseAttrib[0].nValue[0]==100);
    item.m_aryBaseAttrib[0].nValue[0]=INT_MAX;
    assert(!item.ApplyUpgradeState(PhongThanEncodeUpgradeState(1,1)) && item.m_aryBaseAttrib[0].nValue[0]==INT_MAX);
    PhongThanUpgradeStat deltas[20];int count=0;
    assert(PhongThanLoadUpgradeDeltas(41,4,deltas,count) && count==2 && deltas[1].type==45 && deltas[1].delta==42);
    KItem armor;armor.m_CommonAttrib.nItemGenre=item_equip;
    armor.m_aryBaseAttrib[0].nAttribType=30;armor.m_aryBaseAttrib[0].nValue[0]=100;
    assert(armor.ApplyUpgradeState(PhongThanEncodeUpgradeState(4,41)) && armor.m_aryBaseAttrib[1].nAttribType==45 && armor.m_aryBaseAttrib[1].nValue[0]==42);
    assert(armor.ApplyUpgradeState(0) && armor.m_aryBaseAttrib[0].nValue[0]==100 && !armor.m_aryBaseAttrib[1].nAttribType && !armor.m_aryRequireAttrib[0].nAttribType);
    puts("PASS ITEM_UPGRADE_STATE actual_item_method PAK18 rule1/41 idempotence restore_base preserved_set restore_encoded_state overflow unknown_rule");
    g_pPakList=NULL;return 0;
}
