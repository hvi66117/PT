// Actual item upgrade implementation + actual PAK recipes/rates/costs.
// Only ownership/placement/payment and RNG are isolated from live characters.
#define Item UnallocatedEngineItems
#define main UpgradeStateUnitMain
#include "ItemUpgradeStateTests.cpp"
#undef main
#undef Item
#include "../../Headers/PhongThanCompose.h"
#include "../../Sources/Core/Src/PhongThanComposeRecipe.h"
KItem Item[16];
struct ItemPos {int nPlace,nX,nY;};
struct BagMock {
    bool owned[16],room,payAllowed;int money,failedRemove;
    int GetEquipmentMoney(){return money;}
    bool SearchPosition(int,int,ItemPos* p,bool){p->nPlace=pos_equiproom;p->nX=p->nY=0;return room;}
    bool Remove(int id){if(id==failedRemove || !owned[id])return false;owned[id]=false;return true;}
    int Add(int id,int place,int,int,bool){if(place!=pos_builditem && !room)return 0;owned[id]=true;return id;}
};
struct PlayerMockUpgrade {BagMock m_ItemList;bool Pay(int amount){if(!m_ItemList.payAllowed || m_ItemList.money<amount)return false;m_ItemList.money-=amount;return true;}} Player[2];
struct ItemSetMockUpgrade {void Remove(int id){Item[id].SetID(0);}} ItemSet;
static int forcedRoll=0;
static int TestUpgradeRandom(int max){assert(max==100);return forcedRoll;}
#define g_Random TestUpgradeRandom
#define PHONGTHAN_EQUIPMENT_COMPOSE_TEST
#include "../../Sources/Core/Src/PhongThanEquipmentCompose.inl"
#undef g_Random
static void Seed(int id,int genre,int detail,int part){
    ZeroMemory(&Item[id],sizeof(KItem));Item[id].SetID(100+id);Item[id].SetGenre(genre);Item[id].SetDetailType(detail);Item[id].SetParticular(part);
    Item[id].m_CommonAttrib.nStackNum=1;Item[id].m_CommonAttrib.nWidth=Item[id].m_CommonAttrib.nHeight=1;
    Player[1].m_ItemList.owned[id]=true;
}
static void Setup(int level,int rule){
    ZeroMemory(Player,sizeof(Player));Player[1].m_ItemList.room=Player[1].m_ItemList.payAllowed=true;Player[1].m_ItemList.money=100000000;
    forcedRoll=0;Seed(1,0,0,0);Seed(2,0,4,0);Seed(3,3,41,0);
    Item[1].m_aryBaseAttrib[0].nAttribType=28;Item[1].m_aryBaseAttrib[0].nValue[0]=100;
    Item[1].m_aryBaseAttrib[1].nAttribType=29;Item[1].m_aryBaseAttrib[1].nValue[0]=200;
    Item[1].m_aryRequireAttrib[0].nAttribType=36;Item[1].m_aryRequireAttrib[0].nValue[0]=50;
    assert(Item[1].ApplyUpgradeState(PhongThanEncodeUpgradeState(level,rule)));
}
int main(int argc,char**argv){
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;assert(packs.Open("\\package.ini"));g_pPakList=&packs;g_SetPakFileMode(1);
    KTabFile recipes,costs;
    assert(recipes.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_gui_ze_biao.txt"));
    assert(costs.Load("\\settings\\item\\001\\zhuang_bei_he_cheng_jin_qian_xu_qiu.txt"));
    int input[9]={1,2,3,0,0,0,0,0,0},recipe=0;
    Setup(0,0);assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_OK && recipe==1);
    assert(Item[1].GetID()==101 && Item[1].m_CommonAttrib.nUpgradeLvl==1 && Item[1].m_aryBaseAttrib[0].nValue[0]==110);
    assert(!Item[2].GetID() && !Item[3].GetID() && Player[1].m_ItemList.money==99990000);
    Setup(3,1);assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_OK);
    assert(Item[1].m_CommonAttrib.nUpgradeLvl==4 && Item[1].m_aryBaseAttrib[0].nValue[0]==145);
    Setup(5,1);forcedRoll=99;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_FAILED_LEVEL3);
    assert(Item[1].m_CommonAttrib.nUpgradeLvl==3 && Item[1].m_aryBaseAttrib[0].nValue[0]==130);
    Setup(6,1);forcedRoll=99;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_FAILED_LOST && !Item[1].GetID());
    Setup(0,0);Player[1].m_ItemList.money=9999;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_NO_MONEY && Item[2].GetID()==102);
    Setup(0,0);Player[1].m_ItemList.room=false;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_NO_ROOM && Item[1].m_CommonAttrib.nUpgradeLvl==0);
    Setup(0,0);Player[1].m_ItemList.payAllowed=false;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_TABLE_ERROR);
    assert(Item[1].m_aryBaseAttrib[0].nValue[0]==100 && Item[2].GetID()==102 && Player[1].m_ItemList.owned[1] && Player[1].m_ItemList.owned[2]);
    Setup(0,0);Player[1].m_ItemList.failedRemove=2;assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_TABLE_ERROR && Item[1].m_CommonAttrib.nUpgradeLvl==0);
    Setup(3,0);assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_RULE_MISSING && Item[2].GetID()==102);
    int undo[9]={1,2,0,0,0,0,0,0,0};
    Setup(5,1);Seed(2,8,201,5);assert(PhongThanEquipmentCompose(1,undo,recipes,costs,recipe)==PT_COMPOSE_RESTORE_OK && recipe==1101);
    assert(Item[1].GetID()==101 && Item[1].GetUpgradeState()==0 && Item[1].m_aryBaseAttrib[0].nValue[0]==100 && !Item[2].GetID());
    Setup(12,0);Seed(2,8,201,5);assert(PhongThanEquipmentCompose(1,undo,recipes,costs,recipe)==PT_COMPOSE_RESTORE_OK && Item[1].GetUpgradeState()==0);
    Setup(0,0);Seed(2,8,201,5);assert(PhongThanEquipmentCompose(1,undo,recipes,costs,recipe)==PT_COMPOSE_NO_RECIPE && Item[2].GetID());
    int refined[9]={1,2,3,4,0,0,0,0,0};Setup(1,1);Seed(4,8,191,2);
    assert(PhongThanEquipmentCompose(1,refined,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_MODE_MIX && Item[4].GetID());
    Setup(0,0);Seed(4,8,191,2);assert(PhongThanEquipmentCompose(1,refined,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_OK && recipe==201);
    assert(Item[1].m_aryRequireAttrib[0].nValue[0]==50 && Item[1].m_aryBaseAttrib[0].nValue[0]==110);
    // PAK recipes explicitly override the base rate: one stone gives 6 here,
    // not the different 10% description from a newer website version.
    Setup(3,1);Seed(4,8,187,2);forcedRoll=5;
    assert(PhongThanEquipmentCompose(1,refined,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_OK && recipe==401);
    Setup(3,1);Seed(4,8,187,2);forcedRoll=6;
    assert(PhongThanEquipmentCompose(1,refined,recipes,costs,recipe)==PT_COMPOSE_FAILED_LEVEL3 && Item[1].m_CommonAttrib.nUpgradeLvl==3);
    // Find an actual +10 recipe rather than inventing the catalyst identity.
    bool testedTen=false;
    for(int row=2;row<=recipes.GetHeight() && !testedTen;++row){PhongThanComposeRecipe r;
        if(!PhongThanReadComposeRecipe(recipes,row,r) || r.type!=1 || r.group!=1 || r.attributeId!=1 || r.requiredRecipe[0] ||
           r.inputs[0].detail!=0 || r.inputs[0].part!=0 || !(r.inputs[0].upgradeMask&(1u<<9)) || r.chance<=0 || r.chance>=100 || r.inputCount>9)continue;
        Setup(9,1);int slots[9]={0};
        for(int n=0;n<r.inputCount;++n){slots[n]=n+1;if(n==0)continue;Seed(n+1,r.inputs[n].genre,r.inputs[n].detail,r.inputs[n].part);
            Item[n+1].m_CommonAttrib.nStackNum=r.inputs[n].quantity;}
        forcedRoll=99;int result=PhongThanEquipmentCompose(1,slots,recipes,costs,recipe);
        if(result==PT_COMPOSE_NO_COST)continue;
        assert(result==PT_COMPOSE_FAILED_RESET && Item[1].GetUpgradeState()==0 && Item[1].m_aryBaseAttrib[0].nValue[0]==100);testedTen=true;
    }
    assert(testedTen);
    // Gold armor uses a distinct explicit rule; do not reuse weapon or set ID.
    Setup(0,0);Seed(1,0,2,15);Seed(2,0,4,1);Seed(3,3,41,0);
    Item[1].m_aryBaseAttrib[0].nAttribType=30;Item[1].m_aryBaseAttrib[0].nValue[0]=100;
    assert(PhongThanEquipmentCompose(1,input,recipes,costs,recipe)==PT_COMPOSE_UPGRADE_OK && recipe==9144);
    assert(Item[1].m_CommonAttrib.nUpgradeRule==3006 && Item[1].m_aryBaseAttrib[1].nAttribType==45 && Item[1].m_aryBaseAttrib[1].nValue[0]==20);
    Seed(2,8,201,5);assert(PhongThanEquipmentCompose(1,undo,recipes,costs,recipe)==PT_COMPOSE_RESTORE_OK && recipe==10502);
    assert(Item[1].GetID()==101 && Item[1].GetUpgradeState()==0 && Item[1].m_aryBaseAttrib[0].nValue[0]==100 && !Item[1].m_aryBaseAttrib[1].nAttribType);
    puts("PASS EQUIPMENT_COMPOSE actual_PAK actual_item_delta normal_refined_restore same_ID no_reroll fail_to3_destroy old_state guards money_room_payment_detach_rollback");
    g_pPakList=NULL;return 0;
}
